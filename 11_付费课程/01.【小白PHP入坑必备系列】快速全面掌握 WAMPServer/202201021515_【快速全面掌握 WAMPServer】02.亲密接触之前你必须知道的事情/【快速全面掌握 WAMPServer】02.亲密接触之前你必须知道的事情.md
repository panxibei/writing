【快速全面掌握 WAMPServer】02.亲密接触之前你必须知道的事情

副标题：【快速全面掌握 WAMPServer】02.亲密接触之前你必须知道的事情

英文：master-wampserver-quickly-and-comprehensively-wampserver-all-you-need-to-know

关键字：wamp,wampserver,php,apache,mysql,mariadb,js,html



我们在与他人打交道之前，较为合理的做法便是先打探了解一下对方的喜好和忌讳。

除非你只是接触一下而并不想继续打交道，否则提前了解对方的一些相关信息还是非常有利于我们更快更深入地建立加强合作关系，而且也更有利于以后能够扩展、吸纳和融合更多的其他关系。

道理很简单，也是相通的，因此在正式开始使用 `WAMPServer` 之前，我们当然有必要学习了解一些关于她的喜好和禁忌。



`WAMPServer` 也有喜好禁忌？

那是当然，如果你熟知她的这些喜欢禁忌，那么你就能更好地驾驭她，使她发挥出最大的特长。

那么，`WAMPServer` 到底都有哪些喜好禁忌呢？



以最新版本为例。



##### 一、`WAMPServer` 并不能工作在 `FAT32` 或 `exFAT` 分区上，而只能工作在 `NTFS` 分区上。

因此你可不要犯糊涂了，假如你的分区是 `FAT32` 或 `exFAT` ，那么 `WAMPServer` 是绝对没办法正常运行的，切记切记！



##### 二、安装所有 `Microsoft C/C++ Runtime Libraries` 。

这个可以说是非常硬性的前提条件，在安装 `WAMPServer` 之前务必确保安装了所有的微软 `C/C++` 运行库，注意，是所有的哦！

要是你少安装了某个或某些运行库，那么 `I'm sorry` ，请先不要安装 `WAMPServer` ，否则装了也会报错而无法正常使用。

还有更厉害的，如果你都装好了 `WAMPServer` ，那么在缺少部分运行库的情况下，你也不得不先卸载 `WAMPServer` ，然后待运行库全面搞定后才能再次安装 `WAMPServer` 。

灰常麻烦有木有？

那么所有的 `C/C++` 运行库都有哪些呢？



如下，你必须确保以下的运行库都是最新版本的。

* `Microsoft Visual C/C++ Redistributable 2012 (VC11)`

* `Microsoft Visual C/C++ Redistributable 2013 (VC13)`

* `Microsoft Visual C/C++ Redistributable 2015 - 2022 (VC17)`

  `VC17` 包含了 `Microsoft VC14, VC15, VC16` 。



恭喜小伙伴哈，`VC17` 包含了 `VC14` 、 `VC15` 和 `VC16` ，我们只要安装好 `VC17` 就行了，省去了不少麻烦！

为啥要安装这么多个运行库呢？

实际上它们都是用来针对不同的 `PHP` 版本的，换句话说，不同版本的 `PHP` 依赖使用的运行库是不同的。

比如，`PHP 5.3/5.4` 就需要安装 `VC2008(VC9)` ，以此类推。



如果你使用的是 `Windows 10` 以前的版本，并且运行的组件使用的是 `MSVC2015 (VC14)` 编译的 `Apache/MySQL/PHP` ，那么你还需要安装其他的通用运行库 `Universal C Runtime` 。

当然， `Windows Update` 的实难恭维，这自动更新的效率多少会让人抓狂，那么我们还有更好更快的办法来安装这么多的运行库吗？

好办法当然有，在前一篇文章中我们也提到了 `WAMPServer` 相关文件下载的站点，我们就利用这个站点即可。

等各个运行库组件安装完成后，我们可以到 `控制面板` > `程序` > `程序和功能` 中查看是否安装正常完整。

不过由于库文件实在太多，挨个下载再将它们逐个安装多少有点费劲，所以我发明了一键快速安装大法。



“一键快速安装大法”，请详细参考后一期关于 `WampServer` 的安装教程。



##### 三、绝对不要在系统已安装了 `WAMPServer` 的基础上再安装 `WAMPServer` 。

覆盖安装对于 `WAMPServer` 是行不通的哦！

即便你安装上了新版本，但也存在原有数据被覆盖而丢失的风险，注意注意啊！

如果你真的想要升级安装，那么是有 `WAMPServer` 的更新包的。

但是吧，对于 `Apache` 、 `MySQL/MariaDB` 和 `PHP` 来说，却需要专门的更新来升级，而不是简单地通过安装 `WAMPServer`来实现。

关于更新和升级安装，我们支在下一篇中为小伙伴们详细讲解。



##### 四、应该将 `WAMPServer` 安装在根目录上。

什么意思呢？

就是说 `WAMPServer` 必须安装在清爽的英文字母、非空格或没有特殊字符或中文字符的路径中。

比如：`C:\wamp` 和 `D:\wamp` ，64位的话就是 `C:\wamp64` 和 `D:\wamp64` 等等。

注意，绝对不要安装在如 `C:\Program Files` 或 `C:\Program Files (x86)` 之类的文件夹中。



##### 五、安装前需要先关闭一些程序

比如 `Skype` 和 `IIS` 等等。

至于 `Skype` ，它的配置中有可以开启了 `80` 或 `443` 端口，容易与 `WAMPServer` 产生冲突。

关闭 `IIS` 的道理自然也是一样的。



##### 六、多个安装包

其中包括各组件的更新包、工具、还有其他一些附加组件。

`WAMPServer` 主程序更新包。

`xDebug` 更新包。

`Aestan Tray Menu` 托盘管理更新包。

`PhpSysInfo`

`PhpMyAdmin`

`Adminer`

`wampmanager.ini` 修复工具

`Apache` 附加组件

`PHP` 附加组件

`MySQL/MariaDB` 附加组件



### 教程小结

本节内容为小伙伴们介绍了在正式安装使用 `WAMPServer` 之前的一些注意事项。

虽然这有些麻烦，不过了解这些注意事项还是很有必要的，它可以使你能更快地理解并驾驭 `WAMPServer` 的使用。

如果你想在后续的安装和使用中少踩坑，那么真心建议你好好地回顾一下本文前面的内容，这可是肺腑之言哦，我可没少吃亏哦！

只要你认真地阅读了本文，那么你就可以很顺利地去到下一节。

在下一节教程中，我们将正式开始 `WAMPServer` 的安装，并且还会在已安装的基本上进一步说明如何升级以及需要注意的事项。

好了，你准备好了吗？

我们下一节教程再见啦！



* *PS：《【小白PHP入坑必备系列】快速全面掌握 WAMPServer》教程列表：*
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
