---
title: Network Command
---

**Linux 关于网络通信指令。**

网络通信指令：
　　write[向另外一个用户发消息]
　　wall[向所有用户广播信息]
　　ping[测试网络连通性]
　　ifconfig[查看网络设置信息]

命令名称：**write**    命令所在路径：**/usr/bin/write**   执行权限：所有用户
语法：write  <用户名>   功能描述：向另外一个用户发信息,以Ctrl+D作为结束
```
范例：$write webmaster
```

命令名称：**wall**   命令所在路径：**/usr/bin/wall**   执行权限：所有用户
语法：wall [message]  [文件名]  功能描述：向所有用户广播信息
```
范例：$wall Happy New Year!
```

命令名称：**ping**   命令所在路径：**/usr/sbin/ping**  执行权限：root
语法：ping 选项 IP地址  功能描述：测试网络连通性
```
范例：# ping 192.168.1.1
　　　-c  次数：  如：#ping -c 3 192.168.1.1
　　　-s  表示设置发包大小  如：#ping -s 60000 192.168.1.1
```

命令名称：**ifconfig**    命令所在路径：**/usr/sbin/ifconfig**   执行权限：root
语法：ifconfig  选项[-a] [网卡设备]
　　　　　　　　　-a  显示所有网卡
功能描述：查看网络设置信息
```
范例：#ifconfig -a
```
 