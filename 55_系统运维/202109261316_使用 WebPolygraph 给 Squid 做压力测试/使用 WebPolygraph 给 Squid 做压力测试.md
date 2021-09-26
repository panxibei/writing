使用 WebPolygraph 给 Squid 做压力测试

副标题：

英文：

关键字：





### 准备工作

系统：`Rocky LInux 8.4`



安装一些必要组件，有可能还有其他的，按实际需要安装即可。

```
dnf install unzip zlib-devel
```



另外，有个 `ldns` 好像不能直接安装，所以需要我们手动给它安装上。

下载链接：https://www.nlnetlabs.nl/downloads/ldns/

```
dnf install ldns unbound-devel
wget https://www.nlnetlabs.nl/downloads/ldns/ldns-1.7.0.tar.gz
tar zxvf ldns-1.7.0.tar.gz
cd ldns-1.7.0
./configure
make
make install
```



### 安装 `Polygraph`

从官网下载最新安装源码包。

官网链接：http://www.web-polygraph.org/downloads/



```
wget http://www.web-polygraph.org/downloads/srcs/polygraph-4.13.0-src.tgz
tar zxvf polygraph-4.13.0-src.tar.gz
cd polygraph-4.13.0
./configure
make
make install
```



### 概念介绍





### 简单使用

作为演示我们只需要简单地了解以下一些文件。

* 执行文件

  服务端： `/usr/local/bin/polygraph-server`

  客户端： `/usr/local/bin/polygraph-client`

* 工作负载配置文件

  示例配置文件：`/usr/local/share/polygraph/workloads/simple.pg`



好了，知道这几样简单的文件我们就可以开始测试了，需要注意的是，目前仅仅是演示用，并不能真正用于生产环境的测试。

测试的方法很简单，按以下命令行形式，先执行服务端，再执行客户端。

需要补充的是，同一终端窗口无法同时跑两个程序，所以你应该开启两个终端窗口，一个执行服务端，另一个执行客户端。



服务端命令。

```
/usr/local/bin/polygraph-server --config /usr/local/share/polygraph/workloads/simple.pg --verb_lvl 10
```



客户端命令。

```
/usr/local/bin/polygraph-client --config /usr/local/share/polygraph/workloads/simple.pg --verb_lvl 10
```



服务端运行后，它就会处于一个等待客户端的状态，此时并不会有什么请求和响应的信息反映。

一旦客户端上线，我们就可以看到服务端和客户端两边会同时不断地翻滚信息，客户端发送请求，服务端做出响应。

如果要终止程序，那只能手动按下 `Ctrl+C` 强制停止。

至于反馈出来的信息都是啥意思呢，一会儿后面会说。



可能这时有的小伙伴会注意到，怎么服务端和客户端所引用的配置文件是同一个文件呢？

其实那是因为我们在同一系统中操作的缘故。

打开配置文件 `simple.pg` 就会看到下面这样的内容。

```
Server S = {
    kind = "S101"; 
    contents = [ SimpleContent ];
    direct_access = contents;

    addresses = ['127.0.0.1:9090' ]; // where to create these server agents
};
```



很明显，服务端是跑在了 `127.0.0.1:9090` 这个回送地址，所以客户端只能在本机上运行并在原地踏步了。

因此，如果服务端与客户端是分开的，那么就要将这个地址修改为明确的IP地址了。

比如服务端IP是 `10.44.128.61` ，那么就应该像下面这样修改配置。

```
Server S = {
    kind = "S101"; 
    contents = [ SimpleContent ];
    direct_access = contents;

    addresses = ['10.44.128.61:9090' ]; // where to create these server agents
};
```



重点说明一下，要将 `polygraph` 客户端安装在 `Squid` 主机上，`polygraph` 服务端可以是同一台机器，也可以是单独一台机器。

如果两者所处同一台机器中，那么地址就用 `127.0.0.1` ；

如果是分开的，那么配置文件中的地址就应该修改为服务端的IP地址加端口号。



### 添加代理服务器测试

只需要在客户端命令行后添加 `--proxy`  参数即可。

```
/usr/local/bin/polygraph-client --config /usr/local/share/polygraph/workloads/simple.pg --verb_lvl 10 --proxy 10.44.0.100:3128
```





### 获取并解读二进制日志

在客户端命令行后添加 `--log`  参数，并指定日志路径即可。

```
/usr/local/bin/polygraph-client --config /usr/local/share/polygraph/workloads/simple.pg --verb_lvl 10 --log /tmp/clt.log
```



如要查看日志，用 `polygraph-lx` 命令即可。

```
/usr/local/bin/polygraph-lx /tmp/clt.log
```



上面这个是查看所有日志内容，其实也可以细分，比如下面那样加个 `--objects` 参数。

```
/usr/local/bin/polygraph-lx --objects rep.rptm.hist /tmp/clt.log
rep.rptm.hist:
# bin   min   max   count     %   acc% 
    3     2     2      26  4.42   4.42
    4     3     3     160 27.21  31.63
    5     4     4      89 15.14  46.77
    6     5     5      81 13.78  60.54
    7     6     6      18  3.06  63.61
    8     7     7      21  3.57  67.18
    9     8     8      30  5.10  72.28
   10     9     9      20  3.40  75.68
   11    10    10      25  4.25  79.93
   12    11    11      21  3.57  83.50
   13    12    12      17  2.89  86.39
   14    13    13      10  1.70  88.10
   15    14    14      10  1.70  89.80
   16    15    15       3  0.51  90.31
   17    16    16       5  0.85  91.16
   18    17    21       5  0.85  92.01
   23    22    58       6  1.02  93.03
   72    71   234       6  1.02  94.05
  365   364  1267       7  1.19  95.24
  830  1268  1351       6  1.02  96.26
  854  1364  1475       5  0.85  97.11
  882  1476  2807       6  1.02  98.13
 1123  2832  2975       6  1.02  99.15
 1142  2984  3431       5  0.85 100.00

/usr/local/bin/polygraph-lx --objects rep.rptm.mean /tmp/clt.log
rep.rptm.mean:           119.35
```

按官网文档的说法，解读一下日志内容的意思。

第三列 `max` 为最大响应时长，有 79.93% 的响应是小于11毫秒的，但是大约有 5% 交互事务花费超过了一秒钟，所以这样就会使得平均响应时间增加到了 119 毫秒。

