---
title: "代码管理"
date: 2022-10-20T23:09:19+08:00
draft: false

tags: [git,github]
categories: [工具]

comment: true
toc: true
---

## git
### 每个仓库设置Git用户名
```bash
git config --global user.name "username"
git config --global user.email "email address"
```
### 一个仓库设置Git用户名
```bash
git config user.name "username"
git config user.email "email address"
```
https://docs.github.com/cn/get-started/getting-started-with-git/setting-your-username-in-git

```bash
# 生成ssh-key
ssh-keygen -t rsa -C "email address"
# 测试链接GitHub
ssh -T git@github.com
```

### GitHub
https://cli.github.com/  
