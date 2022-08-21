# deepin编译安装Python3.6

## 官网下载源码
官网：https://www.python.org/downloads/source/  
```
cd /opt/python/
sudo wget https://www.python.org/ftp/python/3.6.10/Python-3.6.10.tar.xz
sudo xz -d Python-3.6.10.tar.xz
sudo tar xvf Python-3.6.10.tar
cd Python-3.6.10/
sudo ./configure --prefix=/usr/local/python3.6
sudo make
sudo make install
sudo ln -s /usr/local/python3.6/bin/python3 /usr/bin/python3.6
```

## 虚拟环境
```
python3.6 -m venv ./env           #创建虚拟环境

source env/bin/activate           #激活虚拟环境
```

## python官方文档
https://docs.python.org/zh-cn/3/library/venv.html
