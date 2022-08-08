【快速全面掌握 WAMPServer】10.HTTP2.0时代，让 WampServer 开启 SSL 吧！

副标题：【快速全面掌握 WAMPServer】10.HTTP2.0时代，让 WampServer 开启 SSL 吧！

英文：master-wampserver-quickly-and-in-the-http2.0-age-lets-enable-ssl-for-wampserver

关键字：https,http,http2,ssl,wampserver,wamp,openssl,加密





> **WAMPSERVER免费仓库镜像（中文）**
> https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files



如今的互联网就是个看脸的时代，颜值似乎成了一切！

不信？看看那些直播带货的就知道了，颜值与出货量绝对成正比！

而相对于 `HTTP` 来说，`HTTPS` 绝对算得上是高颜值的帅哥，即安全又有范，拉出去逛街都倍儿有面！

在如今的互联网时代背景下，`HTTPS` 早已是流行标配，`HTTPS` 支持加密保护，只要你是正规网站，那妥妥地必须支持 `HTTPS` 。

`WampServer` 作为常用的 `Windows` 下开发调试 `PHP` 网站系统的神器，自然也是支持 `HTTPS` 的，只是很多小伙伴并不知道的是，其实她默认并未开启。



你说啥？还用着 `HTTP` 呢？

出门还好意思和人打招呼吗？

那位说，我用 `HTTP` 也好使着呢，没必要啊。

好吧，其实吧有很多情况，还是要用到 `HTTPS` 的。

比如新版的 `webrtc`，它就看上了 `HTTPS` ，非 `HTTPS` 不嫁啊！

如果你用 `HTTP` ，那她死活是无法调试使用的。

又比如微信等常见的应用程序接口，支持 `HTTPS` 就是潜规则，那是必须滴！

`HTTPS` 这么牛，以后早晚都要用到他，那不赶紧一起来看看 `WampServer` 开启 `SSL` 的正确姿势吧！



慢着，怎么又冒出来一个 `SSL` 了？

其实说白了，`HTTPS` 的最后一个 `S` 就是这个 `SSL` 。

在这儿我不做过多的名词解释了，总而言之，我们可以简单粗暴地将 `HTTPS` 理解为加密的 `HTTP` 。

具体的名词解释请小伙伴们自行百度吧，接下来我们还是来点正经的知识：让 `WampServer` 支持 `HTTPS` 访问。



### 测试环境准备

我们假定你已经安装好以下软件，当然可以有程序版本的些许差别，这对接下来的试验影响并不大。

* `WampServer` : `3.2.9` - `64bits`

  * `Apache`:  `2.4.51`
  * `PHP`:  `7.4.26`

  

### 相关路径变量预设

有两个非常重要的变量，为了让大家不至于头脑混乱，先罗列于此。

**名称意义 = 变更名称 = 实际路径举例**

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

图01



编辑 `httpd.conf` ，找到并修改以下代码。

```ini
# 去掉下列行首的#号
LoadModule ssl_module modules/mod_ssl.so 
Include conf/extra/httpd-ssl.conf
```

图02

图03



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

图04



之后就可以输入证书相关的一些参数信息了，比如国家代码、行省代码、组织代码以及邮箱地址等等。

注意，这个证书将来是给自己用的自签名证书，因此它的 `Common Name` 可以随便写，密码也可以不用设定。

但是如果你是申请的互联网证书，那么至少 `Common Name` 这一项必须要与当前的服务器域名相匹配，否则证书无法工作正常哦！

图05



**再次，生成服务器密钥文件。**

通过前面步骤生成的 `server.csr` 和 `privkey.pem` ，我们就可以生成服务器密钥文件了。

```
openssl rsa -in privkey.pem -out server.key
```

执行命令后，此时要求我们输入之前 `PEM` 密钥密码，我特别让大家记忆的，没忘记吧？

这样我们就得到了 `server.key` 。

图06



**再再次，我们就可以创建证书了。**

按以下命令，通过请求文件 `server.csr` 以及密钥文件 `server.key` ，就可以生成最终的证书文件 `server.csr` 。

当然，其中我们也可以指定证书的有效期，比如 `3650` 天，也就是 `10` 年，这个任意填写即可。

```
openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 3650
```

图07



**最后，将生成的证书文件、密钥文件都放到一个指定的文件夹中备用。**

将  `${SRVROOT}\bin` 下面的 `server.csr` 、`server.crt` 、`server.key` 共三个文件统一移动到 `${SRVROOT}\conf\ssl` 文件夹中。

图08



##### Step 4 - 修改 `httpd-ssl.conf`

证书文件我们已经拿到了，接下来就是将这些文件指定到配置文件中使其生效。

打开并编辑 `${SRVROOT}\conf\extra\httpd-ssl.conf ` 文件。

图09



设置 `SSLCertificateFile` 和 `SSLCertificateKeyFile` 两个参数，将其修改为实际证书文件以及密钥文件的完全路径。

```ini
SSLCertificateFile "${SRVROOT}/conf/ssl/server.crt"
SSLCertificateKeyFile "${SRVROOT}/conf/ssl/server.key"
```

图10



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

图11

图12



##### 2、目录务必要指向正确

`WampServer` 默认的 `www` 目录指向了 `Apache` 所在的安装目录，实际上这是错误的。

如果你发现网站出现找不到文件或目录的错误，多半就是这个原因。

此时我们应该在 `httpd-ssl.conf` 文件中修正 `DocumentRoot` 为正确的目录。

敲黑板：注意区别 `${SRVROOT}` 和 `${INSTALL_DIR}` 。

```
# 在 httpd-ssl.conf 文件中，至少将 DocumentRoot 指向正确的 www 目录。
DocumentRoot "${INSTALL_DIR}/www"
ServerName www.example.com:443
ServerAdmin admin@example.com
ErrorLog "${SRVROOT}/logs/error.log"
TransferLog "${SRVROOT}/logs/access.log"
```

图13



同样，我们还要确认自定义日志的路径是否正确。

```ini
CustomLog "${SRVROOT}/logs/ssl_request.log" \
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
```

图14



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

图15



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

图16



### 写在最后

好了，调试一番后如果你能顺利地在浏览器中打开 `https://` 开头的页面，那么恭喜你，成功啦！

不过，注意到网址前面有把小锁了吗？

它带有感叹号，说明我们用的是自签名证书。

这个证书不能被浏览器的权威证书机构承认，只能自己用用，其实问题不大，只是有些警告而已。

图17



我们使用自签名证书，我们知道是安全的，因此可以将浏览器的警告关闭。

通常在浏览器的警告界面点击 `高级` ，就可以看到更多信息，其中有临时将当前站点纳入信任之列的链接。

图18



点击 `继续前往localhost（不安全）` ，我们就可以跳过警告看到网站的本来面目啦！

当然，证书非信任的警告还是存在的，但不会影响我们正常访问站点。

图19



### 教程小结

虽说近期传言 `Web3.0` 时代即将到来，但毕竟瘦死的骆驼比马大，目前仍还是 `Web2.0` 主流的时代。

即便 `https` 自身也并不是100%的完美，也同样有着不少的缺陷，但是各大网站仍然还是欢快地跑着 `https` ，可见它有它存在的理由，一时半会儿还不会退休领养老金啊！

即使 `https` 对于传输损耗不少，但至少它的优势不在于此，牺牲一些性能换回更多的诸如加密等功能也算是比较划算的。

因此，不管怎么说，作为基础知识，我们仍然要学习这个 `https` 的相关知识，打好了基础才能更好地迎接 `Web3.0` 对不对？

我们有了 `https` 的支持，那么在使用一些需要加密协议接口支持的应用程序时就会方便很多。

好了，今天我为小伙伴们分享的 `WampServer` 开启 `SSL` 支持就是一个很好的学习切入点，大家可以拿来练习练习。

如果一次实验没有成功也没有关系，回头再仔细看一看，我想应该是问题不大，祝你好运哦！





*PS：《【小白PHP入坑必备系列】快速全面掌握 WAMPServer》教程列表：*

* *【快速全面掌握 WAMPServer】01.初次见面，请多关照*
* *【快速全面掌握 WAMPServer】02.亲密接触之前你必须知道的事情*
* *【快速全面掌握 WAMPServer】03.玩转安装和升级*
* *【快速全面掌握 WAMPServer】04.人生初体验*
* *【快速全面掌握 WAMPServer】05.整明白 Apache*
* *【快速全面掌握 WAMPServer】06.整明白 MySQL 和 MariaDB*
* *【快速全面掌握 WAMPServer】07.整明白 PHP*
* *【快速全面掌握 WAMPServer】08.想玩多个站点，你必须了解虚拟主机的创建和使用*
* *【快速全面掌握 WAMPServer】09.如何在 WAMPServer 中安装 Composer*
* *【快速全面掌握 WAMPServer】10.HTTP2.0时代，让 WampServer 开启 SSL 吧！*
* *【快速全面掌握 WAMPServer】11.安装 PHP 扩展踩过的坑*
* *【快速全面掌握 WAMPServer】12.WAMPServer 故障排除经验大总结*
* *【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！*
* *【快速全面掌握 WAMPServer】14.各种组件的升级方法*



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc

