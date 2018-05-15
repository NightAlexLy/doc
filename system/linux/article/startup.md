---
title: Linux Start up
---

### 方法一
    **编辑 /etc/rc.local文件  [vi /etc/rc.local]**               
```
　　# custom startup
    # 启动tomcat服务， 准备下面服务的方式，但是实践下来没有成功
　　cd /opt/package/tomcat-7.0.86/bin/ && ./startup.sh >> /tmp/tomcat.log 
　　# 启动Nginx服务
　　/usr/local/bin/nginx >/dev/null 2>&1 &
　　# 启动Docker服务
　　systemctl restart docker.service
　　# 启动Docker Redis服务
　　/usr/bin/docker run -p 6379:6379 -v $PWD/data:/data  -d redis:3.2 redis-server --appendonly yes
```

### 方法二
    服务的方式   /etc/rc.d/init.d
    创建对应的服务脚本文件  touch service
　　编写服务对应的脚本(如下示例Nginx)：           
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

　　添加服务        
　　`chkconfig add service`            

    设置启动               
    `chkconfig service on`      