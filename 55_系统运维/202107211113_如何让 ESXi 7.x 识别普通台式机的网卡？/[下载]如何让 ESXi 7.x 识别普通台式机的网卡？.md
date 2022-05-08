[下载]如何让 ESXi 7.x 识别普通台式机的网卡？



很久很久以前我曾写过一篇文章，说的是 `ESXi` 的 `7.x` 版本与以往的 `6.x` 版本已大不一样，已经不再支持普通台式机上的螃蟹网卡了。

文章一出，很多小伙伴都坐不住了，这还怎么玩呢？

前文也说明了不支持的原因，同时也给出了 `6.7` 版本的镜像文件，以方便大家伙测试使用。

> 《还想免费玩 VMware vSphere Hypervisor 7.x？小心别被坑了哦！》
>
> 链接：https://www.sysadm.cc/index.php/xitongyunwei/765-vmware-vsphere-hypervisor-7-esxi



虽然 `6.7` 版本的照样可以玩，但毕竟现在主流是 `7.x` ，然而一般情况下我们也不可能有那么多服务器用来测试，真的就拿它没办法了吗？

办法总比困难多，虽然这句话听上去像一碗鸡汤，但我们既然碰到了问题，总是要尝试一下看看嘛！

你还别说，我找了N多天，多少有那么一点点收获。



### 使用 USB 网卡

我找来了一块联想的USB转RJ45的转接网卡，通过测试发现可以正常工作，注意最好是千兆。

那么这个驱动怎么打到安装镜像中呢，毕竟在控制台上安装驱动是个伪命题？

这里还是和之前文章中介绍的一样，用到了一个工具和两个材料。



我们拿最新版本 `7.0U2a` 来举例，它们分别是：

* **驱动注入工具**

  **ESXi-Customizer-PS-2.8.1.zip**

  下载链接：https://pan.baidu.com/s/1kPbFlEbLCbVt3atfDJjkkw

  提取码：<文末付费查看>

  

* **USB 网卡驱动**

  **ESXi702-VMKUSB-NIC-FLING-47140841-component-18150468.zip**

  下载链接：https://pan.baidu.com/s/10mHYyy7lnqkfyOYomeAa6w

  提取码：<文末付费查看>

  

* **`ESXi 7.0U2a` 扩展包**

  **VMware-ESXi-7.0U2a-17867351-depot.zip**

  下载链接：https://pan.baidu.com/s/19u7zklSSPMKs8RfD7N7OSg

  提取码：<文末付费查看>



### 使用 `PCIe` 千兆网卡

如果感觉 USB 网卡 Low 的话，那只能找块 Intel 芯片的千兆网卡装上了，那么什么样的网卡可行呢？

赶巧手头上有一块瑞联的千兆网卡，可能是以前买来备用的。

型号是 `LREC9201CT` ，网上一查，它的芯片正好是 Intel 的，就拿它来试试吧。



### 完整版镜像文件下载

图07



**ESXi-7.0U2a-VMKUSB-NIC-FLING.ISO (388M)**

SHA256: 74D05ECC728EC565CA9EEF57928F4B1F86EC3F7005DF2AED395352B748B176E2

下载链接：https://pan.baidu.com/s/1Wn4tARpUzqGSFRjQvXm6aA

提取码：<文末付费查看>



付费查看下载提取码

↓↓↓



驱动注入工具以及扩展包等：

* **驱动注入工具**

  **ESXi-Customizer-PS-2.8.1.zip**

  下载链接：https://pan.baidu.com/s/1kPbFlEbLCbVt3atfDJjkkw

  提取码：txr7

  

* **USB 网卡驱动**

  **ESXi702-VMKUSB-NIC-FLING-47140841-component-18150468.zip**

  下载链接：https://pan.baidu.com/s/10mHYyy7lnqkfyOYomeAa6w

  提取码：sn1k

  

* **`ESXi 7.0U2a` 扩展包**

  **VMware-ESXi-7.0U2a-17867351-depot.zip**

  下载链接：https://pan.baidu.com/s/19u7zklSSPMKs8RfD7N7OSg

  提取码：0v26



**ESXi-7.0U2a-VMKUSB-NIC-FLING.ISO (388M)**

SHA256: 74D05ECC728EC565CA9EEF57928F4B1F86EC3F7005DF2AED395352B748B176E2

下载链接：https://pan.baidu.com/s/1Wn4tARpUzqGSFRjQvXm6aA

提取码：o95m



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc









