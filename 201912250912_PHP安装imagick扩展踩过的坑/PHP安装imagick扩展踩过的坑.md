PHP安装imagick扩展踩过的坑



**环境背景：WAMP（PHP7.1.9 + Apache2.4.27）**



最近需要使用到图形添加水印等操作，于是找到了 `Intervention Image` 这个组件。

大神的轮子拿来用，还真是方便！啧啧！

出于好奇，发现配置文件 `image.php` 中，除了 `gd` 库外，还可以使用 `imagick` 。

哎，这个东东平时不太留意啊！听说效率比 `gd` 要高很多。嗯，盘它！

自此开启入坑之路......



<center><strong>- 1 -</strong></center>

老一套，网上一顿猛搜索，找到了我当前环境所匹配的扩展包。

解压扩展包中的 `php_imagick.dll` 到php环境的ext目录中。

图1

图2

图3



<center><strong>- 2 -</strong></center>

轻车熟路，修改配置文件 `php.ini` ，开启加载 `php_imagick.dll` 扩展。

一切都是那么的简单，不是吗？

OK，重启服务加载扩展......

纳尼！没有成功？

使用测试命令 `php --ri imagick` 试试，还是失败。

打开phpinfo页面，居然没有找到imagck扩展。（失败了当然找不到了）

图4



<center><strong>- 3 -</strong></center>

我经历过的坑，总结如下，少走弯路：



> 1、到ImageMagick官网下载相应版本的安装程序。
>
> 安装过后仍然失败，其实告诉你，根本不需要安装官网的程序。

> 2、按网上指导新建一个环境变量 `MAGICK_HOME` ，同样没有用。

> 3、在安装了官网的程序后，phpinfo中会出现imagick扩展项目。
>
> 先别高兴得太早，怎么 `ImageMagick number of supported formats` 一项居然是 `0` ！
>
> 网上的文章居然不明就里，说过段时间后再使用又好了。
>
> 说是apache下显示为0，换nginx就是正常的。（我不信！事实证明我是对的。）

> 4、扩展包中的 `CORE_xx.dll` 的所有文件复制到php目录下，
>
> 还有说复制到apache的bin下的，均告失败。



<center><strong>- 4 -</strong></center>

好了，折腾得也够累了，给出最终答案吧。

其实很简单，只需两步即可。（php.ini开启扩展别忘记）

第一步，把扩展包中根目录下的所有dll文件解压到php的ext扩展目录中。

第二步，在系统变量Path中添加php的ext扩展目录路径。

图5



打完收功！就这么简单！给出最终抓图。

图6

图7





生命在于折腾，但也要少折腾！希望能帮到爱学习的小伙伴们！



附imagick 3.4.4 for Windows Dll文件下载：

PHP 7.4
7.4 Non Thread Safe (NTS) x64
7.4 Thread Safe (TS) x64
7.4 Non Thread Safe (NTS) x86
7.4 Thread Safe (TS) x86

PHP 7.3
7.3 Non Thread Safe (NTS) x64
7.3 Thread Safe (TS) x64
7.3 Non Thread Safe (NTS) x86
7.3 Thread Safe (TS) x86

PHP 7.2
7.2 Non Thread Safe (NTS) x64
7.2 Thread Safe (TS) x64
7.2 Non Thread Safe (NTS) x86
7.2 Thread Safe (TS) x86

PHP 7.1
7.1 Non Thread Safe (NTS) x64
7.1 Thread Safe (TS) x64
7.1 Non Thread Safe (NTS) x86
7.1 Thread Safe (TS) x86 