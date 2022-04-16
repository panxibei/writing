老板下令，今天必须搞定居家办公的VPN！我却笑而不语，晚上准时回家吃饭！

副标题：AnyLink一款开源免费企业级远程办公VPN软件~

英文：boss-ordered-that-the-vpn-of-home-office-must-be-completed-today-i-smiled-without-a-word-and-went-home-on-time-for-dinner-at-night

关键字：anylink,vpn,ssl,linux,docker



也不知怎么的，近期疫情愈加严重起来，始终犹豫是否居家办公的老板忽然下令，命我等挨踢人员今天立刻马上火速搞定 `VPN` ！

这不扯的嘛，之前我们曾多次向老板申请加装 `VPN` 设备，无奈从未被重视过，如今又想要立马整出一套现成的来，这还真是天下老板一般X啊！

这么一来就给大家整不会了，一时间大家伙也都有点懵圈，徒生怨气，牢骚满腹。

而我呢，则笑而不语，心说没有 `VPN` 专用设备不是问题。

正在众人交头接耳之时，我独自一人走上台前，两手一挥，大声说道：“诸位诸位，请听我说！我有一妙法，可解此燃眉之急！”

众人不解，纷纷侧目，我说只需这么那么这样那样，OK，搞定！

没有 `VPN` 设备真的能搞定吗？

要问我是如何搞定的，这还要从一款开源 `VPN` 软件说起......



前不久我在网上闲逛，偶然间浏览到 `github` 上有一款号称企业级远程办公 `VPN` 软件，名叫 `AnyLink` 。

在如今大趋势流行居家办公的时代背景下，各种 `VPN` 解决方案是满天飞，而这个 `AnyLink` 居然号称企业级，是不是有点自吹呢？

我看了一下，它是用 `GO` 写的开源软件，基于 `openconnect` 协议开发，可支持多人同时在线，完全兼容思科的 `AnyConnect` 客户端。

看完简介，似乎这个 `AnyLink` 并不需要依靠什么特殊的网络设备，单单软件就能实现 `VPN` ，于是乎我就决定拿它试试看，好用的话呢就可以实际利用利用。

因此就有了下面的内容，这不总结好后分享给各位小伙伴！



### 测试环境

* Rocky Linux 8.5 (Kernel 4.18.0)



### 获取 `AnyLink` 软件

根据官网提示，没有编程基础的同学建议直接下载 `release` 包 `anylink-deploy.tar.gz` 。

这就对了，我就是那个没有编程基础的同学啊，所以我还是老老实实地去下载了。

图01



下载后解压缩。

```
tar zxvf anylink-deploy.tar.gz
```

```
anylink-deploy
|- conf\
  |--- files\
    |--- index.html
    |--- info.txt
  |--- anylink.db
  |--- profile.xml
  |--- server.toml		# 服务端配置文件
  |--- server-sample.toml
  |--- vpn_cert.crt		# 证书
  |--- vpn_cert.key		# 密钥
|- systemd\
  | anylink.service
|- anylink		# 主程序
|- bridge-init.sh
|- LICENSE
```



文件没几个，重要的也就是 `anylink` 主程序，以及 `server.toml` 服务端配置文件。

至于证书和密钥，在实际使用中必须申请安全的 `https` 证书，`anylink` 并不支持私有证书（自签名证书）。

有的小伙伴会说，那我还得先搞个证书罗，那测试成本是不是有点大发了？

其实大家也不用担心，开发者还是给我们留了一个测试的机会的，而且操作起来很简单。

我们只要将 `vpn.test.vqilu.cn` 这个域名正确解析到服务器的IP地址就行了。

简而言之，就是让客户端能够以域名 `vpn.test.vqilu.cn` 访问到服务器即可，因为 `anylink` 自带的证书是绑定到这个域名上的。

如果还是不太明白也没关系，待会我们演示过程中会再次说明的。

好了，我们来看看如何测试吧！



### 服务端运行

运行 `./anylink -h` 查看帮助信息。

```
[root@sysadm anylink-deploy]# ./anylink -h
AnyLink is a VPN Server application

Usage:
  anylink [flags]
  anylink [command]

Available Commands:
  completion  generate the autocompletion script for the specified shell
  help        Help about any command
  tool        AnyLink tool

Flags:
      --admin_addr string         后台服务监听地址 (default ":8800")
      --admin_pass string         管理用户密码 (default "$2a$10$UQ7C.EoPifDeJh6d8.31TeSPQU7hM/NOM2nixmBucJpAuXDQNqNke")
      --admin_user string         管理用户名 (default "admin")
      --audit_interval int        审计去重间隔(秒),-1关闭 (default -1)
      --cert_file string          证书文件 (default "./conf/vpn_cert.pem")
      --cert_key string           证书密钥 (default "./conf/vpn_cert.key")
  -c, --conf string               config file (default "./conf/server.toml")
      --cstp_dpd int              死链接检测时间(秒) (default 30)
      --cstp_keepalive int        keepalive时间(秒) (default 20)
      --db_source string          数据库source (default "./conf/anylink.db")
      --db_type string            数据库类型 [sqlite3 mysql postgres] (default "sqlite3")
      --default_group string      默认用户组 (default "one")
      --files_path string         外部下载文件路径 (default "./conf/files")
  -h, --help                      help for anylink
      --ip_lease int              IP租期(秒) (default 1209600)
      --ipv4_cidr string          ip地址网段 (default "192.168.10.0/24")
      --ipv4_end string           IPV4结束 (default "192.168.10.200")
      --ipv4_gateway string       ipv4_gateway (default "192.168.10.1")
      --ipv4_master string        ipv4主网卡名称 (default "eth0")
      --ipv4_start string         IPV4开始地址 (default "192.168.10.100")
      --issuer string             系统名称 (default "XX公司VPN")
      --jwt_secret string         JWT密钥 (default "abcdef.0123456789.abcdef")
      --link_mode string          虚拟网络类型[tun tap macvtap ipvtap] (default "tun")
      --log_level string          日志等级 [debug info warn error] (default "info")
      --log_path string           日志文件路径,默认标准输出
      --max_client int            最大用户连接 (default 100)
      --max_user_client int       最大单用户连接 (default 3)
      --mobile_dpd int            移动端死链接检测时间(秒) (default 60)
      --mobile_keepalive int      移动端keepalive接检测时间(秒) (default 50)
      --pprof                     开启pprof
      --profile string            profile.xml file (default "./conf/profile.xml")
      --proxy_protocol            TCP代理协议
      --server_addr string        服务监听地址 (default ":443")
      --server_dtls               开启DTLS
      --server_dtls_addr string   DTLS监听地址 (default ":4433")
      --session_timeout int       session过期时间(秒) (default 3600)

Use "anylink [command] --help" for more information about a command.
```



这么多参数，是不是被吓到了？

别着急哈，其实根本用不着多少参数的，甚至都不用参数也能玩。

不信咱走着！



我们直接运行 `./anylink` （或前面需要 `sudo` ），屁股后边不加任何参数。

图02



程序已经开始运行了，在不加任何参数所情况下，`anylink` 会自行使用默认参数值，其中就包括自带的证书，还有默认的后台管理员和密码等等。

好了，既然如此那我们就来用用看吧！



### 服务端后台管理

我们先用以下网址打开后台管理页面。

```
https://x.x.x.x:8800
```

图03



默认后台管理员是 `admin` ，密码是 `123456` ，我们登录进去看看。

页面很简洁，每日统计信息，以及系统信息等等。

图04

图05



##### 邮箱设置

在 `其他设置` 中，我们可以设置邮件通知。

先在 `邮件配置` 中设置好我们的邮件服务器信息。

图06



然后在 `其他设置` 中根据自身实际情况并参照模板设置邮件内容。

图07



##### 用户设置

默认一开始 `用户列表` 中是没有任何用户的，我们来添加一个测试用户吧！

点击 `+添加` 按钮，填写新建用户信息。

图08

图09



这里需要注意几点。

`PIN` 码就是用户密码，而 `OTP` 密钥就是动态密码，这两者可以一起用，也可以只用前者。

用户新建时必须指定一个用户组，因此可以使用默认的用户组 `ops` ，也可以先建立用户组后将用户指定新建的用户组。



当开启发送邮件选项时，完成新建用户后，我们会得到一封通知邮件。

图10



从收到的邮件内容看，我们就会明白，这个内容就是前面邮件设置中的模板内容。

其中系统给出了我们登录所需的 `PIN` 码和 `OTP` 动态码，在默认情况下这两个密码要一起使用才行。

不过话说回来，我测试了几次，老是提示动态码不对，后面会具体说到。



最后我们还要小心一点的是，应该第一时间确认用户和用户组的状态，两者任何一个的状态是停用的话，那是怎么也无法成功连接上的，切记切记！



### 客户端怎么连接？

##### 安装客户端

据官方所说，可以使用 `Cisco` 的 `AnyConnect` 客户端连接服务器，并且强调需要使用官方群中的共享文件版本。

由于 `Cisco` 官网上无法成功下载到 `AnyConnect` ，因此只能使用共享文件了。

为方便小伙伴们使用，我将它放在这里分享给大家。



**AnyConnect-win-4.10.05085**

下载链接：



`AnyConnect` 的安装非常简单。

图11

图12

图13

图14

图15



最后启动 `AnyConnect` 就像这样子。

图16



##### 修改 `DNS` 解析

客户端安装好了，是不是我们就可以直接使用了呢？

还不行，因为我们没有申请实际的证书，所以我们要动点手脚才能测试成功。

怎么做呢，其实很简单，就是编辑一下 `hosts` ，修改 `DNS` 解析即可。

具体是，我们以管理员身份用文本编辑器打开 `hosts` 文件，然后在最后新加入如下解析条目。

```
# x.x.x.x为服务器IP地址，后加空格，再加上测试域名。
x.x.x.x vpn.test.vqilu.cn
```



要是你不信邪，就是用IP地址去连，那么只会得到证书与域名不匹配的警告提示。

图17



##### 以证书域名方式连接服务器

有了正确的域名解析，那么我们就可以通过域名来连接 `anylink` 服务器了。

填好测试域名（不要用IP地址），然后点击连接 `Connect` 开始连接 `anylink` 。

图18



这时我们会看到提示输入用户名和密码的窗口。

图19



输入用户名和密码后，我们再次看到接入前的提示信息，点击确认 `Accept` 正式开始连接。

图20



连接OK后，系统给出成功提示。

图21



同时我们也可以查看到虚拟网卡获取到了 `VPN` 指定的IP网段。

图22



就像前面说过的，如果在登录时使用 `PIN` 码+动态码的形式可能会失败，会老是提示动态码错误。

图23



我以为是设置的问题，结果后来折腾一阵后才发现，需要在手机上用 `FreeOTP` 扫描二维码获取动态码。

这个动态码是6位的数字，比如 `522944` 这个样子。

然后密码就成了用户密码加上动态码，假如用户密码是 `sysadm` ，那么实际 `VPN` 连接密码就成了 `sysadm522944` 了。

图24



**FreeOTP**

> https://freeotp.github.io



### 服务器其他一些设置

前面我们测试OK，在 `./anylink` 之后没有加任何参数，但是往往实际情况并不像测试一样，因此可能还需要我们做一些参数上的调整。



##### `tool` 工具

在 `./anylink` 的后面有一个 `tool` 的命令，用于生成后台密码或 `JWT` 密钥。

比如像下面这样子。

```
# 重新生成后台密码，就是admin的密码
# 默认密码 123456
./anylink tool -p 666666

# 重新生成jwt密钥，就是web访问令牌密钥
# 默认密钥 abcdef.0123456789.abcdef
./anylink tool -s
```



注意，这两者都是服务于后面管理页面的，与 `VPN` 用户密码没有关系哦！

具体的参数可以看看下面的帮助信息。

```
[root@sysadm anylink-deploy]# ./anylink tool -h
AnyLink tool is a application

Usage:
  anylink tool [flags]

Flags:
  -d, --debug           list the config viper.Debug() info
  -h, --help            help for tool
  -p, --passwd string   convert the password plaintext
  -s, --secret          generate a random jwt secret
  -v, --version         display version info
```



还可以查看版本。

```
[root@sysadm anylink-deploy]# ./anylink tool -v
AnyLink v0.7.4 build on go1.17.8 [linux, amd64] commit_id(ccce143f853f0ec4caab8d2da14b542fb07d823a)
```



##### 数据库支持

`AnyLink` 支持三种数据库，分别是 `sqlite3` 、`mysql` 和 `postgresql` 。

```
数据库类型	数据源连接
sqlite3 	./conf/anylink.db
mysql		user:password@tcp(127.0.0.1:3306)/anylink?charset=utf8
postgres	user:password@localhost/anylink?sslmode=verify-full
```



默认使用 `sqlite3` ，我们什么都不用设置，一旦 `anylink` 服务启动，就会在 `./conf` 下自动生成一个名为 `anylink.db` 的数据库文件。

```
./conf/anylink.db
```



如果有定制读取数据库需求的话，也可以研究一下这个 `sqlite3` 数据库文件。

图25



另外如果当用户数量非常大时，也可以考虑使用 `mysql` 或 `pgsql` 。



##### 配置 `NAT` 转发

当成功连接到服务器后，你可能会发现，哎，怎么只能 `ping` 通服务器，服务器所在的局域网其他电脑却 `ping` 不通呢？

况且直接在服务器上 `ping` 其他电脑都是通的呀，这是怎么回事？

其实是因为我们还需要再配置一下 `NAT` 转发。

方法很简单，按以下照做就是了。



1、开启 `IPv4` 转发

```
# 开启ipv4转发
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
# 立即生效
sysctl -p
```



2、开启 `NAT`

```
# 设置NAT
# 此处IP地址应与server.toml文件中一致，比如 192.168.20.0/24
# 此处的网卡名称应与系统实际网卡名称一致，比如 ens160
iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -o eth0 -j MASQUERADE
# 查看设置是否生效
iptables -nL -t nat
```

图26



3、永久保存 `NAT` 设置

```
# 保存设置NAT，永久生效
dnf install -y iptables-services
systemctl enable iptables
service iptables save
```



##### 作为服务随系统自启动

`AnyLink` 已经为我们做好了 `service` 文件，我们只需将 `anylink` 程序文件放到指定的目录中即可。



1、将 `anylink` 主程序复制到 `/usr/local/anylink-deploy` 中。

```
mkdir /usr/local/anylink-deploy
cp ./anylink /usr/local/anylink-deploy/anylink
```



2、将配置文件 `conf/server.toml` 复制到 `/usr/local/anylink-deploy/conf` 中。

```
mkdir /usr/local/anylink-deploy/conf
cp ./conf/server.toml /usr/local/anylink-deploy/conf/server.toml
```



3、将 `anylink` 目录中的 `systemd/anylink.service` 文件复制到 `/usr/lib/systemd/system/` 中。

```
cp systemd/anylink.service /usr/lib/systemd/system/anylink.service
```



4、现在可以作为服务启动、停止 `anylink` 了。

```
# 开机自启 anylink
systemctl enable anylink

# 启动 anylink
systemctl start anylink

# 停止 anylink
systemctl stop anylink
```

图27



在实际应用中，我们可以编辑 `server.toml` 以及  `anylink.service` 文件来调整具体的服务启动。



### 使用 Docker 镜像部署

`Docker` 似乎是万能的，只要是支持 `Docker` 的系统现在也能上 `anylink` ，并不必拘泥于 `Linux` 系统。

按官方说明，罗列如下。

```
# 获取镜像
docker pull bjdgyc/anylink:latest

# 查看命令信息
docker run -it --rm bjdgyc/anylink -h

# 生成密码
docker run -it --rm bjdgyc/anylink tool -p 123456
#Passwd:$2a$10$lCWTCcGmQdE/4Kb1wabbLelu4vY/cUwBwN64xIzvXcihFgRzUvH2a

# 生成 jwt secret
docker run -it --rm bjdgyc/anylink tool -s
#Secret:9qXoIhY01jqhWIeIluGliOS4O_rhcXGGGu422uRZ1JjZxIZmh17WwzW36woEbA

# 启动容器
# -e IPV4_CIDR=192.168.10.0/24 这个参数要与配置文件内的网段一致
docker run -itd --name anylink --privileged \
  -e IPV4_CIDR=192.168.10.0/24
  -p 443:443 -p 8800:8800 \
  --restart=always \
  bjdgyc/anylink

# 使用自定义参数启动容器
# 参数可以参考 -h 命令
docker run -itd --name anylink --privileged \
  -e IPV4_CIDR=192.168.10.0/24 \
  -p 443:443 -p 8800:8800 \
  --restart=always \
  bjdgyc/anylink \
  -c=/etc/server.toml --ip_lease=1209600 # IP地址租约时长

# 构建镜像
#获取仓库源码
git clone https://github.com/bjdgyc/anylink.git
# 构建镜像
docker build -t anylink .
```



感觉没有自己动手做系统来得灵活和定制性强，关于 `Docker` 下如何具体使用就不在这儿赘述了，有兴趣的小伙伴们可自行折腾。



### 写在最后

经过我的一番折腾测试，已经分别在局域网和外网环境下成功连接 `VPN` 网络，效果还是可以的。

这个 `AnyLink` 通过软件实现 `VPN` 功能，有点和 `OpenVPN` 之类的软件相似，但相比下来更加安全严谨一些。

至于 `AnyLink` 的其他特点，小伙伴们可以上官网查看学习。

如果你有兴趣的话，完全可以自己搭建一个系统环境先测试起来，毕竟它支持多个 `Linux` 平台，同时也支持在 `Docker` 下跑，部署起来是非常便捷。

最后，祝各位小伙伴们测试顺利！

同时也希望疫情阴霾早日散去，还我们一个明朗的晴天！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
