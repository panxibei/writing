KVM的raw格式磁盘扩容方法

副标题：尽量使用raw的磁盘格式，扩容起来很方便



> 微信公众号：网管小贾
>
> 博客：www.sysadm.cc



由于见天地往虚拟机里堆东西，什么安装包啦、系统镜像啦，渐渐地小小硬盘快撑不住了。

一开始也没想着要用多大容量的硬盘，随便设置了一个小容量，现在不够用了，于是网上扒了扒有什么方法可以扩容。

找到了几个方法，其中说到对于raw格式的磁盘，KVM自带的命令就可以解决扩展问题。

回头瞧了一眼，不错，我当初都是使用 `dd` 创建的磁盘，属于raw格式。

具体怎么做，请往下看。



##### - Part 1. 使用命令扩展磁盘容量 -

很简单，就两条命令。

一个是查看当前磁盘信息，包含容量信息。

```shell
shell> qemu-img info xxx.img
```

另一个是扩容命令，直接扩展你想要的容量大小。

```
shell> qemu-img resize xxx.img +yyyG    #yyy是数字，比如100G
```

实例：

```shell
[root@KVM test]# qemu-img info mywin7.img  // 查看磁盘信息
image: mywin7.img
file format: raw
virtual size: 20G (21474836480 bytes)
disk size: 10G

[root@KVM test]# qemu-img resize mywin7.img  +200G // 怕不够，先加个200G再说
Image resized.

[root@KVM test]# qemu-img info mywin7.img // 再次查看磁盘信息，容量扩展OK
image: mywin7.img
file format: raw
virtual size: 298G (319605964800 bytes)
disk size: 13G
```



##### Part 2. Windows系统中扩展磁盘空间

这一步如果不做的话，在虚拟机上是无法使用扩展后的空间的。

其实操作也很简单，还是接着往下看。



1、找到 `磁盘管理` 界面，右击C盘，在弹出的菜单中选择 `扩展卷`。

图1

2、在 `扩展卷向导` 界面中，直接点击 `下一步`，最后点击 `完成`。

图2

3、再回到 `Windows资源管理器` 看一下C盘容量，是不是已经扩展完成了呢。



欧了！揍四辣么简单！

如果你成功搞定，别忘记帮我点个赞哦。

如果你有什么问题，欢迎和我讨论交流！88



> 微信公众号：网管小贾
>
> 博客：www.sysadm.cc