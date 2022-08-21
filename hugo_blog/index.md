# hugo搭建博客，部署到GitHub

## hugo站点
hugo官网：https://gohugo.io/  
安装和使用，先参考官网  
安装：使用命令或者从GitHub下载 https://github.com/gohugoio/hugo  
检查安装：$ hugo version  

生成站点 $ hugo new site blogHugo  
进入站点 $ cd blogHugo  
使用主题(https://github.com/olOwOlo/hugo-theme-even) $ `git clone https://github.com/olOwOlo/hugo-theme-even themes/even`  
安装主题上的说明进行配置，注意此主题生成新文件为$ hugo new post/some-content.md  

本地运行预览博客 $ hugo server -D  
浏览器 $ http://localhost:1313/ 

## 部署到GitHub  
在GitHub新建仓库 username.github.io  
渲染md文件 $ `hugo --theme=even --baseUrl="https://username.github.io" --buildDrafts`

此时生成了public目录  
执行命令 
```
cd public
git init
git commit -m "first commit"
git remote add origin git@github.com:username/blogHugo.git
git push origin master
```

以后再提交，在站点执行此脚本 $ `sh gitHub.sh`  
gitHub.sh
```
hugo --theme=even --baseUrl="https://username.github.io" --buildDrafts
cd public
git add .
git commit -m "update"
git push origin master 
cd ..
```

## 原文件放入私有仓库
第一次使用，在站点目录下
```
git init
git add .
git commit -m "first commit"
git remote add origin git@github.com:username/blogHugo.git
git push origin master
```
以后可以使用脚本 $ `sh zhang.sh`  
zhang.sh
```
git add .
git commit -m "update"
git push origin master
sh gitHub.sh
```
