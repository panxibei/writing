【XigmaNAS 设置和用户指南】03.初始配置

副标题：

英文：

关键字：





 # `LAN` 接口和 `IP` 配置

一旦你将 `XigmaNAS` 安装到了 `CF` 、 `HDD` 或 `USB` 驱动器上，电脑设备就会从这些设备上重新启动。

你首先应该登录控制台：

```
#login:
```

默认登录 `XigmaNAS` 控制台的帐户和密码：

```
username:root
password:xigmanas
```

```
Console Menu
------------
1) Configure Network Interfaces    10) Configure Hosts Allow for WebGUI
2) Configure Network IP Address    11) Restart WebGUI
3) Reset WebGUI Password           12) Resart WebGUI. force HTTP on port 80
4) Reset to Factory Defaults       20) Console Keyboard Map
5) Ping Host
6) Shell
7) Reboot Server
8) Shutdown Server

Enter a number:
```



默认配置的 `XigmaNAS` 会使用第一检测到的 `NIC` (网卡)并将其 `IP` 地址设置为 `192.168.1.250` 。

* 选择 `1` 并输入网卡接口名称（我这边是 `fxp0` ,可能和你的不同) 

* 在可选项 `1` 接口提示时按下回车，选择 `y` 并设定接口

* 选择 `2` 并选择是否使用 `DHCP` 。

  如果不启用，请输入您的 `IP` 地址设置（以我为例：`192.168.8.128` 和 `/24` ）以及合适的网址。

* 一旦控制台菜单有效，选择 `5` 并 `ping` 另一个子网上的设备以确保网络连接可靠（请牢记，你无法 `Ping` 通一台受个人防火墙保护的电脑），请先禁用防火墙。 

  



   













