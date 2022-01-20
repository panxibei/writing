PowerRemoteDesktop

副标题：

英文：

关键字：







### 安装

`PowerRemoteDesktop` 的安装方法灵活多样不止一种，主要的思路就是将模块（包括  `PowerRemoteDesktop_Server` 和 `PowerRemoteDesktop_Viewer` ）放到 `PowerShell` 可访问的模块目录中去。

我们先来介绍最为推荐的方法。



##### 方法一：直接从 `PowerShell` 库安装（推荐）

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







？？？

```powershell
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet
```

？？？



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



##### 方法二：手动将 `PowerRemoteDesktop` 模块导入

刚才我们是利用了 `PowerShell` 库从网络上给它拉下来自动安装的，现在我们试试手动安装，也不算太难搞。

首先我们来确认一下 `PowerShell` 模块所在路径。

```
Write-Output $env:PSModulePath
```

一般情况它会输出几个路径，比如像我这儿是这样的（我将它分行以便看得更清楚）。

```
C:\Users\<USER>\Documents\WindowsPowerShell\Modules;
C:\Program Files\WindowsPowerShell\Modules;
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;
```

图a06



我们先记下这些路径，等会儿再用。

接下来将 `PowerRemoteDesktop` 项目下载下来。

用 `git` 克隆也可以。

```
git clone https://github.com/DarkCoderSc/PowerRemoteDesktop.git
```

直接下载 `Release` 压缩包也可以。

```
https://github.com/DarkCoderSc/PowerRemoteDesktop/archive/refs/tags/1.0.5-beta-6.zip
```



然后找到 `PowerRemoteDesktop_Server` 和 `PowerRemoteDesktop_Viewer` 两个文件夹，如果是压缩包，那么解压出来就可以看到。

图a07



好了，还记得前面我们记录下来的 `PowerShell` 模块所在路径吗？

我们随便选一个路径，比如 `C:\Program Files\WindowsPowerShell\Modules` ，我们将那两个文件夹复制到这个路径中。

图a08



OK！就这样搞定了！哈哈，简单吧！

如果不放心，那么我们就像前一小节那样再验证一下模块是否可查。

```
Get-Module -ListAvailable
或者
Import-Module PowerRemoteDesktop_Server
Import-Module PowerRemoteDesktop_Viewer
```



具体验证效果可以参考前面所述，另外关于那两个模块文件夹中的 `.psd1` 文件实际上并不是必需的，官方说可以将其删除而只保留 `.psm1` 文件，但我发现删除后模块版本信息就丢失了，因此还是不要删除的好。



##### 方法三：当作 `PowerShell` 脚本直接拿来用

实际上将 `PowerRemoteDesktop` 作为模块安装到模块路径中并不是必须要这样做。

事实是你完全可以把它拿来当普通的 `PowerShell` 脚本加载执行。

方法有很多，比如：

```
IEX (Get-Content .\PowerRemoteDesktop_Viewer.psm1 -Raw)IEX (Get-Content .\PowerRemoteDesktop_[Server/Viewer].psm1 -Raw
```

甚至可以从网络上直接调用。

```
IEX (New-Object Net.WebClient).DownloadString('http://127.0.0.1/PowerRemoteDesktop_[Server/Viewer].psm1)
```

不过由于我水平有限，这些方法还没有被一一验证，猜测应该是可以的，有点简单粗暴了哈！

好了，反正前面的安装方法都够用了，我们接下来看看怎么使用它吧！



### 用法

##### 先是客户端，调用 `Invoke-RemoteDesktopViewer` 再加上参数选项即可。



支持选项：

- `ServerAddress`（默认值：`127.0.0.1`）：远程服务器主机/地址。
- `ServerPort`（默认值：`2801`）：远程服务器端口。
- `Password`（必需）：用于服务器身份验证的密码。
- `DisableVerbosity`（默认值：无）：如果存在此开关，则将从控制台中隐藏详细程度。
- `TLSv1_3`（默认值：无）：如果存在此开关，则查看器将使用 TLS v1.3 而不是 TLS v1.2。仅当查看器和服务器都支持 TLS v1.3 时，才使用此选项。
- 剪贴板（默认值：`Both`）：定义剪贴板同步规则：
  - `Disabled`：完全禁用剪贴板同步。
  - `Receive`：仅使用远程剪贴板更新本地剪贴板。
  - `Send`：将本地剪贴板发送到远程对等方。
  - `Both`：剪贴板在查看器和服务器之间完全同步。



举个例子：

```
Invoke-RemoteDesktopViewer -ServerAddress "127.0.0.1" -ServerPort 2801 -Password "12345678"
```



##### 再是服务端，调用 `Invoke-RemoteDesktopServer` 再加上参数选项即可。



支持选项：

- `ListenAddress`（默认值：`0.0.0.0`）：定义在哪个界面中侦听新查看器。
  - `0.0.0.0`： 所有接口
  - `127.0.0.1`：本地主机接口
  - `x.x.x.x`：特定接口（`x` 替换为有效的网络地址）
- `ListenPort`（默认值：`2801`）：定义在哪个端口中侦听新查看器。
- `Password` (**强制**）：定义身份验证过程中使用的密码。
- `CertificateFile`（默认值：**无**）：有效的 X509 证书（带私钥）文件。如果设置，则此参数为优先级。
- `EncodedCertificate`（默认值：**无**）：编码为 Base64 字符串的有效 X509 证书（带私钥）。
- `TransportMode`（默认值：`Raw`）：定义用于传输流的方法。
  - `Raw`：以原始字节的形式传输流（推荐）
  - `Base64`：将流作为 base64 编码的字符串传输
- `TLSv1_3`（默认值：无）：如果此开关存在，服务器将使用 TLS v1.3 而不是 TLS v1.2。仅当查看器和服务器都支持 TLS v1.3 时，才使用此选项。
- `DisableVerbosity`（默认值：无）：如果存在此开关，则将从控制台中隐藏详细程度。
- `ImageQuality`（默认值：）：JPEG 压缩级别从 0 到 100。0 = 最低质量，100 = 最高质量。`100`
- `Clipboard`（默认值：`Both`）：定义剪贴板同步规则：
  - `Disabled`：完全禁用剪贴板同步。
  - `Receive`：仅使用远程剪贴板更新本地剪贴板。
  - `Send`：将本地剪贴板发送到远程对等方。
  - `Both`：剪贴板在查看器和服务器之间完全同步。
- `ViewOnly`（默认值：无）：如果存在此开关，则查看器将无法控制鼠标（移动、单击、滚轮）和键盘。仅对视图会话有用。



如果未设置证书选项，则会生成默认的 X509 证书并将其安装在本地计算机上（需要管理权限）。

比如：

```
Invoke-RemoteDesktopServer -ListenAddress "0.0.0.0" -ListenPort 2801 -Password "12345678"

Invoke-RemoteDesktopServer -ListenAddress "0.0.0.0" -ListenPort 2801 -Password "12345678" -CertificateFile "c:\certs\phrozen.p12"
```

