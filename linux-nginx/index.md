# linux安装并配置nginx

## 维基百科
Nginx是异步框架的网页服务器，也可以用作反向代理、负载平衡器和HTTP缓存。

## 安装
官网：https://www.nginx.com/  
官网安装文档：http://nginx.org/en/docs/install.html  
安装完成：http://127.0.0.1/
## 管理命令
```
systemctl restart nginx.service    重启
systemctl status nginx.service     查看运行状态
systemctl start nginx.service      启动
systemctl stop nginx.service       关闭

systemctl enable nginx.service     开机自启
systemctl disable nginx.service    关闭开机自启
```

## 默认配置文件
以CentOS/7.3.1611、 nginx/1.12.2为例：  
默认配置：`/etc/nginx/nginx.conf`  
```
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

#user nginx;
user root;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-streamo;


    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

    autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}

```
自己新加的conf可以放在`cd /etc/nginx/conf.d`目录下  
## 自定义的配置
zhang.conf
```
server {
listen       5000 default_server;
listen       [::]:5000 default_server;
server_name  _;
charset utf-8;
root    /root/nginxroot;

# Load configuration files for the default server block.
include /etc/nginx/default.d/*.conf;

autoindex on;
autoindex_exact_size off;
autoindex_localtime on;

location / {
}

error_page 404 /404.html;
    location = /40x.html {
}

error_page 500 502 503 504 /50x.html;
    location = /50x.html {
}
}

```
打开：http://127.0.0.1:5000/
