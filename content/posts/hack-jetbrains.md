---
title: "Hack Jetbrains"
date: 2022-12-27T23:30:00+08:00
draft: false

tags: [Jetbrains,hack]
categories: [hack]

comment: true
toc: true
---

Jetbrains全家桶 https://3.jetbra.in  

jetbra.zip-`readme.txt`
```
1. add -javaagent:/path/to/ja-netfilter.jar=jetbrains to your vmoptions (manual or auto)
2. log out of the jb account in the 'Licenses' window
3. use key on page https://jetbra.in/5d84466e31722979266057664941a71893322460
4. plugin 'mymap' has been deprecated since version 2022.1
5. don't care about the activation time, it is a fallback license and will not expire
```

Jetbrains Toolbox
```
GoLand -> Settings -> Configuration -> show... -> GoLand.app.vmoptions
```

在vmoptions文件最后增加以下内容
```
-javaagent:/path/jetbra/ja-netfilter.jar=jetbrains
# jdk17 need
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
```

获取key，看readme.txt中的url

`新版本区域选择的坑`
如果你选择 China Mainland 将会有一个比较坑的地方：激活许可验证走 account.jetbrains.com.cn 这个域名，而不是默认的 account.jetbrains.com

找到你的jetbra目录，编辑 config-jetbrains\url.conf 文件,新增以下内容,把新的域名也拦截。
```
[URL]
PREFIX,https://account.jetbrains.com.cn/lservice/rpc/validateKey.action
```
