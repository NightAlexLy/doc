  ########################
#  Instanll RabbitMq
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt

# Download erlang source rpm
wget http://www.rabbitmq.com/releases/erlang/erlang-19.0.4-1.el7.centos.x86_64.rpm
# Download rabbitmq source rpm
wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.4/rabbitmq-server-3.7.4-1.el7.noarch.rpm

# install dependency
yum install socat.x86_64  -y
# intall erlang
rpm -ivh erlang-19.0.4-1.el7.centos.x86_64.rpm
# install rabbitmq
rpm -ivh rabbitmq-server-3.7.4-1.el7.noarch.rpm