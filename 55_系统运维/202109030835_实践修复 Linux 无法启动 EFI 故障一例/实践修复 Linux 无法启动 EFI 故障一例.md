实践修复 Linux 无法启动 EFI 故障一例

副标题：

英文：

关键字：







### 救援模式下挂载 `LVM` 



##### 1、查看当前系统中的**逻辑卷**信息

```
lvdisplay
```

从输出结果中可以看到，有两个逻辑卷，一个是交换分区，一个是根分区。

此外我们也可以看到卷组的名字叫作 `rl` ，这个是我默认安装时系统自动起的名字，暂且记住它，一会有用。

图a01



##### 2、查看当前系统中的**逻辑卷组**信息

```
lvm vgscan
```

和前面查看的信息一致，卷组就叫 `rl` 。

图a02



##### 3、激活**逻辑卷**

```
# lvm vgchange -ay 卷组名称
lvm vgchange -ay rl
```

注意，命令最后要写上前面查看到的卷组的名字，本例中刚才我们获取到的是 `rl` 。

从输出结果中我们得知卷组 `rl` 中有两个逻辑卷被激活，这两个就是前面我们查看过的 `swap` 和 `root` 两个分区。

图a03



是不是真的被激活了呢？

我们可以在执行此命令之前，先查看一下 `/dev` 下的设备名称。

如图示，前后对比之下，很容易发现的确多出来一个叫作 `rl` 的家伙，不用多说，就是那个谁了。

图a04



##### 4、挂载**逻辑卷**分区

```
# mount /dev/卷组名称/root 挂载点
mount /dev/rl/root /mnt/sysimage/
```

挂载前 `/mnt/sysimage/` 下啥都木有，挂载后原系统上的文件都粗线了！

图a05



### 救援模式下挂载到原系统根目录

为了修复原系统，必须切换（挂载）到原系统上再进行下一步操作。

```
chroot /mnt/sysimage/
```

图a06



**手动设定网卡，以保证能访问网络。**

```
# 查看当前网卡信息
ip addr show
```

我们可以从图中看到，网卡设备名称是 `enp0s3` ，实际以你查看的为准，另外状态是 `UP` 启动状态。

图a07



```
# 确保启用了网卡，本例网卡名称为 enp0s3
ip link set dev enp0s3 up
```

如果网卡状态是 `DOWN` 禁用状态，那么就用这条命令启用它。

当然了，通常接上网线的话网卡应该是启用状态，所以别忘记接网线哦！



```
# 设定IP地址，最后的网卡名称按实际情况修正
# 本例IP地址为 192.168.1.123/24 ，网卡名称为 enp0s3
ip addr add 192.168.1.123/24 dev enp0s3

# 设定网关，本例为 192.168.1.1
ip route add default via 192.168.1.1
```

命令完成后，尝试 `ping` 一下确认网络是否连接正常。

图a08



```
/usr/sbin/sshd -D &
```





**重新安装 `grub2-efi` 和 `shim` 。**

```
dnf reinstall grub2-efi shim
```

图a09





**安装 `kernel` 。**

可以安装指定版本的 `kernel` 。

```
# 查看内核版本号
# 比如输出：4.18.0-305.3.1.el8_4.x86_64
uname -r

# 列出可安装的内核版本
# 有两个版本：一个是 4.18.0-305.3.1.el8_4，另一个是 4.18.0-305.12.1.el8_4
dnf list kernel

# 安装指定版本的内核
dnf reinstall "kernel-*-$(uname -r)"

dnf reinstall "kernel-headers-$(uname -r)"
dnf reinstall "kernel-core-$(uname -r)"
dnf reinstall "kernel-modules-$(uname -r)"
```



```
dnf reinstall kernel*
```







安装完成后，我们立马就可以看到 `/boot` 目录下的几个久违的子目录都回来了。

但是要注意哈，我们也能看出来，关键的 `grub.cfg` 并没有粗线，所以先不要激动，还得继续努力哈！

图a10



**重新生成 `grub.cfg` 文件。**

```
# grub2-mkconfig -o 输出目录/grub.cfg
# grub2-mkconfig -o /boot/efi/EFI/发行版名称/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/rocky/grub.cfg
```



请小心，此处有个坑，如果直接以上命令，那么你有可能会得到以下这样的错误。

```
grub2-probe: error: cannot find a device for / (is /dev mounted?)
```

原因是因为挂载的 `/mnt/sysimage/` 下 `/dev` 中的确是空的，什么都没有。

解决方法也很简单，就是先退出挂载，在救援 `shell` 中执行该命令。

需要注意的是，同时相应的路径也要做些修改。

```
bash-4.4# exit
sh-4.4# grub2-mkconfig -o /mnt/sysimage/boot/efi/EFI/rocky/grub.cfg
```

图a11



这样命令就能正确找到设备 `/dev/mapper/rl-root` ，从而成功执行。

可以先查看一下这个新生成的 `grub.cfg` 文件，也可以直接重新启动。