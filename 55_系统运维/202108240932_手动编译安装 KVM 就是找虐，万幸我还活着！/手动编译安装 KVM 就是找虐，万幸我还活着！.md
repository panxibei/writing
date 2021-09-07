手动编译安装 KVM 就是找虐，万幸我还活着！

副标题：总结纷繁复杂的 KVM 手动安装步骤~

英文：compiling-and-installing-of-kvm-is-very-troublesome-thanks-god i-am-still-alive

关键字：kvm,qemu,xen,libvirt,libvirtd,virt-viewer,virt-manager,virtmanager,virt



玩过虚拟机的小伙伴们多少应该听说过 `KVM` 吧。

虽然它和 `Keyboard Video Mouse` 的缩写一样，但我们今天要分享的可不是那个用来连接显示器和键盘鼠标的机房设备。

`KVM` 即`Kernel-based）Virtual Machine` ，是基于 `Linux` 的一种开源虚拟化技术。

除了 `VMware` 、 `VirutalBox` 和 `HyperV` 之外，`KVM` 也是非常流行的虚拟解决技术方案。

关于 `KVM` 的安装，相信很多小伙伴们多半是通过像 `yum` 或 `apt-get` 之类的软件包管理命令来安装的。

使用软件包管理命令来安装有很多好处，比如自动解决程序依赖问题。

但是它也有些缺点，比如官方源支持程序的版本较低，可能有部分功能没有被支持，从而导致我们无法正常使用一些新功能。

好了，我忙中抽空，挑战了一把完全使用手动编译的方法来安装 `KVM` 。

赶快一起来看看，我在这个过程中是怎么被虐的吧！



### 环境背景及安装目标：

* `Rocky Linux` `8.4` 内核 `4.18`
* `ninja` `1.10.2`
* `Python` `3.9`
* `QEMU` `6.0.94`
* `libvirt` `7.6.0`
* `virt-manager` `3.2.0`



我们需要安装的大概一共有三大块，分别是 `QEMU` 、 `libivrt` 以及 `virt-manager` 。

`KVM` 是 `Linux` 自带的，不需要我们安装了，我们主要把这三大块给搞定就行了。



### 切换更新源

如果你嫌官方源速度慢，也可以考虑用国内的源。

```
# 切换为上海交通大学的更新源
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.sjtug.sjtu.edu.cn/rocky|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-*.repo

# 生成缓存
dnf makecache
```



### 所需组件

```shell
dnf install tar unzip bzip2 make wget curl curl-devel gcc gcc-c++ automake autoconf libtool pixman pixman-devel zlib-devel lzo-devel glib2-devel pam-devel python39 python39-devel

dnf config-manager --set-enabled powertools
dnf install libfdt-devel SDL SDL-devel SDL2 SDL2-devel vte291-devel
dnf install libevdev-devel spice-* xorg-x11-server-Xspice libssh-devel
```



### 安装 `ninja`

项目下载链接：https://github.com/ninja-build/ninja/releases



**ninja-linux.zip(100K)**

本地下载：https://pan.baidu.com/s/1zdjoZaTw7bia0r2zG_Q6mQ

提取码：6pzq



直接下载解压缩，得到一个可执行文件

https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip

```shell
wget https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip
unzip ninja-linux.zip
mv ninja /usr/bin/
```



### 第一大块：安装 `QEMU`

`QEMU` 是创建虚拟机的关键，它其实可以理解为虚拟机模拟器，我们跑的虚拟机就是它在工作。

如果你用 `yum` 或 `apt` 来安装官方源中的 `QEMU` ，那么你就会发现它的版本是 `4.2` ，而官方当前版本是 `6.x` ，足足高了两个版本。

怎么猜这版本的差距也包含了不少的功能增加和性能提升吧，我没有仔细阅读官方文档，纯粹主观臆断哈，小伙伴们不要介意。

好，本文的目的就是要打破现状启用新版，所以我们直接上手安装 `6.x` 版吧！

> 官方下载链接：https://www.qemu.org/download/



以当前最新版本 `6.1.0-rc4` 为例，按以下步骤安装即可。

```shell
wget https://download.qemu.org/qemu-6.1.0-rc4.tar.xz
tar xvJf qemu-6.1.0-rc4.tar.xz
cd qemu-6.1.0-rc4
./configure
make
make install
```



由于文件数量众多，所以编译会需要比较长的时间。

安装完成后，再做几个软链接好方便调用命令。

```shell
ln -s /usr/local/bin/qemu-system-x86_64 /usr/bin/qemu-kvm
ln -s /usr/local/bin/qemu-system-x86_64 /usr/libexec/qemu-kvm
ln -s /usr/local/bin/qemu-img /usr/bin/qemu-img
```



查看一下当前 `QEMU` 版本，我这儿显示是 `6.0.94` 。

```shell
# qemu-img 是用来管理镜像文件的
qemu-img --version

# qemu-kvm 是用来管理虚拟机的
qemu-kvm --version
```



### 第二大块：安装 `libvirt`

官方文档说得比较文绉绉，不太容易理解，我个人的理解是，这个 `libvirt` 是用来管理和控制前面我们安装的 `QEMU` 的。

虽然 `QEMU` 拥有自己的命令，可以创建、启动虚拟机，但实际上管理虚拟机是非常复杂的，包括网络、磁盘等管理，所以说通常我们还是要用 `libvirt` 来管理虚拟机，毕竟它相对比较强大、全面、并且完善一点点。

作为小白，我也就了解这么一丢丢，复杂的也不懂，如果你有兴趣，可以花点时间去啃一啃官方文档。

好了，打起精神，这个 `libvirt` 可不好对付，要小心，开始罗！



##### 安装所需组件

```shell
# X11 服务端，图形化界面所需
dnf install xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps

dnf install cyrus-sasl-devel device-mapper-* gnutls-devel libxml2-devel dnsmasq dnsmasq-* libxslt libtirpc-devel libpciaccess libpciaccess-devel yajl-devel libacl-devel libattr-devel audit-libs-devel libblkid-devel fuse-devel fuse3-devel fuse3-libs libnl3-devel libiscsi-devel

pip3 install meson rst2html5 jsonschema==3.0.2

dnf install cyrus-sasl-devel device-mapper-* gnutls-devel libxml2-devel dnsmasq dnsmasq-* libxslt libtirpc-devel
```



安装 `rpcgen` 及 `portable-rpcgen` 。

```shell
dnf install dnf-plugins-core

# 或者也可以编辑 /etc/yum.repos.d/Rocky-PowerTools.repo 将 enabled=0 改成 1。
dnf config-manager --set-enabled powertools

dnf install rpcgen --enablerepo=powertools
```



在这儿我要友情提示一下，编译 `libvirt` 时需要用到 `python38` 以上版本，否则会出现各种难以描述的错误。

而 `YUM` 默认官方源安装为 `python36` 版本，所以不能支持使用。



##### 安装驱动程序

这个驱动程序是指 `libvirt` 联动 `QEMU` 的接口程序。

如果没有这些驱动，那么很可能有些功能就不支持了，默认情况下不安装的话，`libvirt` 也只提供一些基本的接口驱动。

我手动打包了这些驱动程序，虽然不全，但是基本上已经包括了大部分的功能，如果有特殊需求你也可以自行追加。

追加后别忘记还要再次编译安装一次 `libvirt` 才能生效。

```
unzip libvirt-daemon-drivers.zip
cd libvirt-daemon-drivers
rpm -ivh --nodeps libvirt-daemon-*
```

**libvirt-daemon-drivers.zip(2.15M)**

打包下载：https://pan.baidu.com/s/1F-q6QniOol-AHQhgPLtRRQ

提取码：by0m



##### 安装 `libvirt`

打开 `libvirt` 官网，按说明步骤安装，此处以 `libvirt-7.6.0` 版本为例。

官网链接：https://libvirt.org/compiling.html

```
wget https://libvirt.org/sources/libvirt-7.6.0.tar.xz
tar xvJf libvirt-7.6.0.tar.xz
cd libvirt-7.6.0
meson build --localstatedir=/var
ninja -C build
ninja -C build install
```



整个安装过程有可能会非常不顺利，这毫不夸张，不是缺这个模块就是缺那个模块，甚至一时半会儿还不知道怎么填上坑。

不过别着急，可以通过编译时给出的结果来查看并判断是否有模块被正常识别。

同时可以使用以下命令来启用或禁用某些模块。

```shell
# 查看开关参数
meson configure

# 举例，当你需要重新配置时可以这样
# 配置目录在 ./build，同时开启 driver_qemu 支持（默认都是开启的）
meson --reconfigure --localstatedir=/var -Ddriver_qemu=enabled ./build
```



OK，如果你遇到什么迷之报错，那么可以先来看看下面我遇到过的这些坑。

感叹这部分的坑是真的多，深不可测，异常磨人，现举例如下，以供参考。



##### 坑一：`sock` 文件生成路径不同之迷

在后续使用 `virt-manager` 连接 `libvirt` 之时，可能会遇到如下图提示的错误。

图01



这是由于 `virt-manager` 找不到 `libvirt-sock` 文件造成的。

然而事实上这个文件已经正常生成，只是其路径跑到了 `/var/local/run/libvirt/` 之中，而 `virt-manager` 却硬要在 `/var/run/libvirt/` 里乱找，结果自然是一无所获，找了个寂寞，最后以失败报错而告终。



我翻遍了整个互联网，找了一个方法，说是可以通过修改 `libvirt` 的配置文件，改变其生成 `sock` 文件的路径来解决。

```
vim /usr/local/etc/libvirt/libvirtd.conf
```

定位到 `unix_sock_dir` 一项，并按如下修改其参数。

```
# unix_sock_dir = "/var/local/run/libvirt"
unix_sock_dir = "/var/run/libvirt"
```

图02



修改好后，`virt-manager` 的确可以正常连接到 `libivrt` 了，可是心情大好之后好景不长。

令人遗憾的是，`virsh` 等命令却无法正常使用，因为那么一修改，它们倒反而找不到原来的 `sock` 文件了。

我的天啊，疯了，我折腾了快一个星期才终于找到了终极解决方法，让我吐会儿血先......

解决方法很简单，即在编译 `libvirt` 时加上 `--localstatedir=/var` 参数即可（前面已经给出命令），这样 `sock` 文件就不会跑到 `/var/local/run/libvirt` 目录中去了。

大喜过望之后，我多吃了两碗饭！



##### 坑二：需要手动修改源代码之迷

在编译过程中，屡次出现以 `html.in` 结尾的文档中的语法报错。

图03



解决方法很简单，只是有点费时间，编辑一堆 `html.in` 结尾的文件，修改大概第17行，将 `--` 修改成 `-` 即可。

```
vim build/docs/manpages/virkeycode-atset1.html.in
```



源代码还要自己修改，真新鲜哈，不过看那样子像是编译出来的文件，两个减号与注释符冲突造成了报错，看样子编译器识别有待改善啊！

需要修改的文件挺多，要有耐心，因为这是后续编译产生的文件，所以我也不方便打包给大家了，抱歉了，请大家自行修改吧。

修改完毕后再来编译就可以正常通过了。

可能需要修改的文件。

```
./build/docs/manpages/virkeycode-atset1.html.in
./build/docs/manpages/virkeycode-atset2.html.in
./build/docs/manpages/virkeycode-atset3.html.in
./build/docs/manpages/virkeycode-linux.html.in
./build/docs/manpages/virkeycode-osx.html.in
./build/docs/manpages/virkeycode-qnum.html.in
./build/docs/manpages/virkeycode-usb.html.in
./build/docs/manpages/virkeycode-win32.html.in
./build/docs/manpages/virkeycode-xtkbd.html.in
./build/docs/manpages/virkeyname-linux.html.in
./build/docs/manpages/virkeyname-osx.html.in
./build/docs/manpages/virkeyname-win32.html.in
```



##### 一些后续处理

成功安装 `libvirt` 后，因为其自带 `libvirtd.service` ，所以我们可以直接使用 `systemctl` 来管理 `libvirtd` 程序。

```shell
# 重启或用以下命令重新加载服务配置
systemctl daemon-reload

# 启用 libvirtd 等服务，通常只要第一个就行，其他视情况启用
systemctl enable libvirtd
systemctl enable libvirt-guests
systemctl enable virtinterfaced
systemctl enable virtlockd
systemctl enable virtlogd
systemctl enable virtlxcd
systemctl enable virtnetworkd
systemctl enable virtnodedevd
systemctl enable virtnwfilterd
systemctl enable virtproxyd
systemctl enable virtqemud
systemctl enable virtsecretd
systemctl enable virtstoraged
systemctl enable virtvboxd

# 查看 libvirtd 状态，其他服务类推
systemctl status libvirtd

# 启动 libvirtd 状态，其他服务类推
systemctl start libvirtd

# 停止 libvirtd 状态，其他服务类推
systemctl stop libvirtd
```



当然，你也可以不通过 `systemctl` 而直接使用命令启动它。

```
# -d 为后台运行
libvirtd -d
```



服务启动后，会在 `/var/run/libvirt` 下产生几个 `sock` 文件。

图04



如果出现如下错误提示，应该是 `virtlogd` 没有启动，启动之即可解决。

```
systemclt start virtlogd
```

图05



### 第三大块：安装 `virt-manager`

`virt-manager` 是我等小白常用的用于创建和管理虚拟机的图形管理程序。

这玩意使用起来方便不少，但是安装它也是令人痛苦万分，希望大家少走弯路。



官方下载链接（建议使用 `Github` 上的最新版）：

https://virt-manager.org/download/sources/virt-manager/virt-manager-3.2.0.tar.gz



安装说明：

https://github.com/virt-manager/virt-manager/blob/master/INSTALL.md



##### 先决条件

* `gettext` >= `0.19.6`
* `python` >= `3.4`
* `gtk3` >= `3.22`
* `libvirt-python3` >= `0.6.0`
* `pygobject3` >= `3.22`
* `libosinfo` >= `0.2.10`
* `gtksourceview3` >= `3`



##### 安装所需组件

```shell
dnf install gtk-update-icon-cache
dnf install rpm-build intltool
dnf install python3-devel python3-docutils
dnf install libosinfo gtksourceview3

# 安装 gtksourceview4 时需要
dnf install vala

dnf install pygobject3-devel
dnf install libvirt-glib gtk-vnc2
pip3 install Pygi gobject PyGObject
```



##### 安装 `gtksourceview4`

最新版本好像是 `4.8` ，但是它的依赖要求太高，我折腾了很久也没搞定，无奈选择了较低版本的 `4.6` 。

```
wget http://ftp.gnome.org/pub/gnome/sources/gtksourceview/4.6/gtksourceview-4.6.1.tar.xz
tar xvJf gtksourceview-4.6.1.tar.xz
cd gtksourceview-4.6.1
mkdir build && cd build
meson --prefix=/usr
ninja
ninja install
```



**gtksourceview-4.6.1.tar.xz（1.10M）**

本地下载：链接：https://pan.baidu.com/s/1ib6woV9qFXRNiy-dx4pC4w

提取码：odbu



##### 直接安装 `virt-manager`

在这儿建议尽量从 `github` 上下载，而不是从官网上，因为官网上可能并不是最新版，可能含有一些 `Bug` 。

```shell
sudo yum install rpm-build intltool
wget https://github.com/virt-manager/virt-manager/archive/refs/tags/v3.2.0.tar.gz
tar -zxvf v3.2.0.tar.gz
cd virt-manager-3.2.0
./setup.py install
```

如果你遇到了一些问题，可以先看看后面我写的坑，估计会有一些启发。



##### 通过生成 `rpm` 包来安装 `virt-manager`

由于直接使用源代码中的 `./setup.py install` 可能无法成功安装（原因很多，似乎作者都不这么建议）， 所以参考了某位国外网友的文章，通过生成 `rpm` 包来安装。

```
sudo yum install rpm-build intltool
wget https://github.com/virt-manager/virt-manager/archive/refs/tags/v3.2.0.tar.gz
tar -zxvf v3.2.0.tar.gz
cd virt-manager-3.2.0
./setup.py rpm
```



创建成功后，可以在当前目录的 `./noarch` 目录中找到 `rpm` 包。

```
virt-install-3.2.0-1.el8.noarch.rpm
virt-manager-3.2.0-1.el8.noarch.rpm
virt-manager-common-3.2.0-1.el8.noarch.rpm
```

一共三个文件，我们要用到的是第二个和第三个文件。

图06



使用 `yum` 或 `dnf` 安装后面这两个文件，这样可以解决一些文件依赖问题。

```shell
cd ./noarch

# 先安装 virt-manager-common
dnf install virt-manager-common-3.2.0-1.el8.noarch.rpm

# 再安装 virt-manager
# 如果发现 virt-manager 的版本不是 3.2.0 ,那么建议用 rpm 安装
# rpm -ivh --nodeps virt-manager-3.2.0-1.el8.noarch.rpm
dnf install virt-manager-3.2.0-1.el8.noarch.rpm
```



OK，接下来请出你们熟悉的坑坑坑。



##### 坑一：安装时出错，说什么 `gi` 模块没找到

```
>>> import gi
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'gi'
```

找了半天，才知道怎么安装这个倒霉组件，像下面这样就行了，呼呼......

```
dnf install cairo-devel cairo-gobject-devel
pip3 install Pygi gobject PyGObject
```



##### 坑二：`virt-manager` 无法正常启动，出现类似如下的错误

```
[root@localhost virt-manager-3.2.0]# Unable to init server: Could not connect: Connection refused
Unable to init server: Could not connect: Connection refused
Unable to init server: Could not connect: Connection refused

(virt-manager:99226): Gtk-WARNING **: 12:31:50.650: cannot open display:
```



这类问题说来尴尬，应该是显示服务没有正常启动造成的。

如果你正常安装了 `X11` 服务端，那么重启服务器，或检测 `X11` 服务端有无正常启动，一般情况下都能解决。



##### 坑三：只要点击到磁盘或光驱就总是提示错误

```
TypeError: Argument 1 does not allow None as a value
```

 图07



这个错误好像是程序代码中 `Python` 语法的问题，由于较旧版本的 `pygobject` 无法正确处理 `set_active(None)` ，也就是说其参数不能为 `None` 。

```
参考链接：https://github.com/virt-manager/virt-manager/issues/188
```



这个问题起初困扰了我很久，甚至我都找到答案了却还不自知，一度颇费周折。

后来通过反复查验和测试，最后才发现我所做修改和测试的顺序搞错了。



首先，打开并编辑以下文件。

```shell
vim /usr/share/virt-manager/virtManager/device/addstorage.py
```

其次，在此文件大致第313行处，将原有代码追加 `bool()` 函数，如下。

```
# 原来的样子
removable = disk.removable

# 最终修改的样子
removable = bool(disk.removable)
```

图08



**最后，修改完成后，切记一定要关掉 `virt-manager` ，然后再重新打开测试。**



其实还要补充一点，`virt-manager` 使用的是 `python36` ，如果你用的是 `python39` 就会报各种错误，真是要吐了。



### 写在最后

经过一场场艰苦卓绝的战斗，我终于拿下了手动编译安装 `KVM` 的这块阵地！

虽然我已经被虐得体无完肤，但是至少我已经尝遍了各种酸甜苦辣。

擦干眼泪，继续前行！

亲爱的小伙伴们，到此为止我已经把全部过程分享出来了。

OK，请你们大声告诉我，你们都学废了吗？！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

