如何离线安装XPS查看器？

副标题：我想打印，可是电脑没连打印机，怎么办？



上周末应同村的流浪哥邀请赴豪宅小聚，到他家时正赶上他在忙着双十一抢购。

见我来了，他迫不及待地指着购物车里的一台网红打印机，问我：“赶紧，帮我解决一个问题，我好省下这台打印机的钱！”

我心想，不愧是久经商场的老将，早已深谙商家的各种算计，搞了半天这是要算计到我这儿来了啊！

不等我回答，他紧接着说道：“如果一台电脑不联网，同时又没有连接任何打印机，想要打印东西应该怎么办？”

看着他呆萌的大脸，我说我帮你有什么好处？

他狡黠地微笑了一下，暗示我好处少不了。

这个问题嘛...我摇头晃脑，开始搜肠刮肚找起了办法。



很快我想到了 `XPS Viewer` ，通常 `Windows` 系统都有预装 `Microsoft XPS Document Writer` 虚拟打印机。

完全可以先把内容打印成 `xps` 或 `oxps` 格式的虚拟文件，然后转移到有打印机的电脑上再通过 `XPS Viewer` 打印。

图1



在连接有打印机的电脑上打开 `xps` 或 `oxps` 格式的虚拟文件，然后直接打印到实体打印机上就可以完成纸张打印。

连接打印机的电脑上需要安装好 `XPS查看器` 。

如果是 `Windows7` ，那么只要在 `控制面板 > 程序 > 打开或关闭 Windows 功能` 里开启 `XPS Viewer` 即可。

图2



如果是 `Windows10` ，那么只要在 `开始 > 设置 > 应用 > 可选功能 > 添加功能` 里安装 `XPS 查看器` 即可。

图3



**`XPS查看器` 安装非常简单，然而对于 `Windows10` 的用户来说，通常需要联网才能成功安装。**

联网安装的方法网上有很多，只要你的电脑能正常访问互联网，那么在等待片刻时间即可完成 `XPS查看器` 的安装。

图4



但是，如果一台电脑它是不联网的，那该怎么安装 `XPS查看器` 呢？

有的小伙伴会问，这叫什么问题，这种情况有意义吗？



有些公司为了管控互联网而部分限制了访问，实际上这种情况下是无法正常安装可选功能的。

换句话说，当我们的电脑需要打开 `xps` 或 `oxps` 格式的虚拟文件时，因为没有联网所以无法正常下载安装 `XPS查看器` 。

于是就产生了一个问题，像这种几乎和断网没啥区别的情况下，又如何能安装上 `XPS查看器`呢？ 





### 寻找安装源（包）

首先想到的是，`XPS查看器` 会不会存在于安装镜像中，也就是我们系统的安装盘中。

以管理员身份运行 `PowerShell` ，列出正在运行的操作系统中的可选功能。

```powershell
PS C:\> Get-WindowsOptionalFeature -Online | findstr "XPS"
```

图5



如图，答案是否定的，Windows10的镜像中并不包含 `XPS查看器` 。

其他方法，诸如在 `Windows2016` 镜像中寻找等方法，我也已经折腾过了，建议小伙伴们不要学我浪费了时间。

最后经过查证才得知，默认支持镜像安装 `XPS查看器` 只提供到 `Windows 10 Version 1709` ，之后的 `Windows 10 Version 1803` 开始就不再提供了。



最后搜索到网上相关的帖子，链接如下：

```
https://social.technet.microsoft.com/Forums/en-US/0acc5178-9336-41b6-8a0f-ae4ea1ced453/feature-on-demand-empty-add-xps-viewver-win1803?forum=winserverwsus
```

找到了安装源（包）应该是这个样子的。

图6



于是灵机一动，用了个歪招，再一次利用联网安装时，找出了系统自动下载的安装源（包），**文末有免费下载哦**。

路径如下，`135dad3ce3fd44ea6c6aa650cb70f324` 应该是临时命名的文件夹名称。

```
C:\Windows\SoftwareDistribution\Download\135dad3ce3fd44ea6c6aa650cb70f324
```

图7





### 尝试离线安装 `XPS.Viewer`

有了安装包，胆子就大多了。



**1、获取映像中关于 `XPS.Viewer` 的功能信息。**

```
Dism /Online /Get-CapabilityInfo /CapabilityName:XPS.Viewer~~~~0.0.1.0
```

图8



**2、将 `XPS.Viewer` 功能添加到系统中。**

```
Dism /Online /Add-Capability /CapabilityName:XPS.Viewer~~~~0.0.1.0
```

图9



注意哦，此时会报错，因为它会自动尝试连接网络下载安装。

很显然，我们没有联网，当然会出错了，所以这里的命令参数要改一改，必须要指定安装源（包）才可以。



新建文件夹 `C:\sysadm` ，把前面提到的安装包文件 `Microsoft-Windows-Xps-Xps-Viewer-Opt-Package~31bf3856ad364e35~amd64~~.cab` 放到新建的文件夹内。

再次尝试使用以下命令安装。

```
Dism /Online /Add-Capability /CapabilityName:XPS.Viewer~~~~0.0.1.0 /LimitAccess /Source:"C:\sysadm"
```

图10



OK，这样离线安装就成功了！



### 总结

有了离线安装包后，就可以实施批量安装等操作了，对于解决部分联网不畅等问题真是大大滴有用啊！

如果你有离线安装 `XPS查看器` 的需求，可以参考尝试这些方法。

嗯，测试成功了，我得赶紧趁着这次双十一找流浪哥要好处去。



本文测试环境，系统版本是 `Windows 10 x64 2004 (19041.208)` ，仅供小伙伴们参考。



**XPS查看器离线安装包下载链接：**

应小伙伴们的要求，我多测试了几个平台。

如果好用，请小伙伴们务必关注微信公众号@网管小贾，并多多分享给他人。

Xps-Viewer-Win10_2004.7z

Xps-Viewer-Win10_1909.7z

Xps-Viewer-Win10_LTSC.7z

Xps-Viewer-Win10_21H2.7z（New!)



**Xps-Viewer-Win10_21H2.7z**

下载链接：https://pan.baidu.com/s/11BtsOK6mnRXtQWZ_XRM9Lg

提取码：faz3



**Xps-Viewer-Win10_2004.7z**

下载链接：https://pan.baidu.com/s/12mFWsCwM19AvC8bgNarcMw 

提取码：z9ms

解压密码：www.sysadm.cc 



**Xps-Viewer-Win10_1909.7z**

下载链接：https://pan.baidu.com/s/17CfxgPo2EujxFgzrR4QNIw 

提取码：d6q9



**Xps-Viewer-Win10_LTSC.7z**

下载链接：https://pan.baidu.com/s/1qSv4x-uEJ3jc23PHuIEZfg 

提取码：aaf1









> WeChat@网管小贾 | www.sysadm.cc

