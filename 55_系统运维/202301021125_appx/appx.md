appx

副标题：

英文：

关键字：







使用 `Windows 照片查看器` 无法正常打开图片。

图a01



打开微软应用商店，搜索关键字 `照片` ，打到 `Microsoft 照片` 。

图a02



打开 `Microsoft 照片` 应用页面后直接点击获取即可下载安装。

如果想要将它单独下载下来以备将来离线安装，那么也不是不可以。



找到分享图标。

图a03



在弹出的小页面中有很多分享方式，其中有一项 `复制链接` 。

图a04



点击这个 `复制链接` ，后面我们就可以利用这个链接去下载独立安装包了。

我这儿获取到的链接如下：

> https://www.microsoft.com/store/productId/9WZDNCRFJBH4









打开一个神秘网站。

> https://store.rg-adguard.net

这个网站是专门用来下载 `Appx` 独立安装包的。



怎么用呢？

先选择查询模式，这里我们选择 `URL(link)` 方式，也就是通过链接来查询。

然后在后面文本框内输入我们刚刚复制的应用商店链接。

好，点击后面的查询按钮（就是那个打勾的）。



稍等一会儿就可以出查询结果了。

图b01



或者换一种查询方式，前面换成 `ProductId` ，后面输入产品号（也就是链接最后那串字符，比如本例的 `9WZDNCRFJBH4` ）。

也可以得到同样的结果。

图b02



可能有眼尖的小伙伴要说了，不对啊，怎么结果里没有 `Windows 照片` 应用项啊？

别着急，往下翻翻！

图b03













安装

版本 `1809` 以上或 `21H2` 以下，可安装 `AppxBundle` 包。

```powershell
Add-AppPackage .\Microsoft.Windows.Photos_2022.30100.19004.0_neutral_~_8wekyb3d8bbwe.AppxBundle
```



版本 `22H2` 以上，可安装 `MsixBundle` 包。

```
Add-AppPackage .\Microsoft.Windows.Photos_2022.31110.21006.0_neutral_~_8wekyb3d8bbwe.Msixbundle
```



独立安装下载

