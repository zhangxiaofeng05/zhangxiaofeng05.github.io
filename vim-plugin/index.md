# vim安装插件

> 注意：推荐参考：[https://github.com/zhangxiaofeng05/dotfiles](https://github.com/zhangxiaofeng05/dotfiles)
## 插件管理器(Vundle.vim)
### 安装
github地址：https://github.com/VundleVim/Vundle.vim  (`仔细看README.md`)

1. clone  
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
2. 修改配置文件  
`vim ~/.vimrc`  
```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"plugin------------------------"
“Plugin '插件名'  
"看作者的README.md，有示例

"plugin------------------------"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

```

### Install Plugins
 - Launch `vim` and run `:PluginInstall`
 - To install from command line: `vim +PluginInstall +qall`

## 安装NERDTree

### 安装此插件需要安装插件管理器  
github地址：https://github.com/preservim/nerdtree  (`仔细看README.md`)

1. clone
```
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
```
2. 修改配置文件
`vim ~/.vimrc`  
```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"plugin------------------------"
Plugin 'scrooloose/nerdtree'     "新加的      


"plugin------------------------"

"lionng set start--------------"
"[Ctrl + n] to open NERDTree      "新加的  不设此快捷键需要在vim中输入:NERDTree
map <C-n> :NERDTreeToggle<CR>     "新加的  
"lionng set end----------------"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

```

### Install Plugins
 - Launch `vim` and run `:PluginInstall`
 - To install from command line: `vim +PluginInstall +qall`


## 快捷键
在`NERDTree`中输入？即可获取帮助。

## root用户不能使用插件(解决)
在root用户下按上述描述安装

## vim版本升级
为什么要升级vim版本,安装插件依赖的vim有版本要求.

 - CentOS7 yum 升级vim 8

```
# 卸载老的vim
yum remove vim-* -y
# 下载第三方yum源
wget -P /etc/yum.repos.d/  https://copr.fedorainfracloud.org/coprs/lbiaggi/vim80-ligatures/repo/epel-7/lbiaggi-vim80-ligatures-epel-7.repo
# install vim
yum  install vim-enhanced sudo -y
# 验证vim版本
rpm -qa |grep vim
```

## 代码自动补全插件
### YouCompleteMe
GitHub地址: https://github.com/ycm-core/YouCompleteMe

> Make sure you have Vim 7.4.1578 with Python 3 support. The Vim package on Fedora 27 and later and the pre-installed Vim on Ubuntu 16.04 and later are recent enough. You can see the version of Vim installed by running vim --version. If the version is too old, you may need to compile Vim from source (don't worry, it's easy).

`重点`:vim版本和vim支持python3,如果不符合,考虑编译vim源码,vim源码的GitHub地址:https://github.com/vim/vim 如有疑问,详细看插件的README

vim安装YouCompleteMe挺麻烦的.本人使用的是deepin,`deepin官方提供的方法`:https://wiki.deepin.org/wiki/Vim  
除了通过 Vundle 安装语法补全 YouCompleteMe，也可以自己手动编译安装，这里有另外一种更加简单的方法。
```
# 试试这个命令，看是否已经安装 vim-addons
$ vim-addons
# 如果没有安装 vim-addons，则需安装 vim-addon-manager
$ sudo apt-get install vim-addon-manager
# 开始安装 YouCompleteMe
$ sudo apt-get install vim-youcompleteme
# 将 YCM 加入 addons 管理器中
$ vim-addons install youcompleteme
```

## vim终极插件
### SpaceVim(推荐)
GitHub地址:https://github.com/SpaceVim/SpaceVim  
安装很方便,使用体验也很nice.具体信息看官方文档  
英文官网:https://spacevim.org/  
中文官网:https://spacevim.org/cn/  

### vimplus
GitHub地址: https://github.com/chxuan/vimplus  
一键安装脚本,很方便,支持很多linux发行版,具体信息看作者的README  
`注意`:会删除你的vim,下载vim源码,重新编译,具体定制看install.sh


