UrBackup 客户端安装到 Windows 7 的正确姿势

副标题：UrBackup 客户端安装到 Windows 7 的正确姿势

英文：the-correct-way-to-install-urbackup-client-to-windows-7

关键字：urbackup,client,windows,7



“什么？现在都 `Windows 11` 时代了，你还在用 `Windows 7` ？”

我坚信至今仍有不少小伙伴还在坚持使用 `Windows 7` 系统，倒不一定说是它稳定、耐用啥的，其实也可能有着不吐不快的难言之隐......



是的，难言之隐有很多，然而坚持使用 `Windows 7` 在有的情况下的确是无奈之举。

比如，有些业务系统必须跑在 `Windows 7` 上面，迁移业务系统不是不行，只是相对而言要么成本巨大，要么将面临业务停摆等不可抗风险。

就像法国某航空公司，到现在还在用 `Windows 2000` 一样，只要好用就行，不在于你用啥系统，而在于你适合用啥系统。

当然了，我们今天并不是来讨论用哪个系统更好，而是针对已经被官方淘汰的 `Windows 7` 系统，看看它到底能不能、还有怎么安装新版 `UrBackup` 的问题。

毕竟即使是在 `Windows 7` 上跑的业务系统，它也是需要备份的嘛！



记得以前在写 `UrBackup` 教程的时候，我曾经使用的是 `2.4.x` 版本（当前最新版本 `2.5.x` ）的程序，那时是完全支持 `Windows 7` 的！

只可惜 `UrBackup` 也变得与时俱进，在新版本中逐渐放弃了对 `Windows 7` 的支持。

这是趋势，不可阻挡，不过仍然有部分小伙伴还在用着 `Windows 7` 呢，还好 `UrBackup` 是免费开源软件，方便查询测试，因此我专门测试了几个版本，最终精准定位了最后可支持 `Windows 7` 的 `UrBackup` 客户端版本。



经过确认， `UrBackup` 客户端 `UrBackup Client 2.5.20` 可以安装到 `Windows 7` 上，`UrBackup Client 2.5.21` 及以上版本就不再支持 `Windows 7` 了。

小伙伴们可以去官网下载 `2.5.20` 这个版本，当然我在文末也放上了备用下载链接，一会儿你们就可以下载啦！

本着对大家负责的态度，接下来我把测试过程分享出来，供大家参考。



你们看哈，如果安装了较高的版本，安装程序会给出警告提示。

图01



前面我们说过， `2.5.20` 是支持安装到 `Windows 7` 的最新客户端版本。

但是安装过程中可能会由于某些原因导致无法成功启动 `UrBackupClientBackend` 服务，从而出现如下错误。

```
Service 'UrBackup Client Service for Backups' (UrBackupClientBackend) failed to start.
Verify that you have sufficient privileges to start system services.
```

图02



这提示啥意思呢？

翻译成大白话就是，`UrBackupClientBackend` 这个服务启动失败了，让我们确认是否有权限启动它。

这不扯的嘛！

我就是管理员权限啊，怎么会没有权限启动服务呢，难道这个 `UrBackupClientBackend` 比较牛连管理员都不放在眼里？

另外根据 `UrBackup` 备份原理来讲，客户端全靠这个服务，它是根本中的根本，无法启动的话安装程序就会自动退出，最后以安装失败告终。



挺奇怪的问题，之前也没遇到过，现在正好明确一下。

最后找到官方论坛链接：

```
https://forums.urbackup.org/t/cbt-client-2-2-12/6191
```

图03



斑竹反问提问者是否安装了 `UrBackup` 所需的更新。

啥更新，我怎么没听说过呢？

更新说的就是这个，看下面这个链接：

```
https://support.microsoft.com/en-us/help/2999226/update-for-universal-c-runtime-in-windows
```

图04



说穿了 `UrBackup` 就是靠 `Windows` 里的一些 `Runtime` 才能跑起来的，这也是 `Windows` 的一大特色。

这就明白了，也别整那么多废话了，安装所需更新就完事了呗！



遂找到更新 `KB2999226` 的下载链接：

```
https://www.microsoft.com/zh-cn/download/details.aspx?id=49093
```

图05



还等啥，下载完后安装更新补丁。

图06

图07



安装飞快，保险起见再次确认 `KB2999226` 是否安装成功。

图08



当然了，如果你的系统里以前安装过这个更新，那么多半 `UrBackup Client` 应该是会安装成功的。

比如你安装的是俄罗斯大神出品的带有全部更新的 `Windows 7 UpdateR2` 这种的，我之前的文章有写过，现在也在不定期地更新，建议小伙伴们安装这个 `Windows 7` 系统，省时省力不闹心。



好了，回到正题，再次安装 `UrBackup` 客户端，服务成功启动了！

图09



附上支持 `Windows 7` 最新版的 `UrBackup` 客户端安装程序。

**UrBackup Client 2.5.20多平台版本(含 `KB2999226` 更新补丁)**

下载链接：https://pan.baidu.com/s/1hctfI9YIMy4uDnDM7y1bSA

提取码：viy1



最后用几句话作为结尾。

作为当前仍是生产力一部分的 `Windows 7` 系统来说，的确是微软历史上除 `XP` 以外最稳定最OK的系统之一。

它甚至有不少拥趸不惜将 `Windows 10/11` 降级成 `Windows 7` 来使用，也足见这套系统的优秀。

因此在 `Windows 7` 上跑业务系统并不是什么不好、落伍的事情，而重要的是，我们更应该重视系统的备份工作。

最后希望本文能够给还在使用 `Windows 7` 系统的小伙伴们带来一点帮助。

祝大家使用 `UrBackup` 一切顺利！



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc