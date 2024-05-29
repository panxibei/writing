manjaro

副标题：

英文：

关键字：







默认终端字体比较难看，修改之。

图c01



在终端中执行以下两条命令。

```
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-zenhei
```

图c02

图c03



完成后重新打开终端即可。

图c04



 Arch Linux CN 软件源 

> https://mirrors.ustc.edu.cn/help/archlinuxcn.html



在 `/etc/pacman.conf` 文件末尾添加两行：

```
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

然后请安装 `archlinuxcn-keyring` 包以导入 GPG key。



如果出现以下错误。

```
error: archlinuxcn-keyring: Signature from "Jiachen YANG (Arch Linux Packager Signing Key) " is marginal trust
```

 应该本地信任 farseerfc 的 GPG key 

```
sudo pacman-key --lsign-key "farseerfc@archlinux.org"
```

