SMTP

副标题：

英文：

关键字：







将文字转换成 `Base64` 编码字符串，可以使用在线网站。

```
https://www.base64encode.org/
```



如果你不放心，怕文字内容泄露隐私，那么我们还可以在自己的电脑上使用 `PowerShell` 命令。

```powershell
[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("想要转换的文字内容"))
```







### 使用 `PLAIN` 方式登录

这种方式必须要将用户名和密码放在一起生成一行 `Base64` 编码字符串。

为了有效区分写在一行中的用户名和密码，在生成编码之前必须要用分隔符将用户名和密码划分开来。

通过以下形式，使用 `Null` 字符（ `ASCII` 为 `0` ）来划分。

```
<NULL>用户名<NULL>密码
```



由于 `ASCII` 为 `0` 是空字符，也就是说，它不像英文数字那样是不可显示字符，你直接是无法输入的，因此一般情况下需要我们用转义符号来代替。

不同的编程语言定义的转换符不尽相同，在 `PowerShell` 中 `NULL` 可以用 ``0` 来表示，就是反撇符号（键盘上数字 `1` 左边那个）外加一个零。

于是我们就可以用 `PowerShell` 来生成 `PLAIN` 登录认证用的 `Base64` 编码字符串了。

```powershell
[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("`0用户名`0密码"))
```

得到的字符串应该是这样的。

```
AOeUqOaIt+WQjQDlr4bnoIE=
```

图a02



当然这是个例子，你需要自行将 `用户名` 和 `密码` 这几个字改成你正在使用的文字。

另外多说一句，网上有网友说 `NULL` 字符不可显示无法在 `Telnet` 上使用，其实这是并不科学。

实际上我们也看到了，编码成 `Base64` 字符串后完全可以直接在 `Telnet` 上使用，并没有什么影响，我后面有成功登录的截图为证哦！



登录地具体做法有两种。

一种是先输入 `auth login` 再输入前面生成的 `Base64` 编码字符串，这需要输入两行。

```
客户端: AUTH PLAIN
服务端: 334
客户端: AOeUqOaIt+WQjQDlr4bnoIE=
服务端: 235 2.7.0 Authentication successful
```



另一种干脆放在一行输入，即 `auth login` 后直接加上 `Base64` 编码字符串。

```
客户端: AUTH LOGIN AOeUqOaIt+WQjQDlr4bnoIE=
服务端: 235 2.7.0 Authentication successful
```





使用 `PLAIN` 方式登录成功。

图a01



### `LOGIN` 方式登录

这种方式最为常用，使用起来也很清晰明了。

首先，将登录的用户名和密码分别编码成 `Base64` 字符串备用。

其次，登录时输入 `auth login` 命令。

最后，依次输入第一步中用户名和密码的 `Base64` 字符串即可完成登录。



```
客户端: AUTH LOGIN
服务端: 334 VXNlcm5hbWU6
客户端: 55So5oi35ZCN
服务端: 334 UGFzc3dvcmQ6
客户端: 5a+G56CB
服务端: 235 2.7.0 Authentication successful
```

其中 `55So5oi35ZCN` 为 `Base64` 编码的用户名，`5a+G56CB` 为 `Base64` 编码的密码。

图a03





### `TLS` 连接



```
openssl.exe s_client -starttls smtp -connect smtp.163.com:25
```

图b01



