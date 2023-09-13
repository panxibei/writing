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







参考链接：

> 关于MSChapv2的客户端远程验证
>
> https://nbailey.ca/post/peap-freeradius/
>
> https://wiki.freeradius.org/guide/eduroam#tooling_eapol_test



> eapol_test (on Windows)
>
> https://github.com/janetuk/eapol_test
>
> https://wiki.geant.org/display/H2eduroam/Testing+with+eapol_test







安装依赖

```
# Centos/RHEL
sudo yum groupinstall "Development Tools"
sudo yum install git openssl-devel pkgconfig libnl3-devel

# Ubuntu/Debian
sudo apt-get install git libssl-dev devscripts pkg-config libnl-3-dev libnl-genl-3-dev
```



编译安装

```
# 克隆freeradius项目（其实没必要下载整个项目，只用到了其中的脚本，文末有下载）
git clone --depth 1 --no-single-branch https://github.com/FreeRADIUS/freeradius-server.git

# 切换到脚本目录
cd freeradius-server/scripts/ci/

# 运行编译脚本
./eapol_test-build.sh

# 拷贝安装到可执行目录
cp ./eapol_test/eapol_test /usr/local/bin/
```



其实编译 `eapol_test` 只需要 `ci` 目录中的文件即可，文末有下载。

另外文末下载中还提供了 `Windows` 版的 `eapol_test` ，方便使用 `Windows` 来测试 `Radius` 。





给编译脚本文件赋予可执行权限。

```
chmod +x eapol_test-build.sh
```

图d01



很快就编译好了。

图d02

图d03



将编译好的执行文件复制一份到统一的执行文件目录中。

```
cp ./eapol_test/eapol_test /usr/local/bin/
```



复制好后，加个 `-h` 来测试一下命令是否有效。

图d04







测试命令

```
eapol_test -c eap-peap.conf -a 192.168.1.123 -p 1812 -s testing123
```

* `-c` : `EAP` 配置文件
* `-a` : `Radius` 服务器 `IP`
* `-p` : `Radius` 服务器端口
* `-s` : `Radius` 服务器共享密码



图d05



输出最后几个字符，正常情况下是 `SUCCESS` 。

图d06



这样的字符串不太好处理，可以将它加工一下。

预处理 `JavaScript` 代码。

```
var strStatus = value.substr(-7);
if (strStatus == 'SUCCESS') {
  result = 1;
} else {
  result = 0;
}
return result;
```

图d07



再来测试一下效果，得到结果是 `1` 或 `0` 这样的数字了。

图d08



不过别慌，这是在 `Radius` 正常工作的情况下没啥问题，要是工作不正常的情况下呢？

没想到直接来个超时，而且也没有任何结果。

图d09



没有结果可不行，没法判断是不是正常了，至少应该是 `0` 吧！

因此我们要加个超时的时间限制。

请出 `timelimit` 。















编译安装 `timelimit` 。

解压

```
tar zxvf timelimit-1.x.x.tar.gz
```

图e01



使用它自带的安装脚本安装。

```
cd timelimit-1.x.x
./build-and-test-all.pl
```

图e02



生成执行文件 `timelimit` 。

图e03



将它复制到执行文件大本营，方便以后调用。

```
cp ./timelimit /usr/local/bin
```



OK，这时就可以用 `timelimit` 改造一下原来的脚本了。

```
timelimit -T 1 -t 1 eapol_test -c /foo/eap-peap.conf -a 192.168.1.123 -p 1812 -s testing123
```

`timelimt` 的参数解释：

* `-T` 杀掉程序的时限
* `-t` 等待程序的时限

参数在前，要执行的命令在最后。



这就完了吗？

别急，还得改改 `zabbix` 的配置文件，因为配置文件时也有一个超时限制。

不过这个超时限制太短了，我需要将它搞大一点，要不还没等脚本执行完就已经超时被迫停止了。

```
# 将超时修改为5秒或10秒（默认我这儿是4秒）
Timeout=5
```

图e04



再测试一下，`Radius` 服务器不工作时，成功返回结果 `0` 。

图e05



创建触发器

触发器的关键是表达式，按以下格式写。

```
/主机名/监控项值
```

这只是基本的表达式，还没有写比较，否则不能触发。

因此应该写成这样。

```
max(/host/checkradius.sh,2m)=0
```

意思是，主机 `host` 的监控项 `checkradius.sh` 在 `2` 分钟内的最大值是 `0` ，那么就触发。

具体时间（这里是 `2` 分钟）可以根据实际情况来写。

除了表达式外，只要简单地写上名称和严重性即可。

图f03



将 `Radius` 服务停止，看看会不会触发。

图f01



再将 `Radius` 服务启动，触发的问题解决了。

图f02



















**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc