干掉程序兼容性助手，让你的VB6程序更年轻更顺畅

副标题：干掉程序兼容性助手，让你的VB6程序更年轻更顺畅

英文：get-rid-of-the-program-compatibility-assistant-to-make-your-vb6-program-younger-and-smoother

关键字：pca,兼容性助手,vb,sdk,mt,compatibility,assistant





`VB6` 开发的程序，功能OK，运行的时候一切都好好的。

然而在最后退出程序时，时常会蹦出来个提示信息，仔细一看，不是别人，正是 `程序兼容性助手` 这货！

图z01



为啥这货总是在程序退出时蹦跶出来呢？

我研究了一下，大概也许可能或许应该是程序以管理员权限运行着，因为 `VB6` 写的程序毕竟比较古老嘛，所以在最后退出时它就会露下脸、刷一下存在感。

当出现这种情况时，我们要知道程序本身并没有啥问题，也没啥兼容不兼容的，因为跑得挺好的嘛。

这时点击 `已正确安装此程序` 或直接将其关闭，一般就算解决问题了。

不过嘛，有时候它还是会跳出来告诉你，你的程序太老啦，兼容的干活，你滴明白？！

我明白你个大头鬼啊！

是可忍孰不可忍，我决定干掉这个大头鬼！



结果网上一搜，着实让我大跌眼镜！

铺天盖地的文章都写着如何关闭程序兼容性助手，还假模假式地教你怎么操作。

我丢啊！

难道要我告诉用户，在使用我写的程序前请先关闭兼容性助手？

甚至秉承顾客就是上帝的原则帮助用户一个一个的去指导？

真是滑天下之大稽啊！

不行，这么玩行不通啊！







啥叫 `Mainfest` 文件呢？

简单地说，就是清单文件。

这个清单里写着各种程序要用到的信息，比如接口信息、应用描述信息等等。

说白了它只是后缀伪装成 `mainfest` 的 `XML` 文件罢了。

大概其像下面这个样子。

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0"> 
  <assemblyIdentity version="1.0.0.0" processorArchitecture="X86" name="Name of your application" type="win32"/> 
  <description>Description of your application</description> 
  <dependency>
      <dependentAssembly>
          <assemblyIdentity version="6.0.0.0" processorArchitecture="X86" />
      </dependentAssembly>
  </dependency>
</assembly>
```



文末有模板 `Mainfest` 文件下载，并附有修改使用说明。

虽然说将这个对应的 `Mainfest` 文件与 `VB6` 应用程序放在一起，就可以有效防止兼容性助手出来捣乱，但是这样做吧它总感觉不怎么方便，有时也可能会不灵。

如果说你的应用程序不仅有 `exe` 应用程序，另外还有一大堆的其他文件，那么多一个 `Mainfest` 文件不算啥。

不过像我一般就生成一个单独的应用程序，简单便利绿色环保不用安装，这种情况下要是拖个 `Mainfest` 文件，总有点累赘的感觉，对吧？

那有没有更彻底的办法，比如就保持单独一个应用程序文件，同时还能避免蹦出兼容性助手？

文章刚写了个开头，后面还有不少内容，聪明的小伙伴一下就能猜到：肯定有办法！

那好，我就展开来说一说吧！



注意：以下付费内容

===============================



如果想要将 `Mainfest` ，必须使用到 `Windows SDK` ，因为要用到一个小工具，叫做 `Mt.exe` 。

有人说了，这 `Windows SDK` 是啥？

我的理解这玩意就是 `Windows` 编程用开发环境，具体的我也不懂，能用就行呗！



那么还有这个小工具 `Mt.exe` 又有什么功能呢？

官方解释 `Mt.exe` 文件是生成已签名文件和目录的工具。 

它在 `Microsoft Windows` 软件开发工具包 ( `SDK` ) 中提供。

`Mt.exe` 要求清单中引用的文件与清单位于同一目录中。 



反正眼前我只用到很小的一点点功能，因此直接安装它就是了。

谁能想到，我千辛万苦下载下来的 `SDK` 安装包居然报错无法安装。

（`Windows SDK Setup` 官方安装包文末下载）

图b01



这是怎么回事？

看提示说是我已经安装了旧版的 `.NET Framework 4` ？

这可真冤枉了，天地良心，我哪儿安装过了！

再仔细一看，似乎是忽悠人的，可以直接点击 `确定` 继续嘛！



点 `确定` 后出现安装向导，应该没事，废话不多说，走起！

图b02

图b03

图b04

图b05

图b06



前面都用默认设置，一路都没问题，结果安装进程并没有开始，反倒出现了安装失败的提示！

图b07



真是奇怪，难道和一开头那个提示有关系？

后来找来找去，终于找到答案。

直接安装



再来安装 `Windows SDK` ，这下安装进程顺利展开了。

图b08



不过好景不长，还没安装到一半，又出错了！

图b09



今儿怎么这么不顺呢！





> Installing Visual C++ 2010 and Windows SDK for Windows 7: offline installer and installation troubleshooting
>
> https://notepad.patheticcockroach.com/1666/installing-visual-c-2010-and-windows-sdk-for-windows-7-offline-installer-and-installation-troubleshooting/
>
> So I decided to **uninstall** my Visual C++ 2010 SP1 .
>
> I ran the Windows SDK installer again and it worked fine. 
>
> It installed  the Visual C++ 2010 Redistributable Package,  which I updated then with its SP1. 
>
> All working good now, hurray ! 







以下是大致的解决方法，不过我只卸载了 `VC++2010` 就OK了！ 

具体你那儿行不行，还要看实际情况而定。

```
安装此 Windows SDK 遇到问题时可能的解决方案摘要

* 卸载 Visual C++2010 SP1 Redistributable Package（从今日起，这是安装 Windows SDK 所必需的）（x64和x86均适用））
* 确保 Windows 模块安装程序服务已启动并正在运行
* 将 HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components 的所有权更改为 Administrators 组（不确定是否真的需要）
* 确保所有 TEMP 和 TMP 环境变量（全局和用户）都指向同一个文件夹（同样，不确定是否真的需要……但将所有临时文件夹放在同一位置总是很好的，更容易清理）
```

图g01



果断卸载 `VC++2010` 。

图c01

图c02





最后确认没毛病了，之后再来安装 `Windows SDK` ，这下安装进程顺利展开，并且完美结束。

图c03

图c04



赶紧点开开始菜单找一找，终于有了 `Microsoft Windows SDK v7.1` 的字样。

图c05



当然，`mt.exe` 也好好地在文件夹里面躺着呢！

图c06



后面就针对这个 `mt.exe` 来做文章了，先看看命令参数。

```
C:\>mt.exe
Microsoft (R) Manifest Tool version 6.1.7716.0
Copyright (c) Microsoft Corporation 2009.
All rights reserved.

Usage:
-----
mt.exe
    [ -manifest <manifest1 name> <manifest2 name> ... ]
    [ -identity:<identity string> ]
    [ < <[-rgs:<.rgs filename>] [-tlb:<.tlb filename>]> -dll:<filename> > [ -replacements:<XML filename> ] ]
    [ -managedassemblyname:<managed assembly> [ -nodependency ] ]
    [ -out:<output manifest name> ]
    [ -inputresource:<file>[;[#]<resource_id>] ]
    [ -outputresource:<file>[;[#]<resource_id>] ]
    [ -updateresource:<file>[;[#]<resource_id>] ]
    [ -hashupdate[:<path to the files>] ]
    [ -makecdfs ]
    [ -validate_manifest ]
    [ -validate_file_hashes:<path to the files> ]
    [ -canonicalize ]
    [ -check_for_duplicates ]
    [ -nologo ]
```

图d01



具体怎么用呢？

其实照着参数套上就行了。

比如校验 `mainfest` 文件应该是这个样子。

```
mt.exe -mainfest App.exe.mainfest -validate_mainfest
```

图e01



又比如将 `mainfest` 文件导入到应用程序，可能是这个样子。

```
mt.exe -mainfest App.exe.mainfest -outputresource:App.exe;1
```

图e02



具体用法可以参考官方文档：

> https://learn.microsoft.com/zh-cn/windows/win32/sbscs/mt-exe



这样一来，`App.exe` 这个应用程序就会变成一个新的带有 `Mainfest` 信息的程序。

注意，在使用这个命令前务必将应用程序备份一份，因为有可能会被覆盖。



说话打命令麻烦，前面安装 `SDK` 也麻烦，不就用个 `Mt.exe` 嘛！

于是我就将这些打了个包，并做了一个小工具，不需要再安装 `SDK` 也能直接做到同样的效果了。

就拿我写的这个程序来做例子吧！

它是这个样子的。

图f01



使用很方便，就两步，先根据指定应用程序生成并校验相应的 `Mainfest` 文件。

然后再导出新的更新好的应用程序，就OK啦！

导入更新后是这个样子的。

图f02



怎么样，程序界面是不是看上去不太一样了，有点新版系统的风格。

当你尝试使用更新后的程序时，你就懂了，兼容性助手就再也没有出现过，并且程序本身的功能效果都没有任何改变或影响。





* `Microsoft Windows SDK 7.1.pdf` - 下载说明信息及校验码等
* `GRMSDK_EN_DVD.iso` - `x32`
* `GRMSDKIAI_EN_DVD.iso` - `ia64`
* `GRMSDKX_EN_DVD.iso` - `x64`

下载链接：









**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc