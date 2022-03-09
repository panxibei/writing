msconfig

副标题：

英文：

关键字：





```
truncatememory          0x80000000
numproc                 2
quietboot               Yes
usefirmwarepcisettings  Yes
```





```
bcdedit /deletevalue {default} quietboot
bcdedit /deletevalue {default} numproc
bcdedit /deletevalue {default} usefirmwarepcisettings
bcdedit /deletevalue {default} truncatememory
```





手动修改

```
bcdedit /set {default} numproc 4
```

