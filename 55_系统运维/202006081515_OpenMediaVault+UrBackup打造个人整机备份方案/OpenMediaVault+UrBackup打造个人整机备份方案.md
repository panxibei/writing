OpenMediaVault+UrBackup打造个人整机备份方案

副标题：



在之前的文章中，我们有分享过关于 `XigmaNas` + `UrBackup` 来实现个人整机备份的方案。

不过有人说，他喜欢用 `OpenMediaVault` ，能不能实现与 `UrBackup` 的组合呢？

从官网的文档上看，`UrBackup` 是多平台上都可以运行的，当然也包括 `OpenMediaVault` 了。

那么具体如何实现呢，让我们一起走一走、看一走吧~



`OpenMediaVault` （简称OMV）是基于 `Debian GNU/Linux` 的NAS解决方案。

用的人很多，特别适合家庭或小型办公场景，简单易用，好处多多。

有人就说了，OMV与群晖或XigmaNas比较，有什么优势吗？

我接触OMV不多，但我觉得每个系统各有其特色。

而OMV的最大特色之一就是它支持Docker，而后两者要么支持得不好，要么并不支持。

Docker是个啥？

如果你还没了解过，那你可以简单地理解为**打包好的一套可以独立运行的系统加程序**。

很难理解地话，建议你赶快去学习了解一下哈！

因为要在OMV上实现UrBackup备份，是要用到Docker的。



步骤内容繁多，先来个速览：

> 1、安装OMV
>
> 2、安装OMV-Extras
>
> 3、安装Docker和Portiner
>
> 4、拉取UrBackup镜像
>
> 5、创建并运行UrBackup容器



好，我们具体尝试实现：

#### 一、安装OMV

安装OMV有很多教程，而安装起来是非常简单的，连分区的步骤都省略了，记得保证网络通畅。

我这里安装最新版本 `openmediavault_5.3.9-amd64.iso` 。

Sourceforge下载巨慢，点击 这里 快点下载。（提取码：）

此处省略一万字...



#### 二、安装OMV-Extras

OMV很愉快地安装好了，那么之后就要安装OMV-Extras，这是用来安装Docker的前提条件。

在浏览器的地址栏中输入 `https://www.omv-extras.org` ，打开如下页面。

图1



我们安装的OMV是 `5.x` 版本的，所以我们点击 `usul` 。

按照顺序 `usul` > `openmediavault-omvextrasorg` > `pool` > `main` > `o` > `openmediavault-omvextrasorg` 一路点击打开，找到 `openmediavalut-omvextrasorg_5.5.5_all.deb` 一项点击下载。

备用下载地址：openmediavalut-omvextrasorg_5.5.5_all.deb

图2



来到OMV的左侧导航 `系统` > `插件` ，点击 `上传` ，把刚才下载的安装包上传到系统中。

上传好后，还要点击 `安装` 才能真正地开始安装。

图3



#### 三、安装Docker和Portiner

OMV-Extras安装好后，页面自动刷新，在左侧导航栏你会看到新增了一项 `OMV-Extras` ，赶快点它。

图4



在右侧点击 `Docker` 选项卡，看到了没，有一个 `Docker` 和 一个 `Portainer` 。

分别点击它们，在下拉菜单中点选安装。

安装需要联网，有时会安装失败，要多试几次。

图5

图6



可能有人要问了，这个Portainer是个什么东东？

其实你可以理解为它只是用来管理Docker的一个WEB管理程序，如果你很熟悉Docker的话，也可以不用安装它，直接操作Docker指令。

好吧，我是小白，我也当你是小白，有现成的工具，咱们还是用用它吧。



哎，可能你没注意到吧，我们安装好 `Portainer` 后，在那个安装按钮右边的 `打开WEB页` 变得可用了。

木有错啊，点它就对了！

嗯，成功出现了 `Portainer` 的界面，只是头一次它要你生成管理员帐号和密码，你照做就是了。

图7



改好了没？

好了的话，我们选择本地环境，点击 `connect` 开始连接管理Docker了。

图8



#### 三、拉取UrBackup镜像

点击进入本地Docker环境，点击 `image` 镜像。

图9

图10



在镜像一栏内输入 `uroni/urbackup-server:latest` ，点击 `Pull the Image` 开始拉取镜像。

成功完成后，UrBackup会在最下面的镜像列表中出现。

图11



#### 四、创建并运行UrBackup容器

找到 `Containers` 中的 `Add container` ，我们来添加UrBackup容器。

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

