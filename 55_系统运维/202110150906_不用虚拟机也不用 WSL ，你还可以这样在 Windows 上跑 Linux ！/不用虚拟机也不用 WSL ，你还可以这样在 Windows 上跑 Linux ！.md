不用虚拟机也不用 WSL ，你还可以这样在 Windows 上跑 Linux ！

副标题：不是虚拟机但干了虚拟机活儿的CoLinux ~

英文：without-vmware-or-virtualbox-or-wsl-you-can-also-run-linux-on-windows-like-this

关键字：colinux,linux,windows,wsl,vmware,virtualbox,虚拟机



正如文章标题所写，既不用虚拟机也不用 `WSL` ，想要在 `Windows` 上跑 `Linux` 可行吗？

早在很久以前（抱歉多久没查到，的确很早就是了），那时在虚拟系统 `VMWare` 和 `VirtualBox` 还很小的时候，在 `WSL` 还没出生的时候，江湖中已经出现了一位拥有早期黑科技于一身的大侠。

这位大侠江湖人称 `Cooperative Linux` ，意为协作 `Linux` ，人送外号 `CoLinux` 。



既然是大侠，那他的黑科技有多黑呢？

这么说吧，他可以在 `Windows` 系统上时不时地抢夺 `CPU` 资源，以此来模拟运行 `Linux` 系统，因此可以实现在 `Windows` 上同时运行 `Linux` 的效果。

他这招黑就黑在，他不是我们现在所熟知的虚拟机技术，而是和 `Windows` 一模一样、大模大样地一起向前奔跑，犹如一台机器实际上跑着两个甚至多个系统。

也就是说，他的这个 `Linux` 是个真的系统，虽然它和虚拟机挺像，也要先开个 `Windows` 。

好了，说到这儿，我想肯定有小伙伴心里好奇得痒痒了，那我就陪各位走一遭，去拜访拜访这位当年名噪一时的大侠吧！



### 准备工作

一台安装有 `Windows 7 32位` 的物理实体机。

当然你用虚拟机也是可以的，这并不会影响 `CoLinux` 的实现。

为什么要 32 位，后文书会说到，暂时按下不表。

还有最好能上网，好了，就这么多。



### 下载安装 `CoLinux`

我们本着能动手绝不BB的原则，直接来到官网，来个先下载为敬。

官网链接：http://www.colinux.org/



打开官网，左上角的 `LOGO` 震撼到了我，这用的是我中国的太极啊，你中有我、我中有你的阴阳理论，与大侠的风范的确很贴合啊。

找到左侧菜单栏中的 `Download` 一项，实际上 `CoLinux` 下载被托管到了 `SourceForge.net` 上了。

下载链接：https://sourceforge.net/projects/colinux/files/



最新版本 `0.7.9` ，直接点击下载即可。

图01



因为是 `Windows` 程序，所以安装极为简单。

不过在安装过程中有几处需要言明，比如如下图，你可以不勾选第二行的 `Root Filesystem image Download` ，这样就可以直接跳过后面的镜像系统的下载过程，避免因镜像系统过大而浪费时间。

图02



还有，如果你需要将 `Linux` 系统通过桥接方式联网的话，必须要安装 `WinPcap` ，因为 `CoLinux` 的网络依赖这个组件。

提示：`pcap-bridge` 模式需要 `WinPcap` ，而 `ndis-bridge` 则不需要，一会再细说。

图03



那么如何安装 `WinPcap` 呢？

其实一点儿都不难，到它的官网下载安装就是了。

> `WinPcap` 下载链接：https://www.winpcap.org/install/default.htm

找到如下图中的安装包就可以了。

图04



如果在前面的步骤中你没有去掉 `Root Filesystem image Download` 的勾也没关系，可以让它保持默认不下载任何镜像即可，直接点下安装继续。

有些镜像系统文件有新版本，我们在后续的步骤中再手动下载即可。

图05



接下来程序会开始安装，如果它弹出一个错误，就像下图那样，那么你应该使用 32 位的系统，原因是 `CoLinux` 不支持 64 位操作系统。

这是个小小的遗憾，不过官方也说了，以后会更新，毕竟现在都已经是 64 位系统的时代了。

图06



安装过程中会提示你安装一些驱动程序软件，其中包括一块虚拟网卡，这个之后会详细再说。

选择 `始终安装此驱动程序软件` 后继续。

图07



除 `CoLinux` 本身程序的安装以外，我们还要下载一个 `Linux` 系统的镜像文件。

