# linux安装mariadb并配置phpmyadmin

## mariadb
### 维基百科
MariaDB是MySQL关系数据库管理系统的一个复刻，由社区开发，有商业支持，旨在继续保持在GNU GPL下开源。MariaDB的开发是由MySQL的一些原始开发者领导的，他们担心甲骨文公司收购MySQL后会有一些隐患。

linux现在默认的MySQL是mariadb。
### 安装mariadb
$ sudo apt-get install mariadb-server mariadb-client
### 新建用户授权
以root身份输入mariadb，进入mariadb
```
# mariadb
> use mysql;                                                           # 进入mysql数据库
mysql> CREATE USER 'zhang'@'localhost' IDENTIFIED BY '123456';         # zhang是用户名,123456是密码
mysql> GRANT ALL PRIVILEGES ON *.* TO 'zhang'@'localhost' WITH GRANT OPTION;   # 授权
mysql> FLUSH PRIVILEGES;
或者(推荐下边的，可以登录，上边只能本地登录)
mysql> CREATE USER 'zhang'@'%' IDENTIFIED BY '123456';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'zhang'@'%' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
```
查看user信息
```
> select user,host,password from user;
```
至此，可以用新建的用户登录了。

## phpmyadmin
### 维基百科
phpMyAdmin 是一个以PHP为基础，以Web-Base方式架构在网站主机上的MySQL的数据库管理工具，让管理者可用Web接口管理MySQL数据库。借由此Web接口可以成为一个简易方式输入繁杂SQL语法的较佳途径，尤其要处理大量数据的导入及导出更为方便。其中一个更大的优势在于由于phpMyAdmin跟其他PHP程序一样在网页服务器上运行，但是您可以在任何地方使用这些程序产生的HTML页面，也就是于远程管理MySQL数据库，方便的创建、修改、删除数据库及数据表。也可借由phpMyAdmin创建常用的php语法，方便编写网页时所需要的sql语法正确性。

### centos7安装配置phpmyadmin+nginx
安装
```
yum install phpMyAdmin
yum install php php-fpm php-mysql php-mbstring -y
```
/etc/nginx/conf.d/phpMyAdmin.conf
```
server {
    listen       6060;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/phpMyAdmin;
        index  index.php index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        root           phpMyAdmin;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  /usr/share/phpMyAdmin$fastcgi_script_name;
        include        fastcgi_params;
    }

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
```
/etc/phpMyAdmin/config.inc.php
```
<?php
/**
 * phpMyAdmin configuration file, you can use it as base for the manual
 * configuration. For easier setup you can use "setup/".
 *
 * All directives are explained in Documentation.html and on phpMyAdmin
 * wiki <http://wiki.phpmyadmin.net>.
 */

/*
 * This is needed for cookie based authentication to encrypt password in
 * cookie
 */
$cfg['blowfish_secret'] = 'au1LXERWlgCnpaE7fS008WLYs4Xbgny0'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

/**
 * Server(s) configuration
 */
$i = 0;

// The $cfg['Servers'] array starts with $cfg['Servers'][1].  Do not use
// $cfg['Servers'][0]. You can disable a server config entry by setting host
// to ''. If you want more than one server, just copy following section
// (including $i incrementation) serveral times. There is no need to define
// full server array, just define values you need to change.
$i++;
/*
$cfg['Servers'][$i]['host']          = 'localhost'; // MySQL hostname or IP address
$cfg['Servers'][$i]['port']          = '';          // MySQL port - leave blank for default port
$cfg['Servers'][$i]['socket']        = '';          // Path to the socket - leave blank for default socket
$cfg['Servers'][$i]['connect_type']  = 'tcp';       // How to connect to MySQL server ('tcp' or 'socket')
$cfg['Servers'][$i]['extension']     = 'mysqli';    // The php MySQL extension to use ('mysql' or 'mysqli')
$cfg['Servers'][$i]['compress']      = FALSE;       // Use compressed protocol for the MySQL connection
                                                    // (requires PHP >= 4.3.0)
$cfg['Servers'][$i]['controluser']   = '';          // MySQL control user settings
                                                    // (this user must have read-only
$cfg['Servers'][$i]['controlpass']   = '';          // access to the "mysql/user"
                                                    // and "mysql/db" tables).
                                                    // The controluser is also
                                                    // used for all relational
                                                    // features (pmadb)
$cfg['Servers'][$i]['auth_type']     = 'cookie';    // Authentication method (config, http or cookie based)?
$cfg['Servers'][$i]['user']          = '';          // MySQL user
$cfg['Servers'][$i]['password']      = '';          // MySQL password (only needed
                                                    // with 'config' auth_type)
$cfg['Servers'][$i]['only_db']       = '';          // If set to a db-name, only
                                                    // this db is displayed in left frame
                                                    // It may also be an array of db-names, where sorting order is relevant.
$cfg['Servers'][$i]['hide_db']       = '';          // Database name to be hidden from listings
$cfg['Servers'][$i]['verbose']       = '';          // Verbose name for this host - leave blank to show the hostname

$cfg['Servers'][$i]['pmadb']         = '';          // Database used for Relation, Bookmark and PDF Features
                                                    // (see scripts/create_tables.sql)
                                                    //   - leave blank for no support
                                                    //     DEFAULT: 'phpmyadmin'
$cfg['Servers'][$i]['bookmarktable'] = '';          // Bookmark table
                                                    //   - leave blank for no bookmark support
                                                    //     DEFAULT: 'pma_bookmark'
$cfg['Servers'][$i]['relation']      = '';          // table to describe the relation between links (see doc)
                                                    //   - leave blank for no relation-links support
                                                    //     DEFAULT: 'pma_relation'
$cfg['Servers'][$i]['table_info']    = '';          // table to describe the display fields
                                                    //   - leave blank for no display fields support
                                                    //     DEFAULT: 'pma_table_info'
$cfg['Servers'][$i]['table_coords']  = '';          // table to describe the tables position for the PDF schema
                                                    //   - leave blank for no PDF schema support
                                                    //     DEFAULT: 'pma_table_coords'
$cfg['Servers'][$i]['pdf_pages']     = '';          // table to describe pages of relationpdf
                                                    //   - leave blank if you don't want to use this
                                                    //     DEFAULT: 'pma_pdf_pages'
$cfg['Servers'][$i]['column_info']   = '';          // table to store column information
                                                    //   - leave blank for no column comments/mime types
                                                    //     DEFAULT: 'pma_column_info'
$cfg['Servers'][$i]['history']       = '';          // table to store SQL history
                                                    //   - leave blank for no SQL query history
                                                    //     DEFAULT: 'pma_history'
$cfg['Servers'][$i]['verbose_check'] = TRUE;        // set to FALSE if you know that your pma_* tables
                                                    // are up to date. This prevents compatibility
                                                    // checks and thereby increases performance.
$cfg['Servers'][$i]['AllowRoot']     = TRUE;        // whether to allow root login
$cfg['Servers'][$i]['AllowDeny']['order']           // Host authentication order, leave blank to not use
                                     = '';
$cfg['Servers'][$i]['AllowDeny']['rules']           // Host authentication rules, leave blank for defaults
                                     = array();
$cfg['Servers'][$i]['AllowNoPassword']              // Allow logins without a password. Do not change the FALSE
                                     = FALSE;       // default unless you're running a passwordless MySQL server
$cfg['Servers'][$i]['designer_coords']              // Leave blank (default) for no Designer support, otherwise
                                     = '';          // set to suggested 'pma_designer_coords' if really needed
$cfg['Servers'][$i]['bs_garbage_threshold']         // Blobstreaming: Recommented default value from upstream
                                     = 50;          //   DEFAULT: '50'
$cfg['Servers'][$i]['bs_repository_threshold']      // Blobstreaming: Recommented default value from upstream
                                     = '32M';       //   DEFAULT: '32M'
$cfg['Servers'][$i]['bs_temp_blob_timeout']         // Blobstreaming: Recommented default value from upstream
                                     = 600;         //   DEFAULT: '600'
$cfg['Servers'][$i]['bs_temp_log_threshold']        // Blobstreaming: Recommented default value from upstream
                                     = '32M';       //   DEFAULT: '32M'
*/
/*
 * End of servers configuration
 */

/*
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '/var/lib/phpMyAdmin/upload';
$cfg['SaveDir']   = '/var/lib/phpMyAdmin/save';

/*
 * Disable the default warning that is displayed on the DB Details Structure
 * page if any of the required Tables for the relation features is not found
 */
$cfg['PmaNoRelation_DisableWarning'] = TRUE;

/*
 * phpMyAdmin 4.4.x is no longer maintained by upstream, but security fixes
 * are still backported by downstream.
 */
$cfg['VersionCheck'] = FALSE;

$cfg['AllowArbitraryServer'] = true; /* 允许自定义服务器，默认为false */
?>
```
命令
```
systemctl restart php-fpm.service
systemctl restart nginx.service
```

### deepin安装phpmyadmin+apache2
$ sudo apt-get install apache2  
$ sudo apt-get install phpmyadmin
### 修改配置
位置： /etc/apache2/apache2.conf  
$ sudo vim /etc/apache2/apache2.conf  
在文件底部加上  
`Include /etc/phpmyadmin/apache.conf`  
在地址栏输入http://localhost/phpmyadmin/  
输入用户和密码即可登录  
登录后能正常使用，但底部显示默认连出错，需要将默认配置注释掉  
$ sudo vi /etc/phpmyadmin/config.inc.php  
注释图片的两处   
![phpmyadmin](/mypng/7.png)  

目前只能连接本地数据库，端口也不能修改,下边是解决方法  
修改配置  
$ sudo vi /etc/phpmyadmin/config.inc.php  
在文件底部加上  
`$cfg['AllowArbitraryServer'] = true;  /* 允许自定义服务器，默认为false */`  

关闭版本检查更新
修改version_check.php
```
echo json_encode(array());//添加这一行，下边的注释掉
/*
if (empty($versionDetails)) {
    echo json_encode(array());
} else {
    $latestCompatible = $versionInformation->getLatestCompatibleVersion(
        $versionDetails->releases
    );
    $version = '';
    $date = '';
    if ($latestCompatible != null) {
        $version = $latestCompatible['version'];
        $date = $latestCompatible['date'];
    }
    echo json_encode(
        array(
            'version' => (! empty($version) ? $version : ''),
            'date' => (! empty($date) ? $date : ''),
        )
    );
}
 */

```
-----------

参考地址  
https://support.plesk.com/hc/en-us/articles/360005493133-Unable-to-register-remote-MySQL-server-Host-is-not-allowed-to-connect-to-this-MySQL-server
