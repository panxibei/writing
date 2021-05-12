体验 Windows 10 预览版安装

副标题：

英文：

关键字：



Windows 10 预览版？

是的，你没有看错，也可以理解为测试版。

可能有的小伙伴会说，我用着好好的稳定版干吗要用预览版呢？

哎，这就不得不提到我之前碰到的一件事儿了。



前不久有那么一天，手机上XX给我推送了一条消息，大意为 Win10 WSL 可以支持 Linux 版本的图形界面程序了。

当即我就发出了 wc 一声惊叹，立马上网查了查这个叫作 `WSLg` 的新鲜玩意。

`WSLg` 就是 `WSL` GUI 的简称，它的项目主页在 `https://github.com/microsoft/wslg` 上，有兴趣的小伙伴可以去看看。

这个玩意到底是什么意思，又怎么玩呢？

其实它就是在 `WSL2` （`WSL` 第二版）的基础上增强了支持图形程序的功能，像我们平时在 `Linux` 上使用的众多图形软件都可以用这玩意实现了，是不是有点小激动？

不过，这个和前面提到的 Windows 10 预览版有啥子关系？

说到这儿，我心中都是泪啊！

就因为审题不认真，我以为只要是 `WSL2` 就能给按上 `GUI` 的功能，结果瞎忙活了半天，愣是没搞定。

回头再一看官网上的介绍，上面来了一句这样的描述。

> * Windows 10 Insider Preview build 21362+
>   * WSLg is going to be generally available alongside the upcoming  release of Windows. To get access to a preview of WSLg, you'll need to  join the [Windows Insider Program](https://insider.windows.com/en-us/) and be running a Windows 10 Insider Preview build from the dev channel.



原来是要用到 `21362` 及以上版本的 Win10 才行啊！

我又扒了扒手头的系统版本，这才发现现有的系统都是特么19开头的，21开头的基本可以认定为预览版了。

好了，到这儿总算是把话又绕回来了，容我喘口气先！



OK，事情已经很明确了，要想玩一玩 `WSLg` ，那就得先搞定预览版。

具体咋整？Just follow me ！



### 安装预览版的方法

步骤一，点击开始菜单，依次打开 `设置 `> `更新和安全` > `Windows 预览体验计划` 。

图1



步骤二，点击右侧的 `开始` 按钮，出现选择链接帐户提示。

图2



步骤三，选择适合你的微软帐户，点击继续。

通常我们可以使用个人帐户，比如 `sysadm@outlook.com` 。

图3



步骤四，输入帐户和密码，并点击下一步。

图4

图5



步骤五，登录成功后，提示帐户设备使用许可，以及需要注册，点击下一步和注册。

图6

图7

图8

图9

图10



步骤六，注册成功后，它会让你选择使用哪个渠道。

一共三个渠道，`Dev` 、`Beta` 和 `Release Preview` 。

我个人的理解，其区别可以简单地认为 `Dev` 最新但最不稳定，`Release Preview` 最旧相对稳定一些，`Beta` 则居前两者之间。

我的目的很简单，毕竟是男人嘛，追求最新最刺激也就最好玩的，所以我选 `Dev` 。

图11

图12



步骤七，重新启动你的电脑。

图13



步骤八，重启后如果你觉得你选错了渠道，其实它是可以反悔的，男人嘛，谁还没有个年轻的时候呢。

图14

图15



步骤九，点击开始菜单，依次打开 `设置` > `更新和安全` > `Windows 更新` 。

如果没有自动开始检查更新，那么在右侧手动点击一下检查更新。

这个时候应该可以看到有 Windows 10 预览版的更新下载。

图16



到这里都很简单了，让它慢慢下载即可，等它自动安装完成后重启电脑即可。

图17



### 从前有座庙，前方有个坑

安装预览版和以往的 Win10 升级或安装更新有点类似，不过我在安装的过程中也遇到了坑，分享给小伙伴们以防各位失手。

通常当我们自信满满地点击了 `Windows 预览体验计划` 后，很可能我们会遭遇一片白茫茫的尴尬情况。

图18



就像图片中那样的情况，我们应该怎么继续玩预览版呢（搓手）？

实际上我也是拾人牙慧，有个超简单的方法。

以管理员身份打开 `PowerShell` 或命令终端，执行以下命令即可。

```
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
# Telemetry level: 1 - basic, 3 - full
$value = "3"
New-ItemProperty -Path $path -Name AllowTelemetry -Value $value -Type Dword -Force
New-ItemProperty -Path $path -Name MaxTelemetryAllowed -Value $value -Type Dword -Force
```



它实际上相当于在注册表中增加了两个注册表项。

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection]
"AllowTelemetry"=dword:00000003
"MaxTelemetryAllowed"=dword:00000003
```



执行完毕后不需要重启电脑，再次打开 `Windows 预览体验计划` 后你就能继续安装预览版的进程了。



### 告一段落

Windows 10 预览版总算安装完成了，当然了，原来是什么系统版本并不重要，大概略应该都可以安装实现。

至少我在 `2004` 和 `21H2` 两个版本上都已经试过了，么有什么问题。

那么接下来我们应该做些什么呢？

回到文章的开头，我们的起心动念是为了看看 `WSLg` 这个东东啊，所以紧接着我们就应该在这预览版的基础上进一步来实现图形 `WSL` 的功能。

至于我们能不能做到呢？

在些过程中又会遇到怎样的坑呢？

码字半天了，让我先去小解一下，回头再和小伙伴们慢慢道来！



**扫码关注@网管小贾，阅读更多**

**网管小贾的博客 / www.sysadm.cc**