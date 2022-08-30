# 终端使用socks5代理


## 安装proxychains
简单粗暴的方式：
``` Bash
$ sudo apt-get install proxychains
```
如果想要使用最新版，也可以自己手动编译源码
``` Bash
# 安装
git clone https://github.com/rofl0r/proxychains-ng.git
./configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
sudo make install-config
```
## 配置
在安装完成之后，一般在 /etc/proxychains.conf 处会有默认配置文件，编辑该文件

    sudo vim /etc/proxychains.conf

然后在文件末修改成自己设置的shadowsocks设置的端口，如下

    socks5 127.0.0.1 1080

## 验证
``` Bash
$ curl ip.gs
```
这个显示的ip是没有被代理的
``` Bash
$ proxychains curl ip.gs
```
这个就是你的代理了

在配置完 proxychains 之后，在终端如果任何命令无法连接成功时，在其前加上 proxychains 就可以走代理方式来执行该命令。

## shell函数(unix&linux)
如果系统不支持proxychains，可以考虑设置函数。
```bash
# .zshrc

function proxy_on() {
    export http_proxy=http://127.0.0.1:1080
    export https_proxy=$http_proxy
    echo -e "终端代理已开启。"
}

function proxy_off(){
    unset http_proxy https_proxy
    echo -e "终端代理已关闭。"
}
```

## 参考
 - [终端使用 sock5 代理 终端 terminal socks5 shadowsocks 代理 proxy](http://einverne.github.io/post/2017/02/terminal-sock5-proxy.html)
 - [终端使用代理加速的正确方式(Shadowsocks)](https://segmentfault.com/a/1190000039686752)
