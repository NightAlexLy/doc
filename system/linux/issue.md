---
title: Linux Issue
---

## Crontab执行时效

```
crontab定时执行脚本的时候，可能由于环境的缺失导致执行失败。

可以在脚本的执行的开头添加如下代码：

./etc/profile    #因为我的环境设置都在这个配置文件中

```
