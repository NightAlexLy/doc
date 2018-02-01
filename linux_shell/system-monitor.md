---
title: System Monitor Shell
---

**系统信息监控脚本**

```
#!/bin/bash

clear
# s# 提取位置参数的个数
if [[ $# -eq 0 ]]
then
#定义高亮显示变量
reset_terminal=$(tput sgr0)

#Check OS Type
os=$(uname -o)
echo -e '\E[32m' "Operting System Type :" $reset_terminal $os
#Check OS Release Version and Name
os_name=$(cat /etc/issue | grep -e "Final")
echo -e '\E[32m' "Check OS Release Version and Name :" $reset_terminal $os_name
#Check Architecture
architecture=$(uname -m)
echo -e '\E[32m' "Check Acrhitecture :" $reset_terminal $architecture
#Check Kernel Release
kernerr_release=$(uname -r)
echo -e '\E[32m' "Check Kernel Release :" $reset_terminal $kernerr_release
#Check hostname uname -n /// echo $HOSTNAME
hostname=$(hostname)
echo -e '\E[32m' "Check Hostname :" $reset_terminal $hostname
#Check Internal IP
internal_ip=$(hostname -I)
echo -e '\E[32m' "Check Internal IP :" $reset_terminal $internal_ip
#Check External IP 通过第三方
external_ip=$(curl -s http://ipecho.net/plain)
echo -e '\E[32m' "Check External IP :" $reset_terminal $external_ip
#Check DNS
dns=$(cat /etc/resolv.conf | grep -E "\<nameserver[ ]+" | awk '{print $NF}')
echo -e '\E[32m' "Check DNS :" $reset_terminal $dns
#Check if connected to Internet or not
ping -c 2 baidu.com &>/dev/null && echo "Internet:Connected" || echo "Internet:DisConnected"
#Check Logged In Users
who>/tmp/who
echo -e '\E[32m' "Logged In Users" $reset_terminal && cat /tmp/who
rm -rf /tmp/who

fi
```