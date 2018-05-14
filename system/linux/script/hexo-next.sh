################################################
#  Intall Hexo install & init next Theme
#
#  user：root
#  path：/opt
#
################################################

#!/bin/sh

# check node install
if which node 2>/dev/null; then
  echo "node exists!"
else
  cd /opt
  # install node dependency
  yum install -y gcc gcc-c++ make
  # Download node source tar gz
  wget https://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.gz
  # unzip
  tar -zxvf node-v6.11.0.tar.gz
  # change folder
  cd node-v6.11.0
  # set configure
  ./configure
  # make
  make
  # make install
  make install
  # copy command
  cp /usr/local/bin/node /usr/sbin/
  # test node command
  node --version
  npm --version
fi

# check git install
if which git 2>/dev/null; then
  echo "git exists!"
else
  # change folder
  cd /opt
  # install dependency
  yum install -y zlib-devel 
  yum install -y openssl-devel 
  yum install -y perl 
  yum install -y cpio 
  yum install -y expat-devel 
  yum install -y gettext-devel
  yum install -y autoconf 

  #Downlod git source 
  wget http://www.codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.xz 
  # xz
  xz -d git-latest.tar.xz
  # unzip 
  tar xvf git-latest.tar 
  # change folder
  cd git*
  # autoconf
  autoconf
  # set configure
  ./configure --with-curl=/usr/local 
  # make
  make
  # make install
  make install
  # init git config
  git config --global user.name "luis"
  git config --global user.email "night_ly@live.com"
  # test install
  git --version
fi

# check hexo install
if which hexo 2>/dev/null; then
  echo "hexo exists!"
else
  # change folder
  cd /opt
  # install hexo
  npm install hexo-cli -g
  # test install
  hexo --version
fi

# check glup install
if which gulp 2>/dev/null; then
  echo "gulp exists!"
else
  # change folder
  cd /opt
  # install gulp
  npm install -d --save gulp gulp-clean gulp-load-plugins gulp-minify-css gulp-minify-html gulp-rename gulp-uglify gulp-shell typescript
  # test install
  gulp --version
fi

mkdir -p /opt/website
cd /opt/website

# init blog project
hexo init blog
# change folder
cd blog
# remove source file
rm -rf source/*
# Donwload my blog doc
git clone git@github.com:NightAlexLy/blog.git source
# copy gulpfile.js
wget http://118.25.106.223/upload/blog_gulpfile.js
mv blog_gulpfile.js gulpfile.js
# Download next theme source
git clone https://github.com/iissnan/hexo-theme-next themes/next
# change theme value
sed -i 's/theme: [/a-zA-Z0-9._-\ ]*/theme: next/' _config.yml
sed -i 's/title: [/a-zA-Z0-9._-\ ]*/title: run time/' _config.yml
sed -i 's/subtitle: [/a-zA-Z0-9._-\ ]*/subtitle: stay hungry stay foolish/' _config.yml
sed -i 's/description: [/a-zA-Z0-9._-\ ]*/description: stay hungry stay foolish/' _config.yml
sed -i 's/author: [/a-zA-Z0-9._-\ ]*/author: Luis Yang/' _config.yml
sed -i 's/language: [/a-zA-Z0-9._-\ ]*/language: zh-Hans/' _config.yml

