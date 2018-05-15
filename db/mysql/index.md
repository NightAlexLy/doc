---
title: Mysql Command
---

## 常用命令

**创建用户**
```
CREATE USER '用户名'@'%' IDENTIFIED BY '07fa533360d9'; 
```

**修改密码**
```
update mysql.user set password=password('修改后的密码') where user='用户名';
```

**创建数据库并制定编码**
```
create database 数据库名 CHARACTER SET utf8 COLLATE utf8_general_ci;

建立数据库时可以使用以下命令：
create database 数据库名 character set utf8; 
use 数据库名;
source 初始化脚本.sql;
修改数据库编码的命令为：

alter database 数据库名 character set utf8; 
```

**用户给指定数据库授权 **
```
grant all privileges on 数据库.* to '用户名'@'%';
```
	
**刷新MySQL的系统权限相关表**
```
flush privileges;
```

**查看环境信息**
```
查看端口号
show global variables like 'port';
查看环境编码
show variables like "%character%";
```

## Conf

　　[Mysql Server Conf](conf.html)

## 主从同步
```
 Master Server ：

   0. 添加同步账户
   连接Mysql服务[mysql -uroot -pxxxx]
   mysql> create user repl;
   Query OK, 1 rows affected (0.01 sec)
   mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'192.168.0.%' IDENTIFIED BY 'mysql';   #指定那个段的IP才能连接服务
   Query OK, 1 rows affected (0.01 sec)
   mysql> flush privileges;
   Query OK, 1 rows affected (0.01 sec)
   
   1. 修改/etc/my.cnf文件
   [mysqld]
   port=13577
   datadir=/var/lib/mysql
   socket=/tmp/mysql.sock
   server-id=1  # server id
   log-bin=master-bin  # master-bin日志文件 
   log-bin-index=master-bin.index  
   binlog-do-db=itools  # 指定同步那个库

   [mysqld_safe]
   log-error=/var/log/mariadb/mariadb.log
   pid-file=/var/run/mariadb/mariadb.pid


   2.重启Master Server的Mysql服务

   systemctl restart mysql.service

   3.查看Master的状态
   连接Mysql服务[mysql -uroot -pxxxx]
   执行`show master status;`

   mysql> show master status;
   +-------------------+----------+--------------+------------------+
   | File              | Position | Binlog_Do_DB | Binlog_Ignore_DB |
   +-------------------+----------+--------------+------------------+
   | master-bin.000004 |    10237 | itools       |                  |
   +-------------------+----------+--------------+------------------+
   1 row in set (0.00 sec)


Slave Server ：

   1. 修改/etc/my.cnf文件
   [mysqld]
   datadir=/var/lib/mysql
   socket=/var/lib/mysql/mysql.sock
   server-id=2
   relay-log-index=slave-relay-bin.index
   relay-log=slave-relay-bin
   [mysql.server]
   user=mysql
   [client]
   socket=/var/lib/mysql/mysql.sock

   2. 重启Mysql服务

   systemctl restart mysql.service

   3. 添加Master配置
   连接Mysql服务[mysql -uroot -pxxxx]
   mysql> change master to master_host='xxx.xxx.xxx.xxx',   # Master的IP
          master_port=13577,    # Master的port
          master_user='repl',   # 连接Master的用户名
          master_password='mysql',  # 连接Master的用户密码
          master_log_file='master-bin.000004',   # 上面show master status 查到的File值
          master_log_pos=2806;    # 上面show master status  查看到Position值
   Query OK, 1 rows affected (0.01 sec)
   mysql> flush privileges;
   Query OK, 1 rows affected (0.01 sec)

   4. 查看Slave的状态
   mysql> show slave status;
   +----------------------------------+----------------+-------------+-------------+---------------+-------------------+---------------------+------------------------+---------------+-----------------------+------------------+-------------------+-----------------+---------------------+--------------------+------------------------+-------------------------+-----------------------------+------------+------------+--------------+---------------------+-----------------+-----------------+----------------+---------------+--------------------+--------------------+--------------------+-----------------+-------------------+----------------+-----------------------+-------------------------------+---------------+---------------+----------------+----------------+-----------------------------+------------------+-------------+----------------------------+-----------+---------------------+-----------------------------------------------------------------------------+--------------------+-------------+-------------------------+--------------------------+----------------+--------------------+--------------------+-------------------+---------------+
   | Slave_IO_State                   | Master_Host    | Master_User | Master_Port | Connect_Retry | Master_Log_File   | Read_Master_Log_Pos | Relay_Log_File         | Relay_Log_Pos | Relay_Master_Log_File | Slave_IO_Running | Slave_SQL_Running | Replicate_Do_DB | Replicate_Ignore_DB | Replicate_Do_Table | Replicate_Ignore_Table | Replicate_Wild_Do_Table | Replicate_Wild_Ignore_Table | Last_Errno | Last_Error | Skip_Counter | Exec_Master_Log_Pos | Relay_Log_Space | Until_Condition | Until_Log_File | Until_Log_Pos | Master_SSL_Allowed | Master_SSL_CA_File | Master_SSL_CA_Path | Master_SSL_Cert | Master_SSL_Cipher | Master_SSL_Key | Seconds_Behind_Master | Master_SSL_Verify_Server_Cert | Last_IO_Errno | Last_IO_Error | Last_SQL_Errno | Last_SQL_Error | Replicate_Ignore_Server_Ids | Master_Server_Id | Master_UUID | Master_Info_File           | SQL_Delay | SQL_Remaining_Delay | Slave_SQL_Running_State                                                     | Master_Retry_Count | Master_Bind | Last_IO_Error_Timestamp | Last_SQL_Error_Timestamp | Master_SSL_Crl | Master_SSL_Crlpath | Retrieved_Gtid_Set | Executed_Gtid_Set | Auto_Position |
   +----------------------------------+----------------+-------------+-------------+---------------+-------------------+---------------------+------------------------+---------------+-----------------------+------------------+-------------------+-----------------+---------------------+--------------------+------------------------+-------------------------+-----------------------------+------------+------------+--------------+---------------------+-----------------+-----------------+----------------+---------------+--------------------+--------------------+--------------------+-----------------+-------------------+----------------+-----------------------+-------------------------------+---------------+---------------+----------------+----------------+-----------------------------+------------------+-------------+----------------------------+-----------+---------------------+-----------------------------------------------------------------------------+--------------------+-------------+-------------------------+--------------------------+----------------+--------------------+--------------------+-------------------+---------------+
   | Waiting for master to send event | xxx.xxx.xxx.xxx | repl        |       13577 |            60 | master-bin.000004 |               10237 | slave-relay-bin.000002 |          7698 | master-bin.000004     | Yes              | Yes               |                 |                     |                    |                        |                         |                             |          0 |            |            0 |               10237 |            7867 | None            |                |             0 | No                 |                    |                    |                 |                   |                |                     0 | No                            |             0 |               |              0 |                |                             |                1 |             | /var/lib/mysql/master.info |         0 |                NULL | Slave has read all relay log; waiting for the slave I/O thread to update it |              86400 |             |                         |                          |                |                    |                    |                   |             0 |
   +----------------------------------+----------------+-------------+-------------+---------------+-------------------+---------------------+------------------------+---------------+-----------------------+------------------+-------------------+-----------------+---------------------+--------------------+------------------------+-------------------------+-----------------------------+------------+------------+--------------+---------------------+-----------------+-----------------+----------------+---------------+--------------------+--------------------+--------------------+-----------------+-------------------+----------------+-----------------------+-------------------------------+---------------+---------------+----------------+----------------+-----------------------------+------------------+-------------+----------------------------+-----------+---------------------+-----------------------------------------------------------------------------+--------------------+-------------+-------------------------+--------------------------+----------------+--------------------+--------------------+-------------------+---------------+
   1 row in set (0.00 sec)

   主要看`Slave_IO_Running`和`Slave_SQL_Running`是否都是`YES`。

验证：
   
   在Master Server的同步里面插入表或者数据， Slave会自动进行同步。

```

资料
- [实现两个Mysql数据库之间的主从同步](https://blog.csdn.net/guoguo1980/article/details/2343722)
- [主从不同步解决办法，常见问题及解决办法，在线对mysql做主从复制](http://blog.51cto.com/13407306/2067333)
- [mysql 远程连接数据库的二种方法](https://www.cnblogs.com/skyWings/p/5952795.html)
- [MySQL主从复制指定不同库表同步参数说明](https://www.linuxidc.com/Linux/2016-07/132862.htm)
- [Mysql主从配置，实现读写分离](https://www.cnblogs.com/alvin_xp/p/4162249.html)
- [mysql主从选择性同步某几个库实现方法](http://blog.itpub.net/29654823/viewspace-2139004/)


## 双向同步
```
   相反的两台服务器调换配置即可。

   Master的my.cnf：
    [mysqld]
    port=13577
    datadir=/var/lib/mysql
    socket=/tmp/mysql.sock
    symbolic-links=0
    # Master config
    server-id=1
    log-bin=master-bin1
    log-bin-index=master-bin1.index
    binlog-do-db=itools
    log_err=my-err.log
    # Slave config
    relay-log-index=slave-relay-bin1.index
    relay-log=slave-relay-bin1
    [mysqld_safe]
    log-error=/var/log/mariadb/mariadb.log
    pid-file=/var/run/mariadb/mariadb.pid

  重启服务
  systemctl restart mysql.service

  连接Mysql服务
  
  mysql> show master status;

  mysql> stop slave;
  mysql> reset slave;
  mysql> change master to master_host='xxx.xxx.xxx.xxx',   # Slave的IP
          master_port=xxx,    # Slave的port
          master_user='repl',   # 连接Slave的用户名
          master_password='mysql',  # 连接Slave的用户密码
          master_log_file='master-bin.000004',   # Slave的show master status 查到的File值
          master_log_pos=2806;    # Slave的show master status  查看到Position值
  mysql> start slave;
  mysql> show slave status;
     检查`Slave_IO_Running`和`Slave_SQL_Running`是否都为`YES`。

  Slave的my.cnf：
    [mysqld]
    datadir=/var/lib/mysql
    socket=/var/lib/mysql/mysql.sock
    # slave config
    server-id=2
    relay-log-index=slave-relay-bin2.index
    relay-log=slave-relay-bin2
    # Master config
    log-bin=master2-bin
    log-bin-index=master2-bin.index
    binlog-do-db=itools
    binlog_checksum = none   # 修复Slave can not handle replication events with the checksum that master is configured to log;问题
    [mysql.server]
    user=mysql
    [client]
    socket=/var/lib/mysql/mysql.sock

  连接Mysql服务
  
  mysql> show master status;

  mysql> stop slave;
  mysql> reset slave;
  mysql> change master to master_host='xxx.xxx.xxx.xxx',   # Master的IP
          master_port=xxx,    # Master的port
          master_user='repl',   # 连接Master的用户名
          master_password='mysql',  # 连接Master的用户密码
          master_log_file='master-bin.000004',   # Master的show master status 查到的File值
          master_log_pos=2806;    # Master的show master status  查看到Position值
  mysql> start slave;
  mysql> show slave status;
     检查`Slave_IO_Running`和`Slave_SQL_Running`是否都为`YES`。

问题：
QA: ERROR 1201 (HY000): Could not initialize master!
执行change master的时候报如上错误。
解决办法：执行`reset slave;`

```

资料
- [复制1236错误（不同版本间binlog_checksum配置问题）](http://blog.itpub.net/30221425/viewspace-1798856/)
- [MySQL 主从复制事件校验 mysql Replication Event Checksum](https://www.linuxidc.com/Linux/2013-04/82716.htm)
- [MySQL 数据库双向同步复制](https://blog.csdn.net/mindfloating/article/details/50032877)

## 初始化Master-Slave的数据
```
大致思路： 就是Master停止写服务，导出同步库SQL脚本。Slave执行同步的SQL脚本，完成后，Master启动写服务即可。

--主机开两个窗口，一个进入mysql，一个是shell
--主机阻断写操作
mysql> FLUSH TABLES WITH READ LOCK;
Query OK, 0 rows affected (0.00 sec)
mysql> 
mysql> 
mysql> SHOW MASTER STATUS;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000002 |  1529881 | openser      | mysql,test       |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
--另外一个窗口导出主机数据库
mysqldump -u root -p123456 --opt -R openser > openser20121203.sql
--刚才的窗口主机解锁
mysql> UNLOCK TABLES;
Query OK, 0 rows affected (0.00 sec)
mysql>
--打包数据文件到从机
drop database openser;
create database openser;
mysql -u root -p123456 openser < openser20121127.sql
--从机操作
SLAVE STOP;
reset slave;
CHANGE MASTER TO MASTER_HOST='192.168.21.26',
MASTER_USER='repl_user',
MASTER_PASSWORD='123456',
MASTER_LOG_FILE='mysql-bin.000002',
MASTER_LOG_POS=1529881;
start slave;
show slave status\G
```

## 找回密码
```
 停止mysql服务
 systemctl stop mysql.service

 sudo mysqld_safe --user=mysql --skip-grant-tables --skip-networking &

 开启另外一窗口
 执行
 mysql -uroot mysql

 mysql> UPDATE user SET password=PASSWORD(“new password”) WHERE user=’root’; 
 mysql> FLUSH PRIVILEGES; 

```

资料
- [Mysql设置初始化密码和修改密码](https://blog.csdn.net/lcg0412/article/details/46137879)
- [Mac上解决Mysql ERROR 1045 (28000): Access denied for user 'root'@'localhost'](https://blog.csdn.net/fghsfeyhdf/article/details/78799270)
- [Can’t connect to local MySQL server through socket ‘/var/lib/mysql/mysql.sock’](https://blog.csdn.net/chuang3344/article/details/73824755)

## Issue

### 修改端口号
　　查看编码：
　　　　show global variables like 'port';
　　编辑mysql配置文件
　　　　--在 [mysqld] 标签下加上以下内容：
　　　　port=xxxx  [端口号]

### 设置数据库编码
　　查看编码：
　　　　show variables like "%character%";

　　有两种方式：
　　- 通过mysql配置文件
　　　　vi /etc/my.cnf
　　　　　--在 [mysqld] 标签下加上以下内容：
　　　　　default-character-set = utf8
　　　　　character_set_server = utf8
　　　　　注意：如果此标签下已经存在“default-character-set=GBK”类似的内容，只需修改即可。
　　　　　--在 [mysql]  标签下加上一行
　　　　　default-character-set = utf8
　　　　　--在 [mysql.server]标签下加上一行
　　　　　default-character-set = utf8
　　　　　--在 [mysqld_safe]标签下加上一行
　　　　　default-character-set = utf8
　　　　　--在 [client]标签下加上一行
　　　　　default-character-set = utf8　　　　
　　- 通过命令行修改
　　　　set character_set_client = utf8;
　　　　set character_set_server = utf8;
　　　　set character_set_connection = utf8;
　　　　set character_set_database = utf8;
　　　　set character_set_results = utf8;
　　　　set collation_connection = utf8_general_ci;
　　　　set collation_database = utf8_general_ci;
　　　　set collation_server = utf8_general_ci;

### 默认配置文件路径
　　默认为**/etc/my.cnf**。 Linux Debian系统为**/etc/mysql/my.cnf**