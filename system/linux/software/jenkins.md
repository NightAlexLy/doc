---
title: Jenkins Install
---

　　[Jenkins](https://jenkins.io/)是一个开源软件项目，是基于Java开发的一种持续集成工具，用于监控持续重复的工作，旨在提供一个开放易用的软件平台，使软件的持续集成变成可能。         


　　Jenkins是基于Java开发。安装之前需要在服务器构建[Java环境](/linux_software/jdk.html)。        

### 安装Jenkins
#### 1.离线安装
```
## http://pkg.jenkins-ci.org/redhat/
wget http://pkg.jenkins-ci.org/redhat/jenkins-2.120-1.1.noarch.rpm ## 下载(也可以Windows下载再转过来)
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins.io.key ## 公钥
sudo yum -y install jenkins-*.noarch.rpm
```
#### 2.在线安装
```
## http://pkg.jenkins-ci.org/redhat/
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum -y install jenkins
```
#### 3.基于Tomcat安装
　　先安装[Tomcat环境](/linux_software/tomcat.html)。         
	官网[jenkins.war](http://mirrors.jenkins.io/war/latest/jenkins.war)         
```
从官网下载 jenkins.war 至 $CATALINA_BASE/webapps，Tomcat 会自动部署；
浏览器访问：http://centos:8080/jenkins/
```
#### 4.免安装
```
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
sudo java -jar jenkens.war ## 启动服务，直至看到日志 `Jenkins is fully up and running`
curl http://localhost:8080/ ## Jenkins 已就绪
```
#### 5.卸载服务
```
sudo systemctl stop jenkins
sudo systemctl disable jenkins
sudo yum -y remove jenkins
sudo rm -rf /var/{lib,log,cache}/jenkins /usr/lib/jenkins /root/.jenkins
sudo rm -rf `sudo find /{etc,var,run} -name "jenkins*"`
```
### 启动服务

　　建议采用第一种服务的方式安装。                
　　jenkins的默认安装目录`/var/lib/jenkins`                      
　　　　项目存放在`/var/lib/jenkins/workspace`下               
　　　　核心配置文件`/etc/sysconfig/jenkins`                     
　　　　日志文件`/var/log/jenkins/jenkins.log`                    
　　　　用户配置文件`/var/lib/jenkinis/users/xxx/config.xml`                  

```
sudo systemctl start jenkins.service  #启动
sudo systemctl stop jenkins.service  #停止
sudo systemctl restart jenkins.service  #重启

jenkins启动以来java命令。如果命令不存在会报错。

journalctl -ex 查看服务启动日志

```
### 其他设置
`系统管理->管理插件`
- Ant Plugin
- Subversion Plug-in
- Git plugin
- Deploy to container Plugin
- Maven Integration plugin
- Folders Plugin
- Checkstyle Plug-in
- FindBugs Plug-in
- PMD Plug-in
- Publish Over SSH
- SSH plugin

`系统管理->全局工具配置`
设置
　　Maven Configuration
设置
　　JDK
设置
　　Maven

### Issue
```
QA :  Jenkins中Git Timeout错误
解决办法：git项目配置的时候，设置git clone的时间为60分钟，避免超时。
Solution steps:
　　1.For resolve the problem we have to edit in Jenkins project configuration and find the "git".
　　2.Then click on "Add" button and select "Advanced clone behaviours".
　　3.Then in Timeout (in minutes) for clone and fetch operations box put any number which is more then 10, (I put 60 here).
　　4.Apply and the save the configuration.
　　5.Build Now again , It took some more time to build , but it will fixed this error.
```

### 资料

- [jenkins安装包](http://pkg.jenkins-ci.org/redhat/)
- [Jenkins 持续集成综合实战](https://blog.csdn.net/kefengwang/article/details/54233584)
- [Jenkins权限配置不对导致进不去Jenkins的解决方法](https://www.cnblogs.com/zhangshimin/articles/5508661.html)
- [Jenkins常用插件之Deploy Plugin](https://blog.csdn.net/jiang1986829/article/details/51173251)
- [Jenkins 忘记admin密码拯救方法](https://www.cnblogs.com/huangenai/p/7416322.html)
- [Jenkins+Maven进行Java项目持续集成](https://blog.csdn.net/jiangfuqiang/article/details/38497461)