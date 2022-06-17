UrBackup Server 2.4.x 管理手册中文版（十一）杂项

副标题：杂项~

英文：administration-manual-for-urbackup-server-11

关键字：administration,manual,urbackup,backup,server,client,architecture



### 11 `UrBackup` 的杂项

##### 11.1 手动更新 `UrBackup` 客户端

我们在使用 `UrBackup` 客户端程序之前，应该先对其进行一些测试。

意思是有可能 `UrBackup` 并不会自动地从 `Internet` 下载最新的客户端版本并进行安装。

这就意味着在第 `9.1.8` 节中描述的自动更新被禁用了。

如果禁用了自动更新，你仍然可以从服务器集中更新客户端。

转至网址：

> https://hndl.urbackup.org/Client/

并将当前系统平台对应的客户端程序在 `update` 文件夹中的所有文件下载到：

`Linux` 上的

```
/var/urbackup
```

或 `Windows` 上（默认）的

```
C:\Program Files\UrBackupServer\urbackup
```

这些目录中。

图01



接着 `UrBackup` 将在它们重新建立连接后推送新版本到客户端。

如果你启用了静默自动更新，则新版本将静默安装在客户端上，否则将弹出窗口询问用户是否要安装新版本。 



##### 11.2 日志记录

`UrBackup` 通常将所有与备份相关的内容记录到几个日志工具中。

每条日志消息都具有相应的严重级别，即 `error` 错误、`warning` 警告、`info` 信息或 `debug` 调试。

每条日志输出都可以根据此严重级别过滤，例如只显示错误。

服务器和客户端都有单独的日志。

在备份过程中，`UrBackup` 服务器尝试将属于某个备份的所有内容记录在客户端特定的日志中，最后将该日志发送给客户端。

这些就是你在客户端界面上看到的日志。

也可以通过 `Web` 界面的 `日志` 选项卡区域查看相同的日志。

如第 `9.2.2` 小节所述，你也可以通过邮件发送它们。



如果没有特别指定某个客户端对应某些日志的话可能会导致产生过多日志流量，因为所有内容将都记录在通用日志文件中。 

服务器的日志文件默认在 `Linux` 上是 `/var/log/urbackup.log` ，在 `Windows` 上则是 `C:\Progam  files\UrBackupServer\urbackup.log` 。

而相应地客户端日志文件默认是 `/var/log/urbackup_client.log` 和 `C:\Progam files\UrBackup\debug.log`。

图02



默认情况下，这些文件仅包含严重警告或更高级别的日志消息。

在 `Windows` 中，有一个 `args.txt` 文件与日志文件位于同一目录中。

将此文件的 `--loglevel` 的 `warn` 更改为 `debug` 、`info` 或 `error` 以获取一组不同级别的日志消息。

图03



你需要重新启动服务器才能使此更改生效。

在 `Linux` 上，这取决于具体不同的发行版命令。

在 `Debian` 上，则要更改 `/etc/default/urbackupsrv` 中的设置。



##### 11.3 使用的网络端口

服务器绑定到以下默认端口：

| Port/端口 | Usage/用途                    | Incoming/Outgoing<br />进/出（方向） | Protocol/协议 |
| --------- | ----------------------------- | ------------------------------------ | ------------- |
| `55413`   | 为 `web` 接口服务的 `FastCGI` | Incoming/进                          | `TCP`         |
| `55414`   | `HTTP web` 管理接口           | Incoming/进                          | `TCP`         |
| `55415`   | `Internet` 客户端访问         | Incoming/进                          | `TCP`         |
| `35623`   | 用于发现的 `UDP` 广播端口     | Outgoing/出                          | `UDP`         |

 

客户端绑定到以下默认端口：

| Port/端口 | Usage/用途                   | Protocol/协议 |
| --------- | ---------------------------- | ------------- |
| `35621`   | 备份期间发送文件（文件服务） | `TCP`         |
| `35622`   | 用于发现的 `UDP` 广播端口    | `UDP`         |
| `35623`   | 发送指令或用于映像备份       | `TCP`         |



##### 11.4 在 `GNU/Linux` 上挂载（压缩的）`VHD` 文件

如果你使用 `fuse`（用户态文件系统）支持编译 `UrBackup` 或安装了 `Debian/Ubuntu` 软件包，则 `UrBackup` 服务器可以直接挂载 `VHD(Z)` 文件。

你可以通过配置来编译带有 `fuse` 支持的 `UrBackup` ：

```
./configure --with-mountvhd
```

你可以通过如下方法挂载 `VHD(Z)` 文件。

```
urbackupsrv mount-vhd --file /media/backup/urbackup/testclient/\  
Image_C_140420-1956.vhdz --mountpoint /media/testclient_C
```

之后 `C` 卷备份中的所有文件将在 `/media/testclient_C` 中有效可读。

`unmount` 卸载由 `UrBackup` 创建的挂载（参见 `mount` 输出），来停止后台进程。 



##### 11.5 在 `Windows` 上将 `VHD` 挂载为卷

