# mac m芯片在/根目录下创建文件报Read-only file system


`关闭SIP以后还是有问题`
**没有效果**
```
1. 重启 Mac 并在启动时按住 Command (⌘) + R 进入恢复模式。
2. 在恢复模式中打开终端（从菜单栏选择 Utilities > Terminal）。
3. 在终端中输入以下命令并按回车键：
csrutil disable
4. 重新启动 Mac。
```

## 解决方法
本质：配置一个文件或文件夹软链到根目录  
1. nvim /etc/synthetic.conf
在文件中添加以下内容
```
mydata    /Users/firefly/mydata
```
中间是 tab 键  
`千万不要用空格,如果误用，可能需要进入恢复模式删除此文件`  
赋权命令：`sudo chmod 777 synthetic.conf`  
重启电脑后，在/根目录就能看到新建的文件或文件夹了


参考：  
https://blog.csdn.net/weixin_50016308/article/details/118757508  
https://stackoverflow.com/questions/58396821/what-is-the-proper-way-to-create-a-root-sym-link-in-catalina

