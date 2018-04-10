---
title: SFTP Install
---
 
 **特别说明**
 
 　　1.  安装用户：**root**
 
a. 建立组

```
[root@hostname ~]# grep -i sftp /etc/group
[root@hostname ~]# groupadd sftp
```

b. 建立用户并授予密码

```
[root@hostname ~]# useradd -g sftp -s /bin/false sftp_user1
[root@hostname ~]# echo '密码' | passwd --stdin sftp_user1

[root@hostname ~]# useradd -g sftp -s /bin/false sftp_user2
[root@hostname ~]# echo '密码' | passwd --stdin sftp_user2
```

c. 建立目录

```
[root@hostname ~]# mkdir -p /sftp/user1
[root@hostname ~]# chown -R sftp_user1.sftp /sftp/user1
[root@hostname ~]# usermod -d /sftp/user1 sftp_user1
[root@hostname ~]# chown root:sftp /sftp/user1
[root@hostname ~]# chmod 755 /sftp/user1

[root@hostname ~]# mkdir -p /sftp/user2
[root@hostname ~]# chown -R sftp_user2.sftp /sftp/user2
[root@hostname ~]# usermod -d /sftp/user2 sftp_user2
[root@hostname ~]# chown root:sftp /sftp/user2
[root@hostname ~]# chmod 755 /sftp/user2
```

d. 重启sshd服务 

```
[root@hostname ~]# service sshd restart
```