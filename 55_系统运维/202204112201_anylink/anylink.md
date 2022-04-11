anylink

副标题：

英文：

关键字：









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

