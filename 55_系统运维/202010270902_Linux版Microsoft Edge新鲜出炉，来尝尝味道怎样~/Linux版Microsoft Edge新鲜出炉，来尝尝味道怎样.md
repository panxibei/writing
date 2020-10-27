Linux版Microsoft Edge新鲜出炉，来尝尝味道怎样~

副标题：终于还是来了，等的就是你~







对于Linux用户来说，直接安装 `.deb` 或 `.rpm` 包显得不那么潇洒专业。

还是来个在线下载安装吧。

接下来就是要解决两个问题，即从哪里下载，如何安装两个问题了。

从哪里下载：

当然是从微软的Linux软件仓库下载了。



**在 Debian/Ubuntu 上安装**

>设置微软存储库
>
>```shell
>curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
>sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
>sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
>sudo rm microsoft.gpg
>```

>安装 Microsoft Edge Dev
>
>```
>sudo apt update
>sudo apt install microsoft-edge-dev
>```



一旦安装了Microsoft Edge，您可以通过运行sudo apt update手动更新，然后sudo apt  upgrade（更新所有包），或sudo apt install microsoft-edge-dev（仅更新Microsoft Edge  Dev）。



要卸载Microsoft Edge, 在终端运行以下命令:

```
sudo apt remove microsoft-edge-dev
sudo rm -i /etc/apt/sources.list.d/microsoft-edge-dev.list
```



**在Fedora上安装**

首先，设置微软的仓库。

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge
```

接下来，安装Microsoft Edge：

```
sudo dnf install microsoft-edge-dev
```

要卸载，运行：

```
sudo dnf remove microsoft-edge-dev
```