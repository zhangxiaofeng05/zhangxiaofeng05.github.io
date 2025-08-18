---
title: "RustDesk"
date: 2025-07-21T21:34:45+08:00
draft: false

tags: [linux,mac,windows]
categories: [远程控制]

comment: true
toc: true
---

开源远程控制软件，客户端是开源的。  
https://github.com/rustdesk/rustdesk

可直接使用 rustdesk 默认中继服务器连接其它客户端。

## 自托管
### 搭建自托管服务器
官方文档: https://rustdesk.com/docs/zh-cn/self-host/rustdesk-server-oss/

推荐直接使用 Docker Compose 部署  
https://rustdesk.com/docs/zh-cn/self-host/rustdesk-server-oss/docker/

### 客户端配置
官方文档: https://rustdesk.com/docs/zh-cn/self-host/client-configuration/

```text
ID 服务器: IP:21116
中继服务器: IP:21117
API服务器: http://IP:21118
Key: ed25519公钥(自托管服务器,docker compose运行路径的相对路径 data/id_ed25519.pub)
```

配置一个服务器配置，可导出配置，导入到其它客户端。
## 局域网
可通过 IP 直接访问
