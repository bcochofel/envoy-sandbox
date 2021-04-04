#!/bin/bash

sudo DEBIAN_FRONTEND=noninteractive apt-get update -y -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq curl vim tree \
    net-tools telnet git python3 python3-pip python3-dev wget jq unzip mc \
    sshpass netcat openssl
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq redis-server
sudo systemctl enable redis-server

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# clone repository
git clone https://github.com/envoyproxy/envoy.git

exit 0
