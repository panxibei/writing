Setup Factory 实现安装包安装前静默卸载

副标题：其实就是实现安装自动升级功能



大家好！我是网管小贾。

大家在使用setup factory制作安装程序时，可能会碰到更新升级的问题。

即先把之前的已安装的程序自动卸载，而后再安装新版本的程序。

大白话就是，用户直接点击安装包，程序实现自动升级安装。

之前在百度知道里已经写了些经验，现写在自己的博客里分享给大家。



**1、`Setup Factory` 删除前一版本程序的方法**

在 `Actions` 的 `On Pre Install` 中加入以下语句。

```shell
result = File.Run(SessionVar.Expand("%AppFolder%\\uninstall.exe"),  "/U:Uninstall/uninstall.xml", SessionVar.Expand("%AppFolder%"),  SW_SHOWNORMAL, true);
Application.Sleep(1000);
```



解释一下吧：

第一句，执行 `uninstall.exe` 自动卸载应用程序本身。

第二句，等待1秒以便卸载程序能完全卸载。

当然，可以根据实际情况调整，比如需要5秒卸载完成，则 `Application.Sleep(5000);`。

图1

图2



**2、在 `Uninstall` 的 `Settings` 选项卡中，设定静默卸载。**

`Options` 中 `Allow silent uninstall` 和 `Start in silent mode` 都打勾。

图3

图4



OK！试试吧！

记得代码最后别忘记分号结束。

设定好后注意保存配置文件哦。

 

**微信公众号：网管小贾**