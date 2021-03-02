虚拟机平台 CentOS 迁移网卡故障一例

副标题：







由 `vdi` 镜像转换得到 `vmdk` 格式的镜像文件。







```
less /var/log/messages
```

`Shift+g` 移动到最后一行。



enp0s3 -> ens192

```
cd /etc/sysconfig/network-scripts
mv ifcfg-enp0s3 ifcfg-ens192
```

同时将 `ifcfg-ens192` 文件中的网卡名称修改成 `ens192` 。

```
DEVICE=ens192
```



再次重启网络服务

```
systemctl restart network
```



