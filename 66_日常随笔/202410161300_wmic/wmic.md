





添加 `WMIC` 。

```
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
```



删除 `WMIC` 。

```
DISM /Online /Remove-Capability /CapabilityName:WMIC~~~~
```



挂载 `Windows` 系统安装镜像，通过镜像来安装。

```
DISM /Online /add-Capability /CapablilityName:WMIC~~~~ /Source:wim:D:\Sources\Install.wim:6
```



```
dism /mount-image /imagefile:C:\install.wim /mountdir:C:\mount /Index:6
```



