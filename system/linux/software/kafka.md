---
title: Kafka Install
---

 **特别说明**
 
 　　1.  JDK的版本：**jdk-7u79-linux-x64.tar.gz**
 　　2.  安装路径：**/opt/java**
 　　3.  安装用户：**root**

### 安装Jdk

　　参考[JDK](/system/linux/software/jdk.html)安装流程

### 安装Zookeeper

　　参考[Zookeeper](/system/linux/software/zookeeper.html)安装流程

### 基础介绍
```
producer：消息生产者，发布消息到 kafka 集群的终端或服务。
broker：kafka 集群中包含的服务器。
topic：每条发布到 kafka 集群的消息属于的类别，即 kafka 是面向 topic 的。
partition：partition 是物理上的概念，每个 topic 包含一个或多个 partition。kafka 分配的单位是 partition。
consumer：从 kafka 集群中消费消息的终端或服务。
Consumer group：high-level consumer API 中，每个 consumer 都属于一个 consumer group，每条消息只能被 consumer group 中的一个 Consumer 消费，但可以被多个 consumer group 消费。
replica：partition 的副本，保障 partition 的高可用。
leader：replica 中的一个角色， producer 和 consumer 只跟 leader 交互。
follower：replica 中的一个角色，从 leader 中复制数据。
controller：kafka 集群中的其中一个服务器，用来进行 leader election 以及 各种 failover。
zookeeper：kafka 通过 zookeeper 来存储集群的 meta 信息。
```

### 安装Kafka

```
	cd /opt
	wget http://archive.apache.org/dist/kafka/0.11.0.0/kafka_2.12-0.11.0.0.tgz
	tar -xzf kafka_2.12-0.11.0.0.tgz

目录结构：
	bin  存放执行命令
	conf 存放配置文件
	libs 依赖文件
	logs 存放日志文件
	site-docs   文档

	cd kafka_2.12-0.11.0.0

启动Kafka自带的Zookeeper
	./bin/zookeeper-server-start.sh config/zookeeper.properties

启动Kafka服务
	./bin/kafka-server-start.sh config/server.properties 

创建Topic
	./binkafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --p artitions 1 --topic test Created topic "test". 

查看创建的Topic
	./bin/kafka-topics.sh --list --zookeeper localhost:2181 test 

发送消息
	./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test >this is a message >this is another message > >this is third message 

消费消息
	./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning this is a message this is another message this is third message 

配置集群
	拷贝conf/server.properties. 
	修改broker.id
		listeners
		log.dir
	通过启动kafka命令， 后面不同的server.properties文件


```

### FAQ

- 启动异常Unsupported major.minor version 52.0              
　　Java版本过低，切换环境变量中JDK版本为JDK8。              

- 启动时报目录名、文件名或卷标语法不正确               
　　检查JAVA_HOME、kafka安装目录路径中是否带有空格，如果有空格，尝试换一个没有空格的目录安装。另，如果安装目录是C:\Program Files，可以使用该目录别名C:\PROGRA~1消除空格            

### 资料

- [官网文档](http://kafka.apache.org/intro)
