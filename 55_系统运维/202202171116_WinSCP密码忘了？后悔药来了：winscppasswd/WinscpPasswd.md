WinscpPwd

副标题：

英文：

关键字：



初春乍暖还寒，心情不错的我哼着小曲走进了卫生间。

正当我吹着口哨带薪放松的时候，忽然收到老板的消息，说是服务器无法登录。

搞什么灰机？没见我正忙着呢吗？

我急忙抖动了几下，一边忿忿不平，一边小步快走，去晚了又得挨老板骂了......



回到工位，我熟练地打开 `Putty` ，输入用户名和密码，回车！

我去，还真是无法登录了！

图01



一连试了好几次都失败了，我心里有点发毛......









这个实用程序是为了让我不断忘记保存的密码而编写的。有两种第三方工具可以解密密码，但我对将密码交给从互联网下载的未知工具的想法并不太高兴。所以我决定写我自己的。


您可以在这里下载现成的二进制文件，也可以从GitHub的“发布”部分下载。但是如果你不信任二进制文件，欢迎你自己编译源代码。

这是用Go lang写的，直接到http://golang.org/下载编译器。





直接运行 `Winscppasswd.exe` 会给出提示。

> WinSCP stored password finder
> Open regedit and navigate to **[HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2\Sessions]** to get the hostname, username and encrypted password
>
> Usage winscppasswd.exe <host> <username> <encrypted_password>



打开 `WinSCP` 的选项。

图a01



`WinSCP.ini` 存储路径有三种。

* **Windows注册表**

  `HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2\Sessions`

* **自动INI文件**

   `C:\Users\<用户名>\AppData\Roaming\WinSCP.ini`

* **自定义INI文件**

  比如：`C:\Users\<用户名>\Documents\WinSCP.ini`

  

图a02



默认我们的会话是保存在注册表中，当然我们还可以按以上方式自由修改存储路径。

不过为了恢复密码，其实我们是不需要刻意修改 `WinSCP.ini` 的存储路径。

实际上我们通过点击 `工具(T)` ，然后再点击 `导出/备份配置(E)...` 后就可以将 `WinSCP.ini` 单独保存一份出来。

图a03



导出的 `WinSCP.ini` 文件随便你放哪儿都行。

打开它我们就能看到其中的会话项，并且附带有主机名、用户名以及密码等信息，这些其实和注册表中保存的是一样的。

图a04



这里需要注意一下，如果当初保存会话时你没有选择保存密码，那么在配置文件 `WinSCP.ini` 中是看不到加密密码的哦。

图b01





```
# host: 主机名
# username: 用户名
# encrypted_password: 加密的密码
winscppasswd.exe <host> <username> <encrypted_password>
```



我们随便拿一个会话记录来做下测试。

```
[Sessions\root@192.168.123.123]
HostName=192.168.123.123
UserName=root
Password=A35C435937195E68B72E3333286D656E726D6A64726D6E6F726D6E6F0F252F3D3831721F3F6D6E6F5D23011F2A5FD8DC56EA
```



比如上面的配置，那么我们写命令就可以像下面这样。

```
winscppasswd.exe 192.168.123.123 root A35C435937195E68B72E3333286D656E726D6A64726D6E6F726D6E6F0F252F3D3831721F3F6D6E6F5D23011F2A5FD8DC56EA
```



瞬间破防了，密码一览无余，太厉害了！

不过我的密码也顺利找回来了，欧耶！

图b02





修改环境变量 `GOPROXY` ，否则无法下载所需程序包。

```
go env -w GO111MODULE=auto
go env -w GOPROXY=https://goproxy.io,direct
```



获取所需的 `ini` 程序包。

```
go get github.com/go-ini/ini
```



程序包被下载到了 `GOPATH` 下，默认为以下路径。

```
C:\Users\<用户名>\go
```



在下载过程中如果你遇到了除无法下载之外的错误提示，那么多半你需要升级你的 `GO` 了。

我们使用通过执行源码的方式运行一下看看。

```
go run winscppwd.go 
```

可以看出，它还支持指定 `ini` 文件参数的语法。

```
winscppasswd.exe ini [<filepath>]
```

图c01



我们用前面导出的 `WinSCP.ini` 文件来试试看哈。

我的天啊！全都出来了，还有没有隐私啦？

图c02





旧版语法不支持指定 `WinSCP.ini` 文件。

图e02



新版功能更强大一些，直接甩给它 `WinSCP.ini` 就能批量找回密码啦！

图e01



**winscppasswd旧版.7z (439K)**

下载链接：



**winscppasswd新版.7z (1.22M) 含源码**

下载链接：





### 写在最后

本来打算自己用VB写一个同样可以实现找回密码功能的程序，但是无奈 `GO` 的语法不通，一时半会儿也没办法搞清楚解密的算法，因此暂时放弃，等研究会了算法再来过。

另外如果只是单纯调用 `winscppasswd` 命令的基础上写个 `GUI` 似乎又有些鸡肋，所以说还是要等有朝一日搞懂算法再搞个 `GUI` 才有意义。

或者，哪位小伙伴能不吝赐教告诉我这个算法，也省得我担心仅有的几根毛发（保住几根毛不易啊！）。

好了，分享在此又要和小伙伴们说拜拜了！

勿忘点赞、分享转发，切记不要将本文看到的内容用于不可描述的场合哦！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
