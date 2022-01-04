你居然还在用微信传文件？试试自己动手用 transfer.sh 搭建超酷文件传输服务（下）

副标题：一个简单却很花式的文件传输方案 transfer.sh ~

英文：still-sending-files-through-wechat-try-using-transfersh-to-build-cool-file-sharing-service-2

关键字：transfer.sh,go,golang,文件共享,curl,wget,sharing, wechat, 微信, 传输助手



还在用微信、QQ或者是邮件将文件传给别人吗？

那你真的 OUT 了哦！

要是文件太多、太大，或者要发给多个人，或者文件要加密，这些情况又该怎么办？

在开始本篇之前，建议先从上一篇文章开始阅读，效果会更好。



> 前文参考：《你居然还在用微信传文件？试试自己动手用 transfer.sh 搭建超酷文件传输服务（上）》
>
> 文章链接：https://www.sysadm.cc/index.php/xitongyunwei/900-still-sending-files-through-wechat-try-using-transfersh-to-build-cool-file-sharing-service-1



是的，在日常生活和工作中，我们对于文件传输可能会有各种各样的甚至是有些变态的要求，为了应对这些不同的应用场景，我们在前几篇文章中就介绍了超酷文件传输服务 `transfer.sh` 。

她是用 `GO` 语言开发的开源项目，支持多种系统平台，而且她仅有一个文件却功能强大而又多样化。

在上一篇我们主要讲的是如何初步搭建一个属于我们自己的 `transfer.sh` 服务系统，在本文中我将继续为小伙伴们分享关于她更多更广泛的应用方法。



### 使用 Docker 跑服务

这么好的项目上头的人肯定不在少数，但就算精简到只需一个文件就可以作为服务启动可能也拯救不了部分懒汉那慵懒的心。

这不，`transfer.sh` 还提供了 `Docker` 镜像，我猜这下子肯定有人要吹起口哨、欢呼雀跃了。

拉取镜像后执行如下命令。

```
docker run --publish 8080:8080 dutchcoders/transfer.sh:latest --provider local --basedir /tmp/
```



忽然感觉 `Docker` 像是万能的，因为不少系统或设备都能很好地支持 `Docker` ，那么我们就可以轻而易举地直接拿来用了。

例如我想到的，你如果有专门存放文件的网盘，比如群辉之类的 `NAS` ，那么就可以结合 `transfer.sh` 的 `Docker` 镜像来部署文件分享服务，是不是很方便啊？

有自己的网盘最好，那要是手上没有网盘呢？

我们手上没有那就向外面找找呗！



### 结合第三方云存储

如果你是第三方云存储服务的用户，比如 `Amazon S3` 、 `Google Drive` 或 `Storj` ，那么恭喜你，最新版的 `transfer.sh` 已经提供了非常棒的用于连接这些存储服务供应商的支持。

我们只要将 `--provider` 参数指向对应的供应商名称，然后设定其他相应的参数即可。

嗯，好像都不是国内的厂家哈，不知道将来会不会支持阿里腾讯。

不过先不用管这样，至少为了举例，我专门跑去注册了 `Storj` ，操作非常容易成功哦！



`Storj` 是一家很有发展潜力的云存储解决方案厂商，具体小伙伴可以自行了解，我也是刚用上，如果以后有更多了解再和大家分享。

这款存储免费版提供了 `150GB` 的空间，虽说空间不大，但如果只是用来临时转发文件倒还算不错。

我们如果想要将 `transfer.sh` 连上 `Storj` ，那么至少需要给出三个参数值。

- provider `--provider storj`
- storj-access *(either via flag or environment variable STORJ_ACCESS)*
- storj-bucket *(either via flag or environment variable STORJ_BUCKET)*



第一个参数肯定就是指向 `Storj` 了，而第二个和第三个参数则是指访问 `Storj` 的加密密钥和 `Bucket` 。

这个 `Bucket` 我觉得可以简单地理解为分类或大文件夹。

那么利用 `Storj` 来做 `transfer.sh` 的最小化命令就可以这样写。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider storj ^
	--storj-access <访问密钥> ^
	--storj-bucket <BUCKET名称>
```



具体 `Storj` 怎么设置呢？

如果你申请了 `Storj` ，那么可以大致参考下面的步骤和方法。



首先，点击左侧导航菜单项 `Buckets` ，然后点击右上角的按钮新建一个 `Bucket` ，将其命名为 `sysadm` 。

图01



其次，点击左侧导航菜单项 `Access` ，新建一个访问密钥，比如给它一个名字叫作 `transfer.sh for 网管小贾` 。

图02



再其次，按你的实际需求，设定这个密钥应用到哪些 `Buckets` ，还有有效期以及上传下载等权限。

图03



再再次，输入密钥的密码，这个很重要，密码强度不能太弱，并且千万别忘记了。

图04



最后，一切OK，密钥生成，建议小伙伴们将密钥下载保存下来以备不时之需。

图05

图06



好了，我们接下来就试一试之前这些设定能不能实际用上。

在服务端结合前面的设定参数输入命令开启 `transfer` 服务。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider storj ^
	--storj-access 1jA3fVg....fbaT6ja9 ^
	--storj-bucket sysadm
```

图07



从图中可以看出，服务内部IP是 `127.0.0.1` ，并且侦听端口是 `8080` 。

而作为测试，我也是在自己电脑本机上开启的服务，所以服务实际对外其实同样也是本机回送地址 `127.0.0.1` ，端口则是默认的 `8080` 。

使用回送地址并不需要担心，它只是说服务是在本机上跑，实际服务连接的则是 `Storj` 的远程存储服务。



好，服务已经起来了，我们上传一个文件试试效果。

```
curl -I --upload-file ./hello.txt http://127.0.0.1:8080/hello.txt
```

图08



服务端也正常工作。

图09



我们赶快到 `Storj` 这边来看看，到底文件有没有成功上传。

进入 `Buckets` 之前我们需要确认我们的访问密码（前面有设定过的，但不是密钥哦）。

图10



一路进到命名为 `sysadm` 的 `Bucket` 中，果然可以看到我们刚刚上传的文件，并且也生成了元数据文件。

图11



好了，我们再来试试删除好不好使。

客户端输入如下命令。

```
curl -I -X DELETE http://127.0.0.1:8080/sBUYda/hello.txt/K0X3X1fPXGPX
```

图12



同时服务端也执行了正常动作。

图13



最后查看删除情况，不知道是不是我操作有误还是有其他原因，上传的文件的确被删除了，可是元数据文件没有被删除，这和用自己的磁盘作存储好像有些不一样哈。

不过问题不大，我们可以手动将其删除。

图14



### 让 `transfer.sh` 支持 `https`

有的人有强迫症，比如像我，总感觉默认的 `http` 链接不安全也不十分正规。

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

图15



从启动的结果来看，服务端口已经正常在 `443` 上侦听了。

为了进一步确认它到底有没有达到效果，我们打开网站链接，特意加上 `https` 。

```
https://server_ip
```

没错了，`transfer.sh` 已经正常开启 `https` 了。

图16



正好，我们就此尝试用一下浏览器的上传功能。

点击页面中的 `click to browse` ，选择要上传的文件后点击打开按钮。

OK，文件不仅成功上传，而且还返回了删除令牌信息，同时还提供了打包下载文件的功能，完美！

图17



不过如果你要是用命令行的话，那么还需要注意一点，就是我们用的是自签名证书，所以我们必须要加上参数 `-k` 跳过 `SSL` 的加密检测，否则会失败哦。

```
curl -k --upload-file hello.txt https://server_ip/hello.txt
```



### 写在最后

到目前为止一切都是那么完美，`transfer.sh` 的确太好用了！

由于它是开源的，又是用 `GO` 语言写的，因此对 `GO` 熟悉的小伙伴们可以视实际需求改造一些东西，比如它的首页展示内容等等，可以让它更符合我们的实际需求。

此外 `transfer.sh` 还有其他不少可以设定的参数，对应着不同的使用场景，让我们可以更加灵活地因地制宜地使用她。

如果你正在寻找临时转存文件的方案，特别是自己私有环境下需要这么一个可用于多人分享文件的东西，那么 `transfer.sh` 真的是值得我们考虑的。



最后由于 `transfer.sh` 的口号是打造命令行式的文件传输服务，因此对一些喜欢用图形界面的小伙伴可能不是那么友好了。

基于此，在以后的时间里，如果我有多余空闲哈，那我可能会做一个图形客户端专门定制用于 `transfer.sh`的文件传输。

到时候我们就可以轻轻松松地用这个图形程序来操作上传下载文件了。



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
