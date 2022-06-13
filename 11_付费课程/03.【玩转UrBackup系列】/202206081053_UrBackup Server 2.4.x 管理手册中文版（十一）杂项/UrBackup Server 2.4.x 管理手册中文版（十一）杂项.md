UrBackup Server 2.4.x 管理手册中文版（十一）杂项

副标题：杂项~

英文：administration-manual-for-urbackup-server-11

关键字：administration,manual,urbackup,backup,server,client,architecture



 本节将向小伙伴们阐述 `UrBackup` 杂项的相关内容。 



#### `UrBackup` 的杂项

##### 11.1 手动更新 `UrBackup` 客户端

在客户端上使用 `UrBackup` 客户端之前，你应该对其进行测试。

这意味着 `UrBackup` 不应自动从 `Internet` 下载最新的客户端版本并进行安装。

这意味着禁用第 `9.1.8` 节中描述的自动更新。

如果禁用自动更新，你仍然可以从服务器集中更新客户端。

转到 `https://hndl.urbackup.org/Client/` 并将当前客户端更新文件夹中的所有文件下载到 Linux 上的  `/var/urbackup` 和 `Windows` 上默认为 `C:\\Program Files\UrBackupServer\urbackup` 。

`UrBackup` 将在重新连接后将新版本推送到客户端。

如果您选中了静默自动更新，则新版本将静默安装在客户端上，否则将弹出窗口要求用户安装新版本。 











### 小结

本节内容不多，主要阐述了 `UrBackup` 恢复备份的相关内容。

虽然内容不多，但还建议各位小伙伴重视起来，毕竟如果备份恢复失败等同于没有备份一样。

因此与如何备份同样重要的恢复备份方法，也需要我们认真阅读学习。

恢复备份的方法有很多种，不同的方法适合不同的场景，而相同的场景又可能有不止一种的恢复方法。

所以说，我们应该在实际操作中来熟悉如何恢复备份，这样也可以很好地为今后在实战中打下基础。



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc

