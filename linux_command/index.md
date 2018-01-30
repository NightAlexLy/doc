---
title: 
---

# Linux Command

```
1.nohup  后台启动应用
2.kill -9 杀死进程
3.killall 应用名   杀死所有进程
4.ps -ef | grep java  查找进程
5.cat 6379.conf | grep logfile  查看内容并且查找
6.netstat -antp | grep mysql  查看mysql端口
7.ll -R /home/luis/Downloads/keepalived/   显示路径下的详细信息
8.rpm -qa | grep vsftpd   查看应用的信息
9.rpm -ql vsftpd-2.2.2-14.el6.x86_64   查看应用的安装路径
10.history  显示历史命令
11.id 显示用户信息
12.whereis  应用名  显示安装应用路径
13.rpm -qc lftp   查看核心配置文件
14.getenforce   查看seLinux是否关闭
15.getsebool -a | grep virt*  查看系统配置
16.yum -y install --downloadonly --downloaddir=/tmp/ vlock   只下载不安装
17.rpm -e xxxx  --nodeps 删除安装包，不管依赖
18.ip a show|awk '/inet\ /'
19.chmod  u+x  file名字   设置可执行程序
20 zip -r xxx.zip  xxx【目录】    压缩目录为指定zip文件
21.ls | wc -w是查看有多少个文件及文件夹ls | wc -c这个查看目录下多少个文件
22.unzip  MetInfo5.2.zip  -d  metinfo-bak   解压zip包
23.ls -hal *.rdb   查看指定格式的文件。 并且计算大小
24.vmstat 1 1111  查看系统进程
25.查看日志：
   last | grep shutdown 
   last | grep reboot
26. userdel  -r xxxx   删除用户并删除关联信息
27. zip -r data.zip data    zip名称    文件夹
28. nginx -s reload
29. scp -r root@192.168.91.128:/opt/* .
30. scp .ssh/id_rsa.pub chenlb@10.211.55.5:/opt/id_rsa.pub 
31. 服务关闭： chkconfig 服务名  off
32. 关闭nginx :   nginx -s stop
33. 建立软连接： ln -s 地址。 软连接 地址
34. du -sh /opt/jdk1.7.0_79/   查看文件的大小
35. mongodb还原
    mongorestore -h localhost -d leanote --dir /home/mongodb/mongodb_backup/20160502/leanote/
36. 配置虚拟主机
    ifconfig eth0:1 192.168.1.7 broadcast 192.168.1.255 netmask 255.255.255.0
37. nginx执行文件
   nginx -c  nginx.conf 
38. 切分日志
   kill -USR1 进程号
39. 开启nmon
   ./nmon_x86_64_rhel6 -fF /opt/nmon/data/`date +'%y%m%d%H%M%S'`.nmon -s 1 -c 40
40. 查看当前启动的java进程
    jps
41. cat /proc/$PID/environ | tr '\0' '\n'   查看进程环境变量
42. su - note -c 'nohup sh /opt/leanote/bin/run.sh &'   开机启动
43. 查看磁盘IO：iostat -x 1
44. watch du -sh *   查看所有文件的增长
45. watch du -sh   查看总的增长
46. md5sum  文件  【可以用来检测文件是否被修改过】  判断两个文件的md5sum的code是否一致
47. 录制命令行教程：script -t 2> timing.log -a output.session
48. 回放录制教程：scriptreplay timing.log output.session
49. 删除指定文件
    find  .  - type f -name "*.log" -print0 | xargs -0 rm -f
50. 查看文件的行数
    find . -type f -name "*.txt" -print0 | xargs -0 wc -l
51. 查看应用的进程号
    pidof stardict    //stardict表示应用的别名
52. 根据进程号查看应用名：grep "Name:" /proc/13782/status   13782表示进程号
    lsof -Pnl +M -i6|grep 51331[PID]          通过lsof命令查看PID 
53. wc -l catalina.log   获得文件的行数
54. grep ^processor /proc/cpuinfo | wc -l   查看CPU数
55. ssh-copy-id -i ~/.ssh/id_rsa.pub  <ip>  拷贝id_rsa.pub到部署主机上建立单向信任
56. ansible test -m command -a 'uptime'   ansible命令。
57. find   * | xargs grep -F "xxxx"     指定文件搜索制定内容
58. wc  -l  文件名    查看文件总行数
59. ansible all -i hosts -m ping
60. ansible-playbook -i hosts site.yml
61. tower-manage inventory_import --custom --source=get_inventory.py --inventory-name="cib-hosts" --overwrite
62. ansible test -m -yum -a "name=lsof.x86_64" -k 
63. cat /etc/fstab | grep -v "#" | grep -v '^$' | awk -F "[\t ]+" '{print "DEVICE: "$1 "\t FSTYPE: "$3}'
64. grep -v '^$'    去掉空行
65. chattr +I file  将文件设置为不可修改的
66. chattr -I  file  设置文件为可写的
67. find *.sh | xargs grep -F "bin" --color=auto     查看指定内容并标记显示
68. ps -ef --sort -pcpu | head   查看CPU占用率最高的进程
69. cat /proc/cpuinfo | sed -n 5p     获得处理器名称
```             
