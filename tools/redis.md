---
title: Redis
---

## 常用命令
```
1 ） 连接操作命令
    quit： 关闭连接（ connection）
    auth： 简单密码认证
    help cmd： 查看cmd帮助， 例如： help quit
2） 持久化
    save： 将数据同步保存到磁盘
    bgsave： 将数据异步保存到磁盘
    lastsave： 返回上次成功将数据保存到磁盘的Unix时戳
    shundown： 将数据同步保存到磁盘， 然后关闭服务
3） 远程服务控制
    info： 提供服务器的信息和统计
    monitor： 实时转储收到的请求
    slaveof： 改变复制策略设置
    config： 在运行时配置Redis服务器
4） 对value操作的命令
    exists(key)： 确认一个key是否存在
    del(key)： 删除一个key
    type(key)： 返回值的类型
    keys(pattern)： 返回满足给定pattern的所有key
    randomkey： 随机返回key空间的一个
    keyrename(oldname, newname)： 重命名key
    dbsize： 返回当前数据库中key的数目
    expire： 设定一个key的活动时间（ s）
    ttl： 获得一个key的活动时间
    select(index)： 按索引 查询
    move(key, dbindex)： 移动当前数据库中的key到dbindex数据库
    flushdb： 删除当前选择数据库中的所有key
    flushall： 删除所有数据库中的所有key
5） String
    set(key, value)： 给数据库中名称为key的string赋予值value
    get(key)： 返回数据库中名称为key的string的value
    getset(key, value)： 给名称为key的string赋予上一次的value
    mget(key1 , key2,…, key N)： 返回库中多个string的value
    setnx(key, value)： 添加string， 名称为key， 值为value
    setex(key, time, value)： 向库中添加string， 设定过期时间time
    mset(key N, value N)： 批量设置多个string的值
    msetnx(key N, value N)： 如果所有名称为key i的string都不存在
    incr(key)： 名称为key的string增1 操作
    incrby(key, integer)： 名称为key的string增加integer
    decr(key)： 名称为key的string减1 操作
    decrby(key, integer)： 名称为key的string减少integer
    append(key, value)： 名称为key的string的值附加value
    substr(key, start, end)： 返回名称为key的string的value的子串
6） List
    rpush(key, value)： 在名称为key的list尾添加一个值为value的元素
    lpush(key, value)： 在名称为key的list头添加一个值为value的 元素
    llen(key)： 返回名称为key的list的长度
    lrange(key, start, end)： 返回名称为key的list中start至end之间的元素
    ltrim(key, start, end)： 截取名称为key的list
    lindex(key, index)： 返回名称为key的list中index位置的元素
    lset(key, index, value)： 给名称为key的list中index位置的元素赋值
    lrem(key, count, value)： 删除count个key的list中值为value的元素
    lpop(key)： 返回并删除名称为key的list中的首元素
    rpop(key)： 返回并删除名称为key的list中的尾元素
    blpop(key1 , key2,… key N, timeout)： lpop命令的block版本。
    brpop(key1 , key2,… key N, timeout)： rpop的block版本。
    rpoplpush(srckey, dstkey)： 返回并删除名称为srckey的list的尾元素， 并将该元素添加到名称为dstkey的list的头部
7） Set
    sadd(key, member)： 向名称为key的set中添加元素member
    srem(key, member) ： 删除名称为key的set中的元素member
    spop(key) ： 随机返回并删除名称为key的set中一个元素
    smove(srckey, dstkey, member) ： 移到集合元素
    scard(key) ： 返回名称为key的set的基数
    sismember(key, member) ： member是否是名称为key的set的元素
    sinter(key1 , key2,…key N) ： 求交集
    sinterstore(dstkey, (keys)) ： 求交集并将交集保存到dstkey的集合
    sunion(key1 , (keys)) ： 求并集
    sunionstore(dstkey, (keys)) ： 求并集并将并集保存到dstkey的集合
    sdiff(key1 , (keys)) ： 求差集
    sdiffstore(dstkey, (keys)) ： 求差集并将差集保存到dstkey的集合
    smembers(key) ： 返回名称为key的set的所有元素
    srandmember(key) ： 随机返回名称为key的set的一个元素
8） Hash
    hset(key, field, value)： 向名称为key的hash中添加元素field
    hget(key, field)： 返回名称为key的hash中field对应的value
    hmget(key, (fields))： 返回名称为key的hash中field i对应的value
    hmset(key, (fields))： 向名称为key的hash中添加元素field
    hincrby(key, field, integer)： 将名称为key的hash中field的value增加integer
    hexists(key, field)： 名称为key的hash中是否存在键为field的域
    hdel(key, field)： 删除名称为key的hash中键为field的域
    hlen(key)： 返回名称为key的hash中元素个数
    hkeys(key)： 返回名称为key的hash中所有键
    hvals(key)： 返回名称为key的hash中所有键对应的value
    hgetall(key)： 返回名称为key的hash中所有的键（ field） 及其对应的value

9）其他
  
   设置从服务器
   SLAVEOF xxx.xxx.xxx.xxx 6379

   解除主从关系
   SLAVEOF NO ONE

   修改某个配置
   config set xxxxx xxxxx

   获得某个配置
   config get xxxx.xxx

   将配置回写文件
   CONFIG REWRITE
```

