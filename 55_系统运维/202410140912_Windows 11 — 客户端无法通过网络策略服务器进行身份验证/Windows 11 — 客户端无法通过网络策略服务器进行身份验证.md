Windows 11 — 客户端无法通过网络策略服务器进行身份验证





证书命名

打开证书管理器，输入以下命令。

```
certlm.msc
```

图





主机名称

设置>系统>系统信息

图





在Dell官网上找到了疑似解决方案。

> https://www.dell.com/support/kbdoc/zh-cn/000193474/windows-11-客户端-无法-通过-网络-策略-服务器-进行-身份-验证?msockid=30bef28433e86df715b6e19132c66c9f



>Windows 11 身份验证失败
>
>Windows 11 计算机无法通过 Windows 网络策略服务器 (NPS) 外部链接进行身份验证。
>
>
>
>解决方案
>
>1、Microsoft 在 Windows 11 中引入了 NPS 证书的区分大小写验证（Windows 10 支持不区分大小写的表示法）。
>
>2、查看并调整组织组策略 (GPO) 中受保护的可扩展身份验证协议 (PEAP) 设置。
>
>3、验证颁发给服务器的根 CA 是否与主机名的表示法匹配。



图b01





如果使用 `Microsoft:智能卡或其他证书(EAP-TLS)` ，似乎只能使用计算机身份证书验证。













**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc