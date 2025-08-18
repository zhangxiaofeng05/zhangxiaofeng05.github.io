---
title: "解决vim粘贴错乱问题"
date: 2019-11-28T22:58:59+08:00
draft: false

tags: [vim]
categories: [Linux]

comment: true
toc: true
---
vim打开文件后  
1、在视图模式下输入  
```
:set paste
```
2、按i进入编辑模式  
3、粘贴((win)Ctrl+v | Shift+Insert(linux))  
4、关闭粘贴  
```
:set nopaste
```