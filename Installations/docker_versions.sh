#!/usr/bin/bash


read -p "select version you wanna install for example, docker-ce-18.03.0.ce: " version
if [[ ${version} =~ "el7" ]] ; then
    sudo yum install -y docker-ce-${version} 
elif [ -z "${version}" ] ; then
    sudo yum install -y docker-ce
else
    echo "[ERROR]: You MUST have to choose one VERSION!!"
fi

 
