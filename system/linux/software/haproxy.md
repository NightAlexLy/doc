---
title: Haproxy Install
---
 
### 安装

将haproxy-1.4.21.tar.gz拷贝至服务器的/opt目录下

[root@localhost ~]# cd /opt
[root@localhost ~]# wget http://ore2d9chp.bkt.clouddn.com/haproxy-1.4.21.tar.gz
[root@localhost opt]# tar -zxvf haproxy-1.4.21.tar.gz
[root@localhost opt]# cd haproxy-1.4.21
[root@localhost haproxy-1.4.21]# make TARGET=linux26 PREFIX=/usr/local/haproxy
[root@localhost haproxy-1.4.21]# makmake install PREFIX=/usr/local/haproxy
[root@localhost haproxy-1.4.21]# cp examples/haproxy.cfg /usr/local/haproxy/
[root@localhost haproxy-1.4.21]# cd /usr/local/haproxy/
[root@localhost haproxy]# vi haproxy.cfg

增加Haproxy  Manager:
	listen admin_stats
        bind 0.0.0.0:8888
        option httplog
        stats refresh 30s
        stats uri /stats
        stats realm Haproxy Manager
        stats auth admin:admin
        #stats hide-version

[root@localhost opt]# touch /etc/rc.d/init.d/haproxy
[root@localhost opt]# vi /etc/rc.d/init.d/haproxy

增加启动脚本：
```
#!/bin/bash  
BASE_DIR="/usr/local/haproxy"  
ARGV="$@"  
  
start()  
{  
echo "START HAPoxy SERVERS"  
$BASE_DIR/sbin/haproxy -f $BASE_DIR/haproxy.cfg  
}  
  
stop()  
{  
echo "STOP HAPoxy Listen"  
kill -TTOU `pidof haproxy`
echo "STOP HAPoxy process"  
kill -USR1 `pidof haproxy`
}  
case $ARGV in  
  
start)  
start  
ERROR=$?  
;;  
  
stop)  
stop  
ERROR=$?  
;;  
  
restart)  
stop  
start  
ERROR=$?  
;;  
  
*)  
echo "hactl.sh [start|restart|stop]"  
esac  
exit $ERROR  
```
启动成功：
[root@localhost haproxy]# service haproxy start   
START HAPoxy SERVERS

报错：
1. [root@localhost haproxy]# service haproxy start
START HAPoxy SERVERS
[WARNING] 150/045452 (48330) : parsing [/usr/local/haproxy/haproxy.cfg:21]: keyword 'redispatch' is deprecated, please use 'option redispatch' instead.
[ALERT] 150/045452 (48330) : parsing [/usr/local/haproxy/haproxy.cfg:88] : error opening file </etc/haproxy/errors/503.http> for custom error message <503>.
[ALERT] 150/045452 (48330) : Error(s) found in configuration file : /usr/local/haproxy/haproxy.cfg
[ALERT] 150/045452 (48330) : Fatal errors found in configuration.
[root@localhost haproxy]# vi /etc/rc.d/init.d/haproxy

解决办法：
	将/usr/local/haproxy/haproxy.cfg文件的21行和88行注释即可。

2. [root@localhost haproxy]# service haproxy start
START HAPoxy SERVERS
[ALERT] 150/045942 (48392) : [/usr/local/haproxy/sbin/haproxy.main()] Cannot chroot(/usr/share/haproxy).

解决办法:
	[root@localhost haproxy]# mkdir /usr/share/haproxy


访问：
	http://192.168.91.131:8888/stats

配置Redis的haproxy.cfg:
```
global
        log 127.0.0.1   local0        #日志输出配置，所有日志都记录在本机，通过local0输出
        maxconn 4096    #最大连接数
        chroot /usr/local/haproxy    #改变当前工作目录
        user haproxy    #所属运行的用户    
        group haproxy    #所属运行的用户组
        daemon        #以后台形式运行ha-proxy
        nbproc 4    #启动4个ha-proxy实例
        pidfile /usr/local/haproxy/log/haproxy.pid        #pid文件位置
 
defaults
        log     127.0.0.1       local3    #日志文件的输出定向
        mode    tcp        #{ tcp|http|health } 设定启动的实例的协议类型，此处要选择tcp，因为redis是基于tcp协议运行的
        option dontlognull        #保证HAProxy不记录上级负载均衡发送过来的用于检测状态没有数据的心跳包
        option redispatch        #当serverId对应的服务器挂掉后，强制定向到其他健康的服务器
        retries 2        #重试2次连接失败就认为服务器不可用，主要通过后面的check检查
        maxconn 2000    #最大连接数
        balance roundrobin        #负载均衡算法，roundrobin表示轮询，source表示按照IP
        contimeout      5000    #连接超时时间
        clitimeout      50000    #客户端连接超时时间
        srvtimeout      50000    #服务器端连接超时时间
 
listen proxy 192.168.1.168:6300
        server redis_192.168.1.168_6378 192.168.1.168:6378 check inter 2000 rise 2 fall 5    #你的均衡节点
        server redis_192.168.1.168_6379  192.168.1.168:6379 check inter 2000 rise 2 fall 5
```       