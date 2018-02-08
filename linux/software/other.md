---
title: Other Software Install
---

## node 安装

```
	yum install -y gcc gcc-c++ make
	cd /opt
	wget https://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.gz

	tar xvf node-v6.11.0.tar.gz
	cd node-v6.11.0
	./configure
	make
	make install
	cp /usr/local/bin/node /usr/sbin/
	
	查看当前安装的Node版本
	node -v

	查看当前安装npm版本    ---类似于Linux下面的yum
	npm -v
```

## git 安装

```

    //先安装git依赖的包 
    yum install zlib-devel 
    yum install openssl-devel 
    yum install perl 
    yum install cpio 
    yum install expat-devel 
    yum install gettext-devel 
    
    //安装autoconf 
    yum install autoconf 
    
    //安装git 
    wget http://www.codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.xz 
    xz -d git-latest.tar.xz
    tar xzvf git-latest.tar.gz 
    cd git-{date} 
    autoconf 
    ./configure --with-curl=/usr/local 
    make 
    make install

```


## hexo 安装

```

	cd /opt    
	npm install hexo-cli -g
	hexo init blog
	cd blog
	npm install
	hexo server

hexo命令：
	Usage: hexo <command>
	
	Commands:
	  help     Get help on a command.
	  init     Create a new Hexo folder.
	  version  Display version information.
	
	Global Options:
	  --config  Specify config file instead of using _config.yml
	  --cwd     Specify the CWD
	  --debug   Display all verbose messages in the terminal
	  --draft   Display draft posts
	  --safe    Disable all plugins and scripts
	  --silent  Hide output on console
	
	For more help, you can use 'hexo help [command]' for the detailed information
	or you can check the docs: http://hexo.io/docs/

```