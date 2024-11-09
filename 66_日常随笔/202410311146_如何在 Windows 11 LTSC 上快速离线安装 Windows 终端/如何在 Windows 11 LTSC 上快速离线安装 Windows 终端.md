如何在 Windows 11 LTSC 上快速离线安装 Windows 终端

副标题：如何在 Windows 11 LTSC 上快速离线安装 Windows 终端

英文：

关键字：





Windows 11 LTSC 安装 Windows 终端。





官网关于 Windows 终端的介绍页面。

> https://www.microsoft.com/store/productId/9N0DX20HK701?ocid=pdpshare



安装方法很简单。

通过应用商店安装。

具体就不啰嗦了，搜索一下就有了。

图01



通过应用商店安装是一种联网安装方式。

如果想要离线安装呢？

在以前我曾经介绍过一种方法，就是通过应用商店的分享链接来查询并下载相应的安装包，然后再安装即可。

离线安装包文末有下载。

图02



然后通过一条简单的命令即可安装。

```
PS> Add-AppPackage .\Microsoft.WindowsTerminal_3001.21.2911.0_neutral_~_8wekyb3d8bbwe.Msixbundle
```

需要注意的是终端程序安装包的名字要确保正确。

图03



安装完成后，在所有应用里就显示出来了。

图04



打开看一下相关信息吧。

图05



**微软Windows终端程序离线安装包**

下载链接：https://pan.baidu.com/s/1UpDomAR3GzZjZiphH5TYLg

提取码：mmzb



请注意，我们现在所用的这些新系统，默认已经是网络系统了。

因此像 `Windows 11` 这种比较新的系统，自然也是默认你联网的。

所以说如果你在安装好 `Windows` 终端之类的程序后仍然打不开，那么可以尝试联下网，重新一下电脑，终端程序有可能就可以正常显示出来了。







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc