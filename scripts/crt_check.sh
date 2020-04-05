#!/bin/bash

domains=`cat /root/groceries/scripts/lists.txt`

for line in $domains; do
echo "====================================================================================="

echo "当前检测的域名：" $line
end_time=$(echo | timeout 1.5 openssl s_client -servername $line -connect $line:443 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | awk -F '=' '{print $2}')
([ $? -ne 0 ] || [[ $end_time == '' ]])
    
end_times=`date -d "$end_time" +%s`
current_times=`date -d "$(date -u '+%b %d %T %Y GMT')"+%s`

left_time=$end_times-$current_times 
days=`expr $left_time / 86400`
echo "剩余天数:" $days
[ $days -lt 30 ] && echo "https 证书有效期少于30天，存在风险" 
    
done
