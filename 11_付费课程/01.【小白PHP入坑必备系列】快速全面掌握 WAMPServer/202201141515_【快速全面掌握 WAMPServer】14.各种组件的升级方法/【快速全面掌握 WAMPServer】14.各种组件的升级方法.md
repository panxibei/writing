【快速全面掌握 WAMPServer】14.各种组件的升级方法

副标题：【快速全面掌握 WAMPServer】14.各种组件的升级方法

英文：master-wampserver-quickly-and-upgrade-components

关键字：wamp,wampserver,php,web,apache,mysql,mariadb,check,problem,troubleshooting,upgrade,升级,更新





> **WAMPSERVER免费仓库镜像（中文）**
> https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files



`WAMPServer` 更新很快，这是件好事！

但是 `WAMPServer` 更新快是因为他很勤劳吗？

其实这个问题的原因并不是出自 `WAMPServer` 自身，而是来自它的各个组件。

是的，你能想像得到，比如 `PHP` 、`MySQL` 或是其他。

那么在这些软件频繁地更新背景之下，我们想要获得最稳定最可靠的版本支持时，那就不得不也被推着往前走。

没错，我们需要学会如何及时安装各个组件的更新版本。



### 更新组件前的注意事项

由于所有的 `WAMPServer` 组件都工作在 `Windows` ，而它们都需要不同版本的 `VC++` 软件包支持，因此在更新它们之前务必要确保相应的 `VC++` 已经安装OK。

这一点在之前的教程安装篇中已有介绍，并且我们可以使用 `Check` 程序来检查是否已经正确安装。



`WAMPServer` 自身的更新可能就要先卸载再重新安装了，在此之前别忘记备份你的文件和数据哦！

我们重点讲一下 `PHP` 、`MySQL` 之类组件的更新。



### 升级 `Apache`

**示例：`Apache 2.4.51` > `Apache 2.4.54`**

打开官网下载链接：

> https://wampserver.aviatechno.net/?lang=en



在标有 `Addons Wampserver 3` 字样的区域找到最新版本的 `Apache` 组件安装包。

图a01



在下载完成之前，我们来看看关于 `Apache` 升级的重要提示。

在安装 `Apache 2.4.54` 之前，需要更新到 `Wampserver 3.2.9` 。

在安装之前已经安装 `VC 2015-2022 (VS17) 14.32.31326` 或更高版本也是必须事项。

可能通过集成 `Apache fcgi_module` 允许更改每个 `VirtualHost` 的 `PHP` 版本以获得具有不同 `PHP` 版本的虚拟主机。



开始安装。

图a02



提示我们务必事先安装好相应版本的 `VC++` 组件。

图a03

图a04



在安装快结束的时候，程序提示我们可以通过点击来切换不同版本的 `Apache` 。

此外，对于虚拟主机来说，也可以复制其配置信息来迁移。

图a05

图a06



重启服务后新版本出现。

图a07



当我们点击新版本要来切换时，系统会出现一个版本比较窗口，然后询问我们是否将旧版本的配置复制到新版本中。

按钮含义：

* `ALL` - `A` - 所有
* `RESET` - `R` - 重置
* `CANCEL`- 按回车取消

注意：当你决定选择后，还要再按个 `G` 再回车。

图a08



成功切换到新版本。

图a09



### 升级 `PHP`

**示例：`PHP 8.1.0` > `PHP 8.1.9`

`PHP` 的安装非常简单，没有一点儿难度，看图就知道了。

图b01

图b02

图b03

图b04

图b05

图b06



就这样结束了？

是的，但是其实你并不知道，`WAMPServer` 默默地帮我们做了很多事，只是我们不知道而已。

其中就有，它将原来 `8.1.0` 的配置文件以及相关联的扩展等文件都帮我们复制过来了。

真是方便神器啊！



### 升级 `MySQL`

通常 `WAMPServer` 的默认安装只有 `MySQL 5.7` 而没有 `MySQL 8.0` ，因此当我们想使用 `8.0` 时，就需要我们自己安装了。

好，我们到文章开始的镜像页面下载好 `MySQL 8.0` 的安装包，下面我来为小伙伴们演示一下。

图c14

图c15

图c16

图c17

图c18

图c19



整个安装过程非常简单，但有几点需要我们注意一下。

一是安装程序并没有指定安装路径，因此 `WAMPServer` 尽量以默认路径形式安装，然后再安装 `MySQL 8.0` 。

二是在安装之前切记备份原来数据库的数据，安装完成后再导入备份。

三是在安装过程中 `WAMPServer` 会中止服务，因此安装完毕记得重新开启服务。



一旦安装完成，我们再回过来查看，就可以看到 `MySQL` 的版本多了一个 `8.0` 。

此时就可以随时切换了，只要点选一下就行，很方便！

图c20



### 教程小结

其他应用组件，比如 `Phpmyadmin` 、 `Adminer` 和 `Phpsysinfo` 等等，基本上都可以通过下载官方安装包来直接安装，非常方便。

这里不再赘述了。

此外，如果你觉得旧版本碍眼，那你可以直接将相关联的文件夹删除。

当然在此之前请务必小心保留设置和备份。

好了，亲爱的小伙伴们，如果你在学习的过程中遇到什么问题，欢迎评论留言！

以后如果有其他需要补充的内容，我也会不定期地更新在这里！

感谢各位的关注和支持！



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



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc