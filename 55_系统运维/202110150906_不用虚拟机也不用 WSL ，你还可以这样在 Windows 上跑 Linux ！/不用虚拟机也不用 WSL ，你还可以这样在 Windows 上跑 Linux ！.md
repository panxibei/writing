不用虚拟机也不用 WSL ，你还可以这样在 Windows 上跑 Linux ！

副标题：

英文：

关键字：



不用虚拟机也不用 WSL ，如何在 Windows 上跑 Linux 呢？





需要安装 `WinPcap` 。

> `WinPcap` 下载链接：https://www.winpcap.org/install/default.htm







我们可以在 `C:\Program Files\colinux` 中找到一份关于如何配置 `CoLinux` 的文本说明文件 `colinux-daemon.txt` 。

图b01





```
kernel=<path to vmlinux file>

  This specifies the path to the vmlinux file.

  Example:
  kernel=vmlinux

initrd=<path to initrd file>

  This specifies the path to the initrd file.

  Example:
  initrd=initrd.gz
```



关于内存设定，作为实验，一般不需要特别指定，默认是被注释掉的。

内存默认以 `MB` 为单位，在未被指定并且你的实际物理内存大于 `128MB` 的情况下，它会以实际物理内存的四分之一为设定标准。

 ```
 mem=<mem size>
 ```





妈耶，这是什么字体啊，造型挺别致啊！

遂修改之







这里有坑，日文键盘布局。

布局错乱，除了标点符号啥的完全不一样外，好像 `z` 键和 `y` 键也完全颠倒了。

图a20



对于这样变态的用法你能忍吗，反正我是忍不了了，怎么办？

很简单，`Ubuntu` 里有修改键盘布局的高级工具 `dpkg-reconfigure` 啊！

输入以下命令开启变更键盘布局之旅。

```
$ sudo dpkg-reconfigure keyboard-configuration
```



注意，在出现的界面中，按上下键做出选择，按 `Tab` 键移动光标至 `<OK>` 处再按回车进入下一步。

第一个画面中，选择 `Generic 104-key PC` ，当然你看到的是乱码，忍耐一下，一会儿就好。

图a21



紧接着选择 `Chinese` ，这是国家和区域选择。

图a22



接下来是选择语言，我猜应该是最上面一行简体中文。

图a23



然后应该是键盘布局，选择最上面的默认布局，可以参考第二幅图片。

图a24

图a25



快了哈，接着是配置组合键，选择第一行没有组合键，同样参考第二幅图，我的眼睛啊！

图a26

图a27



最后不用我多说，肯定是确认设置，选择 `Yes` 搞定！

图a28



OK，再来试试键盘输入，瞬间舒服多了吧！





### 网络设置



关闭防火墙。



网卡支持类型为：tuntap，pcap-bridge，ndis-bridge，slirp

图a31



注意，配置文件中最好按以下格式写入网卡配置信息。

本地连接名称就是你在正常使用的网卡的名称，当然你可以重命名为你喜欢的名字。

另外，后面的 mac 地址应该是这块网卡的硬件地址，如果和 Linux 虚拟系统中的 mac 地址不同，那可能会出现问题，最好重新来过。

```
eth0=pcap-bridge,"本地连接名称",00:11:22:33:44:55
```





通过以下命令查看网卡信息，从返回的结果看，当前的网卡名称叫作 `eth3` 而不是 `eth0` ，这个要注意了，以实际反馈的信息为准哦。

```
$ ip address
```

图a29



有了网卡信息，那么我们接下来修改它的IP地址信息吧。

输入以下命令，开始编辑网卡信息。

```
$ sudo vi /etc/network/interfaces
```

系统配置中默认 `eth3` 是被注释掉的，所以我们将它的注释拿掉，再赋予正确的 IP 地址及网关信息即可。

注意，在最上面 `auto` 一行，别忘记确保有相应编号的 `eth` 。

举例如下：

```
auto lo eth3

iface lo inet loopback

iface eth3 inet static
	address 192.168.2.10
	netmask 255.255.255.0
	gateway 192.168.2.1
```

图a30



设定完成，保存退出，然后执行以下命令使网卡配置生效。

```
# ifdown eth3 && ifup eth3
```

或者重启服务也是可以的。

```
# /etc/init.d/networking restart
```

最后确认网络可 Ping 通。

图a32



除了桥接方式，本身它是可以支持本机网络访问的。

从下图中我们可以看到，在 `CoLinux` 安装完成后，就会自动生成一个虚拟网卡。

图a33



这种情况下，只要将网卡简单配置成 `tuntap` 参数即可。

```
eth0=tuntap
```







镜像源文本

使用中科大镜像源，链接：https://mirrors.ustc.edu.cn/repogen/



先备份原来的镜像源文件 `/etc/apt/sources.list` 。

```
cp /etc/apt/sources.list /etc/apt/sources.list.bak
```



然后再编辑 `/etc/apt/sources.list` ，将以下内容复制到文件中。

```
deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-security main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-updates main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-backports main restricted universe multiverse

## Not recommended
# deb http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-proposed main restricted universe multiverse
# deb-src http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ precise-proposed main restricted universe multiverse
```







### 将 `CoLinux`  注册成服务

确切地说，是将我们设定好的 `Linux` 虚拟系统注册成服务，以便它可以在系统启动的同时加载启动。

这样的好处不言自明，通常 `Linux` 系统也是作为服务器的角色存在于大家的思维中的，那么将这些 `Linux` 系统变成服务自动启动它也是顺理成章的事了。



非常简单，只需加个参数一条命令就可以搞定。

```
colinux-daemon @*.conf --install-service "Linux Name"
```

比如本文中将 `Ubuntu12.04` 注册为服务可以这样子。

```
colinux-daemon @C:\colinux\base.conf --install-service "Ubuntu12.04"
```

图b01



同样非常简单，将 `install-service` 换成 `remove-service` 就可以注销服务。

```
colinux-daemon --remove-service "Linux Name"
```

比如本文中将 `Ubuntu12.04` 再注销掉可以这样子。

```
colinux-daemon --remove-service "Ubuntu12.04"
```

图b02



简单是简单，不过我们还需要注意两点。

一是必须以管理员权限执行命令，注册服务肯定是要有管理员权限的对吧。

二是注销服务不需要加上配置文件参数，并且服务名称务必要与之前注册时的一致。



注册好服务后就可以对服务进行操作了，用命令方式或图形操作方式都可以，完全看你心情啦。

```
net start "Ubuntu12.04"
```

