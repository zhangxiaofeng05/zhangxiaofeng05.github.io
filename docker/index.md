# Docker

## 维基百科
https://zh.wikipedia.org/wiki/Docker  
Docker是一个开放源代码软件项目，让应用程序部署在软件货柜下的工作可以自动化进行，借此在Linux操作系统上，提供一个额外的软件抽象层，以及操作系统层虚拟化的自动管理机制。  

## docker官网
官网：https://www.docker.com/  
官网安装指南：https://docs.docker.com/install/  
docker安装软件比较简单，很适合学习，避免了linux的各种版本安装软件的繁琐。

##  Docker Hub
https://hub.docker.com/  
Docker Hub是一个由Docker公司负责维护的公共注册中心，它包含了超过15,000个可用来下载和构建容器的镜像，并且还提供认证、工作组结构、工作流工具（比如webhooks）、构建触发器以及私有工具（比如私有仓库可用于存储你并不想公开分享的镜像）。  

### 举例：docker安装MySQL
官网安装指南：https://hub.docker.com/_/mysql  
举例：  
```
docker pull mysql:5.7.28
docker run -p 3306:3306 --name mysql5.7 -e MYSQL_ROOT_PASSWORD=password -d mysql:5.7.28
```
具参数查看官网!!!  

### 举例：docker安装phpmyadmin
官网安装指南：https://hub.docker.com/r/phpmyadmin/phpmyadmin  
举例：  
```
docker pull phpmyadmin/phpmyadmin
docker run --name myadmin -d -e PMA_ARBITRARY=1 -p 6060:80 phpmyadmin/phpmyadmin
```
此命令安装，登录任意服务器地址端口，空格为分割  
![phpmyadmin](/mypng/6.png)
