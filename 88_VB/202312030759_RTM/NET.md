NET

副标题：

英文：

关键字：





`VB6` 开发的程序，功能OK，运行的时候一切都好好的。

然而在最后退出程序时，时常会蹦出来个提示信息，仔细一看，不是别人，正是 `程序兼容性助手` 这货！

图z01



为啥这货总是在程序退出时蹦跶出来呢？

我研究了一下，大概也许可能或许应该是程序以管理员权限运行着，因为 `VB6` 写的程序毕竟比较古老嘛，所以在最后退出时它就会露下脸、刷一下存在感。

当出现这种情况时，我们要知道程序本身并没有啥问题，也没啥兼容不兼容的，因为跑得挺好的嘛。

这时点击 `已正确安装此程序` 或直接将其关闭，一般就算解决问题了。

不过嘛，有时候它还是会跳出来告诉你，你的程序太老啦，兼容的干活，你滴明白？！

我明白你个大头鬼啊！

是可忍孰不可忍，我决定干掉这个大头鬼！



结果网上一搜，着实让我大跌眼镜！

铺天盖地的文章都写着如何关闭程序兼容性助手，还假模假式地教你怎么操作。

我丢啊！

难道要我告诉用户，在使用我写的程序前请先关闭兼容性助手？

甚至秉承顾客就是上帝的原则帮助用户一个一个的去指导？

真是滑天下之大稽啊！

不行，这么玩行不通啊！

















> Installing Visual C++ 2010 and Windows SDK for Windows 7: offline installer and installation troubleshooting
>
> https://notepad.patheticcockroach.com/1666/installing-visual-c-2010-and-windows-sdk-for-windows-7-offline-installer-and-installation-troubleshooting/
>
> So I decided to **uninstall** my Visual C++ 2010 SP1 .
>
> I ran the Windows SDK installer again and it worked fine. 
>
> It installed  the Visual C++ 2010 Redistributable Package,  which I updated then with its SP1. 
>
> All working good now, hurray ! 





