---
title: Hexo
---

## 常用命令
```
  初始化项目： hexo init
  自动生成： hexo generate / hexo g
  启动服务： hexo server / hexo s
  部署git :  hexo deploy / hexo d    [需要安装npm -d --save hexo-deployer-git]
```

## Issue
```
QA: hexo设置skip_render,指定不进行渲染的文件

# 路径是相对source目录的
# 不对google7caf449f9ab0f94b.html与your-other-ignore-file进行渲染，保持文件原有内容
skip_render:
  - "google7caf449f9ab0f94b.html"
  - "your-other-ignore-file"
```

## 资料
- [hexo + next](https://www.jianshu.com/p/ee4344922554)
- Hexo Theme Api
  - [Hexo Doc](https://zalando-incubator.github.io/hexo-theme-doc/get-started.html)
  - [Hexo Next](http://theme-next.iissnan.com/)
- [Gulp Api](https://www.gulpjs.com.cn/docs/getting-started/)
- [Hexo Command](https://hexo.io/zh-cn/docs/commands.html)