########################
#  Intall SFTP
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

grep -i sftp /etc/group
# add group
groupadd sftp

# add user
useradd -g sftp -s /bin/false sftp_user
echo 'sftp_password' | passwd --stdin sftp_user

# create folder
mkdir -p /sftp/user
# chown folder
chown -R sftp_user.sftp /sftp/user
usermod -d /sftp/user sftp_user
chown root:sftp /sftp/user
chmod 755 /sftp/user

# start service
# centOS 6
#service sshd restart
# centOS 7 
systemctl restart sshd.service