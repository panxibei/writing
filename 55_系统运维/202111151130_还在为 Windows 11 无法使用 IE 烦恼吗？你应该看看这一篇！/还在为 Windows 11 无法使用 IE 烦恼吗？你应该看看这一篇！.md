还在为 Windows 11 无法使用 IE 烦恼吗？你应该看看这一篇！

副标题：

英文：

关键字：



Windows 11 无法使用 IE 甭着急，你看完这篇文章你也能搞定！





系统环境

`Windows 11 企业版 21H2 22000.258`

此版本是我在 `ITellYou` 上下载的，原版镜像，干净可靠。



替换文件

网上流传的替换文件大法，即将 `Win11` 中的 `ieframe.dll` 文件依次替换成旧版。

经过我测试，的确有效，方法如下。

需要替换的 `ieframe.dll` 文件一共两处，分别为以下路径。

```
C:\Windows\System32\ieframe.dll
C:\Windows\SysWOW64\ieframe.dll
```



很显然，这两个路径中的前者针对64位IE，而后者针对的就是32位IE。

那么在这里我仅演示一下前者64位路径中的 `ieframe.dll` 的替换方法。



下载 `ieframe.dll` 打包文件（含32位和64位共两个文件）。

下载链接：



由于系统权限问题，我们无法直接将原来的 `ieframe.dll` 文件删除、覆盖或重命名。

因此我们需要先将文件权限改一改，以便我们将替换文件放到合适的位置。

右键点击 `ieframe.dll` ，选择属性。

在弹出的属性窗口中选择 `安全` 选项卡，并点击 `高级(V)` 按钮。

图b01



在高级安全设置中，我们点击上方所有者一项的 `更改(C)` 。

图b02



然后输入 `Administrators` 组并确定。

图b03



此时我们再看所有者一项，已经变更为默认管理员 `Administrators` 组了，别忘记确定。

图b04



所有者变更确认后，我们先不要急着退出，可以再点击 `编辑(E)...` 按钮。

图b05



我们在 `组或用户名` 内容栏内选中 `Administrators` 所在行，然后在下方 `Administrators 的权限(P)` 选项栏中将完全控制勾选上。

图b06



最后点击确定直至完全退出设置，这样 `ieframe.dll` 的权限就完全转交到 `Administrators` 手上了，我们就可以对其任意操作了。

比如我们可以这样。

```
; 将原来的 ieframe.dll 重命名为 ieframe.dll.bak
rename ieframe.dll ieframe.dll.bak

; 再将我们准备好的旧版 ieframe.dll 复制到 C:\Windows\System32
copy ieframe.dll C:\Windows\System32
```



好了，别忘记还有32位的 `ieframe.dll` 也像上面如法炮制，将 `C:\Windows\SysWOW64` 文件夹中的也替换掉。

OK，打完收工！

这时你再找到 `Internet Explorer` 后尝试打开，就会看到 `IE11` 已经起死回生，完全活过来了！

可喜可贺，可喜可贺啊！

通常我们可以说，到此为止皆大欢喜，不过嘛，如果还想完美一些呢，最好能在桌面上放上个 `IE` 图标就再好不过了！



桌面生成 `IE` 图标

起初我以为修复桌面的 `IE` 图标应该不是什么难事，可是被折磨了许久后我终于明白了，事上无难事只怕有心人，没心的早挂了。

经过我的痛苦折腾，最终总结如下，只需要将文本内容保存为 `reg` 后缀文件，并双击导入这个文件即可重新在桌面上创建 `IE` 图标。

```
Windows Registry Editor Version 5.00

; ==========================================
; 修复 Windows 11 无法正常打开 IE11 的问题
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



文件其中各行代码的含义是啥我就不在这儿啰嗦了，好用就行，就分享给有余力的小伙伴们参考吧。



经过前面各个步骤的实践，我相信小伙伴们应该都掌握了其中的原理。

但是话说回来，这什么权限改来改去挺麻烦的，还要手动导入注册表，能不能干脆给出个一键啥都干完的小工具啊？

呵呵，我的确低估了部分人的懒惰程度，但是哈，话也说得不错，事情到了这步也完全可以直接工具搞定啊，时间就是生命，小伙伴们是给我机会挽救你们的生命啊！

这责任还是真够重大的，所以嘛，最后我只好祭出一键修复IE的小工具了。



下载链接：



小工具原理不用多说，而且其中不掺杂任何广告（俺自己的除外），所以请小伙伴们放心食用。

有图有真相，目前在 `21H2 22000.258` 版本上测试通过。

图a01



写在最后





