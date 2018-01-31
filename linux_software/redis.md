---
title: 
---
 
 **特别说明**
 
 　　1.  Redis的版本：**redis-3.0.3.tar.gz**
 　　2.  安装路径：**/usr/local/bin/redis**
 　　3.  安装用户：**root**，部署过程会添加redis用户
 
a. 编译和安装所需的包

```
　　[root@hostname ~]# yum -y install gcc tcl
```

b. 添加用户

```
　　[root@hostname ~]# useradd redis
　　[root@hostname ~]# echo "密码" | passwd --stdin redis
```

c. 安装

```
　　[root@hostname ~]# cd /opt
　　[root@hostname ~]# wget http://ore2d9chp.bkt.clouddn.com/redis-3.0.3.tar.gz
　　[root@hostname ~]# tar -zxf redis-3.0.3.tar.gz -C /usr/local/bin/
　　[root@hostname ~]# cd /usr/local/bin/
　　[root@hostname ~]# chown -R redis.redis redis-3.0.3/
　　[root@hostname ~]# mv redis-3.0.3 redis
　　[root@hostname ~]# cd /usr/local/bin/redis
　　[root@hostname ~]# make
　　[root@hostname ~]# cd src
　　[root@hostname ~]# make install
　　[root@hostname ~]# cd /usr/local/bin/
　　[root@hostname ~]# chown -R redis.redis redis*
```

d. 将解压包里的 redis.conf 拷贝到 /etc目录下并重命名

```
　　[root@hostname ~]# cp -a redis/redis.conf /etc/redis-master.conf
```

e. redis主配置文件配置

```
　　[root@hostname ~]# vi /etc/redis-master.conf
　　添加如下配置：
　　　　daemonize yes
　　　　pidfile /var/run/redis.pid
　　　　port 6379
　　　　timeout 300
　　　　loglevel debug
　　　　logfile stdout
　　　　databases 16
　　　　save 900 1
　　　　save 300 10
　　　　save 60 10000
　　　　rdbcompression yes
　　　　dbfilename dump.rdb
　　　　dir /usr/local/bin/redis
　　　　appendonly no
　　　　appendfsync always

```

f. redis主配置文件配置

```
　　[root@hostname ~]# vi /etc/redis-slave.conf
　　添加如下配置：
　　　　daemonize yes
　　　　pidfile /var/run/redis.pid
　　　　port 6379
　　　　timeout 300
　　　　loglevel debug
　　　　logfile stdout
　　　　databases 16
　　　　save 900 1
　　　　save 300 10
　　　　save 60 10000
　　　　rdbcompression yes
　　　　dbfilename dump.rdb
　　　　dir /usr/local/bin/redis
　　　　slaveof xxx.xxx.xxx.xxx 6379   # redis master ip port
　　　　appendonly no
　　　　appendfsync everysec
```

g. 启动操作

```
　　[root@hostname ~]# su - redis
　　[root@hostname ~]# cd /usr/local/bin
　　[root@hostname ~]# nohup /usr/local/bin/redis-server /etc/redis-master.conf >/dev/null 2>&1 &  #启动redis
　　[root@hostname ~]# /usr/local/bin/redis-cli -p 6379 shutdown  #关闭redis
```

h. 结果查看

```
　　[root@hostname ~]# ps -ef | grep redis
　　[root@hostname ~]# netstat -lntup | grep 6379
　　[root@hostname ~]# lsof -i :6379
```





