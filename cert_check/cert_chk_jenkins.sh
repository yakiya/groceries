#!/bin/bash
#Title: Special domain SSL check for Jenkins v2.0
#Author: Xavi

#===Initial====
work_path="/root/groceries/cert_check"

> $work_path/cert_warn.txt

sed -i "s/ /\n/g" $work_path/spcl_domains.txt
domains=`cat $work_path/spcl_domains.txt`

#====SSL Check====

for domain in `$domains`
    do
      end_time=$(echo | timeout 3 openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | awk -F '=' '{print $2}' )
      ([ $? -ne 0 ] || [[ $end_time == '' ]]) &&  exit 10
               
      end_times=`date -d "$end_time" +%s `
      current_times=`date -d "$(date -u '+%b %d %T %Y GMT') " +%s `
                            
      let left_time=$end_times-$current_times
      days=`expr $left_time / 86400`

      [ $days -lt 30 ] && echo -e "===== $domain =====\n\n 剩余天数: $days 天; [WARN]: 证书有效期少于30天，存在风险！\n" >> $work_path/cert_warn.txt || echo -e "\n==== $domain ====\n\n 剩余天数: $days 天" 
      echo ""
done

#====send mail====
#$work_path/mail.py
