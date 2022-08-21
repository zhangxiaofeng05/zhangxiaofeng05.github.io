# 命令行下测试服务器外网速度speedtest-cli

## speedtest-cli命令
speedtest-cli是一个使用python编写的命令行脚本，通过调用speedtest.net测试上下行的接口来完成速度测试  
linux命令大全：https://man.linuxde.net/speedtest-cli  
github地址：https://github.com/sivel/speedtest-cli  

## 使用方式
自己看作者的`README.md`  
此处列一个简单的方法  
```
wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod +x speedtest-cli
```
命令  
```
./speedtest-cli -h               打印帮助信息
./speedtest-cli --share          测速
```
