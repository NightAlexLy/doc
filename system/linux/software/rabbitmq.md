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