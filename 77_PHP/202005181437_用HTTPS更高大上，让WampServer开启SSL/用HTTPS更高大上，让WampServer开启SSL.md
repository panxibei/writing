用HTTPS更高大上，让WampServer开启SSL

副标题：不用HTTPS都感觉不帅了



> 微信公众号：@网管小贾
>
> 技术博客：@www.sysadm.cc



HTTPS在现今时代背景下已经日渐流行，而且各大网站早已经支持HTTPS了。

既安全可靠，同时也显示正规范十足，出门还用HTTP你都不好意思和人打招呼！

但是在平时用WampServer调试程序的时候，还是用着HTTP，好像也没啥大问题嘛！

其实有很多情况下，还是要用到HTTPS的，比如新版的 `webrtc`，它就看上了HTTPS，非HTTPS不嫁。

好吧，那就一起来看看WampServer开启SSL的正确姿势吧！



开发测试环境概要：

> WampServer：3.2.2
>
> Apache: 2.4.39
>
> PHP: 7.3.5



**Step 1 确认以下文件是否存在并确保正确**

* a. [Apache安装目录]/modules/ mod_ssl.so
* b. [Apache安装目录]/bin/ openssl.exe, libeay32.dll, ssleay32.dll
* c. [Apache安装目录]/conf/ openssl.cnf



**Step 2 修改配置文件 `httpd.conf` (用于载入 ssl 模块和其配置文件)**

```ini
# 去掉下面行首的#号
LoadModule ssl_module modules/mod_ssl.so 
Include conf/extra/httpd-ssl.conf
```



**Step 3 生成证书**

1. 请求认证文件生成
   在命令行下进入Apache安装目录下\bin文件夹，输入命令：
   C:\wamp\apache\bin> openssl req -new -out server.csr -config ../conf/openssl.cnf
2. 生成私钥
   openssl rsa -in privkey.pem -out server.key
   然后要求输入之前 privkey.pem 的密码（keynes)。
3. 创建证书
   openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 3650
4. 移动文件
   将 \bin 下面的 server.csr、server.crt、server.key 移动到[Apache安装目录]\conf\ssl 文件夹中



**Step 4 修改httpd-ssl.conf**

打开 `[Apache安装目录]\conf\extra\httpd-ssl.conf ` 文件，设置 `SSLCertificateFile` 和 `SSLCertificateKeyFile` 语句对应的路径。

```ini
SSLCertificateFile "C:/wamp/bin/apache/apache2.4.9/conf/ssl/server.crt"
SSLCertificateKeyFile "C:/wamp/bin/apache/apache2.4.9/conf/ssl/server.key"
```



一般来说，完成以上四步可能还无法成功启动SSL。

我在排查问题时总结以下一些方法，你可以参考一下下：

> 排查方法：通过查看 Apache 安装目录下的 logs 文件夹内的 access.log 和 error.log 中的记录解决问题



可能会遇到的坑：

1、如果使用shmcb

```ini
# 应该在 httpd-ssl.conf 文件中开启模块
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
# 同时在 httpd-ssl.conf 文件中写明参数
SSLSessionCache        "shmcb:C:/wamp/bin/apache/apache2.4.39/logs/ssl_scache(512000)"
```



2、目录要指向正确

```ini
# 在 httpd-ssl.conf 文件中
DocumentRoot "C:/wamp/www"
ServerName www.example.com:443
ServerAdmin admin@example.com
ErrorLog "C:/wamp/bin/apache/apache2.4.39/logs/error.log"
TransferLog "C:/wamp/bin/apache/apache2.4.39/logs/access.log"

CustomLog "C:/wamp/bin/apache/apache2.4.39/logs/ssl_request.log" \
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
```



3、外网访问WampServer的权限问题

```ini
# 在 httpd.conf 文件中
# 或 <Directory "${INSTALL_DIR}/www/"> 等目录中确认权限，添加以下允许权限
<Directory />
  <RequireAll>
      Require ip x.x.x.x/24
  </RequireAll>
</Directory>
```



