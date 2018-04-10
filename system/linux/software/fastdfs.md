---
title: FastDFS Install
---

### 依赖
```
wget https://github.com/happyfish100/libfastcommon/archive/V1.0.7.tar.gz
wget https://github.com/happyfish100/fastdfs/archive/V5.05.tar.gz
wget http://nginx.org/download/nginx-1.8.0.tar.gz
wget http://jaist.dl.sourceforge.net/project/fastdfs/FastDFS%20Nginx%20Module%20Source%20Code/fastdfs-nginx-module_v1.16.tar.gz
wget http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz
```

### Tracker安装
Tracker安装
准备工作
将tracker目录下安装介质拷贝至目标机器的opt目录下

关闭防火墙
```
[root]# chkconfig --level 2345 iptables off
[root]# chkconfig --list|grep iptables
[root]# service iptables stop
```
安装gcc gcc-c++ make automake autoconf libtool pcre* zlib openssl openssl-devel
```
[root]# yum install -y gcc gcc-c++ make automake autoconf libtool pcre* zlib openssl openssl-devel 
```
成功截图：
 
解压安装libfastcommon-master
```
[root]# cd /opt
[root]# unzip libfastcommon-master.zip
[root]# cd /opt/libfastcommon-master
[root]# ./make.sh
[root]# ./make.sh install
创建fastdfs_tracker目录，并解压FastDFS软件包
[root]# cd /opt
[root]# mkdir /opt/fastdfs_tracker
[root]# tar -xzf FastDFS_v5.05.tar.gz
[root]# cd /opt/FastDFS
[root]# ./make.sh
[root]# ./make.sh install
上述安装的路径在/usr/lib64/，但是FastDFS主程序设置的lib目录是/usr/local/lib，所以需要创建软连接如下:
[root]# ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so 
[root]# ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
[root]# ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
[root]# ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so
拷贝tracker.conf模板，并修改
[root]# cd /etc/fdfs
[root]# cp tracker.conf.sample tracker.conf
[root]# vi /etc/fdfs/tracker.conf
修改点：
	disabled=false
	port=22122
	base_path=/opt/fastdfs_tracker
	http.server_port=8088
安装Nginx
解压并且重命名nginx、fastdfs-nginx-module和ngx_cache_purge
[root]# cd /opt
[root]# tar -xf nginx-1.8.0.tar
[root]# mv nginx-1.8.0 nginx
[root]# tar -xf fastdfs-nginx-module_v1.16.tar.gz
[root]# tar -xf ngx_cache_purge-2.3.tar.gz
[root]# chown -R root:root *
修改fastdfs-nginx-module配置
[root]# vi /opt/fastdfs-nginx-module/src/config
将
	CORE_INCS="$CORE_INCS /usr/local/include/fastdfs /usr/local/include/fastcommon/"改为
	CORE_INCS="$CORE_INCS /usr/include/fastdfs /usr/include/fastcommon/"
编译安装nginx及其模块
[root]# mkdir /opt/local
[root]# cd /opt/nginx
[root]# ./configure  --prefix=/opt/local/nginx  --add-module=/opt/fastdfs-nginx-module/src  --add-module=/opt/ngx_cache_purge-2.3
[root]# make 
[root]# make install
[root]# mkdir -p /opt/cache/nginx/proxy_cache/tmp
[root]# vi /opt/local/nginx/conf/nginx.conf
	删除所有内容
	将文档同级Tracker目录下的nginx.conf内容粘贴进来
	并修改以下几点：
	upstream fdfs_group1 {
         	server IP:80 weight=1 max_fails=2 fail_timeout=30s;  #第一台Storage的IP地址
         	server IP:80 weight=1 max_fails=2 fail_timeout=30s;  #第二台Storage的IP地址
		server IP:80 weight=1 max_fails=2 fail_timeout=30s;  #第三台Storage的IP地址
    	}
	location ~/purge(/.*) {
            allow 127.0.0.1;
            allow 10.1.1.0/24;   #修改地址为同网段
            deny all;
            #proxy_cache_purge http-cache  $1$is_args$args;
        }  

[root]# cp /opt/FastDFS/conf/http.conf /etc/fdfs/
[root]# cp /opt/FastDFS/conf/mime.types /etc/fdfs/
[root]# cp /opt/fastdfs-nginx-module/src/mod_fastdfs.conf  /etc/fdfs
[root]# cp /opt/FastDFS/conf/anti-steal.jpg  /etc/fdfs/
修改mod_fastdfs.conf文件：
[root]# vi /etc/fdfs/mod_fastdfs.conf
修改点：
	base_path=/opt/fastdfs_tracker
	tracker_server=127.0.0.1:22122
	store_path0=/opt/fastdfs_tracker
[root]# vi /etc/fdfs/http.conf
修改参数如下：
	http.anti_steal.token_check_fail=/etc/fdfs/anti-steal.jpg
启动tracker、nginx
[root]# /usr/bin/fdfs_trackerd /etc/fdfs/tracker.conf  start
[root]# /opt/local/nginx/sbin/nginx
```

### Storage安装
准备工作
将storage目录下安装介质拷贝至目标机器的opt目录下
 关闭防火墙
