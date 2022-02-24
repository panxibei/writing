等Windows自带共享开启黄花菜都凉了，看我用Webd秒秒钟开启文件共享！

副标题：Webd：一款文件共享秒开神器！

英文：its-too-late-to-enable-windows-its-own-sharing-look-i-use-webd-to-start-file-sharing-instantly

关键字：webd,windows,共享,sharing,linux,arm,android,网盘,cloud,storage,存储



最近一周，我发现与我热恋半年多的女友小C突然忙碌了起来。

而正是这突如其来的变化，似乎让我迎来了人生的转折点。



小C是我的同事，由于是办公室恋情，因此我俩的关系并未向其他人公开。

我们本来打算再过一段时间，等双方父母见了面再决定公开我俩的关系。

可是，最近几天也不知道怎么她忽然忙得不太想搭理我。

我也不好多说什么，心想可能是最近她们部门工作确实繁多，我应该多多理解和支持她才对。

直到有一天，其他同事在背后咬耳朵，被我无意间听到了一些骇人的言论......



“哎哎，我说，不对劲啊，你知不知道那个小C，她电脑里的那些照片是怎么回事？那老头谁啊？”

“啊？哦，你是说和她合影的那老头？你也看到了？别提了，没想到看上去年纪轻轻、貌不惊人的，居然还会这一手啊！”

“你是说......嘿嘿，我看那老头肯定是个特有钱的主儿！”

“嘘...你小点声儿！”



哎呦嗬？几个意思？

我心想我也不是个八卦的人儿啊，怎么一遇到这种情况本来萎靡不振的人突然就立马有了精神头了？

吃瓜堪比吸大烟啊，有时候瓜是真香！

毕竟涉及到小C，于是我直起腰板竖起耳朵想再听个究竟，结果你说巧不巧，小C正好打来了电话。

我心里咯噔一下，差点儿没从座位上蹦起来，原来她是找我看电脑。

我心想太好了，之前没怎么注意她电脑里的照片，现在正好去看看到底有没有这回事！

我定了定神，一边回她说稍等几分钟马上就来，一边赶忙打开了 `Webd` 的说明文档准备回顾一下用法......



### Webd 介绍

`Webd` 是一款轻量小巧的简易网盘程序。

这款轻量小巧的 `Web` 分享服务程序非常适合临时搭建、灵活管理的场合。

而且它支持多平台，可以在 `Linux` 甚至是 `Android` 上跑，并且可应用在 `openwrt` 上面。

正是它小巧灵活、机动性强，于是我选择了用它帮我开启电脑的共享功能。

> 官方网站：http://webd.cf/



`Webd` 的特点：

* 轻量级 `self-hosted` 自建网盘软件
* 程序仅 `60 ~ 90 KB` ，含 `Server` 端，无其它依赖，速度快资源占用低
* 纯便携软件，解压即用
* 支持 `Windows` 、`Linux` 、`OpenWrt` 、`Armbian`
* 界面简洁易用，无繁琐设置，支持移动设备



说 `Webd` 是个网盘程序，却不仅仅是字面意思这么简单，实际上它也相当于是个文件共享程序。

具体的我们实际运用它就可以体会到。



### 下载

由于 `Webd` 支持多个平台，因此官网上提供了很多针对不同平台的安装包。

我们仅在 `Windows` 上做演示，因此下载名为 `webd-20220127-win32.7z` 的安装包即可。

> 下载链接：[webd-20220127-win32.7z](https://gwgw.ga/webd/20220127/webd-20220127-win32.7z)



图01



下载完成后解压缩可获得一个名为 `webd` 的文件夹，其中包含了一个主执行程序 `webd.exe` ，以及批处理脚本文件夹 `scripts` 和网页脚本文件夹 `web` 。

图02



至于 `webd` 文件夹放到哪里都没问题，只要你记住路径，一会儿配置会用到。



### 配置文件

`webd` 文件夹内，除了主程序 `webd.exe` 外还有一个重要文件，就是配置文件 `webd.conf` 。

虽说这个配置文件并不一定是必须的，但当我们直接双击 `webd.exe` 来启动服务时，那么这时 `webd.conf` 就是必须的了，因为主程序要读取一些配置才能正常运行。



因此，我们需要了解一下配置文件书写时的注意事项。

别怕，没有几个配置项哦，很简单的！



**配置文件在开头写下了这样的注解。**

```
# NOTE:
# This file must be encoded in UTF-8.
# Directives and variable definition in this file are case-insensitive.
# Lines that begin with the hash character "#" are considered comments, and are ignored.
```

大意如下：

1、配置文件 `webd.conf` 必须以 `UTF-8` 编码格式保存。

当你使用 `Windows` 自带的记事本程序时就要特别注意，务必以 `UTF-8` 编码保存文件哦！

图03



2、指令和变量都是大小写敏感的，就是说每个单词都要严格注意字母的大小写。

3、每一行最前面的 `#` 号表示注释，也就是说带 `#` 号的命令行会被忽略而不会起到任何作用。



**`Webd` 的根目录，需要注意 `Linux` 和 `Windows` 各个平台目录路径的不同写法。**

```
# Webd 根目录，用于开放网络共享
# Webd.Root: The directory that webd share on network.

# Linux 下这么写
# Webd.Root /mnt/sdb1

# Windows 下这么写
# Webd.Root "D:\my share"
```



**`Webd` 的侦听端口。**

```
# Webd.Listen: Bind webd to specific IP and/or port.
# 通过书写多行 Webd.Listen 可以同时绑定多个IP地址
# Also, webd can bind to multiple addresses by use multiple "Webd.Listen" instructions.

# 绑定IPv4协议的9212端口
# Webd.Listen 9212

# 同时绑定IPv4和IPv6协议的9212端口
# Webd.Listen [::]:9212
```



**用户权限可通过一个或多个标签组合进行设置。**

注意，`rlum` 是小写字母，`ST` 是大写字母哦！

```
# User's permissions can be set via one or more tag combinations:
# r: access files - 只读
# l: list directories - 列出目录
# u: upload file - 上传
# m: delete or move files - 删除或移动
# S: show hidden files or directories - 显示隐藏的文件或目录
# T: use webpage to play media files - 通过WEB页面播放媒体文件
```



**关于用户支持，目前 `Webd` 仅提供两个普通用户支持。**

每一个用户可独立拥有各自的用户名密码和权限。

但是，这两个用户只能用于共享同一个 `Web` 共享目录。

```
# For now, webd supports only two users.
# Each user may have it's own Username Password and Permissions.
# But they share the same web directory.

# user1拥有所有权限（rlumS）
# user1 has all permissions.
# Webd.User rlumS user1 pass1

# user2可以读取列出文件列表以及下载文件（rl）
# user2 can download and list files.
# Webd.User rl user2 pass2

# 访客 Guest 用户默认就可以列出并下载文件
# Guest can download and list files by default.
# 如下取消注释可禁用 Guest 用户的所有权限
# Uncomment to disable all permissions for guest.
# Webd.Guest 0
```



**可以隐藏 `Windows` 下 `Webd` 的系统托盘图标。**

```
# Hide tray icon for Windows.
# Webd.Hide
```



**`Windows` 下如果 `webd` 无法通过双击任务栏图标弹出浏览器，那么我们需要指定浏览器的程序路径。**

```
# Specify the path of Browser for Windows if webd can not popup Browser by double clicking tray icon.
#
# 比如我们可以指定打开火狐浏览器
# Webd.Browser "C:\Program Files\Mozilla Firefox\firefox.exe"
#
# Or start Browser with extra paramters that set by a batch file.
# 也可以指定批处理文件，用于启动浏览器时需要带些特别的参数
# Webd.Browser "C:\Program Files\Mozilla Firefox\myFirefox.cmd"
```



**`Webd` 还有一些环境变量设定，这些环境变量应该在命令行或系统配置中设置。**

```
# Envionment variables for webd.
# These should be set in the command line or system configration.
#
# 设定日志文件写到 /var/log/webd-YYYY-MM-DD.log
# Write log files to /var/log/webd-YYYY-MM-DD.log
# _LOG_DIR=/var/log/webd-
#
# 是否开启将日志写到 syslog 服务器的功能
# Write log to syslog.
# _syslog=1
#
# Linux下，可设定最大打开文件描述符数量
# Set the maximum number of open file descriptors, linux only.
# _FD_LIMIT=10240
#
# Linux下，启动后切换为非特权用户
# Switch to non-privileged user after startup, linux only.
# _RUNAS=nobody
#
# Linux下，启动后更改根目录
# chroot after startup, linux only.
# _CHROOT_PATH=/mnt/sda1
```



### 命令行参数

通常配置文件是一次编辑终身受用，比较适合不用那么频繁修改的情况。

而有时呢我们可能需要更加灵活多变的方式来使用 `Webd` 服务，比如在不同的服务器上运行不同参数的服务，那么通过在 `webd.exe` 命令后加上参数的方式就比较合适一些。



相对应配置文件中的配置项，命令行参数会有对应的参数，有些效果和在配置文件里设定是一样的。

```
命令行参数对应的配置项:
  -c 指定配置文件, 不再使用默认路径的
  -h Webd.Hide
  -B Webd.Browser
  -l Webd.Listen 可指定多个
  -w Webd.Root
  -g Webd.Guest
  -u 类似 Webd.User, 需把空格用冒号替代, 类似 -u rlum:user1:pass1
     配置文件和命令行参数一共能设置三个用户
```



如果有一些常用的场合，可以考虑将命令行写在批处理文件保存下来，到用时就可以双击批处理直接走起，方便非常啊！

嗯，够简单吧，可能有的小伙伴会说，我的大脑学会了，可是我的手还没学会！

好吧，我们就来实际动手做一做！



### 简单运用

我们先新建一个空文件夹 `sysadm.cc` 。

```
mkdir C:\sysadm.cc
```



然后最简单地，我们希望用户有上传下载的权限，运行像下面这样的命令。

```
webd.exe -w C:\sysadm.cc -u rlum:user:123
```

其中，

1. 共享目录为 `C:\sysadm.cc` 
2. 用户名为 `user` ，密码为 `123` 
3. 用户权限为 `rlum`



命令执行后可能会弹出开启防火墙的提示，启用允许访问即可。

图04



与此同时系统任务栏内生成 `Webd` 图标。

图05



让我们先确认一下这个服务是否在正常工作，输入以下命令查看。

```
netstat -anp tcp
```

可见 `Webd` 正运行在端口 `9212` 上，所有 `IPv4` 地址均可访问。

图06



OK，我们打开浏览器，输入以下网址。

```
http://<webd服务器IP>:9212
```

注意，协议号是 `http` 而不是 `https` 。

正常打开后应该是这个样子。

图07



空空如也，什么都没有，那么怎么上传文件呢？

我们点击中间的那个 `Login` 登录，然后输入用户名和密码。

图08



成功登录后，我们就可以正式开始使用 `Webd` 了。

我们可以先新建一个文件夹，点击右上角的新建文件夹按钮，输入文件夹名称。

图09



亦或者点击右上角的上传文件来直接上传文件到网盘根目录。

图10



上传完成后就是这个样子了。

图11



我们再到 `Webd` 服务器上看看，哎，的确多了一个文件和文件夹。

图12



### 使访客无法下载查看

默认情况下运行 `Webd` ，作为访客 `Guest` 是可以直接查看和下载文件的，并不需要特意登录为某用户。

如果我们想让指定的用户访问，而不想让访客 `Guest` 匿名访问，那么在配置文件中禁用访客就可以了。

```
Webd.Guest 0
```



如果是命令行方式，那么只要加上参数 `-g 0` 即可。

```
webd.exe -w C:\sysadm.cc -u rlum:user:123 -g 0
```



重启服务后我们再来试试看，就会发现不登录的话就会被拒绝访问 `Webd` 。

图13



### 两个用户

`Webd` 同时只能支持两个用户访问，当然这并不是它的缺点，功能小巧轻量也就不需要那么复杂冗余，通常两个用户也算够用。

要想支持两个用户，那么像下面这样写命令，`user1` 和 `user2` 就能同时访问 `Webd` 了。

但是请注意，两个用户只能共享同一个的文件夹哦！

```
webd.exe -w C:\sysadm.cc -u rlum:user1:123 -u rlum:user2:456 -g 0
```



### 在线播放音视频

有时候为了浏览方便，我们想要在线查看并播放视频音频，那么这就需要两个前提条件。



一是，用户权限里要加上 `T` ，注意要大写哦。

```
webd.exe -w C:\sysadm.cc -u rlumT:user:123
```



二是，将 `web` 目录下的 `.player.htm` 文件复制到 `Webd` 的共享根目录中。

```
# copy <Webd根目录>\web\.player.htm <共享根目录>\.player.htm
copy C:\webd\web\.player.htm C:\sysadm.cc\.player.htm
```



前面两个条件OK的话，我们将音视频上传到 `Webd` 上之后，应该就是这个样子。

图14



好，我们再点击视频文件，顺利的话它就可以自动在线播放了。

图15



很明显，它是通过 `.player.htm` 文件的 `JS` 代码实现播放功能的，并没有什么特殊神秘之处。

其实图片以及文档之类的也都是可以在线预览的，只不过有些是依托浏览器自身的解读能力罢了，大家可以试一试。



### 通知栏图标的菜单项

极简轻量的 `Webd` 其通知栏图标菜单也是一样简单易懂。

如图所示，就几个菜单项。

* `Open Web Root` - 打开 Web 根目录
* `Open by Browser` - 鼠标双击的默认项，打开浏览器访问 `Webd`
* `Add firewall rule` - 添加防火墙规则，允许 `Webd` 通过防火墙
* `Delete firewall rule` - 删除防火墙规则，禁止 `Webd` 通过防火墙
* `Exit` - 退出 `Webd` 程序

图16



这里需要说明一下，添加/删除防火墙只要点一下菜单项即可。

删除防火墙规则，那么也就是 `Webd` 被禁止访问了，这个通常可以用于紧急关闭 `Webd` 服务而无需刻意退出。

图17



### 后记

我顺手用 `Webd` 做了个批处理文件，并将整个 `webd` 文件夹放到我随身携带的的U盘上。

很快我来到了小C的办公室，装模作样地操作着电脑，趁她转身倒水的功夫我顺势掏出U盘，将 `Webd` 拷进了她的电脑。

我眼疾手快，施展十指禅大法唰唰两下，使出飞人苏炳添的速度仅用时几秒钟就用 `Webd` 开启了文件共享，并且开启了随系统启动功能，以及关闭了任务栏图标显示。

一切OK，不一会儿电脑问题也搞定了，我招呼了几句就从办公室里退了出来。

然后火速回到工位上，点开浏览器，敲入小C电脑的IP地址，一路点击顺利地找到了她保存照片的文件夹。

果不出所料，其中几张照片中她正手挽着一个老头，满面欢笑、态度亲昵！

而照片中的老头穿着华贵富有气质，一看就是位家资巨富、腰缠万贯的金主。

我咬了咬牙，难不成是，“干爹”？还是说，“老情人”？

瞬间，我精神恍惚，脑袋嗡嗡作响，实难理解这眼前的一切！



半晌我昏昏沉沉站起身来，也不知怎么就来到走廊外路过会议室。

只见会议室的门虚掩着，我就感觉不对，便从门缝中偷眼观瞧，却只见小C正和一陌生老头大声说着话。

这一瞧不打紧，哎，这不就是照片中的那个老头嘛！

就听见小C说了一句：“爸，我这刚来，请您务必支持我的工作！”

我一愣，正在这时，同事小Y急急忙忙跑过来拉了我一把：“你小子怎么跑这儿来了，还不赶紧回工位！待会儿新上任的董事长要召集大伙开会呢，现在人就在会议室，别乱跑了，赶紧回去！”

我两腿一软，噗通摔倒在地。

等我挣扎着爬起来时，天早已大亮......

（本文故事纯属虚构，如有雷同，概不负责！）



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc



