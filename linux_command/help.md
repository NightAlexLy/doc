---
title: 
---

**Linux 关于帮助命令。**

### 帮助命令：
　　　　man[获得帮助信息]
　　　　info[获得帮助信息]
　　　　whatis[获得索引的简短说明信息]

命令名称：**man** 命令英文原意：**manual**    命令所在路径：**/usr/bin/man**   执行权限：所有用户   
语法：man[命令或配置文件]    功能描述：获得帮助信息
```
范例：$man ls  查看ls命令的帮助信息
　　　$man services 查看配置文件services的帮助信息
```

命令名称：**info**
命令英文原意：**infomation**    命令所在路径：**/usr/bin/info**   执行权限：所有用户   
语法：info[命令或配置文件]    功能描述：获得帮助信息
```
范例：$info ls  查看ls命令的帮助信息
```

命令名称：**whatis apropos makewhatis**
命令英文原意：**search the whatis database for strings**
指定所在路径：/usr/bin/whatis apropos
　　　　　　　/usr/sbin/makewhatis
执行权限：所有用户、所有用户、root
语法： whatis apropos [任何关键字]  功能描述：获得索引的简短说明信息
范例：$whatis ls
　　　$apropos fstab  相当于man -k
　　　　　#makewhatis   建立whatis和apropos搜索使用的数据库,当使用这两个命令发生错误时,就是whatis database没有建立

**help**   查看shell内置命令的帮助
 