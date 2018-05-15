---
title: NodeJS
---

## Command
```
npm
  安装包
  npm -d --save xxxx
  安装指定版本
  npm -d --save xxxx@0.0.1
  更新包
  npm update xxxx
  检查模块是否已过期
  npm outdated xxxx
  卸载
  npm uninstall xxxx
  查看安装的模块
  npm ls
  查看版本
  npm --version

  查看配置
  npm config list

  获取配置
  npm config get prefix

  设置配置
  npm config set prefix "directory"

  删除配置
  npm config delete prefix

  npm帮助
  npm --help
```
[Node.js中npm常用命令大全](http://www.jb51.net/article/86253.htm)

## Script

- [i5ting_toc](script/i5ting_toc.html)
- [gulp](script/gulp.html)

## Issue

### 修改npm默认配置

```
vi ~/.npmrc
添加如下内容：
  registry=https://registry.npm.taobao.org/
  prefix=/opt/blog/node_modules
```


