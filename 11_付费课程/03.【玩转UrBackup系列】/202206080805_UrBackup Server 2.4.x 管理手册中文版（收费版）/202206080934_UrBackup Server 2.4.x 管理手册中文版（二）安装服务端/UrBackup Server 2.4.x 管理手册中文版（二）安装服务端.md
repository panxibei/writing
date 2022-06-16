UrBackup Server 2.4.x 管理手册中文版（二）安装服务端

副标题：安装服务端~

英文：administration-manual-for-urbackup-server-2

关键字：administration,manual,urbackup,backup,server,client



通常我们学习一套软件，总会先尝试安装它，然后再通过熟悉它的界面以及配置操作来掌握使用它。

`UrBackup` 既然是 `C/S` 构架的，那么它肯定是分为服务端和客户端。

OK，那我们先来了解 `UrBackup` 的服务端是如何安装的。

在这里我们要知道，`UrBackup` 是支持多平台操作系统的，所以下面我们会针对不同的平台分别说明。

当前演示版本为 **`UrBackup Server 2.4.13`** 。



### 2 服务端的安装

##### 2.1 在 Windows上安装服务器

**演示操作系统版本：Windows Server 2016**



###### 2.1.1 直接安装

直接到官方首页即可下载到 `exe` 格式的安装软件包。

或者在下载页面找到 `msi` 这种 Windows 平台特有的安装文件，只不过 `msi` 只支持 `Vista/2008` 及其以后版本的 64 位系统。

理所当然，我选择并下载了 `exe` 格式的安装包，它在哪个版本上都能安装，注意，同时它也支持 32 位系统。



安装过程极其简单，下一步搞定一切。

图01

图02

图03

图04



安装完毕后，打开服务器上的浏览器，再打开网址 `http://localhost:55414` 即可访问管理配置页面。

如果要在其他电脑上访问服务器，那么别忘记开放服务器上防火墙的 `TCP` `55414` 端口。

打开配置页面，首先要做的就是设置 `UrBackup` 的备份目标文件夹（备份存储路径），也就是设置将来备份放在哪儿。



注意啦！这个备份文件夹可不是随便选的，它必须满足以下条件。

1. 它应该放在 `NTFS` 格式的分区（卷）上，而不能是 `ReFS` 或 `FAT` 等其他格式的分区。

2. 要保证它有足够的可用空间来容纳备份。

3. 最好它是专门放备份的，而不要兼作他用。

4. 它应该在 `UrBackup` 服务实例运行时一直处于在线状态，`UrBackup` 并不支持不同的备份卷或驱动器。

5. 虽然它可以被迁移，但过程漫长且异常困难，所以最好提前做好规划。

6. 如果你使用 `Windows` 动态卷或硬件 `raid` ，那么你就可以轻松扩展备份存储卷的大小。

   如果你使用的是普通卷，若想将来备份文件夹有扩展性，请在首次备份之前将其更改为动态卷。

   具体可以参考我写的《Windows 运用 UrBackup 备份服务的最佳实践》一文。

7. 为 `UrBackup` 备份文件夹打开压缩（资源管理器中：右键单击选择属性）。

   如果服务器不是很旧的话，它可以节省空间而不用降低备份速度。

   不过有可能会有例外情况：

   如果你想要备份超过 50GB 的容量大小时，那么你不应该开启压缩，因为 `NTFS` 无法压缩超过 50GB 的文件。

8. 作为压缩的替代方案，你还可以使用 `Windows Server 2012` 中的脱机重复数据删除和压缩构建。

9. 请在分区或卷上禁用 `8.3 名称生成`。

   有关如何执行此操作，请参阅 `https://support.microsoft.com/en-us/kb/121007` 。

   `8.3 名称生成` 在极少数情况下会导致错误，降低性能，并且 `8.3 名称` 仅在极少数情况下使用。

   

   输入以下命令后重启系统来禁用 `8.3 名称生成` ：

   ```
   fsutil behavior set disable8dot3 1
   ```

   

10. 如果你使用的是 `Windows Server 2008(R2)`（或等效桌面版本），可能会有 `NTFS` 卷碎片化严重而导致复制文件失败的系统问题，则应考虑应用修补程序 `https://support.microsoft.com/en-us/kb/967351`，然后使用以下命令格式化备份存储卷。

    ```powershell
    Format <Drive:> /FS:NTFS /L
    ```

    这可以防止这些操作系统上的大文件操作出现潜在问题。
    
    由于 `Windows Server 2008(R2)` 或 `Vista` 之类系统的生命同期已经结束，因此微软官网相关的更新补丁也不再提供，基于此建议大家尽量使用较新的 `Windows` 版本系统以避免出现大文件读写失败问题。



###### 2.1.2 用巧克力来安装

`Windows` 下居然还有其他安装方式，是不是挺新鲜？

慢着，这巧克力是啥？

它就是 `Chocolatey` ，好嘛，等于没说！

其实它类似于 `Linux` 下的包管理软件，只是它专门服务于 `Windows` 。

没用过 `Linux` 的小伙伴可能会懵，听我给你解释。

我们平时在 `Windows` 上安装软件都是先双击后下一步，这种方式本身好像没啥毛病，但是软件一多你就会发现，没办法好好管理了，进而导致软件混乱不堪。

这时我们急需一个统一下载管理的办法，所以仿照 `Linux` ， `Chocolatey` 也就应运而生了。

有了 `Chocolatey` ，所有的被它支持的软件我们只要通过它就可以统一安装管理了，不再需要一个一个地自己手动费心费力了。



如何安装 `Chocolatey` ：

> https://chocolatey.org/install#individual

```powershell
# 请在 PowerShell 中执行
# 开放安全限制
Set-ExecutionPolicy Bypass -Scope Process

# 安装 Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```



用 `Chocolatey` 安装 `Urbackup` 。

```
choco install urbackup-server
```



接下来可以跳转至 `2.6` 节继续操作系统的后续安装步骤了。



##### 2.2 在 Ubuntu 上安装服务器

**演示操作系统版本：Ubuntu 20.04.2 LTS**



使用以下命令安装 `UrBackup` 服务端。

```
# 获取指向 UrBackup 的更新源
sudo add-apt-repository ppa:uroni/urbackup

# 更新系统源
sudo apt-get update
sudo apt-get install urbackup-server
```



获取 `UrBackup` 更新源时，需要回车确认一下。

图05



开始安装后，首先提示设定保存路径，比如这里指定为 `/BACKUP` 。

图06



之后再耐心等待一会儿就完成安装了。

这时就可以打开 `http://serverip:55414` 来访问 `Web` 管理界面了。



##### 2.3 在 Debian 上安装服务器

**演示操作系统版本：Debian 10.10**



输入以下命令开始安装 `UrBackup` 。

```
# 命令中可依据实际具体的版本号修改
sudo apt-get update
wget https://hndl.urbackup.org/Server/2.4.13/urbackup-server_2.4.13_amd64.deb
sudo dpkg -i urbackup-server_2.4.13_amd64.deb
sudo apt-get -f install 
```



下载当前最新稳定版本 `urbackup-server_2.4.13_amd64.deb` 。

图07



可能需要你安装一些依赖，比如 `sqlite3` 和 `libcurl3-nss` 。

图08



安装完成。

图09



##### 2.4 在 FreeBSD 上安装服务器

**演示操作系统版本：FreeBSD-13.0-RELEASE-amd64**



`FreeBSD` 是一种 `Unix` 系统，它的应用也十分广泛，所以官网上仅有 `FreeNAS` 上安装 `UrBackup` 的介绍。

虽然如此，但只要是 `FreeBSD` 平台的系统都是差不多的安装方法。

类似详细的安装方法可以参考我以前的文章。

> 《XigmaNas+UrBackup打造个人整机备份方案》
>



简单地说，由两大步骤完成。

第一步，执行安装命令。

```
pkg update
pkg install urbackup-server
sysrc urbackup_server_enable=YES
```

图10

图11



第二步，如果你使用 `root` 用户来安装并运行 `UrBackup` ，则需要修改配置文件，将用户改为 `root` 。

```
# 修改配置文件 /usr/local/etc/urbackup/urbackupsrv.conf
# 将 USER="urbackup" 修改为 USER="root"
USER="root"
```

图12



以上两个步骤可以在默认系统上安装，也可以创建 `jail` 虚拟机后在 `jail` 上安装。

要注意管理用户和备份存储目录的权限。

```
# 创建备份目录
mkdir -p /mnt/backup/backups

# 修正备份目录的用户所属，比如你的用户是 urbackup ，则修改成 urbackup
chown urbackup:urbackup /mnt/backups/backups
```



此外，可以通过重复操作以上步骤来更新到新版本的 `UrBackup` 。



##### 2.5 在其他 GNU/Linux 发行版上安装服务器

`UrBackup` 项目已经托管到了 `OpenSUSE` 网站上，通过点击不同的图标来显示具体的安装步骤。

> 参考链接：https://software.opensuse.org/download.html?project=home%3Auroni&package=urbackup-server

图13



###### 2.5.1 在其他 GNU/Linux 发行版上以源码方式安装服务器

在 `http://urbackup.org/download.html` 页面上有相关详细信息，通常我们需要手动编译源码来安装服务器。

* 下载 `UrBackup` 服务端 `tarball` 源码并解压缩。
* 安装依赖项，比如 `gcc` 、 `g++` 、`make`  、 `libcrypto++` 以及 `libcurl` （就如开发版本中包含的那样）。
* 通过 `./Configure` 、`make` 和 `make install` 编译并安装服务端。
* 使用 `urbackupsrv run` 来运行服务器
* 将 `/usr/bin/urbackupsrv run -daemon` 添加到你的 `/etc/rc.local` 或其他系统启动配置文件中，以便在服务器启动时可以自动启动 `UrBackup` 服务器。



有关 `GNU/Linux` 系统的更多安装提示，请参阅第 `2.5.2` 节，有关独立于操作系统的安装步骤，请参阅第 `2.6` 节。



###### 2.5.2 关于 GNU/Linux 服务器安装的小提示

进入网页管理界面 `http://localhost:55414` ，在设置中配置备份存储路径。

关于备份存储路径的小提示：

* 它应该很容易扩展，这可以通过使用硬件 `raid`、卷管理器 `LVM` 或下一代文件系统 `btrfs` 和 `ZFS` 来实现。

* 你应该压缩文件备份。这可以通过使用 `ZFS` （`http://zfsonlinux.org/`）或 `btrf` 来实现。

* 推荐 `btrfs` ，因为 `UrBackup` 可以将每个文件备份放入单独的子卷中，并且能够在增量文件备份中执行基于块的廉价重复数据删除。

  有关如何设置 `btrfs` 备份存储，请参阅第 `12.7.2` 节。

  如果使用 `btrfs` ，你应该设置一个非常低的软文件系统配额（请参阅第 `9.1.14` 节），因为 `btrfs`  目前在空间不足的情况下仍然存在问题，可能需要手动干预。



##### 2.6 操作系统独立服务器安装步骤

安装 `UrBackup` 服务器后，你应该执行以下步骤：

* 转到用户设置并添加管理员帐户。如果你不这样做，每个可以访问服务器的人都将能够看到所有备份！

  图14

  

* 通过输入指定的邮件服务器设置来设定邮件服务器（请参阅第 `9.2.1` 节）。

* 如果你希望客户端能够通过 `Internet/广域网` 而不仅仅是通过本地局域网进行备份，请在 `Internet/广域网` 设置中配置服务器的公共服务器名称或 `IP`（参见第 `9.4` 节）。

* 如果你希望**客户端能够通过浏览器访问其备份**并可以通过右键单击指定备份来恢复/访问备份，那么请务必在设置中输入服务器的 `URL` 。

  例如你可以这样输入 `http://backups.company.com:55414/` ，但请确保你的 `DNS` 配置解析正常，如果从内部网络访问，`backups.company.com` 应当指向备份服务器的内部 `IP` ，否则应该解析为外部 `IP` 地址。

* 你应该在 `UrBackup` 前面放置一个真实的 `Web` 服务器并设置 `SSL`（请参阅第 `5.2` 节 ）。

* 如果你想查看备份失败的日志，请转到日志界面并为你的电子邮件地址配置报告。

* 根据你的使用场景修改任何其他设置。有关所有可用设置的说明，请参阅第 `9` 节。

* 安装客户端（请参阅第 `3` 节）。



本节为小伙伴们演示说明了各个服务器平台上安装 `UrBackup` 的要领方法。

作为开始了解 `UrBackup` 的重要一环，服务端安装有很多讲究，而且还包含了使用前的一些准备设定工作，比如备份路径、服务器 `IP` 地址等，需要我们认真仔细地阅读前面所述内容。

好，在下一节我们为大家介绍客户端的安装和注意事项。

如果对本节还不太熟悉，请大家转发分享后再来看看吧！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc





