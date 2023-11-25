用VB6或VBA将文件批量上传到OneDrive

副标题：用VB6或VBA将文件批量上传到OneDrive

英文：batch-upload-files-to-onedrive-using-vb6-or-vba

关键字：vb,vb6,sharepoint,上传,onedrive



前不久我给小伙伴们简单粗略地介绍了一下如何用 `VB6/VBA` 将文件批量自动上传到 `Sharepoint` 的思路和方法。

具体内容可以搜索我以前写的文章《用 VB6/VBA 将文件批量上传到 Sharepoint》。



节目播出后引起了广泛的关注和巨大的反响，人人称赞、好评如潮。

出乎我意料的是，打破了历史记录，前后总共收获了3.5个赞（一个是我自己点的，还一个哥们可能是误点了），让我高兴得合不拢腿！

后来有的小伙伴就问我，有没有想过如何用 `VB6/VBA` 将文件批量自动上传到 `OneDrive` 呢？

我正沉浸在疯狂的喜悦中，你说我是不回答，还是不回答呢？

好吧，看大家都这么热情，我也不好推脱什么，就花点时间研究一下吧，希望对大家有用。

对了，麻烦您动动小手点个赞（单数），年底有考核！



说到 `OneDrive` 呢，我想我不用多啰嗦哈，大家都知道，是一款微软出品的网盘软件，存存文件，放放东西用的。

作为一款还算良心的网盘呢，大家在使用 `Office` 时多多少少会把文档之类的都顺手放到了 `OneDrive` 里。

当然这也是微软有意为之搞 `OneDrive` 的目的，让你的文档放到“云”上，随时随地都可以查看编辑，的确也方便。

这么一来呢，用的多了就会有依赖感，增加了依赖感就更加用得频繁。

好了，回到我们的主题，我想通过 `VB6/VBA` 自动把文档放到 `OneDrive` ，怎么办？



最初，我想到的一个笨办法，就是将文档放到本地的 `OneDrive` 同步文件夹里。

这样的话 `OneDrive` 就会自动将文档上传同步到云端。

这样做是不是挺简单的？

不过，问题是，`OneDrive` 的本地同步文件夹在哪个地方？



你会说查看一下 `OneDrive` 的设置，里面就有文件夹路径啊！

我只能说，同学，图样图森破！

要知道我们现在用的高级工具是 `VB6/VBA` 哦，不用那么死板哈！



OK，注意，看我手的动作……

在命令提示窗口中打个 `set` 命令，回车。

嗯，仔细找上这么一找，哎，你就能发现有我们需要的 `OneDrive` 文件夹变量。

通常它应该是这样式儿的。

```
OneDrive=C:\Users\username\OneDrive
OneDriveCommercial=C:\Users\username\OneDrive - COMPANY
```

图01



是不是有眼前一亮的感脚？

前一个 `OneDrive` 可能是个人版的路径，而后一个 `OneDriveCommercial` 则是商业版的路径。

先别忙记下来，我们不能直接拿来用，还需要转换成 `VB6/VBA` 代码，没错，直接上环境变量函数。

```
Environ$("OneDrive")
Environ$("OneDriveCommercial")
```



至于要用哪个，就看你的需要了，用的是个人版还是商业版，不过怎么看上去好像实际文件夹路径可能都一样哈。



有了目标文件夹路径，我们下面就可以使用保存函数将文件保存到 `OneDrive` 的文件夹内，以此来实现上传文件的目的。

当然，这种方法有点傻，不太正宗的感脚，因为只要把 `OneDrive` 客户端关掉，那么上传功能就等于失效了。

实际上正宗的方法应该是靠 `VB6/VBA` 程序自己远程上传到 `OneDrive` 才算数，并不需要依赖 `OneDrive` 客户端程序。

在本文的后半段我会将正宗的远程上传方法及源代码说明，并且提供示例源代码下载供大家参考。



示例 `VB6/VBA` 源代码，供大家参考。

* `Upload4OneDrive`（源码示例，含本地和远程两种实现方法）
* `XJVBHttp` 编译可执行程序
* `XJVBHttp` 文件上传 `Sharepoint` 源代码（ `OneDrive` 通用）

下载链接：https://pan.baidu.com/s/1vns1NUgcL3uLTBX9OtBAgA

提取码：<文末付费查看>



图04

图05



在此之前，我先把刚才没说完的内容，如何利用保存函数将文件保存到 `OneDrive` 同步文件夹内介绍给大家……



首先，我们要先确认我们想要上传的文档是什么格式，这个有一些讲究……

（注意，以下为付费内容部分）

============================================



以下内容请付费查看

↓↓↓↓↓↓↓↓





在 `VBA` 中，我们可以利用函数 `ActiveWorkbook.SaveAs` 来保存文件。

这个 `SaveAs` 函数中有一个参数，需要我们事先明确保存文件的格式。

保存文件的格式，可以简化为使用数字来替代。

```
50 = xlExcel12 (Excel binary formatted workbook, with or without macros, .xlsb)
51 = xlOpenXMLWorkbook (macro-free Excel workbook, .xlsx)
52 = xlOpenXMLWorkbookMacroEnabled(Excel workbook with or without macros, .xlsm)
56 = xlExcel8 (Excel 97 through Excel 2003 formatted files .xls)
```



比如，我们通常使用的 `xlsx` 文件格式参数 `xlOpenXMLWorkbook` ，就可以简单地用数字 `51` 来表示。

那么我们可以将文件格式简写成这样。

```
FileFormat:=##
```

比如，普通 `Excel` 文件格式 `.xlsx` ，这样式儿写就行了。

```
FileFormat:=51
```



完整一些的 `VBA` 代码，保存文档到本地 `OneDrive` 文件夹内，可以参考如下。

```
' 生成一个新的演示文档
Workbooks.Add
ActiveWorkbook.Sheets(1).Range("A1") = "网管小贾 / sysadm.cc"

' xlsx格式
FileFormat = 51 'xlOpenXMLWorkbook

' 根据OneDrive环境变量保存到OneDrive文件夹内
ActiveWorkbook.SaveAs Filename:=Environ$("OneDrive") & "\test123.xlsx", FileFormat:=FileFormat, CreateBackup:=False

' 关闭保存的文档
ActiveWorkbook.Close
```



接下来我们来研究如何打开远程 `OneDrive` 上的文件。

实际上这么做的目的只有一个，就是获取远程文件夹路径，以便使用 `VB6/VBA` 程序自动上传文件。



那么怎么获取远程文件夹路径呢？

通常我们会先通过复制远程已有的文件链接来揣摩实际的链接路径。

图02



得到如下类似链接。

```
https://xxxx-my.sharepoint.com/:x:/r/personal/username_xx_yy_com/Documents/123.xlsx?d=w8e402b322ff148b594562e8624c252c2&csf=1&web=1&e=diu3Zg
```



接着尝试将后半部分的文件名和参数去掉，放到浏览器的地址栏内访问。

```
https://xxxx-my.sharepoint.com/:x:/r/personal/username_xx_yy_com/Documents/123.xlsx
```



可能会报错，因为这里边有加密或干扰项。

找来找去非常麻烦并且不得要领，最后还是通过查找资料才发现 `OneDrive` 的路径和 `Sharepoint` 其实是差不多的。



`OneDrive` 远程链接与 `SharePoint` 类似，一般为以下路径形式。

```
https://tenant-my.sharepoint.com/personal/username/Documents/
```



例如，你的公司域名假设叫作 `sysadm.local` ，那么可能是如下这个样子。

```
https://sysadm-my.sharepoint.com/personal/userid_sysadm_local/Documents/
```

前面主机名为 `公司域名-my` ，后面用户名为用户完全域名 `FQDN` 的形式。



接下来就好办多了。

只需定义一个变量，将这个远程文件夹路径加上要上传文件的名称放到这个变量中直接调用即可。

如下是打开 `OneDrive` 远程文件的参考代码：

```
sfilename = "https://sysadm-my.sharepoint.com/personal/userid_sysadm_local/Documents/test123.xlsx"
Set xl = CreateObject("Excel.Sheet")
Set xlsheet = xl.Application.Workbooks.Open(Filename:=sfilename, ReadOnly:=True)
```



好了，可以试试看能不能远程打开 `OneDrive` 上保存的文件了。

虽说打开远程文档可以不需要 `OneDrive` 客户端（亲测），但是本文前半段介绍的本地上传文档方法毕竟还是靠的客户端偷摸在后台完成的。

有点魔术障眼法糊弄洋鬼子的感脚，总归有欺骗大众的嫌疑对吧，因此还是要想办法真正地实现远程上传的功能才行。

这不我们已经知道了远程文件夹路径的方法，有了远程路径就容易实现了。



具体怎么实现的，可以参考之前我写的上传 `Sharepoint` 的方法。

内容非常多，限于篇幅一两句话是没办法说清楚的。

简言之是通过 `HTTP` 的交互方法实现的。

在这我就不赘述了，感兴趣的小伙伴可以参考前文。



这里我只放 `VB6/VBA` 源代码，供大家参考。

* `Upload4OneDrive`（源码示例，含本地和远程两种实现方法）
* `XJVBHttp` 编译可执行程序
* `XJVBHttp` 文件上传 `Sharepoint` 源代码（ `OneDrive` 通用）

下载链接：https://pan.baidu.com/s/1vns1NUgcL3uLTBX9OtBAgA

提取码：allb



图03



图04



图05





**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc

