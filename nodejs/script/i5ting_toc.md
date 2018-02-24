---
title: NodeJs gulp script
---

　　　** [gulp](https://www.gulpjs.com.cn/) 是node基于流的自动化构建工具。 **

```
	var marked = require('marked');
	var fs = require('fs');  
	var path = require('path'); 
	var is_open = false;
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

	//函数可以返回当前正在执行的项目路径
	var pwd = process.cwd()  

	function readAppointFile(filePath,suffix){

	    //根据文件路径读取文件，返回文件列表  
	    fs.readdir(filePath,function(err,files){  
	        if(err){  
	            console.warn(err)  
	        }else{  
	            //遍历读取到的文件列表  
	            files.forEach(function(filename){  
	                //获取当前文件的绝对路径  
	                var filedir = path.join(filePath,filename);  
	                //根据文件路径获取文件信息，返回一个fs.Stats对象  
	                fs.stat(filedir,function(eror,stats){  
	                    if(eror){  
	                        console.warn('获取文件stats失败');  
	                    }else{
	                        var isFile = stats.isFile();//是文件  
	                        var isDir = stats.isDirectory();//是文件夹  
	                        if(isFile){  
	                            var fileSuffix = filedir.substr(filedir.lastIndexOf("\\")+1).split('.')[1];
	                            if(fileSuffix == suffix){
	                              i5ting_ztree(filedir);
	                            }
	                        }  
	                        if(isDir){  
	                            readAppointFile(filedir,suffix);//递归，如果是文件夹，就继续遍历该文件夹下面的文件  
	                        }  
	                    }  
	                })  
	            });  
	        }  
	    });  
	}

	function i5ting_ztree(source_file_name){
	  var file_name = source_file_name.split('/').pop();
	  var _file_name = file_name.substr(file_name.lastIndexOf("\\")+1).split('.')[0];
	  var dest_file_path = pwd + '/preview/' + _file_name + '.html';

	  console.log('pwd=' + pwd);
	  console.log('source_file_name=' + source_file_name);
	  console.log('dest_file_path=' + dest_file_path);

	  require('i5ting_toc')(pwd,source_file_name, dest_file_path, is_open, markd_config);
	}


	readAppointFile(pwd,"md");
```