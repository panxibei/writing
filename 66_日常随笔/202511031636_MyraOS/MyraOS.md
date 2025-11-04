MyraOS

副标题：

英文：

关键字：









需要 `Qemu` 来模拟运行 `MyraOS` 。

在 `Windows` 上安装 `Qemu` 。

图a01



安装完成后，最好添加环境变量，方便运行 `Qemu` 执行程序。

图a02



将 `MyraOS` 中的 `fs.img` 和 `MyraOS.iso` 两个文件解压到某个文件夹内，比如：

```
C:\MyraOS\fs.img
C:\MyraOS\Myraos.iso
```

图a03



一切准备就绪，开始尝试运行。



窗口模式下运行：

```
qemu-system-i386 -cdrom C:\MyraOS\MyraOS.iso -drive file=C:\MyraOS\fs.img,format=raw,if=ide,index=0 -m 1024
```



全屏模式下运行：

```
qemu-system-i386 -cdrom C:\MyraOS\MyraOS.iso -drive file=C:\MyraOS\fs.img,format=raw,if=ide,index=0 -m 1024 -display gtk,zoom-to-fit=on -full-screen
```



务必要注意前面说的那两个文件的路径。



运行起来了。

和一般 `Linux` 发行版的启动画面差不多。

图a05



可能连一秒都不需要，启动完成了？

图b01



乱点了半天，没有任何反应。

桌面上只有一个 `Doom` 的图标，运行之。

图b02



这个游戏居然能玩！



