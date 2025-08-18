---
title: "Google Analytics"
date: 2025-08-12T16:51:27+08:00
draft: false

tags: [Google,Analytics]
categories: [Google]

comment: true
toc: true
---
### Google Analytics
1. 打开 Google Search Console: https://search.google.com/search-console ,登录
2. 添加网址前缀: eg: https://zhangxiaofeng05.github.io
3. 选择 HTML 标记，将一行代码添加到网站的 head 中，完成后点击 验证
4. 选择 编制索引 -> 站点地图 -> 添加新的站点地图。一般是 网址前缀+ /sitemap.xml。eg: https://zhangxiaofeng05.github.io/sitemap.xml 点击 提交。

### 替代品-umami
https://github.com/umami-software/umami  
使用官方网站: 有免费计划，最多3个网站，6个月数据，每月最多10万次获取  
私有化部署: 无限制

#### hugo网站配置
主题一般默认支持 Google Analytics,增加配置即可  
主题仓库不支持 umami,可自定义  

在自己项目的 layouts 目录里创建一个同路径文件，覆盖主题里的同名文件，不需要直接改 submodule
假设我的主题目录是:
```text
themes/PaperMod/layouts/partials/extend_head.html
```
只需要在项目根目录创建同样的路径:
```text
layouts/partials/extend_head.html
```
执行命令，复制出来
```bash
mkdir -p layouts/partials
cp themes/PaperMod/layouts/partials/extend_head.html layouts/partials/extend_head.html
```
在最下边增加以下内容
```html
{{ if site.Params.analytics.umami }}
  <script defer src="{{ site.Params.analytics.umami.url }}" data-website-id="{{ site.Params.analytics.umami.id }}"></script>
{{ end }}
```
和 Google Analytics 一样,在配置文件增加配置信息。
