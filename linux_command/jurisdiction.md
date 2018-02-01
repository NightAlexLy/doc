---
title: 
---

**Linux 关于权限处理命令。**

权限命令：
　　　chmod[改变文件或目录权限]
　　　chown[改变文件或目录的所有者]
　　　chgrp[改变文件或目录的所属组]
　　　umask[显示、设置文件的缺省权限]

命令名称：**chmod**   命令英文愿意：**change the  permissions mode of a file**   命令所在路径：**/bin/chmod**
执行权限：所有用户  语法：chmod [{ugo}{+-=}{rwx}][文件或目录]
　　　　　　　　　　　　　　　　[mode=421][文件或目录]

功能描述：改变文件或目录权限
```
范例：$chmod g+w file1  赋予文件file1所属组写权限
　　　$chmod 777 dir1   设定目录dir1为所有用户具有全部权限
```
　　rwx  可读可写可执行
　　r-4   w-2   x-1
　　rwxr-xr--  754
　　rw-r-x--x  651
　　752  rwxr-x-w-

**文件目录权限总结：**

| 代表字符   |     权限　         |      对文件的含义   |    对目录的含义      | 
| :--------: | :--------:         |  :--------:         |   :--------:         | 
| r          |  读权限  |   可以查看文件内容  |    可以列出目录中的内容  | 
| w          |  写权限|   可以修改文件内容|    可以再目录中创建、删除文件| 
| x          |  执行权限 |   可以执行文件  |    可以进入目录  | 

**文件：**
　　r- cat、more、head、tail
　　w- echo、vi
　　x- 命令、脚本

**目录：**
　　r- ls
　　w- touch、mkdir、rm
　　x- cd

命令名称：**chown**  命令英文原意：**change file ownership**  命令所在路径：**/bin/chown**
执行权限：所有用户   语法:chown [用户] [文件或目录]
功能描述：改变文件或目录的所有者
```
范例：$chown nobody file1  改变文件file1的所有者为nobody
```

命令名称：**chgrp** 命令英文原意：**change file group ownership**   命令所在路径：**/bin/chgrp**
执行权限：所有用户  语法：chgrp [用户组] [文件或目录]
功能描述：改变文件或目录的所属组
```
范例：$chgrp adm file1  改变文件file1的所属组为adm
```

命令名称：**umask**   命令所在路径：**/bin/umask**  执行权限：所有用户
语法：umask [-S]
　　　　　　-S   以rwx形式显示新建文件或目录缺省权限
功能描述：显示、设置文件的缺省权限。
```
范例：$umask 
　　　$umask -S
```

Linux下查看创建文件或目录的默认权限
使用umask命令：
```
[luis@localhost ~]$ umask
　　0002
　　0002 表示  第一位0表示特殊权限位    022表示用户权限位，权限掩码值。
　　777
　　-002
　　------
 　　775   表示当前用户和用户组可读写。 其他能不能执行
　　umask -S  可以显示详细信息：
[luis@localhost ~]$ umask -S
　　u=rwx,g=rwx,o=rx
　　修改系统默认的创建文件权限：
　　umask 027  [参数为权限掩码]

Linux权限规则：
　　缺省创建的文件不能授予可执行x权限
```