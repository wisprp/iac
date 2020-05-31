#!/bin/bash

###
#  Instal docker+docker-compose and run sample wordpress app
#  Only sample, not production solution
### 

# update packages
apt-get update -yqq
apt-get install -yqq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
# add docker GPG key / repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# update and install docker engine
apt-get update -yqq
apt-get install -yqq docker-ce docker-ce-cli containerd.io
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# setup and run wordpress via docker-compose
cd /opt
curl https://codeload.github.com/visiblevc/wordpress-starter/tar.gz/master | tar -xz --strip 1 wordpress-starter-master/example
cd /opt/example
docker-compose up -d