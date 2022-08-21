# vim基础配置


## 我的配置
系统的vim的配置文件在  
`/etc/vim/vimrc`  
当前用户的vim配置文件  
`~/.vimrc`

```
" --------------zhangxiaofeng----------------
" 显示行号 或者 set number
set nu
" 语法高亮,自动识别代码,使用多种颜色显示
syntax on
" 不与vi兼容,采用vim自己的操作命令
set nocompatible
" 不支持鼠标,如果想支持把-去掉
set mouse-=a
" 使用utf-8编码
set encoding=utf-8
" 高亮度搜寻
set hlsearch
" 输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set incsearch
" 设置主题
" colorscheme molokai
colorscheme desert
 
" 高亮显示当前行/列
set cursorline                                                                                                                          
set cursorcolumn
" 修改行/列线的外观
" highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
" 按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set autoindent
" 按下 Tab 键时，Vim 显示的空格数
set tabstop=4
" 在文本上按下>> <<等缩进,每一级的字符数
set shiftwidth=4
" 光标遇到括号,自动高亮对应的括号
set showmatch
```

