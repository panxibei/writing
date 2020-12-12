没有 CentOS 的日子里我们怎么过活？

副标题：把有限的生命投入到无限的白嫖中去~





近日传闻 CentOS 将死，不信吧，我也不信，今年假新闻太多！

可是非常遗憾啊，这传闻它喵是真的！

CentOS 官方近期发布消息，称将在明年（2021年）逐步把开发工作重心从 CentOS Linux 往 CentOS Stream 转移。

官方进一步说，CentOS Stream 才是未来，什么 CentOS 7 或 8 都将被 CentOS Stream 取而代之。

什么意思，他在说啥呢？

简单地讲，就是以后没有 CentOS 7 或 8 了，CentOS 8 都将在2021年年底（原定2029年）提前结束维护。

而针对 CentOS 7 ，官方考虑到其用户基数较多，暂时按照原计划维护到2024年6月30日，也就是说你还可以使用它不到4年的时间。

图1



此时有的小伙伴儿们肯定会有些失落，发出“怎么会这样”的感叹吧。

实际上我们应当先搞清楚，这个 CentOS Stream 它到底是个什么东西。

以我浅薄的阅读和理解力对其研究一番，大概得出这么个结论。

* 原先的模式：Fedora > RHEL > CentOS
* 将来的模式：Fedora > CentOS Stream/RHEL



你可以将 `Fedora` 理解为测试版，`RHEL` 为正式版，`CentOS` 则为稳定版。

那么原先的模式就是先在 `Fedora` 上测试，然后测试OK则成为 `RHEL` ，最后再到 `CentOS` 。

可以说 `CentOS` 是最稳定可靠的，只是它有一个缺点，也是很多人对它不太看好的地方。

就是它虽然稳定，但它的更新来源于 `RHEL` 却需要很长时间来完成更新，这个过程通常要数天甚至20多天。

不过对于一般用户来说，这也不算太大的问题，只要它稳定就行。

可是，现在不一样了，稳定的 `CentOS` 没有了！

取而代之的是 `CentOS Stream` 这个后来者，而它一反常态，跑到了 `RHEL` 的前面去了，也就是成为测试版。

只有 `CentOS Stream` 测试OK了，才会更新到 `RHEL` 上。

这回明白了吧，官方的小心思显露无疑啊！

以往很多人认为的至理名言“CentOS就是免费版的红帽”，也就随之烟消云散了。



广大群众不禁要问：那就真的走投无路了吗？

有的小伙伴儿立马举起了小手，用 `Ubuntu` 啊！

是的，估计 `CentOS` 没了的消息一出，可以预见会有大量的用户从 `CentOS` 迁移到 `Ubuntu` 的壮举。

`Ubuntu` 也是一款免费开源的 Linux 系统，做服务器或桌面系统都非常棒，的确是个好选择。

不过嘛，在这里我们先不说它，而是说一说有没有其他类似或者说更接近 `CentOS` 的替代系统。

有吗？

还真有！

它就是 `Oracle Linux` ！



Oracle Linux 官网：https://linux.oracle.com/switch/centos/

图2



这是官网介绍，你看它的标题，号称“最佳CentOS替换方案”。

说实话，我以前听说过它，可也没怎么去深入了解，现在好了，终于有充分的理由去了解了。

有兴趣的小伙伴儿们可以去了解一下。

而我在这里，就大家伙比较关心的问题点，简单地总结一下它与CentOS的异同以及它的特点。



1、Oracle Linux 它不要钱，这个和 CentOS 一样，免费用。



2、它其实也是个 RHEL 的翻版，所以100%兼容原来 CentOS 的程序，这下放心了吧。



3、它比 CentOS 好，因为它更新更快更稳定，你看下图，更新很及时啊。

图3



4、如果你觉得它好用，而且想购买支持，那么找 Oracle ，它们声称比红帽便宜。



基本上看完前三条，有的小伙伴儿就坐不住了，这么好那实际运用有没有啥问题呢？

嗯，我也是你们中的一员我也关心啊，所以我亲自到官网上下载了一个亲自安装尝试了一下。

官网下载需要注册帐号，如果你想直接下载，我这放了个备用下载链接。

Oracle Linux 7.9

百度链接









#### 尝试安装 `Oracle Linux` 

新建虚拟机，加载安装镜像到光驱，启动进入安装界面，一切都如往常那样操作。

安装界面正常加载完毕，可以看到除了左上角的标志不同，其他感觉和 `CentOS` 差不多。

这个左上角的标志，是 Linux 企鹅穿着 Oracle 的小马甲，与其在官方网页上的介绍一样，它也是个 RHEL 的翻版，这个标志倒是挺形象的哈。

图4

图5



你要是安装过 CentOS ，那么对你来说整个安装过程应该是毫无违和感，不看那个标志，肯定还以为在安装 `CentOS` 。



安装完成后，很显然启动菜单项上的单词与 `CentOS` 不同。

直到启动完成出现登录提示，发现两者的内核版本完全不一样。

CentOS的内核版本为了保持所谓的稳定还是用着旧版的，而 Oracle Linux 就比较新。

* Oracle Linux Server 7.9 （内核 5.4.17）
* CentOS 7.9 （内核 3.10.0）

图6

图7



另外，官方介绍说与 CentOS 的另一个不同之处是，Oracle 使用的是官方自己 `yum` 仓库，我看看。

查看 `yum` 仓库，果然是 `oracle-linux` 的仓库。

```shell
[root@localhost yum.repos.d]# ls
oracle-linux-ol7.repo  uek-ol7.repo  virt-ol7.repo
```



至于其他方面，毕竟还没有正式使用它，所以我也没有更深入的确认还有没有其他不一样的地方，反正打了几条命令，结果和使用方法都和原来的 CentOS 没有啥区别。



这就欧了吗？直接开用就得了呗？

嘿嘿，别着急，还有一项没有介绍，那就是官网提供的**在线切换脚本**。

`Oracle Linux` 既然号称最佳替换方案，那么能否让用户快速切换就成了重中之重了，否则不好切换也可能会让人失去尝试使用的兴趣。

项目：https://github.com/oracle/centos2ol

脚本：https://github.com/oracle/centos2ol/blob/main/centos2ol.sh



使用方法很简单：

1. 登录到 `CentOS` 6, 7 或 8 ，确保有管理员 `sudo` 权限。
2. 克隆本项目或直接下载 [`centos2ol.sh`](https://github.com/oracle/centos2ol/blob/main/centos2ol.sh) 脚本。
3. 执行 `sudo bash centos2ol.sh` 即可从 `CentOS` 切换到 `Oracle Linux`。



按以下命令执行即可。

```shell
yum -y install wget unzip
wget https://github.com/oracle/centos2ol/archive/main.zip
unzip main.zip
cd centos2ol
chmod +x ./centos2ol.sh
sudo ./centos2ol.sh
```



如果你没有安装或不想安装 `Git` ，那么使用脚本就行了。

下载脚本不方便的话，可以下载我给你们准备好的备份链接。

在线切换脚本备份下载：

下载下来是个 `zip` 压缩包，按前面的命令解压、赋予执行权限，再执行脚本就OK啦！



整个切换过程大概在几十分钟不等，猜测主要是修改源仓库以及下载一些更新吧。

反正全自动更新，耐心等待就是了。

此外你也能看到，不管是CentOS 6、7还是8，都是可以切换的。

如果切换失败也不用担心，它会保持系统原来的样子。







Oracle Linux 7.9 下载：



WeChat@网管小贾 | www.sysadm.cc



