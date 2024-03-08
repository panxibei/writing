hackBGRT

副标题：

英文：

关键字：





hack



最简单的，我们可以利用 `diskpart` 程序。



挂载 `EFI` 分区，并指定盘符为 `X` 。

```
select disk0
select part 1
assign letter=X
```



卸载 `EFI` 分区。

```
remove letter=X
```

