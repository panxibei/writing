用 VB6/VBA 将文件批量上传到 Sharepoint

副标题：用 VB6/VBA 将文件批量上传到 Sharepoint

英文：batch-upload-files-to-sharepoint-using-vb6-or-vba

关键字：vb,vb6,sharepoint,上传



随着巨硬 `Office365` 的大量普及使用，将文件上传到 `Sharepoint` 成了众多职场人的日常操作之一。

每天产生的大量信息都需要我们及时地上传更新或修改，对此我们早已习以为常。

然而就这一很普通的上传操作，为啥我们还要专门拿出来说事呢？

因为看似简单的操作，有时会遇到一些令人头痛的特殊情况。



比如，需要上传的文件很多，人力上传肯定是费时费力。

又比如，有些文件是系统产生的，需要系统自动上传而非人为。

总之存在着这样一种规律，越是重复性的工作，越可能会被自动化所替代。

如果你拒绝自动化，那么将来 `AI` 也会推着你往向走，到时就逼得你不得不自动化。



我们暂且先不谈 `AI` 的残酷未来，我们就在这儿简单讨论一下，就目前情况我们怎么把眼前这个上传问题给它自动化处理一下。

解决的方法肯定很多，不过有的小伙伴提出能否用 `VB6/VBA` 来实现。

我听完一皱眉，可以是可以，不过……



上传文件这事吧，肯定要用到 `http` 方面的知识啊，用 `VB6` 来实现 `http` 请求，听上去是不是像在开玩笑一样哈！

放着大把的工具不用，用 `VB6` 来做这事儿，这靠谱吗？

其实这也不算奇葩，毕竟 `VB` 也是一门高级编程语言，只要懂得原理，理论上它也是可以做到的。

总之就是用 `VB` 来实现网络编程。

好吧，试试就试试！



要做到给 `VB` 插上能翱翔网络的翅膀，我们需要一样东西，就是 `XMLHTTP` 库。

其实这个库一点儿也不新，它是个老家伙，和 `VB` 同时代的，你想想 `VB` 是什么年纪的。

说实话，对于这块的了解我也是一片空白，干脆我就折腾一下吧。

没想到一折腾，这才发现，这个 `XMLHTTP` 库的引用就有好几样。

```
Set Req = New XMLHTTP
Set Req = New XMLHTTP60
Set Req = CreateObject("Microsoft.XMLHTTP")
Set Req = CreateObject("MSXML2.XMLHTTP")
Set Req = CreateObject("MSXML2.ServerXMLHTTP")
```



这些都是啥乱七八糟的？

其实它们是有区别的（我当然知道），通常是版本新旧的区别，在我的电脑上只能最新的 `XMLHTTP60` 。

还有的区别就是是否支持 `SSL` 等高级功能。

具体它们的定义是啥，具体又有其他什么区别，碍于篇幅请有兴趣的小伙伴自行移驾网上查询相关资料。

简而言之，如果你只是做简单的 `Get` 和 `Post` 请求测试，那么用 `Microsoft.XMLHTTP` 就够了。

但是我要实现的功能很明显要复杂得多，最后测试得出的结果，我发现 `MSXML2.ServerXMLHTTP` 比较好使。



在此以我粗浅的网络知识，插播一点关于 `Get` 请求和 `Post` 请求的说明。

通常这两种请求用到的最多，我们可以简单地理解为，`Get` 就是获取数据，`Post` 就是传递数据。

两者都可以获取返回的数据，但这并不是后者 `Post` 请求的主要目的。

详细科普还是要请小伙伴们上网学习，我就不在这儿班门弄斧了，这只做为网络基础知识，方便能看懂接下来的内容。



`Get` 请求演示，我们自己就可以做。

新建一个 `Get` 请求页面，我这用的是 `PHP` 写的，当然你也可以用其他的。

文件命名为 `http_get.php` ，以下为部分代码，完整代码（含中文支持等）文末统一打包下载。

```php+HTML
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta charset="UTF-8">
</head>
<body>
<p>GET示例</p>
欢迎 <?php echo $_GET["myname"]; ?>!<br>
你的年龄是 <?php echo $_GET["myage"]; ?>  岁。
</body>
</html>
```



将文件 `http_get.php` 上传到 `Web` 服务器目录中，获取远程访问路径，比如：

```
https://127.0.0.1/vbhttp/http_get.php
```



如果你直接访问它，页面不会有任何显示（空白），那是因为我们没有传递任何参数给它。

如果想传点参数，那么我们就可以这样。

```
https://127.0.0.1/vbhttp/http_get.php?myname="网管小贾"&myage="100"
```



通常是在网址后加个问号 `?` ，后面就是一个一个的参数，用 `参数=值` 并以 `&` 做分隔的形式连接。

这时我们就可以在网页中看到参数显示出来了。



要做出相同的事情，用 `VB` 也可以，下面就是 `Get` 请求代码。

```vb
Set oHttpReq = CreateObject("MSXML2.ServerXMLHTTP")

strUrl = "https://127.0.0.1/vbhttp/http_get.php"
strData = "user=admin?password=123"
isAsync = False
index = 1

' 打开连接并构建连接到服务器的请求
oHttpReq.Open "GET", strUrl & "?" & strData, isAsync

' 发送请求到服务器
oHttpReq.send

' 轮循等待响应
Do Until oHttpReq.ReadyState = 4
	DoEvents
Loop

' 按不同方式获取返回响应的内容
Select Case Index
    Case 1: WebRequestGet = oHttpReq.responseText  '返回字符串
    Case 2: WebRequestGet = oHttpReq.responseBody '返回二进制
    Case 3: WebRequestGet = BytesToStr(oHttpReq.responseBody) '二进制转字符串[直接返回字串出现乱码时尝试]
    Case Else: WebRequestGet = vbNullString '无效的返回
End Select

Set oHttpReq = Nothing
```





`Get` 请求很简单，那么 `POST` 请求呢？

和 `GET` 请求不同的是，我们需要新建两个文件来做到 `POST` 请求。

一个是提交文件，另一个是接受响应文件。



提交文件 `http_post_sumbit.html` ：

```
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta charset="utf-8">
</head>
<body>
    <form action="http_post_result.php" method="post">
        名字: <input type="text" name="myname">
        年龄: <input type="text" name="myage">
        <input type="submit" value="提交">
    </form>
</body>
</html>
```



接收文件 `http_post_result.php` ：

```php+HTML
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta charset="UTF-8">
</head>
<body>
    <p>POST示例</p>
    欢迎 <?php echo $_POST["myname"]; ?>!<br>
    你的年龄是 <?php echo $_POST["myage"]; ?>  岁。
</body>
</html>
```



 为什么不能直接用链接参数的方式提交呢？

因为那样的方式浏览器默认是 `Get` 请求而非 `POST` 请求，因此我们需要一个提交文件来实现 `POST` 这个动作。

两个演示文件可在文末下载，小伙伴们可以自行测试。



那么 `VB` 怎么做到 `POST` 请求呢？

部分 `POST` 请求示例代码如下。

```
Set oHttpReq = CreateObject("MSXML2.ServerXMLHTTP")

strUrl = "https://127.0.0.1/vbhttp/http_post.php"
strData = "user=admin?password=123"
isAsync = False
index = 1

' 打开连接并构建连接到服务器的请求
oHttpReq.Open "POST", strUrl & "?" & strData, isAsync

' 请求头，有特殊情况可再添加
oHttpReq.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"

' 发送请求到服务器
oHttpReq.send strData

' 轮循等待响应
Do Until oHttpReq.ReadyState = 4
	DoEvents
Loop

' 按不同方式获取返回响应的内容
Select Case Index
    Case 1: WebRequestPost = oHttpReq.responseText  '返回字符串
    Case 2: WebRequestPost = oHttpReq.responseBody '返回二进制
    Case 3: WebRequestPost = BytesToStr(oHttpReq.responseBody) '二进制转字符串[直接返回字串出现乱码时尝试]
    Case Else: WebRequestPost = vbNullString '无效的返回
End Select

Set oHttpReq = Nothing
```



OK，不论是 `Get` 还是 `Post` ，测试都搞定了！

当我满心欢喜，以为已经掌握了访问 `Sharepoint` 的关键钥匙，于是直接兴冲冲的就拿着这些粗鄙简陋的知识去尝试了。

结果可想而知，不仅脸被打肿了，而且脸上还有五个手指印。

为什么会这样？

原因有以下这么几个方面，当然这些也是用 `VB` 没那么容易访问 `Sharepoint` 的关键知识点。

感兴趣的小伙伴现在可以拿起你的小笔记了。



首先，也是一开始被我忽略却又最头痛的问题，就是登录认证的问题。

要想操作 `Sharepoint` 文档，就算你拿着帐号密码也得先登录，要不就没有权限进行操作。

就是这个登录认证的实现着实让我伤透了脑筋，因为微软的登录会跳转N次页面，并且还是加密的，并且每次网址不定，并且用 `VB` 实现起来非常困难，至少我水平有限做不到。

你会发现，你无法直接对网址做更多的操作，因为它允许你的操作真的被限制到了最小。

图01



最后我用了一个变相的办法实现了登录。

具体我就不献丑了，可以参考文末下载中的源代码。



好不容易出现了选择帐号的画面。

图02



终于可以输入帐号和密码了。

图03



好了，登录成功了，那是不是万事大吉了呢？

很显然不是！

它是地主家的傻儿子，整个一脸盲，连我这么一帅哥它都认不出来。

每回都是刚想登门，它答应的好好的，却在我刚迈腿进门时把门又给关上了！

可气死我了，问题究竟出在哪里呢？



因为 `http` 请求是发一次算一个会话，你发一次就得到返回一次的结果，想得到多次结果就得多发送几次，每次都是全新的开始。

很显然登录时已经用掉了一次（或多次），接下来再发送的话，呃，它还是要让你登录！

你说糟糕不，其实关于这个问题我们就必须要让 `Cookie` 酱登场了！



`Cookie` 又名小甜饼，网络上有不少它的介绍资料，我就不啰嗦了，简单地说它就是用来存放用户登录或其他一些用于验证的信息用的。

所以问题就很清楚了，我们需要将前面认证通过的信息以 `Cookie` 的形式给拿到手，然后再用手里的这个 `Cookie` 进门就不会吃闭门羹了。

那 `Cookie` 上哪儿去拿呀？

说是简单，只要认证通过，服务端会返回给我们的。



如下图右侧，有了它我们就可以继续后续的操作了。

图04



当然如果出现浏览器问题，那么这里需要说明一下。

由于时间长久，到目前为止 `IE` 已经是彻彻底底玩不转了。

可能有的小伙伴会发现这种方法会比较麻烦，好像部分系统行不通了，不过部分旧版的Win10还是可以用的。

图05



好，两个问题解决了，接下来就可以上传文件了，这也是程序的核心功能。

大概原理是将上传文件以二进制打开方式上传到 `Sharepoint` 。

里面也有几个坑，其中一个是中文乱码问题，当然我这边是解决了，有点麻烦。

另外不要忘记在上传提交时带上 `Cookie` ，否则会失败。



最后 `VBA` 也实现了上传 `Sharepoint` 的功能，并且由于 `Excel` 可以自动登录认证，省去了这部分的麻烦。

图06



本来打算分两篇来介绍本文内容的，不过最近实在时间精力有限，于是考虑再三最终还是整合在了一起。

最后部分收尾也显得有些仓促，还请小伙伴们见谅！

如有什么问题欢迎关注我讨论交流哈！



源码及示例打包下载（包含 `VB/VBA` 程序）：

* 用于测试 `HTTP` 请求的示例网页文件
  * `http_get.php`
  * `http_post_result.php`
  * `http_post_sumbit.html`

* `XJVBHttp.exe`（可执行程序）
* `XJVBHttp` 文件上传 `Sharepoint` 源代码.7z
* `Upload4Sharepoint.xlsm` （ `VBA` 源代码）



**网管小贾的Sharepoint上传文件程序（含示例及VB和VBA源码）.7z(86K)**

下载链接：https://pan.baidu.com/s/17ToqfgXys6O0d001jss_7Q

提取码：ikqb







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc

