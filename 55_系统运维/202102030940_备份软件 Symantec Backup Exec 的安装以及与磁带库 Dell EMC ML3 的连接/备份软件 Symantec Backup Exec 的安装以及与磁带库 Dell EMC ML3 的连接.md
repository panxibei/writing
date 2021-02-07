备份软件 Symantec Backup Exec 的安装以及与磁带库 Dell EMC ML3 的连接

副标题：



### 备份软件的简介







### 备份软件的安装





### 磁带库驱动安装的坑



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







### 设定一个备份







### 安装评估和部署工具包

Windows 评估和部署工具包（ADK）在一般情况下用得不多，主要是用作自定义大规模部署映像或测试系统等等场景之用。

为什么现在要提及这个东东呢，因为在下一节关于恢复备份而需要创建恢复磁盘时非常有用。



官方文档链接：https://docs.microsoft.com/zh-cn/windows-hardware/get-started/adk-install

其中可以下载到最新版本的 Windows ADK 。

我们用的是 Windows 2016 ，可是打开链接页面，其中只有 Windows 10、8、7 之类的版本，并没有 2016 啊？

其实直接套用 Windows 10 的就行了，在这里我们选择 Windows 10 版本 2004 的 ADK 。

安装包下载链接：https://go.microsoft.com/fwlink/?linkid=2120254

将链接文件下载后得到 `adksetup.exe` 文件。



执行这个文件开始下载安装评估和部署工具包。

摆在我们面前的只有两条路，一条是边安装边下载，另一条是一口气全部下载下来以后安装。

为了方便分享给小伙伴们使用，我毫不犹豫地选择了第二条路--完整下载。

图？



此处作为测试，我选择了不发送数据。

图？



我是从官网直接下载的，完整文件大小1.15G左右，如果你连不上微软的官网或赚速度慢，可以用这儿的国内备用下载链接。

ADK备用下载链接：https://

提取码：











### 创建 Simplified Disaster Recovery 磁盘

左上角 `Backup Exec` 按钮 > `配置和设置` > `创建灾难恢复磁盘`







### 





