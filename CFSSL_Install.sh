#!/bin/bash
#Instatlled CFSSL


echo -e "===== Download cfssl crt =====\n"
wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64

chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64 && ls -al |grep cfssl*
mv cfssl_linux-amd64 /usr/local/bin/cfssl
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
mv cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo

echo -e "===== Check Lists =====\n"
ls -al

ls -al /usr/local/bin/cfssl
ls -al /usr/local/bin/cfssljson
ls -al /usr/bin/cfssl-certinfo

