XigmaNAS 设置和用户指南（开篇）

副标题：

英文：

关键字：





XigmaNAS 设置和用户指南



本手册的目的是为您提供安装和使用 XigmaNAS 的起点。 本手册的第 1 节和第 2 节介绍了 XigmaNAS 的基本安装，并包括可以帮助您配置和使用 XigmaNAS 中包含的某些服务的流程和程序。 如果您需要知道 *如何做某事* ，您可以在手册的前 2 部分中找到它。  

第 3 节及以后的内容涵盖了 XigmaNAS 的详细信息和更高级的功能。 在这些部分中，您可以找到有关您在 WebGUI 中看到的选项和设置的简要说明。 如果您需要知道 *某物是什么或做什么* ，您可能会在第 3 节或以后的部分找到它。  

XigmaNAS 易于安装、配置和管理。 它可以说是最简单、功能最全的 NAS 操作系统 。 但是，XigmaNAS 不是 [交钥匙系统 ](https://hosteagle.club/wiki/doku.php?id=faq:0128&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)，您是 [OEM ](https://hosteagle.club/wiki/Oem?__cpo=aHR0cHM6Ly9lbi53aWtpcGVkaWEub3Jn)，您必须了解或了解 XigmaNAS 提供的服务和功能，以便您可以有效地使用您的服务器。  



> **在尽可能提供帮助的同时，本手册不会尝试** ： 
>
> - 教你什么是 RAID，如何设置网络或管理防火墙。 
> - 教您系统管理以及如何管理用户和组。 
> - 帮助您选择最好的主板或硬盘控制器等。 
> - 向您展示如何执行许多其他操作，例如如何配置 iSCSI 以与 AD 域中的 ESXi 服务器一起工作。 
>
>  您将需要已经了解此类内容或从其他资源中了解它们。 



## 1 - 简介 

1.  [硬件要求 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:hardware_requirements&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
2.  [限制 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:limitations&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
3.  [获得帮助 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:getting_help&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

## 2 - 安装 

1.  [安装和配置概述 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:installation_and_configuration_overview&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
2.  [将 XigmaNAS 与 CDROM 和可移动磁盘一起使用（LiveCD 模式） ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:using_xigmanas_with_the_cdrom_and_a_removable_disk_livecd_mode&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
3.  [使用 U 盘上的安装程序映像进行嵌入式安装 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:embedded_install_with_installer_image_on_a_usb_stick&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
4.  [在磁盘上安装 XigmaNAS ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:installing_xigmanas_on_disk&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

## 3 - 初始配置 

1.  [LAN接口和IP配置 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:lan_interface_and_ip_configuration&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
2.  [基本配置 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:basic_configuration&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
3.  [网络配置 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:network_configuration&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
4.  [软件 RAID 配置和管理 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:software_raid_configuration_management&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
5.  [ZFS RAID-Z 配置和管理 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:zfs_raid-z_configuration_management&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

## 4 - 访问控制 

1.  [用户和组 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:users_groups&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

## 5 - 状态 

1.  [监控 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:status_status&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
2.  [诊断和日志 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:diagnostics_logs&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

## 6 - 工具 

1.  [工具 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:tools&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
2.  [获得帮助 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:help&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)
3.  [升级 XigmaNAS ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:upgrading_xigmanas&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)

## 7 - WebGUI 

1.  [WebGUI 界面和设置 ](https://hosteagle.club/wiki/doku.php?id=documentation:setup_and_user_guide:webgui_interface&__cpo=aHR0cHM6Ly93d3cueGlnbWFuYXMuY29t)