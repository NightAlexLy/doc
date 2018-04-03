---
title: Docker
---

　　[Docker](https://baike.baidu.com/item/Docker) 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。


## 安装

```
	yum -y install docker

启动服务：
	centOS 6: 
		service docker start
	centOS 7:
		systemctl start docker.service

查看服务：
	centOS 6: 
		service docker status
	centOS 7:
		systemctl status docker.service



```


## 资料

- [Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)
- [Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)