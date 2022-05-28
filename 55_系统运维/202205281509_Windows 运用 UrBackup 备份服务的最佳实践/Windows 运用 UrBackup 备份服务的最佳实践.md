Windows 运用 UrBackup 备份服务的最佳实践

副标题：

英文：

关键字：







专用备份分区（盘）



格式化备份分区（盘）。

```
# 格式化命令语法
# /V:Label 分区卷标
# /Q 快速格式化
# /FS:NTFS 文件系统NTFS
# /L:enable 强制使用较大的文件记录，可简写为 /L
Format <Drive:> /V:Label /Q /FS:NTFS /L:enable
```



以当前为例，格式化 `D` 盘。

```
Format D: /V:UrBackup /Q /FS:NTFS /L
```

