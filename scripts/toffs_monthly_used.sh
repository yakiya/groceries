#!/bin/bash
#Project: Toffs Monthly used v1.2
#Author: Xavi

#===== 固定参数 ======
monthly=`date "+%Y-%m-%d %H:%M:%S"`
EMAIL=''
TOKEN=''
URL=https://api.toffstech.com/v1/
TTL_AMT=16000

> ./padamt.txt
> ./usdamt.txt
> ./final.txt

#===== GET_PAD_IDs =====

PAGE_TTL=`curl -sX GET ''{$URL}'pads/12?page=1&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'total_pages_count' | sed -E 's/"|:|,/ /g' | awk '{print $2}'`
PAGE_TTL1=`curl -sX GET ''{$URL}'pads/175?page=1&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'total_pages_count' | sed -E 's/"|:|,/ /g' | awk '{print $2}'`

<< amtused
PAGE_TTL=`curl -sX GET ''{$URL}'pads/12?page=1&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'total_pages_count' | sed -E 's/"|:|,/ /g' | awk '{print $2}' >> ./usdamt.txt`
PAGE_TTL1=`curl -sX GET ''{$URL}'pads/175?page=1&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'total_pages_count' | sed -E 's/"|:|,/ /g' | awk '{print $2}' >> ./usdamt.txt`
TTL_AMT=`cat usdamt.txt |  awk '{sum+=$1} END {print sum}'`
amtused

PAGE=1
while [ $PAGE -le $PAGE_TTL ]
#do echo > /dev/null 2>&1 ; curl -sX GET ''{$URL}'pads/12?page='${PAGE}'&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'pad_name'| sed -E 's/"|:|,/ /g' | awk '{print $2}'  >> ./test.txt ; let PAGE+=1 ; done
do echo > /dev/null 2>&1; curl -sX GET ''{$URL}'pads/12?page='${PAGE}'&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'customer_brand'| sed -E 's/"|:|,/ /g' | awk '{print $2}' >> ./padamt.txt  ; let PAGE+=1 ; done

PAGE1=1
while [ $PAGE1 -le $PAGE_TTL1 ]
#do echo > /dev/null 2>&1 ; curl -sX GET ''{$URL}'pads/175?page='${PAGE1}'&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'pad_name'| sed -E 's/"|:|,/ /g' | awk '{print $2}'  >> ./test.txt ; let PAGE1+=1 ; done
do echo > /dev/null 2>&1; curl -sX GET ''{$URL}'pads/175?page='${PAGE1}'&per_page=50' -H 'X-Auth-Email: '${EMAIL}'' -H 'X-Auth-Token: '${TOKEN}'' | jq . | grep 'customer_brand'| sed -E 's/"|:|,/ /g' | awk '{print $2}' >> ./padamt.txt  ; let PAGE1+=1 ; done


echo -e "============= 数据处理中 请稍后 =============="

A01_TTL=`grep -E "^A01|^a01" padamt.txt |wc -l`
A01_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A01_TTL'/'$TTL_AMT')*100}'`
A02_TTL=`grep -E "^A02|^a02" padamt.txt |wc -l`
A02_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A02_TTL'/'$TTL_AMT')*100}'`
A03_TTL=`grep -E "^A03|^a03" padamt.txt |wc -l`
A03_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A03_TTL'/'$TTL_AMT')*100}'`
A04_TTL=`grep -E "^A04|^a04" padamt.txt |wc -l`
A04_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A04_TTL'/'$TTL_AMT')*100}'`
A05_TTL=`grep -E "^A05|^a05" padamt.txt |wc -l`
A05_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A05_TTL'/'$TTL_AMT')*100}'`
A06_TTL=`grep -E "^A06|^a06" padamt.txt |wc -l`
A06_percent=`awk 'BEGIN{printf "%.1f%%\n",('$A06_TTL'/'$TTL_AMT')*100}'`
B01_TTL=`grep -E "^B01|^b01" padamt.txt |wc -l`
B01_percent=`awk 'BEGIN{printf "%.1f%%\n",('$B01_TTL'/'$TTL_AMT')*100}'`
C01_TTL=`grep -E "^C01|^c01" padamt.txt |wc -l`
C01_percent=`awk 'BEGIN{printf "%.1f%%\n",('$C01_TTL'/'$TTL_AMT')*100}'`
C02_TTL=`grep -E "^C02|^c02" padamt.txt |wc -l`
C02_percent=`awk 'BEGIN{printf "%.1f%%\n",('$C02_TTL'/'$TTL_AMT')*100}'`
C07_TTL=`grep -E "^C07|^c07" padamt.txt |wc -l`
C07_percent=`awk 'BEGIN{printf "%.1f%%\n",('$C07_TTL'/'$TTL_AMT')*100}'`
Public_TTL=`egrep -v  '^A0[1-6]|^a0[1-6]|^B0[1-7]|^b0[1-7]|^C0[1-7]|^c0[1-7]' padamt.txt |wc -l`
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
