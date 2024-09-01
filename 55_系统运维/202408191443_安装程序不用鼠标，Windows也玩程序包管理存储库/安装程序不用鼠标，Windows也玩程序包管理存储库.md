安装程序不用鼠标，Windows也玩程序包管理存储库

副标题：安装程序不用鼠标，Windows也玩程序包管理存储库

英文：installing-does-not-require-mouse-and-windows-also-uses-package-management-repositories

关键字：windows,winget,apt,dnf,yum,安装,repo,仓库



“嘿，嘿，看见没，今年某某著名大学建筑专业才招了4名新生！”

大刘用手点指手机，带着一脸的吃惊相。



我冲他笑了笑，说道：“那是他们的教学水平不行。”

“要是换了我，学生多得能踏破门槛，你信不信！”



大刘撇了撇嘴：“切，信你个鬼啊！”

“你不就是个IT民工嘛，现在计算机都烂大街了，谁还不会个计算机啊！”



“哎，大刘，你可别说哈！如果让我来教学生，就完全不一样了！”

“还能咋不一样，不就是上机操作点鼠标那一套嘛，学计算机不跟玩儿似的。”



我本不想计较，但是看他那不服不忿的样子，我就想让他知道知道，什么叫专业。

于是我就打算来场赌赛。

“大刘，要不咱来赌一把，咱来个现在教学，看看我是不是专业的？”

“行啊，来就来呗。说吧，赌点啥？”

“今天食堂有鸡腿，就赌两鸡腿！”

“行，一言为定！慢着，等我摇几个人，找计算机专业的，气氛做到家哈，看大家怎么评判！”



不一会儿，办公室不大塞进十来个人。

有坐着的，有站着的，有带水杯的，还有带瓜子的。

我一看，直咂嘴，心想这大刘也真的是，给我整这么多吃瓜群众还。

看我这一犹豫，大刘和几个小子在那催促起哄。

得，看样子不来点真格的是不行了！



“大家好！鸡腿……不是……我现在为大家讲一堂免费的计算机公开体验课！”

说完，我打开投影，将电脑屏幕投放到幕布上。

“今天，我们就来讲一讲，如何在 Windows 中安装程序……”



这时，有人咋呼了一句：“哎，怎么黑乎乎的？除了命令窗口，什么都没有啊！”

“请大家稍安勿躁！我们今天就是给大家介绍，不用鼠标的安装程序的方法……”



什么？还能这么干？不用鼠标光打命令就安装程序了？

起初略显嘈杂的办公室一瞬间变得安静了，可能这几位也是头一次碰见这样的情况。



没错，我们平时安装程序，都是双击安装文件，启动安装向导程序，这种方式来安装程序的。

最多在此之前还有一个解压缩的操作（2024年了，可能还有一部分人不会解压缩，但却是事实。）。

但是这一回，怎么就不是这么干的呢？

因为我们完全可以通过命令窗口来安装程序。

但是请注意，并不是说通过命令窗口来启动安装向导程序，而是另外一番不同的体验。



对于玩过 `Linux` 的朋友来说，安装程序就是通过程序包管理工具来安装。

简单地说，就是通过打命令来安装程序，并不是像 `Windows` 那样通过双击安装包。

是的，`Windows` 放着好好的图形界面不用，它也搞出来一个类似于 `Linux` 下的程序包管理工具：`WinGet` 。



`WinGet` ，全名为 **Windows Package Manager**，即 `Windows` 程序包管理器的意思。

它是微软官方推出的一个命令行工具，用于在 `Windows` 系统上安装、管理和升级软件包。

`WinGet` 没什么神秘的，它相当于 `Linux` 中的 `apt`（ `Ubuntu/Debian` ）或 `yum/dnf` （ `CentOS/RedHat` ）等发行版的程序包管理工具。



有人可能会说了，`Linux` 我没用过啊，那些包管理工具也从来没接触过。

没事哈，如果说它一点用处也没有，那么官方也不会推出这个功能。

使用 `WinGet` 来安装程序，其实是通过官方提供的程序仓库来实现的。

说白了，就是安装程序时，它会在程序仓库里找，而不是我们手动去网上下载。



在较新版本的 `Windows` 里其实已经自带了 `WinGet` 。

如果你的 `Windows` 里还没有安装 `WinGet` ，那么可以先搞定它。

`WinGet` 怎么获取呢？

（文末有备用下载）



可以从 `Microsoft Store` 获取应用安装程序。

> https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab

图01



以前给大家介绍过的，通过应用商店中的分享，可以获取当前软件的实际链接。

`WinGet` 的实际链接如下：

https://www.microsoft.com/store/productId/9NBLGGH4NNS1?ocid=pdpshare



要实际链接有啥用呢？

可以到下面的神秘网站中下载到这个软件。

```
https://store.rg-adguard.net/
```



输入软件的实际链接，就可以看到 `WinGet` 的安装包下载链接了。

当然，它在这里并不叫 `WinGet` ，而是叫作 `Microsoft.Desktop.AppInstall` 。

图02



如果你懒得找，也可以到翻滚到文末，有我提供的备用下载地址。



有了安装包就好说了，要用之，则安装之。

以管理员权限打开 `PowerShell` ，然后运行以下命令。

```
Add-AppxPackage .\Microsoft.DesktopAppInstaller_2024.709.2344.0_neutral_~_8wekyb3d8bbwe.Msixbundle
```



如果你遇到了错误，安装失败。

图03



别慌，这应该是有一些必要组件没安装的缘故，比如 `UI.Xaml` 之类的。

这些必要组件也都在文末一同提供下载。

安装它就是了。

```
Add-AppxPackage .\Microsoft.UI.Xaml.2.8_8.2310.30001.0_x64__8wekyb3d8bbwe.Appx
```

图04



然后再回过头来，安装 `WinGet` ，应该没问题了。

图05



安装成功，`WinGet` 可以使用了。

打开命令提示符，输入命令看看有没有反应。

图06



它列出了命令语法，大概 `命令+选项` 这个样子。

```
winget  [<命令>] [<选项>]
```



其中命令如下：

>  install          安装给定的程序包
>  show           显示包的相关信息
>  source        管理程序包的来源
>  search        查找并显示程序包的基本信息
>  list               显示已安装的程序包
>  upgrade     显示并执行可用升级
>  uninstall     卸载给定的程序包
>  hash           哈希安装程序的帮助程序
>  validate      验证清单文件
>  settings      打开设置或设置管理员设置
>  features     显示实验性功能的状态
>  export        导出已安装程序包的列表
>  import        安装文件中的所有程序包
>  pin               管理包钉
>  configure    将系统配置为所需状态
>  download   从给定的程序包下载安装程序
>  repair          修复所选包



选项如下：

>-v,--version                               显示工具的版本
>--info                                         显示工具的常规信息
>-?,--help                                     显示选定命令的帮助信息
>--wait                                         提示用户在退出前按任意键
>--logs,--open-logs                    打开默认日志位置
>--verbose,--verbose-logs        启用 WinGet 的详细日志记录
>--nowarn,--ignore-warnings  禁止显示警告输出
>--disable-interactivity             禁用交互式提示
>--proxy                                      设置要用于此执行的代理
>--no-proxy                                禁止对此执行使用代理



别看它那么多的命令参数，其实主要也就几个，比如搜索、安装、卸载等等。



使用 `WinGet` 安装程序，我们就用 `install` 命令就可以了。

```
winget install <程序名称>
```



前面是使用 `WinGet` 安装一个应用程序，要是安装多个应用程序，直接在 `install` 后面多加几个就是了。

```
winget install <程序名称1> <程序名称2> ...
```



举个例子吧，安装 `Windows` 终端，`PowerToys` 和 `VSCode` 这三个应用程序。

```
winget install Microsoft.WindowsTerminal Microsoft.PowerToys Microsoft.VisualStudioCode
```



想要安装什么程序，其实可以先搜索一下。

比如搜索火狐浏览器。

```
winget search firefox
```

但是为什么会失败呢？

图07



再来搜索一下 `PowerToys` 。

图08



还是失败了，没有找到，但是它却给出了可能的结果。

原来软件的名称没那么简单，要写完整才算数。

也就是说，要写成 `Microsoft.powertoys` ，它才能识别，感觉有点智障啊！



那我有些软件并不知道它的名称如何拼写，怎么办呢？

干脆都把它罗列出来吧！



用 `list` 命令可以列出所有安装的程序。

```
winget list
```

图09



有了名称（ID），我们就可以用 `download` 命令下载安装程序了。

```
winget download <程序名称>
```

比如，我们要下载 `PowerToys` ，可以这样。

```
winget download microsoft.powertoys
```

图10



这里面最重要的是明确所要安装软件的确切名称，名称写错或写不全都可能导致安装失败。

因此，我们需要先利用关键字查找到确切的软件名称才行，然后就可以放心大胆地安装它了。

举个完整点的例子吧，我来尝试安装一下便笺软件。



先搜索一下。

```
winget search stickynotes
```

找到两个带有 `stickynotes` 关键字的，好像都不是微软自带的那个程序。

不管了，随便安装一个看看。

```
winget download ZhornSoftware.Stickies
```

图11



总之，先搜索后安装，就是这么一个套路。



类似像升级 `upgrade` 、卸载 `uninstall` 以及查看软件包信息 `show` 等命令就不赘述了。

更多具体的操作，可以参考官方说明。

> https://learn.microsoft.com/zh-cn/windows/package-manager/winget/



**Microsoft.DesktopAppInstaller.7z**

* `Microsoft.DesktopAppInstaller_2024.709.2344.0_neutral_~_8wekyb3d8bbwe.Msixbundle`
* `Microsoft.UI.Xaml.2.8_8.2310.30001.0_x64__8wekyb3d8bbwe.Appx`
* `Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.Appx`



下载链接：https://pan.baidu.com/s/1b2_rFnJQKc5BSOQcq_u-hw

提取码：byzv



我说得吐沫横飞，正在兴头上，有人提醒午休时间到了。

我抬手一看表，可不是嘛，都11点60了。

行吧，基本的就这些了，先到这儿吧，大家赶快去吃饭吧！

看大家都散了，我就招呼大刘：“大刘……大刘……我的两个鸡腿……”

还没等我找着大刘，一同事拍我肩膀，跟我说，大刘突然家里有急事，刚跟领导请了三天假……



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc