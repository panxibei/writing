QuickGUI

副标题：

英文：

关键字：



众所周知，现在的虚拟机非常强大，应用也十分的广泛，并且被人们所熟知的那几款老三强都快被人玩烂了。

你要问是哪三款，当然是业界赫赫有名的 `VMware` 、 `VirtaulBxo` 和 `QEmu` 这三位老大哥啦！

要说是它们是老三强，一点儿也不为过啊！

当然了，还有其他不少虚拟机软件也拥有不少用户，各有各的特色，可虚拟机软件已经非常成熟的现在，却仍然还有人想尽一切办法、竭尽一切所能，就是要玩个透彻、玩个地道。

这不近期我被推送了一则消息，于是 `QuickGUI` 就这样被印入了我的脑海。



`QuickGUI` 是什么？

在介绍这位兄台之前，我们需要先介绍一下他的两位哥哥。

一个名叫 `Quickemu` ，另一位名叫 `Quickget`  。

哦，他们都有同一个姓啊，就是 `Quick` 嘛！

没错，看来你们已经懂了一半了！



`Quickemu` 和 `Quickget` 是一对双胞胎，前面一位是用来启动并运行虚拟机的，后面一位则是用来下载虚拟机镜像及配置文件的。

很简单，他们平时都是一起行动的。

```
# quickget <系统类型> <系统版本>
quickget ubuntu-mate impish

# quickemu --vm <系统配置文件>
quickemu --vm ubuntu-mate-impish.conf
```

也就是说，`Quickget` 先将虚拟机所需的文件都下载下来，然后再由 `Quickemu` 去启动运行虚拟机。



那么 `QuickGUI` 能做什么呢？

虽然他要比那两位哥哥年轻一些，但其实他是一个颜值很高、性格又有些敖娇的帅哥。

前面两位哥哥能做的工作，他一个人就能全部搞定。

是的，你可以用 `QuickGUI` 来下载虚拟机文件，并通过他来启动虚拟机。

要知道，他可是自带 `GUI` 界面的哦，是不是很棒？



不过实际上那并不是他一个人的功劳，工作之所以如此轻松其实是背后有那两们哥哥在默默帮助和支持他。

实际上 `QuickGUI` 的正常运行必须要依赖 `Quickemu` 和 `Quickget` 。



### 安装 `Quickemu` 和 `Quickget`

单纯安装这哥俩儿是非常简单的。

Ubuntu 下可以这么干。

```
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt update
sudo apt install quickemu
```



其他 Linux 发行版可以这么干。

```
# 你需要先安装上 git
git clone --depth=1 https://github.com/wimpysworld/quickemu
cd quickemu
```



安装好后，两个命令就都有了，所以说他俩是双胞胎。

注意，对于其他发行版的 `Linux` 系统，在安装好 `Quickemu` 后最好建立好软链接，以方便调用命令。

```
sudo ln -s /path/to/quickemu /usr/bin/quickemu
sudo ln -s /path/to/quickget /usr/bin/quickget
```



### 安装 `QuickGUI`

安装这位帅哥也是灰常简单。

```
sudo add-apt-repository ppa:yannick-mauray/quickgui
sudo apt update
sudo apt install quickgui
```



其他发行版可以直接下载 `Release` 压缩包，然后解压后就能用了。

```
sudo wget https://www.github.com/quickgui/quickgui/releases/download/v1.1.5/quickgui-1.1.5.tar.xz
sudo tar xvJf quickgui-1.1.5.tar.xz
cd quickgui-1.1.5
```



当然了，给他建立一个软链接也不是个坏主意。

```
sudo ln -s /path/to/quickgui /usr/bin/quickgui
```



### 安装依赖

前面几位安装够简单吧？

但要想真正地能让他们派上用场，还是要安装一些依赖程序。

站稳了哈，别吓到，以下就是必须要安装的依赖。

* QEMU (6.0.0 or newer) with GTK, SDL, SPICE & VirtFS support
* bash (4.0 or newer)
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





```
./configure --enable-virtfs --enable-sdl
```





```
# 针对 virtfs
dnf install libcap-ng-devel libattr-devel

sudo apt install libcap-ng-dev libattr1-dev

# 针对 SDL2
dnf install SDL2*

sudo apt-get install libsdl2-dev

# 针对 gtk
sudo apt install libgtk-3-dev
```





```
sudp apt install libusb*
sudo apt install ccid
sudo apt install libcacard-dev
libpmem-dev
libdaxctl-dev
libzstd-dev
libsnappy-dev
libssh-dev
libxml2-dev
libnfs-dev
libiscsi-dev
libbrlapi-dev
libcurl4-openssl-dev
libaio-dev
xorg-dev
```

