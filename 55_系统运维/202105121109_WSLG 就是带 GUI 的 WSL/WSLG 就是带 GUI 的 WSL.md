WSLG 就是带 GUI 的 WSL

副标题：

英文：

关键字：







```powershell
# 启用适用于 Linux 的 Windows 子系统
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# 启用虚拟机平台
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 启用 Hyper-V 虚拟功能
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
```









```shell
# 备份 ubuntu 默认官方源
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
# 新建国内自定义源
sudo vi /etc/apt/sources.list
```



```shell
sudo apt-get update
```



```
sudo apt-get install gedit
```



