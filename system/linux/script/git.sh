########################
#  Intall Hexo-doc & init
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

# change folder
cd /opt

# check git install
if which git 2>/dev/null; then
  echo "git exists!"
else
  # install dependency
  yum install -y zlib-devel 
  yum install -y openssl-devel 
  yum install -y perl 
  yum install -y cpio 
  yum install -y expat-devel 
  yum install -y gettext-devel
  yum install -y autoconf 

  #Downlod git source 
  wget http://www.codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.xz 
  # xz
  xz -d git-latest.tar.xz
  # unzip 
  tar xvf git-latest.tar 
  # change folder
  cd git*
  # autoconf
  autoconf
  # set configure
  ./configure --with-curl=/usr/local 
  # make
  make
  # make install
  make install
  # init git config
  git config --global user.name "luis"
  git config --global user.email "night_ly@live.com"
  # test install
  git --version
fi