以本文示例，我们选个 `Ubuntu 12.04` 下载吧。

如下图，也是在 `SourceForge` 上，找到目录路径 `Home / Images 2.6.x Ubuntu / Ubuntu 12.04` 。

可以直接下载迷你版：http://sourceforge.net/projects/speedlinux/files/base-200-10-11-11.7z/download

下载完成后我们得到一个压缩文件 `base-200-10-11-11.7z` ，大小约 195 MB。

图08



### 初步使用 `CoLinux`

##### 将 `CoLinux` 命令路径添加到 `Path` 环境变量中

`CoLinux` 被安装在了 `C:\Program Files\colinux` ，然而接下来的操作会涉及到命令行的方式。

因此为了在任意目录下都能直接访问到 `CoLinux` 命令，那么我们最好将这些命令的路径添加到系统路径 `Path` 环境变量中。

图09



##### 基本配置

我们先要给我们的系统搭个窝，在这里我新建一个文件夹，用于存放配置文件和镜像文件啥的，比如 `C:\colinux` 。

将前面下载的镜像压缩文件 `base-200-10-11-11.7z` 解压后，把 `base.vdi` 放到 `C:\colinux` 中。



然后再在 `CoLinux` 的安装目录 `C:\Program Files\colinux` 中，找到名称为 `example.conf` 的这么一个文件。

瞧名字就知道啥意思了哈，将它复制一份出来并重命名，放到我们新建的文件夹中，比如 `C:\colinux\base.conf` 。

接着我们就要来编辑这个 `base.conf` ，用记事本打开就行。



那么怎么编辑呢，需要改些什么参数呢？

其实有个现成的参数文件来着，我们可以在 `C:\Program Files\colinux` 中很容易地找到一份关于如何配置 `CoLinux` 的文本说明文件 `colinux-daemon.txt` 。

图10



我们只要照着这个文件描述的设定方法做就是了，实际做测试的话也很简单，没几个参数要改的。

我可以偷偷告诉你，只要改三个就可以了，哪三个，看下面。

```
# 内核
kernel=<path to vmlinux file>

  This specifies the path to the vmlinux file.

  Example:
  kernel=vmlinux

# 初始镜像
initrd=<path to initrd file>

  This specifies the path to the initrd file.

  Example:
  initrd=initrd.gz
```



一个是 `kernel` ，另一个是 `initrd` ，前者是内核，后者是初始镜像。

这两个东东其实 `CoLinux` 已经帮我们提供好了，就在安装目录中。

不过需要我们特别注意的是，在参数书写之时务必要加上绝对路径，比如。

```
kernel="C:\Program Files\coLinux\vmlinux"
initrd="C:\Program Files\coLinux\initrd.gz"
```

图11



否则可能会导致找不到文件而系统无法正常启动。

图12



前面两个介绍了，还有一个就是镜像系统本身了。

前面我们已经下载好并放到了 `C:\colinux` 中了，OK，将镜像文件引用到 `cobd0` 参数。

```
cobd0="c:\colinux\base.vdi"
```

这个和虚拟的第一块磁盘那赶脚差不多意思。

图13



好了，说到这儿就已经可以启动我们下载的 `Linux` 系统了，不过可能有的小伙伴比较疑惑，还有内存、网络啥的呢，不用配置了？

关于内存设定，作为实验，一般不需要特别指定，默认是被注释掉的。

内存默认以 `MB` 为单位，在未被指定并且你的实际物理内存大于 `128MB` 的情况下，它会以实际物理内存的四分之一为设定标准，当然你指定一下也是可以的，完全没问题。

 ```
 mem=<mem size>
 ```

此外关于网络，我们现在还不着急用到，等之后会专门来说的，稍安勿躁哈，我们先来看看系统能不能启动起来。



##### 启动系统

配置完成后就是启动系统了，我们来尝试启动看看。

打开命令控制台，输入以下命令。

```
colinux-daemon @base.conf
```

还是要啰嗦一句，注意 `colinux-daemon` 和 `base.conf` 的路径正确的问题，如果要写完整，应该是这个样子。

```
C:\Program files\colinux\colinux-daemon.exe @C:\colinux\base.conf
```



好了，系统开始启动了，妈耶，这是什么字体啊，造型挺别致啊！

图14



不喜欢，遂修改之，点击上面菜单 `Config` > `Font...` 修改字体。

图15



改成什么字体就看各位的喜好了，我先干了，你们随意。

图16



字体改完后看着舒服多了，这个系统挺有意思，登录用户名和密码都明明白白告诉你了。

通常密码是 `root` ，也有的系统的密码是 `colinux` 。

图17



输入用户名和密码后登录成功，可是这时候来了一个大坑，当我按下键盘突然发现输出字符错乱，搞了半天它喵的居然是日文键盘布局！

图18



哎？怎么会是日文键盘呢？

我猜测这个 `CoLinux` 项目是太君们搞起来的，看官网上的示例截图，都用上了日文版的 `Knoppix` 。

布局错乱，除了标点符号啥的完全不一样外，好像 `z` 键和 `y` 键也完全给颠倒了！



对照着日文键盘按，凑合凑合倒是可以，不过不管怎么样这到底还是有些反人类啊！

对于这样变态的用法你能忍吗，反正我是忍不了了，怎么办？

很简单，`Ubuntu` 里有修改键盘布局的高级工具 `dpkg-reconfigure` 啊，盘它！

输入以下命令开启变更键盘布局之旅。

```
$ sudo dpkg-reconfigure keyboard-configuration
```



注意，在出现的界面中，按上下键做出选择，按 `Tab` 键移动光标至 `<OK>` 处再按回车进入下一步。

第一个画面中，选择 `Generic 104-key PC` ，当然你看到的是乱码，忍耐一下，一会儿就不疼了。

图19



紧接着选择 `Chinese` ，这是国家和区域选择。

图20



接下来是选择语言，我猜应该是最上面一行简体中文。

图21



然后应该是键盘布局，选择最上面的默认布局，可以参考第二幅图片。

图22

图23



快了哈，接着是配置组合键，选择第一行没有组合键，同样参考第二幅图，我的眼睛啊！

图24

图25



最后不用我多说，肯定是确认设置，选择 `Yes` 搞定！

图26



OK，再来试试键盘输入，瞬间舒服多了吧！

珍爱生命，从保护视力开始！



既然系统成功启动了，那么我们可以做些什么呢？

我想到的是，得保证它可以上网啊，没有网心不亮啊！



### 网络设置

前面留了扣，没有说网络的配置，原因是这玩意搞网络有那么一些些麻烦，需要专门来说一说。

首先我们将 Windows 的防火墙关闭，当然了，如果你可以设定成单独为 `CoLinux` 关闭也是可以的。

其次我们先来了解一下 `CoLinux` 网络参数有哪些选项。



##### 网络连接类型

网卡参数支持类型为：`slirp` ，`tuntap` ，`pcap-bridge` ，`ndis-bridge` ，共四种类型。

* `slirp`：最简单模式，仅直接与 Windows 连接。
* `tuntap`：连接 `CoLinux` 虚拟出来的一块网卡 `TAP-Win32 Adapter V8 (coLinux)` 。
* `pcap-bridge`：桥接 Windows 的物理网卡，需要 `WinPcap` 驱动。
* `ndis-bridge`：与 `pcap-bridge` 相同，区别是不使用 `WinPcap` 驱动，仅通过 Windows 的 `NDIS` 接口层模拟网卡。

图27



##### 配置网卡参数

配置文件中网卡参数的书写形式为以下这个样子。

```
ethX=slirp | tuntap | pcap-bridge | ndis-bridge , <options>
```



在这里我用 `pcap-bridge` 类型方式来做演示，除了桥接其他类型想上网比较困难。

注意，配置文件中最好按以下格式写入网卡配置信息。

本地连接名称就是你在正常使用的网卡的名称，当然你可以重命名为你喜欢的名字。

另外，后面的 mac 地址应该是这块网卡的硬件地址，如果和 Linux 虚拟系统中的 mac 地址不同，那可能会出现问题，最好重新来过。

```
eth0=pcap-bridge,"本地连接名称",00:11:22:33:44:55
```



##### `Linux` 系统中的网络配置

除搞定配置文件外，启动并进入 `Linux` 系统后，还需要通过以下命令查看系统内部网卡信息，这个有可能不是 `eth0` 。

以本文为例，从返回的结果看，当前的网卡名称叫作 `eth3` 而不是 `eth0` ，这个要注意了，以实际反馈的信息为准哦。

```
$ ip address
```

图28



有了网卡信息，那么我们接下来修改它的IP地址信息吧。

输入以下命令，开始编辑网卡信息。

```
$ sudo vi /etc/network/interfaces
```

系统配置中默认 `eth3` 是被注释掉的，所以我们将它的注释拿掉，再赋予正确的 IP 地址及网关信息即可。

注意，在最上面 `auto` 一行，别忘记确保有相应编号的 `eth` （图中没有写 `eth3`，实际应该加上` eth3` ）。

举例如下：

```
auto lo eth3

iface lo inet loopback

iface eth3 inet static
	address 192.168.2.10
	netmask 255.255.255.0
	gateway 192.168.2.1
```

图29



设定完成，保存退出，然后执行以下命令使网卡配置生效。

```
# ifdown eth3 && ifup eth3
```

或者重启服务也是可以的。

```
# /etc/init.d/networking restart
```

最后确认网络可 Ping 通。

图30



除了桥接方式，本身它是可以支持本机网络访问的，这种情况下只是 `Windows` 本机与 `Linux` 系统连接网络了。

从下图中我们可以看到，在 `CoLinux` 安装完成后，就会自动生成一个虚拟网卡。

图31



这种情况下，只要将网卡简单配置成 `tuntap` 参数即可。

```
eth0=tuntap
```

当系统启动后，你会发现这块虚拟网卡由断开网络的状态转变成了连接状态。



### 修改镜像更新源

我们已经成功连上了互联网，但是我发现无法正常下载安装软件，所以我们应该更新一下镜像源。

由于我们用的 `Ubuntu` 是 `12.04` 版本，和现在最新的 `21` 版本比较的话已经很旧了，所以应该找个相对旧一点的但是仍有效的镜像源，于是我找到了中科大镜像源。

可以定制选择镜像源文本，只需要选择不同系统的不同版本即可。

链接：https://mirrors.ustc.edu.cn/repogen/



先备份原来的镜像源文件 `/etc/apt/sources.list` 。

```
cp /etc/apt/sources.list /etc/apt/sources.list.bak
```



然后再编辑 `/etc/apt/sources.list` ，删除原来的内容后将以下内容复制到文件中。

注意不要用 `https` ，而应该用 `http` ，因为当前的 `Ubuntu12.04` 不支持前者。

```
deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-security main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-updates main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-backports main restricted universe multiverse

## Not recommended
# deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-proposed main restricted universe multiverse
# deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-proposed main restricted universe multiverse
```



修改保存 `sources.list` 文件后，输入以下命令更新一下即可开始安装软件了。

```
$ sudo apt-get update
```



### 将 `CoLinux`  注册成服务

确切地说，是将我们设定好的 `Linux` 虚拟系统注册成服务，以便它可以在系统启动的同时加载启动。

这样的好处不言自明，通常 `Linux` 系统也是作为服务器的角色存在于大家的思维中的，那么将这些 `Linux` 系统变成服务自动启动它也是顺理成章的事了。



非常简单，只需加个参数一条命令就可以搞定。

```
colinux-daemon @*.conf --install-service "Linux Name"
```



比如本文中将 `Ubuntu12.04` 注册为服务可以这样子。

```
colinux-daemon @C:\colinux\base.conf --install-service "Ubuntu12.04"
```

图32



同样非常简单，将 `install-service` 换成 `remove-service` 就可以注销服务。

```
colinux-daemon --remove-service "Linux Name"
```



比如本文中将 `Ubuntu12.04` 再注销掉可以这样子。

```
colinux-daemon --remove-service "Ubuntu12.04"
```

图33



简单是简单，不过我们还需要注意两点。

一是必须以管理员权限执行命令，注册服务肯定是要有管理员权限的对吧。

二是注销服务不需要加上配置文件参数，并且服务名称务必要与之前注册时的一致。



注册好服务后就可以对服务进行操作了，用命令方式或图形操作方式都可以，完全看你心情啦。

```
// 启动服务
net start "Ubuntu12.04"

// 停止服务
net stop "Ubuntu12.04"
```



### 写在最后

有的小伙伴可能会问，还有 `SSH` 和磁盘共享啥的，你咋就不写了呢？

其实吧，网络都给搞通了，服务也起来了，剩下的那些还用多说吗？

所以说就此结尾，之后怎么玩就看小伙伴们各自如何发挥了。

不得不说，`CoLinux` 这个项目还是很有特色的，走的路线、实现的思路也与虚拟机完全不同，值得我们借鉴和学习。

不过根据官网上的文档更新状态，我们也能看出来，有好长时间没有更新和支持了，如果就这样放弃着实有些可惜了。

最后还是希望有大神们出来组织一下，重新让 `CoLinux` 活跃起来，希望他能有一个更好更新的明天！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
