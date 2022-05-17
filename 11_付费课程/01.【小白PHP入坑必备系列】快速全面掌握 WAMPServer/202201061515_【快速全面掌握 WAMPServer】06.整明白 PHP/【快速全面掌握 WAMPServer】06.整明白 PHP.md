【快速全面掌握 WAMPServer】06.整明白 PHP

副标题：【快速全面掌握 WAMPServer】05.整明白 PHP

英文：master-wampserver-quickly-and-understand-php

关键字：wamp,wampserver,php,apache,mysql,mariadb,js,html



`PHP` 是 `Hypertext Preprocessor` 即“超文本预处理器”的缩写，是在服务端执行的一种脚本语言。

通常它被用于 `Web` 开发，并可以嵌入 `HTML` 中，是具有交互功能一种动态高级语言。



虽然 `PHP` 历史悠久、应用广泛，在上个世纪的90年代就已经诞生，但是它有个基金会却是去年（2021年）才刚刚建立的。

难怪网络上充斥着黑色幽默： `PHP` 是世界上最好的语言！

当然在基金会建立之前 `PHP` 就已经是小伙伴们调侃的对象。

那这句话是真的吗？

如果你还在纠结这个问题的真假，只能说明你的确有必要好好学习一下这里的内容。

我们不得不承认，很多人就是被绑缚于无尽的纠结而束手束脚，最终一事无成。

你管它是不是最好的呢，有用就行，有用就学啊！

而事实上，到目前为止仍有大量的网站是建立在 `PHP` 基础之上。

比如你一直想要拥有的个人主流博客软件之一的 `Wordpress` 就是跑 `PHP` 的。

那么多人在用，你说 `PHP` 有没有用呢？

不要管别人说什么，自己看到听到想到的才最真实！

好了，来到这儿就已经说明你是个头脑清晰、学习劲头十足的三好学生了，那就开始我们的 `PHP` 学习之路吧！



### 几个重要概念

为了方便入门 `PHP` ，我们先来简单介绍几个常用的概念。



##### `PHP` 的运行模式

`PHP` 有两种运行模式，分别是 `CLI` 模式和 `WEB` 模式。

`CLI` 模式就是终端模式，顾名思义，是指我们在终端输入 `PHP` 命令或语句，它就解释执行并同样在终端输出结果。

`WEB` 模式可能大家就知道了，当我们向 `WEB` 服务器发送请求，`PHP` 就会解释执行并通过 `WEB` 方式返回结果到我们的浏览器上。



##### `TS` 和 `NTS`

`TS` 就是 `Thread Safe` 线程安全，是指支持多线程的构建。

`NTS` 就是 `None Thread Safe` 非线程安装，是指仅单线程的构建。

`TS` 应用到多线程的服务端应用编程接口 `SAPI` 方式，而 `NTS` 则用于 `PHP` 作为模块加载到 `WEB` 服务器的方式。



比如 `Linux` 下的 `PHP-FPM` ，用来解释 `PHP` 代码的 `FastCGI` 管理器，它就是使用的 `NTS` 。

图a01



而在 `Windows` 上跑的 `WampServer` 就是用的多线程 `SAPI` ，因此使用的是 `TS` 。

图a02



以上可以在 `phpinfo` 上查看到，`WampServer` 可通过在浏览器中输入以下链接查看。

```
http://localhost/?phpinfo=-1
```



如果你实在记不住也没关系，我们只要简单大概地记得，在 `Linux` 上一般是 `NTS` ，而在 `Windows` 上一般是 `TS` 。

这有什么用吗？

当我们选择 `PHP` 扩展时就会知道，这些扩展 `DLL` 分 `TS` 或 `NTS` ，可不要选错了哦！



##### `PECL`

`PHP` 扩展社区托管库的简称，有很多扩展库就放在这里。

当我们需要某个扩展支持时，就可以到这里来淘一淘。

比如 `Redis` 缓存扩展，双比如第三方数据库扩展等等。

> http://pecl.php.net/



##### VC15 & VS16

较新版本的 `PHP` 是使用 `VC15` 或 `VS16` （分别指 `Visual Studio 2017` 或 `2019` 编译器）构建的。

`VC15` 和 `VS16` 版本需要安装 `C++ Redistributable for Visual Studio 2015-2019 x64/x86` 。

需要记住的是，以后只要我们看到 `VC` 或 `VS` 字样，自然而然就应该想到，这里所指的 `PHP` 是在 `Windows` 上跑的。

而不同版本的 `PHP` 应该对应不同版本的 `VC` 或 `VS` 。

我们使用的 `WampServer` 中的 `PHP` 正是需要相应的 `VC` 组件，并且通常 `x64` 和 `x86` 版本的都要安装，这在前面的安装篇教程中已经说明过了，道理就在这儿。



### `Apache` 是如何调用 `PHP` 的

如果我们只安装了一个 `httpd` （也就是 `Apache` ），那么我们也只能得到一个静态网站，什么交互功能都不能做。

因此我们要想办法，在我们访问网站时让 `Apache` 调用 `PHP` 来解析相应的程序文件，以此来响应交互信息。

通常最原始的访问方法是，我们建立一个以 `php` 为后缀的文件，将其放到网站上，那么它应该识别这个文件是含有交互信息的，而不是单纯地将它的所有内容以 `html` 形式显示在浏览器上。

OK，我们前面说过，在 `Windows` 下它应该是通过连接 `SAPI` （服务端应用程序编程接口）来实现的。

那具体是怎么做的呢？



分两步走。

**第一步，让 `Apache` 加载 `PHP` 模块。**

我们以 `WampServer` 为例，打开 `Apache` 的配置文件 `httpd.conf` ，找到加载 `PHP` 模块的位置。

如下图，我们可以很清楚地看到，`Apache` 当前加载了 `php7.4` 的模块，这个模块文件名就是 `php7apache2_4.dll` 。

```
PHPIniDir "${APACHE_DIR}/bin"
LoadModule php7_module "${INSTALL_DIR}/bin/php/php7.4.26/php7apache2_4.dll"
```

图b01



**第二步，让 `Apache` 识别 `.php` 扩展名**

光加载模块还不够，还要让 `Apache` 知道如果碰到 `.php` 的文件就去找模块解析才行。

同样我们以 `WampServer` 为例，还是在配置文件 `httpd.conf` 中，查找识别文件类型的设定。

```
    AddType application/x-httpd-php .php
    AddType application/x-httpd-php .php3
```

图b02



经过以上两步，我们可以自己做一个简单的 `PHP` 文件来测试。

将以下代码保存为一个文件，比如 `phpinfo.php` ，然后将它放到网站根目录中。

```
<?php phpinfo(); ?>
```



如果打开浏览器访问这个文件能够正常看到 `PHP` 信息，那么恭喜你 `PHP` 环境安装成功了！



### `WampServer` 中的 `PHP`







*PS：《【小白PHP入坑必备系列】快速全面掌握 WAMPServer》教程列表：*

* *【快速全面掌握 WAMPServer】01.初次见面，请多关照*
* *【快速全面掌握 WAMPServer】02.亲密接触之前你必须知道的事情*
* *【快速全面掌握 WAMPServer】03.玩转安装和升级*
* *【快速全面掌握 WAMPServer】04.人生初体验*
* *【快速全面掌握 WAMPServer】05.整明白 Apache*
* *【快速全面掌握 WAMPServer】06.整明白 PHP*
* *【快速全面掌握 WAMPServer】07.整明白 MySQL 和 MariaDB*
* *【快速全面掌握 WAMPServer】08.想玩多个站点，你必须了解虚拟主机的创建和使用*
* *【快速全面掌握 WAMPServer】09.如何在 WAMPServer 中安装 Composer*
* *【快速全面掌握 WAMPServer】10.HTTP2.0时代，让 WampServer 开启 SSL 吧！*
* *【快速全面掌握 WAMPServer】11.安装 PHP 扩展踩过的坑*
* *【快速全面掌握 WAMPServer】12.WAMPServer 故障排除经验大总结*
* *【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！*
* *【快速全面掌握 WAMPServer】14.各种组件的升级方法*



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
