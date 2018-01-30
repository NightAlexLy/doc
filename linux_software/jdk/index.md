
`
JDK_1.7安装
特别说明

	1. JDK的版本：jdk-7u79-linux-x64.tar.gz
	2. 安装路径：/opt/java
	3. 安装用户：root

 

	a. 检查系统自带的jdk版本

[root@zkp_internal ~]# java -version
[root@zkp_internal ~]# rpm -qa | grep java
 

	b. 卸载自带的JDK的信息[没有自带JDK可不执行]

[root@zkp_internal ~]# rpm -e java-1.7.0-openjdk-1.7.0.79-2.5.5.4.el6.x86_64
[root@zkp_internal ~]# rpm -e java-1.6.0-openjdk-1.6.0.35-1.13.7.1.el6_6.x86_64
 

	c. tar.gz包安装

进入/opt目录
[root@zkp_internal ~]# cd /opt/
解压安装包
[root@zkp_internal ~]# tar -zxf jdk-7u79-linux-x64.tar.gz -C /opt
[root@zkp_internal ~]# cd /opt
对解压的目录重命名
[root@zkp_internal ~]# mv jdk1.7.0_79 jdk
改变/opt/jdk的目录权限
[root@zkp_internal ~]# chown -R root.root /opt/jdk
[root@zkp_internal ~]# ls -ld /opt/jdk
 

	d. 配置环境变量,在/etc/profile文件下添加

[root@zkp_internal ~]# cp -a /etc/profile /etc/profile.ori
[root@zkp_internal ~]# ll /etc/profile*
 
[root@zkp_internal ~]# echo 'export JAVA_HOME=/opt/jdk' >>  /etc/profile
[root@zkp_internal ~]# echo 'export CLASSPATH=$JAVA_HOME/lib' >>  /etc/profile
[root@zkp_internal ~]# echo 'export PATH=$JAVA_HOME/bin:$PATH' >>  /etc/profile
 

	e. 执行环境变量

[root@zkp_internal ~]# source /etc/profile
 

	f. 查看设置的环境变量

[root@zkp_internal ~]# echo $PATH
[root@zkp_internal ~]# echo $CLASSPATH
[root@zkp_internal ~]# echo $JAVA_HOME
 

	g. 查看java版本

[root@zkp_internal ~]# java -version


`
