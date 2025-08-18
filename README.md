![deploy](https://github.com/zhangxiaofeng05/zhangxiaofeng05.github.io/actions/workflows/hugo.yaml/badge.svg?branch=main)
![GitHub repo file or directory count (in path)](https://img.shields.io/github/directory-file-count/zhangxiaofeng05/zhangxiaofeng05.github.io/content%2Fposts)

## local
### install hugo
```bash
brew install hugo
```

### init
```bash
hugo new site zhangxiaofeng05.github.io --format yaml
git init
git remote add origin git@github.com:zhangxiaofeng05/zhangxiaofeng05.github.io.git
git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
```

### clone
```bash
git clone git@github.com:zhangxiaofeng05/zhangxiaofeng05.github.io.git
```

### themes
```bash
git submodule update --init --recursive
```

### Add content
```bash
hugo new content content/posts/my-first-post.md
```

### run
```bash
hugo server
```

## github actions
https://gohugo.io/host-and-deploy/host-on-github-pages/
