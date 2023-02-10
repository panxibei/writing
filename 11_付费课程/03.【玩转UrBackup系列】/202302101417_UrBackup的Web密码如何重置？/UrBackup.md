UrBackup

副标题：

英文：

关键字：



时间久了，密码记不住了。

图01



其实 `UrBackup` 自带密码恢复功能。

查了下官网，在 `Linux` 平台下非常方便。

```
# Reset web interface administrator password
/usr/bin/urbackupsrv reset-admin-pw
```



但是 `Windows` 平台的没找到，于是只好自己摸索。



文件夹内找到一个名为 `reset_pw.bat` 的批处理文件，哈哈，这不就是嘛！

图02



别着急运行，先打开看看，万一要有彩蛋呢！

图03



关键是最后一行代码。

```
"%~dp0\urbackup_srv.exe" --cmdline --no-server --plugin cryptoplugin.dll --plugin urbackupserver.dll --set_admin_pw "%newpw%"
```



没啥特别的，先运行试试看吧！

结果毛毛了，输了个密码后就报了一堆错。

图04



等会哈，我先瞅瞅，好像是一些什么插件加载错误。

这让我上哪儿去整这些插件去啊！



难道说这命令参数有误？

我尝试着查看命令参数，蹦出来好几行让人眼花缭乱的参数。

图05



我咬着后槽牙心想，这都是啥呀！

哎，慢着慢着，不对啊！

我回头一瞧批处理的这条命令，有个 `--plugin` 参数，不是已经加载了两个插件了嘛！

这时我突然好像想起了什么，这加载的两个插件好像就在那文件夹里躺着呢！

果不其然，真是踏破铁鞋无觅处，得来全不费功夫啊！

图06



得，赶紧给加上吧，再走一次！

结果插件是加载正常了，怎么后面的错误还有呢！

图07



这上面好像写着什么打开 `LMDB` 数据库文件失败。

```
ERROR: LMDB: Failed to open LMDB database file
```



这是个什么茬？什么数据库？

思前想后，猜测应该是 `UrBackup` 的数据库吧。

难道是数据库文件路径不对？

遂切换到数据库所在目录后再执行批处理，发现问题依旧。



上网查了半天也查不出个所以然来，这可如何是好？

就在这山穷水尽之时，我突然想到，会不会是 `UrBackup` 服务正在运行占用了数据库文件呢？

想到这儿，我找到了 `UrBackup` 服务所在项，一记重拳将其击倒，服务停止了。

图08



来吧，大胆尝试一下！

先直接用命令行走一遍，直接给密码参数看看。

嘿！奇迹出现了！

图09



真的搞定了？

别慌，再用批处理跑一下，先输入密码 `123456` 。

图10



定定神后果断回车，成功了！

图11



最后总结一下。

首先，要将所需插件（ `dll` 文件）都加载上。

其次，务必先将 `UrBackup` 服务停止，待密码修改完成后再重启服务。

最后，就是验证确认密码是否可以成功登录。



批处理命令行中，如下补充修正代码。

```
"%~dp0\urbackup_srv.exe" --cmdline --no-server --plugin cryptoplugin.dll --plugin fsimageplugin.dll --plugin fileservplugin.dll --plugin luaplugin.dll --plugin urbackupserver.dll --set_admin_pw "%newpw%"
```



懒的复制粘贴的小伙伴可以直接下载我打包好的重置批处理文件。

下载链接：





**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc