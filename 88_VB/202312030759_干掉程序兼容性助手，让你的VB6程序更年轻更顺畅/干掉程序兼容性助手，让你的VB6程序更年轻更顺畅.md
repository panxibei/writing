干掉程序兼容性助手，让你的VB6程序更年轻更顺畅

副标题：干掉程序兼容性助手，让你的VB6程序更年轻更顺畅

英文：get-rid-of-the-program-compatibility-assistant-to-make-your-vb6-program-younger-and-smoother

关键字：pca,兼容性助手,vb,sdk,mt,compatibility,assistant



在座的老少爷们，大家好！

今天我给大家说一段相声，不是，说一段我写 `VB` 程序遇到问题并解决的经历。



大概诸位都知道，用 `VB6` 开发的程序，功能OK，运行的时候一切都好好的。

然而在最后退出程序时，时常会蹦出来个提示信息，仔细一看，不是别人，正是 `程序兼容性助手` 这货！

像下图这样，让人看了有点左右为难。

图01



为啥这货大概率会在程序退出时蹦跶出来呢？

我研究了一下，大概也许可能或许应该是程序以管理员权限运行着，因为 `VB6` 写的程序毕竟比较古老嘛，为了所谓的兼容性或安全性，所以在最后退出时它就会露下脸、刷一下存在感。

当出现这种情况时，我们要知道程序自身并没有啥问题，也没啥兼容不兼容的，因为跑得挺好的嘛。

这时点击 `已正确安装此程序` 或直接将其关闭，一般就算解决问题太平无事了。

不过嘛，下回再打开程序，它还是会跳出来假装好心告诉你，你用的程序太老啦，兼容的干活，你滴明白？！

啊呸，明白你个大头鬼啊！

每次老整这烦人的一出，是可忍孰不可忍，我决定干掉这个大头鬼！



结果网上这么一搜，着实让我大跌眼镜！

铺天盖地的文章都写着如何关闭程序兼容性助手，还假模假式地教你怎么操作。

我丢啊！

难道你要我挨个告诉每一个用户，在使用我写的程序前请务必劳驾先关闭兼容性助手？

搞什么飞机，真是滑天下之大稽啊！

不行不行，这么玩行不通！



那应该怎么玩呢？

后来我经历了九九八十一难，终于搞定了，期间碰到了无数个坑，包括 `SDK` 安装不上等等。

最终实现了预期的效果，不用关闭用户系统的兼容性助手，**自己写的 `VB6` 程序也可以完美地运行而不再弹出兼容性助手窗口**。

同时我也顺手写了个方便工具，可以将应用程序无损转换成兼容模式程序，绿色环保无毒无公害。

**文末提供相关文件程序包、说明及代码等下载。**



想让你的 `VB6` 程序重新换发清纯活力吗？

这些运行库及自制小工具，赶紧下载使用吧！



接下来怎么做的，待我详细说道说道哈……



以下付费内容

↓↓↓↓↓↓↓↓

===================================



在兼容性方面，通过资料查找，我发现有一个叫做 `Mainfest` 的文件可以帮助 `VB6` 程序提高系统运行时的兼容性。

那么啥是 `Mainfest` 文件呢？

简单地说，就是清单文件。

这个清单里写着各种程序要用到的信息，比如接口信息、应用描述信息等等。

说白了它其实只是后缀名伪装成 `mainfest` 的 `XML` 文件罢了。



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



文末有模板 `Mainfest` 文件下载，并附有修改使用说明，只要照着操作就行。

虽然说将这个对应的 `Mainfest` 文件简单地与 `VB6` 应用程序放在一起，就可以有效防止兼容性助手出来捣乱，但是这样做吧它总感觉不怎么方便，有时也可能会不灵。

如果说你的应用程序不仅有 `exe` 应用程序，另外还有一大堆的其他文件，那么多一个 `Mainfest` 文件不算啥。

不过像我一般就生成一个单独的应用程序，简单便利绿色环保不用安装，这种情况下要是拖个 `Mainfest` 文件，总有点累赘的感觉，对吧？

那有没有更彻底的办法，比如就保持单独一个应用程序文件，同时还能避免蹦出兼容性助手？

文章刚写了个开头，后面还有不少内容，聪明的小伙伴一下就能猜到：肯定有办法！

那好，我就展开来说一说吧！



通过查找资料了解到，如果想要将 `Mainfest` 导入到应用程序中，必须使用到 `Windows SDK` ，因为要用到其中一个小工具，叫做 `Mt.exe` 。

有人说了，这 `Windows SDK` 是啥？

我的理解这玩意就是 `Windows` 编程用开发环境，具体的我也不太懂，能用就行呗！



那么还有这个小工具 `Mt.exe` 又有什么功能呢？

官方解释 `Mt.exe` 文件是生成已签名文件和目录的工具。 

它在 `Microsoft Windows` 软件开发工具包 ( `SDK` ) 中提供。

`Mt.exe` 要求清单中引用的文件与清单位于同一目录中。 



反正眼前我只用到很小的一点点功能，因此直接安装它就是了。

谁能想到，我千辛万苦下载下来的 `SDK` 安装包居然报错无法安装。

（`Windows SDK Setup` 官方安装包文末下载）

图02



这是怎么回事？

看提示说是我已经安装了旧版的 `.NET Framework 4` ？

这可真冤枉了，天地良心，我哪儿安装过了！

再仔细一看，似乎是忽悠人的，可以直接点击 `确定` 继续嘛！

后来猜测可能现在的 `Win10/11` 都自带有部分 `.NET Framework 4` 组件。



点 `确定` 后出现安装向导，应该没事，废话不多说，走起！

图03

图04

图05

图06

图07



前面都用默认设置，一路OK，结果安装进程并没有正常开始，反倒出现了安装失败的提示！

图08



真是奇怪，难道和一开头那个提示有关系？

后来找来找去，这才发现是安装路径有问题，直接运行 `WinSDK_amd64.msi` 即可。



好，再继续安装 `Windows SDK` ，这下安装进程顺利展开了。

图09



不过好景不长，还没安装到一半，又出错了！

图10



今儿怎么这么不顺呢！



喘口气，歇一会，接着再战！

后来找到了老外的一段话。

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



按照老外所说，以下是大致的解决方法，不过我只卸载了 `VC++2010` 就搞定了！ 

当然具体你那儿行不行，还得看实际情况而定。

```
安装此 Windows SDK 遇到问题时可能的解决方案摘要

* 卸载 Visual C++2010 SP1 Redistributable Package（从今日起，这是安装 Windows SDK 所必需的）（x64和x86均适用））
* 确保 Windows 模块安装程序服务已启动并正在运行
* 将 HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components 的所有权更改为 Administrators 组（不确定是否真的需要）
* 确保所有 TEMP 和 TMP 环境变量（全局和用户）都指向同一个文件夹（同样，不确定是否真的需要……但将所有临时文件夹放在同一位置总是很好的，更容易清理）
```

图11



行了，果断卸载 `VC++2010` 。

图12

图13





最后确认没毛病了，之后再来安装 `Windows SDK` ，这下安装进程顺利展开，过程虽然曲折，好在结局完美。

图14

图15



好了，赶紧点开开始菜单找一找，终于有了 `Microsoft Windows SDK v7.1` 的字样。

图16



当然，此时小工具 `mt.exe` 也静静地在文件夹里面躺着呢！

图17



接下来就针对这个 `mt.exe` 做文章了，先看看命令参数。

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

图18



这么一大堆参数让人眼花，具体怎么用呢？

其实照着参数往上套就行了。

比如校验 `mainfest` 文件应该是这个样子。

```
mt.exe -mainfest App.exe.mainfest -validate_mainfest
```

图19



又比如将 `mainfest` 文件导入到应用程序，可能是这个样子。

```
mt.exe -mainfest App.exe.mainfest -outputresource:App.exe;1
```

图20



详细用法可以参考官方文档：

> https://learn.microsoft.com/zh-cn/windows/win32/sbscs/mt-exe



这样一来，`App.exe` 这个应用程序就会变成一个全新的带有 `Mainfest` 信息的程序。

注意，在使用这个命令前务必将应用程序备份一份，因为原文件有可能会被覆盖。



说话打命令挺麻烦，前面安装 `SDK` 啥的也超级麻烦，不就用个 `Mt.exe` 嘛！

于是我就将这些打了个包，并做了一个小工具，不需要再安装 `SDK` 也能直接做到同样的效果了。

就拿我写的这个工具程序来做例子吧！

它是这个样子的。

图21



使用很方便，就两步，先根据指定应用程序生成并校验对应的 `Mainfest` 文件（自动生成的哦）。

然后再导出新的更新好的应用程序，就OK啦！

导出更新后程序就会变成这个样子的。

图22



怎么样，程序界面是不是看上去不太一样了，有点新版系统的风格对不？

当你尝试使用更新后的程序时，你就懂了，兼容性助手就再也没有出现过，并且程序本身的功能效果都没有任何影响和改变。



想让你的 `VB6` 程序重新换发清纯活力吗？

这个小工具，赶紧下载使用吧！



**网管小贾的可执行文件导入Manifest工具.7z(317K)**

* `Microsoft Windows SDK 7.1.pdf` - 下载说明信息及校验码等
* `GRMSDK_EN_DVD.iso` - `x32`
* `GRMSDKIAI_EN_DVD.iso` - `ia64`
* `GRMSDKX_EN_DVD.iso` - `x64`

下载链接：https://pan.baidu.com/s/1FCjlR9-V6CgsECRBGIOhBg

提取码：hwxo



最后祝小伙伴们食用愉快！

我们下期再见！



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc