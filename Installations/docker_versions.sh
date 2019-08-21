#!/usr/bin/bash
#docker version check
#auth: neo_hsu
#version: 2.0

read -p "select version you wanna install for example, 18.03.0.ce: " version
if [[ ${version:1:1} =~ ":" ]] ; then
    version=${version:1}
    sudo yum install -y docker-ce-${version:1}
elif [[ ${version} =~ "el7" ]] ; then
    sudo yum install -y docker-ce-${version}
else
    echo "[ERROR]: Please choose one version!!"
fi
