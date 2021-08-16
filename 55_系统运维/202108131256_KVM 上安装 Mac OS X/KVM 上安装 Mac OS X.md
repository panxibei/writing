

标题：

副标题：

英文：

关键字：



由于最近某些测试需要在 `MacOSX` 上做，但手头又没有苹果电脑，怎么办？

有人想到了黑苹果，倒是个不错的主意，可是并不是什么电脑都能安装上的。

一堆的烂机器，装个 `Windows` 还能凑合，但黑苹果可就没那么容易给安上了。

于是只好转向虚拟机，看看虚拟机上是否有门。



众所周知，虚拟机主流的就那么几种，无非 `VMWare` 、`VirtualBox` 或 `KVM` 。

前两者都能通常一定的方法成功安装上 `Mac OS X` ，可是这次不一样了，我必须在 `KVM` 上安装，因为我只有一台安装 `KVM` 的机器。

并且我希望这个系统能长期运行，所以我放弃了在自己电脑上安装的念头。





> https://github.com/kholia/OSX-KVM

官网上虽然有安装方法，但是有点笼统又显得不太灵活，对我等小白也不太友善。

我研究了好几天，终于研究出来可以自己想怎么安装就怎么安装的方法。



坑：

GLib-WARNING **: gmem.c:489: custom memory allocation vtable not supported

> https://bugzilla.redhat.com/show_bug.cgi?id=1666811



```
# 将 `/usr/libexec/qemu-system-x86_64`
<emulator>/usr/libexec/qemu-system-x86_64</emulator>

# 替换成 `/usr/bin/qemu-kvm`
<emulator>/usr/bin/qemu-kvm</emulator>
```

有人说这不是一样的嘛，起初我也是这么想的，别想到我替换后问题居然解决了！

图k01





注意修改以下标记内容。

```
  <name>macOS</name>
  <uuid>2aca0dd6-cec9-4717-9ab2-0b7b13d111c3</uuid>
  <title>macOS</title>
```



磁盘启动关键点，通过 `BaseSystem.img` 启动并加载 `OpenCore.qcow2` ，这两者缺一不可。

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





关于网卡

没有网络，安装程序不能开始并进行下去，所以必须保证网络正常。

以下代码描述了可正常工作的网络配置，切记不要随意更改网卡名称



```xml
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

<interface type="bridge">
    <mac address="52:54:00:88:88:88"/>
    <source bridge="virtbr0"/>
    <target dev="tap0"/>
    <model type="vmxnet3"/>
    <address type="pci" domain="0x0000" bus="0x02" slot="0x01" function="0x0"/>
</interface>
```

