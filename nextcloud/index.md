# Nextcloud云盘

## 维基百科
### Nextcloud
Nextcloud是一套用于创建网络硬盘的客户端－服务器软件。其功能与Dropbox相近，但Nextcloud是自由及开放源代码软件，每个人都可以在私人服务器上安装并运行它。

与Dropbox等专有服务相比，Nextcloud的开放架构让用户可以利用应用程序的方式在服务器上新增额外的功能，并让用户可以完全掌控自己的数据。

ownCloud原先的开发者弗兰克·卡利切创建了ownCloud的分支——Nextcloud，继而让卡利切与其他原先的ownCloud团队成员持续积极地开发。
### 特性
Nextcloud的文件存储在一般的目录结构中，并可透过WebDAV访问。用户的文件会在传输时加密。Nextcloud可与在Windows（Windows XP、Vista、7与8）、macOS（10.6或更新版本）或是多种Linux散布版上运行的客户端同步。

Nextcloud用户可以管理日历（使用CalDAV）、联系人（CardDAV）、计划工作与流媒体（Ampache）。

从管理的角度来看，Nextcloud允许用户与组群管理（透过OpenID或LDAP）。透过用户间与／或组群间的读／写权限调整达到分享文件的目的。另外，Nextcloud的用户可以创建公开的URL来分享文件。也可以记录与文件相关的动作，以及利用文件访问规则来禁止对特定文件的访问。

此外，用户也可以透过浏览器使用Nextcloud的文本编辑器、书签服务、缩略网址服务、相册、RSS阅读器与文件查看器。因为有良好的扩展性，Nextcloud可以透过鼠标点一下即可完成安装的应用程序强化其功能，并可连线至Dropbox、Google云端硬盘与Amazon S3。

### 架构
为了让个人电脑与Nextcloud服务器同步，Windows、macOS、FreeBSD或Linux上都有客户端可以使用。行动客户端则在iOS与Android设备上提供。也可以使用浏览器访问、管理与上传任何文件与数据。任何在设置好同步的文件系统上的变更都会推送到所有链接到该用户账号的电脑与移动设备上。

Nextcloud服务器是以PHP与JavaScript脚本语言撰写。对于远程访问，它采用的是SabreDAV，其为一开放源代码的WebDAV服务器。Nextcloud可与多种数据库管理系统一同运作，包含了SQLite、MariaDB、MySQL、Oracle数据库与PostgreSQL。

## centos7安装
官方安装指南: https://docs.nextcloud.com/server/latest/admin_manual/installation/source_installation.html  
### 环境
```
LSB Version:	:core-4.1-amd64:core-4.1-noarch
Distributor ID:	CentOS
Description:	CentOS Linux release 7.7.1908 (Core)
Release:	7.7.1908
Codename:	Core

PHP 7.2.27 (cli) (built: Jan 26 2020 15:49:49) ( NTS )

Server version: 5.5.64-MariaDB MariaDB Server

Nextcloud 17.0.5
```

Nextcloud官网: https://nextcloud.com/  
### 安装httpd(apache),php,php-fpm,MariaDB
自行百度,谷歌.如果服务器上还有nginx,建议apache更改默认端口  
/etc/httpd/conf/httpd.conf(我的改为7000)  
php-fpm默认端口9000  
ps:安装php-fpm需要注意版本是否支持要安装nextcloud版本  
### 下载nextcloud
https://nextcloud.com/changelog/  
下载nextcloud-17.0.5.zip,解压至/var/www  
/var/www/nextcloud是根目录,有index.php,在此目录下新建目录data  
```
cd /var/www/nextcloud/
mkdir data
cd /var/www
chmod -R 755 nextcloud/
chown -R apache:apache nextcloud/
```
### 配置httpd  
`vim /etc/httpd/conf.d/nextcloud.conf`  
```
Alias /nextcloud "/var/www/nextcloud/"

<Directory /var/www/nextcloud/>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews

  <IfModule mod_dav.c>
    Dav off
  </IfModule>

</Directory>
```
重启httpd,php-fpm,访问,http://服务器地址:7000/nextcloud  
安装完成,自动进入登录界面  

### 离线安装Nextcloud应用
参考文章: https://www.himstudy.net/%E6%89%8B%E5%8A%A8%E7%A6%BB%E7%BA%BF%E5%AE%89%E8%A3%85nextcloud%E5%BA%94%E7%94%A8/  
应用官网: https://apps.nextcloud.com/  
主要操作:将对应版本的应用下载,解压到nextcloud根目录下的apps下边,然后在设置中启用.

## 客户端
官网有对应版本的客户端,下载使用即可.  
多平台挂载WebDAV方法的文章： https://www.leeyiding.com/archives/47/  

### linux资源管理器挂载nextcloud
nextcloud支持WebDAV  
官网指南: https://docs.nextcloud.com/server/17/user_manual/files/access_webdav.html  
本人用的是linux(deepin)  
需要的操作:安装Nautilus,davfs2  
`dav://39.107.227.122:7000/nextcloud/remote.php/dav/files/admin/`  
在nextcloud中可以获取地址,仔细看Nautilus连接到服务器使用的前缀换成对的前缀,输入nextcloud的用户名和密码就ok了.操作完成同步网盘,误删文件可以在回收站中恢复.  
参考： https://www.moerats.com/archives/317/    
```
sudo apt-get install davfs2
sudo mkdir /mnt/webdav
sudo mount -t davfs http://39.107.227.122:7000/nextcloud/remote.php/webdav /mnt/webdav
```

### win10挂载nextcloud
依旧使用WebDAV  
需要安装RaiDrive,官网： https://www.raidrive.com/  
配置网页地址，用户名，密码就可以挂载到本地盘符了。  
![](/mypng/10.png)

参考文章: https://www.wangzhengzhen.com/?p=1003
