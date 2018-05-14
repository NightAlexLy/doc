--- 
title: Nginx Issue
---


## 常用命令
```
动态重启： nginx -s relod
检查配置   nginx -t
```

## 直接下载
```
	location按照如下配置：

	location ~ ^/downlod/(.*)$ {
		add_header Content-Disposition "attachment; filename=$1";  
	}
```

## 文件服务器
```
    location下增加如下配置：

    autoindex on;# 显示目录
	autoindex_exact_size on;# 显示文件大小
    autoindex_localtime on;# 显示文件时间

```