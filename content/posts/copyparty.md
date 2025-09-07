---
title: "copyparty"
date: 2025-09-07T21:23:48+08:00
draft: false

tags: [tool]
categories: [工具]

comment: true
toc: true
---
github: https://github.com/9001/copyparty

便携式文件服务器，具有加速可恢复上传、重复数据删除、WebDAV、FTP、TFTP、零配置、媒体索引器、缩略图++ 等功能，全部包含在一个文件中，无依赖项

下载运行文件
```bash
https://github.com/9001/copyparty/releases/latest/download/copyparty-sfx.py
```

配置文件 copyparty.conf
```yaml
# not actually YAML but lets pretend:
# -*- mode: yaml -*-
# vim: ft=yaml:

# append some arguments to the commandline;
# accepts anything listed in --help (leading dashes are optional)
# and inline comments are OK if there is 2 spaces before the '#'
[global]
  p: 3923  # listen on ports 8086 and 3939
  #e2dsa  # enable file indexing and filesystem scanning
  #e2ts   # and enable multimedia indexing
  #z, qr  # and zeroconf and qrcode (you can comma-separate arguments)

# create users:
[accounts]
  firefly: 123123   # username: password
  passion: 123456

# create volumes:
[/]         # create a volume at "/" (the webroot), which will
  .         # share the contents of "." (the current directory)
  accs:
    r: passion    # everyone gets read-access, but
    rwd: firefly  # the user "ed" gets read-write

# this entire config file can be replaced with these arguments:
# -u ed:123 -u k:k -v .::r:a,ed -v priv:priv:r,k:rw,ed -v /home/ed/Music:music:r -v /home/ed/inc:dump:w:c,e2d,nodupe -v /home/ed/inc/sharex:sharex:wG:c,e2d,d2t,fk=4
# but note that the config file always wins in case of conflicts
```
指定服务端口，创建 firefly账户，有读写删除权限。创建 passion账户，有读权限。

运行命令
```bash
./copyparty-sfx.py -c ./copyparty.conf
```
