用 Qemu 模拟 iPod Touch 上的初版 iPhone OS

副标题：用 Qemu 模拟 iPod Touch 上的初版 iPhone OS

英文：emulating-ipod-touch-and-iphoneos-using-qemu

关键字：ipod,emulating,qemu,iphone,iphoneos,苹果,macos



虚拟机技术现成已经很成熟了，平时我们玩的也不少，但是涉及到水果机方面的虚拟系统，多多少少就有点麻烦了。

虽然我不太清楚现在调试 `iPhone` 系统的主流方法是啥，但是最近我倒是偶然间看到有一位来自荷兰的大神，通过 `Qemu` 成功模拟出了 `iPod Touch` 上的初版系统 `iPhoneOS 1.0` 。



众所周知， `Qemu` 可以实现完全的软件级虚拟，换句话说，它不像 `VMWare` 或 `VirtaulBox` 等虚拟软件需要先开启硬件的虚拟化支持设置。

此外，水果机的硬件比较难模拟，虽然可以模拟，但是总有这样那样的问题，这个玩过虚拟机的小伙伴们也多少应该有点印象吧？

那么水果手机系统呢？

现在这两者相遇时，奇妙的事情也就发生了......



现在是2023年，时间回到一年多以前，来自荷兰的大神 `Martijin` （以下简称为 `M` 哥）开始尝试使用 `Qemu` 来模拟 `iPod Touch 1G` 。

所谓虚拟无非就是用软件模拟成硬件，但模拟水果硬件很明显是一个非常大的挑战。

经过数月的逆向工程以及 `GDB` 无数次的调试运行，`M` 哥终于弄清楚了各种硬件组件的规格。

于是我们现在终于看到了第一版的 `iPhoneOS 1.0` 模拟固件！



大神 `M` 哥的博客中，大致分为两篇博文具体地讲述了实现方法。

```
https://devos50.github.io/blog/2022/ipod-touch-qemu/
https://devos50.github.io/blog/2022/ipod-touch-qemu-pt2/
```



由于内容太过专业，我是上了呼吸机才勉强看完的，请诸君慎入！

为了您的发际线安全，仅供内心饱含热情兴趣度99.9%以上并且发量充足的小伙伴们参考。



`M` 哥博客上也给出了系统实现的演示视频，无法观看的小伙伴不用担心，文末我已经打包到下载文件中了。

```
https://devos50.github.io/assets/video/ipod_touch.mov
```



除博客之外， `M` 哥还创建了与之相关的  `Github` 项目（`Qemu` 分支）。

```
https://github.com/devos50/qemu/tree/ipod_touch_1g
```



我怕下次呼吸机租金涨价，于是索性一口气把 `Github` 项目也给过目了一遍。

不看不要紧，一看呼吸机差点报警，还好我把大概的方法给记下来了。

其实大概的原理就是通过自定义编译 `Qemu` ，将 `iPhoneOS` 所需硬件直接编译成 `Qemu` 模拟器，有点定制专用模拟器的意思。

接下来我就给小伙伴们简单捋一捋，怎么用 `Qemu` 模拟出 `iPhoneOS 1.0` 哈！

如果有什么错误或不足，还请看在呼吸机的份上，友善提出哈！



首先我想要说的是，最初我妄想使用 `Windows` 来实现模拟，结果你懂的，我被狠狠打脸了。

原因无他，`Windows` 平台缺这缺那，一会儿缺编译器，一会儿缺 `python` ，总之我白白折腾了半天而根本用不了。

当然，`Linux` 也是白折腾，`M` 哥在其博客上写得很清楚，仅在 `MacOS` 上测试过（不早说，都是泪！）。

图01



既然是 `MacOS` 那就好办多了，好办...

好办个P...问题是我没有水果机啊！

上哪去弄呢，还好天无绝人之路，我有虚拟机啊！

我只要先虚拟一个 `MacOS` ，然后再来用 `Qemu` 模拟不就行了？

能行吗，最终我还真是这么做的，也成功了，因为 `Qemu` 是不依赖于硬件虚拟支持的。



懂了吧，你应该先有一个 `MacOS` 系统，至少也得是个虚拟系统。

OK，准备好了吗？

接下来并不太难，Let's go！



为了安装各种缺失的程序包（比如 `Git` ），我们先要安装上 `brew` 。

使用如下命令安装 `brew` 。

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

图02



或者

```
/bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
```

前者是官方命令，后者则是连接到国内的 `gitee.com` 上安装。

如果官方连接失败的话，可以替换使用 `gitee.com` 的安装源。

图03



此外在安装过程中如果出现连接 `raw.githubusercontent.com` 失败的情况，那么多半是域名污染的问题。

解决的方法也很简单，在 `etc/hosts` 文件中手动添加正确的 `IP` 地址解析。

```
185.199.110.133 raw.githubusercontent.com
```



完成安装后就可以大胆地使用 `brew` 来安装缺失的程序包了。

比如：

```
brew install git
```

图04



之后可能还要安装一些编译必需的程序包，比如：

```
brew install ninja
brew install sdl2
brew install meson
brew install pixman
brew install glib2
```



当然具体缺少并需要安装哪些程序包，则取决于你电脑的实际情况。

所需程序包都安装好后，我们就可以开始编译工作了。



首先，克隆 `M` 哥的 `Github` 项目，并切换到 `ipod_touch_1g` 分支。

```
git clone https://github.com/devos50/qemu
cd qemu
git checkout ipod_touch_1g
```



其次，按照如下命令行开始编译 `Qemu` 。

```
mkdir build
cd build

sudo ../configure --enable-sdl --disable-cocoa --target-list=arm-softmmu --disable-capstone --disable-pie --disable-slirp --extra-cflags=-I/usr/local/opt/openssl@3/include --extra-ldflags='-L/usr/local/opt/openssl@3/lib -lcrypto'

sudo make
```

图05

图06

图07

图08



OK！只要不缺啥，编译就会顺利完成。

最后，我们就可以运行这个编译好的 `Qemu` 模拟器啦！

```
./arm-softmmu/qemu-system-arm -M iPod-Touch,bootrom=<path to bootrom image>,iboot=<path to iboot image>,nand=<path to nand directory> -serial mon:stdio -cpu max -m 1G -d unimp -pflash <path to NOR image>
```

图09



上面的命令行中有好几个参数是用尖括号括起来的，分别是 `bootrom` 、 `iboot` 、 `nand` 和 `nor` 。

这些都是啥呢？



* `bootrom` - 引导程序
* `iBoot` - 引导加载程序
* `nand` - 基于 `IPSW` 固件文件修改的映像
* `nor` - `pflash` 映像



具体的我也不懂，想要研究深一些的小伙伴还是请到网上学习研究吧！



编译及模拟所需的映像文件，我打包在此供小伙伴下载。

**iPod Touch 1G Emulation Files（含官方演示视频）**

下载链接：https://pan.baidu.com/s/1nNzVlDq6swEWPV2lP33WaQ

提取码：3kai



最终我这儿算是编译成功，启动模拟器也成功了。

来张动态效果图，省得有人说我忽悠，哈哈！

图10.GIF



启动时需要多等一会儿，也不知道是虚拟机性能的问题还是 `iPhone` 启动就慢，小伙伴们可以自行体验哈！

由于时间仓促，简单的测试体验就到先写这儿了。

关于这个项目的一些具体操作细节，比如手动定制映像等等，大家可以前往官网进行研究。

呼吸机快到期了，最后希望大神 `M` 哥能继续有新的研究突破，同时也祝各位小伙伴们测试成功！



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc