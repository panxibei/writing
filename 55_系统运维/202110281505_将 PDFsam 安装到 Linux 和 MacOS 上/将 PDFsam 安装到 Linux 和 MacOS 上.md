

将 PDFsam 安装到 Linux 和 MacOS 上

副标题：不同平台上也能自由分割合并pdf了~

英文：installing-pdfsam-on-linux-and-macos

关键字：



之前给小伙伴们介绍过一款用于分割、合并等功能的神器 `PDFsam` 。

>前方参考：《就在刚才有人问我怎么拼接合并 PDF 文件》
>
>前文链接：https://www.sysadm.cc/index.php/xitongyunwei/876-just-now-someone-asked-me-how-to-merge-pdf-files



不过之前介绍时，我们只在 `Windows` 上安装演示，其实它是跨平台的，在 `Linux` 和 `MacOS` 上都能安装使用。

这次我们就来走一遍，看看 `Linux` 和 `MacOS` 上如何安装 `PDFsam` 。

如之前所述，打开 `GitHub` 上的项目下载链接。

下载链接：https://www.github.com/torakiki/pdfsam/releases



### `Linux` 上安装 `PDFsam`

如图所示，我们先来下载 `Linux` 的安装包。

图01



**1、新建一个目录，名称随意，这儿以 `sysadm` 为例。**

```
sudo mkdir /sysadm
cd /sysadm
```



**2、下载最简单的方式，可以在系统中使用如下命令。**

```
sudo wget https://www.github.com/torakiki/pdfsam/releases/download/v4.2.7/pdfsam-4.2.7-linux.tar.gz
```



**3、下载完成后解压缩。**

```
sudo tar zxvf pdfsam-4.2.7-linux.tar.gz
```

在解压后新生成的 `pdfsam-4.2.7-linux` 目录中，我们可以在 `bin` 子目录中找到可执行文件 `pdfsam.sh` 。

图02



那么这个可执行文件能不能运行得起来呢？

在官网 `FAQ` 中有说明，从版本4开始，`OpenJDK 11` 和简化版本已经与应用程序组合在一起了，因此无需另外再安装 `OpenJDK` 了。

OK，我们现在用的就是版本4（`4.2.7`）啊！

完美， 这就说明我们可以直接运行 `bin/pdfsam.sh` 来启动应用程序了。



正常启动后 `Ubuntu` 下是这样的。

图03



正常启动后 `Rocky Linux` 下是这样的，`CentOS` 之类的可以参考之。

图04



界面和 `Windows` 的基本一样，语言设置和其他操作我就不再多说了。

接下来我们看看 `MacOS` 上安装 `PDFsam` 有没有什么别的花样。



### `MacOS` 上安装 `PDFsam`

我们回到前面据说的下载链接处，找到适合 `MacOS` 的安装包并下载之。

图05



下载完成后双击 `dmg` 安装包，在出现的安装界面中点击 `Agree` 。

图06



到这儿就和 `Windows` 上的不一样了，它出现了如下的界面。

此时应该双击 `PDFsam Basic` 图标，它是用于启动应用程序的入口。

图07



之后便正常打开了应用程序界面，接下来就和其他平台上的操作并无两样了。

图08



### 文档转换时的权限问题

基本上 `PDFsam` 的安装并没有什么困难之处，开源跨平台软件不仅支持多语言，操作也十分亲民。

不过这里要强调一个坑，那就是被操作的对象 `PDF` 文档的权限问题。



由于 `PDFsam` 本身就是对文档进行分割、提取或合并等转换性质的操作，其本质就涉及读写操作（特别是写操作），因此在 `Linux` 等讲究权限的非 `Windows` 平台下要格外注意正确赋予文档写入权限。

以 `Ubuntu` 为例，当我们提取或合并操作后获得了一个新生成的文档，这时应该至少给这个文档加上可读权限，以避免产生无法打开查看文档的尴尬。

图09



从图中我们可以看到，新文档在普通用户组下并没有读写权限，所以在完成操作之后，我们还要手动给它加上读写权限。

```
# 赋予可读权限
sudo chmod 644 xxx.pdf

# 赋予读写权限
sudo chmod 666 xxx.pdf
```



权限修正后，我们就可以愉快地对文档进行下一步操作了。



### 写在最后

`PDFsam` 是一款非常优秀的 `PDF` 加工软件，只要你不是对文档进行文字图像的编辑，基本上普通的页面加工都能胜任。

本文也通过简单的说明，演示了其跨平台上完美实现安装的过程。

如果小伙伴们正在寻找分割、合并、旋转 `PDF` 文档等等功能的应用程序，那么 `PDFsam` 绝对是值得你考虑试用的。

好了，今后关于 `PDFsam` 如果还有什么新发现，我将继续为大家介绍分享，希望大家也一如既往不断关注和支持我！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
