---
title: Keepalived Install
---

### 系统信息
```
uname -a
Linux localhost.localdomain 2.6.32-504.el6.x86_64 #1 SMP Wed Oct 15 04:27:16 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

My服务器信息
内存：512M   硬盘：20G
操作系统：Linux Cent OS 6.6 64位
安装路径：/opt
安装用户： root
```

### 卸载&安装Keepalived的依赖包
```
卸载：
rpm -ivh keyutils-libs-devel-1.4-5.el6.x86_64.rpm
rpm -ivh openssl098e-0.9.8e-18.el6_5.2.x86_64.rpm
rpm -ivh perl-WWW-Curl-4.09-4.el6.x86_64.rpm
rpm -ivh zlib-devel-1.2.3-29.el6.x86_64.rpm

rpm -e e2fsprogs-libs-1.41.12-21.el6.x86_64 --nodeps
rpm -ivh e2fsprogs-libs-1.41.12-22.el6.x86_64.rpm
e2fsprogs-libs-1.41.12-22.el6.x86_64.rpm
rpm -e libcom_err-1.41.12-21.el6.x86_64 --nodeps
rpm -ivh libcom_err-1.41.12-22.el6.x86_64.rpm
  --->libcom_err-1.41.12-22.el6.x86_64.rpm
rpm -e e2fsprogs-1.41.12-21.el6.x86_64 --nodeps
rpm -ivh e2fsprogs-1.41.12-22.el6.x86_64.rpm
e2fsprogs-1.41.12-22.el6.x86_64.rpm
  rpm -e libss-1.41.12-21.el6.x86_64 --nodeps
  rpm -ivh libss-1.41.12-22.el6.x86_64.rpm
  --->libss-1.41.12-22.el6.x86_64.rpm
rpm -e krb5-libs-1.10.3-33.el6.x86_64 --nodeps
rpm -ivh krb5-libs-1.10.3-42.el6.x86_64.rpm
 
krb5-devel-1.10.3-42.el6.x86_64.rpm
  libcom_err-devel
    rpm -ivh libcom_err-devel-1.41.12-22.el6.x86_64.rpm
  libselinux-devel
    rpm -ivh libselinux-devel-2.0.94-5.8.el6.x86_64.rpm
  libsepol-devel       
    rpm -ivh libsepol-devel-2.0.41-4.el6.x86_64.rpm
    
rpm -e openssl-1.0.1e-30.el6.x86_64 --nodeps
rpm -ivh openssl-1.0.1e-42.el6_7.2.x86_64.rpm
rpm -ivh krb5-devel-1.10.3-42.el6.x86_64.rpm
rpm -ivh openssl-devel-1.0.1e-42.el6_7.2.x86_64.rpm
rpm -ivh openssl-perl-1.0.1e-42.el6_7.2.x86_64.rpm
rpm -ivh openssl-static-1.0.1e-42.el6_7.2.x86_64.rpm
rpm -ivh ipvsadm-1.26-4.el6.x86_64.rpm
rpm -ivh libnl-devel-1.1.4-2.el6.x86_64.rpm
rpm -ivh popt-devel-1.13-7.el6.x86_64.rpm
rpm -ivh popt-static-1.13-7.el6.x86_64.rpm
```

### keepalived安装信息
```
Keepalived的日志路径：/var/log/message
安装目录：/usr/local/keepalived
配置文件地址：/etc/keepalived/keepalived.conf
```

### 开始安装
```
1. 安装依赖
yum install openssl*  -y
yum install popt*  -y
yum install ipvsadm -y
yum install libnl-dev* -y

2. 下载keepalived安装包
wget http://www.keepalived.org/software/keepalived-1.2.16.tar.gz

3. 解压
tar –zxvf  keepalived-1.2.16.tar.gz

4. 配置编译信息
./configure --prefix=/usr/local/keepalived
  编译配置需要确保一下几项为Yes状态：
  Use IPVS Framework : Yes
  IPVS sync daemon support : Yes
  IPVS use libnl : Yes
  Use VRRP Framework : Yes

4. 编译安装
make && make install

5. 复制keepalived启动文件到默认路径，也可以通过设置环境变量的path实现
cp /usr/local/keepalived/sbin/keepalived /usr/sbin/

6. 复制服务启动脚本到，以便可以通过service控制keepalived服务
cp /usr/local/keepalived/etc/rc.d/init.d/keepalived /etc/init.d/

7. 复制keepalived服务脚本到默认的地址，也通过修改init.d/keepalived文件中的相应配置实现
cp /usr/local/keepalived/etc/sysconfig/keepalived /etc/sysconfig/

8. 复制默认配置文件到默认路径，其实也可以在/etc/init.d/keepalived中设置路径
cp /usr/local/keepalived/etc/keepalived/keepalived.conf /etc/keepalived/

9. 设置开机启动
chkconfig keepalived on【可执行可不执行】

```

### 配置Keepalived
```
vi /etc/keepalived/keepalived.conf

1.主服务器
global_defs
{
notification_email    #通知email，根据实际情况配置
{
admin@example.com
}
notification_email_from admin@example.com
smtp_server 127.0.0.1
stmp_connect_timeout 30
router_id node1         #节点名标识，主要用于通知中
}
 
vrrp_instance VI_NODE {
  state MASTER          #配置为主服务器
  interface eth0        #通讯网卡
  virtual_router_id 100 #路由标识
  priority 200          #优先级，0-254
  advert_int 5          #通知间隔，实际部署时可以设置小一点，减少延时
   
  authentication {
    auth_type PASS
    auth_pass 123456    #验证密码，用于通讯主机间验证
  }
 
  virtual_ipaddress {
    192.168.26.120       #虚拟ip，可以定义多个
  }
}

2. 从服务器
global_defs {
  notification_email {
    admin@example.com
  }
  notification_email_from admin@example.com
  smtp_server 127.0.0.1
  stmp_connect_timeout 30
  router_id node2
}
 
vrrp_instance VI_NODE {
  state BACKUP           #与主服务器对应
  interface eth0         #从服务器的通信网卡
  virtual_router_id 100  #路由标识，和主服务器相同
  priority 100           #优先级，小于主服务器即可
  advert_int 5           #这里是接受通知间隔，与主服务器要设置相同
   
  authentication {
   auth_type PASS
    auth_pass 123456     #验证密码，与主服务器相同
  }
   
  virtual_ipaddress {
    192.168.26.120        #虚拟IP，也要和主服务器相同
  }
}

上面的设置是最基础的设置，实现的功能是如果主服务器的Keepalived停止服务（一般情况下服务器宕机），则将虚拟IP切换至从服务器，主服务器恢复后从新切换回主服务器。
注意点：
  1. 
virtual_ipaddress必须配置一致
  2. 
adver_int的时间必须配置一致
  3. 
当主重启启动的时候，必须将主的有限级降低一点。
```

### 启动
```
1. 关闭防火墙
service  iptables stop

2. 启动主的keepalived
service  keepalived start
  成功日志：
  Jan 13 01:21:58 localhost Keepalived_healthcheckers[10544]: Netlink reflector reports IP 192.168.26.120 added
  Jan 13 01:21:58 localhost Keepalived_vrrp[10545]: VRRP_Instance(VI_NODE) Sending gratuitous ARPs on eth0 for 192.168.26.120
查看IP是否绑定成功：
ip a show|awk '/inet\ /'
如:
[root@localhost ~]# ip a show|awk '/inet\ /'
            inet 127.0.0.1/8 scope host lo
            inet 192.168.26.130/24 brd 192.168.26.255 scope global eth0
          inet 192.168.26.120/32 scope global eth0
绑定成功！！！！

3. 启动从的keepalived
Service  keepalived start
启动成功日志：
Jan 13 01:25:55 localhost Keepalived_vrrp[6115]: VRRP_Instance(VI_NODE) Sending gratuitous ARPs on eth0 for 192.168.26.120
Jan 13 01:25:55 localhost Keepalived_healthcheckers[6114]: Netlink reflector reports IP 192.168.26.120 added

4.查看IP漂移
杀死主服务器：
Service  keepalived stop  |   killall keepalived
主的日志：
Jan 13 01:25:54 localhost Keepalived_healthcheckers[10544]: Netlink reflector reports IP 192.168.26.120 removed
从的日志：
Sending gratuitous ARPs on eth0 for 192.168.26.120
Jan 13 01:25:55 localhost Keepalived_healthcheckers[6114]: Netlink reflector reports IP 192.168.26.120 added

5.重新启动主keepalived不影响从运行
重新修改主的keepalived.conf文件
设置virtual_router_id的优先级小于从的优先级既可。
重启服务：service keepalived start

```

### ISSUS

- QA： ./keepalived –f  keepalived.conf导致启动的时候卡住
日志报错：
Jan 13 00:24:56 localhost Keepalived_healthcheckers[5596]: Using LinkWat
ch kernel netlink reflector...
日志停止
解决办法：**后面keepalived.conf配置为绝对路径。**
- QA： 采用绝对路径的方式执行过去有可能还会卡住。
Jan 13 00:36:11 localhost Keepalived_vrrp[10051]: VRRP_Instance(VI_NODE) Transition to MASTER STATE
Jan 13 00:36:12 localhost Keepalived_vrrp[10051]: VRRP_Instance(VI_NODE) Entering MASTER STATE
解决办法：采用服务的方式，service keepalived start。
QA：路由标识不一致时，导致启动失败。
Jan 13 00:37:34 localhost Keepalived_vrrp[5725]: ip address associated with VRID not present in received packet : 192.168.26.200
Jan 13 00:37:34 localhost Keepalived_vrrp[5725]: one or more VIP associated with VRID mismatch actual MASTER advert
Jan 13 00:37:34 localhost Keepalived_vrrp[5725]: bogus VRRP packet received on eth0 !!!
Jan 13 00:37:34 localhost Keepalived_vrrp[5725]: VRRP_Instance(VI_NODE) ignoring received advertisment...
解决办法：从服务器和主服务器之间的路由标识要配置相同。
比如
/etc/keepalived/keepalived.conf
     virtual_router_id 60 主从方都要改，默认为51
- QA： 通知时间不一致，导致启动失败
Jan 13 00:50:30 localhost Keepalived_vrrp[5824]: VRRP_Instance(VI_NODE) Dropping received VRRP packet...
Jan 13 00:50:31 localhost Keepalived_vrrp[5824]: advertissement interval mismatch mine=5000000 rcved=1
Jan 13 00:50:31 localhost Keepalived_vrrp[5824]: Sync instance needed on eth0 !!!
解决办法：修改主和从的配置文件的时间，重启服务既可。
比如：
/etc/keepalived/keepalived.conf
将通知时间**advert_int修改为一致即可**。