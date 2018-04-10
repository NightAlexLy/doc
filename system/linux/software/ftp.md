---
title: Vsftpd(FTP) Install
---
 
 **特别说明**
 
 　　1.  vsftpd的版本：**vsftpd-2.2.2-14.el6.x86_64.rpm**
 　　2.  安装用户：**root**
 
a. 关闭防火墙

```
[root@hostname ~]# service iptables stop
检查selinux是否关闭
[root@hostname ~]# getenforce
如果返回的不是Disabled，执行以下命令：
[root@hostname ~]# setenforce 0
```

b. 安装vsftpd服务

```
[root@hostname ~]# yum -y install vsftpd
当yum不成功的时候，可以通过
[root@hostname ~]# cp /opt
[root@hostname ~]# wget http://ore2d9chp.bkt.clouddn.com/vsftpd-2.2.2-14.el6.x86_64.rpm
[root@hostname ~]# rpm -ivh vsftpd-2.2.2-14.el6.x86_64.rpm
```

c. 基础配置

```
[root@hostname ~]# vi /etc/vsftpd/vsftpd.conf
修改值如下：
　　anonymous_enable=NO
　　pam_service_name=vsftpd.vu
末尾添加：
　　guest_enable=YES
　　guest_username=virtual
　　user_config_dir=/etc/vsftpd/user_conf


[root@hostname ~]# touch   /etc/pam.d/vsftpd.vu
[root@hostname ~]# vi  /etc/pam.d/vsftpd.vu
添加内容如下：
　　　　auth       required  pam_userdb.so db=/etc/vsftpd/vsftpd_login
　　　　account  required  pam_userdb.so db=/etc/vsftpd/vsftpd_login
添加虚拟用户文件：
[root@hostname ~]# touch /etc/vsftpd/vsftpd_login.txt
[root@hostname ~]# vi /etc/vsftpd/vsftpd_login.txt
添加如下内容：
　　user1
　　password1
　　user2
　　password2
　　user3
　　password3
　　user4
　　password4
　　user5
　　password5
建立访问者数据文件（如果没有可以安装：yum install db4-utils）
[root@hostname ~]# db_load -T -t hash -f /etc/vsftpd/vsftpd_login.txt /etc/vsftpd/vsftpd_login.db
建立虚拟用户
[root@hostname ~]# useradd -d /home/ftp -s /sbin/nologin virtual
创建目录并赋予权限
[root@hostname ~]# mkdir -p /ftp/user1
[root@hostname ~]# mkdir -p /ftp/user2
[root@hostname ~]# mkdir -p /ftp/user3
[root@hostname ~]# mkdir -p /ftp/user4
[root@hostname ~]# mkdir -p /ftp/user5
[root@hostname ~]# chown -R virtual:virtual /ftp/user1
[root@hostname ~]# chown -R virtual:virtual /ftp/user2
[root@hostname ~]# chown -R virtual:virtual /ftp/user3
[root@hostname ~]# chown -R virtual:virtual /ftp/user4
[root@hostname ~]# chown -R virtual:virtual /ftp/user5
创建用户配置文件目录并创建对应角色配置文件
[root@hostname ~]# mkdir /etc/vsftpd/user_conf
[root@hostname ~]# touch /etc/vsftpd/user_conf/user1
[root@hostname ~]# touch /etc/vsftpd/user_conf/user2
[root@hostname ~]# touch /etc/vsftpd/user_conf/user3
[root@hostname ~]# touch /etc/vsftpd/user_conf/user4
[root@hostname ~]# touch /etc/vsftpd/user_conf/user5
添加配置：
[root@hostname ~]# vi /etc/vsftpd/user_conf/user1
添加如下内容：
　　local_root=/ftp/user1
　　anon_world_readable_only=NO
　　write_enable=YES
　　anon_upload_enable=YES
　　anon_mkdir_write_enable=YES
　　anon_other_write_enable=YES

添加配置：
[root@hostname ~]# vi /etc/vsftpd/user_conf/user2
添加如下内容：
　　local_root=/ftp/user2
　　anon_world_readable_only=NO
　　write_enable=YES
　　anon_upload_enable=YES
　　anon_mkdir_write_enable=YES
　　anon_other_write_enable=YES

添加配置：
[root@hostname ~]# vi /etc/vsftpd/user_conf/user3
添加如下内容：
　　local_root=/ftp/user3
　　anon_world_readable_only=NO
　　write_enable=YES
　　anon_upload_enable=YES
　　anon_mkdir_write_enable=YES
　　anon_other_write_enable=YES

添加配置：
[root@hostname ~]# vi /etc/vsftpd/user_conf/user4
添加如下内容：
　　local_root=/ftp/user4
　　anon_world_readable_only=NO
　　write_enable=YES
　　anon_upload_enable=YES
　　anon_mkdir_write_enable=YES
　　anon_other_write_enable=YES

添加配置：
[root@hostname ~]# vi /etc/vsftpd/user_conf/user5
添加如下内容：
　　local_root=/ftp/user5
　　anon_world_readable_only=NO
　　write_enable=YES
　　anon_upload_enable=YES
　　anon_mkdir_write_enable=YES
　　anon_other_write_enable=YES
```

d. 启动服务

```
[root@hostname ~]# service vsftpd start  #启动
[root@hostname ~]# service vsftpd stop  #停止
[root@hostname ~]# service vsftpd status  #运行状态
```

e. 验证服务

```
[root@hostname ~]# yum install -y lftp
[root@hostname ~]# ftp xxx.xxx.xxx.xxx  搭建ftp的服务器ip
```