# Download blog config
wget http://118.25.106.223/upload/blog_init.zip
yum install -y unzip
unzip blog_init.zip
rm -rf blog_init.zip
# init project 
npm install -d --save hexo-tag-aplayer
npm install -d --save hexo-generator-search
npm install -d --save hexo-deployer-git
#1. 拷贝基础文件
# copy custome file js
# location-addr.js  ---> themes/next/scripts/tags/
cp blog_init/location-addr.js themes/next/scripts/tags/location-addr.js
# load-photos.js   ---> themes/next/scripts/tags/
cp blog_init/location-photos.js themes/next/scripts/tags/location-photos.js
# copy basic config
# blog config
mv _config.yml _config.yml.bk
cp blog_init/blog_config.yml _config.yml
# theme next config
mv themes/next/_config.yml themes/next/_config.yml.bk
cp blog_init/blog_theme_config.yml themes/next/_config.yml
# copy hexo-generator-photo modul
cp blog_init/hexo-generator-photo.tar.gz node_modules/hexo-generator-photo.tar.gz
cd node_modules
tar -vxf hexo-generator-photo.tar.gz
rm -rf hexo-generator-photo.tar.gz
cd ..
sed -i '/^  \"dependencies\": {$/a\    \"hexo-generator-photo\": \"^0.0.1\",' package.json
# copy photo collapse 
cp blog_init/post-collapse-photo.swig themes/next/layout/_macro/post-collapse-photo.swig
# copy style
mv themes/next/source/css/_custom/custom.styl themes/next/source/css/_custom/custom.styl.bk
cp blog_init/custom.styl themes/next/source/css/_custom/custom.styl
# add yaoyiyao js
echo "" >> themes/next/layout/_partials/head/custom-head.swig
echo "<script type=\"text/javascript\" src=\"https://infos.rtime.xin/high-animation.js\"></script>" >> themes/next/layout/_partials/head/custom-head.swig
echo "<link href=\"https://infos.rtime.xin/ma5gallery.mini3.css\" rel=\"stylesheet\" type=\"text/css\" />" >> themes/next/layout/_partials/head/custom-head.swig
# add ma5gallery js
echo "<script type=\"text/javascript\" src=\"{{ url_for(theme.js) }}/src/ma5gallery.js?v={{ theme.version }}\"></script>" >> themes/next/layout/_scripts/pages/post-details.swig
echo "<script type=\"text/javascript\" src=\"{{ url_for(theme.js) }}/src/html5.js?v={{ theme.version }}\"></script>" >> themes/next/layout/_scripts/pages/post-details.swig
echo "<script type=\"text/javascript\">\$(document).ready(function(){\$(\".gallery-item\").ma5gallery({preload:true,fullscreen:false})});</script>" >> themes/next/layout/_scripts/pages/post-details.swig
# change zh-Hans
sed -i '/^title:$/a\  guestbook: 留言' themes/next/languages/zh-Hans.yml
sed -i '/^title:$/a\  about: 关于' themes/next/languages/zh-Hans.yml
sed -i '/^title:$/a\  photo: 相册' themes/next/languages/zh-Hans.yml
sed -i '/^menu:$/a\  guestbook: 留言' themes/next/languages/zh-Hans.yml
sed -i '/^menu:$/a\  photos: 相册' themes/next/languages/zh-Hans.yml

############################################################
# 人工操作步骤：
# 1. vi ./layout/_partials/page-header.swig
# <{% if theme.seo %}h2{% else %}h1{% endif %} class="post-title" itemprop="name headline">{% if !page.isTitle %}{{ page.title }}{% endif %}</{% if theme.seo %}h2{% else %}h1{% endif %}>
# 2. ./layout/_macro/post.swig
# 添加 && !post.isPhoto  判断     ----- 255行
#<div class="post-body{% if theme.han %} han-init-context{% endif %}{% if post.isPhoto %} ma5-gallery{% endif %} " itemprop="articleBody" {% if post.isPhoto %} style="text-align:center;"  {% endif  %} >
# -------- 271 行
# 3. ./layout/_scripts/vendors.swig
# 添加 && !post.isPhoto  判断     ----- 16行
# 4. ./layout/_partials/head.swig
# 添加 && !post.isPhoto  判断     ----- 58行 /130行
# 5. vi ./source/css/_schemes/Pisces/_layout.styl    ---------60行
#  65行----------  background: none;
#  80行----------    background: white;
############################################################

# hexo clean 
hexo clean
# hexo g
hexo g
# npm gulp dependency
npm install -d --save gulp       
npm install -d --save gulp-clean
npm install -d --save gulp-load-plugins
npm install -d --save gulp-minify-css
npm install -d --save gulp-minify-html
npm install -d --save gulp-rename gulp-uglify
npm install -d --save gulp-shell
npm install -d --save typescript 
npm install -d --save gulp-typescript
npm install -d --save gulp-htmlmin
# gulp
gulp