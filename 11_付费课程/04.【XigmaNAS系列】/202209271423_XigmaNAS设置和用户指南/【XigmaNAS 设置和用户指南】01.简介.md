【XigmaNAS 设置和用户指南】01.简介

副标题：

英文：

关键字：



## 1 - 简介 

1.  [硬件要求 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:hardware_requirements&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
2.  [限制 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:limitations&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
3.  [获得帮助 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:getting_help&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)



`XigmaNAS` 可以被安装到各种硬件上，包括并不限于从实体服务器到老旧闲置 `PC` 的任何东西！ 



# 1.硬件要求 

- 多核 `64` 位处理器 
- 一台 **至少 `8GB RAM`（推荐 `ECC`）**，并且附加可引导 `CD-ROM` 驱动器的 `PC` ： 
  - 一张软盘/`U` 盘（用于配置存储）和一个或多个硬盘驱动器（用于存储） 
  - 可引导的 `U` 盘或 `CF` 卡（嵌入式 `embedded` 或完整 `full` 安装最低需 `4GB` 容量，但是**不建议**完整 `full` 使用 `CF` 卡或 `U` 盘），并使用 `1` 个或多个硬盘驱动器进行数据存储。 
  - 一个可启动硬盘和一个或多个硬盘用于存储 
  - 一个可引导的硬盘驱动器（将分区为 `XigmaNAS` 系统和数据分区） 
- 或者如上配置的 `VMware/QEMU` 等虚拟机



注意：

当 `XigmaNAS` 安装在可引导的 `USB` 驱动器、`CF` 驱动器或硬盘驱动器上时，应在安装 `XigmaNAS` 后移除可引导的 `CD-ROM` 。

目前从 `LiveCD/LiveUSB` 安装 `XigmaNAS` 是唯一支持的方法。



警告！ 

- `2GB` 的 `RAM` 是运行无交换的绝对最低要求。 
- 升级嵌入式版本至少需要 `512MB` 的可用 `RAM` 。 
- 使用高级特性和开启许多功能可能需要更多 `RAM`（ `4GB` 或更多）。 
- 对于 `ZFS` ，我们建议至少 `8GB RAM` 以获得更高的系统性能。 



**充分利用系统的最佳方法是安装尽可能多的系统 `RAM` ！**  





# 2.限制 

 以下是 `XigmaNAS` 的一些限制事项： 

- 通过 `LAN` 访问微软 `Windows` 共享并不会影响存储驱动器的本地系统格式。 

- `ZFS` 和 `UFS` 是 `XigmaNAS` 的默认初始文件系统，不建议使用其他文件系统进行数据存储。 

- 几乎每个系统都建议使用 `ZFS` 而不是 `UFS` 。

  `UFS` 不包含 `ZFS` 包含的任何更强大的功能，尤其是校验和，如果 `ZFS` 池包含冗余，它将检测 `bitrot` 并纠正它。

  通常不鼓励使用 `UFS` 。 

- `FAT` 、`NTFS` 和 `EXT2/3` 只能用于将数据批量传输到 `UFS` 格式的驱动器。 

- 在低于 `9.0` 的 `XigmaNAS` 版本中，仅支持 `Inode` 大小为 `128` 字节的 `EXT2/3` 修订版 `0` 。

  修订版 `1` 使用 `256` 字节的 `inode` 大小，`FreeBSD 8.2` 以下版本不支持。

  创建` ext2/3` 分区时，通过 `-I 128` 使用 `128`  字节可以解决此问题，但文件系统永久处于 `not clean` 状态。 

- 支持 `SCSI` 、`PATA (IDE)` 、`SATA` 、`CF` 和 `USB` 驱动器。 

- `XigmaNAS` 的引导驱动器分区不能用作任何 `RAID` 阵列的一部分，只能使用其他整个磁盘来组成 `RAID` 阵列。 

- `USB` 驱动器可以热插拔，但外部新接入的 `USB` 驱动器需要添加和挂载操作，然后才能使用，如本指南后面所述。 

- 任何驱动器（ `USB` 、`ZIP` 、`CD-ROM` ）在移除之前必须先卸载，否则可能会造成系统重启。 



主要 `FreeBSD`（ `XigmaNAS` 底层操作系统）早期 `BUG` ：

已知使用 `CIFS/SMB` 读取/写入 `FAT32` 驱动器分区上的任何文件将会损坏文件！ 



# 3.获得帮助 

 有关技术问题，请按顺序查阅以下链接：  

1. 阅读和搜索 wiki [Wiki ](https://hosteagle.club/wiki/?__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)。 
2. 阅读 [常见问题解答 ](https://hosteagle.club/wiki/doku.php?id=documentation:faq&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)。 
3. 搜索论坛 [XigmaNAS 论坛 ](https://hosteagle.club/forums/?__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)。 
4. 访问 xigmanas IRC -Channel FreeNode [IRC 频道 #xigmanas ](https://hosteagle.club/?channels=&__cpo=aHR0cHM6Ly93ZWJjaGF0LmZyZWVub2RlLm5ldA#xigmanas)，也许其他用户可以帮助您。 

