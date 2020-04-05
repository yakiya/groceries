#!/bin/bash

> ./cert_warn.txt

domains="cat /etc/xavi/A03/cert/spcl_domains.txt"
fkd_domains="cat /etc/xavi/A03/cert/fkd_domains.txt"

for domain in `$domains`
    do
      end_time=$(echo | timeout 2 openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | awk -F '=' '{print $2}' )
      ([ $? -ne 0 ] || [[ $end_time == '' ]]) &&  exit 10
               
      end_times=`date -d "$end_time" +%s `
      current_times=`date -d "$(date -u '+%b %d %T %Y GMT') " +%s `
                            
      let left_time=$end_times-$current_times
      days=`expr $left_time / 86400`

      [ $days -lt 30 ] && echo -e "===== $domain =====\n\n 剩余天数: $days 天; [WARN]: 证书有效期少于30天，存在风险！\n" >> ./cert_warn.txt || echo -e "\n==== $domain ====\n\n 剩余天数: $days 天" 
      echo ""
done

for fkd in `$fkd_domains`
    do
      end_time=$(echo | timeout 2 openssl s_client -servername $fkd -connect $fkd:443 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | awk -F '=' '{print $2}' )
      ([ $? -ne 0 ] || [[ $end_time == '' ]]) &&  exit 10
               
      end_times=`date -d "$end_time" +%s `
      current_times=`date -d "$(date -u '+%b %d %T %Y GMT') " +%s `
                            
      let left_time=$end_times-$current_times
      days=`expr $left_time / 86400`

      [ $days -lt 30 ] && echo -e "===== $fkd =====\n\n 剩余天数: $days 天; [WARN]: 证书有效期少于30天，存在风险！\n" >> ./fkd_warn.txt || echo -e "\n==== $fkd ====\n\n 剩余天数: $days 天" 
      echo ""
done
