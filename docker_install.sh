#!/usr/bin/bash
#Description: Docker install 
#Producer: Neo
#Version: 1.5 18.08.12

#Uninstall old versions
#Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them, along with associated dependencies.
echo "===== Uninstall old versions ====="
sleep 1
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
echo -e "===== Done =====\n"
#Install required packages. yum-utils provides the yum-config-manager utility, and device-mapper-persistent-data and lvm2 are required by the devicemapper storage driver.
echo -e "===== Install required PKGs =====\n"
sleep 1
sudo yum install -y yum-utils device-mapper-persistent-data  lvm2
echo -e "========== Done ===========\n"

#Use the following command to set up the stable repository. You always need the stablerepository, even if you want to install builds from the edge or test repositories as well.
echo -e "===== Set up Stable repo =====\n"
sleep 1
sudo yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo -e "========== Done ==========\n"

#Optional: Enable the edge and test repositories. These repositories are included in the docker.repo file above but are disabled by default. You can enable them with --enable flag and --disable flag to disable it.
#sudo yum-config-manager --enable docker-ce-edge
#sudo yum-config-manager --enable docker-ce-test
#echo ""

#Install the latest version of Docker CE, or go to the next step to install a specific version:
#sudo yum install docker-ce
#To install a specific version of Docker CE, list the available versions in the repo, then select and install:
echo -e "===== Install Docker CE =====\n"
sleep 1

yum list docker-ce --showduplicates | sort -r

sh ./docker_versions.sh

echo -e "========== Done ==========\n"
#Start Docker
echo -e "===== Start Docker =====\n"
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl stop firewalld
sudo systemctl disable firewalld

docker ps
 
echo -e "========== Finished ==========\n"
