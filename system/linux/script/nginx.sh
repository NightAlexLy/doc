########################
#  Install Nginx
#
#  user：root
#  path：/opt
#
########################

cd /opt

# install dependency
yum install pcre* -y
yum install openssl* -y
yum install zlib -y
yum install zlib-devel -y
yum install wget -y 

# Download nginx source tar gz
wget http://nginx.org/download/nginx-1.13.0.tar.gz
# copy
cp nginx-1.13.0.tar.gz /usr/local
# change folder
cd /usr/local
# unzip
tar -zxvf nginx-1.13.0.tar.gz
# rename
mv nginx-1.13.0 nginx
# set configure
./configure --prefix=/usr/local/nginx
# install
make && make install 
# create link
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
# start service
nginx
# 浏览器直接访问http://localhost/即可访问到Nginx的静态页面
# 因为Nginx默认占用80端口,所以必须以root用户启动
