########################
#  Install Maven
#
#  user：root
#  path：/opt
#
########################

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

# Download maven source tar.gz
# https://maven.apache.org/download.cgi
wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
# unzip
tar -zxvf apache-maven-3.5.2-bin.tar.gz
# rename
mv apache-maven-3.5.2 maven
# set env config
echo "export M3_HOME=/opt/maven"  >> /etc/profile
echo "export PATH=${M3_HOME}/bin:${PATH}" >> /etc/profile
# source config
source /etc/profile

mvn -version
