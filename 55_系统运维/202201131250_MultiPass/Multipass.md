Multipass

副标题：

英文：

关键字：





随着电脑性能的飞速提升，虚拟机软件也早已成为了我们平日测试系统经常用到的高频软件。

但是除了虚拟机环境的搭建之外，虚拟客户机的创建和配置的复杂和繁琐性也是一直以来被萌新们谈之色变的话题之一。

毕竟熟练掌握客户机的创建和配置是需要投入时间和精力的，而我们又可能没有太多的时间去搞定它，有没有可以快速创建客户机、快速展开我们所希望的测试工作呢？

还真有这样的方案！



不知道小伙伴们还记不记得以前我给大家分享的一篇关于 `Quickemu` 的文章，就是介绍快速获取虚拟机镜像，并且快速创建虚拟机系统的这么一个解决方案。

不过嘛，`Quickemu` 是建立在 `KVM` 之上的，那必须是 `Linux` 系统啊！

而且好像 `Qemu` 还要 `6.0` 版本以上，这 `KVM` 环境搭建就够费时费力了，荫新们直呼做不到啊！

嘿嘿，别着急！

我们到 `Windows` 上想办法，有可能吗？

当然有可能了，要不我在这儿废什么话呢，哈哈！



今天要给大家介绍的，就是名为 `Multipass` 的一款轻量型虚拟机管理器。

> 官网：https://multipass.run/

图x01



它有什么特点？

你看它的称呼，我们把修饰的定语给它拿掉，就剩下“虚拟机管理器”这几个字。

瞬间明白了，它其实只是个管理器，并不是虚拟软件，其本质上和 `Quickemu` 差不多。

但是它比 `Quickemu` 好处多，它可以在 `Linux` 、 `Windows` 和 `macOS` 多平台上跑。



哎，小伙伴们一看有 `Windows` ，嘿嘿，这下有门了。

没错哈，需要进一步说明的是，它在不同平台上跑的时候啊，它管理的虚拟软件还不一样。

刚才说了嘛，它是个管理器，并不是虚拟软件本身。

那它在不同平台上都怎么管的？



很简单，在 `Linux` 上它管 `KVM` ，在 `Windows` 上它管 `Hyper-V` 和 `VirtualBox` ，还有在 `macOS` 上它管 `HyperKit` 。

管得还真不少，但仔细一看你也能明白，在哪个不同平台就管理哪个不同的虚拟软件，都是与平台相对应的。

那么我们就很清楚了，只要我们在 `Windows` 上安装有 `Hyper-V` 或 `VirtualBox` ，再通过 `Multipass` 来管理它们就可以达到我们的快速创建和管理虚拟机的目的了。

然而 `Hyper-V` 对于荫新们并不常用，复杂度很高，体积也很庞大，似乎可能还要购买 License 。

而相对之下，`VirtualBox` 就比较亲民一些，免费开源，安装使用起来也很方便，因此接下来我们就以 `VirtualBox` 为例，为大家介绍 `Multipass` 的简单用法，以此我们可以类推到其他系统平台上。



假定我们已经拥有了一台 `Windows 10` 系统，上面已经安装好了 `VirtualBox` 。

准备工作就绪，我们先到官网将 `Windows` 版的 `Multipass` 下载下来。

> 下载链接：https://multipass.run/download/windows

图x02



然后开始安装 `Multipass` 。











```
Image                       Aliases           Version          Description
core                        core16            20200818         Ubuntu Core 16
core18                                        20211124         Ubuntu Core 18
18.04                       bionic            20220104         Ubuntu 18.04 LTS
20.04                       focal,lts         20220111         Ubuntu 20.04 LTS
21.04                       hirsute           20220106         Ubuntu 21.04
21.10                       impish            20220111         Ubuntu 21.10
appliance:adguard-home                        20200812         Ubuntu AdGuard Home Appliance
appliance:mosquitto                           20200812         Ubuntu Mosquitto Appliance
appliance:nextcloud                           20200812         Ubuntu Nextcloud Appliance
appliance:openhab                             20200812         Ubuntu openHAB Home Appliance
appliance:plexmediaserver                     20200812         Ubuntu Plex Media Server Appliance
anbox-cloud-appliance                         latest           Anbox Cloud Appliance
minikube                                      latest           minikube is local Kubernetes
```



`Multipass` 默认使用 Hyper-V 作为其虚拟化提供程序。

将虚拟化提供程序切换为 `VirtualBox` 。

```
multipass set local.driver=virtualbox
```





```
multipass launch --name vm_name
```





`launch` 参数大概有以下几种。

```
-n, --name: 名称
-c, --cpus: cpu核心数, 默认: 1
-m, --mem: 内存大小, 默认: 1G
-d, --disk: 硬盘大小, 默认: 5G
```



那么命令可以这样写。

```
multipass launch --name vm_name --cpus 1 --mem 1G --disk 10G
```

简写就可以这样写。

```
multipass launch -n vm_name -c 1 -m 1G -d 10G
```



执行虚拟机内部命令。

```
# 执行不带参数的命令
multipass exec vm_name <command>
例：multipass exec vm01 pwd

# 执行带整数的命令
multipass exec vm_name -- <command> <arguments>
例：multipass exec vm01 -- uname -a
```







```
# 启动实例
multipass start vm01
# 停止实例
multipass stop vm01
# 删除实例（删除后，还会存在）
multipass delete vm01
# 释放实例（彻底删除）
multipass purge vm01
```

