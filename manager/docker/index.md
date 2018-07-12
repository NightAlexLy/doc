---
title: Docker
---

　　[Docker](https://baike.baidu.com/item/Docker) 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。


## 架构

|     组件	|   功能描述  | 
| :--------: | :--------:|
| Docker 镜像(Images)	   |   用于创建 Docker 容器的模板。 |
| Docker 容器(Container)	   |   独立运行的一个或一组应用。 |
| Docker 客户端(Client)	   |   客户端通过命令行或者其他工具使用 Docker API (https://docs.docker.com/reference/api/docker_remote_api) 与 Docker 的守护进程通信。 |
| Docker 主机(Host)	   |   一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。 |
| Docker 仓库(Registry)	   |   仓库用来保存镜像，可以理解为代码控制中的代码仓库。<br/>Docker Hub(https://hub.docker.com) 提供了庞大的镜像集合供使用。 |
| Docker Machine	   |   Docker Machine是一个简化Docker安装的命令行工具，通过一个简单的命令行即可在相应的平台上安装Docker，比如VirtualBox、 Digital Ocean、Microsoft Azure。 |


![Docker组件](http://www.runoob.com/wp-content/uploads/2016/04/576507-docker1.png)
![Docker命令](http://www.runoob.com/docker/docker-command-manual.html)

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

## 安装redis

[Docker安装redis](http://www.runoob.com/docker/docker-install-redis.html)

```
# docker search  redis

runoob@runoob:~/redis$ docker search  redis
NAME                      DESCRIPTION                   STARS  OFFICIAL  AUTOMATED
redis                     Redis is an open source ...   2321   [OK]       
sameersbn/redis                                         32                   [OK]
torusware/speedus-redis   Always updated official ...   29             [OK]
bitnami/redis             Bitnami Redis Docker Image    22                   [OK]
anapsix/redis             11MB Redis server image ...   6                    [OK]
webhippie/redis           Docker images for redis       4                    [OK]
clue/redis-benchmark      A minimal docker image t...   3                    [OK]
williamyeh/redis          Redis image for Docker        3                    [OK]
unblibraries/redis        Leverages phusion/baseim...   2                    [OK]
greytip/redis             redis 3.0.3                   1                    [OK]
servivum/redis            Redis Docker Image            1                    [OK]

# docker pull  redis:3.2

运行镜像
# docker run -p 6379:6379 -v $PWD/data:/data  -d redis:3.2 redis-server --appendonly yes


查看容器运行情况
# docker ps

停止容器服务
#docker kill -s KILL mynginx

连接redis-client
# docker exec -it 容器进行ID redis-cli

查看镜像
# docker images ls


删除镜像
# docker rmi -f IMAGE ID

```

## 资料

- [Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)
- [Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)
- [CentOS Docker 安装](http://www.runoob.com/docker/centos-docker-install.html)
- [Docker命令](http://www.runoob.com/docker/docker-command-manual.html)

