UrBackup Server 2.4.x 管理手册中文版（二）安装服务端

副标题：

英文：

关键字：



通常我们学习一套软件，总会尝试先安装它，然后再通过熟悉它的界面以及配置操作来掌握使用它。

`UrBackup` 既然是 `C/S` 构架的，那么它就分为服务端和客户端。

OK，那我们先来看看 `UrBackup` 的服务端是如何安装的。

在这里我们要知道，`UrBackup` 是支持多平台操作系统的，所以下面我们会针对不同的平台分别说明。



2.1.1 安装到 Windows

**操作系统版本：Windows Server 2016**



**a、直接安装**

直接到官方首页即可下载到 `exe` 格式的安装软件包。

或者在下载页面找到 `msi` 这种 Windows 平台特有的安装文件，只不过 `msi` 只支持 `Vista/2008` 及其以后版本的64位系统。

理所当然，我选择并下载了 `exe` 格式的安装包，它在哪个版本上都能安装，同时也支持 32 位系统。

当前演示版本为 `UrBackup Server 2.4.13` 。



安装过程及其简单，下一步搞定一切。

图01

图02

图03

图04



安装完毕后，打开服务器上的浏览器，访问 `http://localhost:55414` 即可访问管理配置页面。

如果要在其他电脑上访问服务器，那么别忘记开放服务器上防火墙的 `55414` 端口。

打开配置页面，首先要做的就是设置 `UrBackup` 的备份目标文件夹，也就是设置将来备份放在哪儿。



这个备份文件夹不是随便选的，它必须满足以下条件。

1、它应该放在 `NTFS` 格式的分区（卷）上，而不能是 `ReFS` 或 `FAT` 等其他格式的分区。

2、保证它有足够的可用空间来容纳备份。

3、最好它是专门放备份的，而不要兼作他用。

4、它应该在 `UrBackup` 服务实例运行时一直处于在线状态，`UrBackup` 并不支持不同的备份卷或驱动器。

5、虽然它可以被迁移，但过程漫长且非常困难，所以最好提前做好规划。

6、如果你使用 Windows 动态卷或硬件 `raid` ，那么你就可以轻松增加备份存储卷的大小。

如果你使用的是普通卷，请在首次备份之前将其更改为动态卷。

7、为 `UrBackup` 文件夹打开压缩（资源管理器中：右键单击选择属性）。

如果服务器不是很旧的话，它可以节省空间而不用降低备份速度。

不过有可能会有例外：

如果你想要备份超过 50GB 的容量大小时，那么你不应该开启压缩，NTFS 无法压缩超过 50GB 的文件。

8、作为压缩的替代方案，你可以使用 Windows Server 2012 中的脱机重复数据删除和压缩构建。

9、请在分区或卷上禁用 `8.3` 名称生成。

有关如何执行此操作，请参阅https://support.microsoft.com/en-us/kb/121007。

8.3 名称生成在极少数情况下会导致错误，降低性能，并且 8.3 名称仅在极少数情况下使用。

10、如果您使用的是 `Windows Server 2008(R2)`（或等效的桌面版本），则应考虑应用修补程序 `https://support.microsoft.com/en-us/kb/967351`，然后使用以下命令格式化备份存储卷。

```powershell
Format <Drive:> /FS:NTFS /L
```

  这可以防止这些操作系统上的大文件出现潜在问题。



**b、用巧克力来安装**

巧克力是啥？

它就是 `Chocolatey` ，好嘛，等于没说！

其实它类似于 `Linux` 下的包管理软件，只是它专用服务于 Windows 。

我们平时在 Windows 上安装软件都是先双击后下一步，没一个统一下载管理的办法，所以 `Chocolatey` 应运而生了。

如何安装 `Chocolatey` ：https://chocolatey.org/install#individual

```
# 开放安全限制
Set-ExecutionPolicy Bypass -Scope Process

# 安装 Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```



用 `Chocolatey` 安装 `Urbackup` 。

```
choco install urbackup-server
```



接下来可以跳转至 `2.1.6` 节继续操作系统的安装步骤。



**2.1.2 在 Ubuntu 上安装服务器**

**操作系统版本：Ubuntu 20.04.2 LTS**



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



开始安装后，首先提示设定保存路径，这里指定为 `/BACKUP` 。

图06



之后再耐心等待一会儿就安装完成了。

这里就可以打开 `http://serverip:55414` WEB管理界面。



**2.1.3 在 Debian 上安装服务器**

**操作系统版本：Debian 10.10**

输入以下命令开始安装 `UrBackup` 。

```
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























