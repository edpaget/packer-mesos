#!/bin/bash -e
#
# Setup the the box. This runs as root

apt-get -y update
apt-get -y install wget curl default-jre

wget -q -O /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod a+x /usr/local/bin/lein
      
# You can install anything you need here.

