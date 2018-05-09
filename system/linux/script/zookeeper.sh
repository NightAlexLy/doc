########################
#  Install Zookeeper
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt

# set languanger
echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n
# source languanger
source /etc/sysconfig/i18n

# create zookeeper user
useradd -u 704 zookeeper
echo "zookeeperPwd" | passwd --stdin zookeeper 

# Download zookeeper source tar gz
# https://archive.apache.org/dist/zookeeper/
wget http://ore2d9chp.bkt.clouddn.com/zookeeper-3.4.7.tar.gz

# unzip
tar -zxf zookeeper-3.4.7.tar.gz -C /opt
# change chown
chown -R zookeeper:zookeeper zookeeper-3.4.6
# rename
mv zookeeper-3.4.7 zookeeper
# create zookeeper data folder
mkdir -p /opt/zookeeper/data
# create zookeeper logs folder
mkdir -p /opt/zookeeper/logs
# change chown
chown -R zookeeper:zookeeper /opt/zookeeper/
# copy zookeeper config
cp -a /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
# change folder
cd /opt/zookeeper/conf

# set zookeeper config
echo "tickTime=2000" >> zoo.cfg
echo "initLimit=10" >> zoo.cfg
echo "syncLimit=5" >> zoo.cfg
echo "dataDir=/opt/zookeeper/data" >> zoo.cfg
echo "dataLogDir=/opt/zookeeper/logs" >> zoo.cfg
echo "clientPort=2181" >> zoo.cfg

# change zookeeper user
su - zookeeper
# change folder
cd /opt/zookeeper/bin
# start zookeeper server
./zkServer.sh start

# change folder
# cd /opt/zookeeper/bin
# check zookeeper status
# lsof -i:2181
# check zookeeper status
# ./zkServer.sh status