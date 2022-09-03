服务器没网不再怕，带你轻松搞定 Linux 程序离线安装

副标题：服务器没网不再怕，带你轻松搞定 Linux 程序离线安装

英文：

关键字：离线,offline,安装,install,linux,mysql,yum,dnf,依赖,downloadonly,yumdownloader,rpm







`RPM` 安装包下载链接：

```
https://dev.mysql.com/downloads/repo/yum/
```



`MySQL` 的仓库安装包，有了它我们就可以使用 `YUM/DNF` 来联网安装 `MySQL` 了。

```
mysql80-community-release-el8-4.noarch.rpm
```



检查一下 `MySQL Yum` 存储库是否成功添加到我们的系统中。

```
dnf repolist enabled | grep "mysql.*-community.*"
```

图a04



或者直接看看 `repo` 文件里面的内容。

```
vim /etc/yum.repos.d/mysql-community.repo
```

图a06



再来查看一下 `MySQL Yum` 仓库中的所有 `MySQL` 的子仓库。

```
dnf repolist all | grep mysql
```

图a05



在这里我们需要注意一点，官方将最新的 `GA` 系列设定为默认安装版本。

目前最新的是 `MySQL 8.0` ，因此默认被安装的就是 `8.0` 版本，将来如果最新变成 `8.1` 或 `9.0` ，那么默认就安装 `8.1` 或 `9.0` 。

因此，当你需要安装非最新版本时，需要禁用启用相应的版本才行。

比如我们禁用子仓库中的 `5.7` ，同时启用 `8.0` 。

```
dnf config-manager --disable mysql57-community
dnf config-manager --enable mysql80-community
```



最后确认启用的仓库是否就是我们希望的那个样子。

```
dnf repolist enabled | grep mysql
```



好，一切准备就绪，重要就要来了！



### 安装

通常安装

```
dnf install mysql-community-server
```

包括了 MySQL 服务器安装包 `mysql-community-server` ，客户端工具 `mysql-community-client` 、服务器错误消息和字符集 `mysql-community-common` 和共享客户端库 `mysql-community-libs` 。

 

### 禁用默认的 `MySQL` 模块

当前面的工作准备就绪，你满心欢喜地开始安装 `MySQL` 时却发现报错了！

图b04



发生了什么事，难道前面的操作有问题？

其实这个并不奇怪，我还需要再做一步简单的操作——禁用默认 `MySQL` 模块。

基于 `EL8` 的系统包含有默认启用的 `MySQL` 模块，而如果它是启用状态的话，那么我们前面安装的  `MySQL` 仓库就会被屏蔽，从而无法安装 `MySQL 8.0` 。

不过请注意，禁用默认模块仅限 `EL8` 系统，比如 `CentOS8` 、`RockyLinux8` 等等。

```
dnf module disable mysql
```

图b03



### 下载安装依赖包

然后我们再利用 `dnf` 的 `deplist` 选项查看一下安装 `mysql-community-server` 所需的依赖情况。

```
dnf deplist mysql-community-server
```

图b05



不过 `deplist` 只是看看并没有真动手，所以我们要动动小手真地将这些依赖包给下载下来。

首先，新建一个用于存放依赖安装包的目录。

```
mkdir /sysadm/mypackages
```



然后，安装 `Yumdownloader` 工具。

```
dnf install yum-utils
```

停，停，停！注意、注意，其实你根本不用安装它！

因为你完全可以直接使用 `dnf download` ，你都用 `EL8` 系统了，效果完全一样啊！

```
dnf download --resolve --destdir=/sysadm/mypackages/ mysql-community-server
```

* `--resolve` - 解析并下载相应的依赖安装包
* `--destdir` - 下载的依赖安装包将存放到此参数指定的目录中

图b08





好了，确认一下载目录中的依赖包吧！

```
ls /sysadm/mypackages/
```

图b07



### 离线安装

依赖安装包全都拿到手了，接下来我们就让它们移驾到目标离线服务器上吧！

图c01



作为演示，我这边就找一台虚拟机，然后断开网络（拔网线）来模拟离线状态。

如图，我们正常安装时由于断网无法解析下载服务器而导致安装失败。

图c02



好，我们尝试使用离线安装方法。

具体怎么安装呢？

如果我们直接拉过来安装，那么因为部分依赖没有事先安装好从而导致失败。

图c03



但即使这些依赖包一个都不少，我们要是一个一个地安装肯定也得芭比Q！

还好，我们可以批量安装它们的时候选择强制跳过依赖检查，反正我都安装上，也不怕它使用时会因为缺少依赖而报错。

```
rpm -Uvh --force --nodeps *.rpm
```

图c04



为了保险起见，你可以再跑一次安装命令看看结果。

```
rpm -ivh mysql-community-server-8.0.xx-x.el8.x86_64.rpm
```

从结果看也没管我们再要过依赖啥的，完美搞定安装！

图c05



不放心的话再来跑一跑服务，看一看版本号。

图c06



### 写在最后



