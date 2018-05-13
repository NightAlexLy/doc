########################
#  install Keepalived
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

# check java install
if which keepalived 2>/dev/null; then
  echo "keepalived exists!"
else

  cd /opt 

  # install dependency
  yum install openssl*  -y
  yum install popt*  -y
  yum install ipvsadm -y
  yum install libnl-dev* -y

  # Download keepalived source tar
  wget http://www.keepalived.org/software/keepalived-1.2.16.tar.gz

  # unzip 
  tar –zxvf  keepalived-1.2.16.tar.gz

  # set configure
  ./configure --prefix=/usr/local/keepalived

  # make && make install
  make && make install

  # copy keepalived command 
  cp /usr/local/keepalived/sbin/keepalived /usr/sbin/

  # copy keepalived service
  cp /usr/local/keepalived/etc/rc.d/init.d/keepalived /etc/init.d/

  # copy keepalived service sysconfig
  cp /usr/local/keepalived/etc/sysconfig/keepalived /etc/sysconfig/

  # copy keepavlied config
  cp /usr/local/keepalived/etc/keepalived/keepalived.conf /etc/keepalived/

  # startup
  chkconfig keepalived on
fi

