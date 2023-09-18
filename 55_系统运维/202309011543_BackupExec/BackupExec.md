BackupExec

副标题：

英文：

关键字：



备份软件 `Backup Exec` ，对于从事系统管理或运维的小伙伴们来说应该多多少少用过或听说过吧。

前一阵我就碰到个糟心事，就是搞这个 `Backup Exec` 时总有个坎过不去。



事情是这样的，这个 `Backup Exec` （以下简称 `BE` ）呢它有一个很好的功能叫作系统灾难恢复。

这个系统灾难恢复英文叫作 `Simplified Disaster Recovery` ，简称 `SDR` ，可以在系统故障无法启动的时候，我们就可以用它来快速有效地恢复备份。

具体的做法是，我们先做个开启 `SDR` 功能的备份，然后再用 `BE` 向导程序制作一个 `SDR` 启动盘，类似于 `PE` 环境的 `U` 盘或是 `ISO` 光盘。

当故障发生时，我们使用这个 `U` 盘或光盘先启动到 `PE` 环境，然后再连接到备份设备，这样就可以完美恢复备份啦！

图b02



这种方案不能说不完美，不能说不OK！

可是这玩意有个小小的膈应人的地方，想要得到包含指定目标备份的 `SDR` 启动盘，则必须先要成功制作出指定目标的备份才行。

换句大白话讲，就是我得开启 `SDR` 把备份先做出来，然后才能得到指向这个备份的 `SDR` 启动盘。

图b03



比如，我想备份目标服务器 `ServerA`  ，包括它的 `C` 盘啥的。

在备份前，你要开启 `SDR` ，然后再完成备份工作。

接着，用 `BE` 向导制作 `SDR` 启动盘，这时你会发现启动盘里有前面备份的 `ServerA` 。

如果前面 `ServerA` 备份时没带上 `SDR` ，那么启动盘制作时你是看不到 `ServerA` 的，自然用这样的启动盘引导后也是恢复不了 `ServerA` 上的数据的。

因为启动盘引导后，里面压根就不显示之前 `ServerA` 的备份信息，恢复数据也就无从谈起了！



啰嗦了这么多，我碰到个啥问题呢？

如图所示，当BE选择备份项时，如果排除除 `C` 盘以外的任意盘符、文件夹或文件，这时 `SDR` 就会自动关闭无效。

图b01



我再说得直白一点，只要不是全选（所有的盘符）备份项，`SDR` 就会失效。

实际上是你只要备份 `C` 盘、 `EFI` 系统分区以及系统状态，默认 `SDR` 就是有效开启的。

这种情况下，我们就可以制作灾难恢复盘。

当系统出现故障无法启动时，我们就可以拿这个灾难恢复盘启动，然后再连接到备份设备进行恢复工作。

但是吧，就像我前面所说，现在 `SDR` 不让你开启了，我总不能连 `D` 盘一块儿备份吧。

如果 `D` 盘数据量小，那我就忍了，但是动辄几个 `T` 的数据，也不方便啊！



于是上网找答案吧！



官方支持文档一：

> How to enable Simplified Disaster Recovery backup when some files and/or folders on critical volumes are excluded
>
> https://origin-www.veritas.com/support/en_US/article.100013796



```
HKEY_LOCAL_MACHINE\SOFTWARE\Veritas\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:
```

图x01

图x02



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

图y01

图y02



费了半天劲，居然还是不行！

不是吧，这可是官网上的文档啊，还能有错？

可以这么说，我把官网的这些文章一个字一个字地仔仔细细地研究了个遍，也没看出还有其他特殊设置的地方。

就这么多了，没啥特别的，事情一度陷入僵局。



随后我就在思考，究竟啥玩意能让这个 `SDR` 开启呢？

或许这是解开谜题的关键。

于是我耐着性子接着翻文档，结果找到这么一段内容。

原来 `SDR` 开启是要看有没有所谓的关键系统组件的，只有关键系统组件被选中才能开启 `SDR` 。

那么什么是关键系统组件呢？



官方关于备份关键系统组件的描述：

> https://www.veritas.com/content/support/en_US/doc/59226269-99535599-0/v60036296-99535599



以下系统资源被视为关键资源，如果您希望能够使用备份集执行完整系统还原，则必须将它们包含在备份中：

- 系统卷（包括 EFI 和实用程序分区）
- 启动卷（不包括操作系统）
- 服务应用程序卷（引导、系统和自动启动）
- 系统状态设备和卷（包括活动目录、系统文件等）
- 任何适用版本的 Windows 上的 Windows Recovery Partition （WinRE）



哦，我大概明白了！

`EFI` 肯定是关键系统组件，不过还有这么多东西也是关键的啊！

难道说，那个 `D` 盘有什么关键组件存在吗？

就是因为没选中它，`SDR` 才失效的？

可我转念又一想，不可能啊，这个 `D` 盘就是一普通分区，哪来的关键组件呢？

我头上顶着几个大问号，开始研究起这个 `D` 盘到底有什么鬼……



结果不看不知道，一看还真把我老人家给吓了一大跳！

原来啊，这个 `D` 盘是个独立的物理硬盘，并不是简单的逻辑磁盘。

光用 `Windows` 系统中磁盘管理程序，居然看不出它的最前面有那么一个小得不能再小的保留分区。

使用 `BE` 的引导盘启动后，查看高级磁盘配置。

图a01



`Mircosoft` 系统保留分区赫然在目！

图a02



常年打雁，今个儿让雁给啄了眼。

为啥会犯这个错呢？

原因就是我用的 `Windows` 的磁盘管理程序看它，就是一块儿老老实实呆在那儿的 `D` 盘。

其实只要用其他第三方的磁盘管理程序都能发现这里的猫腻。

到此就明白了！



最后只要把这个保留分区删除（注意备份数据），再回过头来测试，即便不选择 `D` 盘，`SDR` 也就可以正常开启了！







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc