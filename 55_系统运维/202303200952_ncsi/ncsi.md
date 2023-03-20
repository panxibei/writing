ncsi

副标题：

英文：

关键字：





`NCSI` ，即 `Network Connectivity Status Indicator` 的缩写，如果直译成中文就是 `网络连接状态指示器` 。

但是吧，就算翻译过来也挺让人犯懵，其实用大白话讲，就是 `Windows` 系统用来判断电脑是否连接到 `Internet` 的一种技术。

这种技术具体怎么做出判断的呢？

说穿了其实非常简单，咱们往下看！





注册表

```
计算机\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet
```

大概分为三大部分：

* `DNS` 服务
* `WEB` 服务
* 其他一些功能参数

图b05



`DNS` 服务相对来说是固定的，没有特殊情况不需要修改它。

```
131.107.255.255    dns.msftncsi.com
```

图b01



`Ping` 一下这个 `DNS` ，似乎不通，但其实应该是起作用的。



`WEB` 服务访问才是重点。

图b03



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



这个要怎么看呢？

我们把字段尾部带 `V6` 的给忽略，就成这样了。

```
"ActiveWebProbeContent"="Microsoft Connect Test"
"ActiveWebProbeHost"="www.msftconnecttest.com"
"ActiveWebProbePath"="connecttest.txt"
```



简化了不少，不过都是什么意思呢？

第一行，文档内容，即我们看到的文本 `Microsoft Connect Test` 。

第二行，`Web` 服务器域名，即 `www.msftconnecttest.com` 。

第三行，`Web` 服务器域名根目录有一个文本文件，即 `connecttest.txt` 。



嘿嘿，将它们连起来，就是这个样子。

```
http://www.msftconnecttest.com/connecttest.txt
```

尝试直接用浏览器访问，结果：

```
Microsoft Connect Test
```



看懂了吧？很简单哦！

不过应该注意，这里用的是 `http` ，而不是 `https` 。



OK，了解过后，我们就可以动手将它改造改造。

修改后像这样（ `ipV6` 也跟着改改）。

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

结果：

```
Microsoft NCSI
```



一般来说都没问题，如果可以访问，那么网络连接的图标就不会变成小地球了。

这里告诉你们一个小秘密，其实这几个参数完全可以更换成自己的，并非一定要用官方的。



可以修改成自己的 `HTTP` 服务器上的链接即可。

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



**NlaSvc.7z(28.7K)**

下载链接：





> https://learn.microsoft.com/zh-cn/troubleshoot/windows-client/networking/internet-explorer-edge-open-connect-corporate-public-network#Workaround



```
注意

Microsoft 不建议禁用 NCSI 探测。 多个操作系统组件和应用程序依赖于 NCSI。 例如，如果 NCSI 无法正常工作，则 Microsoft Outlook 可能无法连接到邮件服务器，或者即使计算机已连接到 Internet，Windows 也可能无法下载更新。
```





另一个参数，用于查询网络活动状态。



```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet]
"EnableActiveProbing"=dword:00000001
```







 若要使用注册表禁用 NCSI 活动探测 

- ```
  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\EnableActiveProbing
  ```

  - 键类型：DWORD
  - 值：小数 0 (False) 

- ```
  HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\NoActiveProbe
  ```

  - 键类型：DWORD

  - 值：小数 1 (True) 

     备注

    在默认注册表配置中，此注册表项不存在。 必须创建它。



若要使用注册表禁用 `NCSI` 被动探测，请创建以下注册表项。

- ```
  HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\DisablePassivePolling
  ```

  - 键类型：DWORD

  - 值：小数 1 (True) 

     备注

    在默认注册表配置中，此注册表项不存在。 必须创建它。





若要使用组策略禁用 `NCSI` 活动探测，请配置以下 `GPO` ：

- 计算机配置 > 管理模板 > 系统 > Internet 通信管理 > Internet 通信设置 > 关闭 Windows 网络连接状态指示器活动测试
  - 值：已启用

若要使用组策略禁用 NCSI 被动探测，请配置以下 GPO：

- 计算机配置 > 管理模板 > 网络 > 网络连接状态指示器 > 指定被动轮询
  - 值：已启用







