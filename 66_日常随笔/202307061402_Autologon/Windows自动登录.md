Windows自动登录

副标题：

英文：

关键字：







按下 `徽标键+R` ，打开运行窗口。

图a01



那位说徽标键是啥？

徽标键就是印有 `Windows` 窗口图标的那个按键，就像这样的。

图a02



好，在打开的运行窗口中输入 `regedit` ，回车。

这时你会看到，一个叫作注册表编辑器的窗口被打开了。

图a03



接下来我们就只需要在这里操作就行了。

定位到如下注册路径：

```
计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
```



什么？你不会定位？

很简单啊，只要把上面那个路径复制下来，然后粘贴到注册表编辑器的地址栏内回车即可。

图a04



定位OK后，我们就可以找一找下面这几个注册表项了。

* `DefaultUserName` - 自动登录时的用户名
* `DefaultPassword` - 自动登录时的密码
* `DefaultDomainName` - 自动登录时的域名
* `AutoAdminlogon` - 开启自动登录的开关，`1` 开启，`0` 关闭，默认为 `0`



拢共就四个，意思也给你们解释过了，赶快找一找，看谁找到又快又准哈！

什么？只找到了三个？

那个 `DefaultPassword` 没找到？

呃，其实这个没找到没关系的，你自行创建一个也是可以的。





图a05