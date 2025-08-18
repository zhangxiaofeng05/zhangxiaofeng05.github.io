---
title: "windows系统"
date: 2025-07-21T22:19:36+08:00
draft: false

tags: [windows]
categories: [windows]

comment: true
toc: true
---

## windows镜像
### 微软官方镜像
英文: https://www.microsoft.com/en-us/software-download/windows11

简体中文: https://www.microsoft.com/zh-cn/software-download/windows11  
不要选家庭版,选 适用于 x64 设备的多版本 ISO

建议安装专业版

### 创建 USB 启动盘

1. 软碟通 https://www.ultraiso.net/  
2. Rufus[推荐] https://rufus.ie/zh/
3. Etcher https://etcher.balena.io/
4. Ventoy https://www.ventoy.net/cn/index.html

安装windows时，选择【针对个人使用设置】会强制登录微软账户。选择另一个【注册工作或学校账户】- 登录选项 - 改为域加入。跳过登录微软账户。

## PE 镜像
https://www.hirensbootcd.org/  

可重置 Windows 密码

## 激活windows/office
1. http://www.yishimei.cn/network/319.html  
各个版本系统和 office 都能激活,激活时需要关闭防火墙
2. https://kms.cx/ 【推荐】  
安全，官方支持的kms激活方式，激活半年，无限续
3. https://github.com/massgravel/Microsoft-Activation-Scripts  
开源激活脚本

### windows
KMS 客户端激活和产品密钥【官方激活密钥】,官方支持使用 KMS 激活，公开的激活密钥  
https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys

查询激活状态
```bash
slmgr /xpr
```
查询激活详细信息
```bash
slmgr /dlv
```

### office
基于 KMS的 GVLK  
https://learn.microsoft.com/zh-cn/office/volume-license-activation/gvlks

查看 office激活状态
```bash
cd C:\Program Files\Microsoft Office\Office16
cscript ospp.vbs /dstatus
```

## 安装office  
### 官方镜像
office部署工具  
https://www.microsoft.com/en-us/download/details.aspx?id=49117  
office自定义工具  
https://config.office.com/deploymentsettings  

1. 下载office部署工具
2. 在office自定义工具页面，选择批量许可证的office【例如：Office 专业增强版 2019 - 批量许可证】导出配置,重命名为config,文件中包含官方激活密钥
3. 新建文件夹office,运行office部署工具，安装到此文件夹，将config.xml 也放到此文件夹下
4. 下载命令
```bash
setup /download config.xml
```
5. 安装命令
```
setup /configure config.xml
```
使用kms.cx激活系统安装批量许可证的office安装完就是激活的。

### 第三方镜像
1. msdn
