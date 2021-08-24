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





### 所需组件

```
dnf install tar unzip bzip2 make wget curl curl-devel gcc gcc-c++ automake autoconf libtool pixman pixman-devel zlib-devel lzo-devel glib2-devel pam-devel

python3 python3-devel





dnf config-manager --set-enabled powertools
dnf install libfdt-devel SDL SDL-devel SDL2 SDL2-devel vte291-devel
dnf install libevdev-devel spice-* xorg-x11-server-Xspice libssh-devel
```



### 安装 `ninja`

项目下载链接：https://github.com/ninja-build/ninja/releases

本地下载：



直接下载解压缩，得到一个可执行文件

https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip

```
mv ninja /usr/bin/
```





### 安装 `QEMU`

官方下载链接：https://www.qemu.org/download/



以当前最新版本 `6.1.0-rc4` 为例。

```shell
wget https://download.qemu.org/qemu-6.1.0-rc4.tar.xz
tar xvJf qemu-6.1.0-rc4.tar.xz
cd qemu-6.1.0-rc4
./configure
make
make install
```



安装完成后，做几个软链接好方便调用命令。

```shell
ln -s /usr/local/bin/qemu-system-x86_64 /usr/bin/qemu-kvm
ln -s /usr/local/bin/qemu-system-x86_64 /usr/libexec/qemu-kvm
ln -s /usr/local/bin/qemu-img /usr/bin/qemu-img
```



查看一下当前 `QEMU` 版本。

```shell
# qemu-img 是用来管理镜像文件的
qemu-img --version

# qemu-kvm 是用来管理虚拟机的
qemu-kvm --version
```



### 安装 `libvirt`

##### 安装所需组件

```
X11安装
dnf install  xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
```



```
dnf install cyrus-sasl-devel device-mapper-* gnutls-devel libxml2-devel dnsmasq dnsmasq-* libxslt libtirpc-devel
```



```
pip3 install meson xsltproc rst2html5 jsonschema==3.0.2
```



安装 `rpcgen` 及 `portable-rpcgen` 。

```
dnf install dnf-plugins-core

# 或者也可以编辑 /etc/yum.repos.d/Rocky-PowerTools.repo 将 enabled=0 改成 1。
dnf config-manager --set-enabled powertools

dnf install rpcgen --enablerepo=powertools
```



打开 `libvirt` 官网，按说明步骤安装，此处以 `libvirt-7.6.0` 版本为例。

官网链接：https://libvirt.org/compiling.html

```
tar xvJf libvirt-7.6.0.tar.xz
cd libvirt-7.6.0
meson build --localstatedir=/var
ninja -C build
ninja -C build install
```



安装期间有可能会不太顺利，别着急，可以先看看下面的这些坑。

这部分的坑非常多，举例如下。

##### 坑一：sock 文件生成路径不同之迷。

在后续使用 `virt-manager` 连接 `libvirt` 之时，可能会遇到如下图提示的错误。

图k01



这是由于 `virt-manager` 找不到 `libvirt-sock` 文件造成的。

事实上这个文件已经正常生成，只是其路径跑到了 `/var/local/run/libvirt/` 之中，而 `virt-manager` 却在 `/var/run/libvirt/` 里乱找，结果肯定是一无所获，最终失败报错。



找遍了整个互联网，说是可以修改 `libvirt` 的配置文件，改变其路径来解决。

```
vim /usr/local/etc/libvirt/libvirtd.conf
```

找到 `unix_sock_dir` 一项按如下修改。

```
# unix_sock_dir = "/var/local/run/libvirt"
unix_sock_dir = "/var/run/libvirt"
```

图k02



修改好后，`virt-manager` 的确可以正常连接到 `libivrt` 了，可遗憾的是，`virsh` 等命令却无法正常使用，因为它们也找不到原来的 `sock` 文件了。

我的天啊，疯了，我测试了快一个星期才终于找到了解决方法，让我吐会儿血......

解决方法很简单，即在编译时加上 `--localstatedir=/var` 参数即可，这样 `sock` 文件就不会跑到 `/var/local/run/libvirt` 目录中去了。



##### 坑二：手动修改源代码之迷

以 `html.in` 结尾的文档中语法报错。

图k03



解决方法很简单，只是有点费时间，编辑 `html.in` 结尾的文件，修改大概第17行，将 `--` 修改成 `-` 即可。

```
vim build/docs/manpages/virkeycode-atset1.html.in
```



需要修改的文件挺多，要有耐心，因为这是后续编译产生的文件，所以我也不方便打包给大家了，大家自行修改吧。

修改完毕后再来编译就可以正常通过了。

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



成功安装 `libvirt` 后，因为其自带 `libvirtd.service` ，所以我们可以直接使用 `systemctl` 来管理 `libvirtd` 程序。

```shell
# 查看 libvirtd 状态
systemctl status libvirtd

# 启动 libvirtd 状态
systemctl start libvirtd

# 停止 libvirtd 状态
systemctl stop libvirtd
```



当然，你也可以不通过 `systemctl` 而直接使用命令启动它。

```
# -d 为后台运行
libvirtd -d
```



服务启动后，会在 `/var/run/libvirt` 下产生 `sock` 文件。

图k04



如果出现如下错误提示，应该是 `virtlogd` 没有启动，启动之即可解决。

```
systemclt start virtlogd
```



图k05



### 安装 `virt-manager`

下载链接：

https://virt-manager.org/download/sources/virt-manager/virt-manager-3.2.0.tar.gz



安装说明：

https://github.com/virt-manager/virt-manager/blob/master/INSTALL.md



先决条件：

* `gettext` >= `0.19.6`
* `python` >= `3.4`
* `gtk3` >= `3.22`
* `libvirt-python3` >= `0.6.0`
* `pygobject3` >= `3.22`
* `libosinfo` >= `0.2.10`
* `gtksourceview3` >= `3`



安装所需组件：

```shell
dnf install gtk-update-icon-cache
dnf install rpm-build intltool
dnf install python3-devel python3-docutils

# 安装gtksourceview4时要
dnf install vala

dnf install pygobject3-devel
dnf install libvirt-glib
```



##### 通过生成 `rpm` 包来安装 `virt-manager`

由于直接使用源代码中的 `./setup.py install` 无法成功安装， 所以参考了国外网友的文章，通过生成 `rpm` 包来安装。

```
sudo yum install rpm-build intltool
wget https://virt-manager.org/download/sources/virt-manager/virt-manager-3.2.0.tar.gz
tar -zxvf virt-manager-1.3.2.tar.gz
cd virt-manager-1.3.2
./setup.py rpm
```



创建成功后，可以在当前目录的 `./noarch` 目录中找到 `rpm` 包。

```
virt-install-3.2.0-1.el8.noarch.rpm
virt-manager-3.2.0-1.el8.noarch.rpm
virt-manager-common-3.2.0-1.el8.noarch.rpm
```

一共三个文件，我们要用到的是第二个和第三个文件。

图k06



使用 `yum` 或 `dnf` 安装后面这两个文件，这样可以解决一些文件依赖问题。

```shell
dnf install virt-manager-3.2.0-1.el8.noarch.rpm
dnf install virt-manager-common-3.2.0-1.el8.noarch.rpm
```



##### 坑来了：安装时出错，说什么 `gi` 模块没找到。

```
>>> import gi
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'gi'
```

找了半天，才知道怎么安装这个倒霉组件，像下面这样就行了，呼......

```
dnf install cairo-devel cairo-gobject-devel
pip3 install Pygi gobject PyGObject
```





### 写在最后

经过一场艰苦卓绝的战斗，我终于拿下了手动编译安装 `KVM` 的这块阵地！

不过有一些小遗憾的是，当我使用 `virt-manager` 时在点击磁盘类别的选项时（磁盘、光驱等），它会提示一个错误。

图k07



这个错误好像是 `Python` 语法的问题，挺尴尬的，我找了好久，修改了无数次文件也没有解决这个问题。

有大神指出，可能是 `Python` 版本的问题，这个我就不得而知了，以后有空再测试看看吧。

好了，亲爱的小伙伴们，到此为止我已经把全部过程分享出来了。

OK，请你们大声告诉我，你们都学废了吗？！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

