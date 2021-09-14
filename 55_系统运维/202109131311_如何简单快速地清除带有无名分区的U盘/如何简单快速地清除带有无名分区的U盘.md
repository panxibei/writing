如何简单快速地清除带有无名分区的U盘

副标题：重置U盘超简单~

英文：

关键字：usb,usboot,udisk,ustick,U盘,efi







```
DISKPART> help clean

     从带焦点的磁盘删除任意和所有分区或格式化卷。

语法:  CLEAN [ALL]

    ALL         指定将磁盘上的每个字节\扇区都设置为 0，这会
                完全删除该磁盘上包含的所有数据。

    在主启动记录(MBR)磁盘上，仅会覆盖 MBR 分区信息和隐藏的
    扇区信息。在 GUID 分区表(GPT)磁盘上，包括
    保护性 MBR 在内的 GPT 分区信息都会被覆盖。如果不使用 ALL 参数，
    则磁盘的第一个 1MB 和最后一个 1MB 都将为零。这将擦除以前应用到
    该磁盘的任何格式化磁盘。清除该磁盘后的磁盘状态为 'UNINITIALIZED'。

示例:

    CLEAN
```





```
select disk 1
clean
```

