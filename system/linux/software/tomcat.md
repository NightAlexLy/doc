---
title: Tomcat Install
---
 
 **特别说明**
 
 　　1. 请先安装[jdk](/linux_software/jdk.html)环境
 　　2. 安装版本：**apache-tomcat-7.0.86.tar.gz**
 　　3. 安装路径：**/opt/apache-tomcat**
 
 
a. 检查是否安装tomcat

```
[root@hostname ~]# ps -ef | grep tomcat
[root@hostname ~]# rpm -qa | grep tomcat
```

b. 安装tomcat

```
[root@hostname ~]# cd /opt
[root@hostname ~]# wget  http://mirrors.hust.edu.cn/apache/tomcat/tomcat-7/v7.0.86/bin/apache-tomcat-7.0.86.tar.gz
[root@hostname ~]# tar -zxvf apache-tomcat-7.0.86.tar.gz
[root@hostname ~]# mv apache-tomcat-7.0.86 apache-tomcat
```

