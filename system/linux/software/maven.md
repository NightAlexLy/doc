---
title: Maven Install
---

**Maven 是项目管理工具，用来处理项目的依赖以及构建等。**
 
 　　1.  Subversion版本：3.5.2
 　　2.  安装方式：tar.gz
 　　3.  安装用户：**root**
 
a. 下载Maven并解压

```
	[root@hostname ~]# cd /opt
	[root@hostname ~]# wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
	[root@hostname ~]# tar -zxvf apache-maven-3.5.2-bin.tar.gz
	[root@hostname ~]# mv apache-maven-3.5.2-bin maven
```

b. 配置环境变量
```
	[root@hostname ~]# vi /etc/profile
	添加：
		export M3_HOME=/opt/maven
		export PATH=${M3_HOME}/bin:${PATH}
	[root@hostname ~]# source /etc/profile
```

c. 验证安装
```
	[root@hostname ~]# mvn -version

	**Apache Maven 3.5.2 (138edd61fd100ec658bfa2d307c43b76940a5d7d; 2017-10-18T15:58:13+08:00)**
	Maven home: /opt/maven
	Java version: 1.8.0_112, vendor: Oracle Corporation
	Java home: /usr/local/java/jdk1.8.0_112/jre
	Default locale: en_US, platform encoding: UTF-8
	OS name: "linux", version: "3.10.0-327.36.3.el7.x86_64", arch: "amd64", family: "unix"

```