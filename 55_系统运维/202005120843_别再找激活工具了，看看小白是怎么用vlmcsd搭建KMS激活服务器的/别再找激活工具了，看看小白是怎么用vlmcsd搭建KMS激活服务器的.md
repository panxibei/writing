别再找激活工具了，看看小白是怎么用vlmcsd搭建KMS激活服务器的

副标题：什么年代了，还用激活工具？



> 微信公众号：@网管小贾
>
> 个人博客：@www.sysadm.cc



使用Windows和Office的你还在满世界找激活工具吗？

如果是，那你太OUT了！

简单动动手，自己搞个激活服务器吧。

可以利用普通电脑、 路由器或手机等等搭建激活服务器。

对，你没看错，很神奇吧？

跟着我走，只需三步，小白也能搞定哦！



先来说说我们要用到的`vlmcsd` 是个什么东东。看图：

图1



`vlmcsd` 是大佬 HOTBIRD 研究出来的模拟类似于微软KMS的服务程序。

可以应用于几乎所有的操作系统平台，什么Windows、Linux、BSD，包括苹果Mac或Andriod都没问题。

很强大有么有？

关键是它不会像传统激活工具那样经常被杀毒软件干掉！

很酷吧！

以下是官方描述（我把它翻译了一下）：

>**`vlmcsd` 是**
>
>1. 微软KMS服务器的替代品
>
>2. 它包含 `vlmcs`，一个KMS测试客户端，主要用于调试，可以作为一个正版KMS服务器的补充
>
>3. 被设计为运行在常开设备上，例如路由器、NAS网盘等等
>
>4. 用于帮助因硬件（主板、CPU等）变动而失去合法许可证激活的人员
>
>**`vlmcsd` 不是**
>
>1. 一键激活或破解工具
>
>2. 用于激活软件的非法副本（Windows、Office、Project、Visio）



在安装使用之前，我们需要先下载它。

下载包不大，但这里还是要提醒一下，官网下载是放在一个叫 `upload.ee` 的网盘上的，速度巨慢，还经常掉线，反正我用了两个钟头也没有下载下来。

还好这个时代有 `Github` ，找到了 `https://github.com/Wind4/vlmcsd` 。

虽然 `Github` 上下载的包和官网上的不太一样，但不影响我们使用的。

我这存了一份2020年最新版，想下得快点的小伙伴请自取。

下载链接：binaries.tar.gz



我们先用Linux系统做例子，用Windows系统其实也是一样的。



**第一步，随便找个系统（比如 `CentOS7`），把压缩包解压后放到某个目录中（比如：`/vlmcsd`）。**

在目录中找到文件 `vlmcsd-x64-glibc` ，如果你用的是32位系统，那么应该找 `vlmcsd-x86-glibc`。

它应该是这个样子：

```shell
shell> /vlmcsd/binaries/Linux/intel/glibc/vlmcsd-x64-glibc
```



**第二步，给它追加执行权限，并重命名为 `vlmscd`，像这样：**

```shell
shell> chmod u+x vlmcsd-x64-glibc
shell> mv vlmcsd-x64-glibc vlmcsd
```



**第三步，执行命令，像这样：**

```shell
shell> ./vlmcsd
```



OK！一二三，欧了！你没看错哦，搞定，简单不！

当然，还有测试一步，也很简单啊！

**在Windows环境中，找到下载压缩包中的客户端测试程序并运行，它应该是这个样子：**

```powershell
# -v 输出详细信息
# -l 3 表示发送 Windows Server 2008 Datacenter 的激活请求，具体版本对应列表可以通过vlmcs.exe -x查看
# x.x.x.x 表示服务器的IP地址或主机名称或域名
cmd> binaries\binaries\Windows\intel\vlmcs-Windows-x64.exe -v -l 3 x.x.x.x
```

注意啦，文件名千万不要找错哦，`vlmcs` 后面是没有字母 `d` 的，有 `d` 的文件是服务程序的意思哦！

另外啰嗦一句，32位的请找 `vlmcs-Windows-x86.exe`。



怎么样？激活成功了吗？成功激活类似于这个样子：

```powershell
cmd>vlmcs-Windows-x64.exe -l 3 127.0.0.1
Connecting to 127.0.0.1:1688 ... successful
Sending activation request (KMS V6) 1 of 1  -> 03612-00206-562-301419-03-5124-17763.0000-0252020 (3A1C049600B60076)
```

实际激活Windows，应该使用管理员权限执行以下命令：

```powershell
slmgr.vbs /skms x.x.x.x    # 设置kms服务器
slmgr.vbs /ato    # 激活
slmgr.vbs /xpr    # 查看激活时效
```



好了，如果你想用Windows做服务器，那么只要找到压缩包中Windows目录中的服务程序并运行它就可以了，和Linux并无太大差别。

除Linux和Windows外，其他诸如Mac等平台也可以自由安装。

很多人安装在安卓或NAS甚至路由器上，都可以很稳定地工作。

当然，有的人很懒，用docker实现，这么简单还用docker，我想搭建个docker环境也有点麻烦不是吗？

另外，需要注意，想要激活的Windows客户端应该使用VL版本，对于如何激活Office，网上也有很多相关内容，请自行搜索吧。



坚持写小白也能懂的文章，应用为王，欢迎留言！

> 微信公众号：@网管小贾
>
> 个人博客：@www.sysadm.cc

