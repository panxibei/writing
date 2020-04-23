Openfiler安装rpm和gcc

副标题：Openfiler手动安装网卡



Openfiler是基于CentOS6，做了高度精简的网络存储管理程序，就是传说中的一款NAS系统。

手头上有个Buffalo的NAS盘，于是安装了Openfiler玩一玩。

没想到安装好后居然无法识别网卡，坑啊！

网卡无法驱动那还玩什么NAS啊，遂下载相应的驱动程序。

网卡驱动是Marvell的sk98lin，你可以自己搜索下载，懒得找或找不着也可以联系我发你一份。

驱动程序是下载下来了，但由于Openfiler做了高度精简，rpm、gcc及yum都没有安装，而其自带的conary也早已失效。

上官网看了一下，最新2.99版本早在2018年12月似乎就已经停止更新了。

系统的确够老的，难怪识别不了网卡，但这网卡也不是什么新货啊。

无奈之下，只能被迫走上自力更生、艰苦创业的道路。



**<center>- 1 -</center>**

**首先要解决rpm安装的问题。**

使用 `WinSCP` 上传rpm管理器包到 `Openfiler`。

使用 `Openfiler`自带的 `rpm2cpio` 解压rpm包，发现失败。

```shell
shell> rpm2cpio rpm-4.8.0-55.e16.x86_64.rpm | cpio -ivd
```

图1



使用 `7Zip` 双击打开rpm包，经过多次双击后，最终可看到 `usr`等子目录。

把这些目录解压到一个单独的文件夹内，然后上传到Openfiler的根目录下。

图2



追加rpm的可执行属性。

```shell
shell> chmod a+x /bin/rpm
```



执行rpm，出现无法加载 `librpmbuild.so.1` 的错误。

图3



在163镜像源中找到相应的rpm包，使用 `7Zip` 打开rpm包再多次双击（同前），把多个目录上传到openfiler根目录下。

（网易开源镜像站：http://mirrors.163.com/centos/6/os/x86_64/Packages/）

再次运行rpm，发现还有其他共享库文件未能加载。

按照以上方法依次地、不厌其烦地找到这些库文件包，解压上传即可。



再再次运行rpm，提示库文件尺寸太小。

**按提示依次删除0字节库文件，然后做实际库文件的链接。**

```shell
shell> rm -f /usr/lib64/librpmbuild.so.1
shell> ln -s /usr/lib64/librpmbuild.so.1.0.0 /usr/lib64/librpmbuild.so.1
```

图4



最后执行rpm，终于正常显示版本号。

图5



挺能折腾的是不？还没完。





**<center>- 2 -</center>**

**RPM安装好后就可以安装GCC啦。**

我这有现成的rpm包，把这些包复制到一个目录内，批量安装。

```shell
shell> rpm -ivh ./*.rpm --nodeps
```

rpm包数量太多，我收集打包了53个包（也有YUM），想要的小伙伴可以联系我。

图6



尝试安装网卡驱动程序，提示 `GCC` 版本错误？

你这么低的版本让我到哪里去找呢，不能忍啊！

图7



仔细一瞧，下面有这么一行，尝试输入之。

```shell
shell> export IGNORE_CC_MISMATCH=1
```

嘎嘎，再安装就OK了！

图8



查看yum版本，状态OK。

图9



但要是能真正使用，可能还要设置正确的yum源，时间关系就不多说了，以后有空再说吧。



**微信公众号：网管小贾**