---
title: Ansible Install
---

### Ansible介绍
　　[Ansible](http://www.ansible.com.cn/)是一个简单的自动化运维管理工具，可以用来自动化部署应用、配置、编排 task(持续交付、无宕机更新等)，采用 paramiko 协议库（fabric 也使用这个）。           
![Ansbile](http://ore2d9chp.bkt.clouddn.com/ansible.png)            
### 安装环境及介质      
安装版本：Ansible 1.7.2           
操作系统：Linux xxx 3.10.0-327.36.3.el7.x86_64 #1 SMP Mon Oct 24 16:09:20 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux           
虚拟机镜像：CentOS-6.6-x86_64-bin-DVD1.iso        
系统配置：1C(core)/1G(mem)/8G(disk)              
介质：          
　　[ansible-1.7.2.tar.gz](https://github.com/ansible/ansible/archive/v1.7.2.tar.gz)
　　[ecdsa-0.11.tar.gz](https://pypi.python.org/packages/source/e/ecdsa/ecdsa-0.11.tar.gz)
　　[Jinja2-2.7.3.tar.gz](https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.7.3.tar.gz)
　　[MarkupSafe-0.9.3.tar.gz](https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.9.3.tar.gz)
　　[paramiko-1.15.1.tar.gz](https://pypi.python.org/packages/source/p/paramiko/paramiko-1.15.1.tar.gz)
　　[pycrypto-2.6.1.tar.gz](https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.1.tar.gz)
　　[Python-2.7.8.tgz](https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz)
　　[PyYAML-3.11.tar.gz](https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.11.tar.gz)
　　[setuptools-7.0.tar.gz](https://pypi.python.org/packages/source/s/setuptools/setuptools-7.0.tar.gz)
　　[simplejson-3.6.5.tar.gz](https://pypi.python.org/packages/source/s/simplejson/simplejson-3.6.5.tar.gz)
　　[yaml-0.1.5.tar.gz](http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz)

### 开始安装
　　2.1 Python2.7安装
```
$  tar –zxvf Python-2.7.8.tgz
$  cd Python-2.7.8
$  ./configure –prefix=/usr/local
$  make --jobs=`grep processor /proc/cpuinfo | wc -l`
$  make install
```
　　**将python头文件拷贝到标准目录，以避免编译ansible时，找不到所需的头文件**
```
$  cd /usr/local/include/python2.7
$  cp -a ./* /usr/local/include/
```
　　**备份旧版本的python，并符号链接新版本的python**
```
$  cd /usr/bin
$  mv python python2.6
$  ln -s /usr/local/bin/python
```
　　**修改yum脚本，使其指向旧版本的python，已避免其无法运行**
```
$  vim /usr/bin/yum
  !/usr/bin/python  -->  #!/usr/bin/python2.6    (将Python改成Python2.6)
```
　　2.2 python-setuptools模块安装
```
$  tar -zxvf setuptools-7.0.tar.gz 
$  cd setuptools-7.0
$  python setup.py install 
```
　　2.3 python-pycrypto模块安装
```
$  tar -zxvf pycrypto-2.6.1.tar.gz
$  cd pycrypto-2.6.1
$  python setup.py install 
```
　　2.4 python-PyYAML模块安装
```
$  tar -zxvf yaml-0.1.5.tar.gz
$  cd yaml-0.1.5
$  ./configure --prefix=/usr/local
$  make --jobs=`grep processor /proc/cpuinfo | wc -l`
$  make install
```
```
$  tar -zxvf PyYAML-3.11.tar.gz
$  cd PyYAML-3.11
$  python setup.py install 
```
　　2.5 python-Jinja2模块安装
```
$  tar -zxvf MarkupSafe-0.9.3.tar.gz
$  cd MarkupSafe-0.9.3
$  python setup.py install
```
```
$  tar -zxvf Jinja2-2.7.3.tar.gz
$  cd Jinja2-2.7.3
$  python setup.py install
```
　　2.6 python-paramiko模块安装
```
$  tar -zxvf ecdsa-0.11.tar.gz
$  cd ecdsa-0.11
$  python setup.py install

$  tar -zxvf paramiko-1.15.1.tar.gz
$  cd paramiko-1.15.1
$  python setup.py install
```
　　2.7 python-simplejson模块安装
```
$  tar -zxvf simplejson-3.6.5.tar.gz
$  cd simplejson-3.6.5
$  python setup.py install
```
　　2.8 python-ansible模块安装
```
$  tar -zxvf ansible-1.7.2.tar.gz
$  cd ansible-1.7.2
$  python setup.py install
```
3.	配置及测试
　　3.1 配置
　　**SSH免密钥登录设置**
```
$  ssh-keygen -t rsa -P ''
```
　　** ansible配置**
```
$   mkdir -p /etc/ansible
$   touch /etc/ansible/ansible.cfg
$   vim /etc/ansible/ansible.cfg
粘贴如下内容：
	[defaults]
	inventory      = /etc/ansible/hosts
	sudo_user=root
	remote_port=22
	host_key_checking=False
	remote_user=root
	log_path=/var/log/ansible.log
	module_name=command
	private_key_file=/root/.ssh/id_rsa
	no_log:True
```
```
$  touch /etc/ansible/hosts
$  vim /etc/ansible/hosts
粘贴如下内容：
[test]
192.168.91.137
```
　　3.2 测试
```
$  ansible test -m ping
```
4. 参考文章

- [Ansible官网全模块文档](http://docs.ansible.com/ansible/list_of_all_modules.html)
- [自动化运维工具Ansible详细部署](http://sofar.blog.51cto.com/353572/1579894/)
- [ansible快速上手](https://linuxtoy.org/archives/hands-on-with-ansible.html)
- [Ansible:自动化工具](http://rangochen.blog.51cto.com/2445286/1425276)
- [自动化工具ansible中文指南](http://www.aikaiyuan.com/6299.html)
- [运维自动化之ansibleplaybook安装nginx](http://dl528888.blog.51cto.com/2382721/1438847)
- [Ansible之安装部署及常用模块的使用介绍](http://yanshisan.blog.51cto.com/7879234/138440)
- [Ansible状态管理](http://xdays.info/ansible%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86.html)
- [ansible学习笔记（二）初始化操作系统：ansible变量使用](http://laowafang.blog.51cto.com/251518/1418471)