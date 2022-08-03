【快速全面掌握 WAMPServer】11.安装 PHP 扩展踩过的坑

副标题：【快速全面掌握 WAMPServer】11.安装 PHP 扩展踩过的坑

英文：master-wampserver-quickly-and-install-php-extension-troubleshooting

关键字：https,http,http2,ssl,wampserver,wamp,openssl,troubleshooting,扩展,extension,pecl





> **WAMPSERVER免费仓库镜像（中文）**
> https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files



我们在调试程序代码时，总会遇到一些 `PHP` 项目需要某些扩展组件。

而在 `WAMPServer` 下通常的 `PHP` 扩展的安装也不算有多麻烦。

具体关于 `PHP` 扩展的区分（比如安全线程或非安全线程），以及怎么安装小伙伴们可以参考之前的教程内容。

但是世事无常，总有一些特殊情况发生，包括我们在安装扩展时。

接下来我就和大家分享一下，我在安装 `imagick` 扩展时遇到的奇葩经历。



**环境背景：WAMP（PHP7.1.9 + Apache2.4.27）**



### 起因

最近需要使用到图形添加水印等操作，于是找到了 `Intervention Image` 这个组件。

大神的轮子拿来用，还真是方便！啧啧！

出于好奇，发现配置文件 `image.php` 中，除了 `gd` 库外，还可以使用 `imagick` 。

哎，这个东东平时不太留意啊！听说效率比 `gd` 要高很多。嗯，盘它！

自此开启入坑之路......



打开 `phpinfo` ，从图中可以看到，我当前使用的是 `32` 位的 `WAMPServer` ，而由于是 `Windows` 系统，因此是线程安全的 `(TS)` 。

图01



然后网上一顿猛搜索，找到了我当前环境所匹配的扩展包（ `32` 位 、 `PHP` 版本以及 `TS` ）。

图02

图03



下载完成后解压扩展包中的 `php_imagick.dll` 文件到 `php` 环境的 `ext` 目录中。

```
C:\wamp(64)\bin\php\phpx.x.x\ext
```

这里务必注意 `PHP` 的版本号，应当是当前默认运行的那个版本。



好了，轻车熟路，修改配置文件 `php.ini` ，开启加载 `php_imagick.dll` 扩展。

```
extension=imagick
```



### 问题出现

一切都是那么的简单，不是吗？

OK，重启 `WAMPServer` 服务加载扩展......

纳尼！没有成功？

使用测试命令 `php --ri imagick` 试试，还是失败，说什么扩展没找到。

图04



打开 `phpinfo` 页面，居然也没有找到 `imagck` 扩展。（失败了当然找不到了）

看来问题并没有那么简单！



### 一顿折腾

接下来就是一番折腾了，前途很光明，道路很曲折！

我经历过的坑，总结如下，希望小伙伴少走弯路啊！



##### 1、到 `ImageMagick` 官网下载相应版本的安装程序。

安装过后仍然失败，其实告诉你，根本不需要安装官网的程序。



##### 2、按网上指导新建一个环境变量 `MAGICK_HOME` ，同样没有用。



##### 3、在安装了官网的程序后，`phpinfo` 中会出现 `imagick` 扩展项目。

先别高兴得太早，怎么 `ImageMagick number of supported formats` 一项居然是 `0` ！

网上的文章居然不明就里，说过段时间后再使用又好了。

说是 `apache` 下显示为 `0` ，换 `nginx` 就是正常的。

这不是放 `P` 嘛！我不信！事实证明我是对的。



##### 4、扩展包中的 `CORE_xx.dll` 的所有文件复制到php目录下，还有说复制到apache的bin下的，均告失败。



### 终成正果

好了，折腾得也够累了，给出最终答案吧。

其实很简单，只需两步即可。（ `php.ini` 开启扩展别忘记）



**第一步，把扩展包中根目录下的所有dll文件解压到 `php` 的 `ext` 扩展目录中。**

**第二步，在系统变量 `Path` 中添加 `php` 的 `ext` 扩展目录路径。**

图05



打完收功！就这么简单！

给出最终成功搞定的截图。

图06

图07



不管是命令测试，还是 `phpinfo` 都正确显示当前 `imagick` 扩展版本为 `3.4.4` ，并且支持格式多达数十种。



### 教程小结

有时调试 `php` 环境也是非常考验人的一项工作，要想做好的前提便是对所做内容的充分了解。

本文之前为啥会失败，个人总结有可能是没有将扩展正确地都解压缩出来，导致未能完全识别扩展文件。

因此我们也从中可以了解到，安装扩展有可能并不是一个文件，也有可能是一堆文件。

此外对于扩展文件的属性，在安装之前我们也要充分把握以免折腾一场徒劳无功。

生命在于折腾，但也要少折腾！希望本文能够帮到爱学习求进步的小伙伴们！

让我们期待下一期教程吧！



*PS：《【小白PHP入坑必备系列】快速全面掌握 WAMPServer》教程列表：*

> * *【快速全面掌握 WAMPServer】01.初次见面，请多关照*
> * *【快速全面掌握 WAMPServer】02.亲密接触之前你必须知道的事情*
> * *【快速全面掌握 WAMPServer】03.玩转安装和升级*
> * *【快速全面掌握 WAMPServer】04.人生初体验*
> * *【快速全面掌握 WAMPServer】05.整明白 Apache*
> * *【快速全面掌握 WAMPServer】06.整明白 PHP*
> * *【快速全面掌握 WAMPServer】07.整明白 MySQL 和 MariaDB*
> * *【快速全面掌握 WAMPServer】08.想玩多个站点，你必须了解虚拟主机的创建和使用*
> * *【快速全面掌握 WAMPServer】09.如何在 WAMPServer 中安装 Composer*
> * *【快速全面掌握 WAMPServer】10.HTTP2.0时代，让 WampServer 开启 SSL 吧！*
> * *【快速全面掌握 WAMPServer】11.安装 PHP 扩展踩过的坑*
> * *【快速全面掌握 WAMPServer】12.WAMPServer 故障排除经验大总结*
> * *【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！*
> * *【快速全面掌握 WAMPServer】14.各种组件的升级方法*
>



> **扫码关注@网管小贾，个人微信：sysadmcc**
>
> 网管小贾的博客 / www.sysadm.cc

