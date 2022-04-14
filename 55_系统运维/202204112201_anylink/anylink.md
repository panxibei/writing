anylink

副标题：

英文：

关键字：





### 测试环境

* Rocky Linux 8.5 (Kernel 4.18.0)



官网提示，没有编程基础的同学建议直接下载 `release` 包 `anylink-deploy.tar.gz` 。

这就对了，我就是那个没有编程基础的同学啊，所以我还是老老实实地去下载了。

图a01



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

图a02



程序已经开始运行了，在不加任何参数所情况下，`anylink` 会自行使用默认参数值，其中就包括自带的证书，还有默认的后台管理员和密码等等。

好了，既然如此那我们就来用用看吧！



### 服务端后台管理

我们先用以下网址打开后台管理页面。

```
https://x.x.x.x:8800
```

图a03



默认后台管理员是 `admin` ，密码是 `123456` ，我们登录进去看看。

页面很简洁，每日统计信息，以及系统信息等等。

图a04

图a05



##### 邮箱设置

在 `其他设置` 中，我们可以设置邮件通知。

先在 `邮件配置` 中设置好我们的邮件服务器信息。

图a06



然后在 `其他设置` 中根据自身实际情况并参照模板设置邮件内容。

图a07



##### 用户设置

默认一开始 `用户列表` 中是没有任何用户的，我们来添加一个测试用户吧！

点击 `+添加` 按钮，填写新建用户信息。

图a08

图a09



这里需要注意几点。

`PIN` 码就是用户密码，而 `OTP` 密钥就是动态密码，这两者可以一起用，也可以只用前者。

用户新建时必须指定一个用户组，因此可以使用默认的用户组 `ops` ，也可以先建立用户组后将用户指定新建的用户组。



当开启发送邮件选项时，完成新建用户后，我们会得到一封通知邮件。

图b01



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

图c01

图c02

图c03

图c04

图c05



最后启动 `AnyConnect` 就像这样子。

图c06



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

图b02



##### 以证书域名访问连接服务器

有了正确的域名解析，那么我们就可以通过域名来连接 `anylink` 服务器了。

填好测试域名（不要用IP地址），然后点击连接 `Connect` 开始连接 `anylink` 。

图c07



这时我们会看到提示输入用户名和密码的窗口。

图c08



输入用户名和密码后，我们再次看到接入前的提示信息，点击确认 `Accept` 正式开始连接。

图c09



连接OK后，系统给出成功提示。

图c10



同时我们也可以查看到虚拟网卡获取到了 `VPN` 指定的IP网段。

图c11



就像前面说过的，如果在登录时使用 `PIN` 码+动态码的形式可能会失败，会老是提示动态码错误。

不知道是我设置的问题，还是说程序本身有 `BUG` 。

图c12













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





```
[root@sysadm anylink-deploy]# ./anylink tool -v
AnyLink v0.7.4 build on go1.17.8 [linux, amd64] commit_id(ccce143f853f0ec4caab8d2da14b542fb07d823a)
```

