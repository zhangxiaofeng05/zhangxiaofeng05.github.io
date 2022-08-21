# linux使用v2ray作为客户端

## 安装v2ray
官网：https://www.v2ray.com/  (`被墙`,如果可以，`不明白的多看官网`)  
github地址：https://github.com/v2ray/v2ray-core  
`在root用户环境下运行`  
yum 或 apt-get 安装v2ray  
或者执行安装脚本`bash <(curl -L -s https://install.direct/go.sh)`  
此脚本会自动安装以下文件：  

 - /usr/bin/v2ray/v2ray：V2Ray 程序； 
 - /usr/bin/v2ray/v2ctl：V2Ray 工具；
 - /etc/v2ray/config.json：配置文件；
 - /usr/bin/v2ray/geoip.dat：IP 数据文件
 - /usr/bin/v2ray/geosite.dat：域名数据文件

此脚本会配置自动运行脚本。自动运行脚本会在系统重启之后，自动运行 V2Ray。  

脚本运行完成后，你需要：

1. 编辑 /etc/v2ray/config.json 文件来配置你需要的代理方式；  
config.json  
```
{
        "inbound": {
            "port": 1080,
            "protocol": "socks",
            "domainOverride": ["tls","http"],
            "settings": {
            "auth": "noauth"
            }
        },
        "outbound": {
            "protocol": "vmess",
            "settings": {
            "vnext": [
                {
                "address": "216.244.76.219",
                "port": 54321, 
                "users": [
                    {
                    "id": "3cf35a68-ea46-11e9-9cab-003048d37a3c",
                    "alterId": 64,
                    "security": "aes-128-gcm"
                    }
                ]
                }
            ]
            },
        "streamSettings": {
        "network": "tcp",
        "security": "aes-128-gcm"
        }

        }
}
```
2. 运行 `service v2ray start` 来启动 V2Ray 进程；
3. 之后可以使用 service v2ray start|stop|status|reload|restart|force-reload 控制 V2Ray 的运行。  
或者使用  
```
systemctl status v2ray.service
systemctl start v2ray.service
systemctl stop v2ray.service
systemctl restart v2ray.service
```

## 图形客户端(推荐:支持订阅)  
 - Windows  
v2rayN(第三方): https://github.com/2dust/v2rayN/releases/latest  
下载v2rayN-Core.zip  
 - Linux
Qv2ray(第三方): https://github.com/lhy0403/Qv2ray/releases
下载Qv2ray.v2.4.1.linux-x64.AppImage,添加权限`chmod 755 Qv2ray.v2.4.1.linux-x64.AppImage`,双击便可执行  
具体配置参考文章:https://linger.ink/2020/linux-qv2ray-usage  
 - Mac
v2rayX(第三方): https://github.com/insisttech/v2rayX-copy/releases  
v2rayU(第三方): https://github.com/yanue/V2rayU/releases  

ps:由于是第三方依赖v2ray,需要指定下载的v2ray的路径,v2ray:https://github.com/v2ray/v2ray-core/releases ,下载v2ray-linux-64.zip  


## 免费账号  
1. https://github.com/Alvin9999/new-pac/wiki
2. https://www.freefq.com/  (被墙)
3. https://github.com/ugvf2009/Miles
