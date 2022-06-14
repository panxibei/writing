UrBackup Server 2.4.x 管理手册中文版（十一）杂项

副标题：杂项~

英文：administration-manual-for-urbackup-server-11

关键字：administration,manual,urbackup,backup,server,client,architecture



 本节将向小伙伴们阐述 `UrBackup` 杂项的相关内容。 



#### 11. `UrBackup` 的杂项

##### 11.1 手动更新 `UrBackup` 客户端

在客户端上使用 `UrBackup` 客户端之前，你应该先对其进行一些测试。

意思是有可能 `UrBackup` 不会自动从 `Internet` 下载最新的客户端版本并进行安装。

这就意味着在第 `9.1.8` 节中描述的自动更新被禁用了。

如果禁用了自动更新，你仍然可以从服务器集中更新客户端。

转至 `https://hndl.urbackup.org/Client/` 并将当前客户端更新文件夹中的所有文件下载到 `Linux` 上的  `/var/urbackup` 或 `Windows` 上（默认）的 `C:\Program Files\UrBackupServer\urbackup` 。

`UrBackup` 将在重新建立连接后推送新版本到客户端。

如果你启用了静默自动更新，则新版本将静默安装在客户端上，否则将弹出窗口要求用户安装新版本。 



##### 11.2 日志记录

`UrBackup` 通常将所有与备份相关的内容记录到几个日志工具中。

每条日志消息都具有相应的严重程度，即错误、警告、信息或调试。

每条日志输出都可以根据此严重程度过滤，例如只显示错误。

服务器和客户端都有单独的日志。

在备份过程中，`UrBackup` 服务器尝试将属于某个备份的所有内容记录在客户端特定的日志中，最后将该日志发送给客户端。

这些是你在客户端界面上看到的日志。

也可以通过 `Web` 界面的 `日志` 选项卡区域查看相同的日志。

如第 `9.2.2` 小节所述，你也可以通过邮件发送它们。



无法授权给特定客户端或会导致过多日志流量的所有内容都记录在通用日志文件中。 

服务器的日志文件默认在 `Linux` 上是 `/var/log/urbackup.log` ，在 `Windows` 上则是 `C:\Progam  files\UrBackupServer\urbackup.log` 。

而相应地客户端日志文件默认是 `/var/log/urbackup_client.log` 和 `C:\Progam files\UrBackup\debug.log`。

默认情况下，这些文件仅包含严重警告或更高级别的日志消息。

在 `Windows` 中，有一个 `args.txt` 文件与日志文件位于同一目录中。

将此文件的 `--loglevel` 的 `warn` 更改为 `debug` 、`info` 或 `error` 以获取一组不同级别的日志消息。

图a01



你需要重新启动服务器才能使此更改生效。

在 `Linux` 上，这取决于具体不同的发行版命令。

在 `Debian` 上，则要更改 `/etc/default/urbackupsrv` 中的设置。



##### 11.3 使用的网络端口

服务器绑定到以下默认端口：

 





 









### 小结

本节内容不多，主要阐述了 `UrBackup` 恢复备份的相关内容。

虽然内容不多，但还建议各位小伙伴重视起来，毕竟如果备份恢复失败等同于没有备份一样。

因此与如何备份同样重要的恢复备份方法，也需要我们认真阅读学习。

恢复备份的方法有很多种，不同的方法适合不同的场景，而相同的场景又可能有不止一种的恢复方法。

所以说，我们应该在实际操作中来熟悉如何恢复备份，这样也可以很好地为今后在实战中打下基础。



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc

