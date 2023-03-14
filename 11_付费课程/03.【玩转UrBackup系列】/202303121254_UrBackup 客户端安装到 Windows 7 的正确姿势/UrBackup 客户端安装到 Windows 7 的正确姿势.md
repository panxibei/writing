UrBackup 客户端安装到 Windows 7 的正确姿势

副标题：UrBackup 客户端安装到 Windows 7 的正确姿势

英文：the-correct-way-to-install-urbackup-client-to-windows-7

关键字：urbackup,client,windows,7



“什么？现在都 `Windows 11` 时代了，你还在用 `Windows 7` ？”

我坚信至今仍有不少小伙伴还在坚持使用 `Windows 7` 系统，倒不一定说是它稳定、耐用啥的。

然而也有的情况是，有些业务系统必须跑在 `Windows 7` 上面，迁移业务系统不是行不通，就是会面临巨大的风险。

就像法国航空公司到现在还在用 `Windows 2000` 一样，只要好用就行，不在于你用啥系统，而在于你适合用啥系统。

当然了，我们今天并不是来讨论用哪个系统更好，而是针对已经被官方淘汰的 `Windows 7` 系统，看看它到底能不能、怎么安装新版 `UrBackup` 的问题。



记得以前在写 `UrBackup` 教程的时候使用的是 `2.4.x` 版本的程序，那时是支持 `Windows 7` 的啊！



确定 `UrBackup` 客户端的准确版本。

`UrBackup Client 2.5.20` 可以安装到 `Windows 7` 上，`UrBackup Client 2.5.21` 及以上版本就不再支持 `Windows 7` 了。



如果安装了较高版本，安装程序会给出提示。

图a01



`2.5.20` 是支持安装到 `Windows 7` 的最新版本。

但是安装过程中可能会由于某些原因无法成功启动 `UrBackupClientBackend` 服务。

图a02



`UrBackup` 备份全靠这个服务，它是根本的根本，无法启动的话安装程序就会自动退出，最后以安装失败告终。





论坛链接：

```
https://forums.urbackup.org/t/cbt-client-2-2-12/6191
```

图b01



更新说明链接：

```
https://support.microsoft.com/en-us/help/2999226/update-for-universal-c-runtime-in-windows
```

图b02





更新 `KB2999226` 的下载链接：

```
https://www.microsoft.com/zh-cn/download/details.aspx?id=49093
```

图b03



安装更新补丁。

图b04

图b05



再次确认 `KB2999226` 是否安装成功。

图b06



当然，如果你安装过这个更新，那么多半 `UrBackup Client` 应该是会安装成功的。

比如你安装的是带有全部更新的 `Windows 7 UpdateR2` 这种的，我之前的文章有写过，现在也在不定期地更新。



再次安装 `UrBackup` 客户端，服务成功启动了！

图c01





最后附上支持 `Windows 7` 最新版的 `UrBackup` 客户端安装程序。

**UrBackup Client 2.5.20多平台版本(含 `KB2999226` 更新补丁)**

下载链接：https://pan.baidu.com/s/1hctfI9YIMy4uDnDM7y1bSA

提取码：viy1







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc