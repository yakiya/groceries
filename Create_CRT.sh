#!/bin/bash

ETCD=ETCD_crts
K8s=K8s_crts
API=APIsvr_crts
Proxy=K8s-proxy_crts

mkdir -p ~/{$ETCD,$K8s,$API,$Proxy}

echo -e "\n===== Create ETCD CRT CA =====\n"
cp ./Kubernetes_Crts/ETCD_Crts/ca-config.json_tmp ~/$ETCD/ca-config.json
cp ./Kubernetes_Crts/ETCD_Crts/ca-csr.json_tmp ~/$ETCD/ca-csr.json &&
echo "done"

echo -e "\n===== Create ETCD Server CRT =====\n"
cp ./Kubernetes_Crts/ETCD_Crts/server-csr.json_tmp ~/$ETCD/server-csr.json &&
echo "done"

echo -e "\n===== Create Kubernetes CRT CA =====\n"
cp ./Kubernetes_Crts/K8s_crts/ca-config.json_tmp ~/$K8s/ca-config.json
cp ./Kubernetes_Crts/K8s_crts/ca-csr.json_tmp ~/$K8s/ca-csr.json &&
echo "done"

echo -e "\n===== Create API_Server CA =====\n"
cp ./groceries/Kubernetes_Crts/APIsvr_Crts/server-csr.json_temp ~/$API/server-csr.json &&
echo "done"

echo -e "\n===== Create Kubernetes_Proxy CA =====\n"
cp ./groceries/Kubernetes_Crts/K8s-proxy_crts/kube-proxy-csr.json_temp ~/$Proxy/kube-proxy-csr.json &&
echo "done"

