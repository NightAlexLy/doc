########################
#  Download Apache Tomcat8.X
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt

# check java install
if which java 2>/dev/null; then
  echo "java exists!"
else
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
fi

# download tomcat source tar.gz 
# https://tomcat.apache.org/
wget  http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz
# unzip
tar -zxvf apache-tomcat-8.5.31.tar.gz -C /opt
# rename
mv apache-tomcat-8.5.31 apache-tomcat