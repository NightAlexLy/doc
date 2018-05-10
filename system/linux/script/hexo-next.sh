################################################
#  Intall Hexo install & init next Theme
#
#  user：root
#  path：/opt
#
################################################

#!/bin/sh

# check node install
if which node 2>/dev/null; then
  echo "node exists!"
else
  cd /opt
  # install node dependency
  yum install -y gcc gcc-c++ make
  # Download node source tar gz
  wget https://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.gz
  # unzip
  tar -zxvf node-v6.11.0.tar.gz
  # change folder
  cd node-v6.11.0
  # set configure
  ./configure
  # make
  make
  # make install
  make install
  # copy command
  cp /usr/local/bin/node /usr/sbin/
  # test node command
  node --version
  npm --version
fi

# check git install
if which git 2>/dev/null; then
  echo "git exists!"
else
  # change folder
  cd /opt
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
  # test install
  git --version
fi

# check hexo install
if which hexo 2>/dev/null; then
  echo "hexo exists!"
else
  # change folder
  cd /opt
  # install hexo
  npm install hexo-cli -g
  # test install
  hexo --version
fi

# check glup install
if which gulp 2>/dev/null; then
  echo "gulp exists!"
else
  # change folder
  cd /opt
  # install gulp
  npm install -d --save gulp gulp-clean gulp-load-plugins gulp-minify-css gulp-minify-html gulp-rename gulp-uglify gulp-shell typescript
  # test install
  gulp --version
fi

mkdir -p /opt/website
cd /opt/website

# init blog project
hexo init blog
# Download next theme source
