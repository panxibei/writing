windows11安装wmic，另附离线安装方法及安装包

副标题：

英文：

关键字：







什么情况？

`WMIC` 命令失效了？

图01



可用按需功能

> https://learn.microsoft.com/zh-cn/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod?view=windows-11

图02



注意，官方说得很清楚，从 `Windows 11` 版本 `24H2` 开始，系统就不再预装 `WMIC` 了。

这句话怎么理解呢？

其实，除了字面意思之外，很明显有一个比较可怕的事情，就是说，这个 `WMIC` ，在不久的将来可能就会被巨硬公司给彻底剔除了！

不过还好，现在还是有办法把它找回来并且安装上的。

至于什么时候会彻底没法用，那就不知道了，到时可能也会有办法。

好了，现在的问题是，怎么给它找回来？



找了很多办法，最简单的方法，就是通过可选功能来联网安装。

按顺序找到 `设置` > `系统` > `添加可选功能` > `查看功能` 。

图03



找到 `WMIC` ，接着添加安装就是了。

图04

图05

图06



除了点点鼠标，还可以用命令来安装。

像下面这样。

```
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
```

图07



顺便写一下删除 `WMIC` 的命令吧。

```
DISM /Online /Remove-Capability /CapabilityName:WMIC~~~~
```



还有一种方法，可以挂载 `Windows` 系统安装镜像，通过镜像来安装。

```
DISM /Online /add-Capability /CapabilityName:WMIC~~~~ /Source:wim:D:\Sources\Install.wim:4
```

图08



这里有几点需要注意。

第一个，`Install.wim` 冒号后面的数字是镜像中系统的索引 `Index` ，`4` 是指 `Windows` 专业版镜像，具体要看你的系统是啥版本的，对应就行。

第二个，带有 `/Online` 参数时，一定要连接上网络才行，否则会报错。

第三个，这个 `Install.wim` 的镜像文件，其实就是在 `Windows` 安装 `ISO` 镜像 `Sources` 文件夹中的，解压缩出来就能用。

图09



我经过网上一番查找，同时也是为了确认 `WMIC` 入土的时间，没想到有了新的发现。

的确，官方留给 `WMIC` 的时间不多了。

如图，`WMIC` 将被保留在 `FoD` 中，也就是作为一个可选功能被保留。

在2024年之后的某个时间点，连 `FoD` 中也不保留了，就彻底和我们说拜拜了！

图10



在前面的安装过程中，我想到了一个问题。

如果万一我想安装启用 `WMIC` 的可选功能，却没办法联网，又应该怎么做呢？

这时我发现还有个 `FoD` 的玩意！

这个 `FoD` 就解开了我的困惑。

原来官方将所有的可选功能程序，都集中放在了一个叫作 `FoD` 的镜像文件中。

当我们无法联网启用可选功能时，这个 `FoD` 就可以实现离线安装了。



可是，经过好几天的折腾，我也没搞明白这个 `FoD` 怎么用。

有的说要先做个镜像仓库 `repo` ，可是我失败了。

到最后，我才搞清楚，如何通过 `foD` 镜像来安装。

实事上没有像网上那样操作，因为网上的命令方式早已过时，那都是旧版的操作方法。

只要你有 `FoD` 的镜像文件，你就可以随意安装了。

比如我们安装 `WMIC` ，在 `FoD` 镜像中就有安装包。

图11



挂载镜像后，我们就可以使用以下命令来安装 `WMIC` 了。

注意，命令中的 `G:` 表示镜像挂载后的驱动盘符，以实际为准。 

```
Dism /Online /Add-Capability /CapabilityName:WMIC~~~~ /Source:G:\LanguagesAndOptionalFeatures /LimitAccess
```

图12



这个 `FoD` 镜像文件包含了所有的可选功能，与 `Windows` 的 `ISO` 镜像文件完全是两个不同的东西。

在网上也不好找，我在文末放了备份下载。



最后可以试一下是否安装成功，最简单的就用如下命令，看看有没有输出。

```
wmic os
```



aaaaaa以下为隐藏内容aaaaaa

Windows 11 版本 21H2 语言和可选功能 ISO
Windows 11 版本 22H2 和 23H2 语言和可选功能 ISO
Windows 11 版本 24H2 语言和可选功能 ISO

> https://learn.microsoft.com/zh-cn/azure/virtual-desktop/windows-11-language-packs

aaaaaa以上为隐藏内容aaaaaa



备用下载：

**Windows11版本24H2可选功能ISO**

下载链接：https://pan.baidu.com/s/15GBwlL_io2i-FK3byezFew

提取码：jv5v







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc