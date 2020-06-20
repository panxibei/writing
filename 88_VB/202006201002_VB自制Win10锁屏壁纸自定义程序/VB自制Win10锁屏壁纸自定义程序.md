VB自制Win10锁屏壁纸自定义程序

副标题：一个用于操作注册表的VB类的演示



在遥远的德克萨斯星球上，当德克萨斯人还在使用 `Win7` 系统时，就已经有人DIY了各种各样丰富多彩的登录界面背景。

> 参考前文：[《教你修改Win7系统的登录界面背景》](https://www.sysadm.cc/index.php/xitongyunwei/33-win7logon)

可是，当星球上的人们开始使用更新的系统 `Win10` 时，他们发现DIY登录界面似乎变得有些复杂了，似乎还多出来一个锁屏界面的概念。

在这颗富有生命力的星球上，对于这些聪明、机智、勇敢的人们来说，这都不是事儿！

他们擅长使用古老的编程语言VB，通过巧妙的方法就能够实现自由定制锁屏界面。

为此他们还专门开发了一个配置程序，分享给了其他星球的人们使用。

图1

图2



他们是怎么做到的呢？

好奇心驱使俺向他们询问解决的方法。

他们热情奔放，坦诚其实原理很简单，通过**新建或修改注册表项**就可以实现定制锁屏壁纸。

俺听后如获至宝，立刻用笔记下，由于听不太懂他们的语言，所以只总结了几个简单、直接、有效的注册表项修改方法。



**1、强制系统使用自定义锁屏壁纸**

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization]
"LockScreenImage"="c:\\yourfolder\\LockScreenImage.jpg"
```



**2、登录背景毛玻璃特效（1903之后）**

```
# 0 为默认启用，1 为禁用
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableAcrylicBackgroundOnLogon"=dword:00000000
```



**3、隐藏 `在登录屏幕上显示锁屏界面背景图片` （可选项）**

```
# 0 为默认显示，1 为隐藏
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableLogonBackgroundImage"=dword:00000000
```



他们告诉俺，以上这些修改注册表的方法，可以手动直接修改，也可以保存为 `*.reg` 文件后双击导入注册表中，之后即可定制你想要的锁屏壁纸。

当然了，他们耸了耸肩膀，建议我直接使用配置程序来达到目的，因为那才是最高效简便靠谱的方式。

太好了，虽然俺们村刚通网，但俺还是决心试一试，于是向他们要了下载链接。



程序安装包下载：

链接：https://o8.cn/V4Ctu4 密码：bg0w



程序源码下载链接：

链接：



如果你尝试成功了，别忘记关注俺的微信公众号哦！

虽然俺们村刚通网吧，但那是唯一联系德克萨斯星球的方式，嗯，下次再找找他们，看看还有什么好玩的玩意儿。



> WeChat @网管小贾
>
> Blog @www.sysadm.cc



