最新稳定版 Squid5 安装使用经验总结

副标题：简单配置即可直接使用~

英文：installation-and-usage-summary-of-the-lastest-version-squid5

关键字：squid,proxy,squid5,web,http,https,代理,代理服务器,windows,update,antivirus



八爪鱼 `Squid` 是很早以前就出了名的一款 `http` 代理服务软件。

你看它的名字就很有特色，通过无数个触角连接众多的客户端，使我们能够通过它来访问网络，所以很形象地起了这么一个名字。

如今代理软件数不胜数，但我还是钟情于 `Squid` ，毕竟一开始就用它嘛。



在平时，我们可能会遇到这样的问题，就是有部分电脑需要通过互联网来访问一些资源，比如说像 `Windows` 的自动更新。

很多人家的局域网里是没有更新服务器的，所以说需要让这些电脑能够自己连接到互联网上去更新补丁。

可是，这些电脑却又有一些限制，比如不允许他们访问除更新以外的其他资源，甚至是局域网资源都被禁止访问。

因此，这种情况就比较适合 `Squid` 这样的代理服务登场了。



这几天我这正好有一台老电脑出了问题，上面就是跑的 `Squid` ，所以正好以此为契机重新更新并整理一下它的使用方法。

以前偷懒，旧版的 `Squid` 是通过 `yum` 之类的自动安装上的，这次我打算安装官网的最新稳定版，所以就需要我们手动编译来安装了。



### 环境及准备工作

* Rocky Linux 8.4
* Squid 5.1



安装所需的基本组件，包含 `C` 编译器及 `Perl` 等。

```
dnf install gcc gcc-c++ perl wget tar
```



开通防火墙端口，编辑 `/etc/firewalld/zone/public.xml` 添加以下代码。

```xml
<!-- 开放 http 或 https 服务 -->
<service name="http"/>
<service name="https"/>

<!-- 开放相应IP段的3128端口 -->
<rule family="ipv4">
  <source address="192.168.1.0/24"/>
  <port protocol="tcp" port="3128"/>
  <accept/>
</rule>
```



### 编译安装 `Squid`

打开官网链接：http://www.squid-cache.org/

找到最新稳定版的下载代码包。

```
wget http://www.squid-cache.org/Versions/v5/squid-5.1.tar.gz
```

图01



解压、编译并安装，老套路了。

```shell
tar xzvf squid-5.1.tar.gz
cd squid-5.1
./configure
make
make install
```



最终 `Squid` 被安装到了以下位置。

```
/usr/local/squid
```



安装完毕后我们接着该干点啥呢？



### 目录结构、配置文件和执行程序一览

武器再厉害，我们也要先熟悉它，然后才能发挥它的威力。

我们先来看看它的目录文件结构，如下。

```
/usr/local/squid/
├── bin
│   ├── purge
│   └── squidclient
├── etc
│   ├── cachemgr.conf
│   ├── cachemgr.conf.default
│   ├── errorpage.css
│   ├── errorpage.css.default
│   ├── mime.conf
│   ├── mime.conf.default
│   ├── squid.conf
│   ├── squid.conf.default
│   └── squid.conf.documented
├── libexec
│   ├── basic_db_auth
│   ├── basic_fake_auth
│   ├── basic_getpwnam_auth
│   ├── basic_ncsa_auth
│   ├── basic_pop3_auth
│   ├── basic_radius_auth
│   ├── basic_smb_auth
│   ├── basic_smb_auth.sh
│   ├── cachemgr.cgi
│   ├── digest_file_auth
│   ├── diskd
│   ├── ext_delayer_acl
│   ├── ext_file_userip_acl
│   ├── ext_kerberos_sid_group_acl
│   ├── ext_sql_session_acl
│   ├── ext_unix_group_acl
│   ├── ext_wbinfo_group_acl
│   ├── helper-mux
│   ├── log_db_daemon
│   ├── log_file_daemon
│   ├── negotiate_wrapper_auth
│   ├── ntlm_fake_auth
│   ├── security_fake_certverify
│   ├── storeid_file_rewrite
│   ├── unlinkd
│   ├── url_fake_rewrite
│   ├── url_fake_rewrite.sh
│   └── url_lfs_rewrite
├── sbin
│   └── squid
├── share
│   ├── errors
│   ├── icons
│   ├── man
│   └── mib.txt
└── var
    ├── cache
    ├── logs
    └── run
```



别看这么一大堆目录和文件，我们只要简单地说一下我们主要关心的哪几个就行，以后有了经验再折腾其他的。



首先是 `bin` 目录，里面就两个，一个 `purge` ，一个 `squidclient` 。

前者用于清除缓存，后者是客户端用来测试服务端的，一会儿后面会细讲。



其次是 `etc` 目录，其中我们只要知道 `squid.conf` 这个最最主要的配置文件即可，目前我们所有的配置都在这个文件中进行。



再次是 `sbin` 目录，只有一个文件 `squid` ，没错，它就是服务端执行程序，所有的不同执行操作都是以它开头的。



最后是 `var` 目录，其中有三个子目录，`cache` 、`logs` 和 `run` 。

一看这几个哥们的名字就应该知道，是用作缓存、日志和运行临时文件存放。

请小心，我在摸索过程中就是在这儿踩到了一个坑，这三个哥们必须要开放权限， `Squid` 才能正常开始工作。

所以，应该给他们放权，但不是给 777 ，而是将他们请到 `nobody` 组中，像下面这个样子。

```
chown -R nobody:nobody /usr/local/squid/var/cache
chown -R nobody:nobody /usr/local/squid/var/logs
chown -R nobody:nobody /usr/local/squid/var/run
```



### 初步编辑配置文件

什么叫初步编辑？

其实 `Squid` 发展到现在的 `v5` 稳定版已经非常好用了，默认的配置文件已经帮我们设定为最小化配置，是可以直接拿来用的。



配置文件在哪里？前面说过了，默认在这儿呢。

```
/usr/local/squid/etc/squid.conf
```



为什么说可以直接拿来用呢，其实如果只是做实验或一般用用的话，配置文件中只要改一个地方，`Squid` 就可以在本机上开始工作啦。

这个地方就是修改配置文件对于磁盘交换目录的定义。

打开 `squid.conf` 文件，然后找到如下段落，将 `cache_dir` 前的注释符去掉即可。

```
# Uncomment and adjust the following to add a disk cache directory.
#cache_dir ufs /usr/local/squid/var/cache/squid 100 16 256
cache_dir ufs /usr/local/squid/var/cache/squid 100 16 256
```

图02



看 `cache_dir` 的名字就知道啥意思了，就是缓存目录嘛，其中的目录路径可以改成你想要的，后面的 `100` 是缓存大小，单位是 `MB` ，而后面的 `16` 和 `256` 分别是儿子目录的数量和孙子目录的数量，基本上是不用改动的。

注意，这个缓存是指磁盘缓存，就是放在硬盘上的，所以如果磁盘空间尚且富裕，可以考虑将 `100` 修改成稍大一点的数值。



### 创建磁盘交换目录

`v5` 版本之前好像没听说过要先这么干的，但现在我们在正式执行 `squid` 前必须先要建立这个磁盘交换目录。

这一点往往是在添加或修改 `cache_dir` 配置后必须马上干的事，切记切记！

```
squid -z
```



命令很简单，后加个 `-z` 参数即可。

运行之后就可以在以下目录中看到很多新冒出来的交换目录，当然了，这些都是根据 `cache_dir` 配置来的。

```
/usr/local/squid/var/cache/squid/
```

图03



注意，这里可能有的小伙伴会踩到一个坑，如果你要是看到拒绝访问而导致错误的提示，那么就是你忘记给那些子目录 `nobody` 权限了，可以参考前面说的内容修正。

图04



### 执行主程序

`Squid` 主程序位于 `/usr/local/squid/sbin` 内，若不带任何参数直接运行 `squid` ，它就会以守护进程形式直接在后台运行。

```
/usr/local/squid/sbin/squid
```



那我们因为是做实验，要是跑到后台去它到底有没有偷懒我们也看不到怎么办？

自然是有办法的，给它一个参数 `-N` 即可以禁止以后台守护进程形式运行，这样可以方便看到输出的错误日志。

```
squid -N
```



虽然 `squid` 主程序的参数众多，我们也没必要记住所有的，所以我们挑几个对我们有点用的来说一说。

比如，检查配置文件语法是否正确。

这个很有用，在正式执行主程序前，这是个避免发生错误而导致尴尬的好办法。

```
squid -k parse
```



还有，检查主程序是否在运行，它主要是判断 `squid.pid` 文件是不是正常状态。

```
squid -k check
```



还有还有，当主程序正在运行的时候，我们更新了配置想及时地反馈生效，那么我们可以实时地加载配置。

就像下面这样，我们都不用重新启动主程序了！

```
squid -k reconfigure
```



最后，我想知道如何关掉 `squid` ，因为它跑在后台我也看不到它啊。

就像下面，一般用第一个，暴力一点就用后面那个。

```
squid -k shutdown
squid -k kill
```



### 启用用户认证

到目前为止，我们已经可以通过 `Squid` 访问网络了。

可是，在 `Squid` 代理为我们提供便利的同时，危险也会悄悄来临。

没错了，如果大家都很遵守规则不滥用代理服务，那么这个世界上就不会有警察了。

当然，我们现在还不想麻烦警察叔叔，我们应该自己先想想办法防止代理被滥用，所以至少我们可以启用用户认证，这样可以有效防止一部分人滥用代理了。



##### 确认 `ncsa_auth` 认证模块

这个 `ncsa_auth` 认证模块是 `Squid` 自带的，我们前面是自动手动编译安装的，而且是安装到默认路径 中，所以可以用下面的命令来查看模块是否存在。

```
[root@localhost squid]# find /usr/local/squid | grep ncsa_auth
/usr/local/squid/share/man/man8/basic_ncsa_auth.8
/usr/local/squid/libexec/basic_ncsa_auth
```

在本例中模块的文件名是 `basic_ncsa_auth` ，记住它一会儿我们要用到。



##### 安装生成认证用户的工具 `htpasswd`

安装命令如下。

```
dnf install httpd-tools
```



安装完成后我们就有了 `htpasswd` ，这个是用来生成用户名和密码的，生成方法如下。

```
# 将用户和密码生成到文件 squid_user.txt 中
# htpasswd -c 密码文件 用户名
htpasswd -c /usr/local/squid/etc/squid_user.txt sysadm
```

命令执行后会询问密码，输入密码后完成创建用户。



##### 修改配置文件 `squid.conf`

在配置文件最开头追加以下几行参数描述。

```
# 定义认证方式为 basic，同时指定认证程序路径与用户密码文件
auth_param basic program /usr/local/squid/libexec/basic_ncsa_auth /usr/local/squid/etc/squid_user.txt

# 认证程序进程为5，可有效提高认证验证并发效率
auth_param basic children 5

# 登录提示信息
auth_param basic realm SYSADM.CC

# 认证超时时间，官方建议2小时
auth_param basic credentialsttl 2 hours
```



然后在适当的位置写入以下规则。

```
# 规则名称为 auth_users 必须使用认证
acl auth_users proxy_auth REQUIRED

# 开启用户认证
http_access allow auth_users
```

第一条可任意写在 `acl` 列表中，但第二条的 `http_access` 必须要注意书写顺序。

如果你不太清楚应该怎么写，没关系，后面有完整版的配置文件可以参考一下。



##### 重启 `squid` 并验证是否生效

重启或重新加载配置都是可以的，比如：

```
squid -k reconfigure
```

 然后再用浏览器随便打开一个网站，就会看到一个提示窗口。

输入前面我们生成的用户名和密码即可正常访问网站了，如果不知道或输错了用户名和密码，那么对不起，我要叫警察叔叔来了。

图5



### 完整配置

按前面的步骤基本上 `Squid` 已经可以欢快地跑起来了。

可是就这样也只能是在服务端本机上玩，这有什么意思呢，别老整三岁的，要整就整四岁的。

所以我们来添加一些规则来测试真实客户机是否可以正常使用 `Squid` 代理。



##### 规则列表

这里简单介绍两种规则方法。

一种是针对网址，开通后所有客户端都能访问这些网址。

```
# acl 规则名称 dstdom_regex 网址列表1 网址列表2 ...
acl sysadm.cc dstdom_regex www.sysadm.cc sysadm.cc
```



还有一种是针对IP地址，只要是匹配了列表中的IP地址，客户端就可以访问任意网址。

```
# acl 规则名称 src IP地址列表（分别列出或用减号表示范围或用掩码均可）
acl 192_168_1_0 src 192.168.1.1-192.168.1.253
```



##### 规则定义

前面设定好的规则列表，在这里就使其按允许或禁止来定义访问规则。

```
# http_access allow/deny 规则名称
http_access allow sysadm.cc
http_access allow 192_168_1_0
```



**需要注意的是，规则列表一定要放在规则定义的前面。**



不管是规则列表也好，还是规则定义也好，它们都应该放在配置文件中的什么位置呢？

其实配置文件默认就已经帮我们写好了一些规则，我们可以参考着往里面写。

如下，就前面简单介绍的我们自己所写的规则内容，我将其追加在了 `=` 号横线范围内，大家可以用来参考。



主要功能是这样的，配置开通访问 `mirrors.163.com` 和 `sysadm.cc` 两个网址，同时 `192.168.1.0/24` 网段以及部分 `192.168.2.0/24` 网段主机开通了访问权限。

其中，服务端所在网段内主机默认是有访问权限的，所以要想禁止就应该注释掉以下行。

```
# 注释掉下面这行，禁止当前网段的访问
#http_access allow localnet
```



完整配置文件示例。

```ini
#
# Recommended minimum configuration:
#

# =================================================================
# 定义认证方式为 basic，同时指定认证程序路径与用户密码文件
auth_param basic program /usr/local/squid/libexec/basic_ncsa_auth /usr/local/squid/etc/squid_user.txt

# 认证程序进程为5，可有效提高认证验证并发效率
auth_param basic children 5

# 登录提示信息
auth_param basic realm SYSADM.CC

# 认证超时时间，官方建议2小时
auth_param basic credentialsttl 2 hours

# =================================================================

# Example rule allowing access from your local networks.
# Adapt to list your (internal) IP networks from where browsing
# should be allowed
acl localnet src 0.0.0.1-0.255.255.255	# RFC 1122 "this" network (LAN)
acl localnet src 10.0.0.0/8		# RFC 1918 local private network (LAN)
acl localnet src 100.64.0.0/10		# RFC 6598 shared address space (CGN)
acl localnet src 169.254.0.0/16 	# RFC 3927 link-local (directly plugged) machines
acl localnet src 172.16.0.0/12		# RFC 1918 local private network (LAN)
acl localnet src 192.168.0.0/16		# RFC 1918 local private network (LAN)
acl localnet src fc00::/7       	# RFC 4193 local private network range
acl localnet src fe80::/10      	# RFC 4291 link-local (directly plugged) machines

acl SSL_ports port 443
acl Safe_ports port 80		# http
acl Safe_ports port 21		# ftp
acl Safe_ports port 443		# https
acl Safe_ports port 70		# gopher
acl Safe_ports port 210		# wais
acl Safe_ports port 1025-65535	# unregistered ports
acl Safe_ports port 280		# http-mgmt
acl Safe_ports port 488		# gss-http
acl Safe_ports port 591		# filemaker
acl Safe_ports port 777		# multiling http

# =================================================================

# 此处写入自己的控制列表

# 开通某网址
acl mirrors.163.com dstdom_regex mirrors.163.com mirrors.163.com:443
acl sysadm.cc dstdom_regex www.sysadm.cc sysadm.cc

# 开通某IP
acl 192_168_1_0 src 192.168.1.1-192.168.1.253
acl 192_168_2_0 src 192.168.2.1 192.168.2.12 192.168.2.30

# 规则名称为 auth_users 必须使用认证
acl auth_users proxy_auth REQUIRED

# 开通清除缓存功能
acl PURGE method PURGE

# =================================================================

#
# Recommended minimum Access Permission configuration:
#
# Deny requests to certain unsafe ports
http_access deny !Safe_ports

# Deny CONNECT to other than secure SSL ports
http_access deny CONNECT !SSL_ports

# Only allow cachemgr access from localhost
http_access allow localhost manager
http_access deny manager

# We strongly recommend the following be uncommented to protect innocent
# web applications running on the proxy server who think the only
# one who can access services on "localhost" is a local user
#http_access deny to_localhost

#
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
#

# =================================================================

# 开启用户认证
http_access allow auth_users

# 此处写入自己的访问规则，对应前面的控制列表填写相应的名称
http_access allow mirrors.163.com
http_access allow sysadm.cc
http_access allow 192_168_1_0
http_access allow 192_168_2_0

# 开启除本地以外的清除缓存功能
http_access allow PURGE localhost
http_access deny PURGE

# =================================================================

# Example rule allowing access from your local networks.
# Adapt localnet in the ACL section to list your (internal) IP networks
# from where browsing should be allowed
# 注释掉下面这行，禁止当前网段的访问
###http_access allow localnet
http_access allow localhost

# And finally deny all other access to this proxy
http_access deny all

# Squid normally listens to port 3128
http_port 3128

# Uncomment and adjust the following to add a disk cache directory.
cache_dir ufs /usr/local/squid/var/cache/squid 100 16 256

# Leave coredumps in the first cache dir
coredump_dir /usr/local/squid/var/cache/squid

#
# Add any of your own refresh_pattern entries above these.
#
refresh_pattern ^ftp:		1440	20%	10080
refresh_pattern ^gopher:	1440	0%	1440
refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
refresh_pattern .		0	20%	4320
```



### 测试方法

##### `squidclient`

服务端主程序本身就有测试的功能，即 `squid -k check` 。

不过这只是检测服务端程序有没在跑的功能，它无法检测我们设定的规则有没有生效。

所以我们还要用到客户端程序，`Squid` 其实已经带了。

```
/usr/local/squid/bin/squidclient
```



那么我们只要这样做就可以测试客户端了。

```
squidclient http://sysadm.cc > result.log
```

可以在 `result.log` 文件中查看结果。



##### `curl`

怎么说 `squidclient` 还是没有跳出服务端的圈子，那我们就实实在在地在客户端测试吧。

其实测试程序很多，我这儿选了 `curl` ，比较简单直观一些。



**curl 7.79.0 for Windows**

下载地址：https://curl.se/windows



用法也很简单，将下载好的压缩包解压后找到 `bin` 目录，直接按以下方式执行测试即可。

```
# curl -x Squid主机IP:端口 测试网址
curl -x 192.168.1.123:3128 sysadm.cc
```



正常情况下，程序执行后会返回网站相关的一些页面代码或者是被拒绝的消息提示，否则就是连接失败。



### 清除缓存

通常清除缓存是比较危险的，所以不能简单认为可以随便清空所有缓存。

那么有时就是需要怎么办呢？

`Squid` 提供了一个方法，只能针对某个网址清除缓存。



首先要在配置文件中开启这个功能，这个设定在前面完整配置文件中已经包含了。

```
# 开启除本地以外的清除缓存功能
http_access allow PURGE localhost
http_access deny PURGE
```



然后使用命令即可。

```
squidclient -m PURGE http://sysadm.cc
```



还有一个比较简单粗暴的清除全部缓存的办法，那就是将 `cache` 目录手动清空或删除，然后再执行 `squid -z` 重新生成缓存。



### 开机自动启动

平时只要手动执行 `squid` 即可让  `Squid` 跑起来，但是还是希望它能够在系统启动时自动跑起来。

怎么办呢？



方法有很多，我找到一个比较简单的办法。

将以下面的代码加入到 `/etc/rc.d/rc.local` 文件中。

```
# Squid caching proxy
if [ -f /usr/local/squid/sbin/squid ]; then
        echo -n ' Squid'
        /usr/local/squid/sbin/squid
fi
```

图06



注意图中上面的红框，也就是注释说明，它提示我们如果要启用这个 `rc.local` ，那么别忘记给这个文件赋予可执行权限，否则是无效的哦。

```
chmod +x /etc/rc.d/rc.local
```



### 补一个坑

我在测试过程中发现，不管是用浏览器访问网站，还是用类似 `curl` 的测试命令，都没有什么问题。

可是，在 `Symantec` 自动更新这个地方碰了个钉子。

不论我怎么调整参数，就算加上参数重新编译安装，仍然无法解决代理自动更新失败的问题。

甚至我直接将它无法下载的更新文件直接放到了浏览器上，你猜如何，它能正常访问并下载，就是自动更新无法正常下载，奇葩不？

图07



我清楚地记得，明明以前使用时都是一切顺利没有任何问题的。

于是我返回去看了一下之前安装是否有什么特别之处，同时与现在的版本对比，最终没有发现有啥不一样的地方，唯一不一样的就是之前使用的是旧版本。



这个问题困扰了我好几天，最后我干脆手动安装了 `v4` 版本的 `Squid` ，居然发现问题解决了！

呵呵哒，我差点没把鼻子给气歪了，回头仔细查看两个版本的更新日志，可惜仍然无法了解其中的问题所在。

我猜测可能是新版的算法有所改变，对于非浏览器方式访问进行了区别对待，导致了在程序自动更新时访问失败。

在这儿提醒小伙伴们一下，如果你有特殊需求，比如 `Symantec` 的自动更新需要代理访问时，尽量使用旧版 `Squid` 。

如果你知道其中的问题所在，恳请你能告诉我，在此先感谢！



### 写在最后

`Squid` 是老牌代理服务软件，如今使用起来也是非常的方便，当然更多更复杂的使用方法小伙伴们可以参考官网文档，我就不在这儿献丑了，我也在不断学习中。

如果你的电脑需要连接指定的网站而又不要它连接其他的资源，那么可以考虑使用代理的方式访问。

通过本文简单的安装设定，即可快速实现你想要的功能。

如今我这边有好多服务器与客户端电脑都需要自动连网更新，同时还要保证杀毒软件升级，可以说 `Squid` 功不可没，用处大大滴。

好了，关于 `Squid` 的介绍就到这里吧，马上就要放假过节了，预祝小伙伴们节日快乐，吃好喝好，身体陪棒！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc