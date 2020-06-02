Hpe ProLiant Microserver Gen 10 安装 NAS4Free 问题一则

副标题：在前进的道路上总是有些沟沟坎坎，跨过去就是了~



最近想搞个NAS，网上搜了半天，发现有这么一款 `Hpe ProLiant Microserver Gen 10` 的设备。

网上介绍了各种天花乱坠的功能，其中居然还能安装Win10当台式机用，这个有点意思。

综合下来，还是选择了它。

就是这货：

图1



等拿回到手，开始安装NAS4Free时，才发现无论怎么启动都会卡在一个地方不动，安装也就无法继续下去了。

大概会是这个样子：

```
pcib0: <ACPI Host-PCI bridge> port 0xcf8-0xcff on acpi0
pcib0: _OSC returned error 0x10
pci0: <ACPI PCI bus> on pcib0
```

图2



嗯？难道我拿到的是假货？还是硬件有问题？

重复启动N次问题依旧，我在哭~

连安装界面都进不去，谈什么安装呢？

我有些出离愤怒了，上网搜搜看吧。

哎，你别看我废话这么多，还真被我找着了，只不过是在老外的网站上看到的。

To Fix the issue of the problem you should ......

好吧，我说人话。

虽然老外用的是 `FreeNAS` ，而我用的是 `NAS4free` ，其实都一样。

首先，原因其实是由于启动时某项参数错误导致的问题，可能是个BUG。

其次就是解决方法了，有这么几个方法。

1. WEB页面修改启动参数
2. 启动时编辑 `Grub`
3. 定制NAS4Free安装镜像



看到第一项时，我鼻子都气歪了，我还没装好哪儿来的WEB页面？

好吧，看样子第二项靠谱一些，试试看。



1、重新启动，耐心等待Grub启动画面出现，按下 `e` 键。

2、在出现的参数列表项最后添加（如果你是安装在U盘上，那第二项也要添加）：

```
set kFreeBSD.hw.pci.realloc_bars=1
set kFreeBSD.hw.usb.no_shudown_wait = 1
```

就像下面这个样子，注意那不是下划线，它只是个光标：

图3

3、按 `F10` 继续启动。

好了，以上步骤很简单，却能解决问题，系统顺利加载到安装界面，可以开始安装啦！



就这样结束了吗？

No No No！你还需要在安装好的系统中修正启动参数，否则安装完成后可能还是无法启动哦！

其实就是之前说的三个办法的第一个办法。

登录到系统中，分别找到以下各项并修正参数。

```
# 系统 > 高级 > loader.conf
hw.pd.realloc_bars = 1

# 系统 > 高级 > sysctl.conf
hw.pci.realloc_bars = 1
hw.usb.no_shudown_wait = 1
```

分别参数下图：

图4

图5



再重启看看，是不是可以顺利启动 `NAS4free` 系统了？

至于第三个办法，通过定制ISO镜像，过程太过复杂，不符合我等小白们应用为王的时间大师管理理念，就不在此介绍了。

下次有机会，我会介绍关于UrBackup在NAS4Free上的安装使用。

希望你的NAS安装顺利，使用愉快！

