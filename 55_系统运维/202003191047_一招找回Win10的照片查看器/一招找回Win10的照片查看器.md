一招找回Win10的照片查看器



相信即便微软在2020年1月14日彻底停止了Win7的安全更新之后，仍然还是有很多人乐此不疲地使用着Win7系统。

诚然，相比Win7，Win10肯定有着很多过人之处。

但是，有这么一个小小的功能 - **Windows照片查看器**，却是让使用Win10的人干瞪眼而怎么也找不着。

难道被微软删了？

先别开骂，实际上照片查看器并没有在Win10中删除，它只是被藏起来了。

对Win10系统来说，可能微软想让用户使用 `画图` 来查看图片，毕竟画图也是花了大力气的，不论从功能也好还是其他方面讲都是有了很大改观的。

在从前的众多视频网课中，画图也算是神器之一，被一票讲师拿来演示讲解课堂知识。

当然这仅仅是我的猜测，可是Win7用惯的老用户说，我就是要用 `照片查看器` 咋的！

其中一个原因是，这东东不仅可以幻灯片式地浏览图片，同样还可以直接拿来打印图片，超级方便啊喂！

好吧，啰嗦了这么多，还是看看怎么找回它吧。



方法是真简单，照着下面把文本复制到一个文本文件中，保存为 `reg` 格式后，导入注册表中即可。

比如：保存并命名为 `WindowsPhotoViewer.reg`，然后双击导入即可（可能需要重启电脑）。

这里考虑到了不限于 `jpg` 之外的其他格式，当然你可以随意增减你喜欢的图片格式。

```vbscript
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations]
".tif"="PhotoViewer.FileAssoc.Tiff"
".tiff"="PhotoViewer.FileAssoc.Tiff"
".jpg"="PhotoViewer.FileAssoc.Tiff"
".jpeg"="PhotoViewer.FileAssoc.Tiff"
".bmp"="PhotoViewer.FileAssoc.Tiff"
".png"="PhotoViewer.FileAssoc.Tiff"
".gif"="PhotoViewer.FileAssoc.Tiff"
```



导入成功后随便找张图片，右键点击它，寻找 `打开方式`，看看是不是出现了 `Windows照片查看器`？

有没有成功帮到你？

不用谢我，点个赞就行！

想偷个懒？那直接下载注册表文件吧。

https://t.cn/A6zHEsa8 密码：004f

**公众号：网管小贾**