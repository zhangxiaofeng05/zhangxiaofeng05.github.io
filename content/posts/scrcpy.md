---
title: "scrcpy"
date: 2025-07-28T18:59:47+08:00
draft: false

tags: [scrcpy]
categories: [mac,android]

comment: true
toc: true
---

github: https://github.com/Genymobile/scrcpy

不仅投屏，电脑还能控制手机

## 安装scrcpy
https://github.com/Genymobile/scrcpy?tab=readme-ov-file#get-the-app

### mac
https://github.com/Genymobile/scrcpy/blob/master/doc/macos.md
```bash
brew install scrcpy
brew install --cask android-platform-tools
```

## 手机只需要打开 USB 调试

红米 K60 PRO为例:   
1. 打开开发者模式  
设置 - 我的设备 - 全部参数与信息 - 连续点击 OS 版本。直到打开开发者模式

2. 打开 USB 调试  
设置 - 更多设置 - 开发者选项 - USB 调试

3. 用数据线连接手机和电脑

4. 运行 scrcpy
```bash
scrcpy
```
5. 结束连接，直接退出

## 无线连接电脑和手机
处于同一 wifi ,电脑安装 scrcpy ，手机打开 USB 调试，用数据线连接手机和电脑
```bash
adb devices  # 确保手机和电脑连接成功
```
查看手机 ip
```bash
adb shell ifconfig wlan0 | grep "inet " | awk '{print $2}'
```
设置手机调试端口
```bash
adb tcpip 5555
```
连接手机
```bash
adb connect <手机ip>:5555
```
开始投屏
```bash
scrcpy
```
结束投屏,中断命令即可。  
如果不再需要投屏，断开连接
```bash
adb disconnect <手机ip>:5555 # 断开指定设备
adb disconnect # 断开所有设备
```
关闭手机 USB 调试

