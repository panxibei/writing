思科交换机的HTTPS访问不了，肿么回事儿？

副标题：思科这个BUG有点搞事情啊~



是日，天朗气清，心情大好，遂想查看一下思科交换机的状态。

打开IE浏览器，输入 `https://x.x.x.x` ，一记潇洒的回车。

哎...哎？怎么肥事？

图1



尝试打开 `http` ，也无法打开页面。

看看能不能 `Telnet` 上去。

发现可以连接，并且确认虽然 `http` 没有开启，但 `https` 的确是开启的啊！

图2



好吧，重新打下命令开启看看。

我勒个去......居然报错了！

图3



自签名证书生成失败？

怪哉怪哉~



以为可能是浏览器的问题，于是又把浏览器换成 `Firefox` 和 `Chrome` 后，发现一个很搞笑的事儿。

图4



呵呵哒，这个倒霉证书居然在2020年1月1日过期了！

好玩儿吧，难道交换机已经成了古董货？

上网搜搜看，不料被我发现一些更有趣的事情。

在一个几乎无法完整打开的思科社区论坛中，我找到了答案，原因是证书真的过期了！

> 



我打开了上面的那个链接，这是个思科官网链接。

这个链接正是解决自签名证书于2020年1月1日过期的问题。

链接：[IOS Self-Signed Certificate Expiration on Jan. 1, 2020](https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)

里面的文章从原因到解决方法讲得非常详尽，如果你有的是时间，那么你可以研究一下。

不过我可是要争当时间管理大师的人，所以只总结了一下三种解决方法。

1. Obtain a valid certificate from a 3rd part Certificate Authority (CA)

   从第三方证书颁发机构（CA）获取有效证书

2. Workaround 2 - Use the IOS CA Server to generate a new certificate

   使用IOS CA服务器生成新证书

3. Workaround 3 - use OpenSSL to generate a new self-signed certificate

   使用OpenSSL生成新的自签名证书



我的天，都不简单，都够麻烦复杂。

懒癌发作，怎么办呢？

你说巧不巧，在思科社区论坛里，我同时还找了一位网友针对这个问题的这么一段回复。

>  thank you very mush. 
>
> the link take me solved the question([https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)](https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html).
>
> In my opinion,If the time can return to before January 1, 2020,the problem may be solved.
>
> so I set router time to January 1, 2019(clock set 15:00:00 Jan 1 2019) ,it is a wonder that I guess right. 



翻译过来就是

> 非常感谢！
>
> 这个链接解决了我的问题。([https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)](https://www.cisco.com/c/en/us/support/docs/security-vpn/public-key-infrastructure-pki/215118-ios-self-signed-certificate-expiration-o.html)
>
> 在我看来，如果时间能回到2020年1月1日之前，问题可能会解决。
>
> 于是我把路由器时间改回2019年1月1日（时钟设置为2019年1月1日15:00:00），结果真TMD是个奇迹，被我猜对了。



好的，我立马修改了一下时间。

```
Switch#clock set 08:08:08 Aug 8 2019
```



再跑去打开 `https://x.x.x.x` ，居然可以正常访问了！

我这么文明的一个社会人怎么突然就想骂人呢？

虽然可以使用了，但是回头一想，时间不对会不会对系统有所影响呢。

于是回过来又把时间改了回来，恢复成正常时间。

再打开 `https://x.x.x.x` ，错误消失了，不再现！

这算个啥？

我都怀疑我还能不能继续做个有素质的文明社会人。

换了台电脑，在浏览器上再次访问 `https://x.x.x.x` ，问题完全消失，就这样木有了！

好了，也没啥好多说了，就到这儿吧。

小伙伴们都忙去吧，我还要去读平安经呢，88......

> WeChat @网管小贾 | www.sysadm.cc