从 `Vista` 开始，`Windows` 可以直接挂载 `VHD` 文件。

如果 `VHD` 文件被压缩，则需要先对其进行解压缩（参见下一节 `11.6`）。

然后进入 `系统设置` > `管理` > `计算机管理` > `磁盘管理` > `其他操作` > `添加虚拟硬盘` ，以只读方式装载 `VHD` 文件。

该映像将在资源管理器中显示为另一个驱动器。

如果 `VHD` 文件位于网络驱动器上，它可能不起作用。



##### 11.6 解压 `VHD` 文件

可以考虑使用下一节 `11.7` 中描述的方法来解压缩 `VHD` 文件。

如果要在 `Windows` 上挂载 `VHD` 文件而它们是压缩格式的（文件扩展名为 `VHDZ`），则需要先解压缩它们。

使用  `C:\Program Files\UrBackupServer\uncompress_image.bat`  正是为了这个原因。

图04



调用不带参数的批处理文件将打开一个文件选择窗口，你可以在其中选择要解压缩的 `VHDZ` 文件。

图05



解压缩完成后，会创建一个比原先更大的临时副本并自动重命名。

如果映像是增量的，则父级 `VHD` 也会自动解压缩。

如果你想防止这种情况发生，请使用第 `11.7` 节中描述的方法来构建单独的未压缩映像。

所有映像文件仍将具有 `VHDZ` 扩展名（也就是说是压缩形式的），否则将不得不更改数据库条目，只是文件将不再被压缩。

在 `Linux` 上，可以使用 `urbackupsrv decompress-file -f [filename]` 完成相同的操作。



笔者补充说明：

和前面官方描述的部分内容有一些出入，特此说明。

在 `Windows` 上如果你直接双击打开的 `uncompress_image.bat` ，那么它会将 `vhdz` 文件直接解压缩并覆盖原文件。

此时需要已经解压缩完成，但文件的扩展名不会变，需要我们手动修正为 `vhd` 。

这样我们就可以利用 `Windows` 自带的镜像挂载功能，直接挂载使用镜像了。

图06



##### 11.7 将多个 `VHD` 卷映像整合成一个 `VHD` 磁盘映像

`UrBackup` 是分别单独存储每个卷的映像备份的。

如果你想在不使用还原 `CD` 的情况下启动加载映像备份，那么作为一台完整的虚拟机你必须将多个卷重新整合到一个磁盘 `VHD` 映像中。

在 `Windows` 上，可以通过运行 `C:\Program Files\UrBackupServer\assemble_disk_image.bat` 来完成。

图07



在第一步中，它将询问你需要整合哪些 `VHD` 映像（可多选），例如选择 `Image_C_XXXXX.vhd` 和 `Image_SYSVOL_XXXXX.vhd` 。

图08



选择的源映像文件也可以是增量或压缩的。

然后它会询问输出的 `VHD` 磁盘映像应该保存在哪里。

图09



之后，它会将 `Image_C_XXXXX.vhd.mbr` 的主引导记录和卷内容写入输出磁盘映像中的适当偏移量。

 在 `Linux` 上，同样的事情可以用

```
urbackupsrv -a /full/path/Image_C_XXXXX.vhdz -a /full/path/Image_SYSVOL_XXXXX.vhdz\  
-o full_disk.vhd
```

 通过选择单个 `VHD` 文件作为输入，此工具还可用于在不解压其父级 `VHD` 的情况下解压缩映像。



##### 11.8 迁移非 `btrfs` 备份存储

`UrBackup` 具有内置迁移功能，可让你以最少的停机时间将备份存储迁移到不同的设备。

这仅适用于普通备份存储，也就是说，它不适用于第 `12.7.2` 节中描述的特殊 `btrfs` 模式或第 `12.7.1` 节中描述的写入时复制 `copy-on-write`  映像 。

迁移功能仅适用于迁移，不适用于比如镜像备份等场景。

与使用诸如 `rsync` 相比，内置迁移有一些优点：

* 它可以以备份级别恢复迁移
* 它会自动禁用所有清理，以最大限度地减少迁移期间必要的更改量
* `UrBackup` 会继续备份当前未迁移的客户端并自动迁移新备份
* `UrBackup` 会很好地处理硬链接



在 `/var/urbackup` 或 `C:\Program Files\UrBackupServer\urbackup`  中创建一个名为 `migrate_storage_to` 的文件，其唯一内容是要将备份迁移至哪里的目标路径。

然后重新启动 `UrBackup` 服务器，迁移进程将会开始。

你可以在 `Web` 管理界面的 `活动` 页面查看迁移进度。

迁移完成后，将设置中的 `备份存储路径` 更改为新位置或将新的备份存储挂载到老位置。

然后运行第 12.4 节中描述的 `删除未知` 。 





### 小结

本节内容比较杂，包括手动更新客户端、日志记录、通讯端口以及 `VHD` 文件的挂载等等。

关于 `VHD` 挂载涉及的存储相关内容，将在下一小节阐述，敬请期待！



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc

