---
title: 
---

**自已编写对于hexo管理的脚本**

```
#!/bin/bash

function initUI() 
{

	while [ true ]
	do
	     echo ""
	     echo "------------------------"
	     echo "-----   h  e  x  o -----"
	     echo "------------------------"

	     echo " 1. start    server "
	     echo " 2. shutdown server "
	     echo " 3. hexo pid        "
	     echo " 4. auto note update     "
	     echo " 5. auto note deploy     "
             echo " 6. auto doc update "
             echo " 7. update source   "
             echo " 0. auto All upate  "
	     echo -n " Please enter :     "
	     
	     read num

	     if [ -z $num ];then
	       exit 0
	     elif  [ $num = 1 ];then
	      startServer
	     elif [ $num = 2 ];then
	      stopServer
	     elif [ $num = 3 ];then
	      getPID
             elif [ $num = 4 ];then
              autoUpdate
              startServer
             elif [ $num = 5 ];then
              autoDeploy
             elif [ $num = 6 ];then
              autoDocUpdate
             elif [ $num = 7 ];then
	      updateSou
             elif [ $num = 0 ];then
              autoAllUpate
	     else
	      echo "Input error !!!!!!"
	     fi
	done 
}

function  startServer() 
{
   cd /opt/blog
   nohup hexo server -p 80 >/dev/null 2>&1 &  
   echo -n "start server sucess !!!  PID ::: " 
   getPID
}

function stopServer()
{
   chkHexo=`ps -ef|grep hexo |grep -v grep | grep -v /bin/bash |awk '{print $2}'`
   if [[ -z $chkHexo ]];then
      echo " hexo server is stop !!! "
   else
      ps -ef|grep hexo |grep -v grep | grep -v /bin/bash| awk '{print $2}' | xargs kill -9  >> /dev/null
      echo "stop hexo success !!! " 
   fi
}

function getPID()
{
  ps -ef | grep hexo | grep -v grep | grep -v /bin/bash |  awk '{print $2}' 
  echo ""
}

function autoUpdate()
{

  stopServer
  
  echo ""
  updateEnv /opt/blog
  nginx -s reload
}

function autoDocUpdate()
{

  stopServer
  
  echo ""
  updateEnv  /opt/hexo-theme-doc-seed
  nginx -s reload
 
}

function autoAllUpate()
{
  
  stopServer

  echo ""
  updateEnv /opt/blog
  updateEnv  /opt/hexo-theme-doc-seed
  nginx -s reload

}

function updateEnv()
{
  echo $1
  cd $1/source
  git pull origin master
  cd $1
  rm -rf db.json
  hexo clean
  hexo generate
  gulp
}

function autoDeploy()
{
   
  autoUpdate

/usr/bin/expect <<-EOF
  spawn hexo deploy
  expect "Username"
  send "$gitUn\r"
  expect "Password"
  send "$gitPwd\r"
  interact
  expect eof
EOF

  startServer

}

function updateSou()
{
   cd /opt/blog/source
   git pull origin master 
}

clear
initUI
```