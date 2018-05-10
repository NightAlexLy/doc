  ########################
#  Intall NodeJS
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt

# check node install
if which node 2>/dev/null; then
  echo "node exists!"
else
  # install node dependency
  yum install -y gcc gcc-c++ make
  # Download node source tar gz
  wget https://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.gz
  # unzip
  tar -zxvf node-v6.11.0.tar.gz
  # change folder
  cd node-v6.11.0
  # set configure
  ./configure
  # make
  make
  # make install
  make install
  # copy command
  cp /usr/local/bin/node /usr/sbin/
  # test node command
  node --version
fi