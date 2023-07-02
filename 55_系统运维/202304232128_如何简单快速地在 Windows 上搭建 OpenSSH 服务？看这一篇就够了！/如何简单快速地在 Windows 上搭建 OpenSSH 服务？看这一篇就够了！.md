如何简单快速地在 Windows 上搭建 OpenSSH 服务？看这一篇就够了！

副标题：如何简单快速地在 Windows 上搭建 OpenSSH 服务？看这一篇就够了！

英文：how-to-easily-and-quickly-build-openssh-service-on-windows-just-read-this-one

关键字：ssh,sshd,openssh,windows





各位小伙伴，你们好！

上一期我们介绍了在 `Windows` 上使用第三方软件 `freeSSHd` 来搭建 `SSH` 服务。

文章中也提到过，`Windows` 实际上是有自带 `OpenSSH` 可以直接利用的。

那为啥还要用第三方的 `freeSSHd` 呢？

原因很简单，这个 `OpenSSH` 服务端是从 `Windows 10 1809` 和 `Windows Server 2019` 才开始支持的。

因此你想要直接用上 `OpenSSH` 的话，就要看验一验你的 `Windows` ，是不是满足版本需要哈！



那么这一期，我们就假定你的 `Windows` 完全满足上面提到的版本要求，来一起看一看 `Windows` 自带的 `OpenSSH` 服务是怎么搭建的吧！

至于什么是 `SSH` ，什么是 `OpenSSH` ，如果你还不太清楚，那么可以到前一期文章中自行查阅，这里就不多啰嗦了。

我们直接开干，从安装说起，期间再穿插可能的坑，一并给它填上。



安装一点也不难，有键盘和鼠标就能操作，下面看图说话。

打开 `Windows` 设置，进入 `应用` 。

图01



在 `应用和功能` 区域点击 `可选功能` （ `OpenSSH` 的服务端和客户端者属于可选功能）。

图02



默认系统已经安装了 `OpenSSH` 客户端，而我们需要的是服务端，接着点击 `添加功能` 。

图03

图04



在列表中勾选 `OpenSSH` 服务器，并点击 `安装` 按钮开始安装。

图05



就这样，只要网络正常，它就会自动开始安装了。

图06



成功安装后的样子。

图07



安装后 `OpenSSH` 相关程序都被放到了 `C:\Windows\System32\OpenSSH` 路径下。

图08



如果不幸遭遇安装失败也别着急，通常是因为网络不佳造成的，不过请放心后面会有办法对付它。

图09



我们再介绍一下命令行方式的安装方法，即使用 `PowerShell` 来安装 `OpenSSH` ，这也是官方推荐的另一方法。

先以管理员身份将 `PowerShell` 运行起来，然后用你那灵活的手指输入以下命令行。

```
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```



注意，命令行最后的那个 `OpenSSH*` ，瞧见最后的那个星号没，它是通配符，是指包括服务端 `OpenSSH Server` 和客户端 `OpenSSH Client` 两者我都要的意思。

要是这两个你都还没有安装过（有时默认客户端是已经安装好的），那么命令行执行后应该会得到类似如下的输出信息。

`NotPresent` 大概就是尚未安装的意思吧。

```
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent

Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```



如下图，要是显示的状态是 `Installed` ，则说明我们已经成功安装过了。

图10



当然，要是你想挨个安装 `OpenSSH Server` 和 `OpenSSH Client` ，那么就按下面的命令行单独安装即可。

```
# 安装 the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# 安装 OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```



正常情况下就应该输出类似如下信息：

```
Path          :
Online        : True
RestartNeeded : False
```

图11



命令行也挺简单哈！

好，前面我们也说了，要是网络不好安装失败可咋整啊？

请放宽心哈，现在我就给小伙伴们介绍一下离线安装大法！



没错，这种离线安装大法就是用安装包直接给它安装上，并且也能非常有效地搞定 `Windows 10` 版本 `1809` 以下或 `Windows Server 2019` 版本以下的系统，可谓是一举两得，居家旅行之必备良药啊！

自然这也是官方推荐的安装方法之一，可不是我乱说的哦！

不过很奇怪的是，微软官网上我没有找到下载安装包的地方，倒是在 `GitHub` 上找到一个叫作 `Win32-OpenSSH` 项目。

通过验证也确实是官方出品无疑。

我将下载放到文末，方便各位小伙伴下载使用，我们先来介绍如何离线安装吧！



有个意思的地方，从下载项上看，除打包的 `zip` 文件外还有一个 `msi` 的安装程序，这就更加方便了。

图12



我们先拿 `OpenSSH-Win64.zip` 的打包程序来演示一下安装方法。

将它下载并解压到 `C:\Program Files\OpenSSH` 中，切记，**不要放在别的路径下**，这是官方要求的。

图13



接着打开命令提示符窗口，切换到 `OpenSSH` 所在目录后执行安装脚本。

```
// 切换目录
cd C:\Program Files\OpenSSH

// 执行安装脚本
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1
```

图14

图15



如果是离线安装地话，我们还需要视情况而定，再设置开机自动启动 `sshd` 服务。

```
# 开机自动启动 sshd 服务
sc config sshd start=auto

# 手动启动 sshd 服务
net start sshd
```

图16



离线安装也很容易搞定是不是？

如果你是低版本的 `Windows 10` ，或是其他的如 `Windows 7` 的老系统，完全可以尝试使用这个离线安装包。



安装搞定，接下来我们还要来做几个善后工作，`OpenSSH` 才能正常为我们提供服务。



`OpenSSH` 默认服务端口是 `22` ，那么我们要设置防火墙开放 `22` 号端口，当然你完全可以将 `22` 修改为你自己想要的其他数字。

如下一条命令就可以快捷搞定。

```
netsh advfirewall firewall add rule name=sshd dir=in action=allow protocol=TCP localport=22
```

图17



当然，你水平够也可以自行开启防火墙设置。

比如，用以下命令打开高级安全 `Windows Defender` 防火墙。

```
wf.msc
```



然后设置后再查看名为 `OpenSSH SSH Server (sshd)` 的规则。

注意，只要开放了相应的端口就行，这个规则的名字并不一定要相同。

图18



接着我们输入命令查看一下 `SSH` 服务是否已经启动，默认它安装完成后就会自动启动。

```
netstat -anp tcp
```

从输出结果中可以看到 `0.0.0.0:22` ，说明 `OpenSSH` 服务正在愉快地工作。

图19



安装部分基本告一段落，紧接着我们必须告诉 `OpenSSH` 我们应该怎么访问它。

说到访问，我们可以给 `OpenSSH` 配置一个默认的 `shell` 。



要使用 `SSH` 登录到目标服务器，总是要提供一个终端程序 `shell` 用于操作管理嘛！

默认情况下，`Windows` 的这个 `shell` 就是命令提示符 `cmd.exe` 。

通过 `SSH` 登录后会看到这个样子。

图20



当然也可以修改为其他的，比如 `PowerShell` 。

以管理员身份运行 `PowerShell` ，然后就像下面这样，有兴趣的小伙伴可以试一试。

```
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
```

图21



其实吧说穿了，就是在注册表里添加一项叫作 `DefaultShell` 的键值。

手脚勤快的小伙伴可以参考着用批处理啥的其他方式也能修改。

图22



修改后再通过 `SSH` 登录后会看到这个样子。

图23





接着我们要修改一下主要配置文件 `sshd_config` 了。

注意注意，这个**配置文件默认在这里**，否则改了半天都没效果，千万不要搞错了哦！

```
%programdata%\ssh\sshd_config
```

图24



我们修改什么配置呢？

默认情况下，我们的用户可能还无法直接登录访问目标服务，因为有限制嘛！

这里呢就有四个允许或拒绝访问的参数，分别是：`AllowGroups` 、 `AllowUsers` 、 `DenyGroups` 、 `DenyUsers` 。

这四个参数看字面意思也能看懂吧！

前两个是允许的组或用户，后两个是拒绝的组或用户。

需要注意的是，它们的处理顺序是这样的：先是 `DenyUsers` 、后是 `AllowUsers` 、然后是 `DenyGroups` ，最后是  `AllowGroups` 。 

还有，必须以小写形式指定所有帐户名称。



还有还有，当配置域用户或组时，应该使用这样的格式：`user?domain*` 。

为避免与标准 `Linux` 模式冲突，因此用 `*` 来涵盖 `FQDN` 。

此外用 `?` 而非 `@` 也是避免与 `Username@host` 这种格式发生冲突。

工作组用户或组将解析为本地帐户名称，而域用户和组将严格解析为 `domain_short_name\user_name` 这样的 `NameSamCompatible` 格式。



好了，说了这么多要求，还是举几个例子来得直观一些。

```
# 域用户和组示例
DenyUsers contoso\admin@192.168.2.23 : 拒绝来自 192.168.2.23 的 contoso\admin 
DenyUsers contoso\* : 拒绝来自 contoso 域的所有用户
AllowGroups contoso\sshusers : 仅允许来自 contoso\sshusers 组的用户

# 本地用户和组示例
AllowUsers localuser@192.168.2.23
AllowGroups sshusers
```



OK，对于 `Windows` 的 `OpenSSH` 来说，基本的配置可以做到如此简单（其实有些配置只在 `Linux` 有效）！



通常我们连接 `SSH` 服务（也就是连接目标服务器）时，只要正确输入用户名和密码后就可以成功登录了。

当然了，第一次登录会询问用户并记录指纹信息，这个也不耽误登录哈！

图25



确认继续连接并保存指纹信息后，只要输入正确密码即可成功登录。

图26



不过要是除去用户名和密码输错的情况还登录失败，那么就会让人感觉有点不爽。

对了，接下来我们也一并说一说遇坑踩坑的问题吧。



首先一个，如果出现远程服务器信息改变而导致登录失败，原因应该是之前保存下来的指纹记录失效了。

图27



这个问题并不一定 `OpenSSH` 设置本身的问题，可能是 `IP` 地址或域名变更等操作造成的问题。

这时可以将文件 `known_hosts` 中的对应登录目标服务器信息的所在行删除后再试。

```
C:\Users\用户名\.ssh\known_hosts
```

图28



再一个，正好我也遇上了，说一下怎么解决出现登录失败时，总是提示“拒绝访问，请重试”的提示，类似如下。

```
网管小贾@localhost's password:
Permission denied, please try again.
网管小贾@localhost's password:
Permission denied, please try again.
网管小贾@localhost's password:
Permission denied (publickey,password,keyboard-interactive).
```



我们可以用调试大法，先将 `OpenSSH` 服务停止，然后用以下加 `-d` 参数的命令行方式开启调试模式。

```
sshd.exe -d
```



然后再连接登录试试看，通常会有相应错误提示。

我这边碰到的是绑定端口 `22` 到 `0.0.0.0` 失败，拒绝访问！

图29



这个情况令我非常震惊，原因很直白也很简单，很明显 `22` 端口被占用了嘛！

真是奇了怪了，谁会占用默认的这个端口呢？

花了我个把钟头的时间，这才发现，之前安装的 `freeSSHd` 正努力地跑着，真是闹了个大乌龙！

好了，只要将占用端口的程序关闭，或者换个端口，一切问题也就迎刃而解了！

网上也小伙伴提出过类似的故障情况，可以作为参考，希望大家少走弯路，不再迷茫！



**个人收集的 `Windows` 版的 `OpenSSH` 安装包(9.57M)：**

* `OpenSSH.7z` - 在线安装后打包自 `C:\Windows\System32\OpenSSH` 文件夹的内容
* `OpenSSH-Win64.zip` - `Zip` 压缩安装包
* `OpenSSH-Win64-v9.2.2.0.msi` - 微软格式安装程序

下载链接：https://pan.baidu.com/s/1ynPUBwtfQaj8p1VB9xeeoA

提取码：44or



以上是我初步测试 `Windows` 下 `OpenSSH` 的亲身体验，分享给感兴趣的小伙伴们。

最后祝大家学习进步、食用愉快！





**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc









