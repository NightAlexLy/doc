---
title: 
---
 
 **特别说明**
 
 　　1. 请先安装[jdk](/linux_software/jdk.html)环境
 　　2.  Zookeeper采用集群部署的方式
 　　3.  默认使用**root**用户安装，部署过程会添加zookeeper用户

 
a. 改变操作系统语言环境

```
　　[root@hostname ~]# echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n
　　[root@hostname ~]# source /etc/sysconfig/i18n
```

b. 添加zookeeper用户(注意设置密码)

```
　　[root@hostname ~]# useradd -u 704 zookeeper
　　[root@hostname ~]# echo "密码" | passwd --stdin zookeeper  
```

c. 下载安装包

```
　　[root@hostname ~]# cd /opt
　　[root@hostname ~]# wget http://ore2d9chp.bkt.clouddn.com/zookeeper-3.4.7.tar.gz
```

d. 安装Zookeeper

```
　　[root@hostname ~]# tar -zxf zookeeper-3.4.7.tar.gz -C /opt
　　[root@hostname ~]# chown -R zookeeper:zookeeper zookeeper-3.4.6
　　[root@hostname ~]# mv zookeeper-3.4.7 zookeeper
　　[root@hostname ~]# mkdir -p /opt/zookeeper/data
　　[root@hostname ~]# mkdir -p /opt/zookeeper/logs
　　[root@hostname ~]# chown -R zookeeper:zookeeper /opt/zookeeper/
　　[root@hostname ~]# cp -a /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
```

e. 添加配置（修改IP）

```
　　[root@hostname ~]# cd /opt/zookeeper/conf
　　在zoo.cfg文件中添加如下内容:
　　　　tickTime=2000
　　　　initLimit=10
　　　　syncLimit=5
　　　　dataDir=/opt/zookeeper/data
　　　　dataLogDir=/opt/zookeeper/logs
　　　　clientPort=2181
　　　　server.1=ip:4000:5000     #server 1 IP
　　　　server.2=ip:4000:5000     #server 2 IP
　　　　server.3=ip:4000:5000     #server 3 IP

```

f. 创建对应的 myid文件（依次在3台server中执行）

```
　　[root@hostname ~]# echo 1 > /opt/zookeeper/data/myid                          #server1 执行
　　[root@hostname ~]# chown -R zookeeper.zookeeper /opt/zookeeper/data/myid      #server1 执行

　　[root@hostname ~]# echo 2 > /opt/zookeeper/data/myid                          #server2 执行
　　[root@hostname ~]# chown -R zookeeper.zookeeper /opt/zookeeper/data/myid      #server2 执行

　　[root@hostname ~]# echo 3 > /opt/zookeeper/data/myid                          #server3 执行
　　[root@hostname ~]# chown -R zookeeper.zookeeper /opt/zookeeper/data/myid      #server3 执行

```

g. 启动zookeeper服务

```
　　[root@hostname ~]# su - zookeeper
　　[zookeeper@hostname ~]# cd /opt/zookeeper/bin
　　[zookeeper@hostname ~]# ./zkServer.sh start
```

h. 完成以后查看状态

```
　　[zookeeper@hostname ~]$ cd /opt/zookeeper/bin
 
　　查看端口所对应的服务信息
　　lsof -i:2181
　　　　COMMAND   PID      USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
　　　　java    10749 zookeeper   19u  IPv6  29172      0t0  TCP *:eforward (LISTEN)
 
　　./zkServer.sh status
　　　　JMX enabled by default
　　　　Using config: /opt/zookeeper/bin/../conf/zoo.cfg
　　　　Mode: followe

```





