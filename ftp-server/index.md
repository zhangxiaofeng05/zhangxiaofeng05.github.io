# ftp服务器

## linux环境  
```
LSB Version:    :core-4.1-amd64:core-4.1-noarch
Distributor ID: CentOS
Description:    CentOS Linux release 7.3.1611 (Core) 
Release:    7.3.1611
Codename:   Core
```
## 安装  
```
yum install vsftpd

systemctl restart vsftpd.service   # 重启vsftpd
systemctl stop vsftpd.service      # 停止vsftpd
systemctl start vsftpd.service     # 启动vsftpd
systemctl status vsftpd.service    # 查看vsftpd的状态
```

## 匿名配置
### 服务器配置文件  
位置：`/etc/vsftpd/vsftpd.conf`  
坑：`从网上购买的服务器(阿里云)要从控制台开放ftp的端口，建议放开全部端口，如果有需要限制，再限制`，否则会出现登录失败的问题  
防火墙：`开放所需端口`

-------------------------
### 匿名设置：配置文件内容  
```
anonymous_enable=YES    #允许匿名登录
local_enable=YES
write_enable=YES
local_umask=022         #匿名上传的默认权限，匿名不能修改生效，只能上传删除     
anon_upload_enable=YES      #允许匿名上传
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_file=/var/log/xferlog
xferlog_std_format=YES
listen=YES
listen_ipv6=NO

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES
```
匿名用户的默认根目录：/var/ftp/pub  
需要更改权限：`chmod -R 755 /var/ftp/pub`
### 客户端(deepin)
安装：  
```
sudo apt-get install vsftpd
sudo apt-get install lftp
```
### 匿名连接ftp服务器
```
lftp IP
```
### 常用命令
```
lpwd 当地目录
pwd 远程目录
lcd 本地切换目录
cd 远程切换目录
mput hello.c aaa.txt 上传多个文件
--------------------------------
put 上传单个文件
mput 上传多个文件
get 下载单个文件
mget 下载多个文件
mirror 下载整个目录及其子目录
mirror -R 上传整个目录及其子目录
退出 bye、quit、exit
```
详细请谷歌、百度，`help`一下  
至此，匿名用户可以用终端上传下载文件!!!  
### 浏览器访问ftp服务器
在地址栏中输入`ftp://服务器ip地址`
### 文件管理器访问ftp服务器
在地址栏中输入`ftp://服务器ip地址`
### 让其他人下载
匿名用户不能修改文件的权限，只能上传和删除，如果要能让别人下载，需要使用用户登录服务器，为下载的文件添加执行权限  
至此，可以用浏览器和文件管理器下载分享的文件了
### wget下载
使用`wget ftp://IP地址/pub/ftp.txt`  
卡在`PASV ... 无法连接到`  
查看wget的参数，使用`wget --no-passive-ftp ftp://IP地址/pub/ftp.txt`  

----------------------------------

## 用户名连接ftp服务器
### 创建用户
```
sudo adduser ftpuser              # 创建用户
sudo passwd ftpuser               # 为此用户设置密码
sudo usermod -a -G ftp ftpuser    # 将创建的ftpuser用户添加到ftp组
```
### 服务器配置文件  
位置：`/etc/vsftpd/vsftpd.conf`  
### 配置文件内容
匿名关闭，强制实行实名  
```
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=755
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_file=/var/log/xferlog
xferlog_std_format=YES
listen=YES
listen_ipv6=NO

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES
```
### 用户名登录
```
lftp 用户名:密码@ftp地址:传送端口（默认21）
```
用户的默认路径：`/home/ftpuser`  
上传和下载不再赘述  
### 让其他人下载
在客户端上传文件后，查看文件的执行权限，下载需要执行权限，如果没有，执行`chmod +x ftp.txt`  通过浏览器或文件管理器访问`ftp://IP地址`，用户登录，即可下载  
### wget下载
 - 第一种方法  
使用`wget ftp://用户名:密码@IP地址/ftp.txt`  
卡在`PASV ...`  
使用`wget ftp://用户名:密码@IP地址/ftp.txt --no-passive-ftp`
 - 第二种方法  
使用`wget ftp://IP地址/ftp.txt --ftp-user=用户名 --ftp-password=密码 --no-passive-ftp`  
 - 第三种方法
使用`wget --user=ftpuser --password=passwd IP:/home/ftp.txt[绝对路径] --no-passive-ftp`  
这样可以下载任意位置的文件了。   
注意：`目录建议设成权限755，文件需要有执行权限`

-------------------------------

多使用`wget -help`，查看linux系统对wget参数的解释   
