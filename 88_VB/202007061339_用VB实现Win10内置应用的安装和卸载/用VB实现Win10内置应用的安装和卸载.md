用VB实现Win10内置应用的安装和卸载

副标题：想卸就卸，想删就删，揍似辣么豪横~



前一阵村里刚通网，虽然网速用蜗牛来形容有点贬低蜗牛，不过好歹我们村也算是进入了网络时代。

赶上了网络时代，苟日新、日日新、又日新，村里家家户户也都用上了最新的Win10系统。

就说这Win10系统先进吧，自带了不少应用程序，给我等草民免去了不少上网下载安装的麻烦。

还有，快速地滚动着开始菜单中那长长的程序列表，也算是这新时代的另类炫酷方式。

不信你试试，我的程序列表滚动一圈只要半分钟！



话说有那么一回，同村的美女林妹妹跑来问我截图工具在哪儿？

这还不好找，难道对我有意思？

嘿呦，我发现我展示炫酷魅力的机会来了！

我立刻打开电脑，干净利落地点开开始菜单，同时告诉她这很容易，请她稍等片刻。

我快速滚动着程序列表，渐渐地，眼中模糊成了数不清的线条。

我感动得揉了揉眼睛，可是好一会也没找到那个该死的截图工具！

你到底在哪儿啊，我叫你一声你敢答应吗？

说好的半分钟已经过了，我的手心微微冒汗，林妹妹显得有些焦躁。

“别急哈，这个要看缘份的哈！”

林妹妹满脸疑惑，没听懂我在说什么。

还好，天赋异禀的我凭借小宇宙最强第六感终于把它给扒拉出来了。

林妹妹向我道谢，看得出她对我很上心，临走时关心地说道：“你这程序也太多了吧，删掉点没用的呗！”。

望着林妹妹离去的背影，我能强烈地感觉到我的表演秀砸了，不，是稀碎！

好吧，我决心把那些让我丢尽脸面的程序删光光！



#### 一、手动删除

点击开始菜单，点击 `设置` > `应用` ，想卸载哪个就选哪个。

图1

不过手动删除有些应用可能看不到，也就卸载不了。

另外卸载后就看不到了，也不方便再次安装。



#### 二、通过 `PowerShell` 命令卸载

Windows10 中 `PowerShell` 内置了 `Get-AppxPackage` 、 `Remove-AppxPackage` 和 `Add-AppxPackage` 命令来进行安装卸载操作。

> `Get-AppxPackage` ：用于获得 Win10 系统内置应用信息
>
> `Remove-AppxPackage` ：用于删除 Win10 系统内置应用
>
> `Add-AppxPackage` ：用于安装 Win10 系统内置应用

列举几种常见命令：

```powershell
# ******查询******
# 查询所有内置应用安装包信息
Get-AppxPackage -allusers

# ******卸载******
# 1.仅查询应用的名称和全称
Get-AppxPackage | Select Name, PackageFullName

# 2.卸载计算器应用
Get-AppxPackage Microsoft.WindowsCalculator | Remove-AppxPackage

# ******重装******
# 1.仅查询应用的名称和全称
Get-AppxPackage | Select Name, InstallLocation

# 2.重装计算器应用
# 例如：InstallLocation = C:\Program Files\WindowsApps\Microsoft.WindowsCalculator_10.1805.1201.0_x64__8wekyb3d8bbwe
Add-AppxPackage -register "InstallLocation\appxmanifest.xml" -DisableDevelopmentMode

# ******重装所有应用******
Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
```

命令行模式操作比较麻烦，不太适合新手小白。



#### 三、自制内置应用安装卸载程序

要不说网络时代真是棒，上网啥都有了。

有很多大神早已造出了各种神奇的工具软件，其中就有针对Win10内置应用卸载的程序。

这些程序有用 `Python` 做的，也有用 `C#` 做的，我嘛只会一点点 `VB` ，当然用 `VB` 做啦！

嗯，看看样子，有点丑，不过能用就行哈！

图2



使用方法很简单：

1、刷新应用列表，就是点一下按钮而已。

2、左侧列表中选择应用，再点击卸载或安装。

3、要是你觉得玩得太嗨了，删得不知道都是啥也没关系，有颗后悔药，点击 `重置所有应用` 就都可以帮你找回来哦。



其实这个程序用到了以前介绍的知识点。

[《VB+SQLite组合，真香！（一）》](https://www.sysadm.cc/index.php/vbbiancheng/721-vb-sqlite)

[《VB+SQLite组合，真香！（二）》](https://www.sysadm.cc/index.php/vbbiancheng/723-vb-sqlite-2)

首先，利用 `PowerShell` 命令读入内置应用列表，再把读取的内容写到SQLite数据库中。

其次，通过读取SQLite数据库信息来操作卸载安装命令。



放出下载链接：



如需源码，请关注我的公众号并留言给我。



突然感觉这个程序很有范的样子，推荐给林妹妹会不会好感度飙升呢？

嘿嘿！我喜上眉梢，擦了擦口水，准备明天展开行动......