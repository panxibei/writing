【XigmaNAS 设置和用户指南】02.安装

副标题：

英文：

关键字：







# 1.安装和配置概述 

`XigmaNAS` 操作系统最好安装在至少一台与存储磁盘分开的设备上。

此设备可以是 `U` 盘、紧凑型闪存或 `SSD` 设备。

从技术上讲，它也可以安装到硬盘驱动器上，但不鼓励这样做，因为该驱动器将无法用于数据存储而浪费了其空间和容量。



你知道吗？

您可以在与实际 `XigmaNAS` 服务器不同的机器上执行安装，以帮助保护您的数据在安装过程中免受意外伤害。

 

 `XigmaNAS` 安装和配置涉及三个步骤，分别是：



**首先**，下载 `XigmaNAS LiveCD (ISO) ` 并将其刻录到 `CD-ROM`，或下载 `LiveUSB` 镜像并将其写入 U 盘。

然后从您刚刚创建的媒体启动。

启动后，通过 `XigmaNAS` 控制台设置菜单完成初始配置。

在此阶段之后，`XigmaNAS` 将安装在您的驱动器上并从您的驱动器上运行。

但是，您仍然需要完成第二步才能使 `XigmaNAS` 运行。

此步骤是可选的：

如果您的系统有 `+2GB RAM` ，您可以从 `CDROM` 和 `MS-DOS` 软盘或 `USB` 设备运行 `XigmaNAS` 来存储配置。

但是我们还是建议执行嵌入式安装。  



**其次**，通过 `WebGUI` 进行基本配置。

[https://www.xigmanas.com/wiki/doku.php?id=documentation:setup_and_user_guide:webgui_interface ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:webgui_interface&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

在此阶段之后，您的 `XigmaNAS` 服务器将具有基本配置即可运行。 



**最后**，通过 `WebGUI` 和 `Command Shell`（主要是 `WebGUI` ）执行高级配置和调整。

本手册的第 `1` 节和第 `2` 节介绍了可以帮助您配置和使用 `XigmaNAS` 的流程和程序。

您可以阅读和理解 `XigmaNAS` 提供的各种选项和功能，并根据自己的需要决定如何使用您的 `XigmaNAS` 系统以及需要采取哪些步骤来实现这些目标。

 然后可以执行进一步的定制，例如 `ZFS` 或 `RAID` 配置、本地化、服务配置和调整。







# 2.将 `XigmaNAS` 与 `CDROM` 和可移动磁盘一起使用（ `LiveCD` 模式）

 您可以通过 `CDROM` 和 **`MSDOS` 格式化过的** 软盘或 `U` 盘来使用 `XigmaNAS` 。 

- 软盘或 `U` 盘必须已经被 `MSDOS` 格式化过（ `XigmaNAS` 不会格式化介质设备）。 

- `XigmaNAS` 将尝试在可移动磁盘根目录下的 `conf` 目录中找到其配置文件 ( `config.xml` )。

  如果没有现成的配置文件，`XigmaNAS` 将重新创建目录 `conf` 并将其配置文件保存在其中。 



*此描述假定 `XigmaNAS` PC 硬件能够从 `CD ROM` 引导并具有用于存储的 `软盘/闪存/usb/hdd` 。*  

确保您计算机的 `BIOS` 配置为首先从 `CDROM` 启动，以防止其他媒体被启动。 

将光盘插入 `CD/DVD` 驱动器，然后启动您的PC。

在 `XigmaNAS` 启动且没有关于 `找不到软盘` 的错误消息后，您可以跳过第 `2.3` 节，直接进入第 `2.4` 节。





# 3.使用 `U` 盘安装嵌入式 `XigmaNAS` 

这是让 `XigmaNAS` 服务器运行的快速方法。

建议使用嵌入式安装，因为它为大多数用户提供了最具弹性的体验。 

要开始使用，您需要两个 `4GB` 或更大的 `U` 盘：

- 一个将在其中写入安装程序镜像。 
- 一个将安装 `XigmaNAS` 并在服务器中用作引导设备。 



## 用法说明

 步骤 1. 创建安装程序 `U` 盘。 

1. 首先，下载最新的 `LiveUSB.img.gz` 安装文件。 

2. 解压缩该文件以获取 `.img`镜像文件。 

   a. 在 `Linux` 下，使用 `gunzip -k filename.img.gz`

3. 将 `.img` 镜像文件写入 `U` 盘。

   a.在 `Linux` 下，使用 `dd if=filename.img of=/dev/sdX bs=4M`

   b.在 `Windows` 下，使用类似于 `Win32DiskManager` 的 `U` 盘工具

 步骤 2. 准备将要安装 `XigmaNAS` 的 `U` 盘。 

1. 使用 `GPT` 分区表的空白 `FAT32` 分区格式化另一个 `U` 盘。 

 步骤 3. 启动服务器。 

1. 最初，仅使用安装程序 `U` 盘引导服务器。 
2. 服务器启动到 `XigmaNAS` 登录屏幕后，插入第二个空 `U` 盘。 
3. 继续后续的安装。





# 将 `XigmaNAS` 安装到磁盘上 

> 警告：`XigmaNAS` 是一个独立的操作系统的 `NAS` 设备。
>
> 安装 `XigmaNAS` 会擦除目标磁盘上的所有现有内容。
>
> 作为安装过程的一部分，现有文件将被删除。 
>
> 
>
> `XigmaNAS` 的安装过程不支持双启动。
>
> 
>
> 不要将 `XigmaNAS` 安装在大于 `2TB` 的磁盘上（ `XigmaNAS` 仅支持将这些磁盘作为“数据”磁盘，而不是作为系统启动磁盘）。 



*此描述假定 `XigmaNAS PC` 硬件能够从 `CD-Rom` 启动并具有启动驱动器（可以是 `USB` 闪存驱动器、`CF` 卡或 `HDD`），并且应该具有一个或多个硬盘驱动器用于存储。*

*下载  `XigmaNAS ISO` 并将镜像刻录到 `CD-Rom` 上。*  

- 将 `XigmaNAS CD` 放入 `CD-Rom` 并从光驱启动（此时不要连接您的闪存设备，直到您看到下面的控制台菜单再连接它，否则 `LiveCD` 会将其默认配置文件写入您的闪存设备的根目录从而导致后续安装失败）。 
- 等到 `XigmaNAS` 控制台设置菜单出现。
- 如果您想将 `XigmaNAS` 安装到闪存设备，现在可以连接它了，`XigmaNAS` 将在屏幕上显示新设备信息，按 `Enter` 键返回控制台菜单。

图a01



- 选择选项 `9` 将在您的硬盘/闪存设备上安装 `XigmaNAS` 。

- 您可以选择安装到单个硬盘驱动器（下面的选择 `2` 或 `3` ），这样就有一个 `XigmaNAS` 引导分区和第二个用于存储数据分区，这两个分区在相同硬盘驱动器上。 



**如果选择 `1` ：**  

```
-------------XigmaNAS Embedded Install Options Menu-------------

1) Install 'Embedded' OS/GPT on HDD/SSD/CF/USB (Preferred)
2) Install 'Embedded' OS/EFI on HDD/SSD/CF/USB (Preferred)
3) Install 'Embedded' OS/MBR on HDD/SSD/CF/USB (Legacy)
4) Install 'Embedded' OS/GPT without SWAP/DATA (For Expert)
5) Install 'Embedded' OS/MBR without SWAP/DATA (For Expert)

             < OK >             < Exit >
```

```
XigmaNAS 'Embedded' installer for HDD, SSD, CF or USB flash drive.

- Create GPT partition 1, for bootcode
- Create GPT partition 2, using UFS, 1024MB size for OS image.
- Create GPT partition 3, as SWAP partition
- Create GPT partition 4, using UFS, for DATA
- Uses a RAM disk to limit read/write access to the device

Warning: There will be some limitations:
1. This will erase ALL partition and data on the destination disk!
             < OK >             < Cancel >
```



此选项会安装 `XigmaNAS` 完全专用于操作系统（该驱动器不能用于存储）。

如果您使用 `CF` 卡、闪存驱动器或 `USB` 密钥，那么这是推荐的选项。 

- 选择源 `CD` 驱动器（例如，如果您只有一个 `ATA CDROM` 驱动器，则选择 `acd0` ）。
- 选择您要安装并启动 `XigmaNAS` 的目标硬盘（例如，如果您想将其安装在 `USB` 密钥上，则为 `da0` ）。

注意：

一些闪存驱动器（比如 `SanDisk Cruzer` 等）预装了一个模拟的只读 `CD-ROM` 驱动器，其中包含制造商提供的数据，应该事先清除这些内容以确保无故障使用。 



**如果选择 `2` 或 `3` ：**

这会将 `XigmaNAS` 安装在驱动器上，并且驱动器的其余部分将被格式化为 `UFS` ，以便通过在驱动器上创建两个分区来用于存储数据。 

- 选择源 `CD` 驱动器（例如，如果您有一个 `ATA CDROM` 驱动器，则选择 `acd0` ）。
- 选择您要安装和引导 `XigmaNAS` 的目标硬盘（例如，如果您想将其安装在 `ATA` 通道 `1` 的主硬盘上，则为  `ad0` ）。 

 

在这两种情况下，一旦安装了 `XigmaNAS` ，请按照说明操作，取出 `CD` ，然后当菜单再次出现时。

- 按下 `ESC` 或选择 `Exit` 并回车退出主菜单 
- 选择 `7` 重新启动计算机



**使用选项 `4` 或 `5` 或 `6` ：从 `CDROM` 升级现有版本**

> 如果您已将它安装在 `USB` 密钥上：确保您的计算机的 `BIOS` 配置为从 `USB 硬盘驱动器` 启动。
>
> 某些 `BIOS` 不支持此功能（应测试 `USB FDD` 或 `USB ZIP` ）。  



第一次启动后： 

- 检查菜单选项 `9)` 是否不再存在：如果是，那么您仍是从 `CDROM` 引导，应当取下安装介质。 
- 转至本文档的 `LAN` 接口和 `IP` 配置部分。 



> `XigmaNAS` 使用 `FreeBSD` 作为底层操作系统，而 `FreeBSD` 并不是 `Linux` ，`FreeBSD` 下的磁盘约定命名如下：
>
> * `/dev/ad0` ：是 `ATA` 通道 `1` 上的第一个 `ATA` 硬盘 
>
> * `/dev/ad1` ：是 `ATA` 通道 `1` 上的第二个 `ATA` 硬盘 
>
> * `/dev/ad2` ：是 `ATA` 通道 `2` 上的第一个 `ATA` 硬盘 
>
> * `/dev/acd0` ：是否检测到第一个 `ATA CD/DVD` 驱动器 
>
> * `/dev/da0` ：是第一个 `SCSI` 硬盘。
>
>   `FreeBSD` 下的 `USB` 密钥设备正在使用 `SCSI` 驱动程序，那么这个名称也可以链接到您的 `USB` 密钥/驱动器。 
>
> * `/dev/da0p1` ：“ **p** ”代表 `EFI/GPT` 分区类型，“ **1** ”代表设备上的第一个分区，这是从版本 `9.0.0.1` 开始的新标准。
>
> * `/dev/da0s1` ：“ **s** ”代表旧的标准分区类型，对于 `UFS` 以外的任何文件系统，您应该寻找一个 's' 类型的分区。 
>
> * `/dev/raid5/RAIDname` ：`RAID` 只是阵列设备。 
>
> * `/dev/raid5/RAIDp1` ：这是 `RAID` 设备上的文件系统。



