UrBackup论坛帖：无法添加Linux客户端

副标题：UrBackup论坛帖：无法添加Linux客户端

英文：urbackup-forum-posts-unable-to-add-linux-client

关键字：urbackup,forum,posts,linux,client



`UrBackup` 是一款非常优秀的开源免费的备份工具软件，可跨多个平台使用，部署灵活方便。

虽然在中国 `UrBackup` 普及度不高，但在欧美日等多个国家却早已应用广泛。

然而 `UrBackup` 官方网站是英文界面，其论坛也是全英文的，这给想了解它的朋友们带来了一定的困扰。

因此为了方便更多的小伙伴们学习和使用 `UrBackup` ，除了制作一些中文教程之外，我特意将论坛中一些有用的、通过网友实际验证过的帖子翻译成小作文提供给大家！

希望小伙伴们喜欢这样的形式，同时如果您有兴趣，也可以加我微信（sysadm-cc）、加入学习交流群——网管小贾的 `UrBackup` 俱乐部。



#### 主题：无法添加Linux客户端（/usr/local/var/urbackup/pw.txt）

> 分类：客户端
>
> 日期：2023年7月9日
>
> 链接：https://forums.urbackup.org/t/unable-to-add-linux-client-usr-local-var-urbackup-pw-txt/13094



**#1 TopHatProductions115**

我最近将 `UrBackup` 服务器安装到 `Windows Server 2019` 虚拟机上。

我能够访问“状态”页，并且已指定备份存储路径。



我还将客户端安装到基于 `Arch` 的虚拟机上（通过 `AUR` ）。

客户端和服务器位于同一 `LAN` 上，我可以从一个 `VM` 对另一个 `VM` 执行 `ping` 操作以验证网络连接。



可是，我的第一个客户端连接到服务器时遇到了一些困难。

当我在客户端虚拟机上输入 `urbackupclientctl` 状态时，我收到以下内容：

> ➜  ~ urbackupclientctl status
> urbackupclientctl: No such file or directory
> Cannot read backend password from /usr/local/var/urbackup/pw.txt



尝试对 `urbackupclientctl` 命令使用其他选项时会出现相同的错误。



我还尝试转到“状态”页面，选择“下载适用于 `Linux` 的客户端”，并在客户端 `VM` 上运行下载的脚本。

但是，这也没有解决问题。

该脚本似乎假定客户端虚拟机正在运行 `RHEL` 。

我不知道如何补救。



当我输入 `urbackupclientgui` 时，我收到这个：

>➜  ~ urbackupclientgui
>Could not load password file!



在网上找了三圈后，我看到了这样一条线索：

>Cannot read backend password from /usr/local/var/urbackup/pw.txt



这似乎并不是答案。

我真的很想将来使用这个 `UrBackup` 。

但是，如果我无法解决此初始配置问题，则无法接着使用它。

有没有人遇到过并解决了这个问题？ 



> 由 `TopHatProductions115` 在帖子 #6 中解决
>
> 我会看看我能做些什么。
>
> 但我也注意到，我无法让代理/客户端自动启动。
>
> 我认为，如果我不在所有情况下都使用 `systemd` ，那我就倒霉了。



**#2 TopHatProductions115**

 我也尝试运行 `urbackupclientctl` 设置，并收到以下错误消息： 

> ➜  urbackup urbackupclientctl set-settings --name <VM_NAME> --server-url <SERVER_NAME> --authkey <AUTH_KEY>
> urbackupclientctl: No such file or directory
> Cannot read backend password from /usr/local/var/urbackup/pw_change.txt



我可以通过在提到的目录中创建名为“pw.txt”和“pw_change.txt”的空文件来解决此问题吗？

以前的用户似乎尝试过类似的东西，但无济于事...... 



**#3 bedna**

> TopHatProductions115:
>
> urbackupclientctl: No such file or directory

几天前，我在功能请求中谈到了这一点。（我正在做从树莓派移动到 `Manjaro-arm` 的测试）

**没有**名为 `urbackupclientctl` 的目录，它是一个二进制文件的名称，搞错了吧？（进一步查看我对这个二进制文件的了解）

从源代码编译时，服务器和客户端都使用**相同的**目录（我在使用 `aur` 时遇到错误，所以我从源代码编译，但它们可能使用相同的 `./configuration` ）并在同一台机器上安装二进制客户端。

一团糟。

两者都使用“urbackup”作为他们的目录 `/usr/local/var/urbackup` 。

在我的树莓派操作系统上，服务器至少安装到 `/var/urbackup` ，保持文件分离。

这可能与此有关，但我并不是绝对的确定。

我的 `urbackupclient` 后端二进制文件的在路径 `/usr/local/sbin/urbackupclientbackend` 中。
如果我在安装时将前缀更改为使用 `/usr/` ，二进制文件将拒绝安装，但在安装时不会出现错误或警告！

不过，其他二进制文件会安装在 `/usr/bin` 中。

你也会这样吗？

`which urbackuplientbackend` 显示什么？



**#4 TopHatProductions115**

> **没有**名为 `urbackupclientctl` 的目录，它是一个二进制文件的名称，搞错了吧？（进一步查看我对这个二进制文件的了解）

`urbackupclientctl` 二进制文件就在那里，只是说文件不存在。

/usr/local/var/urbackup/pw_change.txt/usr/local/var/urbackup/pw.txt



> 在我的树莓派操作系统上，服务器至少安装到 `/var/urbackup` ，保持文件分离。
>
> 这可能与此有关，但我并不是绝对的确定。

我只在正在进行故障排除的 `Linux` 虚拟机上安装了客户端。

在我的设置中，服务器位于另一个虚拟机上。



> `which urbackuplientbackend` 显示什么？

我必须在几个小时内进行测试。

我会让你知道我发现了什么。





**#5 bedna**

> 我必须在几个小时内进行测试。
>
> 我会让你知道我发现了什么。

OMFG，我刚刚意识到我们正在谈论两件完全不同的事情。

我应该在睡觉时停止打字。

我对此没有任何意见，哈哈，您谈论的是 `urbackupclientCTL` 和 `GUI` ，我从不使用它们中的任何一个。

我的服务器是 `headless` 的，所以...

从我从阅读论坛上关于客户端设置如何创建奇怪行为的其他帖子中了解到的情况来看，服务器端设置是我一直在做的事情。

很抱歉造成混乱。

但也许只是尝试创建文件。

问题是它们应该包含什么。





**#6 TopHatProductions115**

我会看看我能做些什么。

但我也注意到，我无法让代理/客户端自动启动。

我认为，如果我不在所有情况下都使用 `systemd` ，那我就倒霉了。



**#7 bedna**
我对你的帖子有点困惑。

在服务器的 `web` `gui` 上进行的所有设置不起作用吗？

我的意思是不要使用 `urbackupblientctl` ，而是设置客户端自动采用的所有服务器端内容。

这不行吗？





**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc