#!/bin/bash
#Description: Install necessary PKGs.
#Producer: Owner
#Version: 1.1 18.08.12


echo -e "===== Update Instal lists =====\n"
sleep 1
sudo yum update install  list
sudo yum upgrade install list
echo ""

echo -e "===== Install requires PKGs ====\n"
sleep 1
sudo yum install -y wget git vim lrzsz net-tools bind-utils


echo -e "========== Finished ==========\n"
