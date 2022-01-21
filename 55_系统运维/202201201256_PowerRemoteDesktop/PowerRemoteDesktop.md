谁能想到，一款功能强大、安装使用又超级方便的远程桌面软件居然是用小众编程语言写的，猜猜是哪个？

副标题：PowerRemoteDesktop：一款简捷方便功能强大的远程桌面软件

英文：a-powerful-remote-desktop-application-was-coded-by-an-unusual-programming-language-guess-which-one

关键字：powershell,windows,power,remote,desktop,vnc



经常管理服务器的小伙伴们应该很有体会，远程连接访问服务器是每天都要做的繁琐事情。

虽然我们已经习惯了 `远程桌面连接` 或是 `VNC` 之类的远程软件，但是你有没有想过自己做一个也可以实现远程服务器的软件呢？

不是我想多了，而是网络上的大神们又开始骚动了！

没错，你猜对了！

他们不会囿于眼前所看到的、听到的和其他感知到的一切，而是一门心思就是要自己来创造属于自己的宇宙。

对于我们这些小白来说，大神们是高高在上、令人仰望的存在，怎么可能阻止得了他们呢！

所以说，我们的最佳做法就是，安安静静、整整齐齐地坐好，把小手放在背后，认真地听我给你们吹大神！



不知道小伙伴们平时有没有关注过所谓的编程语言排行榜呢？

嗯，就像看富豪榜一样，我们的眼睛只盯着那些排名第一、第二的，充其量也只看前十名，要不说我们都是些资质一般的凡人呢！

在我们眼里众多的编程语言中似乎只有什么 `JAVA` 、 `C/C++` ，还有什么新生代 `Python` 和 `Go` 之类的，因此我可以打包票没有几个人会注意到一个非常小众的编程语言。

它就是我们早已常见而又不自知的 `PowerShell` ！

是的，它不在前十名之内，但它却在前三十名之内，你可能从来都没有真正地关注过它，甚至可能你会认为它根本不算是一门编程语言。

好了，现在我可以告诉你，它不仅是，而且还一点也不差劲，并且大神们拿它开发出了一套远程访问服务器的软件，并将其命名为 `Power Remote Desktop` 。

> 项目链接：https://github.com/DarkCoderSc/PowerRemoteDesktop



说到这儿可能有些小伙伴会质疑甚至是嘲笑，好吧，我来讲得更明白一些。

`Power Remote Desktop` 基于 `PowerShell` 编码，并不依赖于任何现有的远程桌面应用程序或协议，并且它只是单纯的 `PowerShell` 代码实现。

它功能齐全，和通常的远程桌面程序一样强大，但它更易用，并且安装十分方便灵活。



目前 `Power Remote Desktop` 处于测试阶段，可以在 `Win10/Win11` 上正常运行。

接下来让我们一起见识一下这款简捷而功能又不失强大的远程软件吧！



### 特性

`PowerRemoteDesktop` 当前测试版本 `1.0.5 Beta 6` ，可以支持以下特性。

- 支持 `HDPI` 和缩放的远程桌面流。
- 远程控制：鼠标（移动、单击、滚轮）和击键（键盘）
- **安全**：网络流量使用 `TLSv1.2` 或 `1.3` 进行加密。通过基于质询的身份验证机制（使用用户定义的复杂密码）授予对服务器的访问权限。
- 网络流量加密使用的是默认的 `X509` 证书（需要管理员）还是自定义 `X509` 证书。
- 支持服务器证书指纹验证，并且可以选择在会话之间持久化。
- 查看器和服务器之间的剪贴板文本同步。
- 鼠标光标图标状态在查看器（虚拟桌面）和服务器之间同步。
- 多屏幕（监视器）支持。如果远程计算机具有多个桌面屏幕，则可以选择要捕获的桌面屏幕。
- 用于演示的"仅查看" `ViewOnly` 模式。可以禁用远程控制功能，只需向远程对等方显示屏幕即可。



### 安装

`PowerRemoteDesktop` 的安装方法灵活多样不止一种，主要的思路就是将模块（包括  `PowerRemoteDesktop_Server` 和 `PowerRemoteDesktop_Viewer` ）放到 `PowerShell` 可访问的模块目录中去。

我们先来介绍最为推荐的方法。



##### 方法一：直接从 `PowerShell` 库安装（推荐）

`PowerShell` 库，也就是 `PowerShell Gallery` ，实际上有点像 `Linux` 的软件源库，我们可以通过这个库，直接从里边获取我们所需的软件并安装上。



不过我们需要先注意几个问题，首先可能有的小伙伴是第一次执行 `PowerShell` 命令，因此其系统执行策略很有可能是默认的 `Restricted` ，也就是受限策略，那么就会导致后面的命令无法正常执行。

解决方法很简单，按以下命令操作即可。

```
# 查看当前执行策略
Get-ExecutionPolicy

# 更改执行策略为 RemoteSigned
Set-ExecutionPolicy RemoteSigned
```

图01



另一个问题，我们还需要使用 `NuGet` 提供程序来与基于 `NuGet` 存储库交互。

所以要将 `NuGet` 和 `PowerShellGet` 都安装上，**记得安装好后重启 `PowerShell`** 。

```powershell
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet
```



如果你的系统中没有 `PSGallery` ，以上命令可能会失败，那么需要先安装它。

我找了很久，最后还是通过手动添加一个 `xml` 文件才成功，方法也简单易懂得。

在以下文件夹内找到或创建（如果没有）一个名为 `PowerShellGet` 的文件夹。

`C:\Users\<username>\AppData\Local\Microsoft\Windows\PowerShell`



然后将以下内容保存为文件，命名为 `PSRepositories.xml` ，并放到 `PowerShellGet` 文件夹中。

```xml
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>System.Collections.Specialized.OrderedDictionary</T>
      <T>System.Object</T>
    </TN>
    <DCT>
      <En>
        <S N="Key">PSGallery</S>
        <Obj N="Value" RefId="1">
          <TN RefId="1">
            <T>Microsoft.PowerShell.Commands.PSRepository</T>
            <T>System.Management.Automation.PSCustomObject</T>
            <T>System.Object</T>
          </TN>
          <MS>
            <S N="Name">PSGallery</S>
            <S N="SourceLocation">https://www.powershellgallery.com/api/v2</S>
            <S N="PublishLocation">https://www.powershellgallery.com/api/v2/package/</S>
            <S N="ScriptSourceLocation">https://www.powershellgallery.com/api/v2/items/psscript</S>
            <S N="ScriptPublishLocation">https://www.powershellgallery.com/api/v2/package/</S>
            <Obj N="Trusted" RefId="2">
              <TN RefId="2">
                <T>System.Management.Automation.SwitchParameter</T>
                <T>System.ValueType</T>
                <T>System.Object</T>
              </TN>
              <ToString>False</ToString>
              <Props>
                <B N="IsPresent">false</B>
              </Props>
            </Obj>
            <B N="Registered">true</B>
            <S N="InstallationPolicy">Untrusted</S>
            <S N="PackageManagementProvider">NuGet</S>
            <Obj N="ProviderOptions" RefId="3">
              <TN RefId="3">
                <T>System.Collections.Hashtable</T>
                <T>System.Object</T>
              </TN>
              <DCT />
            </Obj>
          </MS>
        </Obj>
      </En>
    </DCT>
  </Obj>
</Objs>
```



好了，准备工作OK！

用 `PowerShell` 库来查看和安装 `Power Remote Desktop` ，可以用以下命令。

```powershell
# 查看服务端模块和客户端模块
Find-Module -Name PowerRemoteDesktop_Server -AllowPrerelease
Find-Module -Name PowerRemoteDesktop_Viewer -AllowPrerelease
```

图02



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

图03



这是系统为了安全起见，提示我们当前使用的是非任何软件源。

它是好心，但我们知道我们在做什么对吧，所以回答自然就是 `Yes` 。

OK，这样就安装好了！

图04



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

图05



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

图06



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

图07



好了，还记得前面我们记录下来的 `PowerShell` 模块所在路径吗？

我们随便选一个路径，比如 `C:\Program Files\WindowsPowerShell\Modules` ，我们将那两个文件夹复制到这个路径中。

图08



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
- `Password`（**必需**）：用于服务器身份验证的密码。
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

图09



这里需要我们注意的是，它会询问我们是否信任当前服务器，如果你需要经常连接的话，那么建议选择 `Always` ，服务器将被加入信任列表。

在后面我们会说明如何查看和删除被加入信任列表中的服务器。



##### 再是服务端，调用 `Invoke-RemoteDesktopServer` 再加上参数选项即可。



支持选项：

- `ListenAddress`（默认值：`0.0.0.0`）：定义在哪个界面中侦听新查看器。
  - `0.0.0.0`： 所有接口
  - `127.0.0.1`：本地主机接口
  - `x.x.x.x`：特定接口（`x` 替换为有效的网络地址）
- `ListenPort`（默认值：`2801`）：定义在哪个端口中侦听新查看器。
- `Password` (**必需**）：定义身份验证过程中使用的密码。
- `CertificateFile`（默认值：**无**）：有效的 X509 证书（带私钥）文件。如果设置，则此参数为优先级。
- `EncodedCertificate`（默认值：**无**）：编码为 Base64 字符串的有效 X509 证书（带私钥）。
- `TransportMode`（默认值：`Raw`）：定义用于传输流的方法。
  - `Raw`：以原始字节的形式传输流（推荐）
  - `Base64`：将流作为 base64 编码的字符串传输
- `TLSv1_3`（默认值：无）：如果此开关存在，服务器将使用 TLS v1.3 而不是 TLS v1.2。仅当查看器和服务器都支持 TLS v1.3 时，才使用此选项。
- `DisableVerbosity`（默认值：无）：如果存在此开关，则将从控制台中隐藏详细程度。
- `ImageQuality`（默认值：`100` ）：JPEG 压缩级别从 0 到 100。0 = 最低质量，100 = 最高质量。
- `Clipboard`（默认值：`Both`）：定义剪贴板同步规则：
  - `Disabled`：完全禁用剪贴板同步。
  - `Receive`：仅使用远程剪贴板更新本地剪贴板。
  - `Send`：将本地剪贴板发送到远程对等方。
  - `Both`：剪贴板在查看器和服务器之间完全同步。
- `ViewOnly`（默认值：无）：如果存在此开关，则查看器将无法控制鼠标（移动、单击、滚轮）和键盘。仅对视图会话有用。



如果未设置证书选项，则会生成默认的 X509 证书并将其安装在本地计算机上（需要管理员权限）。

比如：

```
Invoke-RemoteDesktopServer -ListenAddress "0.0.0.0" -ListenPort 2801 -Password "12345678"
```



需要注意，密码一定要符合复杂度，否则会提示错误导致服务无法正常启动。

密码规则：至少12位，至少有一个 `!@#%^&*_` 中的特殊字符，至少要有小写和大写字母。

图10



一切OK后，服务就能正常启动了。

图11



当客户端成功连接到服务器时，我们就可以看到服务端那边的画面了。

图12



如果有证书，那么加上证书就行了。

```
Invoke-RemoteDesktopServer -ListenAddress "0.0.0.0" -ListenPort 2801 -Password "12345678" -CertificateFile "c:\certs\sysadm.p12"
```



##### 生成自己的 `X509` 证书

使用自己创建生成的 `X509` 证书，然后用于 `PowerRemoteDesktop` 则可以不用以管理员身份运行 `PowerShell` 实例。

我们可以使用 `OpenSSL` 很方便地创建自己的 `X509` 证书。



创建生成证书，私钥为 `sysadm.key` ，证书为 `sysadm.crt` 。

```
openssl req -x509 -sha512 -nodes -days 365 -newkey rsa:4096 -keyout sysadm.key -out sysadm.crt
```



然后导出包含私钥的新证书 `sysadm.p12` 。

```
openssl pkcs12 -export -out sysadm.p12 -inkey sysadm.key -in sysadm.crt
```



有了证书 `sysadm.p12` ，那么我们可以通过两种方法使用它。

一种是将证书直接加到参数 `-CertificateFile` 后面，就像前面介绍的那样。

另一种还可以将证书编码为 `base64` 字符串，再加到参数 `-EncodedCertificate` 后面。

将证书 `phrozen.p12` 编码为 `base64` 字符串，可以使用任何生成 `base64` 的命令或程序。

```
base64 -i sysadm.p12
```



##### 列出受信任的服务器

通常我们会有一些固定经常连接的服务器，而每次都要手动指定诸如 `IP` 地址、密码等等信息会非常麻烦，较为方便的做法是将这些我们信任的服务器给添加到信任列表中，这样一来我们就可以便利地直接调用连接它们了。

前面有说过，当客户端连接服务端时程序会提示是否信任当前服务器，此时如果选择总是 `Always` 的话，那么服务器就被加入了信任列表，否则每当连接时就会再次出现询问提示。

那么怎么查看有哪些服务器曾经被我们信任过呢？

就一个命令 `Get-TrustedServers` 。

```
Get-TrustedServers
```

输出示例：

```
PS C:\> Get-TrustedServers

Detail                           Fingerprint
------                           -----------
@{FirstSeen=2022/1/21 09:16:25} D8615E954B68BB602896167C9112B003C859BA03
```

图13



同样删除信任列表中的服务器也很方便，分别是如下两个命令。

```
# 删除某个服务器（永久）
Remove-TrustedServer
```

图14



```
# 删除所有服务器（永久）
Clear-TrustedServers
```

图15



### 写在最后

经过我的一番测试，发现一开始的确成功连接到服务器了，可是我只能看到画面而无法操作鼠标和键盘。

后来我在服务端加上了参数 `ViewOnly` 再次启动，这次在连接时程序明确提示是仅查看访问。

图16



然后我把服务端关闭后，再次去掉参数 `ViewOnly` 启动服务，这回我连接完成后就可以操作键盘鼠标了。

此外还有，当我启动某些程序而又需要通过 `UAC` （帐户访问控制）时，它就卡住了什么都干不了了。

想来应该是还存在某些 `BUG` ，毕竟仍在测试版阶段，希望以后能改善修复。



最后不得不说，毕竟这个 `PowerRemoteDesktop` 建立在强大的 `PowerShell` 以上，功能很强大。

同时它也很绿色，只要将文件拷贝到模块目录就行了，而且开源，因此还是很环保、干净和清楚的。

有兴趣的小伙伴们以后可以持续关注，同时也希望它能尽快出正式版本，在此也感谢开发者！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

