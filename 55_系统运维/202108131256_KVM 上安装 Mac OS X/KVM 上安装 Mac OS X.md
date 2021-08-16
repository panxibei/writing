

标题：KVM 上安装 Mac OS X 到底难不难？

副标题：让你的 KVM 彻底爱上黑苹果~

英文：how-to-install-mac-os-x-on-kvm

关键字：mac,macos,os,macosx,osc,kvm,linux,imac,qemu,hackintosh



由于最近某些测试需要在 `Mac OS X` 上做，但是手头上又没有苹果电脑，怎么办？

有人很快会想到黑苹果，这倒是个不错的主意，可是并不是什么电脑都能安装上的。

我这儿一堆的烂机器，装个 `Windows` 还能凑合用用，但黑苹果可就没那么容易给安上了。

于是只好转向虚拟机，看看虚拟机上是否有门儿。



众所周知，虚拟机主流的就那么几种，无非 `VMWare` 、`VirtualBox` 或 `KVM` 等等。

前两者都能通过一定的方法成功安装上 `Mac OS X` ，可是这次不一样了，我必须在 `KVM` 上安装，因为我只有一台安装 `KVM` 的机器可用。

并且我希望这个系统能不停机长期运行（测试需要嘛），所以我放弃了在自己电脑上安装的念头。

好吧，那我们就尝试尝试在 `KVM` 上安装 `Mac OS X` 系统吧！

（使用黑苹果 `Hackintosh` 可能涉嫌违反相关用户协议，本文仅出于测试目的，违法乱纪的事咱不干哈，还请各位小伙伴以学习为目的注意规避风险。）



最初我可能像很多小伙伴一样，试着直接用 `KVM` 生成一个 `macOS` 虚拟机，无奈根本就启动不了。

还好网上有不少关于如何在 `KVM` 上安装 `Mac OS X` 的文章，拜读过后其中又有很多文章内容都指向了一个 `GitHub` 的开源项目：`OSX-KVM` 。

> 官网链接：https://github.com/kholia/OSX-KVM



官网上虽然有安装方法，我也看了不少相关的介绍文章，但是总感觉有些笼统又显得不太灵活好用，对我等小白也不够友善。

我研究了好几天，天不负我终于研究出来可以自己想怎么安装就怎么安装的方法了。



### 先决条件

先简单介绍一下官网给出的先决条件。

- KVM 必须安装在较新版本的 Linux 上，比如 Ubuntu 20.04 LTS 64-bit 或更新
- QEMU 版本 >= 4.2.0
- A CPU with Intel VT-x / AMD SVM support is required (`egrep '(vmx|svm)' /proc/cpuinfo`)
- A CPU with SSE4.1 support is required for >= macOS Sierra
- A CPU with AVX2 support is required for >= macOS Mojave



我的测试机信息如下：

* `CentOS` 7.6 内核 3.10
* `Python` 3.6.8
* `QEMU` 6.0.91
* `libvirt` 5.2.0
* `virt-manager` 3.2.0



此处要强调一下，由于 `OSX-KVM` 中的脚本需要 `Python3` ，所以需要我们事先安装好它。

另外 `QEMU` 可能也要升级到 `4.2.0` 以上，这些都需要我们自己先安装准备妥当，具体方法就不再赘述了。



### 官网建议步骤

官网上有相应的步骤，非常简单，我们照着做就是了。

可是正是因为太简单了，所以我在照猫画虎的时候踩了不少坑，摔得鼻青脸肿。



我先将官网的步骤简化如下：

```
# 创建一个名为 sysadm 的目录，然后将 OSX-KVM 克隆到这个目录中
mkdir /sysadm
cd /sysadm
git clone --depth 1 --recursive https://github.com/kholia/OSX-KVM.git
cd OSX-KVM
```



```
# 获取安装介质
./fetch-macOS-v2.py

# 选择1-4下载相应安装介质，默认名称为 BaseSystem.dmg
$ ./fetch-macOS-v2.py
1. High Sierra (10.13)
2. Mojave (10.14)
3. Catalina (10.15) - RECOMMENDED
4. Latest (Big Sur - 11)

Choose a product to download (1-4): 3
```



```
# 安装介质下载好后，将其转换为可用的格式
qemu-img convert BaseSystem.dmg -O raw BaseSystem.img
```



```
# 创建一个目标磁盘文件用于安装
qemu-img create -f qcow2 mac_hdd_ng.img 128G
```



```
# 开始安装
./OpenCore-Boot.sh
```



官网克隆可能会很慢甚至中断失败，可以在这里直接下载下来用。

**OSX-KVM.zip(15.6M)**

下载链接：



**1. High_Sierra_10.13.dmg(463M)**

**2. Mojave_10.14.dmg(458M)**

**3. Catalina_10.15.dmg(475M)**

**4. Big_Sur_11.0.dmg(637M)**

***切记：需要将它们转换成 `img` 后才能加载使用！***

下载链接：



如果不出意外的话，当你运行安装命令后，就会看到 `macOS` 加载启动后的画面，接下来就可以开始你的安装了。

正如你们看到的，上面一共就五个步骤，意思也不难理解，很简单很方便对吧？

不过嘛，越是简单方便越有可能遇到不可描述的问题。

虽然只要准备工作足够充分，官网的步骤也没啥大问题，但是就这么安装好似乎感觉少了点儿什么。

没错，要是我想定制它，或者多装个几台，那我又该怎么办呢？

于是我决定进一步搞懂它！



### 寻找官网步骤实现的原理

既然它是通过一个脚本启动安装的，那我就先研究研究这个脚本吧。

我打开 `OpenCore-Boot.sh` ，原来它就是一个将各种参数组合在一起的 `qemu-kvm` 命令。

虽然我不太懂这些命令，但我知道肯定是哪些参数起到了作用，于是我特意将这些参数仔细看了又看。



我平时喜欢通过图形界面 `virt-manager` 来操作虚拟机，如果我每次都要用一条命令来启动虚拟机的话，那还是不太方便啊。

于是我想到了能不能实现将命令转成 `xml` ，这样我就可以导入到我的虚拟机列表中了。

可我找了半天也没有结果，不过幸运的是，我在 `OSX-KVM` 目录中发现了一个名为 `macOS-libvirt-Catalina.xml` 的文件。

这个有可能是一个模板文件啊，好了，接下来就对它做个解剖吧。

没想到真的被我猜到了，于是我就依照这个文件生成了我自己定制化的文件。



### 将官网方法进一步简化

在制作定制化配置文件的时候需要注意有几个地方可以修改，其他地方千万不要乱动。

我先介绍一下修改的方法，在后面会有一个完整版的 `xml` 文件分享给小伙伴们下载。



##### 1、虚拟机名称及 `UUID`

注意修改以下标记内容，如果有多台 `macOS` 那么  `UUID` 不可重复。

```xml
<name>macOS</name>
<uuid>2aca0dd6-cec9-4717-9ab2-8b7b13d131c6</uuid>
<title>macOS</title>
```



##### 2、启动关键点

安装启动的关键，是通过 `OpenCore.qcow2` 映像 `EFI` 方式加载 `BaseSystem.img` 安装映像。

除去它们的顺序不能搞错以外，实际上安装映像是可以定制的，换句话说，这个 `BaseSystem.img` 是可以换成其他的安装介质，甚至可以换成光盘。

我试过几个我以前测试用的 `ISO` 文件都可以正常启动，但版本太低的似乎就不支持了。



有了 `EFI` 启动，又有了安装映像，那么自然还要添加我们的目标磁盘，有了至少这三样我们就完美了。

具体可以参考如下代码，其中的 `OSX-KVM` 目录以及目标磁盘文件的路径可自行修改。

```xml
<disk type="file" device="disk">
    <driver name="qemu" type="qcow2" cache="writeback" io="threads"/>
    <source file="/your_path_for_osx/OSX-KVM/OpenCore-Catalina/OpenCore.qcow2"/>
    <target dev="sda" bus="sata"/>
    <boot order="1"/>
    <address type="drive" controller="0" bus="0" target="0" unit="0"/>
</disk>
<disk type="file" device="disk">
    <driver name="qemu" type="raw" cache="writeback"/>
    <source file="/your_path_for_osx/OSX-KVM/BaseSystem.img"/>
    <target dev="sdb" bus="sata"/>
    <boot order="2"/>
    <address type="drive" controller="0" bus="0" target="0" unit="1"/>
</disk>
<disk type="file" device="disk">
    <driver name="qemu" type="raw" cache="writeback" io="threads"/>
    <source file="/your_path_for_macosx_img/MacOSX.img"/>
    <target dev="sdc" bus="sata"/>
    <boot order="3"/>
    <address type="drive" controller="0" bus="0" target="0" unit="2"/>
</disk>
```



##### 3、关于网卡的破事儿

没有网络，安装程序从一开始就没办法进行下去，所以必须保证网络正常。

而要保证网络正常，自然就要我们正确配置好网卡。

以下代码描述了可正常工作的网络配置，切记不要随意更改网卡名称，因为可能会导致网桥设备发生变化而使网卡变得无效。



```xml
<!-- 网桥设备 -->
<controller type="pci" index="0" model="pcie-root"/>
<controller type="pci" index="1" model="dmi-to-pci-bridge">
	<model name="i82801b11-bridge"/>
	<address type="pci" domain="0x0000" bus="0x00" slot="0x1e" function="0x0"/>
</controller>
<controller type="pci" index="2" model="pci-bridge">
	<model name="pci-bridge"/>
	<target chassisNr="2"/>
	<address type="pci" domain="0x0000" bus="0x01" slot="0x00" function="0x0"/>
</controller>
<controller type="pci" index="3" model="pcie-root-port">
	<model name="ioh3420"/>
	<target chassis="3" port="0x10"/>
	<address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
</controller>

......

<!-- 网卡配置 -->
<interface type="bridge">
    <mac address="52:54:00:88:88:88"/>
    <source bridge="virtbr0"/>
    <target dev="tap0"/>
    <model type="vmxnet3"/>
    <address type="pci" domain="0x0000" bus="0x02" slot="0x01" function="0x0"/>
</interface>
```



**完整版 `xml` 配置文件下载：**

**MacOSX.xml.zip(29.9K)**

下载链接：



好了，我们有了按我们自己需求定制的配置文件，接下来就可以通过以下命令将其导入成我们随时都可以用图形界面来管理的虚拟机了。

```
# 根据 xml 配置文件定义虚拟机
virsh define MacOSX.xml
```

注意：如果要建立多台虚拟机，别忘记修改 `UUID` 。



### 有一些坑

看到这儿，或许很多小伙伴自信满满，坚信自己可以成功安装 `macOS` 。

呵呵，放心，我可以保证你没那么顺利，哈，抱歉有点泼凉水的味道啊！

不过至少我是遇到了不少坑，先捡一些折磨我很痛苦的来说吧。



我在升级完 `QEMU` 后，会遇到如下报错。

```
GLib-WARNING **: gmem.c:489: custom memory allocation vtable not supported
```

有人说是无法自定义内存分配，明明以前都好好的，怎么就无法了？

找到一个链接，进去看一看。

> https://bugzilla.redhat.com/show_bug.cgi?id=1666811



让我这样试一试。

```
# 将 `/usr/libexec/qemu-system-x86_64`
<emulator>/usr/libexec/qemu-system-x86_64</emulator>

# 替换成 `/usr/bin/qemu-kvm`
<emulator>/usr/bin/qemu-kvm</emulator>
```

那位说这不一样的嘛，起初我也是这么想的，然而没想到我替换后问题居然解决了，就是这么神奇哈！

图01



### 安装过程简述

有的小伙伴说了，你真的成功了吗？

的确，无图无真相，网上有的文章写得不详细，图片也没有一个，肯定没啥说服力啊。

我不一样，我不但啰嗦，我还有大把的图片啊，开整！



1、正确启动，看到那个叫作 `macOS Base System` 的启动项了没，那个就是 `BaseSystem.img` 。

图02



2、选择 `macOS Base System` ，加载安装程序。

图03

图04



3、选择 `Disk Utility` 磁盘工具，格式化目标磁盘。

图05

图06



4、关闭磁盘工具，回到安装程序，再次选择重新安装 `macOS` 。

图07



5、选择格式化好的磁盘，正式开始安装了。

图08

图09



6、安装完成后，再次启动时选择目标磁盘启动。

图10



7、经过一系列的设定，最终可以看到桌面啦。

图11

图12



### 写在最后

虽然文章里说得挺简单，感觉一看就会，其实在实际操作中可能会遇到各种各样的问题。

这就比较考验大家的填坑能力了，本文也希望能通过这样的方式能让大家最大限制地减少遇坑的概率。

各位亲爱的小伙伴，你们学废了吗？



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc