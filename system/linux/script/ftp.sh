########################
#  Intall FTP(vsftpd)
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cp /opt
# Download vsftpd source tar.gz
# http://www.rpmfind.net/linux/rpm2html/search.php?query=vsftpd
wget http://www.rpmfind.net/linux/centos/7.4.1708/os/x86_64/Packages/vsftpd-3.0.2-22.el7.x86_64.rpm
# install vsftp rpm
rpm -ivh vsftpd-3.0.2-22.el7.x86_64.rpm
# chang config
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf
sed -i 's/pam_service_name=vsftpd/pam_service_name=vsftpd.vu/' /etc/vsftpd/vsftpd.conf

echo 'guest_enable=YES' >>  /etc/vsftpd/vsftpd.conf
echo 'guest_username=virtual' >>  /etc/vsftpd/vsftpd.conf
echo 'user_config_dir=/etc/vsftpd/user_conf' >>  /etc/vsftpd/vsftpd.conf

# create vsftpd.vu
touch /etc/pam.d/vsftpd.vu
# add config
echo "auth  required  pam_userdb.so db=/etc/vsftpd/vsftpd_login" >> /etc/pam.d/vsftpd.vu
echo "account  required  pam_userdb.so db=/etc/vsftpd/vsftpd_login" >> /etc/pam.d/vsftpd.vu

# create vsftpd user
touch /etc/vsftpd/vsftpd_login.txt
## add user
echo "user" >> /etc/vsftpd/vsftpd_login.txt
echo "password" /etc/vsftpd/vsftpd_login.txt

# check db_load command
if which db_load 2>/dev/null; then
  echo "db_load exists!"
else
  yum install db4-utils -y
fi

# generator db file
db_load -T -t hash -f /etc/vsftpd/vsftpd_login.txt /etc/vsftpd/vsftpd_login.db

# create virtual user
useradd -d /home/ftp -s /sbin/nologin virtual

# create user folder
mkdir -p /ftp/user
# chown folder
chown -R virtual:virtual /ftp/user

# create user config folder
 mkdir /etc/vsftpd/user_conf

# create user config
touch /etc/vsftpd/user_conf/user
# set user config
echo "local_root=/ftp/user"  >> /etc/vsftpd/user_conf/user
echo "anon_world_readable_only=NO"  >> /etc/vsftpd/user_conf/user
echo "write_enable=YES"  >> /etc/vsftpd/user_conf/user
echo "anon_upload_enable=YES"  >> /etc/vsftpd/user_conf/user
echo "anon_mkdir_write_enable=YES"  >> /etc/vsftpd/user_conf/user
echo "anon_other_write_enable=YES"  >> /etc/vsftpd/user_conf/user

# start vsftpd service
# cnentOS 6
#service vsftpd start 
# centOS 7 
systemctl start vsftpd.service