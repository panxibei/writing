acropalypse

副标题：

英文：

关键字：







比如，手头上有一个图片文件名为 `Original.png` 。

按照以下步骤复现漏洞。



1. 备份 `Original.png` 图片文件（这是个良好习惯）。
2. 使用截图工具打开 `Original.png` 图片文件。
3. 裁剪图片，使其比原始尺寸更小一些。
4. 覆盖保存图片到当前文件（可将其重命名为 `Modified.png` ），注意覆盖保存是关键。
5. 比较裁剪后保存的文件与原始文件的大小。



漏洞相关官方链接：

```
https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-28303
```



为重现漏洞，特意重新安装了旧版的截图工具。

我这儿有之前写的一个小工具，可用于卸载应用（文末下载）。

Windows内置应用安装卸载工具.7z



找来一台电脑，安装的是  `Windows 11` 系统，其中的截图工具版本为 `11.2302.20.0` 。

图d01



接着利用我自己写的卸载应用程序将这个版本的截图工具进行卸载。

图d02



然后手动将旧版 `11.2209.20` 截图工具安装上（旧版截图工具文末下载）。

图d03

图d04



我们使用这个旧版来再现漏洞，当然 `Windows 10` 也是一样操作。



通过两个文件容量的对比，发现两者是一样大小的。

图c03



但两者的分辨率，也就是实际高度和宽度是不一样的。

图c04





我们直接来看看数据结束标记块 `IEND` ，它是用来标记图像数据到哪里为止。

标记 `PNG` 文件结束，一般用 `16` 进制表示为：

```
00 00 00 00 49 45 4E 44 AE 42 60 82
```

这个结束标记是固定的，也就是说，只要是 `png` 文件就是以这个来标记结尾的，具体的可以参考相关文档。



原始文件结尾标志在文件最后面。

图a03



而修改过的文件，它的结尾标志却在文件中间。

图a02



截图工具只是简单地将结尾标记放到了裁剪后有效内容的后面，结尾标记之后的部分却并没有删除而直接保留了下来。











命令行检测方法

`Windows` 平台这样做。

```
acropalypse_detect_64_windows.exe <文件夹/文件>
```

图b01

图c01



`Linux` 也差不多，这样做。

```
./acropalypse_detect_64_linux <文件夹/文件>
```

图c05

图c02











`Web` 版检测漏洞方法

```
https://lordofpipes.github.io/acropadetect/
```



图片文件 `Acropalypse` 漏洞检测程序

可以直接使用官方的链接，也可以使用我修正过的程序包，方便局域网内部署。

如果你是从官网下载的这个源码，可能会由于缺失部分脚本文件而无法正常工作，建议下载我提供的程序包（文末下载）。

图c06



一旦检测出问题图片就会给出警告提示。

图c07



在线恢复

```
https://acropalypse.app/
```

但是很遗憾，它并不能成功修复甚至识别有问题的图片文件。

图b02







**Windows内置应用安装卸载工具.7z(223K)**

**Microsoft.ScreenSketch_2022.2209.2.0_neutral_~_8wekyb3d8bbwe.Msixbundle.7z(3.53M)**

**Acropalypse-Detection-Tool-Go单机检测工具.7z(2.19M)**

**acropadetect在线检测工具.7z(64.7K)**

下载链接：







**哪些版本的截图工具会受到影响？**

Windows 10 及旧版本中的默认截图工具不受影响。只有 Windows 10 中的 Snip & Sketch 和 Windows 11 中的 Snipping Tool 受此漏洞影响。已发布针对这些应用程序的安全更新，可通过 Microsoft Store 获得。

**如何检查是否已安装更新？**

- 对于 Windows 10 上安装的 Snip 和 Sketch，应用版本 **10.2008.3001.0** 及更高版本包含此更新。
- 对于安装在 Windows 11 上的截图工具，应用版本 **11.2302.20.0** 及更高版本包含此更新。

**如何获取 Windows 应用的更新？**

微软商店将自动更新受影响的客户。

客户可以禁用 Microsoft Store 的自动更新。Microsoft Store 不会自动为这些客户安装此更新。你可以按照本指南通过应用商店获取更新：[获取 Microsoft Store 中的应用和游戏的更新](https://support.microsoft.com/en-us/account-billing/get-updates-for-apps-and-games-in-microsoft-store-a1fe19c0-532d-ec47-7035-d1c5a1dd464f)。根据您的操作系统，Microsoft Store 将显示可用于您已安装的截图工具的更新。







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc

