如何让 ESXi 7.x 识别普通台式机的网卡？

副标题：

英文：

关键字：



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

有位大神在提及新版本不再支持传统的 `VMKlinux` 驱动后，考虑到我们小白日常测试之需，与此同时也给出了可以使用 USB 网卡的解决方案。



>链接：https://williamlam.com/2020/03/homelab-considerations-for-vsphere-7.html
>
>Legacy VMKlinux Drivers
>
>It should come as no surprise that in vSphere 7, the legacy VMKlinux Drivers will no longer be supported. I suspect this will have the biggest impact to personal homelabs where unsupported devices such as network or storage adapters require custom drivers built by the community such as any Realtek (RTL) PCIe-based NICs which are popular in many environments. Before installing or upgrading, you should check to see if you are currently using any VMKlinux drivers, which you can easily do so with a PowerCLI script that I developed last year which is referenced in this blog post by Niels Hagoort.
>
>You should also check with your hardware vendor to see if a new Native Driver is available, as many of our eco-system partners have already finished porting to this new driver format over the past couple of years in preparation for this transition. For many folks, this will not affect you and you are probably already using 100% Native Drivers but if you are still using or relying on VMKlinux drivers, this is a good time to consider upgrading your hardware or talking to those vendors and asking why there is not a Native Driver for ESXi? From a networking standpoint, there are other alternatives such as the USB Native Driver for ESXi Fling which I will be covering in the next section.



大神给出了 `USB` 网卡驱动的下载链接：

https://flings.vmware.com/usb-network-native-driver-for-esxi



可喜的是，这些USB驱动还支持包括螃蟹卡在内在很多常见网卡。

> The ASIX USB 2.0 gigabit network ASIX88178a, ASIX USB 3.0 gigabit  network ASIX88179, Realtek USB 3.0 gigabit network RTL8152/RTL8153 and  Aquantia AQC111U.



我找来了一块联想的USB转RJ45的转接网卡，通过测试发现可以正常工作。

那么这个驱动怎么打到安装镜像中呢，毕竟在控制台上安装驱动是个伪命题？

这里还是和之前文章中介绍的一样，用到了一个工具和两个材料。



我们拿最新版本 `7.0U2a` 来举例，它们分别是：

* **驱动注入工具**

  **ESXi-Customizer-PS-2.8.1.zip**

  下载链接：

  

* **USB 网卡驱动**

  **ESXi702-VMKUSB-NIC-FLING-47140841-component-18150468.zip**

  下载链接：

  

* ** `ESXi 7.0U2a` 扩展包**

  **VMware-ESXi-7.0U2a-17867351-depot.zip**

  下载链接：



1、将驱动注入工具 `ESXi-Customizer-PS-2.81.zip` 解压缩后得到 `ESXi-Customizer-PS.ps1` 文件。

2、将USB网卡驱动 `ESXi702-VMKUSB-NIC-FLING-47140841-component-18150468.zip` 解压缩后得到 `VMW_bootbank_vmkusb-nic-fling_1.8-3vmw.702.0.20.47140841.vib` 文件。

3、新建一个空文件夹，不要解压缩将扩展包文件 `VMware-ESXi-7.0U2a-17867351-depot.zip` 直接与前两步获得的文件放在新建的同一文件夹内。

4、以管理员身份打开 `PowerShell` ，进入第3步新建的文件夹内，然后执行以下命令。

```powershell
.\ESXi-Customizer-PS.ps1 -izip .\VMware-ESXi-7.0U2a-17867351-depot.zip -pkgDir .\
```

等待命令完成，只要不报错，即可成功注入驱动。

图01



驱动注入成功后，在同一文件夹内会生成一个新的镜像文件。

用这个镜像文件去安装吧，它已经将 USB 网卡驱动打包进去了。

不过这里要注意一点，你下载的驱动版本必须与镜像扩展包文件的版本一致。

从图中可以看出，最小支持 `6.5` 版本，更新时间是 2021年6月14日 。

图02



到这儿可能有的小伙伴会觉得，USB 网卡支持和测试倒没啥大问题，而且现在这种网卡也是千兆速率，不过嘛，总感觉有点太随意不太正规的样子。

还有些小伙伴可能会担心此类网卡的稳定性。

人家大神都写得清楚，下载的时候你要同意不用在生产环境，你想玩真的？

好吧，好像也有办法，我听说要安装 Intel 芯片的千兆网卡。



### 使用 `PCIe` 千兆网卡











