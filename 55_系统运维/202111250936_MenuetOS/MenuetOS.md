MenuetOS

副标题：

英文：

关键字：



MenuetOS



将 `ISO-header` 与 `Menuet` 镜像文件合并，生成可引导的 `ISO` 镜像文件。

```
; /b 表示以二进制方式进行操作
copy /b isohdr + MenuetImage.img mboot.iso
```

图a04



说实话，以前学 `copy` 这个命令的时候，也就简单地合并过两个文本文件，没想到多年之后的今天，居然见识到了还可以这样合并引导文件。