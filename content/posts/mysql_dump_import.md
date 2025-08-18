---
title: "mysql 全部数据导出导入"
date: 2025-05-17T18:20:28+08:00
draft: false

tags: [mysql]
categories: [mysql]

comment: true
toc: true
---

## 导出导入数据库
### 导出所有数据库
```bash
mysqldump -u root -p --host=127.0.0.1 --all-databases > all_dump.sql
```

### 导入所有数据库
```bash
mysql -u root -p --host=127.0.0.1 < all_dump.sql
```

## 数据库免费软件
1. [dbeaver-community](https://dbeaver.io)
```bash
brew install --cask dbeaver-community
```
https://formulae.brew.sh/cask/dbeaver-community

2. [navicat-premium-lite](https://www.navicat.com/en/products/navicat-premium-lite)
```bash
brew install --cask navicat-premium-lite
```
https://formulae.brew.sh/cask/navicat-premium-lite