## Redis监控

- [Redis Live](https://github.com/LittlePeng/redis-monitor)是一个更通用的 Redis 监控方案， 它的原理是定时在 Redis 上执行 MONITOR 命令， 来获取当前 Redis 当前正在执行 的命令， 并通过统计分析， 生成web页面的可视化分析报表
- [Redis Faina](https://blog.csdn.net/cjfeii/article/details/77069778)是由著名的图片分享应用 instagram 开发的 Redis 监控服务， 其原理和 Redis Live 类似， 都是对通过 MONITOR 来 做的。
- [redmon](http://www.oschina.net/p/redmon)是那种一眼看上去就觉得不错的小工具， 而且必然会很轻量级， 目 前它已经支持实时查看Redis的流量， 请求， 配置信息， 命令行操作等功能， 后续还将添加Web端配置修改， 慢日 志查询等功能
- [Redis集群管理工具 Redis: : Sentinel](http://www.oschina.net/p/redis-sentinel
)是Redis的作者antirez完成的， 因为Redis实例在各个大公司的应用，每个公司都需要一个Redis集群的管理工具， 被迫都自 己写管理工具来管理Redis集群， antirez考虑到社区的急迫需要(详情)， 花了几个星期写出了Redis-sentinel。


## 持久化(persistence)
Redis提供两种[持久化](http://redisdoc.com/topic/persistence.html#id5)的方式：
- **RDB** 持久化可以在指定的时间间隔内生成数据集的时间点快照（ point-in-time snapshot） 。
- **AOF** 持久化记录服务器执行的所有写操作命令， 并在服务器启动时， 通过重新执行这些命令来还原数据集。 AOF文件中的命令全部以 Redis 协议的格式来保存， 新命令会被追加到文件的末尾。 Redis 还可以在后台对 AOF 文件进行重写（ rewrite） ， 使得 AOF 文件的体积不会超出保存数据集状态所需的实际大小。
- 切换持久化
```
在 Redis 2.2 或以上版本，可以在不重启的情况下，从 RDB 切换到 AOF ：
 
    为最新的 dump.rdb 文件创建一个备份。
    将备份放到一个安全的地方。
    执行以下两条命令：
 
    redis-cli> CONFIG SET appendonly yes
 
    redis-cli> CONFIG SET save ""
 
    确保命令执行之后，数据库的键的数量没有改变。
    确保写命令会被正确地追加到 AOF 文件的末尾。
 
步骤 3 执行的第一条命令开启了 AOF 功能： Redis 会阻塞直到初始 AOF 文件创建完成为止， 之后 Redis 会继续处理命令请求， 并开始将写入命令追加到 AOF 文件末尾。
 
步骤 3 执行的第二条命令用于关闭 RDB 功能。 这一步是可选的， 如果你愿意的话， 也可以同时使用 RDB 和 AOF 这两种持久化功能
```

### 特殊介绍
　1).RDB 快照 在默认情况下， Redis 将数据库快照保存在名字为 dump.rdb 的二进制文件中。
　　你可以对 Redis 进行设置， 让它在“ N 秒内数据集至少有 M 个改动”这一条件被满足时， 自 动保存一次数据集。你也可以通过调用 SAVE 或者 BGSAVE ， 手动让 Redis 进行数据集保存操作。
　　比如说， 以下设置会让 Redis 在满足“ 60 秒内有至少有 1 000 个键被改动”这一条件时， 自 动保存一次数据集：
　　　save 60 1 000
　　这种持久化方式被称为快照（snapshot） 。
　2).只进行追加操作的文件（ append-only file， AOF）从 1 .1 版本开始， Redis 增加了一种完全耐久的持久化方式： AOF 持久化。你可以通过修改配置文件来打开 AOF 功能：appendonly yes从现在开始， 每当 Redis 执行一个改变数据集的命令时（比如 SET） ， 这个命令就会被追加到 AOF 文件的末尾。这样的话， 当 Redis 重新启时， 程序就可以通过重新执行 AOF 文件中的命令来达到重建数据集的目 的。

　3)如果 AOF 文件出错了， 怎么办？
服务器可能在程序正在对 AOF 文件进行写入时停机， 如果停机造成了 AOF 文件出错（ corrupt） ， 那么 Redis 在重启时会拒绝载入这个 AOF 文件， 从而确保数据的一致性不会被破坏。
　　当发生这种情况时， 可以用以下方法来修复出错的 AOF 文件：
　　1 . 为现有的 AOF 文件创建一个备份。
　　2. 使用 Redis 附带的 redis-check-aof 程序， 对原来的 AOF 文件进行修复。
　　$ redis-check-aof --fix
　　3. （可选） 使用 diff -u 对比修复后的 AOF 文件和原始 AOF 文件的备份， 　　查看两个文件之间的不同之处。
　　4. 重启 Redis 服务器， 等待服务器载入修复后的 AOF 文件， 并进行数据恢复。
　4)怎么从 RDB 持久化切换到 AOF 持久化
　　1 . 为最新的 dump. rdb 文件创建一个备份。
　　2. 将备份放到一个安全的地方。
　　3. 执行以下两条命令：
　　redis-cli> CONFIG SET appendonly yes
　　redis-cli> CONFIG SET save " "
　　4. 确保命令执行之后， 数据库的键的数量没有改变。
　　5. 确保写命令会被正确地追加到 AOF 文件的末尾。

## 技术方案

- Redis Master/Slave + Redis Sentinel
- Redis Cluster
- Redis Master/Slave + HaProxy + Shell
- Redis Master/Slave + twemproxy(nutcracker)
- CacheCloud [搜狐开源方案]
- Redis Master/Slave + F5 [某银行的方案]

## 错误
QA1：
```
127.0.0.1:6379> FLUSHDB
(error) MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk. Commands that may modify the data set are disabled. Please check Redis logs for details about the error.

原因：Redis被配置为保存数据库快照，但它目前不能持久化到硬盘。用来修改集合数据的命令不能用。请查看Redis日志的详细错误信息。

解决办法：config set stop-writes-on-bgsave-error no
```

## 实践

![F5关于Redis的monitor配置](http://ore2d9chp.bkt.clouddn.com/F5-redis-monitor.png)
![Redis setinel实践](http://ore2d9chp.bkt.clouddn.com/Redis-setinel%E5%AE%9E%E8%B7%B5.png)


## 资料

- [Redis.cn](http://redis.cn/)
- [Redis命令参考](http://redisdoc.com/)
- [Redis 数据持久化](http://www.cnblogs.com/siqi/p/4245821.html)
- [redis_主从配置以及自动切换](https://blog.csdn.net/aa838260772/article/details/51165948)
- [Redis+twemproxy(nutcracker)实现Redis多集群方案](https://blog.csdn.net/wutong_login/article/details/50434905)
- [Redis 哨兵模式实现主从故障互切换](https://www.cnblogs.com/chenmh/p/5578376.html)
- [Redis Cluster介绍与搭建](https://blog.csdn.net/men_wen/article/details/72853078)
- [CacheCloud](https://cachecloud.github.io/)
- [Redis性能问题排查解决手册(七)](https://www.cnblogs.com/mushroom/p/4738170.html)
- [redis sentinel 主从切换(failover)解决方案，详细配置](https://blog.csdn.net/pi9nc/article/details/17735653)
- [Redis开发规范](https://www.cnblogs.com/ae6623/p/6183714.html)
- [阿里云Redis开发规范](https://blog.csdn.net/glx490676405/article/details/79580748)