Linux版Microsoft Edge新鲜出炉，来尝尝味道怎样~

副标题：终于还是来了，等的就是你~







对于Linux用户来说，直接安装 `.deb` 或 `.rpm` 包显得不那么潇洒专业。

还是来个在线下载安装吧。

接下来就是要解决两个问题，即从哪里下载，如何安装两个问题了。

从哪里下载：

当然是从微软的Linux软件仓库下载了。





如果你用的是 `CentOS7` ，那么它默认是没有安装 `dnf` 的，所以需要先安装 `dnf` 。

```shell
# yum install epel-release
# yum install dnf
```



我用的是 `CentOS8` ，默认已经包含 `dnf` 了。

我们可以直接开始。



```shell
### 下载并导入 Microsoft 的 GPG 公钥
$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

### 添加程序安装源
$ sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge

### 修正安装源的文件名称
$ sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-dev.repo

### 开始安装
$ sudo dnf install microsoft-edge-dev
```



以下是安装时的截图。

开始安装 `Microsoft Edge Dev` ，输入 `y` 继续安装。

图5



提示验证公钥是否OK，大胆按下 `y` 后回车。

图6



开始下载安装了，看你的网速，等待一定的时间后安装结束，可以看到我的 `Microsoft Edge Dev` 版本是 `88` 。

图7



安装好了，让我们打开看看吧。

哎，怎么桌面上没有啊，你当是 `Windows` 呢？

好吧，打开 `所有程序` ，果然 `Microsoft Edge Dev` 好端端地躺在里面，双击打开它吧！

图8



依次找到 `Settings` > `About Microsoft Edge` ，可查看关于信息。

似乎没有看到哪里写着版本信息啊，毕竟是刚出来的版本，可能将来更新完善后会有。

图9























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