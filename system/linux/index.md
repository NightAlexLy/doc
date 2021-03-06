---
title: Linux
---

## Command

- [常用命令](command/index.html)
- [Vi](command/vi.html)
- [压缩](command/compress.html)
- [文件](command/file.html)
- [搜索](command/search.html)
- [权限](command/shutdown.html)
- [网络](command/network.html)
- [重启/关机](command/shutdown.html)
- [帮助](command/help.html)

## Shell

- [hexo-cmd](shell/hexmo-cmd.html)
- [hexo-deploy](shell/hexo-deploy.html)
- [统计Nginx错误Code数量](shell/nginx-error.html)
- [系统信息监控脚本](shell/system-monitor.html)

## Software

- [ansible](software/ansible.html)
- [ansible-tower](software/ansible-tower.html)
- [activemq](software/activemq.html)
- [kafka](software/kafka.html)
- [tomcat](software/tomcat.html)
- [zookeeper](software/zookeeper.html)
- [fastdfs](software/fastdfs.html)
- [vsftpd](software/ftp.html)
- [sftp](software/sftp.html)
- [subversion](software/subversion.html)
- [rabbitmq](software/rabbitmq.html)
- [redis](software/redis.html)
- [jdk](software/jdk.html)
- [jenkins](software/jenkins.html)
- [metaq](software/metaq.html)
- [maven](software/maven.html)
- [mysql](software/mysql.html)
- [nginx](software/nginx.html)
- [haproxy](software/haproxy.html)
- [keepalived](software/keepalived.html)
- [other](software/other.html)

## Article

- [Linux开机自启动](article/startup.html)

## Issue

### Crontab执行时效

```
crontab定时执行脚本的时候，可能由于环境的缺失导致执行失败。

可以在脚本的执行的开头添加如下代码：

./etc/profile    #因为我的环境设置都在这个配置文件中

```
