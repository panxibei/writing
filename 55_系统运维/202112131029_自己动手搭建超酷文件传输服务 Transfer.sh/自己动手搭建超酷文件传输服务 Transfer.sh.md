你居然还在用微信传文件？试试自己动手用 transfer.sh 搭建超酷文件传输服务

副标题：一个超简单文件传输方案 transfer.sh ~

英文：still-sending-files-through-wechat-try-using-transfersh-to-build-cool-file-sharing-service

关键字：transfer.sh,go,golang,文件共享,curl,wget,sharing



怎么将文件传给别人？

这还不简单，用微信啊！再不行用 `QQ` 啊！

好了好了，要是再这么说就暴露水平了，哈哈！

其实文件传输完全可以变得更优雅更酷炫的哦！



这次我就要给小伙伴介绍一款文件传输分享服务 `transfer.sh` 。

它由 `golang` 开发，支持多个操作系统平台，可以带给我们全新的文件传输体验的解决方案。

它的特点是，简单、快速，通过命令行的方式传输文件。

并且可以提供加密保护、无限上传下载、链接式分享等功能。

还没有接触过 `transfer.sh` 的小伙伴建议先参考一下以前的文章。



> 前文参考：
>
> 文章链接：



好了，`transfer.sh` 很好玩，但最最最重要的是，它还可以作为单独的实例为我们提供我们自己的文件服务系统。

意思就是说，我们可以用它来建立自己的文件分享系统，这样我们就可以更加安全更加自由地与他人传递信息。

本文将重点给大家分享如何搭建一个属于自己的 `transfer.sh` ，在此期间我再穿插一些使用的方法和手段，以加深对 `transfer.sh` 服务的理解。



### 安装 `transfer.sh` 服务

由于 `transfer.sh` 支持跨平台，因此我们就用 `Windows` 来做演示，这样让小伙伴们也更加容易理解，至于 `Linux` 或 `BSD` 甚至是安卓等系统基本上是大同小异的。

打开 `Github` 上的项目页面，找到 `Release` 并下载相应的安装包。

> https://www.github.com/dutchcoders/transfer.sh/

图a01



如果你的网速不错，也可以直接下载 `exe` 文件，我们下载的压缩包解压后其实也是得到一样的 `exe` 文件。

下载完成后，将其中的 `transfersh-v1.3.0-windows-amd64.exe` 这个文件释放出来，放到一个指定的文件夹中，比如我这边是 `C:\sysadm` 。

图a02

图a03



我们打开命令提示符，输入以下命令可以得到帮助信息。

```
C:\sysadm\transfersh-v1.3.0-windows-amd64.exe -h
```

图a04



这些帮助信息作为参考，等一会儿就会用到。

另外如果你觉得这个文件名也太长了点，那你可以将它重命名为 `transfersh` 这样的较短的名字。

当然，作为演示我后面都还会沿用原来的较长的文件名。



### 启动 `transfer.sh` 服务

在启动服务之前，我们需要先建立一个文件夹，用于映射暂存目录。

比如，在 `C` 盘根目录下新建一个文件夹 `tmp` 。

```
mkdir C:\tmp
```



然后按照以下参数启动服务， `^` 用于不中断命令的换行。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider=local ^
	--listener :80 ^
	--temp-path=/tmp/ ^
	--basedir=C:\tmp\
```



参数解释如下：

* `--provider=local`

  实际临时文件存放到本地。

* `--listener :80`

  `transfer.sh` 服务开启 `80` 端口侦听。

* `--temp-path=/tmp/`

  `transfer.sh` 服务内部的临时文件夹为 `/tmp/` 。

* `--basedir=C:\tmp\`

  设定本地文件夹 `C:\tmp\` 与服务内部目录 `/tmp/` 相互映射，作为临时文件存放地。



注意，在命令执行前请务必确保服务器端口已在防火墙中开放。

好了，命令执行后服务就开始运行了。

图a05



这个时候，我们打开浏览器，在地址栏内输入 `http://server_ip` 后回车。

我们会惊喜地发现，我们自己的 `transfer.sh` 服务器已经在正常运行中了。

图a06



我们可以看到，虽然与官方首页长得挺像，但里面的命令参数或链接都变成了我们自己服务器的IP地址了。

当然如果我们使用域名方式访问服务器也是可以的，只要保证能够正常解析域名即可，那样的话我们看到的页面上就是服务器的域名了。

接下来我们就试一下，看看能不能拿来传输文件。



### 测试上传文件

假定当前目录中有一个文件 `hello.txt` ，输入以下命令，我们将这个文件上传到服务器。

```
curl --upload-file ./hello.txt http://server_ip/hello.txt
```

图a07



从返回的结果中我们得到了一个下载链接，比如：

```
http://server_ip/5liLmu/hello.txt
```



我们回到服务端来看看有没有什么变化。

嘿，果不其然，在服务端指定的本地文件夹 `C:\tmp` 中新生成了一个 `5liLmu` 的文件夹。

并且这个文件夹的名字与我们刚才上传时生成的随机字符串一致。



好，我们再来看看文件上传之后到底是怎么存放的。

一共有两个文件，一个就是我们上传的文件，另一个是以 `metadata` 为后缀的元数据文件。

图a08



让我们看看这个 `metadata` 里面到底是什么东东。

用记事本打开它，可以看到如下的内容。

```
{
	"ContentType":"text/plain; charset=utf-8",
	"Downloads":0,
	"MaxDownloads":-1,
	"MaxDate":"0001-01-01T00:00:00Z",
	"DeletionToken":"7vEDa9tajs8U"
}
```



这个格式有点眼熟啊，感觉就是个 `Json` 数据嘛！

当然了，实际上以上内容是写在一行的，为了大家查看方便直观稍稍换了行。

这个 `Json` 就是以 `key-value` 的形式保存的数据信息，那么具体各个 `key` 的意思我想小伙伴们大概也能猜出个一二来吧。

比如 `MaxDonloads` 它的值是 `-1` ，表示无限下载。

这里有一个比较有趣的 `key` ，就是那个 `DeletionToken` ，后面跟着一串奇怪的字符。

这个又是什么意思呢？



从字面意思我们也能猜出个八九不离十哈，就是删除令牌啊！

那么它正是用于删除我们上传文件的。



### 如何删除上传的文件

其实我们通过在命令中追加 `-H "X-Url-Delete"` 参数即可从客户端获取删除令牌。

```
# -I 用于查看返回信息
curl -I -H "X-Url-Delete" --upload-file ./hello.txt http://server_ip/hello.txt
```

图a09



从图中的返回信息中我们就可以看到有那么一行带有删除令牌的信息。

没错，那最后一串奇怪的字符就是删除令牌了。

```
X-Url-Delete: http://server_ip/0czFd5/hello.txt/NcPETCcGExW2
```



然后，怎么删？

很简单，拿刚才的令牌信息，照搬下面的命令就行了。

```
curl -X DELETE http://server_ip/0czFd5/hello.txt/NcPETCcGExW2
```



如果加上参数 `-I` 则可以查看返回信息。

当然了，即便你不主动删除文件，它也会在 `336` 小时后自动删除。

图a10



OK，成功删除文件！

我们回到服务端也能看到文件已经被成功删除了！

图a11



即使打条命令就可以删除文件，官方在新版中也新开发了提供网页界面删除文件的功能。

如图我们只要先点击 `delete` 那个按钮，然后再输入删除令牌 `DeletionToken` 并按下确认 `confirm` 按钮就可以删除文件了。

图a12





### 使用 Docker

这么好的项目上头的人肯定不在少数，但就算精简到只需一个文件就可以作为服务启动可能也出拯救不了部分懒人那慵懒的心。

这不，`transfer.sh` 还提供了 `Docker` ，我猜这下肯定有人要欢呼了。

拉取镜像后执行如下命令。

```
docker run --publish 8080:8080 dutchcoders/transfer.sh:latest --provider local --basedir /tmp/
```



感觉 `Docker` 是万能的，因为不少系统或设备就很好地支持 `Docker` ，那么就可以直接拿来用了。

例如我想到的，你如果有专门存放文件的网盘，比如群辉之类的 `NAS` ，那么就可以结合 `transfer.sh` 的 `Docker` 镜像来部署文件分享服务，真的是很方便啊！



### 结合第三方云存储

如果你是第三方云存储服务的用户，比如 `Amazon S3` 、 `Google Drive` 或 `Storj` ，那么恭喜你，最新版的 `transfer.sh` 已经提供了非常棒的用于连接这些存储服务供应商的支持。

我们只要将 `--provider` 参数指向对应的供应商名称，然后设定其他相应的参数即可。



为了举例，我专门注册了 `Storj` 。

`Storj` 是一家很有发展潜力的云存储解决方案，具体小伙伴可以自行了解，我也是刚用上，如果以后有更多了解再和大家分享。

这款存储免费版提供了 `150GB` 的空间，虽说空间不大，但如果只是用来临时转发文件倒还算不错。

我们如果想要将 `transfer.sh` 连上 `Storj` ，那么至少需要给出三个参数值。

- provider `--provider storj`
- storj-access *(either via flag or environment variable STORJ_ACCESS)*
- storj-bucket *(either via flag or environment variable STORJ_BUCKET)*



第一个参数肯定就是指向 `Storj` ，而第二个和第三个参数则是指访问 `Storj` 的加密密钥和 `Bucket` 。

这个 `Bucket` 我觉得可以简单地理解为分类或大文件夹。

那么利用 `Storj` 来做 `transfer.sh` 的最小化命令就可以这样写。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider storj ^
	--storj-access <ACCESS GRANT> ^
	--storj-bucket <BUCKET NAME>
```



具体 `Storj` 怎么设置？

如果你申请了 `Storj` ，那么可以大致参考下面的步骤和方法。



首先，点击左侧导航菜单项 `Buckets` ，然后点击右上角的按钮新建一个 `Bucket` ，将其命名为 `sysadm` 。

图b01



其次，点击左侧导航菜单项 `Access` ，新建一个访问密钥，比如给它一个名字叫作 `transfer.sh for 网管小贾` 。

图b02



再其次，按你的实际需求，设定这个密钥应用到哪些 `Buckets` ，还有有效期以及上传下载等权限。

图b03



再再次，输入密钥的密码，这个很重要，密码强度不能太弱，并且千万别忘记了。

图b04



最后，一切OK，密钥生成，建议小伙伴们将密钥下载保存下来以备不时之需。

图b05

图b06



好了，我们接下来就试一试之前这些设定能不能实际用上。

在服务端接合前面的设定参数输入命令开启 `transfer` 服务。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider storj ^
	--storj-access 1jA3fVg....fbaT6ja9 ^
	--storj-bucket sysadm
```

图c01



从图中可以看出，服务器的IP是 `127.0.0.1` ，并且侦听端口是 `8080` 。

没错，因为我是在自己电脑上开启服务的，所以是本机回送地址，端口则是默认的。

使用回送地址并不需要担心，它只是说服务是在本机上跑，实际连接的则是 `Storj` 的远程存储服务。



好，服务已经起来了，我们上传一个文件试试效果。

```
curl -I --upload-file ./hello.txt http://127.0.0.1:8080/hello.txt
```

图c02



服务端正常工作。

图c03



我们赶快到 `Storj` 这边来看看，到底文件有没有成功上传。

进入 `Buckets` 之前我们需要确认我们的访问密码（前面有设定过，但不是密钥哦）。

图c04



一路进到命名为 `sysadm` 的 `Bucket` 中，果然可以看到我们刚刚上传的文件，并且也生成了元数据文件。

图c05



好了，我们再来试试删除好不好使。

客户端输入如下命令。

```
curl -I -X DELETE http://127.0.0.1:8080/sBUYda/hello.txt/K0X3X1fPXGPX
```

图c06



同时服务端也正常动作。

图c07



最后查看删除情况，不知道是不是我操作有误，上传的文件的确被删除了，可是元数据文件没有被删除。

不过我们可以手动将其删除。

图c08



### 让 `transfer.sh` 支持 `https`

有的人有强迫症，比如像我，感觉默认的 `http` 链接不安全也不十分正规。

给别人用嘛肯定要用 `https` 这样的链接才显得正规严谨，所以下面我们一起给 `transfer.sh` 加上 `https` 功能。



实际上 `transfer.sh` 已经支持了 `https` ，我们只要给定几个 `https` 需要的参数就可以了。

比如 `tls-listener` 、`tls-cert-file` 和 `tls-private-key` 。

前一个是加密侦听端口，我们知道 `https` 端口一般默认为 `443` 。

而后两个则是 `https` 所需的证书和密钥。



我们以自签名证书为例，使用 `openssl` 来生成证书，只要三步。

```
# openssl genrsa -out sysadm.local.key 2048
# openssl req -new -key sysadm.local.key -out sysadm.local.csr
# openssl x509 -req -days 3650 -in sysadm.local.csr -signkey sysadm.local.key -out sysadm.local.crt
```

`openssl` 需要到网上下载安装后才能使用，这个小伙伴们自行解决吧，我就不啰嗦了。

最后生成三个文件，而我们要用到的只有以 `.key` 和 `.crt` 结尾的两个文件。

* `sysadm.local.key` - 私钥（备用）
* `sysadm.local.csr` - 请求（不用）
* `sysadm.local.crt` - 证书（备用）



将证书和密钥与 `transfer.sh` 服务文件放在一起，我们执行以下命令。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider local ^
	--tls-listener :443 ^
	--tls-cert-file=sysadm.local.crt ^
	--tls-private-key=sysadm.local.key ^
	--temp-path /tmp/ ^
	--basedir C:\tmp\
```

图c09



从启动的结果来看，服务端口已经正常在 `443` 上侦听了。

为了进一步确认它到底有没有达到效果，我们打开网站链接，特意加上 `https` 。

```
https://server_ip
```

没错了，`transfer.sh` 已经正常开启 `https` 了。

图c10



正好，我们就此尝试用一下浏览器的上传功能。

点击页面中的 `click to browse` ，选择要上传的文件后点击打开按钮。

OK，文件不仅成功上传，而且还返回了删除令牌信息，同时还提供了打包下载文件的功能，完美！

图c11



不过如果你要是用命令行的话，那么还需要注意一点，就是我们用的是自签名证书，所以我们必须要加上参数 `-k` 跳过 `SSL` 的加密检测，否则会失败。

```
curl -k --upload-file hello.txt https://server_ip/hello.txt
```



### 写在最后

到目前为止一切都是这么完美，`transfer.sh` 的确太好用了！

由于它是开源的，又是用 `go` 语言写的，因此对 `go` 熟悉的小伙伴们可以视实际需求改造一些东西，比如它的首页展示内容等等，可以让它更符合我们的需要。

此外 `transfer.sh` 还有不少可以设定的参数，对应着不同的使用场景，让我们可以灵活地因地制宜地使用它。

如果你正在寻找临时转存文件的方案，特别是自己私有环境下需要这么一个可用于多人分享文件的东西，那么 `transfer.sh` 真的是值得我们考虑的。



最后由于 `transfer.sh` 的口号是打造命令行式的文件传输服务，因此对一些喜欢用图形界面的小伙伴可能不那么友好了。

基于此，在以后的时间里，如果我有多余空闲哈，那我可能会做一个图形客户端专门定制用于 `transfer.sh`的文件传输。

到时候我们就可以轻轻松松地用这个图形程序来操作上传下载文件了。



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

