Squid5安装

副标题：

英文：

关键字：





编译安装 `Squid`



安装所需组件。

```
dnf install gcc gcc-c++ perl
```





```
% tar xzf squid-2.6.RELEASExy.tar.gz
% cd squid-2.6.RELEASExy
% ./configure --with-MYOPTION --with-MYOPTION2 etc
% make
make install
```



最终 `Squid` 被安装到了以下位置。

```
/usr/local/squid
```





新建缓存

```
squid -z
```







```
chown -R nobody:nobody /usr/local/squid/var/cache
chown -R nobody:nobody /usr/local/squid/var/logs
chown -R nobody:nobody /usr/local/squid/var/run
```



禁止以后台守护进程形式运行，这样可以看到输出的错误日志。

```
squid -N
```







配置文件示例。

```ini
#
# Recommended minimum configuration:
#

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
#cache_dir ufs /usr/local/squid/var/cache/squid 100 16 256
cache_dir ufs /usr/local/squid/var/cache/squid 1024 16 256

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



测试方法

`squidclient`



`curl`



开机自动启动



以下面的代码加入到 `/etc/rc.d/rc.local` 文件中。

```
# Squid caching proxy
if [ -f /usr/local/squid/sbin/squid ]; then
        echo -n ' Squid'
        /usr/local/squid/sbin/squid
fi
```

图s01



注意图中上面的红框，也就是说明，它提示我们如果要启用这个 `rc.local` ，那么别忘记给这个文件赋予可执行权限，否则是无效的哦。

```
chmod +x /etc/rc.d/rc.local
```

