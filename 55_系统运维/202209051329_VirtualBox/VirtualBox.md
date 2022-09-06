好消息，VirtualBox 发布 7.0 预览版！

副标题：好消息，VirtualBox 发布 7.0 预览版！

英文：good-news-oracle-vm-virtualbox-7.0-beta-1-is-now-available

关键字：oracle,vm,virtualbox,7.0,beta,甲骨文,虚拟机





作为开源软件的 `VirtualBox` 是我常用的虚拟机软件之一，自然我也是它的重度爱好者。

就在不久前的2022年8月29日， `Oracle Linux` 及虚拟化产品管理总监 `Simon Coter` 在其官方博客中向大众兴奋宣布 `VirtualBox` 已经释出了 `7.0` 的 `Beta 1` 预览版本。

这是个重大的好消息！

这意味着即便 `VirtualBox 7.0` 的正式版还未发布，但至少我们可以用这个测试版来把玩尝鲜了。

图01



就在此前大约一年左右的时间，大量的用户在使用 `VirtualBox 6.x` 上安装 `Windows 11` ，或是在 `Windows 11` 上安装 `VirtualBox` 时遭遇大量问题而焦头烂额。

在 `VirtualBox 7.0 Beta 1` 发布之前，虽然 `6.x` 版本下也可以安装 `Windows 11` ，但可能需要“做些手脚”来绕过一些限制。

但即使如此，在所谓安装成功后也可能会出现各种各样的问题，至少无法在 `Windows 11` 上安装 `VirtualBox` 。

图02



为此在 `VirtualBox`  官方论坛上曾经展开过激烈的讨论，而官方的表态是，旧版本无法完全支持 `Windows 11`  的某些新特性，结论就是要等新版本出来再说。

这不，官方还是比较给力的，现在新版本呼之欲出！



### `VirtualBox 7.0.0 Beta 1` 版本包括许多新的增强功能

* 改进了包括 `DirectX 11 / OpenGL` 支持的虚拟机的 `3D` 体验。
* `IOMMU` 和 `EPT` 支持嵌套虚拟机，这是改善 `Microsoft Windows` 主机体验所必需的。
* 完整的 `VM` 加密，可通过命令行界面使用类似 `top` 的工具，用于监控每个正在运行的虚拟机的 `CPU` 和内存使用情况。

* 录音：使用 `Vorbis` 作为当前 `WebM` 容器的默认音频格式，而 `Opus` 不再被使用。

* 音频：添加了“默认”主机驱动程序类型，以便在不同平台之间移动虚拟机（设备），无需显式更改音频驱动程序。

  当选择了“默认”驱动程序，将使用平台的最佳音频后端选项。

  这是新建 `VM` 的默认设置。

* 客户机控制：实现 `Linux` 客户机可自动更新客户机扩展更新的初始支持。
* 客户机控制：当通过 `VBoxManage` 添加客户机扩展时实现在更新时等待和/或重新启动客户机的功能。
* `VBoxManage` ：添加了访客控制 `waitrunlevel` 子命令，使其可以等待客户机达到一定的运行水平。
* `Windows` 主机：添加了在会话 `0` 中运行自动启动 VM 的实验性支持，即使用户未登录也允许运行 `VMS`（默认情况下禁用，请查阅手册）
* 更新的外观和感觉



与其他网站和公众号捣浆糊态度有所不同，我不会简单粗暴地将官网内容照搬照抄。

不是我们不信哈，我们就想开开眼界！

懂！本着对小伙伴们负责的态度，这个 `Beta 1` 版到底是啥个样，我们肯定是骡子是马总要拉出来溜溜。

好了，为节省大家的时间，我就将一些我个人体验的截图和说明分享于此。

小伙伴们有兴趣想自己动动小手的，那么在看完本文后请自觉点赞、转发再优雅离场，谢谢合作哈！





### 尝试安装 `VirtualBox 7.0.0 Beta 1`

