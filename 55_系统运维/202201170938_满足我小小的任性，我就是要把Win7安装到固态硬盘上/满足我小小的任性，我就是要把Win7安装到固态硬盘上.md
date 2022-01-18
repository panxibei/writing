满足我小小的任性，我就是要把Win7安装到固态硬盘上

副标题：M.2接口固态硬盘上安装Win7

英文：to-satisfy-my-little-willfulness-i-just-want-to-install-win7-on-solid-state-drive

关键字：ssd,固态硬盘,win7,windows,adk,dism,m2,pci-e,nvme,KB2990941



虽说机械硬盘有机械硬盘的好处，但不得承认如今早已是固态硬盘大行其道的时代了。

你要是还在用机械硬盘，完了再来安装个 `Win10` ，嘿嘿，别怪我没提醒你哈，出门都不好意思和人打招呼，那速度卡得你是分分钟上升到怀疑人生的高度。

咱要认清现实，固态硬盘早已是主流，连服务器都屁颠儿地用上了固态，现在要是谁还在抱有怀疑态度，那不是蠢就是蠢，就这智商也坏不到哪儿去哈！



不说别的，就拿部分老机型电脑，安上固态硬盘就能让它们再次找回年轻时的感觉，瞬间一夜回春年轻态啊！

特别是不少 `Win7` 粉，至少能让他们再坚持个一年半载不成问题，总不能让人家还在机械硬盘上跑吧！

当然对于 `Win7` 来说，如果你用的是 `SATA` 接口的固态硬盘，那么直接拿来用就是了。

但是你要是想用 `M.2` 甚至是 `PCI-e` 接口的固态硬盘，那我只好说 `I'm sorry` ，直接这么干还真不行！

原因很简单，就是 `Win7` 它默认不能识别支持 `NVMe` 的固态硬盘。

接下来我就和小伙伴们分享一下将 `Win7` 安装到 `M.2` 接口的固态硬盘的经验。



### 准备工作

所需软件

* `Windows 7 Professional with Service Pack 1 (x64)`
* `Windows ADK Windows 8.1` 及以上



`Win7` 可到 `itellyou.cn` 上下载。

> https://next.itellyou.cn/



`Win10` 自带 `DISM` 命令，如果没有 `DISM` 命令，可到以下官网链接下载 `ADK` 。

制作 `ISO` 的 `oscdimg` 命令需要 `ADK` 。

> https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install



### 让 `Win7` 支持 `NVMe` 协议的原理

实际上我们说了半天的 `M.2` 接口也好，或是 `PCI-e` 接口也好，其实本质上跑的都是 `NVMe` 协议。

关于这个 `NVMe` ，大家可以自行某度，我就不在这儿展开了，其实它就是有别于传统的 `SATA` ，跑得速度更多快的新规范标准。

至于 `NVMe` 是规范还是协议，其实和以前的 `SATA` 和 `AHCI` 一样，我们没必要咬文嚼字，只要知道接口和协议规范的区别就行。

总而言之，使用 `NVMe` 的固态硬盘跑得比使用 `SATA` 的固态硬盘快。



好了，前面也说过，若是 `SATA` 接口的固态硬盘，我们直接拿来用就是了，但是我们现在要面对的则是跑 `NVMe` 协议的固态硬盘，即接口是 `M.2` 或是 `PCI-e` 。

而 `Win7` 默认情况下不支持 `NVMe` 固态硬盘的原因，则是它缺少相应的更新补丁支持。

众所周知，`Win7` 退休得太早了，还没来得及赶上固态硬盘大规模跟进的时代就让官方给送进敬老院了。

不过现在我们也不用担心，官方之后还是帮我们补上了相应的更新程序，敬老爱老是应该的。

也就是说，只要我们安装上这些更新补丁程序，那么我们就有了让 `Win7` 支持 `NVMe` 的可能。

然后我们给它再导入对应的固态硬盘驱动程序，一切就完美了。



### 获取更新补丁和驱动程序

那么接下来自然就是找到这些补丁和驱动了。

我找了好久，好像并不能找到所谓的万能驱动，最后是在联想的官网上找到了一个压缩包，似乎可以用在一部分电脑上，后来证明并不适用于所有的机器。



* 更新修复补丁
  * `Windows6.1-KB2990941-v3-x64.msu`
  * `Windows6.1-KB3087873-v2-x64.msu`

**HotFix.7z(6.60M)**

下载链接：https://pan.baidu.com/s/1ujOdT9p6vVcVqoWvIf_YDg

提取码：8i9x



图01



* 固态驱动程序

**NVMex64.7z (1.98M)**

下载链接：https://pan.baidu.com/s/1KlSGi3bjBciOl9exsbj73Q

提取码：f5y4



图02



### 将补丁及驱动注入 `Win7` 镜像

我们有了补丁和驱动，那么接下来就是想办法将它们放到安装镜像中去。

按以下步骤，我们一步一步地操作就可以完成驱动注入。



#### 1、创建几个本地文件夹，用来存放操作过程中的文件。

* `e:\win7\src` - 镜像解压出来的原文件
* `e:\win7\mount` - 镜像原文件临时挂载
* `e:\win7\winremount` - 镜像恢复文件临时挂载
* `e:\win7\hotfix` - 更新补丁
* `e:\win7\drivers` - 驱动程序

```
mkdir e:\win7\src e:\win7\mount e:\win7\winremount e:\win7\hotfix e:\win7\drivers
```



#### 2、将 `ISO` 镜像文件中的所有文件解压缩到 `src` 子文件夹中。



#### 3、将前面下载的补丁程序解压缩后（ `.msu` 或 `.cab` 文件）放到 `hotfix` 子文件夹中。

`hotfix` 文件夹中直接存放 `.msu` 文件，不要有下一级子文件夹。



#### 4、将前面下载的驱动程序解压缩后放到 `drivers` 子文件夹中。

`drivers` 文件夹中可有多个子文件夹，用于导入多个不同的驱动程序。



#### 5、以管理员权限打开命令提示窗口，依次执行以下命令。

##### a、将补丁和驱动注入到 `boot.wim` 中。

1、镜像索引一注入。

```
# 将 boot.wim 挂载到临时文件夹 mount 中，索引为1
dism /Mount-Image /ImageFile:e:\win7\src\sources\boot.wim /Index:1 /MountDir:e:\win7\mount
```

图03



```
# 注入补丁程序
dism /Image:e:\win7\mount /Add-Package /PackagePath:e:\win7\hotfix
```

图04



```
# 注入驱动程序
dism /Image:e:\win7\mount /Add-Driver /Driver:e:\win7\drivers /Recurse /Forceunsigned
```

图05



```
# 卸载临时镜像并重新整合镜像
dism /Unmount-Image /MountDir:e:\win7\mount /Commit
```

图06



2、镜像索引二注入，和前面的非常类似，但须注意其中有一个特殊步骤。

```
# 将 boot.wim 挂载到临时文件夹 mount 中，索引为2
dism /Mount-Image /ImageFile:e:\win7\src\sources\boot.wim /Index:2 /MountDir:e:\win7\mount

# 注入补丁程序
dism /Image:e:\win7\mount /Add-Package /PackagePath:e:\win7\hotfix

# 注入驱动程序
dism /Image:e:\win7\mount /Add-Driver /Driver:e:\win7\drivers /Recurse /Forceunsigned
```



注意！注意！注意！关键的操作来了！

此时我们将 `e:\win7\mount\sources` 文件夹中的所有文件按日期排序，找到最新的那些文件，同时将它们覆盖拷贝到 `e:\win7\src\sources` 中。

图07



```
# 卸载临时镜像并重新整合镜像
dism /Unmount-Image /MountDir:e:\win7\mount /Commit
```



以上步骤除了挂载镜像时的索引不一样外，就是 `mount\sources` 子文件夹中的最新文件需要复制出来，这一点不要搞错了哦！



#####  b、将补丁和驱动注入到 `install.wim` 和 `winre.wim` 中。

1、查看 `Install.wim` 中有多少索引需要更新。

```
dism /Get-WimInfo /WimFile:e:\win7\src\sources\install.wim
```

可以看到，当前镜像只有一个索引。

图08



2、注入补丁和驱动程序。

注意，如果查看 `Install.wim` 含有多个索引，则应该按以下命令步骤逐个重复更新注入。

```
# 将 install.wim 挂载到临时文件夹 mount 中，索引为1
dism /Mount-Image /ImageFile:e:\win7\src\sources\install.wim /Index:1 /MountDir:e:\win7\mount

# 注入补丁程序
dism /Image:e:\win7\mount /Add-Package /PackagePath:e:\win7\hotfix

# 注入驱动程序
dism /Image:e:\win7\mount /Add-Driver /Driver:e:\win7\drivers /Recurse /Forceunsigned

# 将 winre.wim 挂载到临时文件夹 winremount 中，索引为1
dism /Mount-Image /ImageFile:e:\win7\mount\windows\system32\recovery\winre.wim /Index:1 /MountDir:e:\win7\winremount

# 注入补丁程序
dism /Image:e:\win7\mount /Add-Package /PackagePath:e:\win7\hotfix

# 注入驱动程序
dism /Image:e:\win7\mount /Add-Driver /Driver:e:\win7\drivers /Recurse

# 卸载临时镜像并重新整合镜像
dism /Unmount-Wim /MountDir:e:\win7\winremount /Commit
dism /Unmount-Wim /MountDir:e:\win7\mount /Commit
```



### 生成全新支持 `NVMe` 的 `ISO` 文件

我们可以将前面制作好的已注入补丁和驱动的安装文件打包成新的 `ISO` 镜像文件。

这样一来，我们就可以拿着这个镜像文件刻录的光盘在搭载有 `NVMe` 固态硬盘的电脑上安装 `Win7` 了。

不过需要注意，我们用到的 `oscdimg` 命令需要事先安装好 `ADK` 。

参考命令如下：



**传统 `BIOS` 启动模式：**

```
# -l 镜像标签
# -m 忽略镜像的最大尺寸限制
# -u2 镜像使用UDF文件格式
# -b 指定引导扇区文件位置，不能有空格

oscdimg -lNVME4Win7 -m -u2 -be:\win7\src\boot\etfsboot.com e:\win7\src e:\win7\Win7.NVME.ISO
```

图09



**支持 `UEFI` 及 `BIOS` 多启动模式：**

```
# 具体参数可用命令 oscdimg -help boot 查看
oscdimg -lNVME4Win7 -m -u2 -bootdata:2#p0,e,bE:\win7\src\boot\etfsboot.com#pEF,e,bE:\win7\src\efi\microsoft\boot\efisys.bin E:\win7\src E:\win7\Win7.NVME.ISO
```

图10



当然你也可以使用其他工具来制作 `ISO` 镜像文件。

不过如今光驱也很难看到了，使用光盘来安装系统多少显得有点Low了。

小伙伴们可以将 `src` 文件夹中的文件直接复制到U盘根目录中，并且参考我之前写的一篇文章，只需再复制两个文件到U盘上就可以完美支持 `UEFI` 启动安装 `Win7` 啦！

> 《不用U盘制作工具，超简单方法让 Windows 7 通过 UEFI 方式启动并安装系统》
>
> https://www.sysadm.cc/index.php/xitongyunwei/824-simple-way-usb-stick-install-windows-7-through-uefi-without-usb-making-tools



### 实际使用情况

新注入补丁驱动的安装镜像我们已经制作完毕，那它在实际使用中能不能达到预期效果呢？

我们试试便知！



先在虚拟机上测试一下，我使用的是 `VirtualBox` ，其他品种小伙伴们请自行测试。

首先，将存储控制器设定为 `NVMe` ，磁盘介质也就是硬盘挂载在这上面。

注意，光驱可不要挂在 `NMVe` 上面，要不是启动不了的。

图11



此外，将 `USB设备` 一项修改为 `USB 3.0 (xHCI) 控制器` 。

图12



不管是 `NVMe` 还是 `USB 3.0` ，`Win7` 在以前默认安装启动时都是无法正常识别的。

现在我们用新制作的镜像文件启动看看。

OK，磁盘被正常识别，可以被分区并安装。

图13



同时，插入U盘后通过 `USB 3.0` 也能正常识别，毫无压力。

图14



虚拟机上没问题了，接下来就是实体机。

虽然我在一台联想 `K22` 笔记本上测试成功，可以将 `Win7` 安装在固态硬盘上，但换了一台台式机就不行。

猜测会不会是驱动不全，毕竟主板不一样。

所以建议小伙伴们找到合适自己电脑的相应驱动（最好是官网的），将其注入镜像后再测试。

好像不同厂家其固态硬盘驱动还不完全一样，至于所谓的万能驱动，我看只有 `Win10` 上有，反正我是没找到过，如果你有的话还请分享一下哦！



这里需要补充一点，如果你的电脑不支持传统兼容启动模式（比如 `CSM` ）而只有 `UEFI` 的话，那么赶紧该干吗干吗吧，因为 `Win7` 是无法正常启动的，别浪费时间了哦！



### 写在最后

文章分享到这儿就要接近尾声了，但是好像我找到的驱动似乎只适合于一部分机器，不得不说有一点点小遗憾。

因此还需要小伙伴们补充不足的地方，有什么好的建议请大家评论分享。

另外在此重申一下，我向大家分享的内容中，通常会建议大家尽量使用官方的原版的软件和工具，这样可以最大程度地保证我们制作出来的东西是干净的、自主的。

就像开源软件一样，不管成不成功，至少我们可以知道我们在做什么、做了什么以及做好后会有什么样的效果，不用担心广告或者居心不良之人夹带私货。

基于此，除了提供软件下载外，我当最大可能地与大家分享细节，希望我能和小伙伴们一起不断成长进步！

好了，今天的分享就在这儿了，祝你们好运哦！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc