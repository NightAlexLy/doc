---
title: Ansbile-Tower Install
---

### 资源

```
ansible-tower-setup-bundle-2.4.3-1.el7.tgz，
lisence.rtf，
rpm-gpg.zip，
task_engine.pyo，
tower-bundle.zip，
xlrd-0.9.4.tar.gz，
get_inventory.py，
projects.zip
```
### 安装Tower

拷贝至Tower服务器/root目录下。
```
[root@hostname]# yum install -y unzip
[root@hostname]# unzip tower-bundle.zip -d /var/lib
[root@hostname]# unzip -o rpm-gpg.zip -d /etc/pki/
[root@hostname]# tar -zxvf xlrd-0.9.4.tar.gz 
[root@hostname]# cd xlrd-0.9.4
[root@hostname]# python setup.py install
[root@hostname]# cd ~
[root@hostname]# tar -zxvf ansible-tower-setup-bundle-2.4.3-1.el7.tgz 
[root@hostname]# cd ansible-tower-setup-bundle-2.4.3-1.el7
[root@hostname]# ./configure
	执行这个文件：./configure,会交互式收集安装信息，按照如下顺序应答：
		第一个问题：回车
		第二个问题：i
		第三个问题：redhat
		确认密码：redhat
		第四个问题：y
[root@hostname]#  ./setup.sh


[root@hostname]#  cd ~
[root@hostname]#  cp get_inventory.py /var/lib/awx
[root@hostname]#  ssh-keygen -t rsa -P ''
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):   【回车】
Created directory '/root/.ssh'.
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
4b:d1:b8:eb:b9:79:93:1e:a7:6d:07:33:32:14:74:d1 root@i-psx9pwbx
The key's randomart image is:
+--[ RSA 2048]----+
|         .. oo   |
|         o..  E  |
|        o ..     |
|         o.      |
|        S.       |
|       . oo +    |
|        o .+.+   |
|       . o+=. .  |
|        =+oo..   |
+-----------------+
[root@hostname]#  cp task_engine.pyo /usr/lib/python2.7/site-packages/awx/main/task_engine.pyo   [提示覆盖，请输入Y]
[root@hostname]#  chmod 755 /var/lib/awx/get_inventory.py
[root@hostname]#  unzip -o projects.zip -d /var/lib/awx/
[root@hostname]#  systemctl restart httpd

在浏览器中输入本机IP访问
```

