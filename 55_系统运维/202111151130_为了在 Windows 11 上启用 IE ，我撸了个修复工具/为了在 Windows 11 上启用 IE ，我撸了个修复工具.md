为了在 Windows 11 上启用 IE ，我撸了个修复工具

副标题：网管小贾的Windows11一键修复IE11工具~

英文：in-order-to-use-ie-on-windows-11-i-made-a-fix-app

关键字：windows,11,10,7,app,ie11,ie,fix,repair,修复,ie浏览器,win11



`Windows 11` 正式版已于前不久官宣发布了。

好不好用呢，我想八成的人都是冲着尝鲜去的，所以说好用的不少，说不好用的也是大有人在。

对我们来说，不管是真的好用还是真的不好用，那完全是见仁见智的个人感受，但就是有那么一个小问题不得不引起一些老用户的重视。

那就是 `IE` 浏览器的使用问题。



众所周知，`IE11` 已经被官方正式写到了生死簿上，将于2022年6月份彻底告别我们。

有的小伙伴要说了，不是之前就举行过告别仪式了吗，怎么尸体还没火化呢？

呵呵，微软也想早点火化啊，小盒子都装好了，接班的也早准备好了，可是鉴于相当一部分固执的老用户群体仍有依赖 `IE` 浏览器的情况存在，因此 `IE` 直到现在还没有完完全全地被盖上棺材板。

好了，这不正式消息来了嘛，板上就要钉钉子了，这下可真没跑了！



这可怎么办？

正当广大人民群众一筹莫展的时候，`Windows 11` 正式版的横空出世又成了屋漏偏逢连夜雨的另一个大坑。

最新发布的 `Windows 11` 已经默认禁用 `IE` 浏览器了！

当你找到了默认应用设置，想要将 `HTTP` 之类的默认应用改成 `IE` ，这时你会发现它根本不让你用 `IE` ，因为压根就没得选啊！

图01



还有，就算你按照网上某些教程所述，将 `Edge` 默认浏览器设置中的选项改了又改还是不顶用，有些选项不让改（灰色），甚至有些选项干脆和你玩消失。

图02



我们可以对照下图，这是 `Win10` 和部分测试版 `Win11` 的 `Edge` 设置。

图03



此外，你说你要出大招了，抱着最后一线希望的你直奔 `C:\Program Files\internet explorer` 文件夹，强行双击 `iexplore.exe` 后发现最终打开了个寂寞。

你以为你能正常打开 `IE` ，可偏偏打开的却是 `Edge` 这位微软爸爸偏爱有加的小儿子。

更有不幸者可能连这位小儿子都没等来，只有眼前的一闪而过，`IE` 不见了，然后就像什么事都没有发生过一样。



老是守着 `Win10` 或 `Win7` 也不是个办法呀，`Windows 11` 才是未来啊，可是今后这 `Windows 11` 还能不能愉快地和 `IE` 一起玩耍了呢？

 咳咳，甭着急哈，你认真看完本文相信你也就能搞定它一切了！

（文末提供“**网管小贾的Windows11一键修复IE11工具**”下载）



### 系统环境

`Windows 11 企业版 21H2 22000.258`

此版本是我从 `ITellYou` 上下载的，原版镜像、干净可靠。

除此版本之外，微软官网上下载的其他版本到目前为止都能正常测试通过。



### 替换文件大法

网上流传的替换文件大法，即将 `Win11` 中的 `ieframe.dll` 文件依次替换成指定的旧版文件。

经过我测试，将系统中的文件替换为网上收集的同名备用文件后的确起到了效果，方法如下。

需要替换的 `ieframe.dll` 文件一共两处，分别为以下路径。

```
C:\Windows\System32\ieframe.dll
C:\Windows\SysWOW64\ieframe.dll
```



显而易见，这两个路径中的前者针对 `64` 位 `IE` ，而后者针对的就是 `32` 位 `IE`。

那么在这里我仅演示一下前者 `64` 位路径中的 `ieframe.dll` 的替换方法。



下载 `ieframe.dll` 打包文件（含32位和64位共两个文件）。

**ieframe.dll.7z(4.85M)**

下载链接：https://pan.baidu.com/s/1Ys7TRwKzRWG1HAUBfkUpHw

提取码：vii4



由于系统权限问题，我们无法直接将原来的 `ieframe.dll` 文件删除、覆盖或重命名。

因此我们需要先将这个文件的权限改一改，这样我们就可以给备用文件腾出替换的空间，以便我们将替换文件放到同样的位置。

右键点击 `ieframe.dll` ，选择属性。

在弹出的属性窗口中选择 `安全` 选项卡，并点击 `高级(V)` 按钮。

图04



在高级安全设置中，我们点击上方所有者一项的 `更改(C)` 。

图05



然后输入 `Administrators` 组并确定。

图06



此时我们再看所有者一项，已经变更为默认管理员 `Administrators` 组了，别忘记确定。

图07



所有者变更确认后，我们先不要急着退出，可以再点击 `编辑(E)...` 按钮。

图08



我们在 `组或用户名` 内容栏内选中 `Administrators` 所在行，然后在下方 `Administrators 的权限(P)` 选项栏中将**完全控制**勾选上。

图09



最后点击确定直至完全退出设置，这样 `ieframe.dll` 的权限就完全转交到 `Administrators` 手上了，我们就可以对其任意操作了。

比如我们可以这样。

```
; 将原来的 ieframe.dll 重命名为 ieframe.dll.bak
rename ieframe.dll ieframe.dll.bak

; 再将我们准备好的旧版 ieframe.dll 复制到 C:\Windows\System32
copy ieframe.dll C:\Windows\System32\ieframe.dll
```



好了，别忘记还有 `32` 位的 `ieframe.dll` 也像上面如法炮制，将 `C:\Windows\SysWOW64` 文件夹中的也替换掉。

OK，打完收工！

这时你再找到 `Internet Explorer` 后尝试将其打开，就会看到 `IE11` 已经起死回生，完全活过来了！

恭喜、恭喜，可喜可贺啊！

通常我们可以说，到此为止皆大欢喜，不过嘛，如果还想完美一些呢，最好能在桌面上放上个 `IE` 图标那就再好不过了！



### 桌面生成 `IE` 图标

起初我以为修复桌面的 `IE` 图标应该不是什么难事，可是被折磨了许久后我终于明白了，事上无难事只怕有心人，绝大部分没心的人早就挂了。

Well，经过一番痛苦折腾，最终总结如下，只需要将以下文本内容保存为 `reg` 后缀文件，并双击导入这个文件即可重新在桌面上创建 `IE` 图标。

```
Windows Registry Editor Version 5.00

; ==========================================
; 修复 Windows 11 桌面上的 IE11 图标
; 欢迎关注“@网管小贾”的微信公众号
; 网管小贾的博客 / www.sysadm.cc
; ==========================================

; 桌面添加显示IE图标
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu]
"{871C5380-42A0-1069-A2EA-08002B30301D}"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]
"{871C5380-42A0-1069-A2EA-08002B30301D}"=-

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{871C5380-42A0-1069-A2EA-08002B30301D}]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{871C5380-42A0-1069-A2EA-08002B30301D}]

; 给IE图标修改或添加部分菜单功能
[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}]
@="Internet Explorer"
"InfoTip"="@C:\\Windows\\System32\\ieframe.dll,-881"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\DefaultIcon]
@="C:\\Windows\\System32\\ieframe.dll,-190"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\InProcServer32]
@="C:\\Windows\\System32\\ieframe.dll"
"ThreadingModel"="Apartment"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell]
@="OpenHomePage"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\OpenHomePage]
@="打开主页(&H)"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\OpenHomePage\Command]
@="\"C:\\Program Files\\Internet Explorer\\iexplore.exe\""

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Sysadm]
@="★ 网管小贾的博客 / www.sysadm.cc (&Y)"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Sysadm\Command]
@="\"C:\\Program Files\\Internet Explorer\\iexplore.exe\" https://www.sysadm.cc"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Blank]
@="打开空白页(&B)"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Blank\Command]
@="\"C:\\Program Files\\Internet Explorer\\iexplore.exe\" about:blank"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\NoAddOns]
@="在没有加载项的情况下启动(&N)"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\NoAddOns\Command]
@="\"C:\\Program Files\\Internet Explorer\\iexplore.exe\" -extoff"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Private]
@="开始 InPrivate 浏览(&I)"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Private\Command]
@="\"C:\\Program Files\\Internet Explorer\\iexplore.exe\" -private"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Open64]
@="启动 32 位 IE (&E)"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Open64\Command]
@="\"C:\\Program Files (x86)\\Internet Explorer\\iexplore.exe\""

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Properties]
@="属性(&R)"
"Position"="bottom"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\shell\Properties\command]
@="control.exe inetcpl.cpl"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\Shellex]

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\Shellex\ContextMenuHandlers]

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\Shellex\ContextMenuHandlers\ieframe]
@="{871C5380-42A0-1069-A2EA-08002B30309D}"

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\Shellex\MayChangeDefaultMenu]
@=""

[HKEY_CLASSES_ROOT\CLSID\{871C5380-42A0-1069-A2EA-08002B30301D}\ShellFolder]
@="C:\\Windows\\System32\\ieframe.dll,-190"
"HideAsDeletePerUser"=""
"Attributes"=dword:00000024
"HideFolderVerbs"=""
"WantsParseDisplayName"=""
"HideOnDesktopPerUser"=""
```



文件其中各行代码的含义是啥我就不在这儿啰嗦了，好用就行，分享给有余力的小伙伴们参考吧（其实后面有更方便的一键修复工具下载）。



经过前面各个步骤的实践，我相信小伙伴们应该都掌握了其中的原理。

但是话说回来，这什么权限改来改去挺麻烦的，还要手动导入注册表，能不能干脆给出个一键啥都干完的小工具啊？

呵呵，我的确低估了部分同学的懒惰程度，但是哈，话也说得不错，事情到了这一步也完全可以直接工具搞定啊，时间就是生命，这些小同学是在给我机会挽救他们的生命啊！

这责任还是真够重大的，虽然我可担待不起，不过嘛，作为测试工具，最后我还是要祭出这一键修复IE的小工具。



**网管小贾的Windows11一键修复IE11工具.7z(4.93M)**

下载链接：https://pan.baidu.com/s/1SmtuLev7tecxfcF08qvnJA

提取码：mmaa



小工具的原理不用多说，融合了前面介绍的内容，另外其中没有掺杂任何广告（俺自己的除外），所以请小伙伴们放心食用。

有图有真相，目前在 `21H2 22000.258` 和 `22000.194` 版本上测试通过。

图10

图11

图12

图13



### 写在最后

就在本文将近结束之时，据最新消息，微软已经封杀了在 `Windows 11` 上的关于设定第三方浏览器为默认的第三方工具软件。

瑟瑟发抖有木有？

喜欢 `Chrome` 或 `Firefox` 的小伙伴们可要小心了哦！

目前事态仍在持续发展中，不过我们不必担心，至少微软自家出的 `IE` 应该算不上第三方浏览器吧。

因此，我个人感觉有很长一段时间内，我们还是可以在 `Windows 11` 上让 `IE` 欢快地跑上一跑的。

好了，有 `Windows 11` 系统的小伙伴们还不赶快去试一试？

祝你好运！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc