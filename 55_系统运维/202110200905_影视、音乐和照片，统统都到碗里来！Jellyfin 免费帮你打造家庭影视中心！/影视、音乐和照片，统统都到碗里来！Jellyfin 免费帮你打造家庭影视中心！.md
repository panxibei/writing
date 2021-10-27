影视、音乐和照片，统统都到碗里来！Jellyfin 免费帮你打造家庭影视中心！

副标题：打造免费家庭影院的利器~

英文：movies-music-and-photos-all-in-the-bowl-jellyfin-helps-you-building-a-home-theater-for-free

关键字：jellyfin,aqiyi,emby,家庭影院,home,movie,music,photo,theater



哎，听说了没，前段时间爱某艺取消了 VIP 超前点播！

这下可好了，有钱也没办法任性了，不过总感觉哪里不对劲。

没错啦，你的感觉是对的，我们总是被它们牵着鼻子走啊！

不是 VIP 时给你看广告，充了 VIP 后给你看 VIP 专属广告，这不是坑爹是什么？

后来又整出个什么超前点播，反正管你有钱还是没钱，玩你没商量啊！

老这样可不行，自己攒一个点播系统不香吗？

哎，今儿你可来对了，自己还真能成，不信走着！



说实话，我平时工作比较忙，之前还真没有那心思研究这方面，这不前两天无意中看到了一个好玩意 `Jellyfin` ，据说是个影视中心系统，还免费，于是上网研究了一番。

官网链接：https://jellyfin.org/



与一些 `NAS` 系统自带的影视管理器相比 `Jellyfin` 更专业更高效，它不仅支持影视，还可以管理照片、文档等多种媒体类型。

`Jellyfin` 源自 `Emby` 的 `3.5.2` 版本并移植到 `.NET Core` 框架上，所以它是全面跨平台支持的。

因此为了更好地了解它，我们先尝试在 Windows 上安装来熟悉它，之后再介绍它在其他平台或 `Docker` 的安装和使用方法。



### 安装

我们到官网上下载最新的 Windows 稳定版安装包。

多说一句，下载网页中的其他项目，分别适合自行手动安装，对小白不太友好，在这里就不详细展开了，我们只说头一个可以直接拿来用的安装包 `installer/jellyfin_x.x.x_windows-x64.exe` 。

为确保下载安装包的正确性，最好用哈希 256 校验，下载项的第二行就是用于对照的检验码文件。



下载链接：https://repo.jellyfin.org/releases/server/windows/stable/

图01



接下来双击安装包开始安装。

图a01

图a02



默认选择**基本安装**，这比较适合新手，`Jellyfin` 会作为一般程序运行在当前用户下。

如果选择**作为服务安装**，那么`Jellyfin` 会作为后台服务运行，当然管理起来比较麻烦，仅适合高级用户了。

图a03



决定将 `Jellyfin` 安装到何处。

图a04



决定将所需数据文件夹放到何处。

图a05



最后确认安装条件，正式开始安装进程直至完成。

图a06

图a08



### 初始设置

右键点击右下角的 `Jellyfin` 图标，在弹出的菜单上选择 `Open Jellyfin` 。

图b01



浏览器将被自动打开并访问链接地址 `http://localhost:8096` 。

首先，选择显示语言，开源万岁，支持多语言就是香啊！

图b02



其次，设定用于登录管理的用户名和密码。

图b03



再次，设置我们自己的媒体库，当然我们可以过一会儿再添加，不着急，在这儿我们先直接跳过。

图b04



再三，首先元数据语言，当然设定为中文和中国了。

图b05



再四，配置远程访问，这没啥说的，默认就行。

图b06



最后，完成设置，挺简单的对吧。

图b07



### 简单使用

浏览器上打开 `http://localhost:8096` ，使用前面设置的用户名和密码登录。

图b08



进入系统后，我们可以看到还没有任何的资料库，需要我们去创建了。

图b09



点击左上角菜单图标，选择 `控制台` > `媒体库` ，在打开的界面中点击 `添加媒体库` 开始添加自己的资料吧。

图b10



媒体的类型丰富多彩自由选择，在显示名称处写上容易识别的名字，然后根据页面上的提示填充相应内容即可。

图b11



添加视频和音乐后，在首页就可以看到媒体列表了。

不过在这儿不知道是不是我自己测试的问题，Windows 7 上似乎不会自动刷新，而 Windows 10 则没问题。

图b12





`Ubuntu/Debian` 安装 `Jellyfin`

可以参考官网下载网页的内容，非常简单，逐步输入以下命令即可。

```
sudo apt install apt-transport-https

wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | sudo apt-key add -

echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release ) $( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list

sudo apt update

sudo apt install jellyfin
```

 

安装完成后 `Jellyfin` 即作为服务已经自动运行在后台了。

之后的登录及设定操作与前面所述并无两样，唯一需要注意的就是媒体的目录权限应该确保 `Jellyfin`可正常访问。

图c01







### 使用 `Docker` 来跑 `Jellyfin`

`Docker` 是优秀的跨平台容器解决方案之一，用它快速部署 `Jellyfin` 绝对是很香的。

一般的操作系统安装 `Docker` 都是没问题的，然而通常情况下，我们大量媒体文件都是放在 `NAS` 之类的大容量存储设备中的。

因此，将 `NAS` 与 `Docker` 两者相结合，然后加入 `Jellyfin` 才是最佳方案。



关于常用的 `NAS` 上如何安装 `Docker` 的方法，可以参考我之前写的文章。

> 文章名称：《OpenMediaVault+UrBackup打造个人整机备份方案》
>
> 文章链接：https://www.sysadm.cc/index.php/xitongyunwei/742-openmediavault-urbackup



有了 `Docker` ，接下来只要执行以下几条命令即可拥有 `Jellyfin` 。

```
# 拉取最新版的 Jellyfin 镜像
docker pull jellyfin/jellyfin:latest

# 新建配置和缓存目录
mkdir -p /srv/jellyfin/{config,cache}

# 运行容器
docker run -d -v /srv/jellyfin/config:/config -v /srv/jellyfin/cache:/cache -v /media:/media --net=host jellyfin/jellyfin:latest
```



最后的运行容器命令行中，你可以自由设定参数，比如媒体文件都放在了 `/movies` 目录中，那么就应该将容器的 `/media` 与之相映射。

```
# 将其中的参数修改为 -v /movies:/media
docker run -d -v /srv/jellyfin/config:/config -v /srv/jellyfin/cache:/cache -v /movies:/media --net=host jellyfin/jellyfin:latest
```

与此同时，在 `Jellyfin` 中添加媒体库时，媒体所在文件夹应当是 `/media` 而非 `/movies` ，这一点可千万别搞错了哦！





### 客户端





### 写在最后





**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc





























