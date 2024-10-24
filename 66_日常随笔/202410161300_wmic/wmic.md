windows11安装wmic，另附离线安装方法及安装包









可用按需功能

> https://learn.microsoft.com/zh-cn/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod?view=windows-11

图f01



添加 `WMIC` 。

```
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
```



删除 `WMIC` 。

```
DISM /Online /Remove-Capability /CapabilityName:WMIC~~~~
```



挂载 `Windows` 系统安装镜像，通过镜像来安装。

```
DISM /Online /add-Capability /CapabilityName:WMIC~~~~ /Source:wim:D:\Sources\Install.wim:4
```



注意：带有 `/Online` 参数时，一定要连接上网络才行，否则会报错。





```
dism /mount-image /imagefile:C:\install.wim /mountdir:C:\mount /Index:4 /ReadOnly
```











```
Dism /Image:C:\mount /Add-Package /PackagePath:C:\Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~amd64~zh-CN~.cab
```



```
Dism /Image:C:\mount /Add-Package /PackagePath:C:\Microsoft-Windows-WMIC-FoD-Package~31bf3856ad364e35~wow64~zh-CN~.cab
```



通过 `foD` 镜像安装。

```
Dism /Online /Add-Capability /CapabilityName:WMIC~~~~ /Source:G:\LanguagesAndOptionalFeatures /LimitAccess
```





最后可以试一下是否安装成功，最简单的就用如下命令，看看有没有输出。

```
wmic os
```





Windows 11 版本 21H2 语言和可选功能 ISO
Windows 11 版本 22H2 和 23H2 语言和可选功能 ISO
Windows 11 版本 24H2 语言和可选功能 ISO

> https://learn.microsoft.com/zh-cn/azure/virtual-desktop/windows-11-language-packs



备用下载：

Windows 11 版本 24H2 语言和可选功能 ISO

下载链接：https://pan.baidu.com/s/15GBwlL_io2i-FK3byezFew

提取码：jv5v

