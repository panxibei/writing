服务器没网不再怕，带你轻松搞定 Linux 下 `RPM` 程序离线安装

副标题：服务器没网不再怕，带你轻松搞定 Linux 程序离线安装

英文：dont-worry-about-that-server-is-offline-i-will-take-you-to-easily-install-rpm-packages-offline

关键字：离线,offline,安装,install,linux,mysql,yum,dnf,依赖,downloadonly,yumdownloader,rpm



"喂！坤儿！喂...醒醒...没事儿吧？"

同事小范不知怎么又昏过去了，当然大家不必紧张，这是加班常有的事。

可是这回似乎有点不一样了，小范同学醒来之后就莫名其妙地哭上了。

经过我们一番劝慰后他倒出了事情的原委......



原来今天一上班小范同学接到了某个客户的电话，说是需要安排给一台 `MySQL` 服务器升级。

服务器跑的是 `Linux` 系统，当前的 `MySQL` 版本是 `5.7` ，由于业务系统调整需要升级到 `8.0` 版本。

只不过有一个恼人的情况，这台服务器并没有联上互联网。

然而小范同学之前也没怎么安装过 `MySQL 8.0` ，当他尝试在测试环境下安装时才发现事情并没有想像地那么简单！

看看这一坨坨的依赖包，只要是个正常人肯定不是被吓死就是被气死。

图b01



小范同学使用笨办法将依赖安装包一个一个地找出来再手动下载，结果金乌西落、玉兔东升，时间一久人就麻了！

实际上文章开头那一幕并不是人睡着了，而是麻翻了！

我滴个乖乖，这么操作得玩到猴年马月啊！

这可不行，听完小范同学的哭诉，我立刻在胸前划了个十字，将手轻轻搭在他的肩膀上——我决定帮帮他！



那我们如何才能实现在服务器离线状态下成功地安装 `MySQL 8.0` 呢？

在这儿我以 `Rocky Linux 8.6` 系统为例来给小伙伴们演示。



### 查询官网的安装方法

首先，打开 `MySQL` 的官网，我们很容易就能找到在不同平台各种各样的安装方法，其中通过仓库联网的安装方法较为常用。

> https://dev.mysql.com/doc/refman/8.0/en/linux-installation-yum-repo.html



然后，找到 `MySQL` 的仓库源文件，通常是个 `RPM` 文件，将它下载下来并安装。

```
https://dev.mysql.com/downloads/repo/yum/
```



注意选择正确的仓库安装包，如下就是与我的系统 `Rocky Linux 8.6` 平台相匹配的 `MySQL` 的仓库安装包。

```
mysql80-community-release-el8-4.noarch.rpm
```



有了它我们就可以使用 `YUM/DNF` 来联网安装 `MySQL` 了，安排上。

```
dnf install mysql80-community-release-el8-4.noarch.rpm
```



好，检查一下 `MySQL Yum` 存储库是否成功添加到我们的系统中。

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

因此，当你需要安装非最新版本时，需要禁用不需要的而启用需要的版本才行。

比如我们禁用子仓库中的 `5.7` ，同时启用 `8.0` 。

```
dnf config-manager --disable mysql57-community
dnf config-manager --enable mysql80-community
```



最后确认启用的仓库是否就是我们希望的那个样子。

```
dnf repolist enabled | grep mysql
```



然后就是通常安装的方法，但是请注意先别这么干，有坑。

```
dnf install mysql-community-server
```



 

### 禁用默认的 `MySQL` 模块

当前面的工作准备就绪，你满心欢喜地开始安装 `MySQL` 时却发现报错了！

图b04



发生了什么事，难道前面的操作有问题？

其实这个并不奇怪，我还需要再做一步简单的操作——禁用默认 `MySQL` 模块。

基于 `EL8` 的系统包含有默认启用的 `MySQL` 模块，而如果它是启用状态的话，那么我们前面安装的  `MySQL` 仓库就会被屏蔽，从而无法安装 `MySQL 8.0` 。

不过请注意，禁用默认模块仅限于 `EL8` 系统，比如 `CentOS 8` 、`Rocky Linux 8` 等等。

```
dnf module disable mysql
```

图b03



好，一切准备就绪，重点来了！





### 如何快速有效地下载安装依赖包

我们利用 `dnf` 的 `deplist` 选项先查看一下安装 `mysql-community-server` 所需的依赖情况。

```
dnf deplist mysql-community-server
```

图b05



不过 `deplist` 只是蹭蹭并没有真动手，所以我们要动动小手真地将这些依赖包给下载下来。

首先，新建一个用于存放依赖安装包的目录，一会儿好安排统一安装。

```
mkdir /sysadm/mypackages
```



然后，安装 `Yumdownloader` 工具......

```
dnf install yum-utils
```

停，停，停！打住、打住，其实你根本不用安装它！

网络上都是这么介绍，其实你真的不用这样。

因为你完全可以直接使用 `dnf download` ，你都用 `EL8` 系统了，效果完全一样啊！

执行以下命令让依赖文件统统都到碗里来吧！

```
dnf download --resolve --destdir=/sysadm/mypackages/ mysql-community-server
```

* `--resolve` - 解析并下载相应的依赖安装包
* `--destdir` - 下载的依赖安装包将存放到此参数指定的目录中

图b08



好了，确认一下碗里的依赖包吧！乖乖，还真不少呢！

```
ls /sysadm/mypackages/
```

图b07



### 离线安装搞起来

依赖安装包全都拿到手了，接下来我们就可以让它们移驾到目标离线服务器上了。

图c01



作为演示，我这边就找一台虚拟机，然后断开网络（拔网线）来模拟离线状态。

如图，我们正常安装时由于断网无法解析下载服务器而导致安装失败。

图c02



OK，我们来尝试使用离线安装。

具体怎么做呢？

如果我们直接拉过来安装，那么因为部分依赖没有事先安装好就会导致又一次无意义的失败。

图c03



但即使这些依赖包一个都不少，我们要是一个一个地安装肯定也得芭比Q！

还好，关键时刻我们可以睁一只眼闭一只眼，批量安装它们的时候选择强制跳过依赖检查，反正我都安装上，也不怕它使用时会因为缺少依赖而报错。

```
rpm -Uvh --force --nodeps *.rpm
```

图c04



为了保险起见，你可以再跑一次原来的安装命令看看结果。

```
rpm -ivh mysql-community-server-8.0.xx-x.el8.x86_64.rpm
```

从结果看也没管我们再要过依赖啥的，完美搞定安装！

图c05



不放心的话再来跑一跑服务，看一看版本号，甚至可以远程连接再测试一把。

图c06



### 写在最后

最后我想说的是，大家都不容易，像和小范同学一样辛苦又迷茫的打工人有千千万，能帮一个是一个吧。

希望本文能够帮助到比较迷茫，甚至是人有点麻的小伙伴。

同时也希望大家注意身体健康状况，千万不要等人麻了再回头就晚了。

我写这些文章的初衷也是考虑到如果有需要，可以随时回来看、反复看，既环保又健康，印象深刻、心情愉快！





二维码

**将技术融入生活，打造有趣之故事。扫码关注@网管小贾 / sysadm.cc**