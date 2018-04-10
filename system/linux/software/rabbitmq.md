---
title: RabbitMQ Install
---


### 安装

```
  cd /opt
  wget http://www.rabbitmq.com/releases/erlang/erlang-19.0.4-1.el7.centos.x86_64.rpm
  wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.4/rabbitmq-server-3.7.4-1.el7.noarch.rpm

  yum install socat.x86_64  -y
  rpm -ivh erlang-19.0.4-1.el7.centos.x86_64.rpm
  rpm -ivh rabbitmq-server-3.7.4-1.el7.noarch.rpm
```

### 资料

- [官网文档](http://previous.rabbitmq.com/v3_6_x/documentation.html)
- [Java示例](http://www.rabbitmq.com/tutorials/tutorial-one-java.html)
- [RabbitMQ的应用场景以及基本原理介绍](https://blog.csdn.net/whoamiyang/article/details/54954780)
- [RabbitMQ系列(一)：Windows下RabbitMQ安装及入门](https://blog.csdn.net/hzw19920329/article/details/53156015)
- [Centos7安装Rabbitmq](https://blog.csdn.net/zhouyongku/article/details/53676837)
- [python3之rabbitMQ](https://www.cnblogs.com/zhangxinqi/p/8460768.html)
- [RabbitMQ config](http://www.rabbitmq.com/configure.html)
- [Authentication failed (rejected by the remote node)](https://blog.csdn.net/j_shine/article/details/78833456)
