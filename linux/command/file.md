---
title: File Command
---

**Linux 关于文件处理命令。**

Linux下：
　　root里面的命令放置在/sbin或者/usr/sbin目录下
　　all users[所有用户]里面的命令放置在/bin或者/usr/bin目录下
　　bin-binary 二进制文件
　　usr-user 用户
　　sbin- super binary 超级用户
	
文件处理命令：
　　ls[显示文件信息]、
　　cd[切换目录]、
　　pwd[显示目录位置]、
　　mkdir[创建文件夹]、
　　touch[创建空文件]、
　　cp[复制文件或目录]、
　　mv[移动文件、更名]、
　　rm[删除文件]、
　　cat[显示文件内容]、
　　more[分页显示文件内容]、
　　head[查看文件的前几行]、
　　tail[查看文件的后几行]、
　　ln[产生链接文件]

命令名称：**ls**  英文原意：list. 命令所在路径：**/bin/ls**
执行权限：所有用户  功能描述：显示目录文件
```
语法： ls  项【-ald】[文件或目录]
　　　　　　　　-a 显示所有文件，包括隐藏文件
　　　　　　　　-l long 详细信息显示
　　　　　　　　-d 查看目录属性
　　　　　　　　-i inode i节点
```

命令名称：**cd**  命令英文原意：**change directory** 命令所在路径：**shell内置命令**
执行权限：所有用户  语法：cd [目录]  功能描述：切换目录
```
范例：$cd / 切换到根目录
　　　$cd .. 回到上一级目录
```

命令名称：**pwd**  命令英文原意：**print working directory** 命令所在路径：**/bin/pwd**
执行权限：所有用户  语法：pwd  功能描述：显示当前所在的工作目录
```
范例：$pwd /etc/rc5.d
```

命令名称：**mkdir**  命令英文原意：**make directories**  命令所在路径：**/bin/mkdir**
执行权限：所有用户 语法：mkdir [目录名] 功能描述：创建新目录
```
范例：$mkdir newdir
```

命令名称：**touch** 命令所在路径：**/bin/touch** 执行权限：所有用户
语法：touch [文件名]  功能描述：创建空文件
```
范例：$touch newfile
```

命令名称：**cp**  命令英文原意：**copy**  命令所在路径：**/bin/cp**
执行权限：所有用户  语法：cp -R [源文件或目录] [目的目录]
        -R 复制目录
功能描述：复制文件或目录
```
范例：$cp file1 file2 dir1 将文件file1、file2复制到目录dir1
　　　$cp -R dir1 dir2 将dir1下所有文件及子目录复制到dir2
```

命令名称：**mv** 命令英文原意：**move**  命令所在路径：**/bin/mv**
执行权限：所有用户 语法：mv[源文件或目录][目的目录]
功能描述：移动文件、更名
```
范例：$mv file1 file3 将当前目录下文件file1更名为file3
　　　$mv file2 dir2 将文件file2移动到目录dir2下
```

命令名称：**rm**  命令英文原意：**remove**   命令所在路径：**/bin/rm**
执行权限：所有用户  语法：rm -r [文件或目录]
　　　　　　　　　　　　　　-r  删除目录
功能描述：删除文件
```
范例：$rm file3 删除文件file3
　　　$rm -r dir1 删除目录dir1
　　　【特殊命令：rmdir  删除空目录。如果非空目录会报错】
　　　【rm -rf dir1 强制删除dir1目录下所有内容】
```

命令名称：**cat**   命令英文原意：**concatenate and display files**
命令所在路径：**/bin/cat**  执行权限：所有用户
语法：cat [文件名]  
```
范例：$cat /etc/issue
```

命令名称：**more**  命令所在路径：**/bin/more**  执行权限：所有用户
语法：more [文件名]  （空格）或f   显示下一页
　　　　(Enter)      显示下一行
　　　　q或者Q       退出
功能描述：分页显示文件内容
```
范例：$more /etc/services
```

命令名称：**head**   命令所在路径：**/bin/head**  执行权限：所有用户
语法：head -num[文件名]
　　-num   显示文件的前num行
功能描述：查看文件的前几行
```
范例：$head -20 /etc/services
```

命令名称：**tail**   命令所在路径：**/bin/tail**  执行权限：所有用户
语法：  tail -num [文件名]
　　　　　　 -num 显示文件的后num行
　　　　　　　-f 动态显示文件内容
功能描述：查看文件的后几行
```
范例：$tail -30 /etc/services
```

命令名称：**ln**   命令英文原意：**link**   命令所在路径:**/bin/ln**
执行权限：所有用户  语法：ln -s [源文件][目标文件]
　　　　　　　　　　　　　　-s 创建软链接
功能描述：产生链接文件
```
范例：$ln -s /etc/issue /issue.soft
　　　创建文件/etc/issue的软连接/issue.soft
　　　$ln /etc/issue  /issue.hard
　　　创建文件/etc/issue的硬链接/issue.hard
　　软链接可以跨文件系统生成、硬链接不行。不能跨分区
　　软连接类似于Windows平台中的快捷方式。  源文件删除软链接失效
　　硬链接相当于拷贝加同步更新。更源文件一样大小。具有相同的i结点。不能跨分区生成链接
```