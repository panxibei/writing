HTTP 2.0 时代，让 WampServer 开启 SSL 吧！

副标题：HTTP 2.0 时代，让 WampServer 开启 SSL 吧！

英文：

关键字：





如今的互联网时代就是个看脸的时代，颜值就是一切！

不信？看看那些直播带货的就知道了，颜值与出货量绝对成正比！

而相对于 `HTTP` 来说，`HTTPS` 绝对算得上是高颜值的帅哥，即安全又有范，拉出去逛街都倍儿有面！

在互联网时代背景下，`HTTPS` 早已是流行标配，只要你是正规网站，那妥妥地支持 `HTTPS` 。

`WampServer` 作为常用的 `Windows` 下开发调试 `PHP` 的神器，自然也是支持 `HTTPS` 的，只是很多小伙伴不知道的是，其实她默认并未开启。



你说啥？还用着 `HTTP` 呢？

出门还好意思和人打招呼吗？

那位说，我用 `HTTP` 也好使着呢，没必要啊。

好吧，其实吧有很多情况，还是要用到 `HTTPS` 的。

比如新版的 `webrtc`，它就看上了 `HTTPS` ，非 `HTTPS` 不嫁啊！

如果你用 `HTTP` ，那她死活是无法调试使用的。

又比如微信等常见的应用接口，支持 `HTTPS` 是必须滴！

`HTTPS` 这么牛，以后早晚都是他了，那赶紧一起来看看 `WampServer` 开启 `SSL` 的正确姿势吧！



开发测试环境概要：

* WampServer：3.2.9

  * Apache: 2.4.51
  * PHP: 7.4.26

  





相关路径变量假定：

`[Apache安装目录]` = `${SRVROOT}` =  `C:\wamp64\apache\apache2.4.51`

`[Wamp安装目录]` = `${INSTALL_DIR}` = `C:/wamp64`



**Step 1 - 确认以下文件是否存在并确保正确**

* `${SRVROOT}/modules/mod_ssl.so`
* `${SRVROOT}/bin/openssl.exe`
* `${SRVROOT}/bin/libeay32.dll` （仅用于 `32` 位 `wamp` ）
* `${SRVROOT}/bin/ssleay32.dll`（仅用于 `32` 位 `wamp` ）
* `${SRVROOT}/conf/openssl.cnf`



**Step 2 - 修改配置文件 `httpd.conf` (用于载入 ssl 模块和其配置文件)**

```ini
# 去掉下面行首的#号
LoadModule ssl_module modules/mod_ssl.so 
Include conf/extra/httpd-ssl.conf
```



**Step 3 - 生成自签名证书**





1. 请求认证文件生成
   在命令行下进入 `[Apache 安装目录]\bin` 文件夹，输入命令：
   
   ```
   openssl req -new -out server.csr -config ../conf/openssl.cnf
   ```
   
    
   
2. 生成私钥

   ```
   openssl rsa -in privkey.pem -out server.key
   ```

   然后要求输入之前 `privkey.pem` 的密码（`keynes`)。

   

3. 创建证书

   ```
   openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 3650
   ```

   

4. 移动文件
   将  `[Apache 安装目录]\bin` 下面的 `server.csr` 、`server.crt` 、`server.key` 移动到 `[Apache 安装目录]\conf\ssl` 文件夹中。

   

**Step 4 - 修改httpd-ssl.conf**

打开 `[Apache安装目录]\conf\extra\httpd-ssl.conf ` 文件，设置 `SSLCertificateFile` 和 `SSLCertificateKeyFile` 语句对应的路径。

```ini
SSLCertificateFile "[Apache安装目录]/conf/ssl/server.crt"
SSLCertificateKeyFile "[Apache安装目录]/conf/ssl/server.key"
```



一般来说，完成以上四步可能还无法成功启动SSL。

我在排查问题时总结以下一些方法，你可以参考一下下：

> 排查方法：通过查看 Apache 安装目录下的 logs 文件夹内的 access.log 和 error.log 中的记录解决问题



可能会遇到的坑：

1、如果要使用shmcb

```ini
# 应该在 httpd-ssl.conf 文件中开启模块
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
# 同时在 httpd-ssl.conf 文件中写明参数
SSLSessionCache        "shmcb:C:/wamp/bin/apache/apache2.4.39/logs/ssl_scache(512000)"
```



2、目录要指向正确

```ini
# 在 httpd-ssl.conf 文件中，至少将 DocumentRoot 指向正确的 www 目录。
DocumentRoot "${INSTALL_DIR}/www"
ServerName www.example.com:443
ServerAdmin admin@example.com
ErrorLog "C:/wamp/bin/apache/apache2.4.39/logs/error.log"
TransferLog "C:/wamp/bin/apache/apache2.4.39/logs/access.log"

CustomLog "C:/wamp/bin/apache/apache2.4.39/logs/ssl_request.log" \
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
```



3、外网访问WampServer的权限问题

按照前面的设置，默认情况我们只能在 `localhost` 也就是本机下使用 `https` 。

```
Require local
```



如果想开放其他人也能同时使用，那么需要将访问权限放开。

一些基本语法：

拒绝所有

```
<RequireAll>
    Require all granted
</RequireAll>
```



开放所有：

```
<RequireAll>
    Require all denied
</RequireAll>
```



开放特定域名主机

```
<RequireAll>
    Require host sysadm.cc
</RequireAll>
```



开放特定IP地址（段）。

```
<RequireAll>
    Require ip 192.120 192.168.100 192.168.88.0/24 192.168.200.200
</RequireAll>
```



这些语法是基于 `Apache` 的 `Require` 指令访问控制，具体可参考相关的文档。

就以当前为例，我们现在想开放某个子网可访问 `https` ，可以简单地按如下设定。

```ini
# 编辑 httpd.conf 文件
# <Directory "${INSTALL_DIR}/www/"> 目录中确认权限，添加以下允许权限
<Directory />
  <RequireAll>
      Require ip x.x.x.x/24
  </RequireAll>
</Directory>
```

图c05



另外如果还想开放 `http` 即 `80` 端口访问的权限，那么可以在 `httpd-vhosts.conf` 中添加相应指令。

```
<VirtualHost *:80>
    ...

    <RequireAll>
        Require ip 192.168.1.0/24 192.168.100.0/24
    </RequireAll>
    
    ...
</VirtualHost>
```

图c06



### 写在最后

好了，调试一番后如果你能顺利地在浏览器中打开 `https://` 开头的页面，那么恭喜你，成功啦！

不过，注意到网址前面有把小锁了吗？

它带有感叹号，说明我们用的是自签名证书。

这个证书不能被浏览器的权威证书机构承认，只能自己用用，其实问题不大，只是有些警告而已。

嗯，时间不早了，就介绍到这里，希望对你有所帮助，我们下期再见！



> 微信公众号：@网管小贾
>
> 技术博客：@www.sysadm.cc