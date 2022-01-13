Multipass

副标题：

英文：

关键字：







```
Image                       Aliases           Version          Description
core                        core16            20200818         Ubuntu Core 16
core18                                        20211124         Ubuntu Core 18
18.04                       bionic            20220104         Ubuntu 18.04 LTS
20.04                       focal,lts         20220111         Ubuntu 20.04 LTS
21.04                       hirsute           20220106         Ubuntu 21.04
21.10                       impish            20220111         Ubuntu 21.10
appliance:adguard-home                        20200812         Ubuntu AdGuard Home Appliance
appliance:mosquitto                           20200812         Ubuntu Mosquitto Appliance
appliance:nextcloud                           20200812         Ubuntu Nextcloud Appliance
appliance:openhab                             20200812         Ubuntu openHAB Home Appliance
appliance:plexmediaserver                     20200812         Ubuntu Plex Media Server Appliance
anbox-cloud-appliance                         latest           Anbox Cloud Appliance
minikube                                      latest           minikube is local Kubernetes
```



`Multipass` 默认使用 Hyper-V 作为其虚拟化提供程序。

将虚拟化提供程序切换为 `VirtualBox` 。

```
multipass set local.driver=virtualbox
```





```
multipass launch --name vm_name
```





`launch` 参数大概有以下几种。

```
-n, --name: 名称
-c, --cpus: cpu核心数, 默认: 1
-m, --mem: 内存大小, 默认: 1G
-d, --disk: 硬盘大小, 默认: 5G
```



那么命令可以这样写。

```
multipass launch --name vm_name --cpus 1 --mem 1G --disk 10G
```

简写就可以这样写。

```
multipass launch -n vm_name -c 1 -m 1G -d 10G
```



执行虚拟机内部命令。

```
# 执行不带参数的命令
multipass exec vm_name <command>
例：multipass exec vm01 pwd

# 执行带整数的命令
multipass exec vm_name -- <command> <arguments>
例：multipass exec vm01 -- uname -a
```

