QuickGUI

副标题：

英文：

关键字：



众所周知，现在的虚拟机非常强大，应用也十分的广泛，并且被人们所熟知的人称老三强的虚拟机软件都快被人玩烂了。

你要问是哪三款，当然是业界赫赫有名的 `VMware` 、 `VirtaulBox` 和 `QEMU` 这三位老大哥啦！

要说是它们是老三强，一点儿也不为过，没人反对吧？

当然了，还有其他不少虚拟机软件也拥有不少用户，各有各的特色，可虚拟机软件已经非常成熟的今天，却仍然有那么一小撮顽固分子想要绞尽脑汁用尽一切办法、竭尽一切所能，就是要玩出个透彻、玩出个地道。

这不近期我被推送了一则消息，于是一个叫作 `QuickGUI` 的名词就这样被印入了我的脑海中。



`QuickGUI` 是什么，好吃吗，怎么个吃法？

在介绍这位兄台之前，我们需要先介绍一下他的两位哥哥。

哦，他还有哥哥啊，当然，一个名叫 `Quickemu` ，另一个名叫 `Quickget`  。

看，他们都有同一个姓啊，就是 `Quick` 嘛！

没错，看来你很快就认识他们了，过一会儿就会更加熟悉了！



`Quickemu` 和 `Quickget` 是一对双胞胎，前面一位是用来启动并运行虚拟机的，后面一位则是用来下载虚拟机镜像及配置文件的。

很简单，他们平时就是互相配合一起行动的，你瞧！

```
# quickget <系统类型> <系统版本>
quickget ubuntu-mate impish

# quickemu --vm <系统配置文件>
quickemu --vm ubuntu-mate-impish.conf
```

也就是说，`Quickget` 先将虚拟机所需的文件都下载下来，然后再由 `Quickemu` 去启动运行虚拟机。



那么 `QuickGUI` 呢，他能做什么呢？

虽然他要比那两位哥哥年轻一些，但其实他是一个颜值很高、性格又有些自傲的帅哥。

前面两位哥哥能做的工作，他一个人就能全部搞定。

是的，你可以用 `QuickGUI` 来下载虚拟机文件，并通过他来启动虚拟机。

要知道，他是用 `Flutter` 开发编写的，可是自带 `GUI` 界面的哦，是不是很棒？



不过实际上那并不是他一个人的功劳，工作之所以如此轻松其实还是背后有那两位哥哥在默默帮助和支持。

实际上 `QuickGUI` 的正常运行必须要依赖 `Quickemu` 和 `Quickget` 。



### 安装 `Quickemu` 和 `Quickget`

单纯安装这哥俩儿是非常简单的。

`Ubuntu` 下可以这么干。

```
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt update
sudo apt install quickemu
```



其他 `Linux` 发行版可以这么干。

```
# 你需要先安装上 git
git clone --depth=1 https://github.com/wimpysworld/quickemu
cd quickemu
```



安装好后，两个命令就都有了，所以说他俩是双胞胎。

注意，对于其他发行版的 `Linux` 系统，在安装好 `Quickemu` 后最好建立好软链接，以方便在任意位置调用命令。

```
sudo ln -s /path/to/quickemu /usr/bin/quickemu
sudo ln -s /path/to/quickget /usr/bin/quickget
```



通过帮助我们可以查看命令的使用参数，并且还可以知道他们支持哪些现成的虚拟系统。

图01

图02







### 安装 `QuickGUI`

安装这位帅哥也是灰常简单。

`Ubuntu` 下可以这么干。

```
sudo add-apt-repository ppa:yannick-mauray/quickgui
sudo apt update
sudo apt install quickgui
```

图03



其他 `Linux` 发行版可以直接下载 `Release` 压缩包，然后解压后就能用了。

```
sudo wget https://www.github.com/quickgui/quickgui/releases/download/v1.1.5/quickgui-1.1.5.tar.xz
sudo tar xvJf quickgui-1.1.5.tar.xz
cd quickgui-1.1.5
```



当然了，给他建立一个软链接也不是个坏主意。

```
sudo ln -s /path/to/quickgui /usr/bin/quickgui
```



最终打开 `QuickGUI` 就是这个样子滴。

图04



### 安装运行条件

前面几位安装够简单吧？

但要想真正地能让他们派上用场，还是要安装一些依赖程序的。

站稳了，别吓到哈，以下就是必须要安装的依赖程序，没有他们这哥仨就玩不转。



* QEMU (*6.0.0 or newer*) **with GTK, SDL, SPICE & VirtFS support**
* bash (*4.0 or newer*)
* Coreutils
* EDK II
* grep
* jq
* LSB
* procps
* python3
* macrecovery
* mkisofs
* usbutils
* util-linux
* sed
* spicy
* swtpm
* Wget
* xdg-user-dirs
* xrandr
* zsync



关于 `QEMU 6.0` 版本以上需要手动安装，因为默认更新源只支持到 `4.0` 版本。

具体怎么安装，请参考我以前的文章，手把手教你怎么搞定。

> 文章名称：《手动编译安装 KVM 就是找虐，万幸我还活着！》
>
> 文章链接：https://www.sysadm.cc/index.php/xitongyunwei/864-compiling-and-installing-of-kvm-is-very-troublesome-thanks-god-i-am-still-alive



至于其他零零碎碎各种程序可参考官网上的说明逐个安装即可。

总之作为演示，在我的测试环境中我已经搞定他们了。

不过在这儿我要补充一个关键问题，就是在 `QEMU` 编译时必须要带上那些所需的组件开关。

注意，包括并不仅于 `GTK` ，`SDL` , `SPICE` 以及  `VirtFS` 等。



安装这些所需组件。

```
# virtfs
# Ubuntu 可以这么干
sudo apt install libcap-ng-dev libattr1-dev
# CentOS/Rocky 可以这么干
dnf install libcap-ng-devel libattr-devel


# SDL2
# Ubuntu 可以这么干
sudo apt-get install libsdl2-dev
# CentOS/Rocky 可以这么干
dnf install SDL2*


# GTK
# Ubuntu 可以这么干
sudo apt install libgtk-3-dev
```



还有其他一些与开关有关的组件，这些比较零散，基本上都是 `QEMU` 所需要的驱动依赖。

此处以 `Ubuntu` 为例，其他发行版按照对应的开发扩展组件安装即可。

```
sudp apt install libusb*
sudo apt install ccid
sudo apt install libcacard-dev
sudp apt libpmem-dev
sudp apt libdaxctl-dev
sudp apt libzstd-dev
sudp apt libsnappy-dev
sudp apt libssh-dev
sudp apt libxml2-dev
sudp apt libnfs-dev
sudp apt libiscsi-dev
sudp apt libbrlapi-dev
sudp apt libcurl4-openssl-dev
sudp apt libaio-dev
sudp apt xorg-dev
```



最后别忘了，在编译前配置 `QEMU` 时开启应用这些组件的开关，然后再编译安装。

```shell
./configure --enable-gtk --enable-virtfs --enable-sdl --enable-libusb --enable-usb-redir --enable-ccid --enable-libcacard
```



### `QuickGUI` 使用演示

当一切都准备就绪后，我们就可以让 `QuickGUI` 大显身手了。

不过先不要着急，我们先请出大哥和二哥，先让他们表现一下哈。

这样有个好处，我们可以先确定 `Quickemu` 和 `Quickget` 这两条命令能正常工作，然后再使用 `QuickGUI` 就问题不大了。



比如，使用 `Quickget` 就直接下载 `Windows 11` 的虚拟机。

不过这玩意不知道是镜像太大，还是支持不太好，我花了好久都没下载下来。

图05



无奈我只好换个系统，比如 `ArchLinux` 。

结果调试了好几天才发现，虚拟机启动时老是报错，说什么 `SDL` 初始化失败。

 最后还好找到方法，使用 `Spice` 作为图形协议才启动成功。

```
quickemu --vm archlinux-xxx.xx.xx.conf --display spice
```

图06



通过远程重定向 `Xming` 也可以正常使用。

图07



各种系统都能正常显示并工作，比如 `MacOS` 也可以。

图08



好了，`Quickemu` 哥俩都没问题了，那么接下来就该 `QuickGUI` 登场了！

`QuickGUI` 的界面操作可以说是非常之简单，大致可以分成左边按钮（用于管理现有虚拟机）和右边按钮（创建新的虚拟机）这两部分。

图04



首先，我们要先下载一个虚拟系统。

在图中点击右侧的 `Create new machines` ，然后选择你想要的系统和版本后点击下载即可。

图09



可选系统还是挺丰富的，连安卓都有。

图10



当然，不同的系统版本号是不一样的，有些只提供少数支持的版本。

图11



有些系统还可以选择不同的语言。

图12



比如最后选择成这样，`ArchLinux` 的最新版。

图13



点击 `Download` 他就会开始下载了。

图14



最后下载完成后，我们就可以在现有虚拟机里看到创建的虚拟机列表了。

图15



点击运行按钮，正常情况下它就会启动起来。

其实我们也能看出来，它就是走的 `Spice` 协议。

图16



同样，通过远程重定向 `Xming` 协议也可以连接并使用 `QuickGUI` 。

只是很奇怪的是，界面显示为德文，似乎官网上也有人反映过，不知道之后的版本会不会修正。

图17



启动虚拟机也是同样OK，操作都是一样一样的。

图18



### 其他内容

虽然前面所说的都不是很难理解，但实际上他们都是围绕着 `QEMU` 在转。

因此，如果你有 `QEMU` 的使用经验，那么你完全可以手动编辑 `Quickemu` 的配置文件。

当你成功下载好一个虚拟机镜像时，你会发现它的配置文件也一起给下载好了。

打开这个配置文件，里面简单得要死，比如像下面这样。

```
guest_os="linux"
disk_img="debian-bullseye/disk.qcow2"
iso="debian-bullseye/firmware-11.0.0-amd64-DVD-1.iso"
```



如果你以前了解过 `QEMU` ，那么就会知道它屁股后面往往会跟着一长串的参数，让人看着就头大。

而现在我们看到的这个配置文件竟然如此简单，会不会有什么坑呢？

虽然我研究不深，不过我觉得这应该不算有坑，毕竟 `Quickemu` 就是为了极大简化操作来的，要不怎么叫 `Quick` 呢！

当然你要说配置文件中只有这些参数，那肯定不尽然，其实他还有很多参数。

比如：

* `fixed_iso=` 指定 `ISO` 镜像
* `tpm="on"` 启用 `TPM`
* `boot="legacy"` 允许传统 `BIOS` 方式启动
* `cpu_cores="4"` 指定 `CPU` 内核
* `ram="4G"` 指定内存
* `disk_size="16G"` 指定硬盘大小



这里只是例举了一些，详细的可以参考官网。

除此之外，他还支持 `Samba` 文件共享、端口映射、`Spice WebDAV` 、`VirtIO-9P` 以及 `USB` 重定向等等功能。

当然这些功能本来就是 `QEMU` 具备的。



### 写在最后

`QuickGUI` 也好，`Quickemu` 和 `Quickget` 也好，他们都是建立在 `QEMU` 及其相应组件的基础上运行的。

他们出现的目的非常单纯，就是为了简化我们对虚拟机的操作，降低操作的复杂度。

很显然，他们可能起步不算太早，还在发展中。

如果小伙伴们感兴趣的话，可以和其他相似同类的程序做个对比，比如 `Gnome Boxes` 。

作为同样是图形界面的虚拟机操作程序，他们各有其特点，而 `QuickGUI` 则可能对所有的发行版更通用一些吧。





**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

