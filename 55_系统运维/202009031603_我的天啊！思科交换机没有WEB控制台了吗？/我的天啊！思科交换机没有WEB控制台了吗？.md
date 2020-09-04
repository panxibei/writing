我的天啊！思科交换机没有WEB控制台了吗？

副标题：交换机也玩瘦身？



最近来了一批新交换机，准备调试后上线更换。

初始化IP地址后，打开浏览器，输入 `http://x.x.x.x` 回车，没想到出事了！

以往印象中的cisco经典web界面没有出现，却打开了个白扑扑的几行英文的界面。

图1



网页加载不完全？

我刷，没变！

我再刷，一样！

尝试 `https://x.x.x.x` 访问，还是老样子。

回到 `CLI` 控制台，发现命令没有问题，不论是 `http` 还是 `https` 都已经正常开启了。

作为一名资深小白，一种不祥的预感瞬间笼罩心头，可能被搞事情了！



## 一、拨开层层迷雾

WEB的管理方式对于小白来讲还是不可或缺的，赶紧上网查吧！

这一查不要紧，果不出所料，在N年前就有人被搞过了，晚辈来迟！

图2



论坛里给出的解释是，交换机中没有嵌入基于WEB的设备管理程序。

若要解决此问题，须下载更新官方提供的IOS镜像，这个镜像必须是 `tar` 格式包含WEB管理器的文件。

> The story is the same for both Cat2960 and Cat2950: to support web based management you need to have embedded web based device manager. When  downloading the system image file from Cisco you need to choose combined tar file which includes both the IOS and web based device manager. The  simple indication whether you have downloaded (and extracted) the proper file is the presence (or absence) of "html" directory within your  flash. As there is none in your flash you have installed just the IOS  image without the web console support.



喵了个咪，还有这种事儿？

找了几台旧交换机，重新这么一查，果然~

这个是以前的版本，果然有 `html` 目录。

图3



而现在这个新的则没有啊，怪不得呢~

图4



## 二、不进则退，光明在前方

好吧，按前辈们指明的方向前进吧！

来到思科官网，登录后一番查询找到了当前型号的镜像下载页面。

我手上的交换机型号是 `Catalyst 2960X-24TS-L` 的，如果你是其他型号，则需要按照相应型号找到相应镜像，否则搞错了后果很严重哦。

图5

图6



从图中可以看到，IOS镜像格式有两个，一个是 `bin` ，另一个是 `tar` 。

这两个镜像的发布日期等信息都是一样的，唯一不同的是，`tar` 格式的镜像是带有 `WEB BASED DEV MGR` 的。

这不正是我们要找的嘛！

先下载了再说~

镜像名称 `c2960x-universalk9-tar.152-7.E2.tar` ，大小40M左右，很快下完了，接下来就是怎么把它刷到交换机上的问题了。



## 三、欲善其工，必先利器

要想把 `tar` 镜像刷到交换机上，首先要想办法把镜像文件上传上去。

通常做法是通过 `TFTP` 来上传，只要搭建个 `TFTP` 服务环境即可。

我手头上使用的是 `manjaro` 系统，所以用以下命令安装 `tftp` 。

```shell
sudo pacman -S tftp-hpa
```

很简单地就搞定了，服务端和客户端全都有。

如果你用的是 `Windows` 系统，那么可以到网上找一个叫做 `tftpd32` 的程序，基本用法都差不多。

你说什么？找不到？还是你懒？那留言给我，我免费送你一个。



安装完成后， `tftp` 的默认根目录是 `/srv/tftp` 。

如果你想更改根目录，可以修改配置文件 `/etc/conf.d/tftpd` ，同时别忘记给目录修改相应的权限。

我们不搞那么复杂了，抓重点使用默认即可，直接开启服务。

```shell
systemctl start tftpd
```



在根目录中随便放上个文件，然后打个命令测试一下服务是否正常。

```shell
tftp 10.10.10.10 -m binary -c get filename.txt 
```

在当前目录上能下载到 `filename.txt` 文件即说明服务运行正常。



## 四、稳扎稳打，一步一个脚印

`tftp` 搞定了，接下来我们要操作交换机了。

假定交换机IP地址是 `10.10.10.1` ，而 `tftp` 服务端IP地址是 `10.10.10.2` 。



#### 1、登录到交换机的 `CLI` 终端控制台。

```shell
Cmd> telnet switch-ip-address
```

举个例子：

```shell
Cmd> telnet 10.10.10.1
```



#### 2、在交换机 `CLI` 下，测试 `tftp` 服务端是否连接正常。

```shell
Switch# ping tftp-server-address
```

举个例子：

```shell
Switch# ping 10.10.10.2
```

图7



#### 3、确认一切都OK后，开始上传更新IOS镜像。

```shell
Switch# archive download-sw /overwrite /reload tftp:[[//location]/directory]/image-name.tar
```

举个例子：

```shell
Switch# archive download-sw /overwrite /reload tftp://10.10.10.2/c2960x-universalk9-tar.152-7.E2.tar
```



命令部分参数说明：

> The **/overwrite** option overwrites the software image in flash memory with the downloaded one. 
>
> **/overwrite** *覆盖交换机flash中原有的镜像*
>
> 
>
> The **/reload** option reloads the system after downloading the image unless the configuration has been changed and not saved.
>
> **/reload** *在下载映像后重新加载系统，除非配置已更改且未保存*
>
> 
>
> The /**allow-feature-upgrade** option allows installation of an image with a different feature set (for example, upgrade from the IP base image to the IP services image).
>
> **/allow feature upgrade**  *允许安装具有不同功能集的镜像（例如，从IP基础镜像升级到IP服务镜像）*
>
> 
>
> For **//***location*, specify the IP address of the TFTP server.
>
> **/location** *指定TFTP服务器的IP地址*
>
> 
>
> For /*directory***/***image-name***.tar**, specify the directory (optional) and the image to download. Directory and image names are case sensitive
>
> **/directory/image-anme.tar** 指定要下载的目录（可选）和镜像，目录名和映像名区分大小写



另外请允许我插播一句废话，不知道小伙伴们有没有这样一种感觉，就是命令参数众多的情况下，还是希望能有实际的示例来作参考比较好理解一些。

如果直接给出一堆参数而没有示例，恐怕很容易让人抓狂，有同感的请举手！



好了，输入下载命令后，系统开始下载并自动刷新IOS了。

图8



更新中我们能看到有 `/html` 的字样。

图9



这里友情提示一下，更新很花时间，我这边粗略估计大概等待了半小时左右。

千万要有耐心，千万不要断电，中间可能会自动重启两次。

半个钟头适合做些什么呢？

我是发呆浪费了时间，不过你有什么好的建议可以留言分享给小伙伴们哦！

图10



## 五、终成正果

经过漫长的等待，终于控制台上显示系统启动完成了。

更新完成了吗？

我迫不及待地打开浏览器，原模原样地输入 `http://x.x.x.x` 回车。

输入登录的用户名和密码，哎，好像有特别不一样的反应了。

果然哈，和原来的白底黑字的页面不同，这次出现了比较现代样式的界面。

图11



左上角可以看到是刚才我们刷新的最新的IOS镜像版本。

控制面板中除了传统的端口状态外，还有CPU和内存利用率，以及系统温度显示。

很显然，这个WEB管理程序被重新定义和设计了。



WELL，不管怎么说，我们期待的WEB管理界面终于回归了。

作为资深小白，使用WEB管理是很稀松平常的事儿，各路大神莫要门缝看银啊！

本片谨献给和我一样的资深小白，希望能为小白轻松管理事业添砖加瓦、更上一层楼！

我的报告讲完了，谢谢大家！



本文相关下载：

**c2960x-universalk9-tar.152-7.E2.tar**

链接：https://o8.cn/6eysDY    密码：gf44



**tftpd32**

链接：https://o8.cn/rp9IQ3    密码：7km9



> WeChat @网管小贾 | www.sysadm.cc

