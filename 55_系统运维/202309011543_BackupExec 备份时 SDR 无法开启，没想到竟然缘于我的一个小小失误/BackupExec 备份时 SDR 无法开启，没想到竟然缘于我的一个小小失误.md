BackupExec 备份时 SDR 无法开启，没想到竟然缘于我的一个小小失误

副标题：BackupExec 备份时 SDR 无法开启，没想到竟然缘于我的一个小小失误

英文：backupexec-simplified-disaster-recovery-can-not-be-enabled-unexpectedly-it-was-due-to-a-small-mistake-on-my-part

关键字：veritas,backup exec,be,ssr,sdr,recovery,备份,simplified,disaster,recovery



我常年和电脑打交道，所从事的工作就是围着电脑转，俗称网管。

老板看我工作不够饱满，出于“好心”一口气分配给我三台电脑，希望我努力工作，再创佳绩，年底多买台车。

我自然不会辜负老板的殷殷期望，抚摸着每一台电脑，暗暗发誓定会让它们物尽其用，发挥它们的最大潜能。

在接下来的日子里，在我热情饱满地工作之余，却遇到了一些令人费解的事情。



`Veritas` 公司的备份软件 `Backup Exec` ，想必对于从事系统管理和运维的小伙伴们来说应该多多少少用过或听说过吧。

没错，`Backup Exec` 是 `Windows` 平台下非常有名的常用备份软件之一，以可靠、易用，就是有点慢而闻名。

我用的电脑多，数据自然也不少，于是备份就成了我每天必须做的工作之一。

就在前一阵我因此碰到个糟心事，就和这个 `Backup Exec` 有关……



事情是这样的，这个 `Backup Exec` （字太长懒得敲，以下简称 `BE` ）呢它有一个很好很强大的功能叫作系统灾难恢复。

这个系统灾难恢复英文叫作 `Simplified Disaster Recovery` ，简称 `SDR` ，顾名思义可以在系统故障无法启动的时候，我们就可以用它来快速有效地恢复备份。

它的好处就是你完全不用担心整个系统被破坏或故障，它会还你一个完完整整、有胳膊有腿，原来是啥样就是啥样的系统。



具体的做法是，我们先做个开启 `SDR` 功能的备份，然后再用 `BE` 向导程序制作一个 `SDR` 启动盘，类似于 `PE` 环境的 `U` 盘或是 `ISO` 光盘。

当故障发生时，我们使用这个 `U` 盘或光盘先启动到 `PE` 环境，然后再连接（也可以是通过网络）到备份设备，这样就可以完美恢复备份啦！

图01



初闻之，惊世骇俗，这种解决方案不能说不完美，这种功能不能说不强大！

可是这玩意却有个小小的让人膈应的地方，想要得到包含指定目标备份的 `SDR` 启动盘，则必须先要成功制作出指定目标并且带有 `SDR` 的备份才行。

换句大白话讲，就是我得开启 `SDR` 把备份先做出来，然后才能得到指向这个备份的 `SDR` 启动盘。

图02



比如，我想备份目标服务器 `ServerA`  ，包括它的 `C` 盘啥的。

在备份前，你要开启 `SDR` ，然后再完成备份工作。

接着，用 `BE` 向导制作 `SDR` 启动盘，这时你会发现启动盘里有前面备份的 `ServerA` 。

如果前面 `ServerA` 备份时没带上 `SDR` ，那么启动盘制作时你是看不到 `ServerA` 的，自然用这样的启动盘引导后也是恢复不了 `ServerA` 上的数据的。

因为启动盘引导后，里面压根就不显示之前 `ServerA` 的备份信息，恢复数据也就无从谈起了！

图03



啰嗦了这么多，有小伙伴会问，我到底碰到个啥问题呢？

如图所示，当我选择备份项时，如果排除除 `C` 盘以外的任意盘符、文件夹或文件，这时 `SDR` 就会自动关闭成无效状态。

图04



我再说得直白一点，只要不是全选（所有盘符）备份项，`SDR` 项就会失效（未选中状态）。

然而事实是，只要备份 `C` 盘、 `EFI` 系统分区以及系统状态，默认 `SDR` 就应该是有效开启的。

在 `SDR` 有效的情况下，我们就可以制作灾难恢复盘。

但是吧，就像我前面所说，现在 `SDR` 不让你开启了，我总不能连 `D` 盘一块儿备份吧。

如果 `D` 盘数据量小，那我就忍了，但是动辄几个 `T` 的数据，也不方便啊！

简言之，我只想备份 `C` 盘，不备份 `D` 盘，同时要有 `SDR` 的恢复功能。

现在搞不定了，你说咋办？

于是上网找答案吧！



扒了半天，官网上还真提到了相关的问题。

官方支持文档一：

> How to enable Simplified Disaster Recovery backup when some files and/or folders on critical volumes are excluded
>
> https://origin-www.veritas.com/support/en_US/article.100013796



```
HKEY_LOCAL_MACHINE\SOFTWARE\Veritas\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:
```

图05

图06



官方支持文档二：

> 重要なボリューム上の一部のファイルやフォルダが除外されている場合に、Simplified Disaster Recovery (SDR) を有効にする方法
>
> https://origin-www.veritas.com/support/en_US/article.100049483

 

```
<Backup Exec 21 以前>
HKEY_LOCAL_MACHINE\SOFTWARE\Symantec\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:

<Backup Exec 21 以降>
HKEY_LOCAL_MACHINE\SOFTWARE\Veritas\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:
```

图07

图08



这么现成的嘛，依葫芦画瓢照做就是了！

结果费了半天劲，居然还是不行！

不是吧，这可是官网上的文档啊，还能有错？

可以这么说，我把官网的这些文章一个字一个字地仔仔细细地研究了个遍，也没看出来还有其他特殊设置的地方。

就这么多了，英文日文都看了个遍，没啥特别的，事情一度陷入僵局。



随后我就在思考人生了，究竟是啥玩意能让这个 `SDR` 开启呢？

或许这才是解开谜题的关键。

于是我耐着性子接着翻文档，结果找到这么一段内容。

原来 `SDR` 开启是要看有没有所谓的“关键系统组件”的，只有关键系统组件被选中才能开启 `SDR` 。

那么什么是关键系统组件呢？



官方关于备份关键系统组件的描述：

> https://www.veritas.com/content/support/en_US/doc/59226269-99535599-0/v60036296-99535599



以下系统资源被视为关键资源，如果您希望能够使用备份集执行完整系统还原，则必须将它们包含在备份中：

- 系统卷（包括 `EFI` 和实用程序分区）
- 启动卷（不包括操作系统）
- 服务应用程序卷（引导、系统和自动启动）
- 系统状态设备和卷（包括活动目录、系统文件等）
- 任何适用版本的 `Windows` 上的 `Windows Recovery Partition` （ `WinRE` ）



哦，我大概明白了！

`EFI` 肯定是关键系统组件，因为系统启动时要用到的嘛，不过还有这么多东西也是关键的啊，恕我孤陋寡闻了！

难道说，那个 `D` 盘里有什么关键组件存在吗？

就是因为没选中它，`SDR` 才失效的？

可我转念又一想，不可能啊，这个 `D` 盘就是一普通分区，既没有 `EFI` 也不是引导盘哪来的关键组件呢？

我头上顶着个大大的问号，开始研究起这个 `D` 盘到底有什么鬼……



结果不看不知道，一看还真把我老人家给吓了一大跳！

原来啊，这个 `D` 盘居然是个独立的物理硬盘，并不是简单的逻辑分区。

光用 `Windows` 系统中磁盘管理程序，居然看不出它的最前面有那么一个小得不能再小的保留分区。

我是用 `SDR` 盘启动时发现的，启动后，查看高级磁盘配置。

图09



可以看到当前磁盘的布局， 第二块硬盘前头的 `Mircosoft` 系统保留分区赫然在目！

图10



常年打雁，今儿个让雁给啄了眼。

为啥会犯这个错呢？

原因就是我用的 `Windows` 的磁盘管理程序看它，完全就是一块儿老老实实呆在那儿的 `D` 盘。

其实只要用其他第三方的磁盘管理程序都能发现这里的猫腻。

到此总算给整明白了！



最后只要把这个保留分区删除（注意备份数据），再回过头来测试，即便不选择 `D` 盘，`SDR` 也可以正常开启了！

图我忘记截了，骚瑞，总之和前面修改注册表后的效果是一样一样的。

小伙伴们，你们遇到过类似的情况吗？

希望对你们有所启发和帮助！

感谢围观，点赞转发走起哈！





**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc