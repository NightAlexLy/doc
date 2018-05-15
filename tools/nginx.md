---
title: Nginx
---

## 常用命令
```
动态重启： nginx -s relod
检查配置   nginx -t
```

## 直接下载
```
	location按照如下配置：

	location ~ ^/downlod/(.*)$ {
		add_header Content-Disposition "attachment; filename=$1";  
	}
```

## 文件服务器
```
    location下增加如下配置：

    autoindex on;# 显示目录
    autoindex_exact_size on;# 显示文件大小
    autoindex_localtime on;# 显示文件时间

```

## 413 Request Entity Too Large
```
Nginx出现的413 Request Entity Too Large错误,这个错误一般在上传文件的时候出现，打开nginx主配置文件nginx conf，找到http{}段，添加解决方法就是打开nginx主配置文件nginx conf，一般在 usr local ngin

设置上传文件大小
client_max_body_size 2m;

重启
sudo /etc/init.d/nginxd reload

重启Nginx
kill -HUP `cat /usr/local/nginx/logs/nginx.pid `
```

## 负载均衡策略
```
1、轮询（默认）
每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器down掉，能自动剔除。 
upstream backserver { 
	server 192.168.0.14; 
	server 192.168.0.15; 
} 

2、指定权重
指定轮询几率，weight和访问比率成正比，用于后端服务器性能不均的情况。 
upstream backserver { 
	server 192.168.0.14 weight=10; 
	server 192.168.0.15 weight=10; 
} 

3、IP绑定 ip_hash
每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session的问题。 
upstream backserver { 
	ip_hash; 
	server 192.168.0.14:88; 
	server 192.168.0.15:80; 
} 

4、fair（第三方）
按后端服务器的响应时间来分配请求，响应时间短的优先分配。 
upstream backserver { 
	server server1; 
	server server2; 
	fair; 
} 

5、url_hash（第三方）
按访问url的hash结果来分配请求，使每个url定向到同一个后端服务器，后端服务器为缓存时比较有效。 
upstream backserver { 
	server squid1:3128; 
	server squid2:3128; 
	hash $request_uri; 
	hash_method crc32; 
} 

在需要使用负载均衡的server中增加 

proxy_pass http://backserver/; 
upstream backserver{ 
	ip_hash; 
	server 127.0.0.1:9090 down; (down 表示单前的server暂时不参与负载) 
	server 127.0.0.1:8080 weight=2; (weight 默认为1.weight越大，负载的权重就越大) 
	server 127.0.0.1:6060; 
	server 127.0.0.1:7070 backup; (其它所有的非backup机器down或者忙的时候，请求backup机器) 
} 

max_fails ：允许请求失败的次数默认为1.当超过最大次数时，返回proxy_next_upstream 模块定义的错误 

fail_timeout:max_fails次失败后，暂停的时间
```

## Nginx启动脚本
有的Linux安装不是服务的方式，如果想将Nginx变成服务的方式。 新建脚本，添加如下内容。并将脚本移至/etc/rc.d/init.d下。
cd /etc/rc.d/init.d/
chkconfig --add nginx.sh
chkconfig nginx on  --- 开机启动
```
#!/bin/sh
# chkconfig : 345 86 14
# description:
NGINX_DIR=/usr/local/nginx
export NGINX_DIR
case $1 in
     'start')
        echo "start nginx...."
        $NGINX_DIR/sbin/nginx
        ;;
     'reload')
        echo "Reload nginx configuration...."
        kill -HUP `cat $NGINX_DIR/logs/nginx.pid`
        ;;
     'stop')
        echo "stopping nginx...."
        kill -15 `cat $NGINX_DIR/logs/nginx.pid`
        ;;
     'list')
        ps aux | egrep '(PID|nginx)'
        ;;
     'testconfig')
        $NGINX_DIR/sbin/nginx -t
        ;;
     'version')
        $NGINX_DIR/sbin/nginx -v
        ;;
     'tailLog')
        tail -f $NGINX_DIR/logs/error.log
        ;;
     'catLog')
        cat $NGINX_DIR/logs/error.log
        ;;
     *)
echo "usage: `basename $0` {start | reload | stop | list | testconfig | version | tailLog | catLog}"
esac
```

## 配置模板
```
user  nobody;
worker_processes  1;
error_log  logs/error.log  info;
pid             logs/nginx.pid;
events {
  worker_connections  65535;
  use epoll;
}
http {
  include          mime.types;
  default_type  application/octet-stream;
  sendfile              on;
  tcp_nopush     on;
  keepalive_timeout  65;
  server_names_hash_bucket_size 128;
  client_header_buffer_size 32k;
  large_client_header_buffers 4 32k;
  client_max_body_size 300m;
  proxy_redirect off;
  proxy_set_header Host $http_host;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_connect_timeout 90;
  proxy_send_timeout 90;
  proxy_read_timeout 90;
  proxy_buffer_size 16k;
  proxy_buffers 4 64k;
  proxy_busy_buffers_size 128k;
  proxy_temp_file_write_size 128k;
  #设置缓存存储路径、存储方式、分配内存大小、磁盘最大空间、缓存期限
  proxy_cache_path  /var/cache/nginx/proxy_cache  levels=1:2
  keys_zone=http-cache:500m max_size=10g inactive=30d;
  proxy_temp_path /var/cache/nginx/proxy_cache/tmp;
  #设置 group1 的服务器
  upstream fdfs_group1 {
    server 192.168.26.128:8080 weight=1 max_fails=2 fail_timeout=30s;
    server 192.168.26.130:8080 weight=1 max_fails=2 fail_timeout=30s;
  }
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
            '$status $body_bytes_sent "$http_referer" '
            '"$http_user_agent" "$http_x_forwarded_for"';
  server {
    listen          80;
    server_name  localhost;
    access_log  logs/host.access.log  main;
  #设置 group1 的反向代理参数
  location /group1/M00 {
    proxy_next_upstream http_502 http_504 error timeout invalid_header;
    proxy_cache http-cache;
    proxy_cache_valid 200 304 12h;
    proxy_cache_key $uri$is_args$args;
    proxy_pass http://fdfs_group1;
    expires 30d;
  }
  #设置清除缓存的访问权限
    location ~ /purge(/.*) {
    allow 127.0.0.1;
    allow 10.10.10.0/24;
    deny all;
    proxy_cache_purge http-cache $1$is_args$args;
  }
  }
}
```

## Nginx日志分析
```
系统日志：
/var/log/message //系统主日志文件
/var/log/secure //认证、安全
/var/log/dmesg //和系统启动相关

应用日志：
access.log //nginx访问日志
mysqld.log //mysql运行日志
xferlog //和访问FTP服务相关

程序脚本：
开发语言：C、C++、Java、PHP
框架：Django、MVC、Servlet
脚本语言：Shell、Python

HTTP状态码介绍
1** 信息，服务器收到请求，需要请求者继续执行操作
2** 成功，操作被成功接收并处理
3** 重定向，需要进一步的操作已完成请求
4** 客户端错误，请求包含语法错误或者无法完成请求
5** 服务器错误，服务器在处理请求的过程中发生了错误

脚本实现功能介绍（Nginx）：

功能一：分析HTTP状态码在100-200、200-300、300-400、400-500、500以上，五个区间的请求条数
功能二：分析日志中HTTP状态为404、500的请求条数

功能三：找出访问最多的IP
cat /opt/logs/nginx/access.log | awk '${print $1}' | sort | uniq -c | sort -rn | more

获得状态码
cat /opt/local/nginx/logs/access.log | awk '{print $9}'
cat /opt/local/nginx/logs/access.log | grep -ioE "HTTP\/1\.[1|0]\"[[:blank:]][0-9]{3}"
```

## 统计脚本
```
#!/bin/sh

#Program function:Nginx's log analysis
resettem=$(tput sgr0)
Logfile_path='/opt/local/nginx/logs/access.log'
Check_http_status()
{
Http_statu_codes=(`cat $Logfile_path|grep -ioE "HTTP\/1\.[1|0]\"[[:blank:]][0-9]{3}"|awk -F "[ ]+" '{
if($2>=100&&$2<200){i++}
else if($2>=200&&$2<300){j++}
else if($2>=300&&$2<400){k++}
else if($2>=400&&$2<500){l++}
else if($2>=500){m++}
}END{
print i?i:0,j?j:0,k?k:0,l?l:0,m?m:0,i+j+k+l+m
}'`)


echo -e '\E[33m' "The number of http status[100+]:" ${resettem} ${Http_statu_codes[0]}
echo -e '\E[33m' "The number of http status[200+]:" ${resettem} ${Http_statu_codes[1]}
echo -e '\E[33m' "The number of http status[300+]:" ${resettem} ${Http_statu_codes[2]}
echo -e '\E[33m' "The number of http status[400+]:" ${resettem} ${Http_statu_codes[3]}
echo -e '\E[33m' "The number of http status[500+]:" ${resettem} ${Http_statu_codes[4]}
echo -e '\E[33m' "All request number:" ${resettem} ${Http_statu_codes[5]}

}

Check_http_code()
{
Http_Code=(`cat $Logfile_path|grep -ioE "HTTP\/1\.[1|0]\"[[:blank:]][0-9]{3}"|awk -v total=0 -F '[ ]+' '{
if($2!=""){code[$2]++;total++}
else{exit}
}END{
print code[404]?code[404]:0,code[403]?code[403]:0,code[500]?code[500]:0,total
}'`)

echo -e '\E[33m' "The number of http status[404]:" ${resettem} ${Http_Code[0]}
echo -e '\E[33m' "The number of http status[403]:" ${resettem} ${Http_Code[1]}
echo -e '\E[33m' "The number of http status[500]:" ${resettem} ${Http_Code[2]}
echo -e '\E[33m' "All request number:" ${resettem} ${Http_Code[3]}

}


Check_http_status
Check_http_code
```

## 资料
- [淘宝的Engine](http://tengine.taobao.org/)
- [Nginx开发从入门到精通](http://tengine.taobao.org/book/chapter_02.html)
- [Nginx翻译网站](http://tengine.taobao.org/nginx_docs/cn/)
- [Nginx安装配置与服务搭建](http://os.51cto.com/art/201111/304611.htm)
- [windows下安装以及配置nginx](https://blog.csdn.net/xqhys/article/details/68485186)
- [Nginx 反向代理、负载均衡、页面缓存、URL重写及读写分离详解](https://www.cnblogs.com/cuihongyu3503319/p/5846015.html)
- [nginx负载均衡的5种策略（转载）](https://www.cnblogs.com/andashu/p/6377323.html)
- [Nginx安装及配置详解](https://www.cnblogs.com/zhouxinfei/p/7862285.html)
