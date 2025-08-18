---
title: "Screego 浏览器屏幕共享"
date: 2025-08-15T23:11:29+08:00
draft: false

tags: [browser]
categories: [browser]

comment: true
toc: true
---
GitHub地址: https://github.com/screego/server  
开发人员的屏幕共享,直接用浏览器

## docker部署
https://screego.net/#/install?id=docker

获取公网 ip  
```bash
curl 'https://api.ipify.org'

curl ipinfo.io
```
docker启动,替换EXTERNALIP为公网 ip
```bash
docker run -d --name screego -p 3478:3478 -p 5050:5050 -e SCREEGO_EXTERNAL_IP=EXTERNALIP ghcr.io/screego/server:1.12.0
```

http://EXTERNALIP:5050 是不能屏幕共享，需要用 https 访问

### 自签名证书配置 https
生成自签名证书
```
mkdir -p certs
cd certs

# 生成私钥
openssl genrsa -out screego.key 2048

# 生成证书请求
openssl req -new -key screego.key -out screego.csr

# 用自己的 key 签发证书（有效期 1 年）
openssl x509 -req -days 365 -in screego.csr -signkey screego.key -out screego.crt
```
执行后会有 screego.crt 公钥 和 screego.key 私钥 两个文件

使用 1Panel 在页面配置反向代理 或者 使用 nginx 等配置反向代理, 将 5050 端口反向代理到 443 端口

访问: https://EXTERNALIP

### Let's Encrypt 证书配置 https
需要绑定域名，然后在 1Panel 中配置 Let's Encrypt 证书  
使用 https://github.com/acmesh-official/acme.sh 生成证书

