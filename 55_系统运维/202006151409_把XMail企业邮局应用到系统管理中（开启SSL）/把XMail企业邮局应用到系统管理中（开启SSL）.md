把XMail企业邮局应用到系统管理中（开启SSL）

副标题：信息安全无小事~



前面我们经过 `XMail` 的安装、配置和管理，已经能很好地使用它了。

不过呢，目前为止我们的用户和密码在传输过程中还是处于裸奔状态。

也就是说，按照基本初步地安装`XMail` ，默认是没有开启 `SSL` 的。

嘿嘿，是不是额头冒汗，开始有点方了呢？



其实 `XMail` 骨子里是支持 `SSL` 的，而且按照我们之前的教程安装好后就已经有了使用 `SSL` 的能力。

那为什么还是裸奔状态，我读书少，你别骗我哦？

原因说出来有点让人呵呵，因为你需要手动生成私钥和证书。

好吧，这个也不能怪它，那我们就来看看怎么生成私钥和证书。

说来也不是太难，省得你去啃官网文档，我已经总结好了，其实只要两步。

1. 找个可以用 `OpenSSL` 的地方。
2. 用 `OpenSSL` 生成私钥和证书，然后把私钥和证书放到 `MAIL_ROOT` 根目录下就欧了！



这......简单得令人发指吗？！

那好，没病咱们来走两步！



#### 一、找个可以用 `OpenSSL` 的地方

在一般的Linux系统中，安装 `OpenSSL` 都非常容易，所以直接拿来用就行了。

如果你手头只有Windows，那么需要下载 `OpenSSL for Windows` 来安装 `OpenSSL` 。

有个神奇的链接：http://slproweb.com/products/Win32OpenSSL.html

对了，下载那个 `1.1.1g` 轻量版本。

打不开还是嫌下载慢？不早说，我这儿有啊！

省心链接：https://o8.cn/PhuAJz 密码：yck0

图1



下载完成后，直接安装，居然报错！

图2



好...好像是 `VC++2017` 依赖组件没有安装，没有它 `OpenSSL` 不干活。

唉~微软就这点不好，要整整十个组件，怎么就一个组件，没啥挑战性啊！

猛然记得之前安装 `WampServer` 时有很多这类组件安装包，到 [《WAMPSERVER仓库镜像（中文）》](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files) 扒拉扒拉，好像最新版的仓库没有啊！

好吧，最后我还是在旧版仓库里找到了，在这儿放个链接。

省心链接：https://o8.cn/6Of0Rm 密码：5gza

图3



安装好依赖组件后，终于可以继续了。

图4



要用到的 `DLL` 文件默认就放到 `Windows` 系统目录下吧。

图5



没有任何报错，一路顺利地完成了安装。

查看一下版本试试，很OK！

图6



#### 二、生成私钥和证书

首先，有两点注意事项：

* 需要使用 `XMail` 提供的 `C:\MailRoot\bin\openssl.cnf` 配置文件
* `COMMON NAME` 信息必须填写服务器**主机名称**或是**IP地址**



其次，有三条命令：

```shell
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.cert
```



最后，把生成的这几个文件（`server.key` 和 `server.cert`）都移动到 `MAIL_ROOT` 根目录下，比如 `C:\MailRoot` 。



好了，祝贺你，完成了！

纳尼？服务器配置文件 `server.tab` 什么的都不需要修改吗？

没错！就这些，已经全都搞定了少年！

好吧，此时你老泪纵横，视线渐渐模糊，我也知道我想说的都说完了，我该走了！

希望你能转发分享，让更多的小伙伴受益！



> WeChat @网管小贾
>
> Blog @www.sysadm.cc

