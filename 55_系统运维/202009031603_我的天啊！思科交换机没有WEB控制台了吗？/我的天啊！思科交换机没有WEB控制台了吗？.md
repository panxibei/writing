我的天啊！思科交换机没有WEB控制台了吗？

副标题：现在都讲究瘦身减肥了？



最近来了一批新交换机，准备调试后上线更换。

打开浏览器，输入 `http://x.x.x.x` 回车，出事了！

印象中的cisco经典web界面没有出现，却打开了个白白的几行英文的界面。

图1



网页加载不完全？

刷新，没变！

尝试 `https://x.x.x.x` 访问，还是老样子。

回到 `CLI` 控制台，发现命令没有问题，不论是 `http` 还是 `https` 都已经正常开启了。

我预感可能被搞事情了！

上网查吧！



一查不要紧，果不出所料，在N年前就有人被搞过了。

图2



论坛里给出的解释是，交换机中没有嵌入基于WEB的设备管理程序。

若要解决此问题，可以下载更新官方提供的镜像，这个镜像必须是还有 `tar` 后缀包含WEB管理器的文件。

> The story is the same for both Cat2960 and Cat2950: to support web based management you need to have embedded web based device manager. When  downloading the system image file from Cisco you need to choose combined tar file which includes both the IOS and web based device manager. The  simple indication whether you have downloaded (and extracted) the proper file is the presence (or absence) of "html" directory within your  flash. As there is none in your flash you have installed just the IOS  image without the web console support.



重新一查，果然~

这个是以前的版本，果然有 `html` 目录。

图3



而现在这个则没有啊，怪不得呢~

图4



好吧，按大神指明的方向前进吧！

来到思科官网，登录查询找到了当前型号的镜像下载页面。

我手上的交换机型号是 `Catalyst 2960X-24TS-L` 的，如果你是其他型号，则需要按照相应型号找到相应镜像。

图5

图6



从图中可以看到，IOS镜像有两个，一个是 `bin` ，另一个是 `tar` 。

这两个镜像的发布日期等信息都是一样的，唯一不同的是，`tar` 格式的镜像是带有 `WEB BASED DEV MGR` 的。

这不正是我们要找的嘛！

先下载了再说~

镜像大小40M左右，很快下完了，接下来就是把它刷到交换机上的问题了。



## 二、使用 `TFTP` 把 `tar` 镜像更新到交换机上

