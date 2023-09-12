ncat

副标题：

英文：

关键字：



参考文章：

> Windows 下使用 nmap ncat 命令测试 UDP 端口连接
>
> http://www.taodudu.cc/news/show-3583006.html?action=onClick



> Zabbix: how to monitor Radius (and other services) with external check items and netcat (nc)
>
> https://blog.pierky.com/zabbix-how-to-monitor-radius-and-other-services-with-external-check-items-and-netcat-nc/





> Nmap for Windows Download
>
> https://nmap.org/download#windows









打开命令提示符窗口，进入 `Nmap` 目录。

```
cd C:\Program Files (x86)\Nmap
```



使用 `ncat` 命令测试 `UDP` 端口连接，语法如下：

```
ncat -z -v -u [主机名/IP] [端口号]
```

* `-z` 仅测试状态
* `-v` 显示详细交互信息
* `-u` 发送 `UDP` 数据包



举例：

```
ncat -z -v -u ntp.aliyun.com 123
```

返回：

```
Ncat: Version 7.94 ( https://nmap.org/ncat )
Ncat: Connected to 203.107.6.88:123.
Ncat: UDP packet sent successfully
Ncat: 1 bytes sent, 0 bytes received in 2.57 seconds.
```

图a01



同理，发送 `UDP` 包到 `Radius` 服务器，照抄就行了。

```
ncat -z -v -u xxx.xxx.xxx.xxx 1812
```

`xxx.xxx.xxx.xxx` 是 `Radius` 服务器的 `IP` 地址。

返回：

```
Ncat: Version 7.94 ( https://nmap.org/ncat )
Ncat: Connected to 172.22.15.232:1812.
Ncat: UDP packet sent successfully
Ncat: 1 bytes sent, 0 bytes received in 2.56 seconds.
```

图a02



但是光看状态（ `-z` ）不是我们想要的，我们要发送请求数据包给 `Radius` 服务器，再获取服务器返回的信息，从而判断服务器是否正常工作。

那么我们就需要做这么几步工作。

首先要有准备发送的数据包，其次将它发送出去，再次收到返回的数据包，最后判断是否OK。



用 `Ncat` 怎么发送 `Radius` 的请求数据包 `Access-Request` 呢？

反正 `Ncat` 是不懂啥叫 `Access-Request` 的，也不关心数据包里面有些啥，那么我们只能自己找个请求数据包，然后像快递打包一样准备好后让它给发出去就行。

这个请求数据包怎么来的，到哪去找呢？

其实很简单，用 `Wireshark` 这个抓包工具就行。



定位到 `Access-Request` 记录行，右键点击 `Radius Protocol` ，选择 `Export Selected Packet Bytes...` 。

说白了就是将我们实际的请求数据包导出为一个文件。

图a03



导出的文件名随便起，比如我这儿保存为 `TestRadius.dat` 。

将这个文件放到某处备用。

有了这个文件，我们要怎么将它发送呢？

我参考到的都是 `Linux` 上的做法，通常是用 `cat` 命令输出，可是 `Windows` 上没有 `cat` 命令啊！

于是我想到了 `type` 命令，这个很古早的 `DOS` 命令。

试试看就知道了。

```
type TestRadius.dat
```

结果会输出一堆乱码，没事，就是要这个效果。



接下来就是重点了！

我们将请求数据包 `type` 输出给 `ncat` 命令，那么 `ncat` 命令就会将它发送给指定的服务器。

问题是怎么让这两位协同合作呢？

答案是，用管道操作符！



写出来就明白了。

```
type TestRadius.dat | ncat -v -u xxx.xxx.xxx.xxx 1812
```

注意，`ncat` 参数里不要加 `-z` 了。

图a04



从返回的结果来看，数据包已经发送出去了，只是接收怎么是 `0` 呢？







开启外部检查

编辑 `zabbix` 配置文件 `/etc/zabbix/zabbix_server.conf` ，设置其中的 `ExternalScripts` 参数。

```
ExternalScripts=/usr/lib/zabbix/externalscripts
```

图b01



编写脚本，起个文件名叫作 `checkradius.sh` 。

```
#! /bin/bash
# Description: Radius – Authentication
# Type: External check
# Key: checkradius.sh[]
# Type of information: Numeric (unsigned)

cat /usr/lib/zabbix/externalscripts/$1.rad | nc -u -w 1 $1 1812 | grep "0000000 02" > /dev/null
if [ $? -eq 0 ]; then
    echo 1
    exit 1
else
    echo 0
    exit 0
fi
```

该脚本从 `$1.rad` 文件获取要发送到服务器的 `Radius` 数据包。

其中 `$1` 是主机名或 `IP` 地址，例如，`Radius` 服务器的 `IP` 是 `192.168.1.123` ，那么可以将访问请求数据包放到名为 `192.168.1.123.rad` 的文件中。

图b05



添加监控项，语法如下：

```
script[<parameter1>,<parameter2>,...]
```

光看这个肯定懵，还是边举例边解释吧！

这个 `script` 就是你要执行检查的脚本，比如 `checkradius.sh` 。

后面的参数 `parameter` 则要看你的脚本需要了。

我这儿的脚本需要一个参数，即 `Radius` 服务器的 `IP` 地址，那么监控项键值可以这么写。

```
checkradius.sh[192.168.1.123]
```

图b02





测试如果出错，就应该根据实际情况做出调整。

比如 `Permission denied` ，指的是脚本执行被拒绝。

图b03



这种情况下可能是我们编写的脚本没有执行权限，简单地处理如下。

```
chmod +x checkradius.sh
```



最后测试，看看返回的结果。

图b04

















**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc