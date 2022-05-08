[下载]还想免费玩 VMware vSphere Hypervisor 7.x？小心别被坑了哦！





如今虚拟机技术已经不是什么新鲜玩意了，并且像 `VMware` 这样的业界杰出代表官方也提供免费试用版本给用户下载尝鲜测试。

这不正好手上有一台闲置的联想台式机，于是就想安装个免费版的 `VMware vSphere Hypervisor` 玩玩。

谁承想居然历程坎坷、着实被坑了一把~

事情是这个样子滴......



记得上一次，我使用的还是 `6.0` 版本的程序，现在最新版是7.0，先找到它下载吧。

我以前就注册过帐号，经过登录、搜索很顺利地就找到了7.0下载的地方。

图1



看得出有两个可以下载的链接，第一个是ISO镜像文件，第二个是离线打包文件，那么选择哪一个呢？

记得以前是用ISO文件刻录成光盘，然后再使用光盘安装的，就选第一个链接来下载吧。

镜像文件有300多M，村里网速再慢也很快就下载完成了，刻光盘什么的都没问题，然后拿去安装，才发现卡住走不下去了。

图2



把上面的鸟语一翻译成人话，我就想骂人。

说是它没有找到物理网卡，反正没有网卡就是不能继续安装。

你说气不气人，这年头哪台电脑会没有网卡呢，WHAT FU*C......！

哎？你等等......好吧，我知道了，之前也曾经在其他台式机上安装过 `6.0` 版本的 `ESXi` ，也发生过这样的问题。

究其原因很简单，我们这位 `ESXi` 公主比较傲骄，只识别服务器设备上的网卡，普通台式机的网卡它压根就瞧不上。

我这么一查，我去果然这台式机的网卡是块螃蟹卡，型号正是烂大街的 `RTL8111/RTL8168/8411`。

OK！OK！Easy！Easy！

您瞧瞧，我这儿气得直说鸟语！

那怎样才能让我们的公主瞧得上呢？

我依稀记得可以通过某种工具软件把螃蟹卡的驱动导入到光盘镜像中，然后就可以顺利安装。

于是我就开始翻找以前的旧资料......



终于我找到了解决以前的解决方法。

方法很简单，只需把网卡的驱动导入到安装盘中即可。

要入得了傲骄公主的法眼，需要以下三位骑士出马（文末有下载）。

1.  `VMware vSphere Hypervisor` 的 `Offline Bundle` 程序包
2.  螃蟹卡的 `VIB` 驱动程序
3.  用于导入驱动程序的脚本工具



###### 最后，分享给小伙伴们本文涉及到的下载链接，可直接下载使用，免去你到处查找的麻烦。

**1、已经导入螃蟹网卡驱动的镜像，可直接用于安装。**

**ESXi-6.7.0-Within-R8111G.iso**

下载链接：(https://pan.baidu.com/s/1vNYLFlxenjq8TdUgGV2hGg

提取码：<文末付费查看>



**2、`VMware-ESXi-6.7.0` 的离线打包程序，可用于导入制作各种定制版安装镜像。**

**VMware-ESXi-6.7.0-8169922-depot.zip**

下载链接：https://pan.baidu.com/s/1x3BGcoXzx6DZ8WtWqh5qLQ

提取码：<文末付费查看>



**3、各种脚本工具和驱动。**

**ESXi-Customizer-PS-v2.6.0.ps1.7z**

下载链接：https://pan.baidu.com/s/17mQlfrl4nn6d_Srkg4rjoQ

提取码：<文末付费查看>



**VMware-PowerCLI-12.0.0-15947286.zip**

下载链接：https://pan.baidu.com/s/1L42WqA7tmZitm0JKq2y9Dg

提取码：<文末付费查看>



**net55-r8168-8.045a-napi.x86_64.vib.7z**

https://pan.baidu.com/s/1jNRamMMj_pEeXPilj62gJw

提取码：<文末付费查看>



补充分享：

**ESXi-6.5-within-R8111G.iso (带R8111G驱动)**

链接：https://pan.baidu.com/s/1doemMcr86aNg1TonBmseRA

提取码：<文末付费查看>



**ESXi-6.0-within-xahci-R8111G.iso(带SATA及R8111G驱动)**

链接：https://pan.baidu.com/s/1_D0_J_xKHWNpbufd20u73A

提取码：<文末付费查看>





付费查看下载提取码

↓↓↓





**1、已经导入螃蟹网卡驱动的镜像，可直接用于安装。**

**ESXi-6.7.0-Within-R8111G.iso**

下载链接：(https://pan.baidu.com/s/1vNYLFlxenjq8TdUgGV2hGg

提取码：whvl



**2、`VMware-ESXi-6.7.0` 的离线打包程序，可用于导入制作各种定制版安装镜像。**

**VMware-ESXi-6.7.0-8169922-depot.zip**

下载链接：https://pan.baidu.com/s/1x3BGcoXzx6DZ8WtWqh5qLQ

提取码：148b



**3、各种脚本工具和驱动。**

**ESXi-Customizer-PS-v2.6.0.ps1.7z**

下载链接：https://pan.baidu.com/s/17mQlfrl4nn6d_Srkg4rjoQ

提取码：aeno



**VMware-PowerCLI-12.0.0-15947286.zip**

下载链接：https://pan.baidu.com/s/1L42WqA7tmZitm0JKq2y9Dg

提取码：v1aq



**net55-r8168-8.045a-napi.x86_64.vib.7z**

https://pan.baidu.com/s/1jNRamMMj_pEeXPilj62gJw

提取码：yv2i



补充分享：

**ESXi-6.5-within-R8111G.iso (带R8111G驱动)**

链接：https://pan.baidu.com/s/1doemMcr86aNg1TonBmseRA

提取码：mdg1



**ESXi-6.0-within-xahci-R8111G.iso(带SATA及R8111G驱动)**

链接：https://pan.baidu.com/s/1_D0_J_xKHWNpbufd20u73A

提取码：eat9







**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

