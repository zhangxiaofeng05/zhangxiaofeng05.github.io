# Hack Jetbrains


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

