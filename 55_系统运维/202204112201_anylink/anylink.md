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



我们直接运行 `./anylink` ，屁股后边不加任何参数。

图a02



程序已经开始运行了，在不加任何参数所情况下，`anylink` 会自行使用默认参数值，其中就包括自带的证书，还有默认的后台管理员和密码等等。

好了，既然如此那我们就来用用看吧！



我们先用以下网址打开后台管理页面。

```
https://x.x.x.x:8800
```

图a03



默认后台管理员是 `admin` ，密码是 `123456` ，我们登录进去看看。

页面很简洁，每日统计信息，以及系统信息等等。

图a04

图a05













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

