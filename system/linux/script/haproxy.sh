########################
#  Intall HaProxy
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cp /opt

# Download haproxy source tar.gz
# http://www.rpmfind.net/linux/rpm2html/search.php?query=haproxy
wget http://www.rpmfind.net/linux/centos/7.4.1708/os/x86_64/Packages/haproxy-1.5.18-6.el7.x86_64.rpm
#wget http://ore2d9chp.bkt.clouddn.com/haproxy-1.4.21.tar.gz

# install haproxy
rpm -ivh haproxy-1.5.18-6.el7.x86_64.rpm

# haproxy command
haproxy