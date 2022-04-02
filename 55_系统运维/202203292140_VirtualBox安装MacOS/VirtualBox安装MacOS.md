VirtualBox安装MacOS

副标题：

英文：

关键字：









### 先来创建个初始的 `VirtualBox` 虚拟机

使用向导程序新建一个虚拟机，其类型是 `Mac OS X` 、版本是 `Mac OS X (64-bit)` 。

图a01



在`系统` > `主板` 选项卡中，确保芯片组是 `ICH9` 、指点设备是 `USB触控板`，并且最好是启用 `EFI` 。

图a02



在`系统` > `处理器` 选项卡中，切记**不要勾选** `启用嵌套 VT-x/AMD-V` 这一项，处理器数量可以随意。

图a03



显存大小也可以随意，并不需要特意将其设置得很大。

图a04



在 `存储` 一项中，先加载 `Catalina 10.15` 的安装光盘。

随后点击控制器右侧的 `添加虚拟硬盘` 按钮来添加前面我们准备好的 `VirtualBox Boot.vmdk` 虚拟硬盘。

如果是第一次添加虚拟硬盘，则应该点击 `注册(A)` ，然后选择虚拟硬盘文件即可。

如果不是第一次添加虚拟硬盘，则可以直接在列表中选择相应的虚拟硬盘。

图a08

图a05



声音设置保持默认，当然你如果有特殊要求，那么就按实际情况调整设置。

图a06



最后建议将 `USB设备` 设定为 `USB 3.0 (xHCI) 控制器` 。

图a07



### 打磨一下这个虚拟机

前面我们新建了一个对于安装 `Catalina` 的虚拟机，可是这个虚拟机虽然它的类型是支持 `Mac OS X` ，但其实它还不能直接上手安装，直接上手是不会成功的。

那我们怎么办呢？

其实它还需要我们再打磨一下就可以用来安装 `Catalina` 了。

好了，我们下面就动手把它打磨一番吧！



以管理员身体运行一个 `cmd` 命令提示窗口，然后依次运行下面的命令。

```
# 命令中的 MacOS 为虚拟机的名字，请根据情况修改为虚拟机实际的名称。
cd %ProgramFiles%\Oracle\VirtualBox\
VBoxManage modifyvm "MacOS" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal©AppleComputerInc"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
```



经过这样的修改，我们就可以顺利安装上 `Catalina` 了。

如果在启动安装时失败，我们可以回过头来重新按顺序一行一行的执行这些命令，确保运行无误。



### 开始安装 `Catalina`

前面一切准备就绪后，我们就可以正式开始安装 `Catalina` 了。

启动顺利的话，我们应该可以看到如下启动画面。

图b01



根据机器性能不同系统启动的速度也不同，可能需要多等待一会儿，启动加载一段时间后我们就能看到苹果的Logo。

图b02



再过一会儿，`macOS实用工具` 界面就会呈现在我们面前。

图b03



能看到这个 `macOS实用工具` ，就说明我们可以真正地开始安装进程啦！

在将 `Catalina` 安装到磁盘上之前，我们需要初始化磁盘以便匹配 `macOS` 系统格式，因此我们先点击 `磁盘工具` 。

图b04



在 `磁盘工具` 界面中，我们在左侧找到目标磁盘，然后点击 `抹掉` 按钮开始初始化磁盘操作。

图b05



默认系统格式为 `Mac OS扩展（日志式）` ，直接按下抹掉即可。

图b06



磁盘初始化完成后，点击完成并关闭 `磁盘工具` 窗口。

图b07



我们返回到 `macOS实用工具` 的主界面，接下来就可以点击 `安装macOS` 正式开始安装 `Catalina` 了。

图b08



同意协议以继续安装进程。

图b09



点选刚才初始化OK的磁盘，并点击 `安装` 按钮。

图b10



接下来就坐等它将系统安装到磁盘上。

图b11

图b12





