#!/bin/bash
#Title: Openresty Nginx
#Auth: Neo_hsu
#Version: 1.0

SRC=/srv/tools/
VERSIONS=`curl -s https://openresty.org/en/download.html | grep 'tar.gz"' | awk -F'"' '{print $2}'`

clear

echo "========== Versions =========="
echo -e "$VERSIONS"
echo "========== END =========="
echo ""
read -p "Choose one version you want to installed:" LATEST_RLS

if [[ $LATEST_RLS =~ ".tar.gz" ]] ; then
    wget -P $SRC $LATEST_RLS
else
    echo "[ERROR]: Please choose one version!!"
fi

