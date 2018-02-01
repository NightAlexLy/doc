---
title: 
---

**Linux 关于文件搜索命令。**

文件搜索命令：
　　which[显示系统命令所在目录]、
　　find[查找文件或目录]、
　　locate[寻找文件或目录]、
　　updatedb[建立整个系统目录文件的数据库]
　　grep[在文件中搜寻字符串匹配的行并输出]


命令名称：**which**   命令所在路径：**/usr/bin/which**   执行权限：所有用户
语法 ：which [命令名称]   功能描述：显示系统命令所在目录
```
范例：$ which ls
 
[luis@localhost ~]$ which ls
alias ls='ls --color=auto'
　　　　　　/bin/ls
[luis@localhost ~]$ which chmod
　　　/bin/chmod
[luis@localhost ~]$ whereis ls
　　　ls: /usr/bin/ls /usr/share/man/man1/ls.1.gz /usr/share/man/man1p/ls.1p.gz
```

命令名称：**find**   命令所在路径：**/usr/bin/find**    执行权限：所有用户  
语法：find [搜索路径] [搜索关键字]
```
功能描述：查找文件或目录
范例：$find /etc -name init  在目录/etc中查找文件init
　　　$find / -size +204800  在根目录下查找大于100MB的文件
　　　$find / -user sam  在根目录下查找所有者为sam的文件
　　　$find /etc -ctime -1  在/etc下查找24小时内被修改过属性的文件和目录
　　　$find /etc -size +163840 -a -size -204800   在/etc下查找大于80MB小于100MB的文件
　　　$find /etc -name inittab -exec ls -l {}\;   在/etc下查找inittab文件并显示其详细信息

　　　查找的范围尽量越小、节约系统性能。
　　　　　　-name   文件名
　　　　　　*   匹配任意字符  init*
　　　　　　?   匹配单个字符  init？？？
　　　　　　-size     文件大小   block数据块   512字节
　　　　　　-user     文件所有者
　　　时间
　　　　　　1.天  ctime、atime、mtime
　　　　　　2.分钟 cmin、amin、mmin
　　　　　　　　　c-change改变,表示文件属性被修改过,所有者、所属组、权限
　　　　　　　　　a-access访问
　　　　　　　　　m-modify修改，表示文件内容被修改过
　　　　　　　　　-之内  +超过
　　　　　　　　　-type 文件类型  f 二进制文件  l软链接文件  d目录
　　　　　　　　　-inum  i节点
```

1. 连接符  -a   and  逻辑与  -o  or 逻辑或
2. 连接符  find  ...  -exec 命令 {}\;   {}表示find查询的结果    \ 转义符,符号命令使用本身的含义 ;结果.
　　　　　　　　　　　-ok  （询问确认）

命令名称：**locate**   指令英文原意： **list files in databases**
指定所在路径：**/usr/bin/locate**  执行权限：所有用户  
语法：locate 【搜索关键字】 
功能描述：需找文件或目录
```
范例：$locate file  列出所有跟file相关的文件
```

命令名称：**updatedb**   指定英文原意：**update the slocate database**
指令所在路径：**/usr/bin/updatedb**   执行权限：root
语法：updatedb
功能描述：建立整个系统目录文件的数据库
```
范例：# updatedb
```

命令名称：**grep**   命令所在路径：**/bin/grep**  执行权限：所有用户
语法：grep [指定字符串] [源文件]
功能描述：在文件中搜寻字符串匹配的行并输出
```
范例：#grep ftp /etc/services
```


 
 