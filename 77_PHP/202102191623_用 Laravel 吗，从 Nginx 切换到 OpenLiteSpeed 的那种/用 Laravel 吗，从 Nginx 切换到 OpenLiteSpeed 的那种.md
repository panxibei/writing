用 Laravel 吗，从 Nginx 切换到 OpenLiteSpeed 的那种

副标题：亲，这边建议您使用 OLS + Laravel 组合呢~



新年伊始，万象更新，各位小伙伴们新年好！

前不久年初时（2021年），刚折腾着把窝倒腾到了新东家。

折腾就是累，不过就在这一通折腾后，我突然发现了一个好东西。



入坑之初当我怀疑新东家的网速或稳定性是否比老东家更可靠时，不经意间我注意到了与以往不一样的东西。

图01



看到了没，新东家使用的是 `LiteSpeed` ，而在此之前我一度使用的不是 `Nginx` 就是 `Apache` 这类的大众款！

怪我孤陋寡闻，有人说贫穷限制了想像力，不不不，我觉得只要是个穷人，他根本就是哪儿哪儿都被限制了嘛！

不过还好穷人多少有点时间可以挤一挤，所以我就初步地研究了一下这个 `LiteSpeed` ，顺便我也使用过 `Laravel` ，最后将两者结合起来也就有了后面的文字！





### OpenLiteSpeed 是个啥

哎？不是正说着 `LiteSpeed` 吗，怎么变成了 `OpenLiteSpeed` ？

最初我也和小伙伴们一样有此疑问，其实前面冠以 `OPEN` 字样，很容易联想到是开源软件。

没错，`OpenLiteSpeed` （以下简称 `OLS` ）就是和 `Apache` 或 `Nginx` 相似的 `WEB` 服务引擎，是 `LiteSpeed EnterPrise` 的开源社区版本。



国内网络中主流引擎仍是 `Nginx` 和 `Apache` 的天下，`OLS` 似乎显得小众了一些，甚至其知名度还不如 `Lighttpd` 。

不过要知道 `OLS` 在国外发展迅猛，其优点多多，不仅仅提供了诸如 `WordPress` 、 `Joomla` 、`OpenCart` 或 `Drupal` 等常见应用的插件支持，而且还支持新一代的 `HTTP3` 协议。

虽然社区版的 `OLS` 与企业版相比有部分限制功能，但对于一般的个人博客或小型站点基本够用。

社区版肯定是免费的，但这并不是重点，你来看看官网给出的 `OLS` 与 `Nginx` 和 `Apache` 的性能对比，我可以猜到你肯定会先是大吃一鲸，然后口水横流。

图02



好吧，我承认我在流口水，容我先擦一擦，接下来我将**如何实现 `OpenLiteSpeed` 平台上跑 `Laravel` 项目**的过程分享给小伙伴们，Let's Start ！



> 官网链接：https://openlitespeed.org
>
> 知识库链接：https://openlitespeed.org/kb/





### 安装 OpenLiteSpeed 很简单



> 安装环境：CentOS 7 (2009)
>
> WEB引擎：OpenLiteSpeed 1.7.8 + PHP 7.4
>
> 准备工作：开通防火墙端口
>
> ```
> firewall-cmd --zone=public --add-port=7080/tcp --permanent
> firewall-cmd --zone=public --add-port=80/tcp --permanent
> ```



网上铺天盖地都是如何一键安装 `OLS` ，如果你的应用是 `WordPress` ，那么恭喜你倒可以参考参考。

因为一键安装可以连带 `WordPress` 及其插件一股脑儿地全部搞定，倒是简单高效。

可是，我虽然是个小白，但我同时又是个完美强迫症患者，在这里我只用最简单、直接的方法来安装。

是的，我要用的正是官方建议的二进制包安装方法。

知识库链接：https://openlitespeed.org/kb/install-from-binary/



注意，任何安装时都是需要管理员权限的，如果你是普通用户，记得用 `sudo` 。

好了，先将二进制包下载下来，可以到下载页上下载，也可以直接使用 `wget` 。

```
wget https://openlitespeed.org/packages/openlitespeed-1.7.8.tgz
```



我安装的是官方最新版本 `1.7.8` ，这个包大概 71.6 MB。

官网下载比较慢，我费了半天劲才下载下来，为了方便小伙伴们，在这我留个国内的备用下载链接。

**openlitespeed-1.7.8.tgz.zip (70.66M)**

下载链接：https://www.90pan.com/b2347537

提取码：tndd



下载好了就可以安装了，超级简单有木有。

```
tar -zxvf openlitespeed-1.7.8.tgz
cd openlitespeed
./install.sh
```

图03



全程自动下载、自动安装，刷刷手机耐心等待。

安装完成后你就可以看到这句话，表明安装成功，就是这么简单。

```
Installation finished, Enjoy!
```

图04



安装完成后你需要注意一点，安装程序在最后给出了一个名为 `WebAdmin` 的初始访问密码，如图中的红字。

```
Your webAdmin password is XXXXXXXX, written to file /usr/local/lsws/adminpasswd.
```

如果你不小心忘记把它记下来了，那么也别担心，可以在 `/usr/local/lsws/adminpasswd` 中找到它。

至于 `WebAdmin` 是什么、怎么用，等一会儿后面会有详细介绍，你先记下这个密码吧。





### 安装 PHP

要想用 `Laravel` ，那么肯定少不了要安装 `PHP` 。



##### a、怎么安装 php

别看前面安装 `OLS` 如此简单，实际上它已经完成了95%以上的任务。

根据以往 `Apache` 或 `Nginx` 等的安装经验，紧接着我们应该安装 `PHP` 了对不对？

哈哈，其实它已经好好地躺在系统里了，官方目前最新版本可以支持到 `7.4` 及 `8.0` 。

在前面的安装过程中我们也能观察到，它偷偷帮你装了 `lsphp74` 。

图05



##### b、添加 php 可执行文件到系统路径中

既然已经装好了 `php` ，那是不是我们直接拿来用就行了呢？

No No，实际上我们得到的 `php` 执行文件并不能在任何目录下直接执行，这就很不方便了 。

因此我们还是需要再动动手做做后续工作，将它的 `php` 执行文件加入到系统路径中。

```
# 编辑 /etc/profile 文件
vim /etc/profile

# 在文件最后添加一行
export PATH="/usr/local/lsws/lsphp74/bin:$PATH"

# 重新加载
source /etc/profile
```

图06



##### c、php 扩展

`PHP` 有了，接着如果你想加载更多的 `php` 扩展，那么可以手动添加它们。

比如想添加 `redis` 扩展，那么应该这样子做。

```
yum install lsphp74-pecl-redis
```

图07

图08



具体每个扩展包的名称可能与以往传统的有所不同，可以通过 `yum list` 查询来确定。

此外，因为我们用的是二进制包的安装方法，所以在安装过程中系统已经自动拥有了 `OLS` 官方的安装源，因此可以直接找到并安装相应的扩展。

如果系统中没有官方安装源，则可以手动添加，以 `CentOS 7` 为例如下。

```
rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm
```

不同平台具体可以参考：

```
https://openlitespeed.org/kb/install-ols-from-litespeed-repositories/
```



##### d、确认 php 环境

最后使用终端命令查看 `PHP` 版本。

图09



再使用 `phpinfo` 查看更多 `php` 及其扩展的支持信息。

图10



很棒对不对，我正需要 `PHP 7.4` ，要知道 `7.3` 将于2021年年底终止支持哦！

当然，你完全可以安装多个版本的 `PHP` ，那样还可以自由切换不同的版本环境用于测试了。

你可以参考官方的相关知识库，或者有机会的话我会另外写一篇文章专门说一说如何安装多个版本的 `PHP` 。





### 安装 MariaDB

几乎任何项目都少不了数据库，在这里虽然我们只是作为演示，但还是规矩规矩地安装最新版本的 `MariaDB` 。

我们采用安装源的方式来安装 `MariaDB` ，打开官网来到下载页面，在其中选择好相应平台及所需版本，按给出的信息保存安装源文件。

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

图11



什么，你问我怎么保存？

好吧，我晓得你懒，你下载这个，解压缩后放到 `/etc/yum.repo.d/` 目录下就可以了。

**MariaDB.repo.zip (1K)**

下载链接：https://www.90pan.com/b2347535

密码：u3xc



然后执行以下安装命令即可开始安装。

```
yum install MariaDB-server MariaDB-client
```

图12



当然了，如果你直接在 `CentOS` 上执行 `yum` 安装命令也是可以的，只不过获取到的并不一定是最新版本。

之后就是配置数据库，因为这不是本文重点，所以就不在此赘述了。





### 初识 OpenLiteSpeed 服务

在 `CentOS` 下， `OLS` 的服务名称为 `lshttpd` ，所以可以这样查看它的服务。

```
systemctl status lshttpd
```



它还有一个别称 `lsws` ，所以也可以这样查看它的服务。

```
systemctl status lsws
```

图13



那么我们就可以随意启动、停止或启用禁用 `OLS` 服务了。

```
# 启用/禁用服务
systemctl enable lsws
systemctl disable lsws

# 启动/停止服务
systemctl start lsws
systemctl stop lsws
```

图14





### OpenLiteSpeed 大概有哪些配置

`OLS` 安装好后，小伙伴们应该会比较关心两个问题，一个是它被安装在哪里了，另外一个是它的配置文件在哪里。

如果你是按照前面二进制包的方法安装的，那么 `OLS` 的根目录是 `/usr/local/lsws` 。

一定要记住这个根目录，因为之后所有的配置、缓存、应用统统都是以这个根目录为基础。



OK，那么接下来的问题就是配置文件，它大体分为两种。

**第一种，是 `OLS` 服务器级别的主配置文件。**

它放在了 `/usr/local/lsws/conf/` 下面，名字叫 `httpd_config.conf` 。

```
/usr/local/lsws/conf/httpd_config.conf
```



**第二种，是虚拟主机级别的配置文件。**

在根目录下专门有个放虚拟主机配置的目录 `/usr/local/lsws/conf/vhosts/` ，不同的虚拟主机则以其名称为子目录分别保存自己相应的配置文件。

比如我们安装好 `OLS` 后它自带有一个叫做 `Example` 的虚拟主机，那么它的配置文件就在这儿。

```
/usr/local/lsws/conf/vhosts/Example/vhconf.conf
```



不管是服务器级别的主配置文件也好，还是虚拟主机级别的配置文件也好，其中均是参数众多，设定纷繁复杂。

还好有个好消息，我们不必自己动手修改这些配置文件，官方给小白们提供了一个帮手。

在 `OLS` 安装完毕之际，我们就已经拥有了一个名为 `WebAdmin Console` 的 WEB 形式的控制面板程序，这也是官方建议的最佳配置编辑方式。

它除了帮助我们免于记忆复杂的参数语法外，我感觉有一点对于我们很有用的就是可以一键平滑重启服务。





### 对小白友好的 WebAdmin 控制台

`OLS` 服务一旦启动完毕，我们就可以登录 `WebAdmin` 了。

注意它是 `https` 开头的，另外端口是 `7080` 。

```
https://ServerName_Or_IP:7080
```



还记得前面让你记住的那个初始密码吗？

对了，就是在这里登录 `WebAdmin`  用的，登录进入系统后可以自行修改密码。

图15



还是那句话，如果你忘记了这个初始密码，可以用下面这个命令来查看。

```
cat /usr/local/lsws/adminpasswd
```



登录进 `WebAdmin` 后，我们可以点击右上角的语言选项，将它改为中文，如果你英文很棒就当我在唱歌。

图16



找到左侧导航栏 `管理控制台设置` > `常规` > `用户` ，可修改管理员密码。

图17



要是记性不好，连修改后的密码都给忘了咋办？

好办，使用以下贴心脚本来重置密码。

```
/usr/local/lsws/admin/misc/admpass.sh
```

图18



好了，说到这儿必须要强调一下，当我们进入 `WebAdmin` 后所做的任何修改变动，如果要使其生效，必须要重启服务。

想到每次都要输命令来重启就好烦啊，不过好在 `WebAdmin` 很贴心啊，它提供了平滑重启功能，点一下右上角的那个绿色小按钮就可以了。

图19





### 如何导入 Laravel 项目

前面准备了那么多，但到这儿总算是该敲黑板、划重点了，因为这里多多少少会有些坑。

作为演示，我不打算新建一个 `Laravel` 项目，而是只将原来的项目整体地迁移到 `OLS` 上，所以大致可以按以下几步去走。



#### 1、创建虚拟主机

`OLS` 安装完成后默认会生成一个名叫 `Example` 的虚拟主机，它可以作为测试或参数调整等参考，我个人不建议直接拿它来用。

那么我们最好是自己新建一个，当然了不需要去编辑晦涩难懂的配置文件，直接在控制台上点鼠标就可以了。



**a、创建目录**

在开始点点点之前，我们还是要先新建一些虚拟主机必要的目录。

假定我想新建一个名叫 `sysadm.local` 的虚拟主机，那么我至少要建立三个相关的目录，分别是 `conf` 、 `html` 和 `logs` 。

进入根目录，使用 `mkdir -p` 一口气新建三个子目录。

```
cd /usr/local/lsws
mkdir -p sysadm.local/{conf,html,logs}
```



为了让 `WebAdmin` 能够帮助我们来配置虚拟主机，需要给 `conf` 这个目录换个主人。

跑 `WebAdmin` 的用户叫 `lsadm` ，所以新主人就是 `lsadm`  。

```
chown lsadm:lsadm sysadm.local/conf
```



**b、新建虚拟主机**

好了，准备工作就绪，可以开始使用 `WebAdmin` 了。

从左侧导航栏开始，找到 `虚拟主机` > `摘要` ，点击右侧加号来添加一个新主机。

图20



给虚拟主机一些必要的参数信息。

图21



在之前我们强调过`OLS` 根目录的重要性，在这里也有所体现。

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

图22



然后再点保存，虚拟主机就创建成功了。

图23



虚拟主机列表中诞生了新的主机，但是这个时候它还是个新生儿还并不完整，因为它的文档根目录并没有指定，没有文档根目录，项目文件放到哪里去啊？

所以我们接着往前走吧，列表中点击虚拟主机名称。

找到 `常规` 选项卡中的常规一项，再点下右边的编辑按钮，输入文档根目录。

图24



**文档根目录（相对路径于 $SERVER_ROOT 或 $VH_ROOT 均可）**

```
语法：$VH_ROOT/html
例子：$VH_ROOT/html/public
```

由于我们使用的是 `Laravel` 项目，所以根目录应该设定成 `$VH_ROOT/html/public` 。

图25



**e、启用重写设定**

虚拟主机列表中点击主机名称，找到 `重写` 选项，点击右侧编辑按钮。

图26



然后启用重写，并指定自动加载 `.htaccess` ，保存退出。

图27



### 2、创建监听器

这个监听器简单地来说，就是用于分析请求来源，以便提供相应的 `WEB` 响应服务。

我个人的理解是，通常有两种监听方式，一种是端口方式，另一种是域名方式。

端口方式很容易理解，同一个IP地址，想要多用户访问，那么可以通过连接不同的端口来访问服务器。

不过我们这里采用另一种监听方式，就是通过主机域名来访问服务，这样就可以通过多个不同域名来访问同一IP地址同一端口的 WEB 服务。

当然在这里我们只指定一个域名作为演示。



点击左侧导航栏中的 `监听器` ，然后点击右侧的添加按钮。

图28



填写监听器名称，我们这里设定端口为标准 `http` 的 `80` 端口，并且选择不加密连接。

图29

图30



还没有结束哦，接着点击列表中我们刚刚建立的监听器名称。

找到下方 `虚拟主机映射` 一栏，并点击右侧添加按钮。

图31



选择我们在前面建立的虚拟主机 `sysadm.local` ，再填写我们需要访问的域名，比如 `sysadm.local` 。

图32



小伙伴们请注意，这里的域名一定要能够解析得到。

我们现在只做测试，所以在我们的电脑上可以在 `hosts` 文件中手动添加解析条目。

比如，将域名 `sysadm.local` 解析到 `192.168.1.x` 这个IP地址上。

```
192.168.1.x sysadm.local
```



好，监听器及虚拟主机映射建立好后基本上应该是这个样子。

图33



#### 3、复制项目文件到虚拟主机根目录下

复制文件这个不用多说了吧，将原有的 `Laravel` 项目目录中所有文件复制到刚才我们建立的虚拟主机文档根目录中。

比如：

```
cp laravel_files /usr/local/lsws/sysadm.local/html/
```



这里要注意两个子目录的权限，这两个子目录需要让 `lshttpd` 服务有权限访问，那么务必给它换个主人。

跑 `OLS` 服务的用户和组都叫 `nobody` ，所以新主人就是 `nobody`  。

```
chown -R nobody:nobody sysadm.local/html/storage/
chown -R nobody:nobody sysadm.local/html/bootstrap/cache/
```



#### 4、导入数据库

这个也不用多说吧，导入数据备份即可。



#### 5、修改 `.env` 配置文件，并重新加载配置。

修正一些环境参数，比如数据库的连接信息。

然后最好是重新加载一下配置，比如以下。

```
php artisan config:cache
php artisan view:cache
composer dump-autoload
```



#### 6、调整一些杂项

一个项目可能会用到不同的扩展，例如 `redis` 等等。

这个时候你就要注意看看系统是否正确加载了这些扩展。

还有其他一些参数的设定，比如 `PHP` 的文件上传大小，或是脚本执行超时等等。





### 写在最后

在导入 `Laravel` 项目的过程中，可能会遇到 `404` 错误，那么你就要检查一下虚拟主机文档根目录是不是指向了 `public` 目录。

还有其他一些错误啊、打开空白页面啊等等情况，可能需要你回过头去再看看哪里做错了，反正我也是调试了很久才成功，但我保证之前的步骤基本没问题。

至于优化或缓存的话题，这些对于我这个小白来说太复杂了，有待将来逐个研究破解。

此外还有一个问题，相信有的小伙伴们也应该注意到了，我们建立的这个虚拟主机只跑在了 `80` 端口上。

传输没有加密心里肯定会有点慌，那如何让 `OLS` 虚拟主机愉快地跑在 `HTTPS` 上呢？

我们下一回再聊。



WeChat@网管小贾 | www.sysadm.cc