我们在 `BIOS` 中开启虚拟化支持后就可以开始安装了。

最初安装时你可能会遭遇到如下图那样的问题。

图03

图04

图05



别慌哈，这只是由于系统中没有安装 `VC++2019` 组件的缘故，安装好后就没问题了。

在文末我将组件包与 `VirtualBox 7.0` 安装程序打包在了一起，小伙伴们可以直接下载使用。

图06

图07



组件安装OK后，我们就可以开始安装 `VirtualBox 7.0` 啦！

图08



还是熟悉的味道，还是一成不变的套路。

图09



`VirtualBox` 需要安装虚拟网卡，因此如果你有程序在使用网络，记得此时停一停。

图10



呃，突然又说缺少依赖程序......

图11



其实不用多想，就是个 `Python` ，其实它只在 `API` 接口编程时用得到。

我们看看手册，里面有写。

> * Python support.    This package contains Python scripting support for the Oracle VM
>   VirtualBox API, see chapter 11, Oracle VM VirtualBox Programming Interfaces, page 374.
>   For this to work, an already working Windows Python installation on the system is required.
>
>   See, for example: http://www.python.org/download/windows/
>
> 译文：
>
> * `Python` 支持    此安装包包含对 `Oracle VM` 的 `Python` 脚本支持的 `VirtualBox API` ，请参阅第 `11` 章，`Oracle VM` 和 `VirtualBox` 编程接口，第 `374` 页。
>
>   为此，需要在系统上安装可运行的 `Windows` 版的 `Python` 。
>
>   参见：http://www.python.org/download/windows/

图12



明白了！想要玩接口编程再安装 `Python` 也不迟啊，至少我们现在不着急用哈！

果断按下 `是(Y)` 继续，后面安装完全没问题！

图13

图14

图15



### 体验安装虚拟客户机

`VirtualBox 7.0.0 Beta 1` 我们安装完毕，接下来让我们装个 `Windows 11` 的虚拟客户机玩玩吧！

初次打开是这个样子。

图16



把右侧的警告信息关闭，新界面的样子一下子好看多了。

图17



先看看关于信息。

图18



OK，在正式安装虚拟客户机之前，我们应该安装扩展程序。

图19



在切换后的界面上点击安装 `Install` 。

图20



选择扩展程序文件（文末有打包下载）。

图21



确认并同意安装信息。

图22

图23

图24



好了，开始创建虚拟客户机，对此比较熟悉的小伙伴看图就可以了。

图25

图26

图27

图28



最终 `Windows 11` 安装成功，整个过程没有任何报错或限制问题，非常丝滑！

图29

图30

图31

图32

图33



### 打包下载

* `VirtualBox-7.0.0_BETA1-153351-Win.exe`
* `VirtualBox-7.0.0_BETA1-153351-OSX.dmg`
* `Oracle_VM_VirtualBox_Extension_Pack-7.0.0_BETA1-153351.vbox-extpack`
* `VBoxGuestAdditions_7.0.0_BETA1.iso`
* `vcredist_2022_x64.exe`
* `UserManual.pdf`
* `SDKRef.pdf`
* `SHA256SUMS.txt`



**Virtualbox7.0.0_BETA1(327M)**

下载链接：



### 写在最后

从前面的安装体验过程中，我们能看到新版本对 `Windows 11` 的支持已经非常好了。

也许其中还有一些 `BUG` ，但毕竟是预览测试版本，在正式版出来之前肯定会修复改进的，至少现在看起来还不错。

另外从界面上看，仍有部分文字没有汉化，说明还有很多工作需要做，期望官网加快步伐，早日释出完美的正式版。

好了，作为留给大家的家庭作业，请大家将前面新建的 `Windows 11` 客户机的扩展程序继续安装完成。

最后我找来个大喇叭：请小伙伴们自觉点赞、转发再优雅离场，谢谢合作哈！





**将技术融入生活，打造有趣之故事。**

网管小贾 / sysadm.cc