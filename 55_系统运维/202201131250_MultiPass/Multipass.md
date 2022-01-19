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



### 准备工作

假定我们已经拥有了一台 `Windows 10` 系统，上面已经安装好了 `VirtualBox` 。

准备工作就绪，我们先到官网将 `Windows` 版的 `Multipass` 下载下来。

> 下载链接：https://multipass.run/download/windows

图x02



### 安装 `Multipass`

然后我们就可以开始安装 `Multipass` 了。

图a01



接受许可，继续。

图a02



选择虚拟引擎，这里有两个选择，前面我们说过了，在这儿选择 `Oracle VM VirtualBox` 。

图a03



选择将 `Multipass` 加到哪个路径环境变量 `PATH` 中，这样做的好处就是你可以在任意路径下调用 `Multipass` 命令。

在这儿我们选择针对所有用户都有效。

图a04



指定安装目录，默认就可以了。

图a05



选择需要安装的组件，应该都选上，反正也占不了多大地方哈。

第一项是 `Multipass` 的命令行及图形程序，第二项是通知栏图标菜单，第三项是后台服务。

图a06



安装程序开始解压缩并拷贝文件。

图a07



如果你还没有安装 `VirtualBox` ，那么它会检查并提示我们。

图a08



最后完成安装，`Windows` 下安装非常的简单啊！

图a09



### 使用 `Multipass`

打开 `Multipass` ，我们可以在系统通知栏内看到它的图标。

图b01



用鼠标右键点击图标，在弹出的菜单中只有寥寥几个选项。

我们先看看关于 `About` 一项，能看到 `Multipass` 的版本，以及可以设定是否跟随系统启动而自动登录。

图b02



这里简单解释一下 `multipass` 和 `multipassd` 的区别。

后面多了一个 `d` 是指 `daemon` ，意思是后台服务，当我们需要它以后台服务的形式运行在系统中时就会用到 `multipassd` 了。



接下来我们尝试简单地运用一下 `Multipass` 来加深对它的理解。

右键点击图标，选择 `Open Shell` 。

图b03



之后会打开一个 `PowerShell` 窗口，我们就可以在这个窗口中执行 `multipass` 命令了。

不过有时也可能会出现如下图那样的提示，询问用户是否可以发送匿名数据来帮助 `Multipass` 开发者。

图c01



说实话，我等小白还是不要掺和大神们的事了吧，我选择直接关闭了窗口，哈哈！

对于我来说，比较通常的做法就是自己打开一个 `PowerShell` 窗口。

由于之前我们已经将 `multipass` 命令放到了环境变量 `PATH` 中了，因此打开 `PowerShell` 后就可以直接输入命令执行。



我们尝试输出当前 `Multipass` 的版本号。

```
multipass version
```

图c02



直接输入 `multipass` 并且不带任何参数可以查看命令帮助信息。

```
multipass -?, -h, --help
```

图c03



我们在前面曾说过，`Multipass` 是个管理器，它可以提供快速部署虚拟机的镜像，那我们来看看它都有哪些可用的镜像吧。

输入以下命令，查看当前提供的镜像列表。

```
multipass find
```

输出结果：

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



图c04



可以看到，`Multipass` 提供的都是 `Ubuntu` 的现成的各种版本镜像，因此它能够在数分钟之内快速完成下载并将其实例化。

如果不刻意指定具体哪个版本的镜像的话，默认情况下 `Multipass` 将获取当前 `LTS` 版本镜像。



关于镜像 `image` 和实例 `instance` 的区分，我简单地科普下哈！

我们可以简单地理解为，镜像是一种模板，作为参照物，内容固定我们不能修改变动它。

而实例则是我们实际操作的对象，它以镜像为模板生成实例，一个或多个实例由一个镜像生成，然后我们对实例进行修改操作。

实际上如果小伙伴们学过 `Docker` 的话，那么对于这些概念甚至是接下来的命令操作可以说是一点也不陌生，简直是一模一样啊！



好了，我们接着看，查看当前我们拥有的实例。

```
multipass list
```

我们还没有下载镜像，自然还没有任何实例存在，别着急，一会儿我们就下载一个试试。

图c05



最简单的，我们就用默认的镜像来做实验吧。

```
multipass launch --name <实例名称>
```

比如，输出一个名为 `sysadm` 的实例。

```
multipass launch --name sysadm
```



除了名字，我们没有加任何参数，因此它会默认使用 `LTS` 版本镜像。

如果镜像还未下载，那么 `launch` 命令会先下载镜像，尔后启动运行实例。

图c08



镜像一旦下载完成，`Multipass` 就会启动实例。

图c10



在此期间有可能我们会遇到一些小问题。

比如，它会提示没有开启 `Hyper-V` 功能。

图c06



说好的 `VirtualBox` ，为啥会提示 `Hyper-V` 呢？

理由是我们还需要手动指定一下，让 `Multipass` 去找 `VirtualBox` 而不是 `Hyper-V` 。

真是有够笨的啊！

好吧，那我们就指定一下吧。

```
multipass set local.driver-virtualbox
```



如此一来，我们就可以安心让 `Multipass` 启动 `VirtualBox` 了。

不过即使如此，也有可能再次冒出来个不省心的问题。

就像下面这样，似乎是虚拟化功能未开启，记得要在 `BIOS` 里开启虚拟化功能哦！

图c09



好了，前面 `launch` 命令已经将镜像下载下来并成功启动了实例，那我们就可以来看看它的状态。

```
multipass list
```

这次终于看到了，镜像是 `Ubuntu 20.04 LTS` ，实例名是 `sysadm` ，当前正在运行中。

图c11



想要查看实例的相关信息，可以用 `info` 参数加是实例名称。

```
multipass info <实例名称>
```

比如，查看实例名为 `sysadm` 的信息。

```
multipass info sysadm
```

图c12



执行实例内部命令，使用 `exec` 参数。

```
# 执行不带参数的命令
multipass exec <实例名称> <command>
例：multipass exec vm01 pwd

# 执行带整数的命令
multipass exec <实例名称> -- <command> <arguments>
例：multipass exec vm01 -- uname -a
```

图c13



关于 `launch` 参数实际上还有更具体的用法，大概有以下几种附加选项参数 `[options]` 可以用来指定虚拟机配置。

```
multipass launch [options]

-n, --name: 名称
-c, --cpus: cpu核心数, 默认: 1
-m, --mem: 内存大小, 默认: 1G
-d, --disk: 硬盘大小, 默认: 5G
```



那么命令大概可以这样写。

```
multipass launch --name <实例名称> --cpus 1 --mem 1G --disk 10G
```

参数简写就可以是这样。

```
multipass launch -n <实例名称> -c 1 -m 1G -d 10G
```



另外如果我们想指定镜像，那么可以在后面加上 `<image>` 参数。

```
multipass launch [options] <image>
```

举例，下载并启动镜像为 `Ubuntu 21.10` 的实例，并命名为 `sysadm` 。

```
multipass launch -n sysadm "21.10"
```



对于实例的启动停止和删除释放命令也很简单。

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



还有很多相关的操作命令，在这儿我们就不一一讲解了。

有兴趣的小伙伴可以到官方文档中查看。

> https://multipass.run/docs/



