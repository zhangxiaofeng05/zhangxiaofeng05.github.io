---
title: "frp"
date: 2026-07-08T23:02:49+08:00
draft: false

tags: [frp,proxy]
categories: [frp,proxy]

comment: true
toc: true
---
github: https://github.com/fatedier/frp

## server
frps.toml
```toml
bindPort = 10001 # 这个端口是所有转发请求传入服务器的端口，避免默认端口7000，10000以上端口
auth.token = "***" # 在引号内填写和客户端相同的token值
```
run
```bash
./frps -c ./frps.toml
```

## client
frpc.toml
```toml
serverAddr = "x.x.x.x" # 公网服务器地址
serverPort = 10001 # 这个端口是所有转发请求传入服务器的端口
auth.token = "***" # 在引号内填写和服务器相同的token值

[[proxies]]
name = "foo" # 这个name是唯一的
type = "tcp"
localIP = "127.0.0.1"
localPort = 8080 # 这里改成本地服务的端口
remotePort = 8081 # 这里的remoteprot就是要在服务器上穿透的端口,请求对应上一行的本地端口
```
run
```bash
./frpc -c ./frpc.toml
```
