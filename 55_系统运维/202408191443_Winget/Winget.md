Winget

副标题：

英文：

关键字：











`WinGet` ，全名为 **Windows Package Manager**，即 `Windows` 程序包管理器的意思。

它是微软官方推出的一个命令行工具，用于在 `Windows` 系统上安装、管理和升级软件包。

`WinGet` 没什么神秘的，它相当于 `Linux` 中的 `apt`（ `Ubuntu/Debian` ）或 `yum/dnf` （ `CentOS/RedHat` ）等发行版的程序包管理工具。



有人说了，`Linux` 我没用过啊，那些包管理工具也从来没接触过。

没事哈，如果说它一点用处也没有，那么官方也不会推出这个功能。





从 Microsoft Store 获取应用安装程序

> https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab

图a01



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

图a02



如果你懒得找，也可以到翻滚到文末，有我提供的备用下载地址。



有了安装包就好说了，要用之，则安装之。

以管理员权限打开 `PowerShell` ，然后运行以下命令。

```
Add-AppxPackage .\Microsoft.DesktopAppInstaller_2024.709.2344.0_neutral_~_8wekyb3d8bbwe.Msixbundle
```



如果你遇到了错误，安装失败。

图a03



别慌，这应该是有一些必要组件没安装的缘故，比如 `UI.Xaml` 之类的。

这些必要组件也都在文末一同提供下载。

安装它就是了。

```
Add-AppxPackage .\Microsoft.UI.Xaml.2.8_8.2310.30001.0_x64__8wekyb3d8bbwe.Appx
```

图a04



然后再回过头来，安装 `WinGet` ，应该没问题了。

图a05



安装成功，`WinGet` 可以使用了。

打开命令提示符，输入命令看看有没有反应。

图a06



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

图b02



再来搜索一下 `PowerToys` 。

图b03



还是失败了，没有找到，但是它却给出了可能的结果。

原来软件的名称没那么简单，要写完整才算数。

也就是说，要写成 `Microsoft.powertoys` ，它才能识别，感觉有点智障啊！

图b03



那我有些软件并不知道它的名称如何拼写，怎么办呢？

干脆都把它罗列出来吧！



用 `list` 命令可以列出所有安装的程序。

```
winget list
```

图b04



有了名称（ID），我们就可以用 `download` 命令下载安装程序了。

```
winget download <程序名称>
```

比如，我们要下载 `PowerToys` ，可以这样。

```
winget download microsoft.powertoys
```

图b05



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

图b06



总之，先搜索后安装，就是这么一个套路。



类似像升级 `upgrade` 、卸载 `uninstall` 以及查看软件包信息 `show` 等命令就不赘述了。

更多具体的操作，可以参考官方说明。

> https://learn.microsoft.com/zh-cn/windows/package-manager/winget/



**Microsoft.DesktopAppInstaller.7z**

* `Microsoft.DesktopAppInstaller_2024.709.2344.0_neutral_~_8wekyb3d8bbwe.Msixbundle`
* `Microsoft.UI.Xaml.2.8_8.2310.30001.0_x64__8wekyb3d8bbwe.Appx`
* `Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.Appx`

下载链接：







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc