nssm

副标题：

英文：

关键字：nssm,srvany,windows,服务









虽然 `nssm` 的最终稳定版 `2.24` 停留在 `2014` 年，但是它还是支持 `Windows 10` 、`Windows Server 2016` 甚至是更新的 `Windows` 版本的，因此大可不必担心是否能正常使用的问题。







找了一个以前自制的小游戏试试吧。

按照前面提示过的，我们先打条安装服务的命令。

注意，命令提示符窗口要以管理员身份运行哦！

```
# LightsOut是服务名，我自己随便取的
nssm.exe install LightsOut
```

输完命令后回车，`GUI` 界面果然出现了！

图a03



然后官网介绍的用法，我们只要在 `Path` 一项中简单地填入应用程序所在的完全路径，这是唯一一个必填项哦！

如果没有什么特殊的，那么启动目录 `Startup directory` 自动会变成应用程序所在目录。

至于参数 `Arguments` 一项，当前的程序并没有什么参数，因此可以省略。

图a04



好了，别的什么都不要做，我们点击安装服务 `Install service` 按钮。

嘿！它居然说安装成功了！

图a05



赶紧去 `Windows` 服务管理器中查看，的确有名为 `LightsOut` 的一个新建服务。

不过怎么打开看时，其可执行文件的路径写的是 `nssm.exe` 的路径，这就非常奇怪了！

图a06



这里会不会有什么误会哈？

总之我们先尝试启动这个服务看看，嗯，服务好像正常启动了。

图a07



再顺手打开任务管理器，我们的应用程序 `LightsOut.exe` 确实正在运行，同时 `nssm.exe` 也在运行，它们两个都是以 `SYSTEM` 身份运行，

图a08



有的小伙伴会说，我怎么看不到程序界面，实际上以服务形式（通常是 `SYSTEM` 用户身份）运行程序通常是看不到界面的，也就是无法通过界面来操作程序。





其他一些设定。

详细信息。

图b01

图b10



##### 登录身份

默认是本地系统帐户，也就是 `SYSTEM` 。

此外还可以设定是否与桌面交互，或使用其他登录身份。

图b02



##### 依赖服务

当前服务依赖哪些服务，可以将这些服务填写在这里。

图b03



##### 进程

进程优先级，以及处理器分配等等，通常保持默认即可。

图b04



##### 关闭服务

服务如何关闭、退出，这里有几种方式。

```
nssm set <服务名称> AppStopMethodSkip 0
nssm set <服务名称> AppStopMethodConsole 1500
nssm set <服务名称> AppStopMethodWindow 1500
nssm set <服务名称> AppStopMethodThreads 1500
```

图b05



##### 退出操作

退出操作可用于调整服务退出时的重启限制和默认操作、重启间隔延迟等等。

```
nssm set <服务名称> AppThrottle 1500
nssm set <服务名称> AppExit Default Restart
nssm set <服务名称> AppRestartDelay 0
```

图b06



##### I/O

输入/输出可以帮我们设定一些比如应用程序日志消息等等。

```
nssm set <服务名称> AppStdout C:\sysadm\logs\service.log
nssm set <服务名称> AppStderr C:\sysadm\logs\error.log
```

图b07



##### 文件轮换

网络上有些教程并没有写清楚这玩意到底是啥意思。

实际上它是指多文件设定，啥意思呢，就是写完一个文件后再写一个文件。

举例来说，比如一个日志文件，我们不可能让它一直写下去最终导致非常庞大。

因此，通过文件轮换，那么我们可以将一个日志文件分成几个。

怎么分呢？

可以是有时间间隔的，比如过多久轮换（写一个）新文件，旧文件就不管了。

也可以是有大小比较的，比如旧文件到大一定程度，那么我们就轮换成一个新文件。

这个文件轮换方式可以和 `I/O` 结合使用。

```
nssm set <服务名称> AppStdoutCreationDisposition 4
nssm set <服务名称> AppStderrCreationDisposition 4
nssm set <服务名称> AppRotateFiles 1
nssm set <服务名称> AppRotateOnline 0
nssm set <服务名称> AppRotateSeconds 86400
nssm set <服务名称> AppRotateBytes 1048576
```

图b08



##### 环境变量

这个很好理解，可以为服务程序提供环境变量访问相应资源。

```
nssm set <服务名称> AppEnvironmentExtra TEMP=C:\Temp
nssm set <服务名称> AppEnvironmentExtra JAVA_HOME=C:\Java\bin GO_HOME=C:\Go\bin
```

图b09







### 卸载服务

很简单，带上 `remove` 卸载参数即可。

```
nssm.exe remove <服务名称>
```

图c01



### 操作服务

```
# 启动服务
nssm.exe start <服务名称>

# 停止服务
nssm.exe stop <服务名称>

# 重启服务
nssm.exe restart <服务名称>

# 暂停服务
nssm.exe pause <服务名称>

# 查看状态
nssm.exe status <服务名称>

# 文件轮换
nssm.exe rotate <服务名称>
```



### 编辑服务

通常使用 `get` 或 `set` 来为服务获取或设置一些参数，前面也有过示例。

```
nssm.exe get <服务名称> <参数>
nssm.exe get <服务名称> <参数> <子参数>

nssm.exe set <服务名称> <参数> <值>
nssm.exe set <服务名称> <参数> <子参数> <值>
```



如果你嫌麻烦，想将参数重置为默认值，那就直接用 `reset` 参数吧。

```
nssm.exe reset <服务名称> <参数>
nssm.exe reset <服务名称> <参数> <子参数>
```

