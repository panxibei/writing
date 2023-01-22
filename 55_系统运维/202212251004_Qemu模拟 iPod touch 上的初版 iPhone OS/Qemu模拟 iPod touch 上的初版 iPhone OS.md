Qemu模拟 iPod touch 上的初版 iPhone OS

副标题：Qemu模拟 iPod touch 上的初版 iPhone OS

英文：

关键字：



Qemu模拟 iPod touch 上的初版 iPhone OS



大神博客

```
https://devos50.github.io/blog/2022/ipod-touch-qemu/
https://devos50.github.io/blog/2022/ipod-touch-qemu-pt2/
```



大神演示视频

```
https://devos50.github.io/assets/video/ipod_touch.mov
```



`Github` 项目（`Qemu` 分支）

```
https://github.com/devos50/qemu/tree/ipod_touch_1g
```





使用如下命令安装 `brew` 。

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

或者

```
/bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
```

前者是官方命令，后者则是连接到国内的 `gitee.com` 上安装。

图c01

图c02



如果出现连接 `raw.githubusercontent.com` 失败的情况，那么多半是域名污染的问题。

解决的方法也很简单，在 `etc/hosts` 文件中手动添加正确的 `IP` 地址解析。

```
185.199.110.133 raw.githubusercontent.com
```



完成安装后就可以使用 `brew` 来安装缺失的程序包了。

比如：

```
brew install git
```

图c03



之后可能还要安装一些必需的程序包，比如：

```
brew install ninja
brew install sdl2
brew install meson
brew install pixman
brew install glib2
```



当然具体缺少并安装哪些程序包则取决于你电脑的实际情况。





```
mkdir build
cd build

sudo ../configure --enable-sdl --disable-cocoa --target-list=arm-softmmu --disable-capstone --disable-pie --disable-slirp --extra-cflags=-I/usr/local/opt/openssl@3/include --extra-ldflags='-L/usr/local/opt/openssl@3/lib -lcrypto'

sudo make
```

图c04

图c05

图c06

图c07



运行模拟器

```
./arm-softmmu/qemu-system-arm -M iPod-Touch,bootrom=<path to bootrom image>,iboot=<path to iboot image>,nand=<path to nand directory> -serial mon:stdio -cpu max -m 1G -d unimp -pflash <path to NOR image>
```

图c08



来张动态效果，省得有人说我忽悠，哈哈！

图1.GIF

