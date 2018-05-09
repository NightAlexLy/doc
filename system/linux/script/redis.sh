########################
#  Intall Redis
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt

# install dependency
yum -y install gcc tcl

# create redis user
useradd redis
echo redisPwd | passwd --stdin redis

# Download redis source tar gz
wget http://ore2d9chp.bkt.clouddn.com/redis-3.0.3.tar.gz
# unzip
tar -zxf redis-3.0.3.tar.gz -C /usr/local/bin/
# change folder
cd /usr/local/bin/
# change chown
chown -R redis.redis redis-3.0.3/
# rename
mv redis-3.0.3 redis
# change folder
cd /usr/local/bin/redis
# make
make
# change folder
cd src
# install
make install
# change folder
cd /usr/local/bin/
# change chown
chown -R redis.redis redis*

# copy redis conf
touch /etc/redis-master.conf
touch /etc/redis-slave.conf

# chang chown 
chown -R redis.redis /etc/redis-master.conf
chown -R redis.redis /etc/redis-slave.conf

# write master config
echo "daemonize yes" >> /etc/redis-master.conf
echo "pidfile /var/run/redis.pid" >> /etc/redis-master.conf
echo "port 6379" >> /etc/redis-master.conf
echo "timeout 300" >> /etc/redis-master.conf
echo "loglevel debug" >> /etc/redis-master.conf
echo "logfile stdout" >> /etc/redis-master.conf
echo "save 900 1" >> /etc/redis-master.conf
echo "save 300 10" >> /etc/redis-master.conf
echo "save 60 10000" >> /etc/redis-master.conf
echo "dbfilename dump.rdb" >> /etc/redis-master.conf
echo "dir /usr/local/bin/redis" >> /etc/redis-master.conf
echo "appendonly no" >> /etc/redis-master.conf
echo "appendfsync always" >> /etc/redis-master.conf

# write slave config
echo "daemonize yes" >> /etc/redis-master.conf
echo "pidfile /var/run/redis.pid" >> /etc/redis-master.conf
echo "port 6379" >> /etc/redis-master.conf
echo "timeout 300" >> /etc/redis-master.conf
echo "loglevel debug" >> /etc/redis-master.conf
echo "logfile stdout" >> /etc/redis-master.conf
echo "save 900 1" >> /etc/redis-master.conf
echo "save 300 10" >> /etc/redis-master.conf
echo "save 60 10000" >> /etc/redis-master.conf
echo "dbfilename dump.rdb" >> /etc/redis-master.conf
echo "dir /usr/local/bin/redis" >> /etc/redis-master.conf
echo "appendonly no" >> /etc/redis-master.conf
echo "appendfsync always" >> /etc/redis-master.conf
# redis master ip port
echo "slaveof xxx.xxx.xxx.xxx 6379" >> /etc/redis-master.conf

# change user
su - redis
# change folder
cd /usr/local/bin
# start server
nohup /usr/local/bin/redis-server /etc/redis-master.conf >/dev/null 2>&1 &
# stop server
# /usr/local/bin/redis-cli -p 6379 shutdown  

# check server status
# ps -ef | grep redis
# netstat -lntup | grep 6379
# lsof -i :6379