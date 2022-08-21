# 安装jdk


# Linux
## 下载
官网：https://www.oracle.com/technetwork/java/javase/downloads/index.html

## 配置环境
解压到/opt
``` Bash
sudo tar -zxf jdk-8u211-linux-x64.tar.gz -C /opt/
```
修改/etc/profile文件
``` Bash
sudo vi /etc/profile
```
把下面的添加到文件的末尾
```
export JAVA_HOME=/opt/jdk1.8.0_211
export JRE_HOME=/opt/jdk1.8.0_211/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
```
使修改后的文件生效
``` Bash
source /etc/profile
```

# Windows
## 下载
官网：http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
## 安装
我选择默认安装
```
C:\Program Files\Java\jdk1.8.0_211
C:\Program Files\Java\jre1.8.0_211
```
## 配置环境

 - 新建系统变量JAVA_HOME

```
变量名：JAVA_HOME
变量值：C:\Program Files\Java\jdk1.8.0_211
```
 - 新建系统变量CLASSPATH

```
变量名：CLASSPATH
变量值：.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
```
 - 在系统变量Path中添加
 
```
%JAVA_HOME%\bin
%JAVA_HOME%\jre\bin
```

# 测试是否成功
``` Bash
java -version
java
javac
```

