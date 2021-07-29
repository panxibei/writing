

尝试微软自家出品的 Linux 系统 CBL-Mariner

副标题：微软有了自己的 Linux ？

英文：test-cbl-mariner-which-is-linux-from-microsoft

关键字：cbl-mariner,cbl,linux,ubuntu,redhat,microsoft,mariner,windows



微软的 `Windows` 系统上早就搭载了 `Linux` 系统，也就是传说中的 `WSL` 。

而这个 `WSL` 现在已经发展到了 `WSL2` ，并且支持了图形界面的 `Linux` 软件，其被称为 `WSLg` 。

可是令人意想不到的是，你听说过微软其实他们家还有自己的 `Linux` 系统吗？

微软有自己的 `Linux` ，啥时候的事，我怎么不知道？



其实 `WSL` 是怎么搞出来的，那肯定他们要有个测试的平台作为基础嘛，然后才能将 `WSL` 整合到 `Windows` 上。

对了，这个微软自家的测试平台 `Linux` 系统，它的名字就是 `CBL-Mariner` 。

别打我，我也是知道没几天，所以我立刻、马上动手开展实验。

感兴趣的小伙伴们一起来吧！



### 先决条件

我们需要做一些前期准备工作，不可能拉过来就搞 `CBL-Mariner` 。

它需要的东西还不少呢，比如以下这些东西你得准备好，当然我会告诉你怎么准备它们。

其基本原理就是先拿一台 `Ubuntu` 系统的电脑，在上面克隆下载 `CBL-Mariner` 项目，然后再通过相关配置命令创建生成我们需要的映像文件。



> 参考官网：https://github.com/microsoft/CBL-Mariner/blob/1.0/toolkit/docs/building/prerequisites.md



* Ubuntu 系统，官方演示版本为 `18.04` ，而我连带 `20.04` 版本也测试 OK 了。
* `GO` 运行环境
* `PYTHON` 运行环境
* `DOCKER` 容器环境
* 其他一些相关的小程序，比如 make、tar、git 等等



```shell
# 添加后备仓库以便安装最新版的 Go
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update

# Install required dependencies.
sudo apt -y install make tar wget curl rpm qemu-utils golang-1.15-go genisoimage python-minimal bison gawk parted git

# Recommended but not required: `pigz` for faster compression operations.
sudo apt -y install pigz

# Fix go 1.15 link
sudo ln -vsf /usr/lib/go-1.15/bin/go /usr/bin/go

# Install Docker.
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```



添加后备仓库以便安装最新版的 Go 。

图01



`Docker` 安装完成。

图02



这里要注意一下，在安装 `python-minimal` 时会报错，实际上是因为我们需要安装的是 `python2` 版本，系统默认认为你要的是 `python3` 版本，所以找不到而报错。

图03



那么我们可以这样安装它。

```
sudo apt install python2-minimal
```

如果你使用的是 `Ubuntu 18.04` 版本，则不会有这个报错，因为它默认就是 `python2` 版本。



接下来我们通过官网的“快速参考” `Quick Start Guide` 来把玩一下 `CBL-Mariner` 。

```
https://github.com/microsoft/CBL-Mariner/blob/1.0/toolkit/docs/quick_start/quickstart.md
```



### 克隆 `CBL-Mariner`

这一步很简单，在终端中输入以下命令行开始克隆 `CBL-Mariner` 。

```shell
# 克隆下载 CBL-Mariner 仓库
git clone https://github.com/microsoft/CBL-Mariner.git

# 切换目录
cd CBL-Mariner

# 同步到最新稳定版本，通常克隆完成即为最新稳定版
git checkout 1.0-stable
```

图04



由于下载速度太慢甚至会失败，可能有的小伙伴会等不及，所以我将这个项目打包放在这儿，你可以直接将它上传到 `Ubuntu` 系统中。

注意，这个打包文件不包含映像文件，后面我们才会创建。



**CBL-Mariner.7z (483M)**

下载链接：https://pan.baidu.com/s/1KbcC3UmbBg9zl6Sky-musA

提取码：4n10



### 创建虚拟映像文件 `VHDX` 和 `VHD`

`VHDX` 和 `VHD` 这两种格式的文件想必小伙伴们应该不陌生，它们都是虚拟磁盘文件。

在这儿我们要创建这两种格式的文件，可直接用于启动加载 `CBL-Mariner` 系统。

此外根据官介绍，映像文件所含已经编译的 `RPMs` 包文件都可以在以下链接仓库中找到。

```
https://packages.microsoft.com/cbl-mariner/1.0/prod/
```

有兴趣可以去看看，都是大部分 `Linux` 发行版常用的程序软件。

当然了，我们不必将这些软件包手动处理，官方已经帮我们准备好了配置文件，我们直接拿来用就可以生成包含这些软件包的映像文件了。



##### 创建 `VHD` 或 `VHDX` 映像文件

执行以下命令，可分别创建映像，其主要区别为一个是支持 `EFI` 启动而另一个 `legacy` 是支持传统启动的。

```shell
# 进入 CBL-Mariner 目录中，再切换到 toolkit 目录
cd toolkit

# 创建 VHDX 映像，它放在了 ../out/images/core-efi 中
sudo make image REBUILD_TOOLS=y REBUILD_PACKAGES=n CONFIG_FILE=./imageconfigs/core-efi.json

# Build VHD Image
# Image is placed in ../out/images/core-legacy
sudo make image REBUILD_TOOLS=y REBUILD_PACKAGES=n CONFIG_FILE=./imageconfigs/core-legacy.json
```



**注意，如果遇到无法正常安装 `golang` 时，可能是无法连接 `proxy.golang.org` 造成的。**

图05



科学的方法是，将 `go` 包管理代理由原网址 `proxy.golang.org` 更换为 `goproxy.cn` 。

可以这么干：

```shell
sudo go env -w GOPROXY=https://goproxy.cn
```



随后按前面介绍的命令正常创建映像就可以了。

在创建过程中，我们也能看到它在下载很多 `rpm` 包，这也正是前面说过的 `RPMs` 仓库的那些软件包。

只不过创建映像时它会自动下载打包，不需要我们人工干预，而且它下载一次就可以了，之后再生成映像会很快。

图06



此外，从上面的命令行中我们也能看出来，生成映像的配置文件官方已经是设定好的，存放路径就在 `./CBL-Mariner/toolkit/imageconfigs` 中。

实际上在这个路径下有很多配置文件，用哪个文件就能按照哪个的配置生成相应的映像文件。

图07



需要一点点耐心，创建完成会是这样。

`CBL-Mariner/out/images/core-legacycore-1.0.20210728.1236.vhdx`

图08



**core-legacycore-1.0.20210728.1236.vhdx (632.00M)**

下载链接：https://pan.baidu.com/s/1SZeNkkYjkkQFlvSAsqeRdQ

提取码：0qyv



`CBL-Mariner/out/images/core-legacycore-1.0.20210728.1250.vhd`

图09



**core-legacycore-1.0.20210728.1250.vhd (2.00G)**

下载链接：https://pan.baidu.com/s/1YFhYB-6aYCkdoTn2LeGBHw

提取码：gyok



##### 创建 cloud-init 配置映像

还有一点，刚才我们生成的 `VHDX` 也好或是 `VHD` 也好，这些映像只是个核心，默认并不包含用户。

所以想要让用户登录的话，还需要再生成一个用户数据映像，将这个映像加载到光驱，并通过光驱启动后就可以登录了。

生成这个用户数据映像很简单，一条简单的命令。

```shell
# 创建 cloud-init 配置映像
# 输出路径为 CBL-Mariner/out/images/meta-user-data.iso
sudo make meta-user-data
```



图10



**meta-user-data.iso (366K)**

下载链接：https://pan.baidu.com/s/1Qtgw1Qi2xLywUW7pmneW6w

提取码：5yqz



挂载 `VHD` 或 `VHDX` 映像，然后通过这个映像启动后，就可以用下面的用户名和密码登录 `CBL-Mariner` 系统了。

```
用户名：mariner_user
密码：p@ssw0rd
```



### 创建完整版 `ISO` 映像文件

前面搞得挺热闹，也挺复杂麻烦的，其实对于只是尝试用用 `CBL-Mariner` 的小伙伴来说，还有一个好办法，就是创建生成一个完整的可启动的 `ISO` 映像文件。

`ISO` 映像地球人都知道，直接挂载光驱即可启动安装系统了，简单粗暴疗效更棒！

那么这玩意咋整呢？

嘿嘿，官方还真有介绍，我们马上开干！



说简单是真简单，就一条命令完事。

```
# 切换到 toolkit 目录
cd toolkit

# 生成 iso 映像，它放到了 ../out/images/full 这个目录中
sudo make iso REBUILD_TOOLS=y REBUILD_PACKAGES=n CONFIG_FILE=./imageconfigs/full.json
```



这条命令挺眼熟不？

对了，除前面指定映像为 `iso` 外，后面的配置文件其实也是 `imagconfigs` 目录中的现成文件。

有了之前的下载的软件包缓存，这个映像生成很快就完成了！

图11



所有都完成后，你的 `Ubuntu` 上应该会有这样的目录和文件生成。

图12



**完整版可引导 full-1.0.20210728.1317.iso (677.03M)**

下载链接：链接：https://pan.baidu.com/s/11dEA6ceo292WynXYmdYdSg

提取码：25w0



### 尝试使用完整版 ISO 映像启动并安装 `CBL-Mariner`

我使用 `VirtualBox` 创建了一个虚拟机，当然你用 `VMWare` 也是一样的。

不过我的 `VirtualBox` 感觉和其他虚拟机有冲突，启动时死过两次机，所以建议用 `VirtualBox` 的小伙伴们最好只单开一个虚拟机来做测试。

这个虚拟机平台应该是哪个呢？

我感觉既然用了 `RPMs` 包，那么应该可以用 `RedHat` ，不过我用 `Ubuntu` 也通过了测试，所以只要是通常的 `Linux` 平台版本应该都可以。

好了，创建好虚拟机，然后挂载 `ISO` 文件，光驱启动。



不一会儿启动界面出现了，第三项是图形安装界面，我是小白我选它。

图13



我是小白，安装类型我就选完整安装。

图14



协议内容即使是空的我也得同意，主要是我不同意它也不给我点下一步啊。

图15



磁盘分区选项，没有啥特殊情况，我就先全部清除。

图16



主机名、用户名和密码，按自己喜欢的来。

注意密码要求挺高的，不要用弱密码，比如连续数字等。

图17



要开始安装了，挺激动的，按下“现在就安装” `Install now` 。

图18



安装起来并不慢，就几分钟吧。

图19



安装结束后还给出了耗费的时间，我这儿是 86 秒。

另外非图形界面下安装时，我这儿测试是用了 74 秒。

按下完成 `Done` 按钮，重启看看这个 `CBL-Mariner` 系统到底是个什么庐山真面目。

图20



系统启动了，输入用户名和密码登录进入系统。

图21



单单从这里可以看出 `Linux` 的内核版本是 `5.10` ，输入 `uname -a` 看看。

图22



### 写在最后

之后我又试试其他的，比如一些常见的命令，都没问题。

不过当我尝试修改它的 IP 地址时，发现静态地址设定后网络服务无法正常启动。

研究了半天，感觉应该是它是由 `docker` 驱动的，可能无法直接修改它的网络配置。

由于没有更多的时间，所以以后有空再进一步深入研究看看。

基本上这是一个具有一般 `Linux` 发行版通常功能的又一款发行版，正如微软官方所说，它是用于研究 `Linux` 与 `Windows` 整合功能的测试版本。

随着微软的努力，使得两者结合得更加紧密，比如 `WSL2` 在新版的 `Win10` 中已经支持图形界面软件。

> 参考文章：《WSLg 就是带 GUI 的 WSL》
>
> 链接：https://www.sysadm.cc/index.php/xitongyunwei/836-wslg-is-short-for-windows-subsystem-for-linux-gui



小伙伴们，如果你也有兴趣尝试一下微软家的 `Linux` ，那么可以参照本文来尝试。

同时为了节省时间，你也可以直接下载文中的映像文件直接测试。

如果你在此过程中发现什么其他有趣的东西，别忘记一起讨论，与大家分享！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc













