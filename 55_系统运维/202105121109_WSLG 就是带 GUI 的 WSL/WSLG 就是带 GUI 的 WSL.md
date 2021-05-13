WSLg 就是带 GUI 的 WSL

副标题：预览版中求WSLg~

英文：

关键字：



前文书我们囫囵说了一说如何安装 Windows 10 预览版。

为啥要安装预览版呢，其实主要是为了玩一玩 `WSLg` ，也就是带有 GUI 图形界面的 Linux 子系统。

要说这玩意有啥好的，嘿嘿，这可是高级货哦！

要知道 Linux 下的图形程序都可以在 Windows 里运行了，那画面简直是太魔幻了！

就好像 `Wine` 一样，只是它实现的是 Windows 程序在 Linux 中运行。

那么反过来也能玩，以后不就可以直接在 Windows 上运行一些只能在 Linux 上才能运行的图形程序啦！



好了，看过前面的文章，Windows 10 预览版我们就可以搞定了。

接下来就一起来看看怎么安装 `WSLg` 吧。



### 一、确认预览版版本

官网上有这样一段介绍，说是版本要大于 `21362` 。

> * Windows 10 Insider Preview build 21362+
>   * WSLg is going to be generally available alongside the upcoming  release of Windows. To get access to a preview of WSLg, you'll need to  join the [Windows Insider Program](https://insider.windows.com/en-us/) and be running a Windows 10 Insider Preview build from the dev channel.



这也正是我们必须要用到预览版的原因，因为现在正常能用的正式版都不满足这个条件。

反正我是折腾了很久，吃了苦头才了解到的，谁叫我是菜鸟小白呢。

点击开始菜单，依次打开 `设置` > `系统` > `关于` ，来查看自己的系统版本。

图1



当前版本 `21376.1` ，好像比 `21362` 大一点哈，我数学不好，小伙伴们帮我看看。

OK，既然大一点，那么我们进入下一步。



### 二、安装 Linux 子系统

以管理员身份打开命令终端，先输入一个 `wsl` 命令，我们可以得到这个命令的参数信息。

图2



其中我们可以看到可以直接安装 Linux 子系统的命令参数。

```
wsl --install -d Ubuntu
```

注意注意，这些参数只有在预览版（`21362+`）才有。



输入这条命令回车，系统开始安装所需组件、内核以及子系统本身。

在安装过程中我们可以清楚地看到它正在安装 GUI 应用支持。

图3



安装完成后，在程序菜单中不仅可以看到有 `Ubuntu 18.04 LTS` 一项，还有一个名为 `Ubuntu-18.04` 的文件夹。

很显然，后者是为了图形界面而来的！

图4



**乌班图 `Ubuntu 18.04` 独立安装包下载。**



### 三、测试图形程序

有哪些 Linux 系统平台的图形程序呢？

我找了两个常见的程序，一个是 `gedit` ，一个是 `linux qq` 。

前者是 Linux 下的一款文本编辑器程序，后者是小伙伴们熟悉的 Linux 版 QQ 。



我们先来安装 `gedit` 。

为了速度快一些，我将安装源换成了阿里的，具体就不啰嗦了，小伙伴们可自行搜索。

然后输入命令 `sudo apt install gedit` 。

安装完成后直接 `gedit` ，嘿，漂亮！界面果然出来了！

图5



尝试点击界面或输入一些内容，好用得很啊！

好，我们再来试试 QQ 。

到官网上下载安装脚本 `linuxqq_2.0.0-b2-1089_x86_64.sh` 。

> https://im.qq.com/linuxqq/download.html



然后将这个脚本文件放到一个文件夹内，比如 `D:\sysadm.cc` 中。

开启 `Ubuntu` 子系统，在提示符后输入以下命令来安装 QQ 。

```
// 进入 D:\sysadm.cc
cd /mnt/d/sysadm.cc

// 开始安装 QQ
sudo ./linuxqq_2.0.0-b2-1089_x86_64.sh
```

很快就完成了。

图6



虽然安装完成了，但可能还有一些库文件缺失，还需要我们再安装一下。

我这儿少了两个，`libgtk-x11-2.0.so.0` 和 `libnss3` 。

```
sudo apt install libgtk2.0
sudo apt install libnss3
```

图7



一切停当后，输入命令启动 QQ 。

```
// 进入QQ所在目录
cd /usr/local/bin

// 运行QQ
qq
```

哈哈，粗线了粗线了！

哎，怎么乱码啊？

图8



嗯，乱码不是问题，至少图形界面已经OK了嘛！

如果想解决乱码问题，很简单，就一条命令的事儿。

```
// 安装中文语言包
sudo apt install  language-pack-zh-han*
```

有了中文语言包，打开 QQ 不再乱码啦！

图9



### 四、已有 `WSL` 如何安装 `WSLg`

到目前为止，一切似乎进行的都很顺利。

不过嘛如果你在已经安装有 `WSL` 的系统上更新为预览版的话，那么其实只要两条命令就可以了。

```
// 将WSL2设定为默认体系结构
wsl --set-default-version 2

// 直接更新现在有子系统，追加GUI支持
wsl --update
```





### 五、一些注意事项

1、不能在虚拟机上直接尝试使用 `WSLg` ，似乎还不支持，反正我没有成功。



2、手动安装 `WSL` 所需组件，这些是不需要联网的。

```powershell
# 启用适用于 Linux 的 Windows 子系统
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# 启用虚拟机平台
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 启用 Hyper-V 虚拟功能
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
```



3、先下载 Linux 子系统独立安装文件，然后择机安装，方便快捷。

https://docs.microsoft.com/en-us/windows/wsl/install-manual

例举 Ubuntu 熟练下载链接：

`Ubuntu 20.04` https://aka.ms/wslubuntu2004

`Ubuntu 18.04` https://aka.ms/wsl-ubuntu-1804

下载后在 `PowerShell` 中打条命令就可以快速本地安装。

```
# 命令基本格式 Add-AppxPackage .\app_name.appx
# 例如安装 C:\sysadm.cc 中的 wsl-ubuntu-1804
Add-AppxPackage C:\sysadm.cc\wsl-ubuntu-1804
```





### 最后结语

即使 `WSLg` 目前仍处于测试阶段，但个人感觉效果还是挺不错的，在不久的将来会很快发布到新的正式版本中。

根据官网文档说明，现在已经有很多图形软件被支持。

其中比较有意思的是，你还可以在 `Ubuntu` 上安装 `Microsoft-Edge` 浏览器。

```
## Microsoft Edge Browser
sudo curl https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/microsoft-edge-dev_91.0.852.0-1_amd64.deb -o /tmp/edge.deb
sudo apt install /tmp/edge.deb -y
```



为什么说它比较有意思呢？

有的小伙伴可能会说，我 `Windows` 上都有 `Edge` 了，干吗还要脱裤子放屁费二遍事在 `Linux` 子系统上再安一个呢？

其实不然，我想它的应该是出于 `Linux` 系统上测试的目的，直接在 `Windows` 上就可以做到测试 `Linux` 程序，这么牛掰难道它不香吗？

说到这儿，网上有些小伙伴不得不发出感叹，在未来我们到底会用到一个什么样的系统呢？

Linux 里有 Windows 程序，亦或是 Windows 里有 Linux 程序？

估计此时此刻又有众多小伙伴正在摇旗呐喊、齐声欢呼，伟大而崭新的 `Winux` 系统或将诞生！



**扫码关注@网管小贾，阅读更多**

**网管小贾的博客 / www.sysadm.cc**


