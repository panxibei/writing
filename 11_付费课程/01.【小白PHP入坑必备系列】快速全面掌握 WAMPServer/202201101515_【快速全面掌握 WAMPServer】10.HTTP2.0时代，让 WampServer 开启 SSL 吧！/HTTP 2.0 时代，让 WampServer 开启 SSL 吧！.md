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



### 开发测试环境概要

* `WampServer` : `3.2.9` - `64bits`

  * `Apache`:  `2.4.51`
  * `PHP`:  `7.4.26`

  

### 相关路径变量预设

* `[Apache安装目录]` = `${SRVROOT}` =  `C:\wamp64\bin\apache\apache2.4.51`
* `[Wamp安装目录]` = `${INSTALL_DIR}` = `C:/wamp64`



### 开启 `SSL` 的步骤

##### Step 1 - 确认以下文件是否存在并确保正确。

* `${SRVROOT}/modules/mod_ssl.so`
* `${SRVROOT}/bin/openssl.exe`
* `${SRVROOT}/bin/libeay32.dll` （仅用于 `32` 位 `wamp` ）
* `${SRVROOT}/bin/ssleay32.dll`（仅用于 `32` 位 `wamp` ）
* `${SRVROOT}/conf/openssl.cnf`



##### Step 2 - 修改配置文件 `httpd.conf` ，开启载入 `ssl` 模块及其配置文件。

```
${SRVROOT}\conf\httpd.conf
```

图a01



编辑 `httpd.conf` ，找到并修改以下代码。

```ini
# 去掉下列行首的#号
LoadModule ssl_module modules/mod_ssl.so 
Include conf/extra/httpd-ssl.conf
```

图a02

图a03



##### Step 3 - 生成 `SSL` 自签名证书

`WampServer` 已经为我们准备好了用于生成证书的配置文件 `openssl.cnf` ，我们只要拿来用就行了。



**首先，我们先进入 `openssl.exe` 命令所在目录。**

```
// 请将 ${SRVROOT} 替换为实际路径，比如本例为 C:\wamp64\bin\apache\apache2.4.51
cd ${SRVROOT}\bin
```



**其次，生成证书请求文件以及私钥，请注意指明正确的 `openssl.cnf` 路径。**

```
// 生成证书请求文件 server.csr
openssl req -new -out server.csr -config ../conf/openssl.cnf
```

 

生成证书请求文件时，我们需要输入 `PEM` 密码，不输入密码则无法进行下一步操作。

这个密码你随便输入，但需要记住它，因为之后生成证书时需要用于再次确认。

图d01



之后就可以输入证书相关的一些参数信息了，比如国家代码、行省代码、组织代码以及邮箱地址等等。

注意，这个证书将来是给自己用的自签名证书，因此它的 `Common Name` 可以随便写，密码也可以不用设定。

但是如果你是申请的互联网证书，那么至少 `Common Name` 这一项必须要与当前的服务器域名相匹配，否则证书无法工作正常哦！

图d02



**再次，生成服务器密钥文件。**

通过前面步骤生成的 `server.csr` 和 `privkey.pem` ，我们就可以生成服务器密钥文件了。

```
openssl rsa -in privkey.pem -out server.key
```

执行命令后，此时要求我们输入之前 `PEM` 密钥密码，我特别让大家记忆的，没忘记吧？

这样我们就得到了 `server.key` 。

图d03



**再再次，我们就可以创建证书了。**

按以下命令，通过请求文件 `server.csr` 以及密钥文件 `server.key` ，就可以生成最终的证书文件 `server.csr` 。

当然，其中我们也可以指定证书的有效期，比如 `3650` 天，也就是 `10` 年，这个任意填写即可。

```
openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 3650
```

图d04



**最后，将生成的证书文件、密钥文件都放到一个指定的文件夹中备用。**

将  `${SRVROOT}\bin` 下面的 `server.csr` 、`server.crt` 、`server.key` 共三个文件统一移动到 `${SRVROOT}\conf\ssl` 文件夹中。

图d05



##### Step 4 - 修改 `httpd-ssl.conf`

证书文件我们已经拿到了，接下来就是将这些文件指定到配置文件中使其生效。

打开并编辑 `${SRVROOT}\conf\extra\httpd-ssl.conf ` 文件。

图c01



设置 `SSLCertificateFile` 和 `SSLCertificateKeyFile` 两个参数，将其修改为实际证书文件以及密钥文件的完全路径。

```ini
SSLCertificateFile "${SRVROOT}/conf/ssl/server.crt"
SSLCertificateKeyFile "${SRVROOT}/conf/ssl/server.key"
```

图b01



### 其他的补充步骤

一般来说，完成以上几步有可能还无法成功启动 `SSL` 。

原因多种多样，比如不同版本的 `Apache` 其代码语法不同造成的。

不过我们可以通过查看 `Apache` 安装目录下 `logs` 文件夹内的 `access.log` 和 `error.log` 中的记录信息来解决问题。

可能会遇到的坑以及有几种可能需要补充的步骤，我将其总结如下，供小伙伴们参考，希望大家少些走一些弯路。



##### 1、如果要使用 `shmcb`

`shmcb` 是用于 `SSL` 会话缓存的模块，有可能需要开启它 `HTTPS` 才能正常。

```ini
# 应该在 httpd-ssl.conf 文件中开启模块
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
# 同时在 httpd-ssl.conf 文件中写明参数
SSLSessionCache        "shmcb:C:/wamp/bin/apache/apache2.4.39/logs/ssl_scache(512000)"
```

图b02

图b03



##### 2、目录务必要指向正确

`WampServer` 默认的 `www` 目录指向了 `Apache` 所在的安装目录，实际上这是错误的。

如果你发现网站出现找不到文件或目录的错误，多半就是这个原因。

此时我们应该在 `httpd-ssl.conf` 文件中修正 `DocumentRoot` 为正确的目录。

敲黑板：注意区别 `${SRVROOT}` 和 `${INSTALL_DIR}` 。

```ini
# 在 httpd-ssl.conf 文件中，至少将 DocumentRoot 指向正确的 www 目录。
DocumentRoot "${INSTALL_DIR}/www"
ServerName www.example.com:443
ServerAdmin admin@example.com
ErrorLog "${SRVROOT}/logs/error.log"
TransferLog "${SRVROOT}/logs/access.log"
```

图b04



同样，我们还要确认自定义日志的路径是否正确。

```ini
CustomLog "${SRVROOT}/logs/ssl_request.log" \
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
```

图b05



##### 3、外网访问 `WampServer` 的权限问题

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

图c02



我们使用自签名证书，我们知道是安全的，因此可以将浏览器的警告关闭。

通常在浏览器的警告界面点击 `高级` ，就可以看到更多信息，其中有临时将当前站点纳入信任之列的链接。

图c03



点击 `继续前往localhost（不安全）` ，我们就可以跳过警告看到网站的本来面目啦！

当然，证书非信任的警告还是存在的，但不会影响我们正常访问站点。

图c04















嗯，时间不早了，就介绍到这里，希望对你有所帮助，我们下期再见！



> 微信公众号：@网管小贾
>
> 技术博客：@www.sysadm.cc