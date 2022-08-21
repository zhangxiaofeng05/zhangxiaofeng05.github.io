# linux安装QQ


>首先要感谢deepin,QQ很早就停止linux版的更新了,deepin团队在移植上的力度还是比较大的。以后有机会的话，还会再装deepin的。  
也要感谢wszqkzqk，做了整理。  

##  解决方案
GitHub:https://github.com/wszqkzqk/deepin-wine-ubuntu  
你也可以看作者的README,但是我没看，作者写的比较精简，有些具体的没看懂怎么操作！！原谅我是个萌新。  

 - 第一步：安装deepin-wine环境  
上`https://github.com/wszqkzqk/deepin-wine-ubuntu`页面下载zip包（或用git方式克隆），解压到本地文件夹
在中国推荐用下面的地址，速度更快： (`git clone https://gitee.com/wszqkzqk/deepin-wine-for-ubuntu.git`)
在文件夹中打开终端，输入sudo sh ./install.sh一键安装。

- 第2步，安装相关应用容器
在http://mirrors.aliyun.com/deepin/pool/non-free/d/中下载想要的容器，点击deb安装即可。
*（建议在终端下使用dpkg -i安装容器，否则容易误报依赖错误）*

- 第３步，关于托盘
安装TopIconPlus的gnome-shell扩展，命令：`sudo apt-get install gnome-shell-extension-top-icons-plus gnome-tweaks`，然后用r命令重启gnome-shell(Alt+F2,输入r)，最后用gnome-tweaks开启这个扩展。

## 参考
https://www.lulinux.com/archives/1319
https://github.com/wszqkzqk/deepin-wine-ubuntu

