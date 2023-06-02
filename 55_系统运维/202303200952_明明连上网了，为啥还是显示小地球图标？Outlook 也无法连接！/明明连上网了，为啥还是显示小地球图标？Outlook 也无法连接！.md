明明连上网了，为啥还是显示小地球图标？Outlook 也无法连接！

副标题：明明连上网了，为啥还是显示小地球图标？Outlook 也无法连接！

英文：why-still-display-small-earth-icon-even-if-it-connected-to-the-internet-and-outlook-is-also-not-connected

关键字：ncsi,小地球,无法连网,earth,network,outlook



下班高峰期的车辆挤满了每条车道，像极了一群群的甲壳虫，排着队闪着彩色的光缓慢而有序地向前挪动着。

从大楼最高处放眼望去，美丽的城市夜景尽收眼底。

可这份繁华又与我有什么关系呢？



“喂！你！过来一下！说的就是你，绿皮大青蛙！”

我怔了一下，确认的确是在叫我，只好不情愿地从栏杆上下来。



“听说你是计算机专业的，帮我修修电脑呗！放心，给你好吃的哦！”

喊我的是位小姐姐，似曾相识，对了，我以前给她送过餐，应该是这幢写字楼里的上班族。

也不知道她是从哪儿听说的，怎么就看出我是学计算机的呢？

我摘下头套，深深吸了一口新鲜空气，终于看清了小姐姐的面庞，挺漂亮的！

肚子此时发出低沉的声音，我心想要不是看在有好吃的，我才不会跟你走呢！

随后跟着小姐姐走进了她们公司的办公室。



小姐姐微笑地指着一台电脑，说是老是联不上网，特别是 `Outlook` 总掉线收发不了邮件，让我帮忙给看看。

我一瞅，系统通知栏里的网络图标变成了一个小地球的样子。

图01



一看就是网络不通嘛！

可是一番检查下来，什么 `IP` 地址啥的都没问题。

连 `Ping` 外网都是OK的，就是 `Outlook` 无法成功连接。

我仔细考虑了一会儿，告诉小姐姐，感觉应该是 `NCSI` 的问题。

小姐姐眨巴着大眼睛看着我，似乎并不明白我在说啥，于是索性拜托我后转身去忙别的事了。



先简单解释一下 `NCSI` 吧。

`NCSI` ，即 `Network Connectivity Status Indicator` 的缩写，如果直译成中文就是 `网络连接状态指示器` 。

不过就算这么翻译过来也挺让人犯懵，干脆用大白话讲，就是 `Windows` 系统用来判断电脑是否连接到 `Internet` 的一种技术手段。

说白了就是通过 `NCSI` 来判断电脑是否正常联网在线。

那这种技术具体怎么是做出判断的呢？

说穿了其实也非常简单，咱们往下看！



我们打开注册表，找到 `NCSI` 的相关设定项。

```
计算机\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet
```

图02



我们就拿注册表来说明，这样比较直观易于理解。

这些注册表项大概分为三大部分：

* `DNS` 服务
* `WEB` 服务
* 其他一些功能参数

看图就像这样。

图03



`DNS` 服务相对来说是固定的，没有特殊情况不需要修改它，我们先看看 `IPv4` 的哈。

```
131.107.255.255    dns.msftncsi.com
```

图04



`Ping` 一下这个 `DNS` ，似乎不通，但其实应该是起作用的。

图05



有时出于网络安全考虑，有些 `IP` 地址是 `Ping` 不通的，但这并不表示服务不可用。

因此，光看 `Ping` 还不行，还要接着看后面的，比如 `WEB` 服务的访问，这才是重点。

图06



默认是这样的。

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet]
"ActiveWebProbeContent"="Microsoft Connect Test"
"ActiveWebProbeContentV6"="Microsoft Connect Test"
"ActiveWebProbeHost"="www.msftconnecttest.com"
"ActiveWebProbeHostV6"="ipv6.msftconnecttest.com"
"ActiveWebProbePath"="connecttest.txt"
"ActiveWebProbePathV6"="connecttest.txt"
```



这么一坨要怎么看呢？

我们把字段尾部带 `V6` 的给忽略掉，就看成这样了。

```
"ActiveWebProbeContent"="Microsoft Connect Test"
"ActiveWebProbeHost"="www.msftconnecttest.com"
"ActiveWebProbePath"="connecttest.txt"
```



这下简化了不少，不过都是什么意思呢？

第一行，文档内容，即我们看到的文本 `Microsoft Connect Test` 。

第二行，`Web` 服务器域名，即 `www.msftconnecttest.com` 。

第三行，`Web` 服务器域名根目录有一个文本文件，即 `connecttest.txt` 。



嘿嘿，将它们三个好朋友手拉手连起来看，就是这个样子。

```
http://www.msftconnecttest.com/connecttest.txt
```



先 `Ping` 一下，是通的。

图07



再尝试直接用浏览器访问，结果就会返回以下内容：

```
Microsoft Connect Test
```



哎，这不就是注册表项 `ActiveWebProbeContent` 的内容嘛！

答对了，这回看懂了吧？很简单哦！

不过应该注意，这里用的是 `http` ，而不是 `https` 。

这回明白了，所谓 `NCSI` 通常就是通过访问这个网址链接，看看能不能打开指定的文本文件，同时对照文件内容。

如果能打开并且文本内容一致，那么说明网络连接OK。



好了，原理了解过后，那么我们就可以动手将它改造改造。

慢着，为啥还要改造？

因为默认设定的网址是国外的，速度慢啊，我们可以改个离我们近一点速度可以快一点的，对不？



OK，修改后像这样（ `ipV6` 也跟着改改）。

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet]
"ActiveWebProbeContent"="Microsoft NCSI"
"ActiveWebProbeHost"="www.msftncsi.com"
"ActiveWebProbePath"="ncsi.txt"

"ActiveWebProbeContentV6"="Microsoft NCSI"
"ActiveWebProbeHostV6"="ipv6.msftncsi.com"
"ActiveWebProbePathV6"="ncsi.txt"
```



改好后再用老方法试试能不能看到文本文件的内容。

```
http://www.msftncsi.com/ncsi.txt
```

返回结果：

```
Microsoft NCSI
```



自然也是 `Ping` 得通的。

图08



一般来说这样都没问题，如果可以访问，那么网络连接的图标就不会变成小地球了。

这里告诉你们一个小秘密，其实这几个参数完全可以更换成自己的，并非一定要用官方的哦！



没错，完全可以修改成自己的 `HTTP` 服务器上的链接即可。

比如像这样：

```
ActiveWebProbeHost=www.xxxx.com
ActiveWebProbePath=yyyy.txt
ActiveWebProbeContent=网管小贾 / sysadm.cc
```



那么照猫画虎，应该可以正常访问以下链接才算可以连接到 `Internet` 了。

```
http://www.xxxx.com/yyyy.txt
```

显示结果：

```
网管小贾 / sysadm.cc
```



修正网络显示为小地球而无法上网的问题。

我把整理好的注册表设定文件打包在此，有需要的小伙伴自行下载吧。

解压后以管理员权限双击 `.reg` 文件导入系统即可。



**NlaSvc.7z(28.7K)**

下载链接：https://pan.baidu.com/s/1qQ5gV1Kb0rW08JQ_beizAQ

提取码：08ov





官方参考链接：

> https://learn.microsoft.com/zh-cn/troubleshoot/windows-client/networking/internet-explorer-edge-open-connect-corporate-public-network#Workaround



可能有的小伙伴会遇到这样一个问题，即使导入修复了设置这小地球依然不会消失。

那么告诉你，很有可能你系统的 `NCSI` 被关掉了。

官方也郑重声明，不建议禁用 `NCSI` 探测。

```
注意

Microsoft 不建议禁用 NCSI 探测。 多个操作系统组件和应用程序依赖于 NCSI。 例如，如果 NCSI 无法正常工作，则 Microsoft Outlook 可能无法连接到邮件服务器，或者即使计算机已连接到 Internet，Windows 也可能无法下载更新。
```



终于明白了，原来有那么程序是依赖这个 `NCSI` 的啊！

怪不得 `Outlook` 怎么连都连不上呢，原因在这儿呢！



那要是不幸 `NCSI` 被禁用了，怎么再次开启它呢？

我们还是回到注册表，有另一个参数，就是用于开启查询网络活动状态的。

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet]
"EnableActiveProbing"=dword:00000001
```

图09



如果值是 `0` ，那么表示禁用 `NCSI` 活动探测，反之为 `1` 就是开启。

- ```
  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\EnableActiveProbing
  ```

  - 键类型：`DWORD`
  - 值：小数 `0/1` ( `False/True` ) 




或者还有一个设置项，也可以禁用 `NCSI` 。

- ```
  HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\NoActiveProbe
  ```

  - 键类型：`DWORD`

  - 值：小数 `1` ( `True` ) 

     备注：在默认注册表配置中，此注册表项不存在。 必须创建它。




还有一个，若要使用注册表禁用 `NCSI` 被动探测，可以创建以下注册表项。

- ```
  HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\DisablePassivePolling
  ```

  - 键类型：`DWORD`

  - 值：小数 `1` ( `True` ) 

     备注：在默认注册表配置中，此注册表项不存在。 必须创建它。




有的小伙伴习惯用组策略，也是可以做到的。

若要使用组策略禁用 `NCSI` 活动探测，请配置以下 `GPO` ：

- 计算机配置 > 管理模板 > 系统 > Internet 通信管理 > Internet 通信设置 > 关闭 Windows 网络连接状态指示器活动测试
  - 值：已启用

若要使用组策略禁用 `NCSI` 被动探测，请配置以下 `GPO` ：

- 计算机配置 > 管理模板 > 网络 > 网络连接状态指示器 > 指定被动轮询
  - 值：已启用



最后如果你嫌前面介绍的一大堆实在麻烦，那么也可以用个最简单的办法。

打开系统 `设置` ，找到 `网络和 Internet` > `状态` ，然后点击 `网络重置` 。

图10



然后点击 `立即重置` 。

图11



当然，如果有特殊的网络设置，最好在此操作之前将设置记下来。



好了，最后将 `NCSI` 开启后，再修改了相应的设置，果然不一会儿网络图标就恢复连接状态了。

我尝试了一下 `Outlook` ，没有任何悬念成功连接了，一封一封新邮件接二连三地收进了邮箱中。

“哇！邮箱好了？”小姐姐端着两份快餐走了过来。

“呐，这份给你的，放心哈，等会再发你个红包！”

看我有点愣神，她笑着说：“时间不早了，吃完了就赶紧回家吧！家里人还等着你呢！”

说完，我的眼泪夺眶而出，抑制不住地往外流……



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc