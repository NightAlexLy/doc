########################
#  Install JDK
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt
# download jdk source tar.gz 
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
wget http://ore2d9chp.bkt.clouddn.com/jdk-7u79-linux-x64.tar.gz
# unzip
tar -zxvf jdk-7u79-linux-x64.tar.gz -C /opt
# rename
mv jdk1.7.0_79 jdk
# change Jurisdiction
chown -R root:root /opt/jdk
# set config
echo 'export JAVA_HOME=/opt/jdk' >>  /etc/profile
echo 'export CLASSPATH=$JAVA_HOME/lib' >>  /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' >>  /etc/profile
# Take effect config
source /etc/profile
# Test
java -version