---
title: hexo-cmd Shell
---

**定时自动部署和更新hexo**


```
#!/bin/bash

function  startServer()
{
   cd /opt/blog
   nohup hexo server -p 80 >/dev/null 2>&1 &
   echo  "start server sucess !!!  PID ::: "
   getPID
}

function stopServer()
{
   ps -ef|grep hexo |grep -v grep | grep -v cron |grep -v blog | grep -v /bin/bash | grep -v /bin/sh | awk '{print $2}' | xargs kill -9  >> /dev/null
   echo "stop hexo success !!! "
}

function getPID()
{
  ps -ef | grep hexo | grep -v grep | grep -v cron | grep -v blog | grep -v /bin/bash | grep -v /bin/sh |  awk '{print $2}'
  echo ""
}


function autoUpdate()
{

  chkHexo=`ps -ef|grep hexo | grep -v cron | grep -v grep |grep -v blog | grep -v /bin/sh | grep -v /bin/bash |awk '{print $2}'`
  if [[ -z $chkHexo ]];then
     echo "hexo server is stop !!! "
  else
     stopServer
  fi
  killall nginx
  echo ""
  cd /opt/blog
  rm -rf db.json
  hexo clean
  hexo generate
  gulp
  nginx

}

function autoDeploy()
{

  autoUpdate

  cd /opt/blog
  set timeout 200000
/usr/bin/expect <<-EOF
  spawn hexo deploy
  expect "Username"
  send "night_ly@live.com\r"
  expect "Password"
  send "liuyang1\r"
  interact
  expect eof
EOF

  startServer

}

. /etc/profile
autoDeploy

echo ""
echo -n "-------------- auto deploy   "
echo `date +"%F %H:%M:%S"`
echo ""
echo ""
```

**配置定时任务**
```
[root@hostname ~]crontab -e
添加如下一行：
30 23 * * * root `sh /opt/blog/hexo-deploy.sh >> /tmp/test.txt`
```