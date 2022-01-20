PowerRemoteDesktop

副标题：

英文：

关键字：







### 安装

`PowerRemoteDesktop` 的安装方法灵活多样不止一种，主要的思路就是将模块（包括  `PowerRemoteDesktop_Server` 和 `PowerRemoteDesktop_Viewer` ）放到 `PowerShell` 可访问的模块目录中去。

我们先来介绍最为推荐的方法。



##### 直接从 `PowerShell` 库安装（推荐）

`PowerShell` 库，也就是 `PowerShell Gallery` ，实际上有点像 `Linux` 的软件源库，我们可能通过这个库，直接从里边将我们所需的软件给找来并安装上。



不过我们需要先注意一个问题，可能有的小伙伴是第一次执行 `PowerShell` 命令，因此其系统执行策略很有可能是默认的 `Restricted` ，也就是受限策略，那么就会导致后面的命令无法正常执行。

解决方案很简单，按以下命令操作即可。

```
# 查看当前执行策略
get-executionpolicy

# 更改执行策略为 remotesigned
set-executionpolicy remotesigned
```

图a01









```powershell
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet
```





用 `PowerShell` 库来查看和安装 `Power Remote Desktop` ，可以用以下命令。

```powershell
# 查看服务端模块和客户端模块
Find-Module -Name PowerRemoteDesktop_Server -AllowPrerelease
Find-Module -Name PowerRemoteDesktop_Viewer -AllowPrerelease


```

图a02



```
# 安装服务端模块和客户端模块
Install-Module -Name PowerRemoteDesktop_Server -AllowPrerelease
Install-Module -Name PowerRemoteDesktop_Viewer -AllowPrerelease
```





其中，命令后面跟着的 `-AllowPrerelease` 参数是指当前版本为预备发行版，加上去的原因也很简单，因为现在正式版还没有嘛！

当我们执行以上命令时，可能会显示如下警告：

> Untrusted repository
> You are installing the modules from an untrusted repository. If you trust this repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the modules from
> 'PSGallery'?

图a03



这是系统为了安全起见，提示我们当前使用的是非任何软件源。

它是好心，但我们知道我们在做什么对吧，所以回答自然就是 `Yes` 。

OK，这样就安装好了！

图a04



我们可以使用以下命令来验证一下两个模块是否已经放到系统中了。

```
Get-Module -ListAvailable
```



正常情况下命令会输出一大堆模块记录信息，我们只要找到带有 `PowerRemoteDesktop...` 字样的记录行就说明安装OK。

```powershell
PS C:\Users\<USER>\Desktop> Get-Module -ListAvailable

    Directory: C:\Users\<USER>\Documents\WindowsPowerShell\Modules

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0.0      PowerRemoteDesktop_Server           Invoke-RemoteDesktopServer
Manifest   1.0.0      PowerRemoteDesktop_Viewer           Invoke-RemoteDesktopViewer

<..snip..>
```



当然也可以将输出内容过滤一下，这样眼睛也少受罪一些。

```
Get-Module -listavailable |where {$_ -match "PowerRemoteDesktop"}
```

图a05



亦或者用以下命令检查，如果没有正确安装它就会输出错误信息，反之则不会有任何提示。

```powershell
Import-Module PowerRemoteDesktop_Server
Import-Module PowerRemoteDesktop_Viewer
```

