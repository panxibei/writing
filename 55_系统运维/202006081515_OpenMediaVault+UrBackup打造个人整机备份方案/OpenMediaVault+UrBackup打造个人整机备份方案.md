OpenMediaVault+UrBackup打造个人整机备份方案

副标题：专为小白打造的家庭数据备份方案~



在此之前，我们有分享过关于 `XigmaNas` + `UrBackup` 来实现个人整机备份的方案。

>  原文链接：

不过有小伙伴说了，`XigmaNas` 比较专业，企业场景下使用得较多，我更多地喜欢用 `OpenMediaVault` ，能不能实现与 `UrBackup` 一起搭档组合呢？

从官网的文档上看，`UrBackup` 优点就是多平台上都可以运行，其中当然也包括 `OpenMediaVault` 了。

那么具体如何实现呢，让我们把舞台交给 `OpenMediaVault` 吧~



`OpenMediaVault` （简称OMV）是基于 `Debian GNU/Linux` 的 `NAS` 解决方案。

用的人那是相当得多，特别适合家庭或小型办公场景，简单易用，无所不能。

要是扒一扒它的历史，你就知道它是从最早先的 `FreeNAS` 发展而来的。

虽然作为分支它是基于 `Debian` ，而不同于老东家 `FreeNAS` 是基于 `FreeBSD` ，但其历史出身及至今依然活跃也证明了它非但各方面不差，而且还独具特色。

哎，这时有小伙伴举手提问了， `OMV` 与  `XigmaNas` 比较，有什么优势特色吗？

我接触 `OMV` 不多，其他特色我不是很清楚，但我可以肯定地说其最大特色之一就是它很好地支持了 `Docker` ，而后者并不支持。

`Docker` 又是个啥？（王宝强式疑问）

如果你还没了解过 `Docker` ，那你可以简单地理解为它是**精简打包好的一套可以独立运行的操作系统加程序**。

如果你看到本文后面的内容而无法理解（王宝强式的疑问，这些都是个啥啥啥......）的话，强烈建议你赶快去学习了解一下哈！

原因很扎心，因为要在OMV上实现运行 `UrBackup` 备份程序，是要用到 `Docker` 的。



实际步骤和内容较多，但不要怕，怕是没用滴！

放心吧，我已经整理好了，保证你能搞定啦，咱们先来个概览：

> 1、安装 `OMV`
>
> 2、安装 `OMV-Extras`
>
> 3、安装 `Docker` 和 `Portiner`
>
> 4、拉取 `UrBackup` 镜像
>
> 5、创建并运行 `UrBackup` 容器



好了，啰嗦了不少，我们马上进入具体实现：



#### 一、安装 `OMV`

安装OMV有很多教程，而安装起来是超级简单，连分区的步骤都不用操心，但记得要保证网络通畅。

我这里安装的是最新版本 `openmediavault_5.3.9-amd64.iso` 。

`Sourceforge` 下载巨慢，我下载好了放在网盘里，点击 这里 下载为你节省时间。（提取码：）

后续安装，此处省略一万字.......



#### 二、安装 `OMV-Extras`

`OMV` 很愉快地安装好了，那么之后就要安装 `OMV-Extras` ，你可以理解为插件，它是用来安装 `Docker` 的前提条件。

在浏览器的地址栏中输入 `https://www.omv-extras.org` ，打开如下页面。

图1



我们安装的 `OMV` 是 `5.x` 版本的，所以我们点击 `usul` 。

按照顺序 `usul` > `openmediavault-omvextrasorg` > `pool` > `main` > `o` > `openmediavault-omvextrasorg` 一路点击打开，最后找到 `openmediavalut-omvextrasorg_5.5.5_all.deb` 一项点击下载。

节省时间，备用下载地址：openmediavalut-omvextrasorg_5.5.5_all.deb

图2



来到 `OMV` 的左侧导航 `系统` > `插件` ，点击 `上传` ，把刚才下载的安装包上传到系统中。

上传好后，还要点击 `安装` 才能真正地开始安装。

图3



#### 三、安装 `Docker` 和 `Portiner`

`OMV-Extras` 安装好后，页面自动刷新，在左侧导航栏你会看到新增了一项 `OMV-Extras` ，赶快点它。

图4



在右侧点击 `Docker` 选项卡，看到了没，有一个 `Docker` 和 一个 `Portainer` 。

分别点击它们，在下拉菜单中点选安装。

安装需要联网，可能由于下载安装包比较大，有时会安装失败，要多试几次。

图5

图6



可能有小伙伴又举手提问了，不是用 `Docker` 吗，怎么又冒出来一个 `Portainer` ，它是什么东东？

其实你可以把它理解为用来管理 `Docker` 的一个WEB界面的管理程序。

如果你很熟悉 `Docker` 的话，也可以不用安装它，直接操作 `Docker` 指令。

好吧，我承认我是小白，我也当你是小白，有现成的工具，咱们还是用用它吧。



嘿嘿，可能你还没注意到吧，我们安装好 `Portainer` 后，在那个安装按钮右边的 `打开WEB页` 变得可用了。

木有错，你很聪明啊，点它就对了！

嗯，成功出现了 `Portainer` 的界面，只是头一次它要你新建管理员帐号和密码，你照做就是了哦。

图7



建好帐号和密码后顺利进入，这时我们选择本地环境，点击 `connect` 开始连接管理 `Docker` 了。

图8



#### 三、拉取 `UrBackup` 镜像

点击进入本地 `Docker` 环境，点击 `image` 镜像。

图9

图10



在镜像一栏内输入 `uroni/urbackup-server:latest` ，点击 `Pull the Image` 开始拉取镜像。

成功完成后，`UrBackup` 就会在最下面的镜像列表中出现。

图11



#### 四、创建并运行 `UrBackup` 容器

找到 `Containers` 中的 `Add container` ，我们来添加 `UrBackup` 容器。

图12



这里要啰嗦几句了。

按照官网手册描述，如果你熟悉Docker指令，那么运行它就是一条命令的事。

```
docker run -d \
                --name urbackup \
                --restart unless-stopped \
                -e PUID=1000 \  
                -e PGID=100  \
                -e TZ=Europe/Berlin \
                -v /path/to/your/backup/folder:/backups \
                -v /path/to/your/database/folder:/var/urbackup \
                --network host \
                uroni/urbackup-server:latest
```

用命令是简单，但我们是新手小白啊，无知者无畏哈，不懂不是问题，问题是不会用啊！

好吧，`Portainer` 可以帮到我们，往下看。

我们按照命令，一项一项往 `Portainer` 上面套就行了。



1、名字这个随便起，我这写的是 `urbackup-server` 。

2、镜像一栏填写`uroni/urbackup-server:latest` 。

图13



3、重启模式，停止后自动重启。

--restart unless-stopped

图14



4、环境变量参数

-e PUID=1000 和  -e PGID=100  和 -e TZ=Europe/Berlin。

最后一项是时区，我们这里写成 `Asia/Shanghai` 。

图15



5、卷重定向

-v /path/to/your/backup/folder:/backups 

-v /path/to/your/database/folder:/var/urbackup

首先，查看想要备份的目标挂载点，我这儿是 `/srv/dev-disk-by-label-urbackup` 。

图16



其次，按下图选择参数，记得要点下Bind。

图17



6、网络模式，按照官方选择host。

图18



7、所有参数准备就绪，找到按钮 `Deploy the container` 点下去。

OK！新的容器创建成功啦！

图19



我们创建的名称为 `urbackup-server` 的容器很顺利地在运行了，这时我们打开 `IP:55414` 看看，`UrBackup` 是不是成功显示了？

