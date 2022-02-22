webd网盘

副标题：

英文：

关键字：









> http://webd.cf/



特点：

* 轻量级(self-hosted)自建网盘软件
* 程序仅 60 ~ 90 KB，含 Server 端，无其它依赖，速度快资源占用低
* 纯便携软件，解压即用
* 支持 Windows、Linux、OpenWrt、Armbian
* 界面简洁易用，无繁琐设置，支持移动设备



### 下载



解压缩获得一个名为 `webd` 的文件夹，其中包含了一个主执行程序 `webd.exe` ，以及脚本文件夹 `scripts` 和网页管理器文件夹 `web` 。

图a02







### 配置文件

配置文件书写的注意事项。

```
# NOTE:
# This file must be encoded in UTF-8.
# Directives and variable definition in this file are case-insensitive.
# Lines that begin with the hash character "#" are considered comments, and are ignored.
```



1、配置文件 `webd.conf` 必须以 `UTF-8` 编码格式保存。

图a03



2、指令和变量都是大小写敏感的，就是说每个单词都要严格注意字母的大小写。

3、每一行最前面的 `#` 号表示注释，也就是说带 `#` 号的命令行会被忽略而不会起到任何作用。



`Webd` 的根目录，需要注意 `Linux` 和 `Windows` 各个平台目录路径的不同写法。

```
# Webd 根目录，用于开放网络共享
# Webd.Root: The directory that webd share on network.

# Linux 下这么写
# Webd.Root /mnt/sdb1

# Windows 下这么写
# Webd.Root "D:\my share"
```



`Webd` 的侦听端口。

```
# Webd.Listen: Bind webd to specific IP and/or port.
# 通过书写多行 Webd.Listen 可以同时绑定多个IP地址
# Also, webd can bind to multiple addresses by use multiple "Webd.Listen" instructions.

# 绑定IPv4协议的9212端口
# Webd.Listen 9212

# 同时绑定IPv4和IPv6协议的9212端口
# Webd.Listen [::]:9212
```



用户权限可通过一个或多个标签组合进行设置。

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



关于用户支持，目前 `Webd` 仅提供两个普通用户支持。

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



可以隐藏 `Windows` 下 `Webd` 的系统托盘图标。

```
# Hide tray icon for Windows.
# Webd.Hide
```



`Windows` 下如果 `webd` 无法通过双击任务栏图标弹出浏览器，那么我们需要指定浏览器的程序路径。

```
# Specify the path of Browser for Windows if webd can not popup Browser by double clicking tray icon.
# 比如我们可以指定打开火狐浏览器
# Webd.Browser "C:\Program Files\Mozilla Firefox\firefox.exe"
# Or start Browser with extra paramters that set by a batch file.
# 也可以指定批处理文件，用于启动浏览器时需要带些特别的参数
# Webd.Browser "C:\Program Files\Mozilla Firefox\myFirefox.cmd"
```



`Webd` 还有一些环境变量设定，这些环境变量应该在命令行或系统配置中设置。

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

而有时我们可能需要更加灵活多变的方式来使用 `Webd` 服务，那么通过在 `webd.exe` 命令后加上参数的方式就比较合适一些。

相对应配置文件中的配置项，命令行参数有对应的参数。

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









### 简单运用

执行以下命令。

```
webd.exe -w C:\sysadm.cc -u rlum:user:123
```

其中，

1. 共享目录为 `C:\sysadm.cc` 
2. 用户名为 `user` ，密码为 `123` 
3. 用户权限为 `rlum`



命令执行后需要开启防火墙。

图b01



同时系统任务栏内生成 `Webd` 图标。

图b02



让我们先确认一下这个服务是否在正常工作，输入以下命令查看。

```
netstat -anp tcp
```

可见 `Webd` 正运行在端口 `9212` 上，所有 `IPv4` 地址均可访问。

图b03



OK，我们打开浏览器，输入以下网址。

```
http://<webd服务器IP>:9212
```

注意，协议号是 `http` 而不是 `https` 。

正常打开后应该是这个样子。

图c01



空空如也，什么都没有，那么怎么上传文件呢？

我们点击中间的那个 `Login` 登录，然后输入用户名和密码。

图c02



成功登录后，我们就可以正式开始使用 `Webd` 了。

我们可以先新建一个文件夹，点击右上角的新建文件夹按钮，输入文件夹名称。

图c03



亦或者点击右上角的上传文件来直接上传文件到根目录。

图c04



上传完成后就是这个样子了。

图c05



我们再到 `Webd` 服务器上看看，哎，的确多了一个文件和文件夹。

图c06



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

图e01



### 两个用户



```
webd.exe -w C:\sysadm.cc -u rlum:user1:123 -u rlum:user2:456 -g 0
```



### 在线播放音视频

我们想要在线查看并播放视频音频的话，需要两个前提条件。



一是，用户权限里要加上 `T` ，注意要大写哦。

```
webd.exe -w C:\sysadm.cc -u rlumT:user:123
```



二是，将 `web` 目录下的 `.player.htm` 文件复制到 `Webd` 的共享根目录中。

```
# copy <Webd根目录>\web\.player.htm <共享根目录>\.player.htm
copy C:\webd\web\.player.htm C:\sysadm.cc\.player.htm
```



前面的条件OK，然后我们将音视频上传到 `Webd` 上之后，应该就是这个样子。

图e02



好，我们再点击视频文件，它就可以自动在线播放了。

图e03



很明显，它是通过 `.player.htm` 文件的 `JS` 代码实现的，并没有什么神秘之处。

其实图片以及文档也都是可以在线预览的，只不过是依托浏览器自身的解读能力罢了，大家可以试一试。



### 通知栏图标的菜单项

极简轻量的 `Webd` 其通知栏图标菜单也是一样简单易懂。

如图所示，就几个菜单项。

* `Open Web Root` - 打开 Web 根目录
* `Open by Browser` - 鼠标双击的默认项，打开浏览器访问 `Webd`
* `Add firewall rule` - 添加防火墙规则，允许 `Webd` 通过防火墙
* `Delete firewall rule` - 删除防火墙规则，禁止 `Webd` 通过防火墙

图d01



添加/删除防火墙只要点一下即可。

删除防火墙规则，那么也就是 `Webd` 被禁止访问了，这个通常可以用于紧急关闭 `Webd` 服务而无需退出服务。

图d02









