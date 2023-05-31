# Connect Mysql8 Error


#### 服务以前连接mysql5.7,现在连接mysql8报错
```
code: 'ER_NOT_SUPPORTED_AUTH_MODE',
errno: 1251,
sqlState: '08004',
sqlMessage: 'Client does not support authentication protocol requested by server; consider upgrading MySQL client'
```

#### 原因：
mysql5.7 认证默认是`mysql_native_password`，mysql8默认是`caching_sha2_password`

#### 解决方式：
1. 创建数据库时，指明`mysql_native_password`
```bash
docker run -d --name mysql8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -v mysql8:/var/lib/mysql mysql:8.0 --default-authentication-plugin=mysql_native_password
```
2. 修改数据库，将用户认证的`caching_sha2_password`改为`mysql_native_password`
```sql
# $ mysql -u root -p
use mysql;
select host,user,plugin,authentication_string from mysql.user;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
# ... 如果还有其他USER，把其他USER(mysql.sys,mysql.session,mysql.infoschema)也替换
flush privileges;
```
3. 升级客户端，支持最新的认证


#### reference:   
https://stackoverflow.com/questions/50093144/mysql-8-0-client-does-not-support-authentication-protocol-requested-by-server
