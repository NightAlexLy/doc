---
title: Mysql Command
---

# Mysql 常用命令

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