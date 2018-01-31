---
title: 
---
 
 **特别说明**
 
 　　1.  请先安装[jdk](/linux_software/jdk.html)环境和[Zookeeper](/linux_software/zookeeper.html)
 　　2.  Metaq的版本：**metaq-server-1.4.6.2.tar.gz**
 　　3.  安装路径：**/opt/taobao/metamorphosis-server-wrapper/**
 　　4.  安装用户：**root**，部署过程会添加metaq用户
 
a. 添加metaq用户

```
　　[root@hostname ~]# useradd metaq
　　[root@hostname ~]# echo "密码" | passwd --stdin metaq
```

b. 下载安装包并解压

```
　　[root@hostname ~]# cd /opt
　　[root@hostname ~]# wget http://ore2d9chp.bkt.clouddn.com/metaq-server-1.4.6.2.tar.gz
　　[root@hostname ~]# tar -zxf metaq-server-1.4.6.2.tar.gz -C /opt
　　[root@hostname ~]# chown -R metaq.metaq /opt/taobao

```

c. 修改服务器上的hosts 文件（集群模式）

```
　　[root@hostname ~]# vi /etc/hosts

　　　　#127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
　　　　#::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
　　　　xxx.xxx.xxx.xxx                      metaq_trans         #metaq server1 ip hostname
　　　　xxx.xxx.xxx.xxx                      metaq_trans2        #metaq server2 ip hostname
　　　　xxx.xxx.xxx.xxx                      metaq_trans3        #metaq server3 ip hostname

```

d. 对配置文件做一个备份

```
　　[root@hostname ~]# cp -a /opt/taobao/metamorphosis-server-wrapper/conf/server.ini  /opt/taobao/metamorphosis-server-wrapper/conf/server.ini.ori
```

e. 修改配置文件

```
　　[root@hostname ~]# vi /opt/taobao/metamorphosis-server-wrapper/conf/server.ini
　　配置如下：
　　　　[system]
　　　　brokerId=4
　　　　numPartitions=1
　　　　serverPort=9133
　　　　dashboardHttpPort=9120
　　　　unflushThreshold=0
　　　　unflushInterval=10000
　　　　maxSegmentSize=1073741824
　　　　maxTransferSize=1048576
　　　　deletePolicy=delete,168
　　　　deleteWhen=0 0 6,18 * * ?
　　　　flushTxLogAtCommit=1
　　　　stat=true
　　　　 
　　　　;; Update consumers offsets to current max offsets when consumers offsets are out of range of current broker's messages.
　　　　;; It must be false in production.But recommend to be true in development or test.
　　　　updateConsumerOffsets=true
　　　　 
　　　　[zookeeper]
　　　　zk.zkConnect=xxx.xxx.xxx:2181,xxx.xxx.xxx:2181,xxx.xxx.xxx:2181   #zookeeper集群地址
　　　　zk.zkSessionTimeoutMs=30000
　　　　zk.zkConnectionTimeoutMs=30000
　　　　zk.zkSyncTimeMs=5000
　　　　 
　　　　;; Topics section
　　　　[topic=test]
　　　　[topic=meta-test]
　　　　[topic=*]

```

f. 启动Metaq

```
　　[root@hostname ~]# su - metaq
　　[root@hostname ~]# /opt/taobao/metamorphosis-server-wrapper/bin/metaServer.sh start  #启动
　　[root@hostname ~]# /opt/taobao/metamorphosis-server-wrapper/bin/metaServer.sh stop  #停止
　　[root@hostname ~]# /opt/taobao/metamorphosis-server-wrapper/bin/metaServer.sh status  #查看状态
```