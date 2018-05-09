########################
#  Install Subversion
#
#  user：root
#  path：/opt
#
########################

#!/bin/sh

cd /opt

# install software
yum -y install subversion

# query subversion version
svnversion --version

# create repos
mkdir -p /opt/svn/repos

# init repos
svnadmin create /opt/svn/repos

# change folder
cd /opt/svn/repos/conf

# change atuhz config
sed -i '/^\[groups\]$/a\development = user' authz
echo "" >> authz
echo "[/]" >> authz
echo "@development=rw" >> authz
echo "" >> authz
echo "[repos:/]" >> authz
echo "user = rw" >> authz

# change passwd config
echo "user = password" >> passwd

# change svnserver config
sed -i '/^\[general\]$/a\anon-access = none' svnserve.conf
sed -i '/^\[general\]$/a\auth-access = write' svnserve.conf
sed -i '/^\[general\]$/a\password-db = passwd' svnserve.conf
sed -i '/^\[general\]$/a\authz-db = authz' svnserve.conf
sed -i '/^\[general\]$/a\realm = /opt/svn/repos' svnserve.conf

# start server 
svnserve -d -r /opt/svn/repos