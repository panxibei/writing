思科交换机无法通过HTTPS访问，肿么回事儿？

副标题：思科居然还有这BUG，想搞事情啊~



是日天朗气清，心情甚佳，忽然想查看看某台思科交换机的运行状况。

遂打开IE浏览器，输入 `https://x.x.x.x` ，一记潇洒的回车。

哎...艾玛？怎么肥事？什么情况？

图1



尝试打开 `http` ，也无法打开页面，出故障了？

对了，看看能不能 `Telnet` 上去。

发现可以连接，并且确认虽然 `http` 没有开启，但 `https` 的确是开启的啊！

图2



好吧，重新打下命令再开启看看。

我勒个去......居然报错了！

图3



自签名证书生成失败？

真是奇哉怪也~



以为可能是浏览器的问题，于是又把浏览器换成 `Firefox` 和 `Chrome` 后，发现一个很搞笑的事儿。

图4



呵呵哒，这个倒霉证书居然在2020年1月1日过期了！

好玩儿吧，难道这台交换机已经成了古董货？

上网搜搜看，没想到被我发现一些更有趣的事情。

在一个几乎无法完整打开的思科社区论坛页面中，我找到了答案，原因是证书真的过期了！



我打开了那个链接，是个思科官网链接。

官方链接：[IOS Self-Signed Certificate Expiration on Jan. 1, 2020](https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)

这个链接正是解决自签名证书关于2020年1月1日过期的问题。



链接文章从原因到解决方法讲得非常详尽，如果你有的是时间，那么你可以研究一下。

不过非常不幸，我要留点时间打游戏的。

另外，我可是要争当时间管理大师的人，所以我总结了它给出的三种解决方法。

1. Obtain a valid certificate from a 3rd part Certificate Authority (CA)

   从第三方证书颁发机构（CA）获取有效证书

2. Use the IOS CA Server to generate a new certificate

   使用IOS CA服务器生成新证书

3. Use OpenSSL to generate a new self-signed certificate

   使用OpenSSL生成新的自签名证书



我的天，哪个都不简单，哪个都是磨人的小妖精。

不好，懒癌发作，怎么办呢？

你说巧不巧，就在这思科社区论坛里，我同时还找了其中一位网友针对这个问题的这么一段回复。

>  thank you very mush. 
>
> the link take me solved the question([https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)](https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html).
>
> In my opinion,If the time can return to before January 1, 2020,the problem may be solved.
>
> so I set router time to January 1, 2019(clock set 15:00:00 Jan 1 2019) ,it is a wonder that I guess right. 



翻译成文明语言就是

> 非常感谢！
>
> 这个链接解决了我的问题。([https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)](https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)
>
> 在我看来，如果时间能回到2020年1月1日之前，问题可能会解决。
>
> 于是我把路由器时间改回2019年1月1日（时钟设置为2019年1月1日15:00:00），结果真TMD是个奇迹，被我猜对了。



一下子，我就灵光乍现，OK，立马修改了一下时间，把年份改成了2019年。

```
Switch#clock set 08:08:08 Aug 8 2019
```



再跑去打开 `https://x.x.x.x` ，居然可以正常访问了喂！

我这么文明一社会人儿，咋就突然想骂人哩？

虽然说可以使用了，但是回头一想，不对啊，时间不准会不会对系统有不良影响呢。

于是回过来又把时间改了回来，恢复成正常时间。

再打开 `https://x.x.x.x` ，您猜怎么着？

尼玛错误消失了，任我怎么刷新再也不出现了！

我都怀疑我还能不能继续做个有素质的文明社会人儿。

不对，换台电脑试试，在另一台电脑的浏览器上再次访问 `https://x.x.x.x` ，问题完全消失，就跟没有发生过问题似的！

不知道以后还会不会问题再现啊！

好了，没啥好多说了，希望小伙伴们少走弯路，我要去划水了，就到这儿吧......



> WeChat @网管小贾 | www.sysadm.cc

