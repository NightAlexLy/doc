---
title: 
---
 
 **特别说明**
 
 　　1. 请先安装[jdk](/linux_software/jdk.html)环境
 　　2. 安装版本：**apache-tomcat-7.0.64.tar.gz**
 　　3. 安装路径：**/opt/apache-tomcat**
 
 
a. 检查是否安装tomcat

```
　　[root@hostname ~]# ps -ef | grep tomcat
　　[root@hostname ~]# rpm -qa | grep tomcat
```

b. 安装tomcat

```
　　[root@hostname ~]# cd /opt
　　[root@hostname ~]# wget  http://ore2d9chp.bkt.clouddn.com/zookeeper-3.4.7.tar.gz
　　[root@hostname ~]# tar -zxvf apache-tomcat-7.0.64.tar.gz
　　[root@hostname ~]# mv apache-tomcat-7.0.64 apache-tomcat
```

