#!/bin/bash
#Title: grey monthly used
#Auther: Xavi

#===== 固定参数 =====
greycdn_token[0]=''
greycdn_token[1]=''
url_api=https://api2.greypanel.com/api/v1
monthly=`date "+%Y-%m-%d %H:%M:%S"`

#===== File_Init =====
#touch amount.txt
#touch data.txt
#touch result.txt
#touch final.txt
> ./amount.txt
> ./data.txt
> ./result.txt
> ./final.txt

#===== Get_usedamount =====
clear

echo "=========== 已收到您的请求,请稍后 ============="

for api in ${greycdn_token[*]}; do curl -sX GET $url_api/account/view -H 'greycdn-token: '$api'' |jq ". | {tatalAmont:.result.packageInfo.domainBalance}" | grep -E 'used|total' | sed -E 's/"|:|,/ /g' | grep "usedAmount" | awk '{print $2}' >> amount.txt ; done

TTL_AMT=`cat amount.txt | awk '{sum+=$1} END {print sum}'`


#===== Get_domainCount =====

set -a uid1 uid2
index=0

for C in `curl -sX POST $url_api/site/list/all -H 'Content-Type: application/json' -H 'greycdn-token: '${greycdn_token[0]}'' | grep 'uid' | awk -F'"' '{print $4}'`; do uid1[index]=$C; let index+=1; echo > /dev/null 2>&1; curl -sX GET ''${url_api}'/site/view?uid='${C}'' -H 'greycdn-token: '${greycdn_token[0]}'' |  jq -c ". | {name:.result.name,domainCount:.result.domainCount}" | sed -E 's/(:|"|\{|\}|,)/ /g' | awk '{print $2,$4}' >> data.txt ; done


for C2 in `curl -sX POST $url_api/site/list/all -H 'Content-Type: application/json' -H 'greycdn-token: '${greycdn_token[1]}'' | grep 'uid' | awk -F'"' '{print $4}'` ; do uid2[index]=$C2; let index+=1; echo > /dev/null 2>&1; curl -sX GET ''${url_api}'/site/view?uid='${C2}'' -H 'greycdn-token: '${greycdn_token[1]}'' |  jq -c ". | {name:.result.name,domainCount:.result.domainCount}" | sed -E 's/(:|"|\{|\}|,)/ /g' | awk '{print $2,$4}' >> data.txt ; done

A01_TTL=`grep 'A01' data.txt | awk '{sum+=$2} END {print sum}'`
A01_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A01_TTL'/'$TTL_AMT')*100}'`
A02_TTL=`grep 'A02' data.txt | awk '{sum+=$2} END {print sum}'`
A02_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A02_TTL'/'$TTL_AMT')*100}'`
A03_TTL=`grep 'A03' data.txt | awk '{sum+=$2} END {print sum}'`
A03_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A03_TTL'/'$TTL_AMT')*100}'`
A04_TTL=`grep 'A04' data.txt | awk '{sum+=$2} END {print sum}'`
A04_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A04_TTL'/'$TTL_AMT')*100}'`
A05_TTL=`grep 'A05' data.txt | awk '{sum+=$2} END {print sum}'`
A05_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A05_TTL'/'$TTL_AMT')*100}'`
A06_TTL=`grep 'A06' data.txt | awk '{sum+=$2} END {print sum}'`
A06_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A06_TTL'/'$TTL_AMT')*100}'`
B01_TTL=`grep 'B01' data.txt | awk '{sum+=$2} END {print sum}'`
B01_percent=`awk 'BEGIN{printf "%.1f%%\n",('$B01_TTL'/'$TTL_AMT')*100}'`
C01_TTL=`grep 'C01' data.txt | awk '{sum+=$2} END {print sum}'`
C01_percent=`awk 'BEGIN{printf "%.1f%%\n",('$C01_TTL'/'$TTL_AMT')*100}'`
C02_TTL=`grep 'C02' data.txt | awk '{sum+=$2} END {print sum}'`
C02_percent=`awk 'BEGIN{printf "%.1f%%\n",('$C02_TTL'/'$TTL_AMT')*100}'`
C07_TTL=`grep 'C07' data.txt | awk '{sum+=$2} END {print sum}'`
C07_percent=`awk 'BEGIN{printf "%.1f%%\n",('$C07_TTL'/'$TTL_AMT')*100}'`
Public_TTL=`egrep -v  '^A0[1-6]|^B0[1-7]|^C0[1-7]' data.txt | awk '{sum+=$2} END {print sum}'`
Public_percent=`awk 'BEGIN{printf "%.1f%%\n",('$Public_TTL'/'$TTL_AMT')*100}'`


#===== Data_Processing =====

echo "=========== 非常感谢您的使用,谢谢 ============="
echo ""

echo Name DomainCount Percent > ./result.txt 
echo A01 $A01_TTL $A01_percent >> ./result.txt
echo A02 $A02_TTL $A02_percent >> ./result.txt
echo A03 $A03_TTL $A03_percent >> ./result.txt
echo A04 $A04_TTL $A04_percent >> ./result.txt
echo A05 $A05_TTL $A05_percent >> ./result.txt
echo A06 $A06_TTL $A06_percent >> ./result.txt
echo B01 $B01_TTL $B01_percent >> ./result.txt
echo C01 $C01_TTL $C01_percent >> ./result.txt
echo C02 $C02_TTL $C02_percent >> ./result.txt
echo C07 $C07_TTL $C07_percent >> ./result.txt
echo Public $Public_TTL $Public_percent >> ./result.txt

#===== 排版 =====
file=./result.txt

while read line
do
    printf "%10s%15s%15s\n" ${line} 

done < ${file} >> ./final.txt

#===== Output_Results =====

echo -e "============= $monthly ==============" 
echo ""
cat ./final.txt
echo ""
echo -e "=============== 本月使用额度清单 ===============" 

