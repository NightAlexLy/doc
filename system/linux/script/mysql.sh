########################
#  Install Mysql
#
#  user：root
#  path：/opt
#
########################

cd /opt

# check mysql server install
if which mysql 2>/dev/null; then
  echo "mysql exists!"
else

  # create mysql user 
  useradd mysql
  # change mysql user password
  echo "mysqlPwd" | passwd --stdin mysql

  # remove mysql-libs dependency
  yum -y remove mysql-libs*
  yum -y remove mariadb-libs*

  # create mysql folder
  mkdir -p /opt/mysql
  # change folder
  cd /opt/mysql
  # Download mysql source rpm
  wget http://cdn.mysql.com/archives/mysql-5.6/MySQL-server-5.6.13-1.el6.x86_64.rpm
  wget http://cdn.mysql.com/archives/mysql-5.6/MySQL-devel-5.6.13-1.el6.x86_64.rpm
  wget http://cdn.mysql.com/archives/mysql-5.6/MySQL-client-5.6.13-1.el6.x86_64.rpm
  # install server

  rpm -ivh MySQL-server-5.6.13-1.el6.x86_64.rpm
  rpm -ivh MySQL-devel-5.6.13-1.el6.x86_64.rpm
  rpm -ivh MySQL-client-5.6.13-1.el6.x86_64.rpm

  # copy mysql conf 
  cp /usr/share/mysql/my-default.cnf /etc/my.cnf

  # set my.cnf config
  sed -i '/^\[mysqld\]$/a\character-set-server=utf8' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\collation-server=utf8_bin' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\default-storage-engine=INNODB' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\max_allowed_packet=40M' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\lower_case_table_names=1' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\innodb_buffer_pool_size = 256M' /etc/my.cnf
  sed -i '/^\[mysqld\]$/a\max_connections=800' /etc/my.cnf

  # mysql install db
  /usr/bin/mysql_install_db

  # start mysql server
  # centOS 6
  #service mysql start
  # centOS 7
  systemctl start mysql.service

  # chkconfig mysql
  chkconfig mysql on

fi 