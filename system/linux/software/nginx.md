---
title: Nginx Install
---

### 安装
 
```
yum install pcre* -y
yum install openssl* -y
yum install zlib -y
yum install zlib-devel -y
yum install wget -y 
cd /opt
wget http://nginx.org/download/nginx-1.13.0.tar.gz
cp nginx-1.13.0.tar.gz /usr/local
cd /usr/local
tar -zxvf nginx-1.13.0.tar.gz
mv nginx-1.13.0 nginx
./configure --prefix=/usr/local/nginx
make && make install 
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
#启动
nginx
#浏览器直接访问http://localhost/即可访问到Nginx的静态页面
	#因为Nginx默认占用80端口,所以必须以root用户启动

```

### 资料

- [linux环境下安装nginx教程](http://jingyan.baidu.com/album/1974b2898f5eadf4b1f774de.html?picindex=6)
- [linux下安装nginx](http://www.cnblogs.com/kunhu/p/3633002.html)
- [Installing nginx on CentOS 6.4](https://codybonney.com/installing-nginx-on-centos-6-4/)