可以快速预览大量不同格式文件内容的神器，一番研究后我选择了 QuickLook

副标题：可以快速预览大量不同格式文件内容的神器，一番研究后我选择了 QuickLook

英文：an-artifact-that-can-quickly-preivew-the-contents-of-a-large-number-of-files-in-different-formats-after-some-research-i-chose-quicklook

关键字：quicklook,preview,预览,windows,pooi



根据警方卧底获取到的最新情报，目前暂时只知道犯罪组织的下一次交易地点与“全视之眼”标记有关。

可是这个“全视之眼”到底在哪儿呢？



经过初步审讯，据“牛二”等已被警方抓获的犯罪嫌疑人交待，以往每一次其非法交易的确均以“全视之眼”标记为接头暗号。

为了避开警方调查掩人耳目，这个“全视之眼”则存放在各自电脑的某个文件中，其保存形式有可能是图片，也可能是文字，还可能是视频，存放形式并不一定。

每次交易双方会核对存放“全视之眼”文件的哈希值，以保证接头无误不会出现任何意外。

不得不说犯罪份子狡猾之极，目前警方虽然起获了犯罪嫌疑人的电脑，但在大量的电脑文件中要寻找到存放“全视之眼”的那个文件就如同大海捞针，几乎成为一个不可能完成的任务！

于是专案组找到了信息系统方面的专家：简睿。



简睿初步了解了案情经过，沉思片刻后提议能否提供给他一份犯罪嫌疑人电脑的复制版本，他要测试一下。

经过申请，他很快拿到了电脑复制资料，于是开始着手研究。

打开电脑，果然电脑中的文件多达几百个G，而且文件类型格式五花八门，这么多文件，有文档、有视频、有图片，还有压缩包。

如果文件类型统一，那么通过编写程序批量读取文件兴许可以快速查找所需内容，但是别说文件类型不统一，就是这个“全视之眼”也并非一定是文字啊！

这可怎么找呢？



简睿突然想到了 `macOS` 系统通过按下空格键来快速查看文件的功能 `QuickLook` ，而这个功能是各种通吃，基本什么文件格式都可以快速预览。

不过嘛，现在是 `Windows` 系统啊，根本没有这功能，有的也只是 `Windows` 自带的有限的预览功能啊！

哎，他猛然想起了网管小贾曾经介绍过 `Windows` 里也可以有 `QuickLook` ......



### `QuickLook` 简介

这个 `QuickLook` 是在 `Windows` 下运行，类似于 `macOS` 下通过按下空格键即可快速查看文件内容的一款效率工具软件。



> 官网链接：https://pooi.moe/QuickLook/
>
> GitHub项目：https://github.com/QL-Win/QuickLook



一般来说，`Windows` 多多少少都自带有预览功能，但可能因为功能不咋地，因此通常预览功能默认被关闭。

并且 `Windows` 自带的预览功能即使已安装了相应程序也无法做到真正的预览。

图01



而 `QuickLook` 则不同，不仅可以快速预览各种不同类型的文件内容，而且并不需要特意安装指定的应用程序。

通常 `QuickLook` 可以快速预览图片、音视频、压缩文件，甚至也可以是文档、表格、演示文稿或PDF等等文件。



**`QuickLook` 的特点：**

* 大量受支持的文件类型（参考后面的完整列表）
* 流畅的设计（0.3版新增）
* 触摸屏友好
* HiDPI支持
* 可从 `打开和保存文件` 对话框预览
* 可从第三方文件管理器预览
* 通过插件轻松扩展
* 严格的 `GPL` 许可证确保永久免费



**目前 `QuickLook` 能支持的文件格式大概如下：**

- 几乎所有的图片格式： `.png`, `.apng`, `.jpg`, `.bmp`, `.gif`, `.psd`, Camera RAW, ...
- 压缩文件： `.zip`, `.rar`, `.tar.gz`, `.7z`, 等等
- `.pdf` 和`.ai` 文件
- 几乎所有的音视频格式： `.mp4`, `.mkv`, `.m2ts`, `.ogg`, `.mp3`, `.m4a`, 等等
- 逗号分隔值文件 (`.csv`)
- 电子邮件和 `Outlook` 文件 (`.eml` and `.msg`)
- `HTML` 文件 (`.htm`, `.html`)
- `Markdown` 文件 (`.md`, `.markdown`)
- 所有类型的文本文件 (由文件内容决定)
- 还有更多功能支持可通过安装插件实现...



### 下载安装

目前 `QuickLook` 可通过以下三种方式下载安装。

* 微软应用商店（适合 `Windows 10` 用户）。
* 从 `Github Release` 上下载 `msi` 安装包或便捷移动版本，这些都是最新稳定版本。
* 每晚版（`Nightly`），此为非稳定的测试版本。



如果你是 `Windows 10` 用户的话，那么很简单，直接打开应用商店，搜索 `QuickLook` 直接获取即可。

图02



如果你是从 `Github` 上下载下来的便捷版压缩包，那么需要注意一点，在解压缩之前最好确认一下文件是否已被解除锁定。

图03



好了，其实不管是哪种方式，都是很方便的，我们就以 `.msi` 的安装包为例为小伙伴们演示吧。



**QuickLook-3.7.1.zip 移动便携版(61.73M)**

下载链接：https://pan.baidu.com/s/19zgH76yD4xlI6Jd4SwGybA

提取码：fpj0



**QuickLook-3.7.1.msi 安装版 (56.83M)**

下载链接：https://pan.baidu.com/s/1Xf5j_HfNlrqnK-0_gxTgFQ

提取码：cv5d



安装过程很简单，就是一路耐克斯特。

图04

图05

图06

图07

图08

图09



安装完成后，右下角任务栏会出现 `QuickLook` 图标。

图10



右键点击图标查看菜单，很简单的就几项内容。

图11



### 如何使用

可以说，`QuickLook` 的操作十分的简单，基本上按空格键及方向键即可。



**操作说明：**

* 空格键：开启/关闭 预览
* `ESC` ：关闭预览
* 回车：运行程序并关闭预览
* `CTRL` + 鼠标滚轮：缩放图片/文档
* 鼠标滚轮：调节音量



我们先拿前面的 `QuickLook` 安装包作例子，选定文件后按下空格键，这时我们就能看到这个文件的信息。

图12



注意右上角的一些图标，比如第一个图标，它通常指当前文件可以用哪个默认程序打开。

比如此处，`msi` 文件自然是要用 `Windows` 安装程序打开的。

当然了，我们除了用鼠标点击这个图标外，实际上直接按下回车是一样的效果。

图13



右上角第二个图标，我们可以理解为 `打开方式` ，就是我们人为指定用什么程序打开当前文件。

图14



右上角第三个图标，则是将文件共享出去。

图15



预览压缩文件，再也不用双击了，我就看看里面都有啥，不用那么麻烦了。

图16



预览图片肯定是没问题哈。

图17



文本文件也OK。

图18



`PDF` 呢？都不用安装阅读器，照看不误啊！

图19



视频预览播放也不在话下。

图20



我们再来看看经常要用到的 `Excel` 、`Word` 这类的 `Office` 文档。

图21



呐尼？无法预览？

别着急，要想预览一些特殊的文件，那就要说到我们接下来要介绍的：插件安装。



### 插件安装

对于 `QuickLook` 来说，有部分文件要想实现预览功能，虽说不用特意安装相应的打开程序，但却也要安装有对应的插件才行。

>  插件获取链接：https://github.com/QL-Win/QuickLook/wiki/Available-Plugins



当然，安装插件并不复杂，和预览其他文件一样，我们只要在插件文件上按下空格，在出现的预览窗口中点击 `Click here to install this plugin` 即可开始安装。

图22



一旦成功安装，预览窗口的文字就变作为 `Done! Please restart QuickLook` 。

是的，你必须重启一次 `QuickLook` 才能生效。

图23



好了，我们再来看看 `Excel` 能不能预览了。

图24



不错哦，内容大体是能看到了，只是部分单元格文字可能被遮盖了。

另外 `Word` 文档预览也没有问题了。

图25



需要注意，对于 `Office` 类型的文件预览，`QuickLook` 有两个不同的插件，一个是针对已安装有 `Office` 软件的，另一个则是针对没有安装过 `Office` 软件的，要注意区分。



| 插件名称                | 最新更新   | 说明                                                         |
| ----------------------- | ---------- | ------------------------------------------------------------ |
| EpubViewer v1           | 2018/9/2   | View .epub ebooks                                            |
| OfficeViewer v4         | 2020/9/27  | View Office formats without installing MS Office             |
| OfficeViewer-Native v1  | 2019/3/30  | View Office formats when you have MS Office/WPS Office installed (Use at  your own risk, see *1 below) |
| HelixViewer v1.0.1-beta | 2018/10/24 | A plugin for viewing 3D models, supports .stl, .obj, .3ds, .lwo &  .ply |
| FontViewer v1.0.0       | 2018/10/23 | A plugin for viewing font files, supports .otf & .ttf  Doesn't work with QL 3.7 |
| ShapefileViewer v1.0.1  | 2019/1/12  | Preview ESRI .shp Shapefiles                                 |
| PostScriptViewer v1     | 2020/5/10  | Preview PostScript .ps and .eps files                        |
| ApkViewer v1.3.1        | 2020/6/3   | Preview Android package .apk                                 |
| FitsViewer v1.0         | 2021/4/6   | Preview astrophotography FITS image (.fits, .fit)            |
| FolderViewer v1.2       | 2021/1/4   | Preview content inside folders                               |
| TorrentViewer v0.1.0    | 2021/10/19 | Preview torrent file                                         |



我收集了官方发布的所有插件，`Github` 可能有时上不去，放在这儿方便小伙伴们下载使用。

图26



**QuickLook.Plugin.7z 所有插件打包(32.02M)**

下载链接：https://pan.baidu.com/s/14KaNYBRWUKCRWz9KwDl0Gg

提取码：gukc



### 后记

`QuickLook` 可以做到同时快速预览各种不同类型的文件而无需刻意将文件分门别类，这正是简睿所需要的！

比如从第一个文件开始按下空格键，之后按向下键即可切换为第二个文件预览，非常方便！

面对大量不同类型不同大小的文件，要在这么纷繁复杂、时间紧迫的情况下尽快找到含有“全视之眼”的那个文件，在没有更好的办法时大概也只能用 `QuickLook` 来查找了。

简睿下定决心，将文件分为几组，再抽调数人分别使用 `QuickLook` 快速预览文件内容来查找文件是否含有“全视之眼”标记。

究竟最后他们有没有找到那个“全视之眼”的神秘文件呢？

而这个神秘文件又是一份怎样的文件呢？

请看下回分解。



**QuickLook-3.7.3（含便携版及最新打包十多种插件）**

下载链接：https://pan.baidu.com/s/11vcYZZn-VcZl2jIvZsW2Vg

提取码：k9aw



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
