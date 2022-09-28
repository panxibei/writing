【XigmaNAS 设置和用户指南】03.初始配置

副标题：

英文：

关键字：





 # 1.`LAN` 接口和 `IP` 配置

一旦你将 `XigmaNAS` 安装到了 `CF` 、 `HDD` 或 `USB` 驱动器上，电脑设备就会从这些设备上重新启动。

你首先应该登录控制台：

```
#login:
```

默认登录 `XigmaNAS` 控制台的帐户和密码：

```
username:root
password:xigmanas
```

```
Console Menu
------------
1) Configure Network Interfaces    10) Configure Hosts Allow for WebGUI
2) Configure Network IP Address    11) Restart WebGUI
3) Reset WebGUI Password           12) Resart WebGUI. force HTTP on port 80
4) Reset to Factory Defaults       20) Console Keyboard Map
5) Ping Host
6) Shell
7) Reboot Server
8) Shutdown Server

Enter a number:
```



默认配置的 `XigmaNAS` 会使用第一检测到的 `NIC` (网卡)并将其 `IP` 地址设置为 `192.168.1.250` 。

* 选择 `1` 并输入网卡接口名称（我这边是 `fxp0` ,可能和你的不同) 

* 在可选项 `1` 接口提示时按下回车，选择 `y` 并设定接口

* 选择 `2` 并选择是否使用 `DHCP` 。

  如果不启用，请输入您的 `IP` 地址设置（以我为例：`192.168.8.128` 和 `/24` ）以及合适的网址。

* 一旦控制台菜单有效，选择 `5` 并 `ping` 另一个子网上的设备以确保网络连接可靠（请牢记，你无法 `Ping` 通一台受个人防火墙保护的电脑），请先禁用防火墙。 

  

> `FreeBSD` 不使用通用网络接口名称，比如像 `Linux` 的 `eth0` 。
>
> 这些网络接口名称取决于使用的驱动程序：
>
> * `fxp0` ：发现的第一个英特尔 `EtherExpress` 芯片组网络适配器
> * `fxp1` ：发现的第二个英特尔 `EtherExpress` 芯片组网络适配器
> * `bge0` ：发现的第一个博通 `BCM570XX` 千兆网络适配器
> * `nve0` ：发现的第一个 `nVidia nForce MCP` 芯片组网络适配器
> * 以此类推... 

   

> 警告：`fwip0 & fwe0` 是火线端口。
>
> 如果你在端口列表中看到了 `fwip0` 或 `fwe0` ，**不要使用它**。
>
> 更合理的做法是，如果你并不使用任何这些端口则最好在 `BIOS` 中关闭火线。 



* 相较于 `cpu` 和内存性能 `XigmaNAS` 在传输速率上更加依赖于网络的传输速度。

* 如果你感觉传输速率缓慢，请直接使用交叉网线连接 `NAS` 和电脑。

  速度和双工设置可以随后进行调整，以便与计算机直接连接测试。



> `NAS` 所连接的交换机需要所有的端口都设定为自动协商。
>
> 交叉网线将允许你在测试/排除和绕过交换机可能带来的瓶颈问题。



# 2.基本配置

### 默认的登录名称和密码

如果你可以从 `XigmaNAS` 服务器 `Ping` 通另一台设备，然后在另一台位于相同子网的计算机上打开网络浏览器，输入 `XigmaNAS` 服务器的 `IP` 地址（例如 `http://192.168.8.128` ），你应该能看到一个用户名/密码对话框像图片显示的这样。  

图a02



在登录名/密码对话中输入：

1. 默认的用户名是 `admin`
2. 默认的密码是 `xigmanas`
3. 按下 `Login`



>  `XigmaNAS` 团队强烈建议在将 `XigmaNAS` 作为生产使用之前应该修改默认的用户名和密码。 



你应该会在下一页看到 `XigmaNAS` 的 `GUI` 系统状态页。

当前页面会加载 `XigmaNAS` 的版本以及其他有用的信息。



### `WebGUI` 布局

`XigmaNAS` 网页配置导航树在左侧页面，同时展示以及数据输入区域在右侧导航树。

`XigmaNAS` 主机名称显示在这里以及其他所有 `WebGUI` 页面。

当管理多台 `XigmaNAS` 时这是非常有用的。  



>  这个 `XigmaNAS` 主机名称可在常规设置页面修改。 

图a03



在展示数据输入区域的页面中，一些展示具有附加控制特性，如下所示：

图a04 - 添加一个元素

图a05 - 删除一个元素

图a06 - 允许用户编辑一个元素



###  控制台/SSH管理的默认登录名和密码(高级) 

系统将要求登录用户名，然后回车，它将再次询问对应的密码，如下所示。

图a07



在登录密码提示时输入：

1. 默认用户名为 `root`
2. 默认密码为 `xigmanas`
3. 按下回车



### 控制台菜单布局

图a08



 控制台菜单是自我注释的，只需选择一个数字并按下回车，然后按照下一步对话说明即可（如果有的话）。 

>  控制台菜单默认情况下不在 `SSH` 连接时提供使用，但它可以使用命令 `/etc/rc.initial` 直接调出，如下所示。 



```
Last login: Sun Apr 12 10:37:15 2020
Welcome to XigmaNAS!
xigmanas: ~# /etc/rc.initial

Console Menu
------------
1) Configure Network Interfaces    10) Configure Hosts Allow for WebGUI
2) Configure Network IP Address    11) Restart WebGUI
3) Reset WebGUI Password           12) Restart WebGUI, force HTTP on port 80
4) Reset to Factory Defaults       20) Console Keyboard Map
5) Ping Host                   
6) Shell
7) Reboot Server
8) Shutdown Server

Enter a number:
```



# 3.网络配置

*其中很多应该由您的网络管理员（可能是您自己）确定。*

您有责任了解和理解在您的网络中使用正确或适当的设置。

未能使用正确的设置可能会导致您的 `XigmaNAS` 服务器运行缓慢、不正确或根本不运行。

*您有责任了解如何管理您的网络并了解您环境中的正确设置*。

**您的**网络**或** `XigmaNAS` 中的不正确设置可能会对其他网络设备/服务的性能产生不利影响或完全阻止它们工作，因此在向其添加任何新设备或服务之前，请确保您了解您的网络。



### 网络|接口管理：

初始安装后，您的网络适配器应该已经从控制台进行了配置。

大多数情况下，网络设置为 `auto` ，它会检测到正确的网卡/驱动程序。

如果没有，您应该能够在此屏幕上配置它们。



### 网络|局域网管理：

在此屏幕上，您可以配置：

- 使用 `DHCP` 或静态 `IP` 配置
- 网关，最重要的设置之一，这应该已经在初始设置期间进行了配置。
- 是否使用 `IPv6`
- `MTU`
- 媒体类型（`10baseT`、`100baseTX`、`1000baseTX`、`1000baseSX` 或自动选择 `autoselect`）



### 系统|一般设置：

在这里你要填写：

- 主机名
- 域名
- `IPv4` 和/或 `IPv6` `DNS` 服务器（如果使用静态 `IP`，否则会被锁定）



您还可以修改（如果需要）：

- `WebGUI` 默认用户名
- `HTTP` 或 `HTTPS`
- `WebGUI` 端口
- `HTTPS` 证书（如果使用 `HTTPS` ，否则不显示）如果您没有提供证书，`XigmaNAS` 将为您自动创建一个。
- 私钥（用于 `SSH` 机器身份验证）
- 语言（默认为英语）
- 时区和系统时间（或使用时间服务器）



### 系统|常规|密码：

在这里，您可以替换默认密码。





# 4.软件 RAID

> 如果您的硬件有足够的内存来使用 `ZFS` ，那么您应该使用 `ZFS` ，而不是任何其他形式的软件或硬件 `RAID` 。
>
> 软件和硬件 `RAID` 并不提供类似于 `ZFS` 冗余和校验的那种强大的数据保护。
>
> `ZFS` 校验和在块级别完成，可以透明地检测和修复 `bitrot` 。
>
> 软件和硬件 `RAID` 不提供这些块级保护。
>
> 软件和硬件 `RAID` 会不知不觉地将损坏的数据传递给系统，并且系统没有任何机制来响应“此数据已损坏，请咨询 `RAID` 的其他部分”。
>
> 您可以使用软件或硬件 `RAID` ，但是你被警告时已经出错了。



`XigmaNAS` 支持软件 `JBOD`、`RAID 0`、`1` 和 `5` 配置以及硬件 `RAID`。

本节介绍如何配置软件 `RAID 5` 。

除了使用 `geom` 之外，其他所有过程几乎相同。



这是 `FreeBSD` 模块名称和等效名称：

- `JBOD`：磁盘簇
- `RAID 0`：条带
- `RAID 1`：镜像
- `RAID 5`：阵列 `RAID5`（感谢 `Arne` 开发了这个非官方的 `FreeBSD` 模块！！）



除了` JBOD` 和 `RAID5`（它将基于最小的磁盘）之外，所有 `RAID` 类型的所有磁盘都必须具有相同的大小。



> 重要：
>
> `RAID` 不等于备份。
>
> 即使您创建了一个 `RAID` 阵列，您仍然必须在不同的 `__cpLocation` 中保留另一个数据副本。



`XigmaNAS` 团队建议首先将每个 `RAID` 磁盘配置为独立的存储磁盘，以确保它们在 `XigmaNAS` 下完全正常运行并受支持。

确认后，移除 `RAID` 驱动器的任何挂载点和磁盘，以确保干净启动。

以下描述假定驱动器已被确认为正常工作。



配置简单 `RAID` 阵列的高级流程是：

1. 添加磁盘
2. 为 `软件 RAID` 格式化磁盘
3. 使用先前格式化为 `软件 RAID` 的方式创建 `RAID` 阵列
4. 在 `UFS` 文件系统中格式化新创建的 `RAID` 阵列
5. 添加挂载点
6. 启用服务（`CIFS`、`FTP`等）
7. 对于 `CIFS`，您必须创建共享 *share* 。



>  **要移除 `RAID` 阵列，请先移除挂载点并删除 `RAID`。** 



## 添加磁盘

按照上述添加磁盘过程添加要在 `RAID` 阵列中使用的每个磁盘。

在下面的示例中，我添加了 `4` 个相同大小的硬盘驱动器。

图a09



确保驱动器处于联机状态。 



> 您不能将 `XigmaNAS` 引导驱动器的第二个分区用作 `RAID` 阵列的一部分。
>
> 只能使用整个磁盘来组成 RAID 阵列。 



## 准备（格式化）磁盘

打开 `Disk|Format` 选项卡，依次选择每个 `Disks` 并确保 `File system` 更改为 `Software RAID` ，单击 `Format Disk` 按钮并确认您的操作。

图a10



对要在 `RAID` 阵列中使用的所有磁盘重复此操作。

结果应该是这样：

```
Erasing MBR and all partitions:
Creating one partition:
******* Working on device /dev/ad1 *******
Initializing partition:
Destroying old GMIRROR information:
Done!
```



## 创建软件 RAID 阵列

打开 `Disks/Software RAID` 页面并选择您的软件 `RAID` 类型。

对于我们的示例，我们选择 `Geom RAID5` ：

图a11



单击右侧的加号 `+` 图标以添加新的 `RAID 5` 。

输入 `RAID` 的阵列名称。

单击并选择要在此 `RAID` 阵列中使用的每个驱动器。

图a12



>  驱动器不会出现在此处，除非它们之前已格式化为软件 `RAID` 。



 单击“*添加*”按钮，并在出现提示时单击“应用更改”按钮。 

图a13



创建 `RAID 5` 阵列可能需要很长时间：

**但是您可以在构建过程中使用您的阵列！（即使它处于 `REBUILDING` 状态）。**

状态字段不会立即更新。



## 格式化软件 `RAID` 阵列

当状态为 `up` 或正在重建时，必须格式化 `RAID` 阵列。

打开 `Disk|Format` 菜单并选择新创建的 `RAID` 阵列：

图a14



将类型保留为 `UFS`（`GPT` 和软更新），单击格式化磁盘按钮并确认。

应该输出与此类似的显示信息（例如，当 `RAID 5` 处于“重建”状态时）：

图a15



（在这个示例中，你可能会看到更多行的内容！本例驱动器只有 `200MB` ）



## 创建挂载点

一旦 `RAID` 阵列被格式化，剩下的就是安装阵列。

打开 `Disk|Mount Point` 页面并单击右侧的加号 `+` 图标。

图a16



从 `Disks` 下拉列表中，选择 `RAID` 磁盘。您之前配置的 `RAID Name` 可见。

*将分区* 更改为 `EFI – GPT` 。

输入有用的共享名称，然后单击添加按钮。

状态应显示为正在配置，然后单击应用更改按钮，状态应更新为 `UP` 。

图a17



您的 `Geom RAID5` 阵列现在可以使用了。如果您已启用 `CIFS` 、`FTP` 或 `NFS` ，则具有已定义共享名称的阵列将在您的网络中可见。

## 软件 RAID 阵列状态

您可以通过以下方式验证 RAID 阵列的状态：

- *状态/磁盘*页面并选择*信息*选项卡
- *Disks/Software RAID/geom used*页面并选择*Information*选项卡。

一个健康的 RAID 阵列将显示所有状态：值为 UP 或 COMPLETE。



> RAID 1 和 RAID 5 阵列可能需要一些时间才能完全同步，请耐心等待并通过继续刷新信息页面来监控 RAID 同步的状态。



## 更换 gmirror 阵列上的故障硬盘驱动器

> 注：
>
> 常见问题解答中提供了有关移除/更换 SoftRAID1 和 SoftRAID 5 阵列中故障驱动器的补充分步说明：
>
> * 如何移除/更换 SoftRAID1 阵列中的磁盘？
> * 如何移除/更换 SoftRAID5 阵列中的磁盘？



如果一个硬盘驱动器发生故障，您的 RAID 阵列处于“DEGRADED”状态：

这是一个名为“mirroire”的 RAID 1 阵列处于“DEGRADED”状态且缺少硬盘的示例：

图a18



 我们可以在磁盘/管理页面检查磁盘是否丢失： 

图a19



我们可以看到，在我们的示例中，磁盘 da1 丢失了。



### 第一步

更换此磁盘：停止 XigmaNAS 并用新磁盘替换此磁盘（在 ATA 或 SCSI 通道上的相同位置）。并重新启动 XigmaNAS。

重新启动 XigmaNAS 后，磁盘/管理应将其显示回来（如果它相同，则为 ONLINE，如果它是不同的磁盘，则为 CHANGED）。

软件 RAID 1 状态仍然是“DEGRADED”，我们必须添加这个新磁盘：



### 第二步

打开*磁盘/软件 RAID/Geom 镜像/工具*页面并选择您的 DEGRADED RAID 阵列和*操作“忘记”*（第一个操作不使用磁盘字段）。

图a20



### 第三步

仍然在此*磁盘/软件 RAID/Geom 镜像/工具*页面上，重新选择您的 DEGRADED RAID 阵列，选择新更换的磁盘，然后选择*操作“插入”*：

图a21



 您现在可以检查您的 RAID 状态（磁盘/软件 RAID/Geom 镜像）：它应该是“REBUILDING”或“COMPLETE”（重建所需的时间取决于您的磁盘大小）。 

图a22



您也应该检查磁盘/安装状态，因为有时需要重新安装。



## 更换 graid5 阵列上的故障硬盘

如果一个硬盘驱动器发生故障，您的 RAID 阵列处于“DEGRADED”状态。

以下是 RAID 5 阵列“bigdisk”缺少硬盘的示例：

图a23



 并且磁盘丢失： 

图a24



### 第一步

更换此磁盘：停止 XigmaNAS 并用新磁盘替换此磁盘（在 ATA 或 SCSI 通道上的相同位置）。并重新启动 XigmaNAS。

重新启动 XigmaNAS 后，磁盘/管理应将其显示回来（如果它相同，则为 ONLINE，如果它是不同的磁盘，则为 CHANGED）。

软件 RAID 5 状态仍然是“DEGRADED”，我们必须添加这个新磁盘：

### 第二步

打开 Disk/Software RAID/Geom Raid5/Tools 页面并选择您的 DEGRADED RAID 阵列，替换的磁盘名称和操作“插入”。

图a25



 您现在可以检查您的 RAID 状态（磁盘/软件 RAID/Geom raid5）：它应该是“REBUILDING”或“COMPLETE”（重建所需的时间取决于您的磁盘大小）。 

图a26



您也应该检查磁盘/安装状态，因为有时需要重新安装。



## 使用 geom vinum 的软件 RAID 配置

Geom Vinum 多合一模块允许您创建软件 RAID 0、1 和 5 阵列。但是，目前 XigmaNAS 团队不建议您使用它，因为太多用户在使用此工具的 RAID 5 选项时遇到了问题。



## 复杂的软件 RAID 组合（RAID 1+0、5+0 等）

XigmaNAS 允许您创建高级软件 RAID 组合，例如：

- RAID 1+0：允许您使用 RAID 1 阵列创建 RAID 0 阵列
- RAID 5+0：允许您使用 RAID 5 阵列创建 RAID 0 阵列
- RAID X + Y：允许您使用 RAID X 阵列创建 RAID Y 阵列



配置复杂 RAID X + Y 阵列的高级流程为：

1. 添加磁盘（RAID 1+0 最少 4 个磁盘，RAID 5+0 最少 6 个磁盘）
2. 为“软件 RAID”格式化磁盘
3. 使用先前格式化为“软件 RAID”的方式创建 RAID X 阵列
4. 为“软件 RAID”格式化新创建的 RAID X 阵列
5. 使用以前格式化为“软件 RAID”的 RAID X 阵列创建 RAID Y 阵列
6. 添加挂载点
7. 启用服务（CIFS、FTP等）