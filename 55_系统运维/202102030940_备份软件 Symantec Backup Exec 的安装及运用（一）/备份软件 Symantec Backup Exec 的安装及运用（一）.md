备份软件 Symantec Backup Exec 的安装及运用（一）

副标题：SBE如何连接磁带库，连接好了然后呢？



最近到货一台服务器以及一台磁带库，准备安装 `Symantec Backup Exec` 备份软件（以下简称 `SBE` ），正好把过程整理记录下来，分享给小伙伴们。



### 备份软件简介

网上的介绍很详细，简单来说 `SBE` 是一款 Windows 下使用的服务器备份软件。

它功能很强大，可以通过网络备份多个不同的系统，包括 Windows 和 Linux ，甚至还包括 VMware 等虚拟系统。



### 备份软件安装

`SBE` 的安装并不难，只需挂载安装镜像，按照每一步提示操作即可。

其中， `SBE` 需要 `MsSQL` 数据库支持，可以选择它自带的 `Express` 版 `MsSQL` ，也可以自己另外安装。

不管通过哪种方式都可以正常工作，如果你有自己的数据库服务，最好是与有服务统一安装在一起。



另外关于选择要安装的功能，除试用版是具有所有功能外，基本是按购入的 License 来选择的。

图1



从图中也可以看出，不同的 License 提供不同的功能支持。

一般基本功能会包含 Windows 和 Linux 的远程备份，而对虚拟机的备份就要另外付费了，当然其价格肯定不简单。



### 磁带库驱动安装的坑

`SBE` 的安装灰常简单，但是要让它开始干活就比较麻烦了。

怎么会麻烦呢，因为我们知道要备份谁，但我们还不知道要备份到哪里去。

所以首先，我们得要让它能正常连接或识别备份目的地，通常我们把它叫作存储介质。



说到存储介质，我们见得多的通常有硬盘、U盘、光盘等等。

那么一般备份服务器数据量也大，所以U盘、光盘之类的并不能满足容量需求，因此硬盘就成了我们最常用的存储介质了。

`SBE` 添加硬盘作为存储介质问题不大，但在这里我们需要添加另外一种说古老而现在又仍常使用的存储介质--磁带。







兼容列表

官网链接：https://www.veritas.com/content/support/en_US/article.100040087









关于这一堆驱动中，我们应该用哪一个，找到了IBM知识中心的参考内容。

链接：https://www.ibm.com/support/knowledgecenter/STAKKZ/dd_iug_kc/con_a88u9_win_svr_install.html

> * install_exclusive.exe The driver issues automatic reserves on open. It also prevents multiple open handles from the host to a drive from existing at the same time, as is required by applications such as Tivoli® Storage Manager. This driver is also required for the failover feature to work as it uses persistent reservation (by default).
>
>   install_exclusive.exe驱动程序在打开时发出自动保留。它还可以防止从主机到驱动器的多个打开句柄同时存在，这是诸如Tivoli®Storage Manager之类的应用程序所要求的。 故障转移功能也需要此驱动程序，因为它使用持久保留（默认情况下）。
>
> * install_nonexclusive.exe The driver permits open handles from the host to a drive to exist at the same time, as is required by applications such as Microsoft Data Protection Manager (DPM).
>
>   install_nonexclusive.exe驱动程序允许从主机到驱动器的打开句柄同时存在，这是Microsoft Data Protection Manager（DPM）之类的应用程序所要求的。



`exclusive` 是独占式，`nonexclusive` 自然就是非独占式。

写了这么一堆，每个字我都认识，可放在一块儿我就懵逼了，就像王宝强似地脱口而出：这都写的是啥？！

还好和我一样的小白遍布天下，我幸运地翻到了另一个有同样问题的帖子，就在 `veeam` 论坛里。

图？



版主回复得很简单，建议没有特殊情况就使用非独占式驱动程序。

照做。



```
# 安装驱动
C:\Dell\Drivers\T10N5\WS2016\install_exclusive.exe

# 卸载驱动
C:\Dell\Drivers\T10N5\WS2016\uninst.exe
```





**事实上备份软件根本就不用特意安装驱动程序。**

图？



好吧，直接用备份软件就行了。





### 磁带介质标签

没钱买二维码标签，就自己手写呗。

带库默认可以接受非正常标签的磁带，但必须由应用程序统一设定逻辑标签，以方便调用和读写。

如果你有矿，那就直接给磁带贴上标签，手写毕竟比较痛苦，而且磁带数量多的话也容易逻辑混乱，一定要当心。

那么怎么给它手写标签呢？



1、登录磁带库，先确认带库是否允许非正常标签的磁带。



`Settings` > `Library` > `Initial Configuration Wizard` 

图？





2、查看磁带槽位状态



`Cartridges` > `Cartridges and Slots`



左上角菜单，`Actions` > `Graphical View` ，以图形模式查看。



最底下一层为占位栏，不允许放置磁带。

图片列表中 `Logical Library` 一列表示逻辑序列。













