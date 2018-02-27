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