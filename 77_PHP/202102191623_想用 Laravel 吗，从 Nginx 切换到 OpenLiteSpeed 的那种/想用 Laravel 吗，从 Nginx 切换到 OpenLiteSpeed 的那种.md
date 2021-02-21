想用 Laravel 吗，从 Nginx 切换到 OpenLiteSpeed 的那种

副标题：亲，这边建议您使用 OLS + Laravel 组合呢~





### OpenLiteSpeed 简介

OpenLiteSpeed （以下简称 `OLS` ）是和 Apache 或 Nginx 相似的 WEB 服务引擎，是 LiteSpeed EnterPrise 的社区版本。

`OLS` 好处多多，不仅仅提供了诸如 `WordPress` 、 `Joomla` 、`OpenCart` 或 `Drupal` 等应用的插件支持，而且还支持新一代的 `HTTP3` 。

虽然社区版的 `OLS` 与企业版相对有部分限制功能，但一般的个人博客或小型站点基本够用。

你看看 `OLS` 与 `Nginx` 和 `Apache` 的性能对比，我可以猜到你肯定先是大吃一鲸，然后口水横流。

图？



好吧，我承认流口水的是我，所以接下来我就开始尝试安装使用它了。



> 官网链接：https://openlitespeed.org
>
> 知识库链接：https://openlitespeed.org/kb/



### OpenLiteSpeed 的安装



> 安装环境：CentOS 7 (2009)



网上铺天盖地都是如何一键安装 `OLS` ，如果你的应用是 `wordpress` ，那么倒可以参考参考，因为一键安装可以连带 `wordpress` 及其插件一股脑儿地全部搞定。

可是，我虽然是个小白，但我同时又是个完美强迫症，在这里我只用最简单、直接的方法来安装。

是的，我要用的正是官方建议的二进制包安装方法。

链接：https://openlitespeed.org/kb/install-from-binary/



注意，安装时需要管理员权限。

先将二进制包下载下来，可以到下载页上下载，也可以直接使用 `wget` 。

```
wget https://openlitespeed.org/packages/openlitespeed-1.7.8.tgz
```



我安装的是官方最新版本 `1.7.8` ，这个包大概 71.6 MB，官网下载比较慢，为了方便小伙伴们，在这我留个国内的备用下载链接。

**openlitespeed-1.7.8.tgz**

下载链接：https://



下载好了就可以安装了，很简单。

```
tar -zxvf openlitespeed-1.7.8.tgz
cd openlitespeed
./install.sh
```

图？

图？



全程自动下载、自动安装，请耐心等待。

安装完成后你就可以看到这句话，表明安装成功，就是这么简单。

```
Installation finished, Enjoy!
```

图？



这时你需要注意一点，安装程序在最后给出了一个 `WebAdmin` 的访问密码，如图中的红字。

```
Your webAdmin password is M2YzM2U2, written to file /usr/local/lsws/adminpasswd.
```

如果你不小心忘记把它记下来了，那么也别担心，可以在 `/usr/local/lsws/adminpasswd` 中找到它。

至于 `WebAdmin` 是什么、怎么用，等一会儿后面会有详细介绍，你先记住这个密码吧。

图？





别看安装如此简单，实际上它已经完成了95%以上的任务。

根据以往的 `Apache` 或 `Nginx` 等安装经验，我们接下来应该安装 `PHP` 对不对？

其实它已经好好地躺在系统里了，目前最新版本可支持到 `7.4` 及 `8.0` 。

在安装过程中我们也能观察到，它偷偷帮你装了 `lsphp74` 。

图？



使用终端命令查看 `PHP` 版本。

图？



使用 `phpinfo` 查看更多 `php` 及其扩展的支持信息。

图？



太棒了，我正需要 `PHP 7.4` ，要知道 `7.3` 将于2021年年底终止支持哦！

当然，如果你完全可以安装多个版本的 `PHP` ，那样就可以自由切换不同的版本环境用于测试了。

你可以参考官方的相关知识库，或者有机会的话我会另外写一篇文章专门说一说如何安装多个版本的 `PHP` 。



`PHP` 有了，接着如果你想加载更多的 `php` 扩展，那么可以手动添加它们。

比如想添加 `redis` 扩展，那么应该这样子做。

```
yum install lsphp74-pecl-redis
```

图？

图？



具体每个扩展包的名称可能与以往传统的有所不同，可以通过 `yum search` 查询来确定。

此外，因为我们是按二进制包的安装方法，所以在安装过程中系统已经自动具有 `OLS` 官方的安装源，因此可以直接找到并安装相应的扩展。

如果系统中没有官方安装源，则可以手动添加，以 `CentOS7` 为例如下。

```
rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm
```

不同平台具体可以参考：

```
https://openlitespeed.org/kb/install-ols-from-litespeed-repositories/
```





### OpenLiteSpeed 的服务

在 `CentOS` 下， `OLS` 的服务名称为 `lshttpd` ，所以可以这样查看它的服务。

```
systemctl status lshttpd
```



它还有一个别称 `lsws` ，所以也可以这样查看它的服务。

```
systemctl status lsws
```



那么我们就可以随意启动、停止或启用禁用 `OLS` 服务了。

```
# 启用/禁用服务
systemctl enable lsws
systemctl disable lsws

# 启动/停止服务
systemctl start lsws
systemctl stop lsws
```

图？



服务启动完毕，我们就可以登录 `WebAdmin` 了。

```
https://服务器名称或IP:7080
```



还记得前面让你记住的那个密码吗？

对了，就在这里登录 `WebAdmin`  用的，登录进入系统后可以自行修改密码。

图？



还是那句话，如果你忘记了这个初始密码，可以用下面这个命令来查看。

```
cat /usr/local/lsws/adminpasswd
```



登录进 `WebAdmin` 后，我们可以点击右上角的语言选项，将它改为中文。









### OpenLiteSpeed 的各项配置

`OLS` 我们已经安装好了，那么它被安装在哪里了呢？

如果你是按照前面二进制的方法安装的，那么 `OLS` 的根目录是 `/usr/local/lsws` 。

一定要记住这个，因为之后所有的配置、缓存、应用统统都以这个根目录为基础。



OK，接下来自然是配置文件，大体有两种。

第一种，是 `OLS` 服务器主配置文件。

它放在了 `/usr/local/lsws/conf/` 下面，名字叫 `httpd_config.conf` 。

```
/usr/local/lsws/conf/httpd_config.conf
```



第二种，是虚拟主机的配置文件。

在根目录下专门有个放虚拟主机配置的目录 `/usr/local/lsws/conf/vhosts/` ，不同的虚拟主机则以其名称为子目录分别保存自己相应的配置文件。

比如我们安装好 `OLS` 后它自带有一个叫做 `Example` 的虚拟主机，那么它的配置文件就在这儿。

```
/usr/local/lsws/conf/vhosts/Example/vhconf.conf
```



不管是服务器主配置文件也好，还是虚拟主机配置文件也好，其中参数众多，设定纷繁复杂。

还好有个好消息，我们不必自己动手修改这些配置文件。

在 `OLS` 安装完毕后，我们就已经拥有了一个 `WebAdmin Console` 的 WEB 形式的控制面板，这也是官方建议的最佳配置编辑方法。

它除了帮助我们免于记忆复杂的参数语法外，我感觉有一个点对来我们很有用的就是可以一键平滑重启服务。

`WebAdmin` 的访问链接：`https://servername:7080/`





### 导入 Laravel 项目









```
chown -R nobody:nobody storage
chown -R nobody:nobody bootstrap/cache
```

