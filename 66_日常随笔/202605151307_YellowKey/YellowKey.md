YellowKey

副标题：

英文：

关键字：





1、找个U盘，格式化成 `NTFS/FAT32/exFAT` 都可以，当然我这儿用的是 `FAT32` 格式，因为更常用。



2、将 `FsTx` 文件夹（文末下载）复制到U盘的以下路径中。

```
U盘盘符:\System Volume Information\
```

`System Volume Information` 是U盘上自动生成的 `Windows` 的系统卷信息文件夹，通常是隐藏的，并且可能没有权限而无法直接访问。

可以用一些第三方磁盘工具软件将 `FsTx` 文件夹复制到 `System Volume Information` 中。



最后，如果你的U盘盘符是F盘，那么应该是这样的。

```
F:\System Volume Information\FsTx
```



3、重启电脑到 `WinRE` 环境。

这个 `WinRE` 环境是指 `Windows` 自带的恢复代理环境，是用来修复自身系统的，类似于 `WinPE` 。

可以这样操作：

按住 `SHIFT` 键 → 用鼠标点击 `开始` 菜单中的 `重启` → 快速放开 `SHIFT` 键并按住 `CTRL` 键不放。



4、没有问题的话，会自动触发进入 `SYSTEM` 权限的命令行，从而绕过 `Bitlocker` 。

只要有了最高权限的命令行界面，那么接下来想干什么就不用我多说了吧！

图



5、一旦成功绕过，原来的U盘上的 `FxTx` 文件夹会自动被删除。







**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc