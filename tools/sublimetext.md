---
title: Sublime Text Issue
---


## 安装Package Control

　　打开控制台**Ctrl+~** 输入
　　Sublime Text 3：
```
Sublime Text 3:
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
```
　　Sublime Text2；
```
import urllib2,os; pf='Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler( ))); open( os.path.join( ipp, pf), 'wb' ).write( urllib2.urlopen( 'http://sublime.wbond.net/' +pf.replace( ' ','%20' )).read()); print( 'Please restart Sublime Text to finish installation')
```

## channel_v3.json错误

```
	"channels":
	[
		"http://ore2d9chp.bkt.clouddn.com/channel_v3.json"
	],
```

## 常用的插件

　　[知乎-sublime text3插件推荐](https://www.zhihu.com/question/24736400)
　　[github-sublime text](https://github.com/jikeytang/sublime-text)
　　[简书-sublime text好用插件](https://www.jianshu.com/p/b2163b4e8e94)
　　[Sublime Text中使用Git](https://www.cnblogs.com/vanstrict/p/5677724.html)
