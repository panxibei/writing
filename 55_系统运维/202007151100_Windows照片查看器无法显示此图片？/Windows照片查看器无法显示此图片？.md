Windows照片查看器无法显示此图片？

副标题：这个事情有点搞~



自从在Win10上找回了照片查看器，终于快活了一阵子。

>  前文：[《一招找回Win10的照片查看器》](https://www.sysadm.cc/index.php/xitongyunwei/15-win10-photo-viewer)

但是，近来却发现有几张高清MM图片无法用照片查看器打开，出现了如下错误提示。

图1

内存不足？硬盘已满？亦或是MM图片损坏了？

搞笑的是，用其他图像软件却都能打开！

还能不能愉快地做朋友了？



网友们也有遭遇此类问题，纷纷献计献策。

比如，追加内存（难道我的16G内存很小？），清理硬盘（我的硬盘很空的好不？），或者干脆用第三方软件替代。

可是我就是个倔强的人儿啊，不想用第三方软件呢。

于是我果断开始踩坑和填坑，小伙伴们要不要和我一起上路呢？



#### 几个好大坑

坑一：修改系统临时变量路径。

TMP变量路径由原来的 `%USERPROFILE%\AppData\Local\Temp` 修改为诸如 `D:\tmp` 之类的路径。

其实这就是前面提到的硬盘空间不足的梗！

结果肯定是无效了，有点被耍的感觉。



坑二：分辨率问题，开启`ClearType` 即可。

按路径 `C:\Windows\System32\cctune.exe` 打开 `ClearType` 设置。

一路下一步直到完成，结果无效。（本来就启用的，又被耍了！）

图2



坑三：颜色管理

`控制面板（小图标）` > `颜色管理` > `高级` ，设备配置文件一项选择不同的项目。

好多啊，我选哪个？

我选择了好几个，包括网上说的 `Agfa` ，都不行，心好累！

图3



#### 探索真相

使用Windows照片查看器到底为什么打不开某些图片呢？

经过一番研究，大概、可能、也许、或者和图片的颜色显示有关。

根据

一是为什么校准颜色（疑似系统颜色空间和图片自带颜色空间不一致），二是为什么内存不足（疑似读取图片长和宽时读错大小）。结合JPG图片的格式规范(里面有图片的扩展信息，包括JFIF，EXIF，ICC等等,这些信息不是图片的必要信息，允许删除)，利用winHex编辑器（二进制编辑器）对JPG图片的扩展信息进行修改、切除等操作，观察图片是否能恢复正常，以便查找病灶。



最终发现可能是ICC信息导致的问题。

ICC配置格式说明：[Embedding ICC profiles in image file formats](http://www.color.org/profile_embedding.xalter)

色彩同步描述文件：

图4



就像前面说的坑三那样，打开 `颜色管理` 的 `高级` 选项卡，可以看到 `设备配置文件` 中有很多配置名称。

图5



查看一下自己图片的ICC信息，好像设备配置文件里没有找到啊。

图6



https://superuser.com/questions/1509194/windows-photo-viewer-cant-run-because-not-enough-memory



图7

网址：https://imagemagick.org/script/download.php

下载链接：[ImageMagick-7.0.10-23-portable-Q16-x64.zip](https://imagemagick.org/download/binaries/ImageMagick-7.0.10-23-portable-Q16-x64.zip)

简易转换程序 `convert.exe`。

下载链接：https://o8.cn/KlsvYD 密码：6nn3

```shell
convert BADFILE.jpg -strip GOODFILE.jpg
```



如果你要批量转换图片

```powershell
mogrify.exe -format jpg -verbose -path C:\OUTPUT_DIR -strip *.jpg
```

Might be also used relative path like **-path OUTPUT_DIR** if You want them in subfolder.





