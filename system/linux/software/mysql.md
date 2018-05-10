---
title: MySql Install
---
 
**特别说明**
 
 　　1.  Mysql版本:MySQL-server-5.6.13-1.el6.x86_64
 　　2.  安装路径：/usr/share/mysql
 　　3.  安装用户：**root**，部署过程会添加mysql用户
 
a. 添加mysql用户
```
useradd mysql
echo "mysql123" | passwd --stdin mysql
```

b.安装Mysql
```
  # remove mysql-libs dependency
  yum -y remove mysql-libs*
  yum -y remove mariadb-libs*

  # create mysql folder
  mkdir -p /opt/mysql
  # change folder
  cd /opt/mysql
  # Download mysql source rpm
  wget http://cdn.mysql.com/archives/mysql-5.6/MySQL-server-5.6.13-1.el6.x86_64.rpm
  wget http://cdn.mysql.com/archives/mysql-5.6/MySQL-devel-5.6.13-1.el6.x86_64.rpm
  wget http://cdn.mysql.com/archives/mysql-5.6/MySQL-client-5.6.13-1.el6.x86_64.rpm
  # install server

  rpm -ivh MySQL-server-5.6.13-1.el6.x86_64.rpm
  rpm -ivh MySQL-devel-5.6.13-1.el6.x86_64.rpm
  rpm -ivh MySQL-client-5.6.13-1.el6.x86_64.rpm

  # copy mysql conf 
  cp /usr/share/mysql/my-default.cnf /etc/my.cnf

  # set my.cnf config
  sed -i '/^\[mysqld\]$/a\character-set-server=utf8' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\collation-server=utf8_bin' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\default-storage-engine=INNODB' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\max_allowed_packet=40M' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\lower_case_table_names=1' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\innodb_buffer_pool_size = 256M' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\max_connections=800' /etc/my.cnf

  # mysql install db
  /usr/bin/mysql_install_db

  # start mysql server
  # centOS 6
  #service mysql start
  # centOS 7
  systemctl start mysql.service

  # chkconfig mysql
  chkconfig mysql on
```

# 初始化Mysql设置
```
 获得密码
 cat /root/.mysql_secret

 登录mysql服务
 mysql -uroot -p获得的密码

 执行如下命令
 SET PASSWORD = PASSWORD('password');
 use mysql;
 update user set password=password('password') where user='root';
 grant all privileges on *.* to mysql@'%' identified by 'password' with grant option;
 update user set password=password('password') where user='mysql';
 flush privileges;
 exit

```