```
[root]# chkconfig --level 2345 iptables off
[root]# chkconfig --list|grep iptables
[root]# service iptables stop
```
安装gcc gcc-c++ make automake autoconf libtool pcre* zlib openssl openssl-devel
```
[root]# yum install -y gcc gcc-c++ make automake autoconf libtool pcre* zlib openssl openssl-devel
```
成功截图：
 
解压安装libfastcommon-master
```
[root]# cd /opt
[root]# unzip libfastcommon-master.zip
[root]# cd /opt/libfastcommon-master
[root]# ./make.sh
[root]# ./make.sh install
创建fastdfs_storage目录，并解压FastDFS软件包
[root]# cd /opt
[root]# mkdir -p /opt/fastdfs_storage
[root]# tar -xzf FastDFS_v5.05.tar.gz
[root]# cd /opt/FastDFS
[root]# ./make.sh
[root]# ./make.sh install
上述安装的路径在/usr/lib64/，但是FastDFS主程序设置的lib目录是/usr/local/lib，所以需要创建软连接如下:
[root]# ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so 
[root]# ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
[root]# ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
[root]# ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so
拷贝storage.conf模板，并修改
[root]# cp /etc/fdfs/storage.conf.sample /etc/fdfs/storage.conf
[root]# vi /etc/fdfs/storage.conf
修改点：
	disabled=false
	group_name=group1
	port=23000
	base_path=/opt/fastdfs_storage
	store_path_count=1
	store_path0=/opt/fastdfs_storage
	tracker_server=10.1.1.143:22122
	#http.server_port=8888
安装Nginx
[root]# cd /opt
[root]# mkdir local
[root]# tar -xf nginx-1.8.0.tar
[root]# mv nginx-1.8.0 nginx
[root]# tar -xf fastdfs-nginx-module_v1.16.tar.gz
[root]# chown -R root:root *
修改fastdfs-nginx-module配置
[root]# vi /opt/fastdfs-nginx-module/src/config
将
	CORE_INCS="$CORE_INCS /usr/local/include/fastdfs /usr/local/include/fastcommon/"改为
	CORE_INCS="$CORE_INCS /usr/include/fastdfs /usr/include/fastcommon/"
安装Nginx:
[root]# cd /opt/nginx
[root]# ./configure  --prefix=/opt/local/nginx  --add-module=/opt/fastdfs-nginx-module/src
[root]# make
[root]# make install
[root]# vi /opt/local/nginx/conf/nginx.conf
修改点：
	server {
        listen       80;
        server_name  localhost;
        #charset koi8-r;
        #access_log  logs/host.access.log  main;
        location / {
            root   html;
            index  index.html index.htm;
        }
        location ~/group1/M00 {
            root /opt/fastdfs_storage/data;
            ngx_fastdfs_module;
        }
拷贝依赖文件：
[root]# cp /opt/FastDFS/conf/http.conf /etc/fdfs/
[root]# cp /opt/FastDFS/conf/mime.types /etc/fdfs/
[root]# cp /opt/fastdfs-nginx-module/src/mod_fastdfs.conf  /etc/fdfs
[root]# vi /etc/fdfs/mod_fastdfs.conf
修改点：
	base_path=/opt/fastdfs_storage
	tracker_server=10.1.1.143:22122
	storage_server_port=23000
	group_name=group1
	url_have_group_name = true
	store_path0=/opt/fastdfs_storage
	group_count = 1
	[group1]
	group_name=group1
	storage_server_port=23000
	store_path_count=2
	store_path0=/opt/fastdfs_storage
	store_path1=/opt/fastdfs_storage
	http.need_find_content_type=true
依赖修改：
[root]# cp /opt/FastDFS/conf/anti-steal.jpg  /etc/fdfs/
[root]# ls -trl /etc/fdfs/anti-steal.jpg
[root]# vi /etc/fdfs/http.conf
修改点：
	# default value is empty (no file sepecified)
	http.anti_steal.token_check_fail=/etc/fdfs/anti-steal.jpg

启动storage、nginx
[root]# /usr/bin/fdfs_storaged  /etc/fdfs/storage.conf start
[root]# /opt/local/nginx/sbin/nginx

验证是否安装完成
[root]# /usr/bin/fdfs_monitor /etc/fdfs/storage.conf
验证服务【此服务是在Tracker机器上实验】
[root]# cp /etc/fdfs/client.conf.sample  /etc/fdfs/client.conf
[root]# vi /etc/fdfs/client.conf
client.conf修改如下：
	base_path=/opt/fastdfs_tracker
	tracker_server=10.1.1.143:22122

[root]# cd /etc/fdfs/
[root]# /usr/bin/fdfs_upload_file  /etc/fdfs/client.conf ./anti-steal.jpg 
返回如下格式的地址：
group1/M00/00/00/i8QJQFYt752AHHBMAABdrZgsqUU539.jpg
浏览器访问地址
http://IP/上面返回的地址                 #IP为第一台Tracker的IP地址
http://IP/上面返回的地址                 #IP为第二台Tracker的IP地址
```

### 资料

- [FastDFS_v5.05安装配置](https://blog.csdn.net/hhq163/article/details/46536895)
- [Nginx+fastDFS-nginx-module+FastDFS配置分布式文件系统](https://blog.csdn.net/ystyaoshengting/article/details/48439003)
- [nginx安装第三方ngx_cache_purge模块，purge命令清除静态缓存](https://blog.csdn.net/lzxlfly/article/details/77885302)