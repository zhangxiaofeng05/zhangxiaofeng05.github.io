# 配置git代理

访问GitHub慢，下载慢的解决办法。  

## ssh-socket代理
创建`config`文件  
```
vi ~/.ssh/config
# 当然你也可以手动在 C:\Users\Username\.ssh 下创建 config 文件
```
文件写入如下内容  
```
# 这里的 -a none 是 NO-AUTH 模式，参见 https://bitbucket.org/gotoh/connect/wiki/Home 中的 More detail 一节
ProxyCommand connect -S 127.0.0.1:1080 -a none %h %p

Host github.com
  User git
  Port 22
  Hostname github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\zhang\.ssh\id_rsa"
  TCPKeepAlive yes

Host ssh.github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\zhang\.ssh\id_rsa"
  TCPKeepAlive yes
```

参考文章： https://upupming.site/2019/05/09/git-ssh-socks-proxy/  

## http/https-http或socket代理
git 设置和取消代理  
```
git config --global https.proxy http://127.0.0.1:1080
git config --global http.proxy 'socks5://127.0.0.1:1080'

git config --global https.proxy https://127.0.0.1:1080
git config --global https.proxy 'socks5://127.0.0.1:1080'

git config --global --unset http.proxy

git config --global --unset https.proxy
```

参考： https://gist.github.com/laispace/666dd7b27e9116faece6  

## 参考  
1. https://gist.github.com/chuyik/02d0d37a49edc162546441092efae6a1  
