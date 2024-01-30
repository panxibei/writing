OUTLOOK无法打开链接

副标题：

英文：

关键字：





> https://support.microsoft.com/zh-cn/office/outlook-%E5%9C%A8%E5%AE%89%E8%A3%85-2023-%E5%B9%B4-7-%E6%9C%88-11-%E6%97%A5%E5%8F%91%E5%B8%83%E7%9A%84-microsoft-outlook-%E5%AE%89%E5%85%A8%E5%8A%9F%E8%83%BD%E7%BB%95%E8%BF%87%E6%BC%8F%E6%B4%9E%E7%9A%84%E4%BF%9D%E6%8A%A4%E5%90%8E%E9%98%BB%E6%AD%A2%E6%89%93%E5%BC%80-fqdn-%E5%92%8C-ip-%E5%9C%B0%E5%9D%80%E8%B6%85%E9%93%BE%E6%8E%A5-4a5160b4-76d0-465b-9809-60837bbd35a8





`GPO` 组策略。

`计算机配置` > `管理模板` > `Windows 组件` > `Internet Explorer` > `Internet 控制面板` > `安全页` > `站点到区域分配列表` 。

图a03



启用，点击显示。

图a04



在其中填写。

图a05



可惜的是，组策略区域管理接口不提供输入值的输入验证。 通过利用上述提示，管理员可以确保在广泛部署策略值之前将其视为有效。





如果是域名。

```
Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\contoso.com
```



如果是IP地址。

```
Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1
```





