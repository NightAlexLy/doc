---
title: Subversion Install
---

**Subversioin 是svn服务端的应用软件。**
 
 　　1.  Subversion版本：1.7.14
 　　2.  安装方式：yum
 　　3.  安装用户：**root**
 
a. 安装Subversion

```
配置过yum环境的直接执行：
　　[root@hostname ~]# yum -y install subversion
验证是否安装完成：
　　[root@hostname ~]# svnversion --version
安装成功返回的信息：
svnversion, version 1.7.14 (r1542130)
   compiled Aug 23 2017, 20:43:38
```

b. 搭建仓库

```
　　[root@hostname ~]# mkdir -p /opt/svn/repos
　　[root@hostname ~]# svnadmin create /opt/svn/repos
```

c. 设置配置文件

```
　　[root@hostname ~]# cd /opt/svn/repos/conf

编辑认证文件authz
　　[root@hostname ~]# vi authz
添加：
　　[groups]
　　development = user

　　[/]
　　@development=rw

　　[repos:/]
　　user = rw

　　[root@hostname ~]# vi passwd
编辑用户密码文件passwd:
添加：
	[users]
	user = password

编辑svnserver配置文件
　　[root@hostname ~]# vi svnserve.conf
添加：
	[general]
	anon-access = none
	auth-access = write
	password-db = passwd
	authz-db = authz
	realm = /opt/svn/repos

```

d. 启动svn-server

```
　　[root@hostname ~]# svnserve -d -r /opt/svn/repos
```

e. 校验svn-server

```
　　[root@hostname ~]# svn list svn://xxx.xxx.xxx.xxx/
```

f. 关于svn的资料
　　
　　[linux下svn命令使用大全](https://www.cnblogs.com/lushilin/p/6100997.html)
　　[svn之——linux下清除svn的用户名和密码](https://www.cnblogs.com/mangu-uu/archive/2012/09/05/2671467.html)
　　[svn出现Authorization failed](https://www.cnblogs.com/rookie404/p/5787070.html)
　　[svn设置提交忽略某些文件或文件夹](http://blog.csdn.net/apensu/article/details/40184121)
　　[linux svn authorization failed错误](http://www.bubuko.com/infodetail-676435.html)
　　[用 Apache 和 Subversion 搭建安全的版本控制环境](https://www.ibm.com/developerworks/cn/java/j-lo-apache-subversion/)
　　[Linux 下SVN自动更新](https://www.cnblogs.com/gpfeisoft/p/5930694.html)