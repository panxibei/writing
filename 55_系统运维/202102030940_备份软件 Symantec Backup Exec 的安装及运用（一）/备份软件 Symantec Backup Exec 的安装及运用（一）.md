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



在添加磁带介质前，我们就需要先准备好磁带库。

手头上的货就是 `Dell ML3` ，打开驱动器一看，其实还是 `IBM` 的。

图2



到 `Veritas` 官网找到 `SBE` 的说明书，上面也写着是 `IBM` 的驱动器，型号为 `LTO Ultrium 7-H` 。

官方软硬件兼容列表链接：https://www.veritas.com/content/support/en_US/article.100040087

我使用的 `SBE` 的版本是 `21` ，查找其硬件兼容列表，的确是支持这一款磁带库的。

图3



接下来就是如何使 `SBE` 正常连接到磁带库的问题了。

我们打开备份服务器上的设备管理器，可以看到有两个未知的媒体更换器设备。

这里有两个未知设备是因为我使用了两根SAS线。

图4



注意了，这里有个大坑，按通常的思维方式，我们应该先解决设备的驱动问题。

于是我便到 Dell 的官网上找来了 ML3 的驱动程序。

驱动程序是个自解压可执行文件，我将它运行解压后得到了几个文件夹。

备份服务器是 Windows 2016 系统，所以我打开了其中名为 WS2016 的文件夹。

图5



哎？怎么没有 install 或是 setup 之类的安装文件呢？

这叫我怎么安装呢，再到刚才下载驱动的页面上看看有没有说明。

于是找到了安装说明。

图6



安装说明里说得很清楚，程序安装是通过 CLI 安装脚本来执行，但需要事先确认程序版本是否是专属。

那么应该安装专属（exclusive）还是非专属（nonexclusive）的驱动呢？



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

又是一番大海捞针式的搜索，还好和我一样的小白遍布天下，我幸运地翻到了另一个有同样问题的帖子，就在 `veeam` 论坛里。

版主回复得很简单，说是建议安装非专属的驱动程序。

图7



 OK，那就照这个走起！

打开命令提示符窗口，切换到 `WS2016` 目录，然后运行 `install_nonexclusive.exe` 。

```
# 安装驱动
C:\Dell\Drivers\T10N5\WS2016\install_exclusive.exe

# 卸载驱动
C:\Dell\Drivers\T10N5\WS2016\uninst.exe
```

安装很顺利地完成了。

图8

图9



注意啦！前方高能预警！

你以为这样安装了驱动程序就是对的吗？

我可以告诉你，这完全就是错误的！

如果你继续后续的连接磁带库等操作，可能会完全失败！



什么？你说了这么一大堆最后告诉我这些都是错误的？！

我只想说，抱歉，如果我不这么说的话，很可能你印象不深刻，无法从中吸取我的经验教训，否则我的文章也可能就沦落成和其他复制粘贴一样的教程了。

好了，说了这么多，其实还是自己经验不足，我们回过头来再整理一下你就会发现问题所在了。



首先，我们忽略了安装说明中的重要信息。

图10



其次，在 `SBE` 的软件兼容列表（SCL）中也提到了关于 Windows 系统版本与磁带库驱动的关系。

图11



备份服务器使用的是 Windows 2016 系统，版本比 2012 高，手头的磁带库也在 `SBE` 硬件兼容列表中，所以它自己就能识别并驱动磁带库。

最后我们可以得出结论，就是**我们根本就不用特意安装驱动程序**！





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













