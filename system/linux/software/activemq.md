---
title: ActiveMQ Install
---
 
![activemq](http://ore2d9chp.bkt.clouddn.com/activemq_config.png)

### 安装Jdk

　　参考[JDK](/system/linux/software/jdk.html)安装流程

### 安装ActiveMQ

```
[root@localhost ~]#  tar -zxvf apache-activemq-5.11.0.redhat-621084-bin.zip
[root@localhost ~]#  cd apache-activemq-5.11.0.redhat-621084
[root@localhost ~]#  vi conf/users.properties
将#admin=admin这行前的注释去除
[root@localhost ~]#  vi conf/groups.properties
将#admins=admin这行前的注释去除
[root@localhost ~]   vi conf/activemq.xml
1.开JMX远程管理功能：
	broker标签 添加 “useJmx="true"”
2.managementContext修改为：
	<managementContext>
	       <managementContext createConnector="true" connectorPort="11099"/>
	</managementContext>
3.添加MySQL持久化方式
	<persistenceAdapter> 
	  <jdbcPersistenceAdapter dataDirectory="${activemq.base}/data" dataSource="#mysql-ds" lockKeepAlivePeriod="5000" > 
	    <locker>
	      <lease-database-locker lockAcquireSleepInterval="10000"/>
	    </locker>
	  </jdbcPersistenceAdapter> 
	</persistenceAdapter>
4.添加Mysql的Bean
  <bean id="mysql-ds" class="org.apache.commons.dbcp2.BasicDataSource" destroy-method="close">
    <property name="driverClassName" value="com.mysql.jdbc.Driver"/>
    <property name="url" value="jdbc:mysql://192.168.1.123:3306/mq?relaxAutoCommit=true"/>
    <property name="username" value="root"/>
    <property name="password" value="123456"/>
    <property name="maxTotal" value="200"/>
    <property name="poolPreparedStatements" value="true"/>
  </bean>
5.添加virtualTopic
	<destinationIterceptors>
	  <virtualDestinationInterceptor>
	<virtualDestinations>
	  <virtualTopic name=">" prefix="Foo.*." selectorAware="false"/>
	</virtualDestinations>
	  </virtualDestinationInterceptor>
	</destinationInterceptors> 
6.添加免密认证
	plugins标签下添加如下内容：
	<simpleAuthenticationPlugin anonymousAccessAllowed="true">
	<users> 
	<authenticationUser username="admin" password="admin" 
	groups="users,admins"/> 
	</users> 
	</simpleAuthenticationPlugin> 
	<!--  Lets configure a destination based authorization mechanism --> 
	<authorizationPlugin> 
	<map> 
	  <authorizationMap> 
	<authorizationEntries> 
	  <authorizationEntry queue=">" read="admins,anonymous" write="admins,anonymous" admin="admins,anonymous" /> 
	  <authorizationEntry topic=">" read="admins,anonymous" write="admins,anonymous" admin="admins,anonymous" /> 
	  <authorizationEntry topic="ActiveMQ.Advisory.>" read="guests,users,anonymous" write="guests,users,anonymous" admin="guests,users,anonymous"/> 
	</authorizationEntries> 
	  </authorizationMap> 
	</map> 
	</authorizationPlugin>
[root@localhost ~]  vi /etc/hosts
添加如下：
主机IP    主机名（通过hostname可以得到）

```

### ActiveMQ Config

![activemq-config](http://ore2d9chp.bkt.clouddn.com/activemq_conf.png)

### 资料

- [ActiveMQ持久化方式](https://blog.csdn.net/kobejayandy/article/details/50736479)
- [ActiveMQ的几种消息持久化机制](https://yq.aliyun.com/articles/38433)

### 错误排查

```
INFO: Loading '/opt/activemq/bin/env'
INFO: Using java '/opt/jdk/bin/java'
INFO: Starting in foreground, this is just for debugging purposes (stop process by pressing CTRL+C)
Java HotSpot(TM) 64-Bit Server VM warning: INFO: os::commit_memory(0x00000000d0350000, 715849728, 0) failed; error='Cannot allocate memory' (errno=12)
#
# There is insufficient memory for the Java Runtime Environment to continue.
# Native memory allocation (malloc) failed to allocate 715849728 bytes for committing reserved memory.
# An error report file with more information is saved as:
# /opt/activemq/bin/hs_err_pid3332.log

```
**解决办法** : ：export ACTIVEMQ_OPTS="-Xmx256M -Xms128M"
-Xms1G -Xmx1G
```
javax.jms.JMSException: Failed to build body from content. Serializable class not available to broker. Reason: java.lang.ClassNotFoundException: Forbidden class com.ibm.mq.api.MqEventBean! This class is not allowed to be serialized. Add package with 'org.apache.activemq.SERIALIZABLE_PACKAGES' system property.
at org.apache.activemq.util.JMSExceptionSupport.create(JMSExceptionSupport.java:36)
at org.apache.activemq.command.ActiveMQObjectMessage.getObject(ActiveMQObjectMessage.java:193)
```
```
如果本地测试可以通过：System.setProperty("org.apache.activemq.SERIALIZABLE_PACKAGES","*");
dubbo服务部署需要添加：
-Dorg.apache.activemq.SERIALIZABLE_PACKAGES=*
tomcat部署需要在catalina.sh添加如下内容：
JAVA_OPTS="$JAVA_OPTS -Dorg.apache.activemq.SERIALIZABLE_PACKAGES=*"
```

检查AMQ问题：
　　1.执行生产者produce代码，看Queue/Topic是否发布成功。
　　2.检查AMQ默认的控制台，查看消息是否存在。并且条数是否增加。
　　3.如果消息发布成功，调用消费者的代码。看是否可以打印一些消费信息。基本日志。
 
核心点：
　　1.生产者和消费者的topic名字是否一致。
　　2.控制台上面的消息是否增加或者消费。
