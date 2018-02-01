---
title: 
---

**Linux  压缩解压缩命令**

### 压缩解压缩命令：
　　　　gzip[压缩文件]
　　　　gunzip[解压缩]
　　　　tar[打包目录]
　　　　zip[压缩文件或目录]
　　　　unzip[解压.zip的压缩文件]
　　　　bzip2[压缩文件]
　　　　bunzip2[解压缩]

命令名称：gzip  命令英文愿意：GNU zip   命令所在路径：**/bin/gzip**
执行权限：所有用户    语法：gzip 选项 【文件】
功能秒速：**压缩文件   压缩后文件格式：.gz**
特点：
　　1. 只能压缩文件
　　2. 不保留源文件

命令名称：gunzip  命令英文愿意：GNU unzip   命令所在路径：**/bin/gunzip**
执行权限：所有用户    语法：gunzip 选项 【文件】
功能秒速：解压缩.gz的压缩文件  
范例：$gunzip file1.gz


命令名称：tar   命令所在路径：**/bin/tar**   执行权限：所有用户

```
语法： tar 选项[cvf] [目录]
　　　　　　-c   产生.tar打包文件
　　　　　　-x   解包.tar文件
　　　　　　-v   显示详细信息
　　　　　　-f    指定压缩后的文件名
　　　　　　-z    打包同时压缩
```

功能描述：打包目录
压缩后文件格式：.tar.gz
```
范例：$tar -zcvf  dir1.tar.gz dir1  将目录dir1压缩成一个打包并压缩的文件
　　　$tar -zxvf dir.tar.gz
```

命令名称：zip   命令所在路径： **/usr/bin/zip**   执行权限：所有用户  
语法：zip  选项[-r] [压缩后文件名称][文件或目录] 
　　　　　　　　-r 压缩目录
功能描述：压缩文件或目录    压缩后文件格式：.zip
```
范例：$zip services.zip /etc/services  压缩文件
　　　$zip -r test.zip /test  压缩目录
```
1.保留源文件  2.设置压缩容量【百分比】

命令名称：unzip   命令所在路径：**/usr/bin/unzip**  执行权限：所有用户
语法：unzip[压缩文件]   功能描述：解压.zip的压缩文件
```
范例：$unzip test.zip
```

命令名称：bzip2   命令所在路径：**/usr/bin/bzip2**    执行权限：所有用户 
```
语法：bzip2  选项[-k][文件]
　　　　　　　　　-k  产生压缩文件后保留文件
功能描述：压缩文件   压缩后文件格式：.bz2   
```
范例：$bzip2 -k file1
```
【压缩比很强悍】   

命令名称：bunzip2   命令所在路径：**/usr/bin/bunzip2**   执行权限：所有用户
语法：bunzip2 选项【-k】【压缩文件】
　　　　　　　　　　-k   解压缩后保留源文件
功能描述：解压缩
```
范例：$bunzip2  -k  file1.bz2
```