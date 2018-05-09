########################
#  Install Jenkins
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

# check maven install
if which mvn 2>/dev/null; then
  echo "mvn exists!"
else
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
fi

# Download jenkins source tar.gz
# http://pkg.jenkins-ci.org/redhat/
wget http://pkg.jenkins-ci.org/redhat/jenkins-2.120-1.1.noarch.rpm
# import jenkins key 
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins.io.key
# install jenkins 
sudo yum -y install jenkins-*.noarch.rpm

# change jenkins config
sed -i 's/JENKINS_JAVA_CMD=["/a-zA-Z0-9._]*/JENKINS_JAVA_CMD=\"\/opt\/jdk\/bin\/java\"/' /etc/sysconfig/jenkins

# start jenkins server
#sudo systemctl start jenkins.service  #启动
#sudo systemctl stop jenkins.service  #停止
sudo systemctl restart jenkins.service  #重启

# query jenkins server status
sudo systemctl status jenkins.service