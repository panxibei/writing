走进科学系列之遭遇鬼打墙的OUTLOOK

副标题：走进科学系列之遭遇鬼打墙的OUTLOOK

英文：approaching-science-series-outlook-cannot-open-a-link

关键字：outlook,链接,邮箱,邮件,link,共享,file,kb5002427





屏幕右下角通知栏内弹出警告提示。

图a01



经查是大概是由于 `Outlook` 的 `KB5002427` 这个更新所致，影响时间从 `2023` 年 `7` 月 `11` 日起。

以下是官方社区参考文档的链接。





> https://support.microsoft.com/zh-cn/office/outlook-%E5%9C%A8%E5%AE%89%E8%A3%85-2023-%E5%B9%B4-7-%E6%9C%88-11-%E6%97%A5%E5%8F%91%E5%B8%83%E7%9A%84-microsoft-outlook-%E5%AE%89%E5%85%A8%E5%8A%9F%E8%83%BD%E7%BB%95%E8%BF%87%E6%BC%8F%E6%B4%9E%E7%9A%84%E4%BF%9D%E6%8A%A4%E5%90%8E%E9%98%BB%E6%AD%A2%E6%89%93%E5%BC%80-fqdn-%E5%92%8C-ip-%E5%9C%B0%E5%9D%80%E8%B6%85%E9%93%BE%E6%8E%A5-4a5160b4-76d0-465b-9809-60837bbd35a8



导致这个问题的原因很简单，就是更新后安全性提升导致的链接打不开。



遇到此问题的人很多，但是官方似乎并没有在后续的更新中将这一漏洞给补上。

取而代之的是用了一个比较山寨的办法来变相规避这个问题。

这个方法就是将链接的域名或IP添加到受信任站点。



1、通过控制面板中的Internet选项手动添加受信任站点的方式。

`控制面板` > `网络和Internet` > `Internet 选项` 。

图b01

图b02



点选 `受信任的站点` ，再点击 `站点(S)` 按钮。

图b03



在 `将该网站添加到区域(D)` 下方的文本框内输入想要添加的网址或IP地址，再点击 `添加(A)` 。

网站网址只要输入域名部分就可以了，不需要把整个链接都输进去。

比如这个链接：

```
https://www.sysadm.cc/index.php/richangsuibi/909-buy-me-a-coffee-if-you-find-my-contents-helpful
```

其实只要输入前面的域名就行。

```
https://www.sysadm.cc
```



此外如果网址的前缀是 `https` 而非 `http` ，则需要勾选下面的 `对该区域中的所有站点要求服务器验证(https:)(S)` 一项。

图b04





当然输入时不仅仅是这么简单，还有很多需要注意的格式限制，特别是通配符的使用，虽然使用起来更加灵活，但也不是那么随便的。

图b05









`GPO` 组策略。

`计算机配置` > `管理模板` > `Windows 组件` > `Internet Explorer` > `Internet 控制面板` > `安全页` > `站点到区域分配列表` 。

图a03



启用，点击显示。

图a04



在其中填写。

图a05



可惜的是，组策略区域管理接口并不提供输入值的输入验证。

如果不符合输入格式，那么最终导致无效肯定是毋庸置疑的。



实际上 `GPO` 是通过修改注册表来实现管理可信任站点的。

如果对象是域名，则走的是以下注册表项 `Domains` 。

```
Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\contoso.com
```



如果对象是IP地址，则换成了另一个注册表项 `Ranges` 。

```
Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1
```



其中域名还分根域名和子域名，有兴趣的小伙伴可以研究研究。

既要区分域名和IP地址，还要区分根域名和子域名，还要区分不同的访问协议（ `http/https/*` ），总之非常麻烦繁琐。

我根据些原理尝试做了一个可以批量添加受信任站点的小程序。

图c01



使用起来非常简单，只需在左侧框内输入需要添加信任的网址或IP地址，然后点击 `[A]添加站点` 即可。

移除站点也很方便，从右侧选择想要删除的站点（可多选），再点击 `[R]移除站点` 即可。

如果格式不正确是无法成功添加的，避免了因格式错误而导致无效的尴尬。

另外在 `Internet 选项` 中也只能是单项操作（添加/删除），这款程序权当便利工具使用。

当然，程序可能还是有 `BUG` 的，不过至少再也不用繁琐地寻找 `Internet 选项` ，再一个一个地操作了。



最后说一下效果。

在将目标域名或IP地址添加到受信任站点后，我们再点击 `Outlook` 邮件中的链接，它会弹出一个警告提示。

图a02



在旧版中是直接打开链接没有警告提示，现在虽然不报错了，但还是有一个警告提示，估计也是出于安全考虑吧。

给用户一些思考的时间，只要点击 `是(Y)` 便可继续打开链接，当然点击 `否(N)` 那就当什么事都没有发生过，也就不会有什么安全风险了。







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc

