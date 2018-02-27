---
title: Android
---

## basic

## issue

### android 5037端口被占用
```
netstat -aon|findstr 5037

tasklist /fi "PID eq xxxx"    或者   tasklist | findstr 2448

taskkill -F -PID xxx

```