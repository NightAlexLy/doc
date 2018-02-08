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

	设置npm安装的路径
	npm config set prefix /opt/node

	安装成功找不到命令
	echo -e "export PATH=$(npm prefix -g)/bin:$PATH" >> ~/.bashrc && source ~/.bashrc
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


## node-hexo 安装
　　　
　　　** [hexo](https://hexo.io/) 是node构建博客网站的模块 **

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

## node-i5ting_toc 安装
　　　
　　　**　[i5ting_toc](http://cnodejs.org/topic/54663d67d1ffc608433de263)　是把markdown编译成带有toc目录的html的node模块 **

```
	
	npm install -g i5ting_toc

	Usage: i5ting_toc  a node npm wrapper of i5ting_ztree_toc https://github.com/i5ting/i5ting_ztree_toc 

	Options:

	  -h, --help             output usage information
	  -V, --version          output the version number
	  -f, --file [filename]  default is README.md 
	      -o, --open             open in browser
	  -v, --verbose          打印详细日志

windows下编写转换js：
	
	var arguments = process.argv.splice(2);
	var source_file_name = arguments[0];
	var marked = require('marked');
	var is_open = true;
	var markd_config = {
	  renderer: new marked.Renderer(),
	  gfm: true,
	  tables: true,
	  breaks: false,
	  pedantic: false,
	  sanitize: false,
	  smartLists: true,
	  smartypants: false,
	  xhtml: false,
	  index: true
	}

	console.log('source_file_name=' + source_file_name);
	//函数可以返回当前正在执行的项目路径
	var pwd = process.cwd()  

	//var source_file_name = pwd + '/' + source_file
	var file_name = source_file_name.split('/').pop();
	var _file_name = file_name.substr(file_name.lastIndexOf("\\")+1).split('.')[0];

	var dest_file_path = pwd + '/preview/' + _file_name + '.html';

	console.log('arguments='+ arguments);
	console.log('pwd=' + pwd);
	console.log('source_file_name=' + source_file_name);
	console.log('dest_file_path=' + dest_file_path);

	require('i5ting_toc')(pwd,source_file_name, dest_file_path, is_open, markd_config);

```

## node-gulp 安装

　　　** [gulp](https://www.gulpjs.com.cn/) 是node基于流的自动化构建工具。 **

```

	npm install -d --save gulp gulp-clean gulp-load-plugins gulp-minify-css gulp-minify-html gulp-rename gulp-uglify gulp-shell typescript

	编写gulp.js

	var gulp = require('gulp');
	var clean = require('gulp-clean');
	var minifyCss = require('gulp-minify-css');
	var minifyHtml = require('gulp-minify-html');
	var uglify = require('gulp-uglify');
	var shell = require('gulp-shell');
	var ts = require('gulp-typescript');
	gulp.task("clean",function() {
	    return gulp.src("./dst/*")
	    .pipe(clean());           //plugins为加载的gulp-load-plugins插件,它可以自动加载项目依赖(package.json定义)
	});
	gulp.task("css",function() {
	    return gulp.src(["public/**/*.css","!public/**/*.min.css"])
	    .pipe(minifyCss({compatibility: "ie8"}))
	    .pipe(gulp.dest("./dst/"));
	});
	gulp.task("js",function() {
	    return gulp.src(["public/**/*.js","!public/**/*.min.js"])
	   .pipe(ts({
	      target: "es5",
	      allowJs: true,
	      module: "commonjs",
	      moduleResolution: "node"
	    }))
	    .pipe(uglify())
	    .pipe(gulp.dest("./dst/"));
	});
	gulp.task("html",function() {
	    return gulp.src("public/**/*.html")
	    .pipe(minifyHtml())
	    .pipe(gulp.dest("./dst/"));
	});
	gulp.task("default",["css","js","html","mv"],function() {
	    console.log("gulp task finished!");
	});
	gulp.task("watch",function() {
	    gulp.watch("public/*",["default"]);
	});
	gulp.task("mv",function() {
	    return gulp.src("./dst/*")
	    .pipe(shell([
	        "cp -r ./dst/* ./public/"
	    ]));
	});

```
