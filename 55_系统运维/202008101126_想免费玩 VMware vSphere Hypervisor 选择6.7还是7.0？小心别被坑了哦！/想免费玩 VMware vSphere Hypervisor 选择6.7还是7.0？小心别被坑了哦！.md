想免费玩 VMware vSphere Hypervisor 选择6.7还是7.0？小心别被坑了哦！

副标题：论我是如何被坑的~



如今虚拟机技术已经不是什么新鲜玩意了，并且像VMware这样的杰出代表官方也提供免费试用版本给用户下载测试尝鲜。

这不手上有一台闲置的联想台式机，于是就想安装个免费版的 `VMware vSphere Hypervisor` 玩玩。

谁承想居然被坑了一把~

事情是这个样子滴......



记得上一次，我使用的还是6.0版本的程序，现在最新版是7.0，先找到它下载吧。

我以前就注册过帐号，经过登录、搜索很顺利地就找到了7.0下载的地方。

图1



看得出有两个可以下载的链接，第一个是ISO镜像文件，第二个是离线打包文件，那么选择哪一个呢？

记得以前是用ISO文件刻录成光盘，然后再使用光盘安装的，于是就选择了第一个链接来下载。

300多M很快就下载完成了，刻光盘什么的都没问题，然后拿去安装，才发现走不下去了。

图2



上面的鸟语翻译成人话，就是说它没有找到物理网卡，反正没有网卡就是不能继续安装了。

我先是一愣，马上就气得想骂人，WHAT FU*C！

好吧，我是知道的，之前也曾经在台式机上安装过6.0版本的 `ESXi` ，也发生过这样的问题。

原因很简单，`ESXi` 只识别服务器设备上的网卡，普通台式机的网卡它看不上。

我一查，果然这台式机的网卡是块螃蟹卡，型号是 `RTL8111/RTL8168/8411`。

OK！OK！Easy！Easy！

你看，气得我直说鸟语！

我依稀记得可以通过某种工具软件把螃蟹卡的驱动导入到光盘镜像中，然后就可以顺利安装了。

于是我就开始翻找以前的旧资料。



---



终于我找到了解决方法以及一个神奇的网站。

方法很简单，只需把网卡的驱动导入到安装盘中即可。

要实现这个访求，需要以下三样东东。

1. VMware vSphere Hypervisor 的 Bundle程序包
2. 螃蟹卡的VIB驱动程序
3. 用于导入驱动程序的脚本工具



##### 1、第一个获取Bundle程序包很简单，直接下载它就是了。

图3



##### 2、第二个和第三个需要到一个名叫 `v-front.de` 的神奇网站上获取了。

网址：https://vibsdepot.v-front.de/wiki/index.php/List_of_currently_available_ESXi_packages

在这个网站中可以找到一个脚本工具以及螃蟹卡的最新ESXi驱动。

图4

图5



别客气，下载它们。

图6

图7



下载完成后，把它们移动到一个新文件夹中，然后以管理员身份打开 `PowerShell` ，尝试运行 `ESXi-Customizer-PS-v2.6.0.ps1` 。

结果提示错误，好像是缺少VMware的某些组件。

图8



怎么好像和以前的不太一样啊，其实这个时候我已经有些不详的预感了。

到网上找大神求助，众大神给出了方法，需要安装名为 `VMware.PowerCLI` 的依赖。

```shell
Install-Module -Name VMware.PowerCLI
```

老实巴交的我照做了，可是换来的是无尽的提示和等待。

图9

图10

图11

图12



我差点晕倒，还好最后被我发现，其实官网早就有完整程序包可供下载。

链接：https://code.vmware.com/web/tool/12.0.0/vmware-powercli

图13



下载好后，得到文件 `VMware-PowerCLI-12.0.0-15947286.zip` 。

 把压缩包中的所有文件夹解压到 `PowerShell` 的 `Modules` 目录中，比如 `C:\Program Files\WindowsPowerShell\Modules` 。

图14



配置远程执行策略为允许

```
Set-ExecutionPolicy RemoteSigned
```

图15



配置忽略证书验证

```
Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCeip $false -InvalidCertificateAction Ignore
```

图16



再次尝试运行 `ESXi-Customizer-PS-v2.6.0.ps1` ，没有错误提示了。

图17



##### 3、导入螃蟹卡的VIB驱动

在脚本当前目录下新建一个空文件夹，比如 `pkgDir` 。

然后把前面下载的 `VIB` 驱动程序放在这个空文件夹中。

执行导入命令：

```shell
.\ESXi-Customizer-PS-v2.6.0.ps1 -izip .\VMware-ESXi-7.0.0-16324942-depot.zip -pkgDir .\pkgDir
```



命令完成后，虽然生成了新我镜像文件，但似乎有警告提示。

图18



实际上这个镜像是无法成功加载Realtek网卡的，原因当然是驱动导入没有成功了。

如果用以下命令导入呢？

```
.\ESXi-Customizer-PS-v2.6.0.ps1 -v70 -load net-r8168,net-r8169,net-sky2
.\ESXi-Customizer-PS-v2.6.0.ps1 -v70 -vft -load net-r8168,net-r8169,net-sky2
```

告诉你吧，这些都没有用，不管是不是直接连接 `v-front` 官网导入生成镜像，结果都和前面的一样。



那么问题出在哪儿呢？

查看命令执行时给出的警告信息，发现 `VIB` 驱动需要两个依赖库，分别是 `vmkapi_2_2_0_0` 和 `com.vmware.driverAPI-9.2.2.0` 。

官方也给出了提示。

图19



任凭我如何艰苦卓绝地搜索，仍然是找不到安装这两个依赖的方法。

最后在一个论坛里找到了无奈的回复。

