---
title: Git Issue
---

## linux init git project

- GitHub上创建一个repositories项目,比如 ：https://github.com/NightAlexLy/doc.git
- 在自已的项目下面执行。 `git init`
- 将资源文件添加到git。`git add . `
- 提交 `git commit -m "log message`（自己的提交日志）"
- `git remote add origin https://github.com/NightAlexLy/doc.git`，在github上面添加origin
- `git push -u origin master`  ,将代码同步至github。
- 上面一步报错可能需要执行`git pull --rebase origin`

## git提交每次都输入密码

```
查看git origin的地址：  git remote -v

　git remote rm origin
　git remote add origin https://username:password@github.com/username/test.git
　git push origin master
```