辞职后全职开发的操作系统 SerenityOS 到底是个怎样的系统

副标题：系统日益精进，毛发日益稀疏，长老好本事啊~

英文：how-about-serenityos-which-i-quit-my-job-to-focus-on-it-full-time

关键字：serenity,serenityos,os,linux,windows,andreas kling,andreas,kling



最近遇热的一款操作系统 `SerenityOS` 成功地被我注意到了！

近期这款系统位于 `GitHub` 排行榜第二的位置久居不下，认识它的人也越来越多。

这款系统有什么特别之处吗？

在多如牛毛的众多操作系统中，它其实并不是特别的亮眼，只不过它的出身有点与众不同。



一位来自瑞典的程序员 `Andreas Kling` ，辞职后用了将近三年的时间全身心地开发了这款 `SerenityOS` 。

很显然，他肯定是位编程高手，但最重要的是，他以一己之力、坚持不懈地完成了其他人都几乎无法完成的事情，这样看来他的确很酷对吧！

当然了，和其他系统类似，他走的也是类 `Unix` 路线，难能可贵的是，系统是带有图形界面的。

能摸到也能看到，这一点才是我们对它产生兴趣的重点之一。

于是我在看完新闻介绍之余，也实际按官方文档走了一遍。

> 官网文档链接：https://github.com/SerenityOS/serenity/blob/master/Documentation/BuildInstructions.md



### 准备工作

虽然 `Windows` 也可以做同样的事情，但是用它总是会带来一些麻烦，所以我还是用了 `Ubuntu` 和其他一些系统来做这件事。

除了 `Ubuntu` ，我已经成功实现了在 `Rocky Linux` 上跑 `SerenityOS` ，当然 `Debian/CentOS` 等等系统都是可以做到的。

OK，在此我就以 `Ubuntu 20.04` 为例来说明吧。



##### 先要安装一些依赖

```
sudo apt install build-essential cmake curl libmpfr-dev libmpc-dev libgmp-dev e2fsprogs ninja-build qemu-system-i386 qemu-utils ccache rsync genext2fs
```



安装 `gcc-10` 以上版本的编译器，如果版本低于 `20.04` ，那么要先加个东西。

```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt install gcc-10 g++-10
```



##### 安装 `QEMU 5` 以上版本 

据说 `Ubuntu 20.10` 是自带 `QEMU 5` 的，不过我的版本低了一点，默认好像是 `QEMU 4.2` ，还是要手动安装。

在此之前可能需要安装 `gtk+3.0` 依赖。

```
sudo apt install libpixman-1-dev libgtk-3-dev
```



有两种安装方法，一种是用 `SerenityOS` 项目中的 `Toolchain/BuildQemu.sh` 脚本来安装，还有一种是老老实实手动编译安装。

我是手动编译安装的 `QEMU 6.1-RC` ，很简单，具体可以参考我之前的文章。

> 文章参考链接：



### 构建在 `QEMU` 上能跑的 `SerenityOS`

将 `SerenityOS` 项目从 `GitHub` 上克隆下来。

```
# 如果没有 git，那么先安装它
# sudo apt install git
sudo git clone https://github.com/SerenityOS/serenity.git
```



构建项目，可能需要等待个十几分钟。

```
cd ~serenity
[serenity]$ sudo Meta/serenity.sh rebuild-toolchain
```



运行项目，启动成功后就能看到虚拟机了。

```
[serenity]$ sudo Meta/serenity.sh run
```

图01



根据官网文档的描述，系统会自动生成一个具有 `root` 权限的用户，名称为 `anon` ，密码为空。

如果要切换到 `root` 用户，只要在终端输入 `su` 即可。



刚启动好时，系统有个小问题，就是分辨率太大，导致看不到底下的开始菜单和状态栏。

我们可以这样做，右击桌面，选择 `Display Settings` ，然后选择 `Monitor` 选项卡，将 `Resolution` 一项修改为 `800x600` 。

图02



我相信当系统界面出现在你们眼前时，你们一定会非常激动。

不过嘛很多上伙伴手头上并没有 `QEMU` ，特意去装个 `QEMU` 其实挺麻烦也没有十分的必要。

那么我们能不能在诸如我们常用的  `VirtualBox` 或 `VMWare` 上跑一跑 `SerenityOS` 呢？

官网上说了，完全可以，于是我就把文档内容总结如下，分享给需要的小伙伴们。



### 在 `VirtualBox` 上跑 `SerenityOS`

##### 生成可启动映像

在 `SerenityOS` 构建好后，通过以下命令可以创建可启动映像。

```
[serenity]$ sudo ninja -C Build/i686 grub-image
```

命令完成后，在 `Build/i686` 目录中会生成一个 `grub_disk_image`  文件。



如果你遇到了困难，比如找不到 `grub2` 之类的，那么安装它就是了。

```
sudo apt install grub2
```





接着，你可以用一些命令将这个映像文件转成 `VirtualBox` 可识别的格式文件。

```
# 如果你有 QEMU，那么直接就可以转换了
qemu-img convert -O vdi Build/i686/grub_disk_image /path/to/serenityos.vdi

# 如果你只有 VirtualBox，那么就先拷贝 grub_disk_image，然后再用 VBoxManage 转换也行
VBoxManage convertfromraw --format VDI /path/to/grub_disk_image /path/to/output/serenityos.vdi
```



OK，最后你就得到了一个 `serenityos.vdi` 文件。

有了这个 `vdi` 文件就好办多了，我们只要将它作为磁盘启动起来就行了。

不过在此之前，我们还是要注意一些事项，接着往下看。



##### 2、创建虚拟机

官网上文档写得一套一套的，而且都是英文，看得眼疼，我给简化如下。

总而言之，创建的虚拟机只要满足以下条件即可。

1. 虚拟机版本选择 `Other/Unknown (64-bit)` ，切记不要选择 `Linux` 。

   图v01

   

2. 启用 `PAE/NX`。

   图v02

   

3. 存储控制器选择 `PIIX4` ，其他的可能会失败。

   图v03

   

4. 网卡仅支持 `Realtek` 之类的常见类型，但并不保证网络一定好用。

   图v04

   

5. 内存推荐256M以上。



一切如之前所说，自带小程序都还是可以用的，贪吃蛇、计算器、画图软件一样也不少。

其中那只酣睡的小猫，它会随时追踪你的鼠标，有点像过去桌面助手的赶脚。

图a03



**现成映像文件 `serenityos.vdi` (328M)**

下载链接：



### 在 `VMWare` 上跑 `SerenityOS`

> 参考链接：https://github.com/SerenityOS/serenity/blob/master/Documentation/VMware.md



和前面的 `VirtualBox` 差不多，先要有启动映像，然后再转成 `vmdk` 格式的磁盘文件即可。

```
qemu-img convert -O vmdk /path/to/grub_disk_image /path/to/output/serenityos.vmdk
```



虚拟机配置也类似，主要注意磁盘是 `IDE` 接口等等之类。

不过非常抱歉，我没有测试成功，文档里也写了，只测试通过了 `VMware Player 15` ，而我的是 `16` 。

有空有闲的小伙伴可以一试。



**现成映像文件 `serenityos.vmdk` (284M)**

下载链接：





### 网络设置

由于 `SenerityOS` 是在虚拟机里跑的，所以网络设置似乎还有些问题。

我测试的结果是，`DHCP` 似乎无效，需要手动指定 IP 地址，也不知道是不是由于网卡默认 `down` 的缘故。



手动设置 IP 地址的方法。

```
// 切换到 root 用户
$ su

// 设置 IP 为 192.168.1.123/24，网关 192.168.1.1
# ifconfig -i 192.168.1.123 -a ep0s3 -g 192.168.1.1 -m 255.255.255.0
```



`DNS` 默认没有开启，我找了好半天才发现应该是在这儿。

```
/etc/LookupServer.ini
```



在编辑这个文件之前，需要将它的属性改一改，要不然无法保存。

```
# chmod a+w /etc/LookupServer.ini
```



打开之后，修改之。

```
[DNS]
Nameserver=1.1.1.1,1.0.0.1
EnableServer=1
```

图a02



### 网站访问

有些遗憾的是，除了 `serenityos.org` 之外，大部分网页无法正常打开，尝试了访问几个大网站，都是提示加载失败。

图a06



通常 `http` 开头的网页似乎还勉强能看到个页面部分，但 `https`  开头的就几乎访问不了了。

图a05



从后台 `Debug` 窗口中可以看到是由于 `https` 加密证书无法被正常识别造成的。

还有就是字体、网络协议等等还不支持或不完善，看来这套系统还是有待进一步开发啊！





### 远程管理

在系统中运行 `TelnetServer` 命令开启 `Telnet` 服务端。

然后打开 `PuTTy` ，输入IP地址以及连接类型为 `Telnet` ，连接后可以远程管理 `SerenityOS` 了，也算是变相使用 `SSH` 了。

可惜只能敲敲命令，没有办法传输文件啊。

图a04



### 写在最后

我们有了前面说的映像文件，理论上可以将其写入到物理磁盘上，这样我们就可以用实体机启动 `SerenityOS` 了。

不过时间有限，我没空测试了，你们谁闲得难受可以考虑考虑。



最后我想对那些对 `SerenityOS` 作者冷嘲热讽的人说几句，即使是抄代码、套皮肤，那也得有强大的计算机底层理论知识做基础。

千万不要对一个热衷于计算机事业的人说三倒四，而自己却一无事处，那样只会被别人瞧不起。

每个人有每个人的位置，你有本事你就可以是大神，你没本事那你就好好拧螺丝。

螺丝拧得好，也是可以当劳模的哦！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc