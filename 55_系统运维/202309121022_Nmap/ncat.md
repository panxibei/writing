ncat

副标题：

英文：

关键字：





注意，以下链接删除==================================

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

注意，以上链接删除==================================







想要用 `Zabbix` 把 `Radius` 服务给监控起来，粗想想可能感觉简单。

用 `Ping` 呗，只要不通就可以判断服务器故障中断了。

可是有时候服务器是 `Ping` 得通的，网络是好的，但是服务可能停了。

这种情况下怎么办呢？

要不监控服务？

只要服务是运行中，就算它是正常工作的。

这样看似解决了问题，实际上仔细再想想，要是服务是运行的，可它无法提供正常的认证验证服务也是故障状态啊！

看来问题没有那么简单！



说了这么多，到底怎么做才算合理呢？

我们如果从 `Radius` 提供服务这个角度来看问题的话，那么自然很容易得出一个结论，那就是只要它能正常返回认证响应就算它的状态正常，否则就算它处于故障状态。

再说得直白点，你给它发个请求 `Access-Request` ，它如果能正确返回响应信息（ `SUCCESS` 或者 `FAILURE` ），不管验证是成功还是失败，我们就可以认为它的状态就是OK的，反之则NG。

好，道理讲明白了，那具体如何做呢？



首先，我们要让 `Zabbix` 发出一个请求信号。

怎么整？

我查遍了互联网，有一篇老外的文章启发了我。

大概的做法是，通过调用 `Shell` 脚本来实现。

不过他用的是 `Ncat` 这类的网络工具程序，发送 `UDP` 包到 `Radius` 服务器的 `1812` 端口。

理论是可行的，我也做了很多尝试，但是非常复杂，不太容易实现。



原因有二，一是 `Ncat` 只是个网络工具，它并不了解如何构造 `Access-Request` 请求包。

然而按照老外作者的意思，直接使用抓包后的数据包来模拟发送，这完全是行不通的。

因为现在一般的身份验证方法不会使用低级方法，所以用这种方法发送请求无法处理多次返回的响应。



另一个原因是，即使你能成功发送合法的请求包，但是 `Radius` 返回的响应包要你自己去抓取，这个要想通过简单的操作来实现几乎不太可能。

基于以上原因，以及根据我实际操作实验结果，最终放弃此类方案。



虽然失败了，但是老外文章的想法却给了我新的思路。

一是，可以利用 `zabbix` 的外部检查脚本。

二是，既然 `Ncat` 不行，那么我换一个可以正常请求的客户端程序不就行了嘛！

事实证明，我的新思路完全行的通！



### 开启外部检查脚本

在构造脚本之前，我们要做一些工作来开启脚本执行的配置。

对于外部检查脚本来说，我们只需要在 `zabbix` 配置文件 `/etc/zabbix/zabbix_server.conf` 中，开启 `ExternalScripts` 参数。

```
ExternalScripts=/usr/lib/zabbix/externalscripts
```

图b01



开启后，我们就可以把自己写的脚本放到 `externalscripts` 目录，比如 `checkradius.sh` ，然后在监控项中调用它。



接着添加监控项时，我们就可以按照如下语法填写键值了。

```
script[<parameter1>,<parameter2>,...]
```



哦，光看这个有点懵是吧，那还是边举例边解释吧！

这个 `script` 就是你要执行检查的脚本，比如 `checkradius.sh` 。

后面的参数 `parameter` 则要看你的脚本需要了。

我这儿的脚本不需要参数，那么监控项键值可以这么写。

```
checkradius.sh[192.168.1.123]
```

图b02



如果测试出错了，就需要根据实际情况做出调整。

比如我遇到的 `Permission denied` ，指的是脚本执行被拒绝。

图b03



这种情况下可能是我们编写的脚本忘记给它执行权限了，简单地处理一下。

```
chmod +x checkradius.sh
```



### 寻找高级身份验证的客户端程序

外部检查脚本开启了，接下来的工作就是编写脚本内容了。

正如前面所说，既然 `Ncat` 不行，那么我就换一个可以正常请求的客户端程序。

有吗？

还真有！



得意于以前曾经粗浅地研究过 `freeRadius` ，其中有不少是用于检测 `Radius` 服务是否正常工作的客户端程序。

在众多的程序中，我找到一个叫作 `eapol_test` 的客户端程序。

为啥是它，而不是 `radtest` 或是 `radclient` 呢？

因为 `eapol_test` 支持验证 `MSCHAPv2` 。



前面也说过了，现在用得比较多的都是企业级的高级身份验证方法，而 `MSCHAPv2` 是其中一种。

如果用其他的客户端，那么是无法做到使用这些高级身份验证方法的。

这个 `eapol_test` 是 `wpa_supplicant` 工具集中的一名成员，它并不天然地存在于已经安装的 `freeRadius` 程序中，而是需要单独编译安装的。

当然这也是像我这种初学者容易迷糊的地方，明明安装好了 `freeRadius` 却无法做到验证 `MSCHAPv2` 。

以下是 `eapol_test` 的编译安装方法，有了它你就可以顺利地验证 `MSCHAPv2` 了。





首先要安装一些依赖程序。

```
# Centos/RHEL
sudo yum groupinstall "Development Tools"
sudo yum install git openssl-devel pkgconfig libnl3-devel

# Ubuntu/Debian
sudo apt-get install git libssl-dev devscripts pkg-config libnl-3-dev libnl-genl-3-dev
```



接着开始编译安装。

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



其实编译 `eapol_test` 只需要 `freeRadius` 的 `ci` 目录中的文件即可，**文末有下载**，像 `git` 之类的并非必需。

另外文末下载中还提供了 `Windows` 版的 `eapol_test.exe` ，方便手头只 `Windows` 的小伙伴来测试 `Radius` 。



在 `Linux` 下切换到 `ci` 目录，找到 `eapol_test-build.sh` 文件。

记得先给编译脚本文件赋予可执行权限。

```
chmod +x eapol_test-build.sh
```

图d01



然后执行，很快就可以编译好。

图d02

图d03



将编译好的执行文件复制一份到统一的执行文件目录中，这样可以在任何地方调用它。

```
cp ./eapol_test/eapol_test /usr/local/bin/
```



复制好后，加个 `-h` 来测试一下命令是否有效。

图d04



化繁为简，我们可以这样写。

```
eapol_test -c EAP配置文件 -a 主机IP -p 端口 -s 共享密码
```



其他都好说，只不过这个配置文件要怎么写呢？

我查了很多资料，总结一下也可以简写成这样。

```
network={
  key_mgmt=WPA-EAP
  eap=PEAP
  identity="testuser"
  password="12345678"
  phase2="auth=MSCHAPV2"
}
```



`identity` 是用户名，`password` 自然就是密码了。

把上面的代码保存为一个配置文件，比如 `eap-peap.conf` 。

然后我们就可以开始测试了，像这样。

```
eapol_test -c eap-peap.conf -a 192.168.1.123 -p 1812 -s testing123
```

* `-c` : `EAP` 配置文件
* `-a` : `Radius` 服务器 `IP`
* `-p` : `Radius` 服务器端口
* `-s` : `Radius` 服务器共享密码



执行命令，屏幕一番眼花缭乱的翻滚后，我们看到了最后出现了一个 `SUCCESS` 的字样。

图d05



当然，你用 `Windows` 版的 `eapol_test` 命令也能做到一模一样的效果。

图c01



回过头来，在服务器一侧也能看到审核成功的日志事件。

图c02



### 优化脚本输出结果



脚本执行，监控结果出来一大堆的字符，这让我们也不方便判断啊！

不过经过观察，输出结果的最后几个字符，正常情况下是 `SUCCESS` ，而失败的话则是 `FAILURE` 。

那我们就只取结果的最后一行吧。

图d06



不过这样的字符串还是不太好处理，我们还可以再将它加工一下 。

我们利用预处理来写一段简单的 `JavaScript` 代码。

取输出结果的最后 `7` 个字符，如果是 `SUCCESS` 则返回 `1` ，否则返回 `0` 。

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



再来测试一下效果，不错，得到了结果是 `1` 或 `0` 这样的数字了。

图d08



不过别着急高兴，这是在 `Radius` 正常工作的情况下没啥问题，如果要是工作不正常的情况下呢？

我们把 `Radius` 服务停止或者断开网络，没想到监控项直接来个执行超时，关键是没有返回任何结果。

图d09



这并不是我们希望看到的，没有结果可不行，因为没法判断是不是正常了，至少应该是 `0` 对吧！

因此我们要加个超时的时间限制，如果超过时限，则返回 `0` 。

嗯，是时候请出 `timelimit` 了！



### `timelimit`

`timelimit` 是用来设置程序运行超时后可以主动停止运行程序的程序。

虽然有点绕口，但是它在很多场景的确是非常有用。

不过它也不是系统自带的，需要我们手动编译安装，还好方法非常简单。



如下步骤编译安装 `timelimit` （文末下载）。

解压缩。

```
tar zxvf timelimit-1.x.x.tar.gz
```

图e01



不用 `configure` 啥的，直接使用它自带的安装脚本安装即可。

```
cd timelimit-1.x.x
./build-and-test-all.pl
```

图e02



瞬间生成执行文件 `timelimit` 。

图e03



将它复制到执行文件大本营，方便以后调用。

```
cp ./timelimit /usr/local/bin
```



OK，这时就可以用 `timelimit` 来改造原来的检查脚本了。

```
timelimit <参数> <想要执行的命令>
```



像下面这样子。

```
timelimit -T 1 -t 1 eapol_test -c /foo/eap-peap.conf -a 192.168.1.123 -p 1812 -s testing123
```

`timelimt` 的参数解释：

* `-T` 杀掉程序的时限
* `-t` 等待程序的时限

上面的命令大概意思是在1秒钟内如果 `eapol_test` 还没结束，那么就停止它。

`eapol_test` 会在网络状态不佳的情况下多次尝试连接 `Radius` 服务，在被中止运行后会返回 `FAILURE` 。



嗯，这就完了吗？

不不不，还得改改 `zabbix` 的配置文件，因为配置文件中也有一个超时限制。

不过如果你嫌这个超时限制太短了，那么就需要将它搞大一点，要不还没等脚本执行完就已经超时被迫停止了。

通常是 `timelimit` 的超时时间应该小于 `Timeout` 的超时时间。

```
# 将超时修改为5秒或10秒（默认我这儿是4秒）
Timeout=5
```

图e04



OK，用新脚本再测试一下。

太棒了， `Radius` 服务器在不工作时，脚本成功返回结果 `0` ！

图e05



### 创建触发器

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









**`zabbix` 监控 `Radius` 相关文件**

* `Linux` 
  * `checkradius.sh` : 外部检查脚本（ `1K` ）
  * `eap-peap.conf` : `Radius` 客户端 `MSCHAPV2` 验证配置文件（ `1K` ）
  * `ci.7z` : `eapol_test` 客户端命令编译源代码（ `16K` ，用于验证 `MSCHAPV2` ）
  * `timelimit-1.9.2.tar.gz` : `timelimit` 编译源代码（ `15K` ）

* `Windows` 
  * `eapol_test.exe` : `eapol_test` 客户端执行文件（ `6.4M` ，用于验证 `MSCHAPV2` ）



下载链接：









**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc