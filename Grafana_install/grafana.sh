#!/bin/bash
#Introduc
#
#Version:5.2.2



#Install grafana

mkdir -p /root/src && cd /root/src
wget -O grafana-5.2.2.64.tar.gz https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.2.linux-amd64.tar.gz &&
tar zxvf grafana-5.2.2.64.tar.gz
mv grafana-5.2.2 /opt/
cd /opt/ && ln -s grafana-5.2.2 grafana && chown -R tomcat.tomcat grafana-5.2.2/ grafana
