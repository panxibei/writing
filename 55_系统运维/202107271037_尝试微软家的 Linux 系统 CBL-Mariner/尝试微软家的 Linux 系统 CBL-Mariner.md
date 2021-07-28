

尝试微软家的 Linux 系统 CBL-Mariner







### 先决条件

我们需要做一些前期准备工作，不可能拉过来就搞 `CBL-Mariner` 。

它需要的东西还不少呢，比如以下这些东西你得准备好，当然我会告诉你怎么准备它们。

其基本原理就是先拿一台 `Ubuntu` 系统的电脑，在上面克隆下载 `CBL-Mariner` 项目，然后再通过相关配置命令创建生成我们需要的映像文件。



> 参考官网：https://github.com/microsoft/CBL-Mariner/blob/1.0/toolkit/docs/building/prerequisites.md



* Ubuntu 系统，官方演示版本为 `18.04` ，而我连带 `20.04` 版本也测试 OK 了。
* `GO` 运行环境
* `PYTHON` 运行环境
* `DOCKER`
* 其他一些相关的小程序，比如 make、tar、git 等等



```shell
# Add a backports repo in order to install the latest version of Go.
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







安装 `python-minimal` 时会报错，实际上是因为我们需要安装的是 `python2` 版本，系统认为的是 `python3` 版本，所以找不到而报错。

那么我们可以这样安装它。

```
sudo apt install python2-minimal
```





接下来我们通过官网的快速参考 `Quick Start Guide` 来把玩一下 `CBL-Mariner` 。

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



由于下载速度太慢甚至会失败，可能有的小伙伴会等不及，所以我将这个项目打包放在这儿，你可以直接将它上传到 `Ubuntu` 系统中。

注意，这个打包文件不包含映像文件，后面我们才会创建。

下载链接：





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

图b5

科学的方法是，将 `go` 包管理代理原网址 `proxy.golang.org` 更换为 `goproxy.cn` 。

```shell
go env -w GOPROXY=https://goproxy.cn
```

