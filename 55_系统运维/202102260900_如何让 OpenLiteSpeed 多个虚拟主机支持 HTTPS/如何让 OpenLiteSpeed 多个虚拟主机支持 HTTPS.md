如何让 OpenLiteSpeed 多个虚拟主机支持 HTTPS

副标题：





OpenLiteSpeed 的基础安装及使用方法可以参考我之前写的文章，简单易上手。

> 参考文章：《用 Laravel 吗，从 Nginx 切换到 OpenLiteSpeed 的那种》
>
> 链接：https://www.sysadm.cc/index.php/webxuexi/810-give-up-nginx-then-using-laravel-with-openlitespeed



看过之前的这篇文章，就算是小白也可以轻松入门。

不过文章最后我们留了一个扣，就是如何让 `OLS` 支持 `SSL` ，现在还果奔 `http` 的应该不多见了吧？

官网的知识库中有相关设置 `SSL` 的内容，但似乎又太过于简单。

官网知识库链接：https://openlitespeed.org/kb/ssl-setup/



我按照文章中的介绍，初步实现了在监听器上如何支持 `SSL` 。



### 一、安装 `OpenSSL`

工欲善其事，必先利其器。

生成我们需要的密钥和证书文件，通常会用到 `OpenSSL` 。

在这儿我准备给小伙伴们介绍一下 `OpenSSL for Windows` ，这个可以在 `Windows` 下使用的工具软件。



`OpenSSL` 一般是在 `Linux` 下使用的加密算法软件，所以在 `Windows` 下使用，似乎是某些爱好者组织在一起开发的。

所以其网站有点怪怪的，不知道为啥它并不是 `https` 开头的。

产品链接页面：http://slproweb.com/products/Win32OpenSSL.html



其中你可以找到最新版本的下载，分为轻量版和32位/64位版。

图1



一般轻量版的就够用了，我选择了最靠前的一个。

备用下载：Win64OpenSSL_Light-1_1_1j.exe (3.54M)



下载完成后开始安装，最初它会提示你系统中没有安装 `Microsoft Visual C++ 2017 Redistributables` 。

图2



如果你点是，它会帮你下载，但只有上帝才知道它什么时候能下载完，微软的速度你懂的。

所以我找到了以前安装 `WampServer` 时用到的组件包，其中就有这么一位哥们。

当然，`OpenSSL` 是64位的自然所需64位的组件，不过我这32位的也有，就打包放一起吧。



备用下载：Microsoft Visual C++ 2017 Redistributables  (xM)



图3



很快装完组件，就可以继续安装 `OpenSSL for Windows` 了。

图4



中间有让你选择将动态链接库放在哪儿合适的提问，你要是无所谓那就默认放在 `Windows` 系统文件夹中，要是有强迫症，那就选择和执行文件放一起，其实都可以正常使用。

图5



正像安装完成的最后那幅画面提示的那样，组织看上去非常渴望捐助。

图6



这也可以从前面那张协议窗口的文本中窥见一斑，组织对白嫖者虽说不上痛恨，但却抱以嗤之以鼻的态度。

在此也顺便呼吁小伙伴们，如果你的确从中受益，即便不予以金钱，但也请表达一下你的支持，比如关注、点赞、分享、外加在看。



好了，我们完成了安装后，建议大家最好将 `OpenSSL` 的执行目录加到系统路径中。

这样我们就可以开始创建 `SSL` 证书了。

图7





### 二、生成用于 `HTTPS` 的密钥和证书文件

此处用最最最简单的方法来实现，一共三步三条命令。

为了便于今后识别整理，我们以域名为文件名来区分不同的主机。

比如域名为 `sysadm.local`，则可以按以下方式生成密钥和证书。



1、生成密钥文件，以 `key` 为后缀。

```
# openssl genrsa -out sysadm.local.key 2048
```

图8



2、以密钥为基础，生成证书请求，以 `csr` 为后缀。

```
# openssl req -new -key sysadm.local.key -out sysadm.local.csr
```

这里需要输入的内容其实可以随便填写，但有一个地方必须要填写正确，那就是通用名称，一般来讲应该是主机的域名。

图9



3、有密钥，有请求，那么就可以据此生成相应的证书了，以 `crt` 为后缀。

```
# openssl x509 -req -days 3650 -in sysadm.local.csr -signkey sysadm.local.key -out sysadm.local.crt
```

图10



好了，一共生成三个文件，除了请求文件是用于生成证书的过渡文件外，其他两个文件等会儿就要用到了。





### 三、给监听器设定证书，开启 SSL



找到监听器，在列表中点击监听器名称。

图11



点击右侧编辑按钮，将端口修改成 `443` ，加密连接修改成 `是` 。

图12

