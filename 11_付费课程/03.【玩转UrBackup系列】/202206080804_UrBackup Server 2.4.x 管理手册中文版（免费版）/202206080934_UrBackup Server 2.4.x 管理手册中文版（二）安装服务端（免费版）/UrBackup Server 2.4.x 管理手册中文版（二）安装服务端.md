UrBackup Server 2.4.x 管理手册中文版（二）安装服务端

副标题：安装服务端~

英文：administration-manual-for-urbackup-server-2

关键字：administration,manual,urbackup,backup,server,client



### 2 安装服务端

##### 2.1 Windows上的服务器安装

* 下载 `NSIS (.exe)` 或 `MSI` 安装程序。

  如果你有 `64` 位操作系统且至少为 `Windows Vista/2008` ，则只能使用 `MSI` 安装程序。

* 安装 UrBackup 服务器。

* 转到 `Web` 界面 ( `http://localhost:55414` )，然后转到设置并配置 `UrBackup` 应存储备份的文件夹。

  此文件夹应具有以下属性：
     * 它应该位于 `NTFS` 格式的卷上（不是 `ReFS` 或 `FAT` ）。

     * 应该有足够的可用空间来容纳备份。

     * 该卷最好专用于 `UrBackup` 备份。

     * 在 `UrBackup Server` 实例运行时，该卷应始终在线。

     * `UrBackup` 不支持不同的备份卷/驱动器。

     * 虽然迁移是可能的，但这将是漫长而困难的。所以最好提前计划。

     * 如果你使用 `Windows` 动态卷或硬件 `RAID` ，则可以轻松增加备份存储卷的大小。

       如果你使用的是普通卷，请在第一次备份之前将其更改为动态卷。

  * 打开 `urbackup` 文件夹的压缩（在资源管理器中：右键单击和属性）。

    如果你使用的不是一台非常旧的计算机，它应该在不降低备份速度的情况下获得回报。

    可能的例外：如果你计划备份超过 `50GB` 的文件或关闭映像压缩并计划备份超过 `50GB` 的卷，则不应打开压缩。

    `NTFS` 无法压缩大于约 `50GB` 的文件。

  *  除了压缩之外，你还可以使用 `Windows Server 2012` 中的脱机去重和压缩。

  * 在卷上禁用 `8.3` 名称生成。

    有关如何执行此操作，请参阅 `https://support.microsoft.com/en-us/kb/121007` 。

    `8.3` 名称生成在极少数情况下会导致错误，降低性能，并且 `8.3` 名称仅在极少数情况下使用。

  * 如果你使用的是 `Windows Server 2008(R2)`（或等效的桌面版本），则应考虑应用修补程序 `https://support.microsoft.com/en-us/kb/967351` ，然后使用格式化备份存储卷。

    ```
    Format <Drive:> /FS:NTFS /L
    ```

    这可以防止这些操作系统上的大文件出现潜在问题。

* 继续执行第 `2.1.6` 节中与操作系统无关的安装步骤。

  

  

##### 2.2 Ubuntu 上的服务器安装

通过运行以下命令安装 `UrBackup Server`：

```
sudo add-apt-repository ppa:uroni/urbackup
sudo apt-get update
sudo apt-get install urbackup-server
```

有关更多安装提示，请参阅第 `2.1.5` 节，有关独立于操作系统的安装步骤，请参阅第 2.1.6 节。



##### 2.3 Debian 上的服务器安装

按照 `http://urbackup.org/download.html` 上的 Debian 下载链接。

软件包可用于 `CPU` 架构 `i686` 和 `AMD64` 的 `Debian` 稳定版、测试版和不稳定版。

该软件包可以通过以下方式安装：

```
sudo apt-get update
sudo dpkg -i urbackup-server*.deb
sudo apt-get -f install
```

有关更多安装提示，请参阅第 `2.1.5` 节，有关独立于操作系统的安装步骤，请参阅第 `2.1.6` 节。



##### 2.4 在其他 GNU/Linux 发行版或 FreeBSD 上安装服务器

在 `http://urbackup.org/download.html` 上详细说明你需要编译服务器。

* 下载 `urbackup` 服务器源 `tarball` 并解压。
* 安装依赖项。它们是 `gcc` 、`g++` 、`make` 、`libcrypto++` 和 `libcurl`（作为开发版本）。
* 通过 `./configure` 、`make` 和 `make install` 编译和安装服务器。
* 使用 `urbackupsrv run` 运行服务器。
* 将 `/usr/bin/urbackupsrv run –daemon` 添加到你的 `/etc/rc.local` 以在服务器启动时启动 `UrBackup` 服务器。

有关 `GNU/Linux` 系统的进一步安装提示，请参阅第 `2.1.5` 节，有关独立于操作系统的安装步骤，请参阅第 `2.1.6` 节。



##### 2.5 `GNU/Linux` 服务器安装提示

进入网页界面（ `http://localhost:55414` ），在设置中配置备份存储路径。

备份存储的一些提示：

* 它应该易于扩展，可以通过使用硬件 `RAID` 、卷管理器 `LVM`  或下一代文件系统 `btrfs` 和 `ZFS` 来完成。

* 你应该压缩文件备份。

  这可以通过使用 `ZFS` ( `http://zfsonlinux.org/` ) 或 `btrfs` 来完成。

* 首选 `btrfs`，因为 `UrBackup` 可以将每个文件备份放入单独的子卷中，并且能够在增量文件备份中进行基于块的廉价重复数据删除。

  请参阅第 `12.7.2` 节了解如何设置 `btrfs` 备份存储。

  如果使用 `btrfs` ，你应该设置一个足够低的软文件系统配额（参见第 `9.1.14` 节），因为 `btrfs` 目前在空间不足的情况下仍然存在问题，并且可能需要手动干预。

  

##### 2.6 操作系统独立服务器安装步骤

安装 `UrBackup` 服务器后，你应该执行以下步骤：

* 转到用户设置并添加管理员帐户。

  如果你不这样做，可以访问服务器的每个人都将能够看到所有备份！

* 通过输入适当的邮件服务器设置来设置邮件服务器（参见第 `9.2.1` 节）。

* 如果你希望客户端能够通过 `Internet` 而不仅仅是通过本地网络进行备份，请在 `Internet` 设置中配置服务器的公共服务器名称或 `IP`（参见第 `9.4` 节）。

* 如果你希望客户端能够通过浏览器访问他们的备份并 `右键单击` > `恢复/访问备份` ，请输入服务器 `URL` ，例如 `http://backups.company.com:55414/` 。

  确保你的 `DNS` 配置为使 `backups.company.com` 在从内部网络访问时指向备份服务器的内部 `IP` ，否则指向外部 `IP` 。

  你应该在 `UrBackup` 前面放置一个真实的 `Web` 服务器并设置 SSL（参见第 `5.2` 节）。

* 如果你想获取失败备份的日志，请转到“日志”屏幕并为您的电子邮件地址配置报告。

* 根据你的使用场景更改任何其他设置。

  有关所有可用设置的说明，请参见第 `9` 节。

* 安装客户端（参见第 `3` 节）。







**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc





