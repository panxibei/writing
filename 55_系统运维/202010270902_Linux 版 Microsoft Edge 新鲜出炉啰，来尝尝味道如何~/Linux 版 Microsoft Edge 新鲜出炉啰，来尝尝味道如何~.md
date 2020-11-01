Linux 版 Microsoft Edge 新鲜出炉啰，来尝尝味道如何~

副标题：终于还是来了，等的就是你~



在之前的文章中我们曾经给小伙伴们介绍过新版 `Edge` 浏览器完整版的安装方法。

不知道小伙伴们使用下来感觉如何啊？

说实话，我的体验是，这个由微软出品的新版 `Edge` 浏览器还真的挺好用。

不过稍有遗憾的是，它只支持 `Windows` 和 `MacOS` 两大平台，甚至后续连 `IOS` 和 `Android` 都支持了，可就是没有 `Linux` 的。

对 `Linux` 有意见？

不可能嘛，说好了要拥抱 `Linux` 的，微软爸爸的话可不会乱说的。

这不最近传来了好消息，`Linux` 平台版本的 `Edge` 浏览器终于发布了。

虽然姗姗来迟，但该来的还是来了不是，今天就让我们一起来尝尝鲜吧！

> 前文参考：[新版 Microsoft Edge 完整版下载的正确姿势](https://www.sysadm.cc/index.php/xitongyunwei/759-microsoft-edge-offline-version-download)



秉承着我们一贯的5W2H大法，在哪里、怎么做，先给出下载链接。

> 官方下载链接：https://www.microsoftedgeinsider.com/zh-cn/download

**嫌官网下载慢？这儿有快速备份下载给你留好了。**

> microsoft-edge-dev_88.0.680.1-1_amd64.deb
>
> https://www.90pan.com/b2145697    密码：0157
>
> microsoft-edge-dev-88.0.680.1-1.x86_64.rpm
>
> https://www.90pan.com/b2145694    密码：9x3h



打开官方链接后，我们能看到有三个不同的渠道。

三个大小伙儿都长得挺帅的，可姑娘只嫁一个意中人，该怎么选呢？

图1



来来，我替你做主了，选中间那个 `Dev` 渠道！

为啥子，看出这小伙儿家里有矿？

嘿嘿，其实原因超简单啦（我耸了耸肩），因为旁边两个渠道它们根本就木有适用Linux版本的安装程序下载啊！

不信你点击下拉菜单看看，只能选中间的啦。

图2



瞧见没，最后那两个安装包就是提供给Linux用户的，一个是 `.deb` 和 一个是 `.rpm` ，分别对应 `Debian/Ubuntu` 和 `Fedora/openSUSE` 。

主流 `Linux` 系统都支持上了，不过我手上只有 `CentOS8` 的系统，先拿它作小白鼠实验一下吧。

`CentOS` 可以对应 `Fedora` ，所以点击 `.rpm` 包一项下载，弹出许可协议，点击同意后开始下载。

图3

图4



下载很顺利，当然你也可以在 `Linux` 系统中下载它。

对于玩 `Linux` 的小伙伴们来说，不需要像 `Windows` 用户那样，事先还要通过 `IE` 来下载其他浏览器的安装包。

`IE` 浏览器沦落成其他浏览器的下载工具也是长久以来被公认的嘲笑梗。

可是实际上 `Linux` 系统并没有 `IE` 浏览器啊，想在 `Linux` 上安装并使用 `IE` 浏览器是非常疯狂的想法。

还好没有 `IE` 并不需要担心哦，`Linux` 有很多很多方法可以下载网上的东西，浏览器并不是下载必需品哦。

好了，啰嗦完了也下载好了，我们用刚才下载好的 `rpm` 包来安装 `Edge` 试试，完成之后再介绍更简便的安装方法。



### 使用RPM包方式安装 `Edge` 浏览器

**1、直接上手尝试安装**

```
# rpm -ivh microsoft-edge-dev-88.0.673.0-1.x86_64.rpm
```

图5



我眉头一紧，安装失败，缺少依赖程序？

这是...又要搞我了？

我可是 `Linux` 优秀小白玩家，先解决一下依赖程序吧。



**2、`yum` 大法安装依赖程序包**

```
# yum install libatomic
```

图6



```
# yum install liberation-fonts
```

图7



```
# yum install libvulkan
```

图8



出错了，并没有这个名字的依赖程序，其实它应该是这个样子。

```
# yum install vulkan
```

图9



**3、再来安装 `rpm` 包**

图10



这一次可以正常安装了，终于成功完成！

哎，怎么桌面上没有图标啊，哦哦，我还以为是 `Windows` 呢，嘿嘿！

好吧，打开左边栏的 `显示应用程序` ，果然 `Microsoft Edge Dev` 好端端地躺在里面，不要犹豫猛击它吧！

图11

图12



### 使用 `dnf` 全自动安装 `Edge`

对于 `Linux` 用户来说，直接安装 `.deb` 或 `.rpm` 包显得不那么潇洒专业。

你都玩 `Linux` 了，专业一点还是来个在线下载全自动安装吧。

你说得容易，要到哪里下载，又如何安装呢？

答案是，到微软的 `Linux` 软件仓库下载，用 `dnf` 来自动安装。

我们来看看实际的操作吧。



前面都用 `yum` 来解决依赖程序问题，可不可以用 `yum` 直接安装 `Edge` 呢？

我没有试过，但我想应该是可以的，不过还是推荐用 `dnf` 。

首先，先友情提示一下，如果你用的是 `CentOS7` ，那么它默认是没有安装 `dnf` 的，所以需要先安装 `dnf` 。

```shell
# yum install epel-release
# yum install dnf
```



我们现在演示用的是 `CentOS8` ，哈哈，感谢上帝它默认已经包含 `dnf` 了。

我们可以直接开始了！



整个过程分为两大步骤，共四条命令，就像下面这个样子。

```shell
### 下载并导入 Microsoft 的 GPG 公钥
$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

### 添加程序安装源
$ sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge

### 修正安装源的文件名称
$ sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-dev.repo

### 开始安装
$ sudo dnf install microsoft-edge-dev
```



很简单，我测试过没问题，小伙伴们照抄就行了。

以下是安装时的部分截图，新手小白建议收藏。



开始安装 `Microsoft Edge Dev` ，输入 `y` 继续安装。

图13



提示验证公钥是否OK，大胆按下 `y` 后回车。

图14



开始下载安装了，看你的网速，等待一定的时间后安装结束，可以看到我安装的 `Microsoft Edge Dev` 版本是 `88.0.673.0-1` 。

图15



安装好了，让我们打开看看吧。

打开左边栏的 `显示应用程序` ，双击 `Microsoft Edge Dev` 。

图16



依次找到 `Settings` > `About Microsoft Edge` ，可查看关于信息。

似乎没有看到哪里写着版本信息啊，不过毕竟是刚出来的版本，可能将来更新完善后会有。

根据相关报道，继停止对 `IE` 的支持之后，微软又将于明年（2021年）停止对旧版 `Edge` 的支持，转而全面支持新版 `Edge` 浏览器，并积极推荐用户使用。

> 小知识：旧版 `Edge` 被称为 `Legacy Edge` ，而新版 `Edge` 被称为 `Chromium Edge` 。



至于 `Ubuntu` 下安装 `Edge` 可以参考以下方法，不过我还没有测试过，小伙伴们有兴趣可以安装试试哦。

> **Debian/Ubuntu** 下安装 **Edge** 的参考命令：
>
> ```
> ## 安装微软的签名密钥和 sources.lst
> curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
> sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
> sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
> sudo rm microsoft.gpg
> 
> ## 开始安装 Micorsoft Edge Dev
> sudo apt update
> sudo apt install microsoft-edge-dev
> ```



好了，小伙伴们接下来应该做什么了？

还等什么，当然是使用新版 `Edge` 浏览器乘风破浪啦！

如果小伙伴们在安装和使用 `Edge` 过程中有什么感受和想法，欢迎留言讨论哦！

我们下期再见！



> 前文参考：
>
> [新版 Microsoft Edge 完整版下载的正确姿势](https://www.sysadm.cc/index.php/xitongyunwei/759-microsoft-edge-offline-version-download)











> WeChat @网管小贾 | www.sysadm.cc

