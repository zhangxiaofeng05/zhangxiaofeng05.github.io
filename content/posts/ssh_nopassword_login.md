---
title: "ssh免密码登录"
date: 2024-07-26T09:11:13+08:00
draft: false

tags: [ssh]
categories: [ssh]

comment: true
toc: true
---

配置SSH无密码登录涉及使用SSH密钥对进行身份验证。以下是步骤：

## 1. 生成SSH密钥对
在客户端机器上（即你要登录的机器），使用以下命令生成SSH密钥对：
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
-t rsa：生成 RSA 类型密钥（也可以用 ed25519，更安全）  
-b 4096：RSA 密钥长度  
-C：注释（可选）  
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
你会被提示输入文件保存位置（默认是~/.ssh/id_rsa）和密码短语（可以留空以便无密码登录）。

## 2. 复制公钥到远程主机
使用ssh-copy-id命令将公钥复制到远程主机上：
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub username@remote_host
```
替换username为远程主机上的用户名，remote_host为远程主机的IP地址或域名。此命令会将公钥添加到远程主机上的~/.ssh/authorized_keys文件中。

如果没有ssh-copy-id，可以手动复制公钥：
```bash
cat ~/.ssh/id_rsa.pub | ssh username@remote_host 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
```
也可以将~/.ssh/id_rsa.pub内容复制到服务器上的~/.ssh/authorized_keys

## 3. 确保权限设置正确
确保远程主机上的~/.ssh目录和~/.ssh/authorized_keys文件的权限设置正确：
```bash
ssh username@remote_host
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## 4. 测试无密码登录
现在你可以测试无密码登录：
```bash
ssh username@remote_host
```
如果一切正常，你应该能够无密码登录到远程主机。

## 5. 其他配置（可选）
为了更好地管理SSH连接，可以在~/.ssh/config文件中添加配置：
```text
Host remote_host
    HostName remote_host
    User username
    IdentityFile ~/.ssh/id_rsa
```
这样你可以通过以下命令登录：
```bash
ssh remote_host
```
替换 remote_host 为远程主机的别名。这样可以避免每次都输入完整的用户名和主机名。

