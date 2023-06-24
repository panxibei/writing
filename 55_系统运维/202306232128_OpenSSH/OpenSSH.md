OpenSSH

副标题：

英文：

关键字：





打开高级安全 `Windows Defender` 防火墙

```
wf.msc
```



图b01



输入命令查看 `SSH` 服务是否已经启动。

```
netstat -anp tcp
```

图b02





使用 `PowerShell` 安装 `OpenSSH`

以管理员身份运行 `PowerShell` ，然后输入以下命令行。

```
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```



命令行最后的那个 `OpenSSH*` ，是指包括服务端 `OpenSSH Server` 和客户端 `OpenSSH Client` 两者。

要是这两个你都还没有安装过，那么命令行执行后应该会得到类似 如下输出信息。

```
Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent

Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```



如下图，显示的状态是 `Installed` ，说明我们已经安装过了。

图b03



要是想挨个安装 `OpenSSH Server` 和 `OpenSSH Client` ，那么就按下面的命令行单独安装即可。

```
# 安装 the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# 安装 OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```



正常情况下应该输出如下信息：

```
Path          :
Online        : True
RestartNeeded : False
```

图b04





`Windows 10` 版本 `1809` 以下或 `Windows Server 2019` 版本以下的系统如何安装 `OpenSSH` 呢？

虽然不能通过前面介绍的方法在线安装，不过不用担心，官方提供了另外的安装方法。

在 `GitHub` 上我找到 `Win32-OpenSSH` 项目，正是官方出品。

我将下载放到文末，方便各位小伙伴下载使用。



从下载项上看，除打包的 `zip` 文件外还可以有 `msi` 的安装程序，这就方便了。

图c01



首先我们拿 `OpenSSH-Win64.zip` 演示一下安装方法。

将它解压到 `C:\Program Files\OpenSSH` 中，切记，不要放在别的路径下，这是官方要求的。

图c02



接着打开命令提示符窗口，切换到 `OpenSSH` 所在目录后执行安装脚本。

```
cd C:\Program Files\OpenSSH
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1
```

图c03

图c04



然后来几个善后工作。

先开放防火墙 `22` 号端口，当然你可以将 `22` 修改为你自己想要的其他数字。

```
netsh advfirewall firewall add rule name=sshd dir=in action=allow protocol=TCP localport=22
```

图c05



再设置开机自动启动 `sshd` 服务。

```
# 开机自动启动 sshd 服务
sc config sshd start=auto

# 手动启动 sshd 服务
net start sshd
```

图c06







给 `OpenSSH` 配置默认的 `shell` 。

要使用 `SSH` 登录到目标服务器，总是要提供一个终端程序用于操作管理嘛！

默认情况下，`Windows` 的这个 `shell` 就是 `cmd.exe` 。

当然也可以修改为其他的，比如 `PowerShell` 。

```
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
```



接着我们要修改一下配置文件 `sshd_config` 。

这个配置文件默认在这里，不要搞错了哦！

否则改了半天都没效果。

```
%programdata%\ssh\sshd_config
```



我们修改什么配置呢？

这里有四个允许或拒绝访问的参数：`AllowGroups` 、 `AllowUsers` 、 `DenyGroups` 、 `DenyUsers` 。

这四个参数看字面意思也能看懂吧！

前两个是允许的组或用户，后两个是拒绝的组或用户。

需要注意的是，它们的处理顺序是这样的： `DenyUsers` 、 `AllowUsers` 、 `DenyGroups` ，最后是  `AllowGroups` 。 

还有，必须以小写形式指定所有帐户名称。



还有还有，当配置域用户或组时，应该使用这样的格式：`user?domain*` 。

为避免与标准 `Linux` 模式冲突，因此用 `*` 来涵盖 `FQDN` 。

此外用 `?` 而非 `@` 也是避免与 `Username@host` 这种格式发生冲突。

工作组用户或组将解析为本地帐户名称，而域用户和组将严格解析为 `domain_short_name\user_name` 这样的 `NameSamCompatible` 格式。



好了，说了这么多要求，还是举几个例子来得直观一些。

```
# 域用户和组示例
DenyUsers contoso\admin@192.168.2.23 : blocks contoso\admin from 192.168.2.23
DenyUsers contoso\* : blocks all users from contoso domain
AllowGroups contoso\sshusers : only allow users from contoso\sshusers group

# 本地用户和组示例
AllowUsers localuser@192.168.2.23
AllowGroups sshusers
```





如果出现远程服务器信息改变而导致登录失败，应该是之前保存下来的指纹记录失效了。

图d13



这时可以将文件 `known_hosts` 中的对应登录目标服务器信息的所在行删除后再试。

```
C:\Users\用户名\.ssh\known_hosts
```

图d12



顺便说一下怎么解决出现登录失败时，总是提示“拒绝访问，请重试”的提示。

```
网管小贾@localhost's password:
Permission denied, please try again.
网管小贾@localhost's password:
Permission denied, please try again.
网管小贾@localhost's password:
Permission denied (publickey,password,keyboard-interactive).
```



先将 `OpenSSH` 服务停止，然后用以下加 `-d` 参数的命令行方式开启调试模式。

```
sshd.exe -d
```



然后再连接登录试试看，通常会有相应错误提示。

我这边碰到的是绑定端口 `22` 到 `0.0.0.0` 失败，拒绝访问！

图d09



这个情况让我非常震惊，其实原因也很简单，因为很明显 `22` 端口被占用了嘛！

只要将占用的程序关闭，或者换个端口，一切问题迎刃而解！















