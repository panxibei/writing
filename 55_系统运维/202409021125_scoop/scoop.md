scoop

副标题：

英文：

关键字：





scoop 首页。

图a01



```
# 修改安全策略级别，以便顺利安装Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

执行命令，按下 `y` 表示同意修改。

图a04



```
# 连接到官网安装Scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```



但是安装并不是那么的顺利。

有时是因为网络质量问题。

图b01



有时，是因为 `Github` 连接不上造成的。

图b02



最后找了半天，把完整版安装文件直接给下载下来了。

这样省去了各种网络连接不上的麻烦。

（文末有下载）

图b03



老习惯，看一下命令是否正常输出。

图b04



它被安装到哪儿了呢？

在这里。

```
C:\Users\用户名\scoop\apps\scoop\current\bin
```

图b05





查询应用程序。

图a02



一般情况下，`scoop` 会到 `main` 默认的软件仓库中找你要安装的软件。

不过可能 `main` 仓库中并不一定有你想要的，所以诞生了更多的软件仓库。

他们管这些软件仓库叫作 `Buckets` 。



通常的 `Buckets` 有这些，可以到对应的 `Buckets` 中搜索想要安装的软件。

1. `main` - Default bucket for the most common (mostly CLI) apps
2. `extras` - Apps that don’t fit the main bucket’s criteria
3. `games` - Open source/freeware games and game-related tools
4. `nerd-fonts` - Nerd Fonts
5. `nirsoft` - A subset of the 250 Nirsoft apps
6. `java` - Installers for Oracle Java, OpenJDK, Zulu, ojdkbuild, AdoptOpenJDK, 7、Amazon Corretto, BellSoft Liberica & SapMachine
7. `jetbrains` - Installers for all JetBrains utilities and IDEs
8. `nonportable` - Non-portable apps (may require UAC)
9. `php` - Installers for most versions of PHP
10. `versions` - Alternative versions of apps found in other buckets







`Buckets` 如下：

后面打对勾的是官方的 `Bucket` ，后面带问号的则是社区版。

图a01



安装 `Buckets` 。

```
scoop bucket add <Bucket名称>
```







玩法：

有个东东叫作 `aria2` 是一种下载器软件。

`scoop` 可以利用这个 `aria2` 来加速下载软件，因此我们可以先安装 `aria2` 。

```
scoop install aria2
```

图c01



但是有时因 `Github` 脑抽而无法正常下载安装包。

只好将安装包先想办法下载下来，接着手动解压到相应文件夹内即可。

放在下面这个路径中，通常应该在 `scoop` 的 `apps` 文件夹中。

```
C:\Users\用户名\scoop\apps\aria2\1.37.0-1\
```

文末打包 `aria2` 一块下载。

图c02





安装软件

```
scoop install <软件名称>
```





安装 `hotkeyslist` ，一款查看当前系统中快捷键的小程序。

```
scoop install hostkeyslist
```



发现没找到。

图d01



这个 `hostkeyslist` 应该是在 `nirsoft` 的 `Buckets` 中。

因此我们先要安装仓库 `nirsoft` 。

```
scoop bucket add nirsoft
```



正常情况下安装很简单。

图d03



你说什么？`Github` 又抽了？

图d02



好吧，操不完的心啊，干脆还是手动安装吧！

文末提供下载。

将 `Buckets` 放到相应的文件夹内。

```
C:\Users\用户名\scoop\buckets\
```

图d04





更换国内镜像。

```
# 更换scoop的repo地址
scoop config SCOOP_REPO "https://gitee.com/scoop-installer/scoop"

# 拉取新库地址
scoop update
```

图d05











