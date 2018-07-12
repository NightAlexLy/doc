---
title: Common Command
---

### Command 1

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
70. du -skh filename   查看文件大小  单位：M
71. export EnvName=EnvValue   设置环境变量
72. rpm -e nodeps 应用名   rpm卸载应用   ||  rpm -e 
73. yum remove 应用名  yum卸载应用
74. rpm -e e2fsprogs-1.41.12-21.el6.x86_64 --nodeps  强制卸载  同72
```             

### Command 2

```
1.检查远程端口是否对bash开放：
echo >/dev/tcp/8.8.8.8/53 && echo "open"

2.让进程转入后台：
Ctrl + z

3、将进程转到前台：
fg

4.产生随机的十六进制数，其中n是字符数：
openssl rand -hex n

5.在当前shell里执行一个文件里的命令：
source /home/user/file.name

6.截取前5个字符：
${variable:0:5}

7.SSH debug 模式:
ssh -vvv user@ip_address

8.SSH with pem key:
ssh user@ip_address -i key.pem

9.用wget抓取完整的网站目录结构，存放到本地目录中：
wget -r --no-parent --reject "index.html*" http://hostname/ -P /home/user/dirs

10.一次创建多个目录：
mkdir -p /home/user/{test,test1,test2}

11.列出包括子进程的进程树：
ps axwef

12.创建 war 文件:
jar -cvf name.war file

13.测试硬盘写入速度：
dd if=/dev/zero of=/tmp/output.img bs=8k count=256k; rm -rf /tmp/output.img

14.测试硬盘读取速度：
hdparm -Tt /dev/sda

15.获取文本的md5 hash：
echo -n "text" | md5sum

16.检查xml格式：
xmllint --noout file.xml

17.将tar.gz提取到新目录里：
tar zxvf package.tar.gz -C new_dir

18.使用curl获取HTTP头信息：
curl -I http://www.example.com

19.修改文件或目录的时间戳(YYMMDDhhmm):
touch -t 0712250000 file

20.用wget命令执行ftp下载：
wget -m ftp://username:password@hostname

21.生成随机密码(例子里是16个字符长):
LANG=c < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;

22.快速备份一个文件：
cp some_file_name{,.bkp}

23.访问Windows共享目录：
smbclient -U "DOMAIN\user" //dc.domain.com/share/test/dir

24.执行历史记录里的命令(这里是第100行):
!100

25.解压:
unzip package_name.zip -d dir_name

26.输入多行文字(CTRL + d 退出):
cat > test.txt

27.创建空文件或清空一个现有文件：
\> test.txt

28.与Ubuntu NTP server同步时间：
ntpdate ntp.ubuntu.com

29.用netstat显示所有tcp4监听端口：
netstat -lnt4 | awk '{print $4}' | cut -f2 -d: | grep -o '[0-9]*'

30.qcow2镜像文件转换：
qemu-img convert -f qcow2 -O raw precise-server-cloudimg-amd64-disk1.img \precise-server-cloudimg-amd64-disk1.raw

31.重复运行文件，显示其输出（缺省是2秒一次）：
watch ps -ef

32.所有用户列表：
getent passwd

33.Mount root in read/write mode:
mount -o remount,rw /

34.挂载一个目录（这是不能使用链接的情况）:
mount --bind /source /destination

35.动态更新DNS server:
nsupdate < <EOF
update add $HOST 86400 A $IP
send
EOF

36.递归grep所有目录：
grep -r "some_text" /path/to/dir

37.列出前10个最大的文件：
lsof / | awk '{ if($7 > 1048576) print $7/1048576 "MB "$9 }' | sort -n -u | tail

38.显示剩余内存(MB):
free -m | grep cache | awk '/[0-9]/{ print $4" MB" }'

39.打开Vim并跳到文件末：
vim + some_file_name

40.Git 克隆指定分支(master):
git clone git@github.com:name/app.git -b master

41.Git 切换到其它分支(develop):
git checkout develop

42.Git 删除分支(myfeature):
git branch -d myfeature

43.Git 删除远程分支
git push origin :branchName

44.Git 将新分支推送到远程服务器：
git push -u origin mynewfeature

45.打印历史记录中最后一次cat命令：
!cat:p

46.运行历史记录里最后一次cat命令：
!cat

47.找出/home/user下所有空子目录:
find /home/user -maxdepth 1 -type d -empty

48.获取test.txt文件中第50-60行内容：
< test.txt sed -n '50,60p'

49.运行最后一个命令(如果最后一个命令是mkdir /root/test, 下面将会运行: sudo mkdir /root/test)：
sudo !!

50.创建临时RAM文件系统 – ramdisk (先创建/tmpram目录):
mount -t tmpfs tmpfs /tmpram -o size=512m

51.Grep whole words:
grep -w "name" test.txt

52.在需要提升权限的情况下往一个文件里追加文本：
echo "some text" | sudo tee -a /path/file

53.列出所有kill signal参数:
kill -l

54.在bash历史记录里禁止记录最后一次会话：
kill -9 $$

55.扫描网络寻找开放的端口：
nmap -p 8081 172.20.0.0/16

56.设置git email:
git config --global user.email "me@example.com"

57.To sync with master if you have unpublished commits:
git pull --rebase origin master

58.将所有文件名中含有”txt”的文件移入/home/user目录:
find -iname "*txt*" -exec mv -v {} /home/user \;

59.将文件按行并列显示：
paste test.txt test1.txt

60.shell里的进度条:
pv data.log

61.使用netcat将数据发送到Graphite server:
echo "hosts.sampleHost 10 `date +%s`" | nc 192.168.200.2 3000

62.将tabs转换成空格：
expand test.txt > test1.txt

63.Skip bash history:
< space >cmd

64.去之前的工作目录：
cd -

65.拆分大体积的tar.gz文件(每个100MB)，然后合并回去：
split –b 100m /path/to/large/archive /path/to/output/files
cat files* > archive

66.使用curl获取HTTP status code:
curl -sL -w "%{http_code}\\n" www.example.com -o /dev/null

67.设置root密码，强化MySQL安全安装:
/usr/bin/mysql_secure_installation

68.当Ctrl + c不好使时:
Ctrl + \

69.获取文件owner:
stat -c %U file.txt

70.block设备列表：
lsblk -f

71.找出文件名结尾有空格的文件：
find . -type f -exec egrep -l " +$" {} \;

72.找出文件名有tab缩进符的文件
find . -type f -exec egrep -l $'\t' {} \;

73.用”=”打印出横线:全选复制放进笔记
printf '%100s\n' | tr ' ' =

``` 
