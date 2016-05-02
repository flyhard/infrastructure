#!/usr/bin/env bash

set -x

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-wheezy main" | sudo tee -a /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y puppet curl docker-engine

sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

sudo mkdir -p /etc/facter/facts.d /etc/puppet
sudo mv /tmp/modules /etc/puppet/
sudo mv /tmp/bin/* /usr/local/bin

sudo mv /tmp/compose /opt

echo "sumo_id: '$1'" | sudo tee -a /etc/facter/facts.d/config.yaml
echo "sumo_key: '$2'" | sudo tee -a /etc/facter/facts.d/config.yaml
sudo puppet apply --logdest syslog /tmp/puppet/dockerServer.pp

sudo curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd /opt/compose
sudo docker-compose up -d consul-boot
sleep 5
sudo docker-compose up -d consul
sleep 5
sudo docker-compose up -d postgrey mail
