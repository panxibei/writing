备份软件 Symantec Backup Exec 的安装及运用（二）

副标题：做个备份演示，看看有没有坑~









### 设定一个备份







### 安装评估和部署工具包

Windows 评估和部署工具包（ADK）在一般情况下用得不多，主要是用作自定义大规模部署映像或测试系统等等场景之用。

为什么现在要提及这个东东呢，因为在下一节关于恢复备份而需要创建恢复磁盘时非常有用。



官方文档链接：https://docs.microsoft.com/zh-cn/windows-hardware/get-started/adk-install

其中可以下载到最新版本的 Windows ADK 。

我们用的是 Windows 2016 ，可是打开链接页面，其中只有 Windows 10、8、7 之类的版本，并没有 2016 啊？

其实直接套用 Windows 10 的就行了，在这里我们选择 Windows 10 版本 2004 的 ADK 。

安装包下载链接：https://go.microsoft.com/fwlink/?linkid=2120254

将链接文件下载后得到 `adksetup.exe` 文件。



执行这个文件开始下载安装评估和部署工具包。

摆在我们面前的只有两条路，一条是边安装边下载，另一条是一口气全部下载下来以后安装。

为了方便分享给小伙伴们使用，我毫不犹豫地选择了第二条路--完整下载。

图？



此处作为测试，我选择了不发送数据。

图？



我是从官网直接下载的，完整文件大小1.15G左右，如果你连不上微软的官网或赚速度慢，可以用这儿的国内备用下载链接。

ADK备用下载链接：https://

提取码：





将完整安装包复制到备份服务器上，解压缩后执行 `adksetup.exe` 。

图？



选择默认的设定，直接安装即可。

图？

图？



由于我们使用的是完整安装包，安装非常快速，一会儿就设定了。

图？

图？



建议重启一下服务器。







### 创建 Simplified Disaster Recovery 磁盘

左上角 `Backup Exec` 按钮 > `配置和设置` > `创建灾难恢复磁盘`

也可以直接运行 `C:\Program Files\Veritas\Backup Exec\sdr\DRPrepWizard.exe` 。

图？









### 





