如何快速将 Microsoft Edge 稳定版安装到 Linux 上

副标题：Linux 的 Edge 稳定版来了，快上车~

英文：how-to-fastly-install-microsoft-edge-stable-build-in-linux

关键字：microsoft,edge,linux,ubuntu,rocky,centos,stable,稳定版



近日有一则好消息，微软放出了 `Linux` 平台上可用的 `Microsoft Edge` 稳定版。

这距离上次我给小伙伴们介绍的如何安装测试版 `Edge` 等内容正正好好过了一年的时间。

如今最新稳定版本已经是 `93.0.1020.40` 了，正好趁现在有些空闲，我准备重新再走一遍，分享一下现在这个稳定版本的安装过程。



> 参考前文：《Linux 版 Microsoft Edge 新鲜出炉啰，来尝尝味道如何~》
>
> 前文链接：https://www.sysadm.cc/index.php/xitongyunwei/778-how-to-install-microsoft-edge-dev-on-linux



与前文所述不同的是，本次我们采用最快速的方法来搞定 `Microsoft Edge` 的安装。

如果小伙伴们有更多的空闲，那么可以参考前文中的内容，通过事先逐步安装所需依赖组件，然后再安装 `.deb` 或 `.rpm` 包的方式来实现 `Edge` 的安装。

不过话说回来，实际上效果都是一样一样的，有更快的方法为什么不用呢？

因此我们还是着重介绍自动安装的方法，保质保量、快速有效！



### `Ubuntu` 下安装 `Microsoft Edge` 稳定版

本文以 `2004` 版本为例，只需要分别执行以下命令。

```
## 安装微软的签名密钥和 sources.lst
sudo wget https://packages.microsoft.com/keys/microsoft.asc
sudo gpg --dearmor microsoft.asc
sudo mv microsoft.asc.gpg microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-stable.list'

sudo rm microsoft.asc microsoft.gpg

## 开始安装 Micorsoft Edge Stable
sudo apt update
sudo apt install microsoft-edge-stable
```



需要友情提醒一下的是，此处安装微软签名证书的命令与前文略有不同。

究其原因是之前的命令经过测试会反馈为权限不足、拒绝访问而导致命令失败，至于为何失败也不得其解。

所以就此我做了一些修改，只要确保官网上下载的 `microsoft.asc` 能正确转换成二进制的 `microsoft.gpg` 即可。

图01



安装完成后，可在全部应用中找到 `Microsoft Edge` 。

启动它，查看帮助中的关于，可以看到是最新稳定版，没有 `Dev` 等测试字样了。

图02

图03



使用 `apt-get` 命令来安装方便、省心、快速，当然你也可以到官网上直接下载 `.deb` 包来安装。

具体安装方法以及如何解决依赖就不再赘述了，请小伙伴们自行练级。

下载链接：https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/

图04



### `Rocky Linux` 下安装 `Microsoft Edge` 稳定版

`Rocky Linux` 是在未来最有可能替代 `CentOS` 的一款优秀的 `Linux` 分行版。

它的作者就是出自 `CentOS` ，因此针对以下内容， `RedHat` 或 `CentOS` 或 `Fedora` 之类的同系列发行版本均可参考运用。



具体的方法，和 `Ubuntu` 大同小异、八九不离十哈，先设定好安装源，再以 `dnf` 安装之即可。

参考命令如下：

```
### 下载并导入 Microsoft 的 GPG 公钥
$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

### 添加程序安装源
$ sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge

### 修正安装源的文件名称
$ sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-stable.repo

### 开始安装
$ sudo dnf install microsoft-edge-stable
```



这里与参考前文内容没有什么大的变化，只需注意将命令中的 `dev` 字样切换成 `stable` 即可。

图05



同样在安装完成之后，我们来确认 `Edge` 的版本，的确为稳定版，版本号也与之前所述一致。

图06

图07



有心的小伙伴或许可能会注意到，其实在前面 `dnf` 自动安装时，也能窥见 `edge` 所需的依赖组件，挨个将其安装好后再来安装 `rpm` 包就万事大吉了。

下载链接：https://packages.microsoft.com/yumrepos/edge/

图08



### 写在最后

在顺利安装好 `Microsoft Edge` 后，我们就可以开启冲浪之旅了。

不过作为稳定版本，`Microsoft Edge` 还推出了一些新鲜有趣的功能，比如“儿童模式”。

这让我想起了我们国家最近出台的教育“双减”政策，还有大力推行的管控游戏措施等，不知道这个“儿童模式”是不是高级童锁功能，也不知道到底怎么用，管不管用。

当然，还有更多好玩、有趣而又奇妙的功能和用法，比如语音、翻译等等太多了，就等小伙伴们去积极探索大发现吧！

希望本文的分享能给小伙伴们有所帮助，祝你们食用愉快！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
