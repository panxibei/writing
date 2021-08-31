辞职后全职开发的操作系统 SerenityOS 到底是个怎样的系统

副标题：系统日益精进，毛发日益稀疏，长老好本事啊~

英文：how-about-serenityos-which-i-quit-my-job-to-focus-on-it-full-time

关键字：serenity,serenityos,os,linux,windows,andreas kling,andreas,kling



最近遇热的一款操作系统 `SerenityOS` 成功地被我注意到了！

近期这款系统位于 `GitHub` 排行榜第二的位置久居不下，认识它的人也越来越多。

这款系统有什么特别之处吗？

在多如牛毛的众多操作系统中，它其实并不是特别的亮眼，只不过它的出身有点与众不同。





分辨率太大，导致我看不到底下的开始菜单和状态栏。

右击桌面，选择 `Display Settings` ，然后选择 `Monitor` 选项卡，将 `Resolution` 一项修改为 `800x600` 。

图a01





```
vim /etc/LookupServer.ini
```



```
[DNS]
Nameserver=1.1.1.1,1.0.0.1
EnableServer=0
```

图a02





很多上伙伴手头上并没有 `QEMU` ，特意去装个 `QEMU` 其实挺麻烦也没有必要，那么我们能不能在诸如我们学用的  `VirtualBox` 或 `VMWare` 上跑一跑 `SerenityOS` 呢？

官网上说了，完全可以，我把文档内容总结如下，分享给需要的小伙伴们。



### 在 `VirtualBox` 上跑 `SerenityOS`

##### 1、生成可启动映像

在 `SerenityOS` 构建好后，可以用来生成可启动映像。

```
[serenity]# ninja -C Build/i686 grub-image
```

在 `Build/i686` 目录中会生成一个 `grub_disk_image`  文件。



```
[serenity]# qemu-img convert -O vdi Build/i686/grub_disk_image /path/to/serenityos.vdi
```



有了 `vdi` 文件就好办了，我们只要将它作为磁盘启动起来就行了。



##### 2、创建虚拟机

官网文档写得一套一套的，而且都是英文，看得眼疼，我给简化如下。

总而言之，创建的虚拟机只要满足以下条件即可。

1. 虚拟机版本选择 `Other/Unknown (64-bit)` ，切记不要选择 `Linux` 。

   图v01

   

2. 启用 `PAE/NX`。

   图v02

   

3. 存储控制器选择 `PIIX4` ，其他的可能会失败。

   图v03

   

4. 网卡仅支持 `Realtek` 之类的常见类型，但并不保证网络一定好用。

   图v04



一切如之前，自带小程序都还是可以用的，贪吃蛇、计算器、画图软件都不少。

其中那只酣睡的小猫，它会随时追踪你的鼠标，有点像桌面助手的赶脚。

图a03





##### 远程管理

在系统中运行 `TelnetServer` 命令开启 `Telnet` 服务端。

然后打开 `PuTTy` ，输入IP地址以及连接类型为 `Telnet` ，连接后可以远程管理 `SerenityOS` 了，也算是变相使用 `SSH` 了。

图a04



大部分网页无法正常打开，尝试了访问几个大网站，都是提示加载失败。

通常 `http` 开头的网页似乎还勉强能看到个页面部分，但 `https`  开头的就几乎访问不了了。

从后台 `Debug` 窗口中可以看到是由于 `https` 加密证书无法被正常识别造成的。

看来这套系统还是有待进一步开发啊！

