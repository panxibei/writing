Windows照片查看器无法显示此图片？

副标题：玩笑开得有点大~



前文：[《一招找回Win10的照片查看器》](https://www.sysadm.cc/index.php/xitongyunwei/15-win10-photo-viewer)



提出问题：

图1

内存不足？硬盘已满？用第三方看图软件？



坑一：修改系统临时变量路径。





坑二：分辨率问题，开启`ClearType` 即可。

`C:\Windows\System32\cctune.exe`

图2



坑三：颜色管理

设备配置文件

图3



#### 探索真相

，一是为什么校准颜色（疑似系统颜色空间和图片自带颜色空间不一致），二是为什么内存不足（疑似读取图片长和宽时读错大小）。结合JPG图片的格式规范(里面有图片的扩展信息，包括JFIF，EXIF，ICC等等,这些信息不是图片的必要信息，允许删除)，利用winHex编辑器（二进制编辑器）对JPG图片的扩展信息进行修改、切除等操作，观察图片是否能恢复正常，以便查找病灶。



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

下载链接：[ImageMagick-7.0.10-23-portable-Q16-x64.zip](https://imagemagick.org/download/binaries/ImageMagick-7.0.10-23-portable-Q16-x64.zip)

简易转换程序 `convert.exe`。

下载链接：https://o8.cn/AEP1jP 密码：vgk2

```shell
convert BADFILE.jpg -strip GOODFILE.jpg
```



如果你要批量转换图片

```powershell
mogrify.exe -format jpg -verbose -path C:\OUTPUT_DIR -strip *.jpg
```

Might be also used relative path like **-path OUTPUT_DIR** if You want them in subfolder.





