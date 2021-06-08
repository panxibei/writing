Rocky Linux，一款最有希望替代 CentOS 的 Linux 发行版

副标题：近期正式版将重磅发布，赶快试用一下吧！

英文：rocky-linux-a-linux-distribution-most-likely-to-replace-centos

关键字：linux,centos,redhat,rocky,distribution,rc,ga,beta



正如小伙伴们都知道的，去年红帽官方就正式宣布，`CentOS` 将变成 `RedHat` 的前置测试版本，还重新给起了个名字叫 `CentOS Stream` 。

消息一出，舆论哗然，乡亲们纷纷奔走相告，一时间激起千层浪。

不曾想更狠的是，原本说好了 `CentOS 8` 可以支持到 2029 年 5 月，结果官方又背后给捅上一刀，搞成了今年（2021年）年底就终止全部支持。

浪里个浪，这猴急样，可搞笑的是，却又说什么基于考虑到所谓大量用户的实际需求，`CentOS 7` 将于 2024 年 6 月 30 日 终止。

好嘛，掰掰手指头，`CentOS 7` 剩下还有个差不多 3 年左右的时间，嘿嘿，3 年以后也是要拜拜的啊！

这意味着各位白嫖的稳定版 `CentOS` 都会在不久的将来与我们彻底再见！

这还了得，广大P友人心惶惶、跳脚怒骂道，这接下来还怎么玩？！



其实也不用太过担心，俗话说得好，天塌了有个儿高的顶着。

互联网上大神云集，海了去了，这不在 `CentOS` 创始人 Gregory Kurtzer 的带领下，我们又迎来了一个崭新的社区。

没错，大神们给我们带来一个惊喜，全新项目 `Rocky Linux` 。

这个新项目正是为完美接替 `CentOS` 而生！

> 官方链接：https://rockylinux.org/



社区创建时间不久，在最初建立时，还只是停留在研讨阶段，不过最近好消息频传，社区已经放出了多个测试版本。

只怨我不怎么逛社区，记得上一个星期版本还是 `8.3` ，现在最新版本已经出到了 `8.4` 。

于是我又抽空下载安装了一下，小伙伴们一起来瞧瞧哈！



### 下载

我们首先来到 `Rocky Linux` 的下载页面。

官方放出了两种平台的镜像下载，分别是 `x86_64` 和 `ARM64` 。

通常我们应该选择 `x86_64` ，如果你有 `ARM` 平台系统，那么你应该选择 `ARM64` 。

图1



按照以往的习惯，我一直是使用 `Minimal` 版本，因为小巧同时也不需要安装那么多包。

不过 `Rocky Linux` 此处的 `Minimal` 版本的镜像大小是 1.8 GB，而 `DVD` 版本镜像大小是 9.3 GB。

我的天呐，都这么庞大吗？！

好像 `CentOS 8` 都不给 `Minimal` 了。

好吧，就选 `Minimal` 吧，没有更小的了不是吗？



### 安装

和 `CentOS` 的安装几乎没什么两样，类似的界面，类似的步骤。

从镜像光盘启动，选择 `Install Rocky Linux 8` 。

图2



默认语言选择英文，如果你想要安装桌面应用，也可以考虑用中文。

图3



各类安装选项界面，它将 `root` 用户及普通用户的密码设置都统一放在这里了。

图4



设置好各选项后开始安装，直至整个过程结束。

图5

图6



我之前刚刚安装过 `8.3` ，和这次不同的是， `8.3` 明显是测试版本。

你瞧，安装一开始就告诉你这是非稳定版本。

图7



安装过程中也提示这是测试版。

图8



等安装完成后启动，系统也很显眼地提示，这是测试版不要用于生产环境。

图9



怎么感觉现在安装的 `8.4` 版本已经没有了这些警告和提示信息了呢？

难道这个是正式稳定版了？

哈哈，没想到还真是的！

我找到了 `Rocky Linux` 中文社区的更新文章，上面有提到计划正式版本的发布。

当然了，现在手上的这个版本应该还是 `RC` 版的。

图10



### 启动

熟悉的味道，熟悉的配方，开机启动项的内核版本是 `4.18` ，代号 `Green Obsidian` 。

图11



启动完毕并登录，嘿，居然没有提示是测试版，这也验证了这一版本应该有可能将成为正式版。

说实话，有点小激动啊！

以后可以尝试将一些系统迁移到 `Rocky Linux` 上了。

图12



### 切换更新源

目前为止国内已经有很多大学提供 `Rocky Linux`  国内更新源了。

> 官方镜像链接：https://mirror.rockylinux.org/mirrormanager/mirrors



我们单独拿上海交大的更新源举例。

> 上海交大链接更新源：https://mirrors.sjtug.sjtu.edu.cn/docs/rocky

```
# 切换为上海交通大学的更新源
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.sjtug.sjtu.edu.cn/rocky|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-*.repo

# 生成缓存
dnf makecache
```

图13



如要恢复官方默认源，可以这样。

```
# 恢复默认源
sed -e 's|^#mirrorlist=|mirrorlist=|g' \
    -e 's|^baseurl=https://mirrors.sjtug.sjtu.edu.cn/rocky|#baseurl=http://dl.rockylinux.org/$contentdir|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-*.repo

# 生成缓存
dnf makecache
```



### 与 CentOS 有啥不一样

网上有网友说，`Rocky Linux` 的网络服务名称变了，以前还有 `network` 字样的命令已经不能用了。

`network` 应该是 `CentOS 7` 时代的，`CentOS 8` 应该用 `NetworkManager` 。

```
# 这样用已经不行了
systemctl status network
```

图14



针对 `Rocky Linux` ，取而代之的应该用 `NetworkManager` ，比如：

```
# 用 NetworkManager 就可以
systemctl status NetworkManager
```

图15



由于我还没有实际运用 `Rocky Linux` ，上手的时间也不长，所以还没有发现有什么大的不同之处。

我猜想短期之内应该和 `CentOS 8` 基本相同吧，但时间久了可能会有变化。

至于是不是还有其他不同，有待日后真正地去运用它才能了解，我会注意比较、收集和整理，到时候分享给小伙伴们。



### 写在最后

`Rocky Linux` 中文社区发布了最新信息（2021年6月7日），宣称 `Rocky Linux 8.4` 将是第一个 `GA` 版本，也就是可以正式用于生产环境的版本。

对于这个好消息，我想小伙伴们一定会是非常激动、非常兴奋的，总算又可以继续白嫖了哈。

之前我还写过文章，在 `Rocky Linux` 出现之前曾经推荐过 `Oracle Linux` ，但反响不佳，似乎大家都对 `OL` 的浓厚商业气息嗤之以鼻，即便它是免费使用的。

现在好了，`Rocky Linux` 横空出世，我们有救了！

那些个躺平的都给我起来，准备躺平的也别躺了，赶紧熟悉和学习起来哈！

让我们一起期待 `Rocky Linux` 的正式版发布吧，希望它的未来越来越棒！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
