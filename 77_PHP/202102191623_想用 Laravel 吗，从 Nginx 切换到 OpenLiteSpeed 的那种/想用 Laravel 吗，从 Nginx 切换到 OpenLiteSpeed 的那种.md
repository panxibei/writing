想用 Laravel 吗，从 Nginx 切换到 OpenLiteSpeed 的那种

副标题：亲，这边建议您使用 OLS + Laravel 组合呢~





### OpenLiteSpeed 是个啥

OpenLiteSpeed （以下简称 `OLS` ）是和 Apache 或 Nginx 相似的 WEB 服务引擎，是 LiteSpeed EnterPrise 的社区版本。

`OLS` 好处多多，不仅仅提供了诸如 `WordPress` 、 `Joomla` 、`OpenCart` 或 `Drupal` 等应用的插件支持，而且还支持新一代的 `HTTP3` 。

虽然社区版的 `OLS` 与企业版相对有部分限制功能，但一般的个人博客或小型站点基本够用。

你看看 `OLS` 与 `Nginx` 和 `Apache` 的性能对比，我可以猜到你肯定先是大吃一鲸，然后口水横流。

图？



好吧，我承认流口水的是我，所以接下来我就开始尝试安装使用它了。



> 官网链接：https://openlitespeed.org
>
> 知识库链接：https://openlitespeed.org/kb/



### 安装 OpenLiteSpeed 很简单



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



这时你需要注意一点，安装程序在最后给出了一个 `WebAdmin` 的初始访问密码，如图中的红字。

```
Your webAdmin password is M2YzM2U2, written to file /usr/local/lsws/adminpasswd.
```

如果你不小心忘记把它记下来了，那么也别担心，可以在 `/usr/local/lsws/adminpasswd` 中找到它。

至于 `WebAdmin` 是什么、怎么用，等一会儿后面会有详细介绍，你先记住这个密码吧。

图？



### 安装 PHP



##### a、怎么安装 php

别看安装如此简单，实际上它已经完成了95%以上的任务。

根据以往的 `Apache` 或 `Nginx` 等安装经验，我们接下来应该安装 `PHP` 对不对？

其实它已经好好地躺在系统里了，目前最新版本可支持到 `7.4` 及 `8.0` 。

在安装过程中我们也能观察到，它偷偷帮你装了 `lsphp74` 。

图？



##### b、添加 php 可执行文件到系统路径中

实际上我们得到的 `php` 执行文件并不能在任何目录下直接执行，这就很不方便了 。

因此我们需要动动手，将它链接成 `php` 这个名字，并将其加入到系统路径中。

```
# 编辑 /etc/profile 文件
vim /etc/profile

# 在文件最后添加一行
export PATH="/usr/local/lsws/lsphp74/bin:$PATH"

# 重新加载
source /etc/profile
```



##### c、扩展

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







最后使用终端命令查看 `PHP` 版本。

图？



再使用 `phpinfo` 查看更多 `php` 及其扩展的支持信息。

图？



很棒对不对，我正需要 `PHP 7.4` ，要知道 `7.3` 将于2021年年底终止支持哦！

当然，如果你完全可以安装多个版本的 `PHP` ，那样就可以自由切换不同的版本环境用于测试了。

你可以参考官方的相关知识库，或者有机会的话我会另外写一篇文章专门说一说如何安装多个版本的 `PHP` 。









### 安装 MariaDB

几乎任何项目都少不了数据库，在这里虽然我们只是作为演示，但还是尝试安装最新版本的 MariaDB 。

我们采用安装源的方式来安装 `MariaDB` ，找到相应平台及所需版本，按给出的信息保存安装源文件。

我们要在 `CentOS 7` 上安装 `MariaDB 10.5` ，所以将以下内容保存到 `/etc/yum.repo.d/MariaDB.repo` 。

```
# MariaDB 10.5 CentOS repository list - created 2021-02-21 04:48 UTC
# https://mariadb.org/download/
[mariadb]
name = MariaDB
baseurl = https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/10.5/centos7-amd64
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/RPM-GPG-KEY-MariaDB
gpgcheck=1
```



然后执行安装命令即可开始安装。

```
yum install MariaDB-server MariaDB-client
```

图？



当然了，如果你直接在 `CentOS` 上执行 `yum` 安装命令也是可以的，只不过获得的并不一定是最新版本。

之后就是配置数据库，因为这不是本文重点，所以就不在此赘述了。



### 了解一下 OpenLiteSpeed 服务

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









### OpenLiteSpeed 大概有哪些配置

`OLS` 我们已经安装好了，那么它被安装在哪里了呢？

如果你是按照前面二进制的方法安装的，那么 `OLS` 的根目录是 `/usr/local/lsws` 。

一定要记住这个根目录，因为之后所有的配置、缓存、应用统统都以这个根目录为基础。



OK，接下来自然是配置文件，大体分为两种。

**第一种，是 `OLS` 服务器主配置文件。**

它放在了 `/usr/local/lsws/conf/` 下面，名字叫 `httpd_config.conf` 。

```
/usr/local/lsws/conf/httpd_config.conf
```



**第二种，是虚拟主机的配置文件。**

在根目录下专门有个放虚拟主机配置的目录 `/usr/local/lsws/conf/vhosts/` ，不同的虚拟主机则以其名称为子目录分别保存自己相应的配置文件。

比如我们安装好 `OLS` 后它自带有一个叫做 `Example` 的虚拟主机，那么它的配置文件就在这儿。

```
/usr/local/lsws/conf/vhosts/Example/vhconf.conf
```



不管是服务器主配置文件也好，还是虚拟主机配置文件也好，其中参数众多，设定纷繁复杂。

还好有个好消息，我们不必自己动手修改这些配置文件。

在 `OLS` 安装完毕后，我们就已经拥有了一个 `WebAdmin Console` 的 WEB 形式的控制面板，这也是官方建议的最佳配置编辑方法。

它除了帮助我们免于记忆复杂的参数语法外，我感觉有一个点对来我们很有用的就是可以一键平滑重启服务。





### 对小白友好的 WebAdmin 控制台



`OLS` 服务一旦启动完毕，我们就可以登录 `WebAdmin` 了。

```
https://ServerName_Or_IP:7080
```



还记得前面让你记住的那个密码吗？

对了，就在这里登录 `WebAdmin`  用的，登录进入系统后可以自行修改密码。

图？



还是那句话，如果你忘记了这个初始密码，可以用下面这个命令来查看。

```
cat /usr/local/lsws/adminpasswd
```



登录进 `WebAdmin` 后，我们可以点击右上角的语言选项，将它改为中文。

图？



找到左侧导航 `管理控制台设置` > `常规` > `用户` ，可修改管理员密码。

图？



要是记性不好，连修改后的密码都给忘了咋办？

好办，使用命令来重置密码。

```
/usr/local/lsws/admin/misc/admpass.sh
```

图？



好了，说到这儿必须要强调一下，当我们进入 `WebAdmin` 后所做的一些修改变动，如果要使其生效，必须要重启服务。

想到每次输命令来重启就好烦啊，不过好在 `WebAdmin` 很贴心啊，它提供了平滑重启功能，点一下右上角的那个绿色小按钮就可以了。

图？





### 如何导入 Laravel 项目

到这儿总算是该敲黑板、划重点了，因为这里多多少少会有些坑。

作为演示，我只将原来的项目整体地迁移到 `OLS` 上，所以大致可以按以下几步去走。



#### 1、创建虚拟主机

`OLS` 安装完成后默认会有一个名叫 `Example` 的虚拟主机，它可以作为参考看看，我个人不建议直接拿它来用。

那么我们最好是自己新建一个，当然了不需要去编辑晦涩难懂的配置文件，直接在控制台上点鼠标就可以了。



**a、创建目录**

不过在开始点点点之前，我们要先新建一些虚拟主机必要的目录。

假定我想新建一个名叫 `sysadm.local` 的虚拟主机，那么我至少要建立三个相关的目录，分别是 `conf` 、 `html` 和 `logs` 。

```
cd /usr/local/lsws
mkdir -p sysadm.local/{conf,html,logs}
```



为了让 `WebAdmin` 能够帮助我们来配置虚拟主机，需要给 `conf` 这个目录换个主人。

```
chown lsadm:lsadm sysadm.local/conf
```







**b、新建虚拟主机**

好了，准备工作就绪，可以开始使用 `WebAdmin` 了。

从左侧导航栏开始，找到 `虚拟主机` > `摘要` ，点击右侧加号来添加一个新主机。

图？



给虚拟主机一些必要的参数信息。

图？



在之前我们强调过，`OLS` 的根目录重要，在这里也有所体现。

```
$SERVER_ROOT = /usr/local/lsws/
```



**虚拟主机根目录（相对路径于$SERVER_ROOT）**

```
语法：$SERVER_ROOT/$VH_NAME/
例子1：$SERVER_ROOT/sysadm.local/
例子2：sysadm.local/
```



**配置文件（相对路径于$SERVER_ROOT）**

```
语法：$SERVER_ROOT/conf/vhosts/$VH_NAME/vhconf.conf
例子1：$SERVER_ROOT/conf/vhosts/sysadm.local/vhconf.conf
例子2：conf/vhosts/sysadm.local/vhconf.conf
```



当你点击保存按钮后，它会提示出错，说指定的配置文件并不存在。

别怕，其实没啥大事，直接点击那个 `CLICK TO CREATE` 就行了，它会帮你创建好配置文件。

图？



然后再点保存，虚拟主机就创建成功了。

图？



虚拟主机列表中有了新建的主机了，但是这个时候它还不完善，因为根目录并没有指定，项目文件放到哪里去啊？

所以我们接着走吧，列表中点击主机名称。

找到 `常规` 选项卡中的常规一项，再点下右边的编辑按钮，输入文档根目录。

**文档根目录（相对路径于 $SERVER_ROOT 或 $VH_ROOT 均可）**

```
语法：$VH_ROOT/html
例子：$VH_ROOT/html/public
```

由于我们使用的是 `Laravel` 项目，所以根目录应该设定成 `$VH_ROOT/html/public` 。

图？





**e、启用重写设定**

虚拟主机列表中点击主机名称，找到 `重写` 选项，点击右侧编辑按钮。

图？



然后启用重写，并自动加载 `.htaccess` ，保存退出。

图？



### 2、创建监听器

这个监听器简单地来说，就是用于分析请求来源，以便提供相应的 `WEB` 响应服务。

我个人的理解是，通常有两种监听方式，一种是端口，另一种是域名。

端口很容易理解，同一个IP地址，想要多用户访问，那么就可以连接不同的端口来访问服务器。

不过我们这里采用另一种监听方式，就是通过不同的域名来访问服务。



点击左侧导航栏中的 `监听器` ，然后点击右侧的添加按钮。

图？



填写监听器名称，我们这里设定端口为标准 `http` 的 `80` 端口，并且选择不加密连接。

图？

图？



还没有结束哦，接着点击列表中我们刚刚建立的监听器名称。

找到下方 `虚拟主机映射` 一栏，并点击右侧添加按钮。

图？



选择我们在前面建立的虚拟主机 `sysadm.local` ，再填写我们需要访问的域名，比如 `sysadm.local` 。

图？



小伙伴们请注意，这里的域名一定要能够解析。

我们现在只做测试，所以在我们的电脑上可以在 `hosts` 文件中手动添加解析条目。

比如，将域名 `sysadm.local` 解析到 `192.168.1.x` 这个IP地址上。

```
192.168.1.x sysadm.local
```



好，监听器及虚拟主机映射建立好后基本上应该是这个样子。

图？







#### 3、复制项目文件到虚拟主机根目录下

复制文件这个不用多说吧，将原有的 `Laravel` 项目目录中所有文件复制到刚才我们建立的虚拟主机根目录中。

比如：

```
cp laravel_files /usr/local/lsws/sysadm.local/html/
```





这里要注意两个子目录的权限，这两个子目录需要让 `lshttpd` 服务有权限访问，那么务必给它换个主人。

```
chown -R nobody:nobody sysadm.local/html/storage/
chown -R nobody:nobody sysadm.local/html/bootstrap/cache/
```





#### 4、导入数据库

这个也不用多说吧，导入数据备份即可。



#### 5、修改 `.env` 配置文件，并重新加载配置。

修正一些环境参数，比如数据库的连接。

然后最好是重新加载一下配置。

```
php artisan config:cache
php artisan view:cache
composer dump-autoload
```







#### 6、调整一些杂项

一个项目可能会用到不同的扩展，比如 `redis` 等等。

这个时候你就要注意看看系统是否正确加载了这些扩展。

还有其他一些参数的设定，比如 `PHP` 的文件上传大小，或是执行超时等等。







```
chown -R nobody:nobody storage
chown -R nobody:nobody bootstrap/cache
```

