# deepin安装使用Oh My Zsh

## 安装Oh My Zsh
github地址：https://github.com/ohmyzsh/ohmyzsh  
```
sudo apt install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 将 Zsh 设置为默认 Shell
chsh -s /bin/zsh
#  查看当前所用的 Shell
echo $SHELL
# 查看系统内已安装的 Shell
cat /etc/shells
```
ps:root执行此脚本只能root使用Oh My Zsh，其他用户使用需要在那个用户下执行此安装脚本
![8](/mypng/8.png)

## 更换主题
```
vi ~/.zshrc

#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
#ZSH_THEME="amuse"
#ZSH_THEME="fishy"
#ZSH_THEME="ys"

source ~/.zshrc
```

## agnoster主题箭头无法正常显示
1. 检查是否安装PowerlineSymbols字体  
如果没有安装,官方安装文档https://powerline.readthedocs.io/en/latest/installation.html
2. 在终端选择能够正常显示箭头的字体  
PowerlineSymbols,DejaVu Sans Mono  

安装字体参考： https://github.com/powerline/fonts  
比如： `sudo apt-get install fonts-powerline`，以GitHub为准。  

deepin 15.11为例,系统已经装好字体了,但是没有正常显示箭头,在终端尝试哪个字体能够正常显示.
![9](/mypng/9.png)
