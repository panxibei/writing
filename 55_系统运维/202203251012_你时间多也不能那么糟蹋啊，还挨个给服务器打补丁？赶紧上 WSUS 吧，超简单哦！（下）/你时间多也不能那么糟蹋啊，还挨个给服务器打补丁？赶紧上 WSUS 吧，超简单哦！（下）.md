你时间多也不能那么糟蹋啊，还挨个给服务器打补丁？赶紧上 WSUS 吧，超简单哦！（下）

副标题：批量给服务器上更新，你必须用用看 WSUS ！

英文：you-cant-waste-so-much-time-and-still-patching-servers-one-by-one-hurry-up-to-try-wsus-its-very-simple-2

关键字：windows,wsus,update,upgrade,更新,补丁,patch,服务器,service pack,reportviewer,sqlsysclrtypes



书接上文，话说我给一哥们小M介绍 `WSUS` ，可给服务器批量安装更新补丁，节约时间省去不少麻烦。

但是由于篇幅所限，我们只说到了 `WSUS` 服务端的设置，接下来就让我们赶快进入 `WSUS` 客户端的设置说明吧！

> 前篇：《你时间多也不能那么糟蹋啊，还挨个给服务器打补丁？赶紧上 WSUS 吧，超简单哦！（上）》



### 客户端如何配置

更新服务器准备就绪后，我们就可以来配置客户端了。

指向更新服务器的客户端配置有几种方法可以做到，但基本原理都是一样的。

我们可以通过组策略、注册表，甚至写个批处理文件导入设置就能实现。



##### 组策略

不管是域组策略还是单机组策略都大同小异。

执行 `gpedit.msc` 打开组策略编辑器，依次找到 `计算机配置` > `管理模板` > `Windows 组件` > `Windows 更新` 。

在右侧设置窗口中找到两项，一项是 `配置自动更新` ，还有一项是 `指定 Intranet Microsoft 更新服务位置` 。

图45



我们先来看看 `配置自动更新` ，打开后选择 `已启用` ，然后在下方选项中设置自动更新方法、计划安装日期和时间即可。

自动更新方法默认为 `3` ，在此建议选择 `4` ，也就是自动下载并同时安装。

因为只有我们审批过更新才会被安装，所以不用担心自动安装会带来麻烦。

图46



接着我们再来看看 `指定 Intranet Microsoft 更新服务位置` 。

在选择 `已启用` 后，在下方选项中只要填写服务器信息即可，比如 `http://WSUSServer:8530` ，当然也可以用IP地址， `8530` 是默认更新端口也可省略。

另外，需要注意是 `http` 而不是 `https` 。

图47



##### 注册表

组策略设置挺简单的吧？

除了组策略，注册表其实也可以设置客户端指向服务器更新。

实际上通过组策略设置，同时注册表也会生成类似如下的注册表信息。

大体你可以参考如下，将 `x.x.x.x` 修改成你的 `WSUS` 服务器的域名或IP地址即可。

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"ElevateNonAdmins"=dword:00000001
"DoNotConnectToWindowsUpdateInternetLocations"=dword:00000001
"WUServer"="http://x.x.x.x:8530"
"WUStatusServer"="http://x.x.x.x:8530"
"UpdateServiceUrlAlternate"=""

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
"NoAutoRebootWithLoggedOnUsers"=dword:00000001
"DetectionFrequencyEnabled"=dword:00000001
"DetectionFrequency"=dword:00000001
"NoAutoUpdate"=dword:00000000
"AUOptions"=dword:00000004
"ScheduledInstallDay"=dword:00000000
"ScheduledInstallTime"=dword:0000000a
"UseWUServer"=dword:00000001
```



其中有几项挑出来说明一下，方便各位小伙伴们理解。

* `WUServer` 和 `WUStatusServer` ，这个不用多说，就是更新服务器。
* `NoAutoRebootWithLoggedOnUsers` ，为 `1` 时当有用户登录时更新不自动重启计算机。
* `NoAutoUpdate` ，`0` 启用自动更新，`1` 禁用自动更新。
* `AUOptions` 指的是自动更新的方法（可参考组策略），默认是 `3` ，建议 `4` 。
* `ScheduledInstallDay` 就是计划安装日期，默认是 `0` 每天都更新，`1` 到 `7` 对应周日到周六。
* `ScheduledInstallTime` 是计划安装时间，数字直接对应从一天的 `0` 点到 `23` 点。
* `UseWUServer` 设置为 `1` 表示使用更新服务器而不是官方的更新服务。



##### 批处理

有了注册表项，我们还可以编写批处理程序来给客户端批量设置更新服务器。

此处仅举个例子，其他项目可自行补充。

```
: 添加 WUServer
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v WUServer /t REG_SZ /d http://x.x.x.x:8530 /f

: 添加 WUStatusServer
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v WUStatusServer /t REG_SZ /d http://x.x.x.x:8530 /f

: 设置使用自建的更新服务器
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v UseWUServer /t REG_DWORD /d 1 /f
```



##### 确认客户端是否连接到更新服务器

在确认客户端是否成功连接之前，我们必须先确保服务器的更新服务是否可以通过防火墙正常访问。

那么我们至少需要开放更新服务所用到的 `TCP` 协议的 `8530` 和 `8531` 两个端口。

图48

图49

图50



我们如何让客户端连接更新服务器呢？

很简单，打开客户端的 `Windows` 更新设置界面，点击 `检查更新` 。

图51



之后过了一会儿，检查更新完成，似乎没有什么大的变化，也没有新的更新出现。

图52



其实不用着急，我们回到更新服务器那边再看看，OK的话我们就可以在所有计算机中找到刚才的客户端计算机。

当然，查询状态你可能需要改成 `任何` ，然后再点刷新。

图53



我们注意到，刚刚添加进来的客户端计算机前面有个感叹号，这表示客户端还没有完成更新，状态暂时异常。

这个状态异常并不是十分要紧，它只是在检查客户端计算机有没有正确安装了应该安装的更新。

经过一段时间的检查，最后它会在下方的信息栏内显示已安装和未安装更新的详细信息。

一旦出现需要的更新，那么客户端就会在计划内安装这些更新。

图54



既然客户端已经连接过来了，那接下来是不是客户端就直接可以更新了呢？

并不是，我们还需要再做些工作，分三步走！



**第一步，将客户端移动到指定的计算机组中。**

这样有利于我们分门别类地管理不同更新需求的客户端计算机。

图55

图56



**第二步，审批更新。**

右键点击需要安装到客户端的更新（可多选），然后点击 `审批(A)...` 。

图57



在审批更新界面中，点选相应的计算机组，然后点击 `已审批进行安装(I)` ，最后确定退出。

图58

图59



我们回到客户端所在的计算机组再次查看，就可以看到有我们刚刚审批通过的更新。

图60



**第三步，客户端更新。**

我们可以直接去客户端手动点击那个检查更新，也可以暂时不管等它自动启动检查更新。

作为测试，我们在这里就手动更新以方便演示。

如果有适合的更新，那么客户端就会从更新服务器上直接下载并安装了。

图61



### 安装信息查看组件

当我们想要查看客户端具体需要安装哪些更新时，可以点击下方状态信息栏中的项目。

不过如果是第一次这样操作，系统会提示我们还需要安装报表查看组件。

图62



这个被称为 `Microsoft Report Viewer 2012` 的组件需要有两个安装程序。

* `ReportViewer`
* `SQLSysClrTypes(64/32)`



我给小伙伴们找好了，都放在这儿，大家就近下载吧，省得再到处找了。



**ReportViewer.msi.7z(5.88M)**

下载链接：https://pan.baidu.com/s/16kmZT2buQfhCV8RE3h2P7g

提取码：oy06



**SQLSysClrTypes64.msi.7z(1.18M)**

下载链接：https://pan.baidu.com/s/1PH01zoekHlImhVv2ZrcDnQ

提取码：86qm



**SQLSysClrTypes32.msi.7z(1.04M)**

下载链接：https://pan.baidu.com/s/1Ohp7JOfmunui1N7Y6d4cQg

提取码：f2zl



以上程序注意是有安装顺序的，应该先安装 `SQLSysClrTypes` 再安装 `ReportViewer` 。

否则会警告缺少组件而无法安装（我就是来帮忙的，没想到还要有人来帮我一把啊！）

图63



具体的安装过程很简单，就是N个下一步，我就不在这儿啰嗦了。

组件安装完毕后，需要重启更新服务器的控制台来加载组件。

通过报告我们可以很清楚地了解到客户端计算机需要安装哪些具体的更新，以便我们可以针对性选择审批适合的更新补丁。

图64

图65



### 其他设置

由于可能需要审批的更新数量众多，因此我们可以使用 `选项` 中的 `自动审批` 来实现自动化。

另外我们还可以设置 `电子邮件通知` ，在经过同步后如果有新的更新需要我们发布就可以第一时间通知到我们。

还有其他一些辅助性的设置，都比较简单，就不在此赘述了。



至于 `SSL` 加密，实际上它只能用来保护元数据而非更新文件的加密传输，此外也会增加 10% 左右的传输损耗，因此没有十分必要的情况下也无需设置它。

当然，最近（2022年4月）微软官宣正式开启支持以 `HTTPS` 的方式访问 `Windows Update Catalog` ，不知道接下来官方是否会对 `WSUS` 相关的使用方式做出调整。



### 写在最后

由于 `WSUS` 并不一定需要域环境支持，因此创建起来并不需要太复杂的条件，还是很简单方便的。

在拥有大量需要安装更新补丁的计算机时，我们完全可以考虑建立一个 `WSUS` 服务，这样可以大大减轻我们的工作量，不仅效率和安全系数提高了，而且安装质量也有了最大的保证。

我们提高了工作效率节省了大量的时间，就可以做更多有益的事情，当然这些事情并应该不包括996类的事情。

可当我和小M开玩笑地说，现在有空了，除了一起钓鱼嗨皮，你也该找个女朋友了吧？

小M一脸惆怅向天仰望，直言现在很多“同学”都被“毕业”了，可谓是躲得了996，躲不过“毕业”啊，哪儿还敢找女朋友！

我一时语塞，顿时说不出话来......



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc





















