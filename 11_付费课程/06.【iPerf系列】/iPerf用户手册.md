iPerf 用户手册

副标题：

英文：

关键字：









目录



什么是 `iPerf2/iPerf3` ？

`iPerf` 特性





1. [公共 iPerf3 服务器](https://iperf.fr/iperf-servers.php#public-servers)
2. [用于托管 iPerf3 服务器的脚本](https://iperf.fr/iperf-servers.php#host-iperf3)
3. [使用 Linux 模拟广域网延迟](https://iperf.fr/iperf-servers.php#netem)





1. [在 iPerf 2.0、iPerf 3.0 和 iPerf 3.1 之间切换](https://iperf.fr/iperf-doc.php#3change)
2. [iPerf 3 用户文档](https://iperf.fr/iperf-doc.php#3doc)
3. [在 iPerf 2.0.6、iPerf 2.0.7 和 iPerf 2.0.8 之间切换](https://iperf.fr/iperf-doc.php#change)
4. [iPerf 2 用户文档](https://iperf.fr/iperf-doc.php#doc)





## 什么是 iPerf / iPerf3 ？

iPerf3 是一种用于主动测量 IP 网络上最大可达到带宽的工具。 它支持调整与时序、缓冲区和协议相关的各种参数（TCP、UDP、SCTP 与 IPv4 和 IPv6）。 对于每个测试，它都会报告带宽、损耗和其他参数。 这是一个新的实现，它不与原始 iPerf 共享任何代码，并且 也不向后兼容。iPerf最初由[NLANR / DAST](https://iperf.fr/contact.php#authors)开发。 iPerf3主要由[ESnet](https://www.es.net/)/[劳伦斯伯克利国家实验室](https://www.lbl.gov/)开发。 它是在三条款[的BSD许可证](https://en.wikipedia.org/wiki/BSD_licenses)下发布的。

## iPerf 特性

- TCP 和 [SCTP](https://en.wikipedia.org/wiki/Stream_Control_Transmission_Protocol)
  - 测量带宽
  - 报告 MSS/MTU 大小和观察到的读取大小。
  - 通过套接字缓冲区支持 TCP 窗口大小。
- UDP
  - 客户端可以创建指定带宽的 UDP 流。
  - 测量数据包丢失
  - 测量[延迟抖动](https://en.wikipedia.org/wiki/Packet_delay_variation)
  - 支持组播
- 跨平台：Windows，Linux，Android，MacOS X，FreeBSD，OpenBSD，NetBSD，[VxWorks](https://en.wikipedia.org/wiki/VxWorks)，Solaris,...
- 客户端和服务器可以有多个同时连接（-P 选项）。
- 服务器处理多个连接，而不是在单个测试后退出。
- 可以运行指定的时间（-t 选项），而不是要传输的设定数据量（-n 或 -k 选项）。
- 以指定的时间间隔打印周期性、中间带宽、抖动和丢失报告（-i 选项）。
- 将服务器作为守护程序运行（-D 选项）
- 使用代表性流测试链路层压缩如何影响可实现的带宽（-F 选项）。
- 服务器同时接受单个客户端 （iPerf3） 同时接受多个客户端 （iPerf2）
- 新增：忽略 TCP 慢启动（-O 选项）。
- 新增：为 UDP 和（新）TCP 设置目标带宽（-b 选项）。
- 新增：设置 IPv6 流标签（-L 选项）
- 新增：设置拥塞控制算法（-C选项）
- 新增功能：使用 SCTP 而不是 TCP（--sctp 选项）
- 新增：JSON 格式的输出（-J 选项）。
- 新增：磁盘读取测试（服务器：iperf3 -s / 客户端：iperf3 -c 测试主机 -i1 -F 文件名）
- 新增：磁盘写入测试（服务器：iperf3 -s -F 文件名/客户端：iperf3 -c 测试主机 -i1）











## 公共 iPerf3 服务器

iPerf3 服务器一次只允许一个 iPerf 连接。不支持同时进行多个测试。 如果测试正在进行中，则会显示以下消息：“iperf3：错误 - 服务器正忙于运行测试。请稍后再试”

| [欧洲](https://iperf.fr/iperf-servers.php#europe)            |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------ | ------------ | ------------------------------------------------------------ |
| iPerf3 服务器                                                | 地方化                                                       | 数据中心                                                     | 好客                                                         | 速度                                                         | 港口                           | IP 版本      | 联系                                                         |
| **iperf.par2.as49434.net**                                   | 法国 法兰西岛                                                | DC和谐托管                                                   | [![Harmony Hosting](https://iperf.fr/images/logo_harmony_hosting.png)](https://harmony.hosting/) | 40 千兆位/秒                                                 | 9200 TCP/UDP 到 9240 TCP/UDP   | IPv4 和 IPv6 | [@g_marsot](https://twitter.com/g_marsot)                    |
| **paris.testdebit.info lille.testdebit.info lyon.testdebit.info aix-marseille.testdebit.info bordeaux.testdebit.info** | 法国 巴黎 法国 里尔 法国 里昂 法国 普罗旺斯 地区艾克斯 法国 波尔多 | 布伊格 电信数据中心                                          | [![Bouygues Telecom](https://iperf.fr/images/logo_bouygues_telecom.png)](https://www.bouyguestelecom.fr/) | 10 千兆位/秒 10 千兆位/秒 10 千兆位/秒 10 千兆位/秒   10 千兆位/秒 | 9200 TCP/UDP 到 9240 TCP/UDP   | IPv4 和 IPv6 | [@lafibreinfo](https://twitter.com/lafibreinfo)              |
| **speed.as208196.net**                                       | 法国 法兰西岛                                                | [莫吉1 楠泰尔](https://www.google.fr/maps/place/moji/@48.8806067,2.2182703,186m/data=!3m2!1e3!4b1!4m5!3m4!1s0x47e66e3c2d73e135:0xe97da9165527c949!8m2!3d48.8805914!4d2.2187747) | [![AS208196](https://iperf.fr/images/logo_as208196.png)](https://as208196.net/) | 10 千兆位/秒                                                 | 5200 TCP/UDP 到 5209 TCP/UDP   | IPv4 或 IPv6 | [@DorianGaliana](https://twitter.com/DorianGaliana)          |
| **ping.online.net ping6.online.net ping-90ms.online.net ping6-90ms.online.net** | 法国 法兰西岛                                                | [Scaleway Vitry DC3](https://www.google.fr/maps/place/61+Rue+Julian+Grimau,+94400+Vitry-sur-Seine/@48.77479,2.3794436,301m/data=!3m1!1e3!4m2!3m1!1s0x47e673f578c8e219:0x53f9662e2d821ffb) | [![online.net](https://iperf.fr/images/logo_scaleway.png)](https://www.scaleway.com/) | 10 千兆位/秒                                                 | 5200 TCP/UDP 到 5209 TCP/UDP   | IPv4 或 IPv6 | [米克马克](https://lafibre.info/iperf/online-iperf/msg180514/#msg180514) |
| **speedtest.serverius.net** （端口 5002：添加 **-p 5002**）  | 荷兰                                                         | 服务器 数据中心                                              | [![Serverius datacenters](https://iperf.fr/images/logo_serverius.png)](https://serverius.net/) | 10 千兆位/秒                                                 | 5002 TCP/UDP                   | IPv4 和 IPv6 | [@serveriusbv](https://twitter.com/serveriusbv)              |
| **nl.iperf.014.fr**                                          | 荷兰                                                         | 下一代网络数据中心                                           | [![014.fr](https://iperf.fr/images/logo_014.png)](https://014.fr/) | 1 千兆位/秒                                                  | 10415 TCP/UDP 到 10420 TCP/UDP | 仅限 IPv4    | [@014_fr](https://twitter.com/014_fr)                        |
| **ch.iperf.014.fr**                                          | 瑞士 苏黎世                                                  | 主机孵化 数据中心                                            | [![014.fr](https://iperf.fr/images/logo_014.png)](https://014.fr/) | 3 千兆位/秒                                                  | 15315 TCP/UDP 到 15320 TCP/UDP | 仅限 IPv4    | [@014_fr](https://twitter.com/014_fr)                        |
| **iperf.eenet.ee**                                           | 爱沙尼亚                                                     | [EENet Tartu](https://www.google.fr/maps/place/Tartu,+Estonie/) | [![EENet](https://iperf.fr/images/logo_eenet.png)](https://www.eenet.ee/) |                                                              | 5201 TCP/UDP                   | 仅限 IPv4    | [@EENet_HITSA](https://twitter.com/EENet_HITSA)              |
| **iperf.astra.in.ua**                                        | 乌克兰 利沃夫                                                | [阿斯特拉利沃夫](https://www.google.fr/maps/place/ASTRA:+your+star+Internet/@49.8137147,24.0379979,181m/data=!3m1!1e3!4m5!3m4!1s0x473ae792a53f6883:0xa708ef57c029c32f!8m2!3d49.813673!4d24.0384111?hl=fr) | [![Астра](https://iperf.fr/images/logo_astra.png)](https://astra.in.ua/) | 10 千兆位/秒                                                 | 5201 TCP/UDP 到 5206 TCP/UDP   | IPv4 和 IPv6 | noc@astra.in.ua                                              |
| **iperf.volia.net**                                          | 乌克兰                                                       | [沃利亚基辅](https://www.google.fr/maps/place/Kikvidze+St,+1%2F2,+Kyiv,+Ukraine/@50.4182095,30.5498797,373m/data=!3m1!1e3!4m2!3m1!1s0x40d4cf6ea4eb9f77:0x6e651c039c8a501a!6m1!1e1?hl=fr) | [![ВОЛЯ](https://iperf.fr/images/logo_volia.png)](http://volia.com/) |                                                              | 5201 TCP/UDP                   | 仅限 IPv4    | [@voliaofficial](https://twitter.com/voliaofficial)          |
|                                                              |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| [亚洲](https://iperf.fr/iperf-servers.php#asia)              |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| iPerf3 服务器                                                | 地方化                                                       | 数据中心                                                     | 好客                                                         | 速度                                                         | 港口                           | IP 版本      | 联系                                                         |
| **speedtest.uztelecom.uz**                                   | 乌兹别克斯坦 塔什干                                          | [信息系统](https://www.google.fr/maps/place/Infosystems/@41.3251919,69.3170839,297m/data=!3m1!1e3!4m13!1m7!3m6!1s0x38ae8b0cc379e9c3:0xa5a9323b4aa5cb98!2z0KLQsNGI0LrQtdC90YIsINCj0LfQsdC10LrQuNGB0YLQsNC9!3b1!8m2!3d41.2994958!4d69.2400734!3m4!1s0x38aef51e34ce0557:0xf2b8c867a43a0792!8m2!3d41.3253678!4d69.3173564) | [![Uztelecom](https://iperf.fr/images/logo_uztelecom.png)](https://uztelecom.uz/) | 10 千兆位/秒                                                 | 5200 TCP/UDP 到 5209 TCP/UDP   | IPv4 和 IPv6 | [@KhurshidSuyunov](https://twitter.com/KhurshidSuyunov)      |
| **iperf.it-north.net**                                       | 哈萨克斯坦                                                   | [彼得罗巴甫尔](https://www.google.fr/maps/place/Petropavl+150000,+Kazakhstan/@54.8738729,69.0904091,12z/data=!3m1!4b1!4m2!3m1!1s0x43b23a383d9aa3dd:0x5349226c95938f6f) | [![Kazakhtelecom](https://iperf.fr/images/logo_kazakhtelecom.png)](http://telecom.kz/) | 1 千兆位/秒                                                  | 5200 TCP/UDP 到 5209 TCP/UDP   | 仅限 IPv4    | [布劳宁格·](mailto:baf@it-north.net)                         |
| **iperf.biznetnetworks.com**                                 | 印度尼西亚                                                   | [Biznet - 西芒吉斯中央广场 酒店](https://www.google.fr/maps/place/Biznet+Technovillage/@-6.4353143,106.8969055,251m/data=!3m1!1e3!4m8!1m2!2m1!1sBiznet+Networks+Jl.+Biznet+Technovillage+No.+1+16965+Cimanggis+West+Java,+Indonesia!3m4!1s0x0000000000000000:0xe794f80c0724e861!8m2!3d-6.435587!4d106.8971158) | [![Biznet Networks](https://iperf.fr/images/logo_biznetnetworks.png)](http://www.biznetnetworks.com/) | 1 千兆位/秒                                                  | 5201 TCP 到 5203 TCP           | IPv4 和 IPv6 | [Biznet 网络](http://www.biznetnetworks.com/)                |
|                                                              |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| [大洋洲](https://iperf.fr/iperf-servers.php#oceania)         |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| iPerf3 服务器                                                | 地方化                                                       | 数据中心                                                     | 好客                                                         | 速度                                                         | 港口                           | IP 版本      | 联系                                                         |
| **speedtest-iperf-akl.vetta.online**                         | 新西兰奥 克兰                                                | 维塔在线 奥克兰                                              | [![Vetta Online](https://iperf.fr/images/logo_vetta.png)](https://www.vetta.online/) | 10 千兆位/秒                                                 | 5200 TCP 到 5209 TCP           | 仅限 IPv4    | [联系](https://www.vetta.online/contact/)                    |
|                                                              |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| [美洲](https://iperf.fr/iperf-servers.php#americas)          |                                                              |                                                              |                                                              |                                                              |                                |              |                                                              |
| iPerf3 服务器                                                | 地方化                                                       | 数据中心                                                     | 好客                                                         | 速度                                                         | 港口                           | IP 版本      | 联系                                                         |
| **iperf.scottlinux.com**                                     | 美国加利福尼亚州                                             | [飓风 弗里蒙特 2](https://www.google.fr/maps/place/Hurricane+Electric/@37.4717128,-121.9207521,305m/data=!3m1!1e3!4m2!3m1!1s0x808fc6197a0be5dd:0x75e712aca8e3ac5e) | [![scottlinux.com](https://iperf.fr/images/logo_scottlinux.png)](https://scottlinux.com/) | 1 千兆位/秒                                                  | 5201 TCP/UDP                   | IPv4 和 IPv6 | [@scottlinux](https://twitter.com/scottlinux)                |
| **iperf.he.net**                                             | 美国加利福尼亚州                                             | [飓风 弗里蒙特 1](https://www.google.fr/maps/place/Hurricane+Electric/@37.489826,-121.9309676,128m/data=!3m1!1e3!4m2!3m1!1s0x808fc644b35fd311:0xee25ef985cd52aef) | [![he.net](https://iperf.fr/images/logo_hurricane_electric.png)](https://he.net/) |                                                              | 5201 TCP/UDP                   | IPv4 和 IPv6 | [高等教育论坛](https://forums.he.net/)                       |

要添加/删除公共iPerf3服务器，请将其报告给[@lafibreinfo](https://twitter.com/lafibreinfo)



------

## 使用 Linux 托管 iPerf3 服务器的脚本（Ubuntu / Debian）

iPerf3 不允许对一台服务器进行多次测试 => 由于没有消息 **iperf3：error - 服务器正忙于运行测试，**因此必须启动多个 iPerf 进程。 稍后重试
Systemd 脚本以启动 41 iPerf3 服务器（端口 9200 到端口 9240）。

sudo adduser iperf --**disabled-login --gecos iperf**
**sudo nano /etc/systemd/system/iperf3-server@.service**

> ```
> [Unit]
> Description=iperf3 server on port %i
> After=syslog.target network.target
> 
> [Service]
> ExecStart=/usr/bin/iperf3 -s -1 -p %i
> Restart=always
> RuntimeMaxSec=3600
> User=iperf
> 
> [Install]
> WantedBy=multi-user.target
> DefaultInstance=5201
> ```

“重新启动 = 总是”允许在一小时后重新启动 iperf3（运行时最大秒 = 3600），以限制无响应或 iperf3 服务器突然结束时的情况。

sudo systemctl **daemon-reload**
要在服务器启动时激活 iperf3：
**对于 $（seq 9200 9240）中的 p;sudo systemctl 是否启用 iperf3-server@$p ; done**

> ```
> $ for p in $(seq 9200 9240); do sudo systemctl enable iperf3-server@$p ; done
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9200.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9201.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9202.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9203.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9204.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9205.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9206.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9207.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9208.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9209.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9210.service → /etc/systemd/system/iperf3-server@.service.
> Created symlink /etc/systemd/system/multi-user.target.wants/iperf3-server@9211.service → /etc/systemd/system/iperf3-server@.service.
> ...
> ```

**须藤重启**

------

要查看 iPerf3 的状态和日志：

sudo systemctl status iperf3-server@* **sudo journalctl -u iperf3-server@\***

------

在启动服务器时禁用 iperf3 ：

**对于 $（seq 9200 9240） 中的 p;sudo systemctl 禁用 iperf3-server@$p ; 完成**

------

## 使用 Linux 模拟广域网延迟

[NetEm](https://www.linuxfoundation.org/collaborate/workgroups/networking/netem)（已在 Linux 内核中启用）通过模拟广域网的属性，为测试协议提供了网络仿真功能。

要模拟 80 毫秒的额外延迟，只需键入 **sudo tc qdisc 添加 dev eth0 根 netem 延迟 80ms**
它只是为从本地以太网传出的所有数据包增加了固定的延迟量。

要停止额外的延迟，只需键入 **sudo tc qdisc change dev eth0 根 netem 延迟 0ms** 在**退出 0** 之前添加到文件 /**etc/rc.local** 的行，以增加 40ms

的延迟：

> ```
> # Add +40ms latency
> tc qdisc add dev eth0 root netem delay 40ms
> ```

注意：如果您的网络接口不是 eth0，请将 **eth0** 替换为网络接口的名称











## 在 iPerf 2.0、iPerf 3.0 和 iPerf 3.1 之间切换

- iPerf2 目前支持的 iPerf3 功能：
  - TCP 和 UDP 测试
  - 设置端口 （-p）
  - 设置 TCP 选项：无延迟、MSS 等
  - 设置 UDP 带宽 （-b）
  - 设置套接字缓冲区大小 （-w）
  - 报告间隔 （-i）
  - 设置 iPerf 缓冲区 （-l）
  - 绑定到特定接口 （-B）
  - IPv6 测试 （-6）
  - 要传输的字节数 （-n）
  - 测试长度 （-t）
  - 并行流 （-P）
  - 设置 DSCP/TOS 位向量 （-S）
  - 更改数字输出格式 （-f）

- iPerf 3.0 中的新功能：
  - 动态服务器（客户端/服务器参数交换）– iPerf2 中的大多数服务器选项现在可以由客户端动态设置
  - 客户端/服务器结果交换
  - iPerf3 服务器同时接受单个客户端（对于 iPerf2，多个客户端同时接受）
  - iPerf API （libiperf） – 提供一种使用、自定义和扩展 iPerf 功能的简单方法
  - -R，反向测试模式 - 服务器发送，客户端接收
  - -O， --omit N ：省略前 n 秒（忽略 [TCP 慢启动](https://en.wikipedia.org/wiki/Slow-start)）)
  - -b， --bandwidth n[KM] for TCP（仅适用于 IPERF 2 的 UDP）：将目标带宽设置为 n 位/秒（UDP 默认为 1 Mbit/秒，TCP 为无限制）。
  - -V， --verbose ：比以前更详细的输出
  - -J， --json：JSON格式的输出
  - -Z， --zerocopy ：使用“零拷贝”sendfile（） 方法来发送数据。这使用更少的 CPU。
  - -T， --title str ： 在每个输出行前面加上这个字符串
  - -F， --文件名 ： xmit/recv 指定的文件
  - -A， --affinity n/n，m ： 设置 CPU 亲和力 （内核从 0 开始编号 - 仅限 Linux 和 FreeBSD）
  - -k， --blockcount #[KMG]：要传输的块（数据包）数（而不是 -t 或 -n）
  - -4， --版本4 ： 仅使用 IPv4
  - -6， --版本6 ： 仅使用 IPv6
  - -L， --flowlabel ：设置 IPv6 流标签（仅限 Linux）
  - -C， --linux-congestion ： set congestion control algorithm （仅限 Linux 和 FreeBSD） （iPerf2 中的 -Z）
  - -d， --debug ：发出调试输出。主要（也许完全）用于开发人员。
  - -s， --server ： iPerf2 可以处理多个客户端请求。iPerf3一次只允许一个iperf连接。

- iPerf 3.1 中的新功能：
  - -I， --pidfile 文件使用进程 ID 写入一个文件，在作为守护程序运行时最有用。
  - --cport ：指定客户端端口。
  - --sctp 使用 SCTP 而不是 TCP（Linux、FreeBSD 和 Solaris）。
  - --udp-counters-64bit ：支持长时间运行的UDP测试，这可能会导致计数器溢出
  - --日志文件文件：将输出发送到日志文件。

- iPerf2 不支持的 iPerf3 功能：
  - 双向测试 （-d / -r）
  - 从标准输入传输的数据 （-I）
  - TTL ：生存时间，用于组播 （-T）
  - 排除 C（连接） D（数据） M（多播） S（设置） V（服务器） 报告 （-x）
  - 以逗号分隔值 （-y） 的形式报告
  - 兼容模式允许与旧版本的 iPerf （-C） 一起使用





## iPerf 3 用户文档

| 一般选项                               |                                                              |
| -------------------------------------- | ------------------------------------------------------------ |
| 命令行选项                             | 描述                                                         |
| **-p**， --端口 ***n***                | 服务器要侦听和客户端连接的服务器端口 自。这在客户端和服务器中应该相同。默认值为 5201。 |
| -**-端口** ***n***                     | 用于指定客户端端口的选项。（iPerf 3.1 中的新功能）           |
| **-f**， --格式 ***[公里公里]***       | 指定用于打印带宽数字的格式的字母。 支持的格式是 自适应格式根据需要在千和兆之间进行选择。`  'k' = Kbits/sec      'K' = KBytes/sec   'm' = Mbits/sec      'M' = MBytes/sec` |
| **-i**， --区间 ***n***                | 设置周期带宽、抖动、 和损失报告。如果非零值，则自上次报告以来*每隔几秒*的带宽进行一次报告。如果为零，则无周期性 打印报告。默认值为零。 |
| **-F**， --文件名                      | **客户端：**从文件中读取并写入网络，而不是使用随机数据; **服务器端：**从网络读取并写入文件，而不是丢弃数据。 |
| **-A**， --亲和力 n***/n，m-F***       | 如果可能的话，设置 CPU 关联（仅限 Linux 和 FreeBSD）。在客户端和服务器上，您可以通过以下方式设置本地相关性 使用此参数的 n 形式（其中 n 是 CPU 编号）。此外，在客户端，您可以覆盖服务器的 仅对那一个测试的亲和力，使用 n，m 形式的参数。请注意，使用此功能时，进程只会绑定 到单个 CPU（与包含潜在多个 CPU 的集合相反）。 |
| **-B**， --绑定***主机***              | 绑定到***主机***，这是此计算机的地址之一。对于客户 这将设置出站接口。对于服务器，这将设置传入 接口。这仅在具有多个多宿主主机上有用 网络接口。 |
| **-V**， --详细                        | 提供更详细的输出                                             |
| **-J**， --json                        | JSON格式的输出                                               |
| -**-日志文件**文件                     | 将输出发送到日志文件。（iPerf 3.1 中的新功能）               |
| -**-d**， --调试                       | 发出调试输出。主要（也许完全）用于开发人员。                 |
| **-v**， --version                     | 显示版本信息并退出。                                         |
| **-h**， --帮助                        | 显示帮助概要并退出。                                         |
|                                        |                                                              |
| 服务器特定选项                         |                                                              |
| 命令行选项                             | 描述                                                         |
| **-s**， --服务器                      | 在服务器模式下运行 iPerf。（这将一次只允许一个 iperf 连接）  |
| **-D**， --守护进程                    | 在后台将服务器作为守护程序运行。                             |
| **-I**， --pidfile***file***           | 使用进程 ID 编写文件，这在作为守护程序运行时最有用。（iPerf 3.1 中的新功能） |
|                                        |                                                              |
| 客户端特定选项                         |                                                              |
| 命令行选项                             | 描述                                                         |
| **-c**， --客户端***主机***            | 在客户端模式下运行 iPerf，连接到***主机上***运行的 iPerf 服务器。 |
| **--中科**                             | 使用SCTP而不是TCP（Linux，FreeBSD和Solaris）。（iPerf 3.1 中的新功能） |
| **-u**， --udp                         | 使用 UDP 而不是 TCP。另请参见 [-b](https://iperf.fr/iperf-doc.php#3bandwidth) 选项。 |
| **-b**， --带宽 ***n[公里]***          | 将目标带宽设置为 n 位/秒（UDP 默认为 1 Mbit/秒，TCP 默认为无限制）。如果有多个流（-P 标志）， 带宽限制单独应用于每个流。您还可以在带宽说明符中添加“/”和数字。 这称为“突发模式”。它将在不暂停的情况下发送给定数量的数据包，即使暂时超过指定的带宽限制也是如此。 |
| **-t**， --time ***n***                | 要传输的时间（以秒为单位）。iPerf 通常通过重复发送一个 ***len*** 字节数组来工作，以获得***时间***秒。 默认值为 10 秒。另请参见 -[l](https://iperf.fr/iperf-doc.php#3len)、[-k](https://iperf.fr/iperf-doc.php#3blockcount) 和 [-n](https://iperf.fr/iperf-doc.php#3num) 选项。 |
| **-n**， --num ***n[KM]***             | 要传输的缓冲区数。通常，iPerf 发送 10 秒。-n 选项会覆盖它并发送一个 ***len*** *字节数组*的次数，无论这需要多长时间。另请参见 -[l](https://iperf.fr/iperf-doc.php#3len)、[-k](https://iperf.fr/iperf-doc.php#3blockcount) 和 [-t](https://iperf.fr/iperf-doc.php#3time) 选项。 |
| **-k**， --blockcount ***n[KM]***      | 要传输的块（数据包）数。（而不是 -t 或 -n） 另请参见 -[t](https://iperf.fr/iperf-doc.php#3time)、[-l](https://iperf.fr/iperf-doc.php#3len) 和 [-n](https://iperf.fr/iperf-doc.php#3num) 选项。 |
| **-l**， --length ***n[KM]***          | 要读取或写入的缓冲区的长度。iPerf 通过编写 ***len*** 字节数组多次。TCP 的默认值为 128 KB，UDP 的默认值为 8 KB。 另请参见 -[n](https://iperf.fr/iperf-doc.php#3num)、[-k](https://iperf.fr/iperf-doc.php#3blockcount) 和 [-t](https://iperf.fr/iperf-doc.php#3time) 选项。 |
| **-P**， --并行 ***n***                | 要与服务器同时建立的连接数。默认值为 1。                     |
| **-R**， --反向                        | 以反向模式运行（服务器发送，客户端接收）。                   |
| **-w**， --window ***n[KM]***          | 将套接字缓冲区大小设置为指定值。对于 TCP，这 设置 TCP 窗口大小。（这被发送到服务器并在该侧使用） |
| **-M**， --set-mss ***n***             | 尝试设置 TCP 最大段大小 （MSS）。MSS 通常是 MTU - 40 字节用于 TCP/IP 标头。 对于以太网，MSS 为 1460 字节（1500 字节 MTU）。 |
| **-N**， --无延迟                      | 设置 TCP 无延迟选项，禁用 Nagle 算法。 通常，这只对 telnet 等交互式应用程序禁用。 |
| **-4**， --版本4                       | 仅使用 IPv4。                                                |
| **-6**， --版本4                       | 仅使用 IPv6。                                                |
| **-S**， --tos ***n***                 | 传出数据包的服务类型。（许多路由器忽略 TOS 字段。您可以在十六进制中指定带有“0x”前缀的值，在八进制中指定值 前缀为“0”，或十进制。例如，“0x10”十六进制 = “020” 八进制 = “16” 十进制。RFC 1349 中指定的 TOS 编号为：`  IPTOS_LOWDELAY   minimize delay    0x10   IPTOS_THROUGHPUT  maximize throughput  0x08   IPTOS_RELIABILITY maximize reliability 0x04   IPTOS_LOWCOST   minimize cost     0x02` |
| **-L**， --flowlabel ***n***           | 设置 IPv6 流标签（目前仅在 Linux 上受支持）。                |
| **-Z**， --零拷贝                      | 使用“零拷贝”方法来发送数据，例如 sendfile（2），而不是通常的 write（2）。这使用更少的 CPU。 |
| **-o**， --省略 ***n***                | 省略测试的前 n 秒，以跳过 TCP [TCP 慢启动](https://en.wikipedia.org/wiki/Slow-start)周期。 |
| **-T， --title \**\*str\**\***         | 在每个输出行前面加上此字符串的前缀。                         |
| **-C**， --linux-congestion ***algo*** | 设置[拥塞控制算法](https://en.wikipedia.org/wiki/TCP_congestion-avoidance_algorithm)（Linux 仅适用于 iPerf 3.0，Linux 和 FreeBSD 仅适用于 iPerf 3.1）。 |

















## 在 iPerf 2.0.6、iPerf 2.0.7 和 iPerf 2.0.8 之间切换

- 2.0.6 更改集 （rjmcmahon@rjmcmahon.com） 2014 年 <> 月：
  - 增加报表标头的共享内存，减少互斥锁争用。需要提高性能。应独立于平台/操作系统的次要代码更改

- 2.0.7 更改集 （rjmcmahon@rjmcmahon.com） 2014 年 <> 月：
  - 支持端到端延迟的仅限 Linux 版本（假设时钟同步）
  - 支持更小的报告间隔（5 毫秒或更长）
  - UDP（平均值/最小值/最大值）的结束/结束延迟，以毫秒为单位显示，分辨率为微秒
  - 套接字读取超时（仅限服务器），因此无论是否未收到数据包，都会发生 iperf 报告
  - 报表时间戳现在显示毫秒分辨率
  - 本地绑定支持使用冒号作为分位数的端口值 （-B 10.10.10.1：60001）
  - 使用 Linux 实时调度程序和数据包级别时间戳来提高延迟准确性
  - 建议在客户端和服务器上使用 PTP 将时钟同步到微秒
  - 为PTP大师推荐一个高质量的参考，例如来自Spectracom等公司的GPS纪律振荡器

- 2.0.8 变更集（截至12年2015月<>日）：
  - 修复可移植性，使用 Linux、Win10、Win7、WinXP、MacOS 和 Android 进行编译和测试
  - 客户端现在需要 -u 表示 UDP（不再默认为 UDP 和 -b）
  - 维护旧版报表格式
  - 支持 -e 获取增强的报告
  - 支持使用令牌桶的 TCP 速率限制流（通过 -b）
  - 通过 pps 作为单位支持每秒数据包数 （UDP）（例如 -b 1000pps）
  - 在客户端和服务器报告 （UDP） 中显示 PPS
  - 支持实时调度程序作为命令行选项（--realtime或-z）
  - 改进客户端 tx 代码路径，以便实际 tx 提供速率将收敛到 -b 值
  - 提高微秒级延迟呼叫的准确性（以独立于平台的方式）
  - （使用卡尔曼滤波器预测延迟误差并根据预测误差调整延迟）
  - 在初始客户端标头 （UDP） 中显示目标循环时间
  - 修复从服务器发送到客户端 （UDP） 的最终延迟报告
  - 在延迟输出中包含标准偏差
  - 抑制不切实际的延迟输出 （-/-/-/-）
  - 支持发送时SO_SNDTIMEO，因此套接字写入不会阻止超过 -t （TCP）
  - 如果可用，请使用clock_gettime（优先于 gettimeofday（））
  - TCP 写入和错误计数（TCP 重试和 Linux 的 CWND）
  - TCP 读取计数、TCP 读取直方图（8 个箱）
  - 服务器将在 -t 秒无流量后关闭套接字

另请参阅 https://sourceforge.net/projects/iperf2/



## iPerf 2 用户文档

| ![iPerf](https://iperf.fr/images/logo_iperf_command.png) | ![img](https://iperf.fr/images/white.png) | [调整 TCP](https://iperf.fr/iperf-doc.php#tuningtcp) 连接 [调整 UDP 连接](https://iperf.fr/iperf-doc.php#tuningudp)    运行[多播服务器和客户端](https://iperf.fr/iperf-doc.php#multicast)  [IPv6 模式](https://iperf.fr/iperf-doc.php#ipv6)  [代表流](https://iperf.fr/iperf-doc.php#repmode)  将 iPerf 作为[守护程序](https://iperf.fr/iperf-doc.php#daemon)  运行 [将 iPerf 作为 Windows 服务](https://iperf.fr/iperf-doc.php#service)  运行 [自适应窗口大小](https://iperf.fr/iperf-doc.php#adaptive)  [编译](https://iperf.fr/iperf-doc.php#compiling) |
| -------------------------------------------------------- | ----------------------------------------- | ------------------------------------------------------------ |
|                                                          |                                           |                                                              |

| 一般选项                                           |                 |                                                              |
| -------------------------------------------------- | --------------- | ------------------------------------------------------------ |
| 命令行选项                                         | 环境变量选项    | 描述                                                         |
| **-f**， --format ***[bkmaBKMA]***                 | $IPERF格式      | 指定用于打印带宽数字的格式的字母。 支持的格式是 自适应格式根据需要在千和兆之间进行选择。领域 除带宽外，始终打印字节，否则遵循 请求的格式。默认值为“a”。 ***注意：***这里公斤 = 1024， 处理字节时，Mega = 1024^2 和 Giga = 1024^3。通常在网络中， Kilo = 1000，Mega = 1000^2，Giga = 1000^3，所以我们在处理时使用它 位。如果这真的困扰你，请使用 -f b 并做数学运算。`  'b' = bits/sec      'B' = Bytes/sec   'k' = Kbits/sec      'K' = KBytes/sec   'm' = Mbits/sec      'M' = MBytes/sec   'g' = Gbits/sec      'G' = GBytes/sec   'a' = adaptive bits/sec  'A' = adaptive Bytes/sec` |
| **-i**， --区间***#***                             | $IPERF_间隔     | 设置周期带宽、抖动、 和损失报告。如果非零值，则自上次报告以来*每隔几秒*的带宽进行一次报告。如果为零，则无周期性 打印报告。默认值为零。 |
| **-l**， --len ***#[KM]***                         | $IPERF_LEN      | 要读取或写入的缓冲区的长度。iPerf 通过编写 ***len*** 字节数组多次。TCP 的默认值为 8 KB，1470 UDP 的字节数。请注意，对于UDP，这是数据报大小，使用时需要减小 IPv6 寻址到 1450 或更低，以避免分段。另请参见 [-n](https://iperf.fr/iperf-doc.php#num) 和 [-t](https://iperf.fr/iperf-doc.php#time) 选项。 |
| **-m**， --print_mss                               | $IPERF_打印_MSS | 打印报告的 TCP MSS 大小（通过TCP_MAXSEG选项）和 观察到的读取大小通常与 MSS 相关。MSS 通常是 MTU - 40 字节用于 TCP/IP 标头。通常稍小的 MSS 是 由于 IP 选项中存在额外的标头空间而报告。接口类型 还打印了与 MTU 对应的 MTU（以太网、FDDI 等）。这 选项未在许多操作系统上实现，但读取大小可能仍会 表示 MSS。 |
| **-p**， --port***#***                             | $IPERF_端口     | 服务器要侦听和客户端连接的服务器端口 自。这在客户端和服务器中应该相同。默认值为 5001， 与 TTCP 相同。 |
| **-u**， --udp                                     | $IPERF_UDP      | 使用 UDP 而不是 TCP。另请参见 [-b](https://iperf.fr/iperf-doc.php#bandwidth) 选项。 |
| **-w**， --window ***#[KM]***                      | $TCP_窗口_大小  | 将套接字缓冲区大小设置为指定值。对于 TCP，这 设置 TCP 窗口大小。对于UDP，它只是数据报的缓冲区 接收，因此限制了最大的应收数据报大小。 |
| **-B**， --绑定***主机***                          | $IPERF_绑定     | 绑定到***主机***，这是此计算机的地址之一。对于客户 这将设置出站接口。对于服务器，这将设置传入 接口。这仅在具有多个多宿主主机上有用 网络接口。对于 UDP 服务器模式下的 iPerf，这也用于绑定和加入 多播组。使用 224.0.0.0 到 239.255.255.255 范围内的地址 对于多播。另请参见 [-T](https://iperf.fr/iperf-doc.php#ttl) 选项。 |
| **-C**， --兼容性                                  | $IPERF_兼容     | 兼容模式允许与旧版本的 iPerf 一起使用。此模式 不是互操作性所必需的，但强烈建议这样做。在 在某些情况下，使用代表性流式处理可能会导致 1.7 服务器 崩溃或导致意外的连接尝试。 |
| **-M**， --mss ***#[KM}***                         | $IPERF_MSS      | 尝试通过TCP_MAXSEG设置 TCP 最大段大小 （MSS） 选择。MSS 通常是 MTU - 40 字节用于 TCP/IP 标头。为 以太网，MSS 为 1460 字节（1500 字节 MTU）。此选项不是 在许多操作系统上实现。 |
| **-N**， --nodelay                                 | $IPERF_无延迟   | 设置 TCP 无延迟选项，禁用 Nagle 算法。通常 这仅适用于 Telnet 等交互式应用程序。 |
| **-V**（从 v1.6 或更高版本开始）                   | .               | 绑定到 IPv6 地址 服务器端： $ iperf -s -V客户端： $ iperf -c <服务器 IPv6 地址> -V  注意：在版本 1.6.3 及更高版本上，特定 IPv6 地址 不需要绑定 [-B](https://iperf.fr/iperf-doc.php#bind) 选项，以前的 1.6 版本确实如此。同样在大多数操作系统上使用此选项也将响应IPv4 使用 IPv4 映射地址的客户端。 |
| **-h**， --帮助                                    |                 | 打印出命令摘要并退出。                                       |
| **-v**， --version                                 |                 | 打印版本信息并退出。打印“线程”（如果编译） POSIX 线程，如果使用 Microsoft Win32 线程编译，则为 'win32 线程'， 或“单线程”，如果在没有线程的情况下编译。 |
|                                                    |                 |                                                              |
| 服务器特定选项                                     |                 |                                                              |
| 命令行选项                                         | 环境变量选项    | 描述                                                         |
| **-s**， --服务器                                  | $IPERF_服务器   | 在服务器模式下运行 iPerf。（iPerf2 可以处理多个客户端请求）  |
| **-D**（从 v1.2 或更高版本开始）                   | .               | 在 Win32 平台上将服务器作为守护程序（Unix 平台） 运行 在服务可用的情况下，iPerf 将开始作为服务运行。 |
| **-R**（仅适用于 Windows，从 v1.2 或更高版本开始） | .               | 删除 iPerf 服务（如果它正在运行）。                          |
| **-o**（仅适用于 Windows，从 v1.2 或更高版本开始） | .               | 将输出重定向到给定文件。                                     |
| **-c**， --客户端***主机***                        | $IPERF_客户端   | 如果 iPerf 处于服务器模式，则使用 -c 指定主机 将限制 iPerf 将接受的到指定***主机***的连接。不适用于 UDP。 |
| **-P**， --并行***#***                             | $IPERF_并行     | 服务器之前要处理的连接数 关闭。默认值为 0（表示永久接受连接）。 |
|                                                    |                 |                                                              |
| 客户端特定选项                                     |                 |                                                              |
| 命令行选项                                         | 环境变量选项    | 描述                                                         |
| **-b**， --带宽 ***#[KM]***                        | $IPERF_带宽     | 要发送的 UDP 带宽，以位/秒为单位。这意味着 -u 选项。 默认值为 1 Mbit/秒。 |
| **-c**， --客户端***主机***                        | $IPERF_客户端   | 在客户端模式下运行 iPerf，连接到***主机上***运行的 iPerf 服务器。 |
| **-d**， --双重测试                                | $IPERF_双重测试 | 在双重测试模式下运行 iPerf。这将导致服务器连接 返回到 [-L](https://iperf.fr/iperf-doc.php#listenport) 选项中指定的端口上的客户端（或缺省值 到客户端连接到服务器的端口）。这是立即完成的 因此同时运行测试。如果你想要一个交替 测试尝试 [-r。](https://iperf.fr/iperf-doc.php#tradeoff) |
| **-n**， --num ***#[KM]***                         | $IPERF_NUM      | 要传输的缓冲区数。通常，iPerf 发送 10 秒。-n 选项会覆盖它并发送一个 ***len*** *字节数组*的次数，无论这需要多长时间。另请参见 [-l](https://iperf.fr/iperf-doc.php#len) 和 [-t](https://iperf.fr/iperf-doc.php#time) 选项。 |
| **-r**， --权衡                                    | $IPERF_权衡     | 在权衡测试模式下运行 iPerf。这将导致服务器连接 返回到 [-L](https://iperf.fr/iperf-doc.php#listenport) 选项中指定的端口上的客户端（或缺省值 到客户端连接到服务器的端口）。这是在下面完成的 客户端连接终止，因此运行测试 交替。如果你想要同时测试，请尝试 [-d。](https://iperf.fr/iperf-doc.php#dualtest) |
| **-t**， --time***#***                             | $IPERF_时间     | 要传输的时间（以秒为单位）。iPerf 通常通过以下方式工作 重复发送 ***len*** 字节数组以表示***时间***秒。 默认值为 10 秒。另请参见 [-l](https://iperf.fr/iperf-doc.php#len) 和 [-n](https://iperf.fr/iperf-doc.php#num) 选项。 |
| **-L**， --listenport***#***                       | $IPERF_听端口   | 这指定服务器将连接回的端口 客户端打开。它默认为用于连接到服务器的端口 从客户端。 |
| **-P**， --并行***#***                             | $IPERF_并行     | 要与服务器同时建立的连接数。违约 为 1。需要客户端和服务器上的线程支持。 |
| **-S**， --tos***#***                              | $IPERF_TOS      | 传出数据包的服务类型。（许多路由器忽略 TOS 字段。您可以在十六进制中指定带有“0x”前缀的值，在八进制中指定值 前缀为“0”，或十进制。例如，“0x10”十六进制 = “020” 八进制 = “16” 十进制。RFC 1349 中指定的 TOS 编号为：`  IPTOS_LOWDELAY   minimize delay    0x10   IPTOS_THROUGHPUT  maximize throughput  0x08   IPTOS_RELIABILITY maximize reliability 0x04   IPTOS_LOWCOST   minimize cost     0x02` |
| **-T**， --ttl***#***                              | $IPERF_TTL      | 传出组播数据包的生存时间。这本质上是 要通过的路由器跃点数，也用于范围。 默认值为 1，本地链路。 |
| **-F**（从 v1.2 或更高版本开始）                   | .               | 使用代表性流来测量带宽，例如：- $ iperf -c <服务器地址> -F <文件名> |
| **-I**（从 v1.2 或更高版本开始）                   | .               | 与 -F 相同，来自标准输入。                                   |



------

## 调整 TCP 连接

iPerf 的主要目标是帮助调整特定路径上的 TCP 连接。最 TCP 的基本调优问题是 TCP 窗口大小，它控制在任何一个点网络中可以有多少数据。 如果它太小，发送方有时会空闲并得到较差的性能。用于 TCP 窗口大小是***带宽延迟积***，

> 瓶颈带宽 * 往返时间

在下面的modi4/cyclops示例中，瓶颈链路是45 Mbit/sec DS3链路，使用ping测量的往返时间为42毫秒。 带宽延迟积为

> 45 Mb/秒 * 42 ms
> = （45e6） * （42e-3）
> = 1890000 位
> = 230 KB

这是确定最佳窗口大小的起点;将其设置得更高或更低可能会产生更好的结果。 在我们的示例中，超过 130K 的缓冲区大小并没有提高性能，尽管带宽延迟积为 230K。

请注意，许多操作系统和主机对 TCP 窗口大小有上限。 这些可能低至 64 KB，也可能高达几 MB。iPerf 尝试检测何时发生这些情况，并发出警告，指出实际窗口大小和请求的窗口大小为 不相等（如下所示，尽管这是由于 IRIX 中的四舍五入）。 有关 TCP 窗口大小的详细信息，请参阅 [LaFibre.info](https://lafibre.info/tester-son-debit/ping-systeme-exploitation/)。 下面是伊利诺伊州的节点 1 和北卡罗来纳州的节点 2 之间的示例会话。它们通过 vBNS 主干网和 45 Mbit/s DS3 链路连接。 请注意，我们使用适当的 TCP 窗口大小将带宽性能提高了 3 倍。 在允许以字节粒度设置窗口大小的平台上使用自适应窗口大小功能。

> ```
> node2> iperf -s
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 60.0 KByte (default)
> ------------------------------------------------------------
> [  4] local <IP Addr node2> port 5001 connected with <IP Addr node1> port 2357
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-10.1 sec   6.5 MBytes   5.2 Mbits/sec
> 
> node1> iperf -c node2
> ------------------------------------------------------------
> Client connecting to node1, TCP port 5001
> TCP window size: 59.9 KByte (default)
> ------------------------------------------------------------
> [  3] local <IP Addr node1> port 2357 connected with <IP Addr node2> port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec   6.5 MBytes   5.2 Mbits/sec
> ```
>
> ------
>
> ```
> node2> iperf -s -w 130k
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size:  130 KByte
> ------------------------------------------------------------
> [  4] local <IP Addr node 2> port 5001 connected with <IP Addr node 1> port 2530
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-10.1 sec  19.7 MBytes  15.7 Mbits/sec
> 
> node1> iperf -c node2 -w 130k
> ------------------------------------------------------------
> Client connecting to node2, TCP port 5001
> TCP window size:  129 KByte (WARNING: requested  130 KByte)
> ------------------------------------------------------------
> [  3] local <IP Addr node1> port 2530 connected with <IP Addr node2> port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec  19.7 MBytes  15.8 Mbits/sec
> ```

要做的另一个测试是运行并行 TCP 流。 如果总聚合带宽大于单个流获得的带宽，则有问题。 要么是TCP窗口大小太小，要么是操作系统的TCP实现有bug，要么是网络本身有缺陷。 有关 TCP 窗口大小，请参见上文;否则诊断有些困难。 如果 iPerf 是使用 pthreads 编译的，则单个客户端和服务器可以对此进行测试，否则在不同的端口上设置多个客户端和服务器。 下面是一个示例，其中单个流获得 16.5 Mbit/秒，但两个并行流 共同获得 16.7 + 9.4 = 26.1 Mbit/秒，即使使用较大的 TCP 窗口大小也是如此：

> ```
> node2> iperf -s -w 300k
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size:  300 KByte
> ------------------------------------------------------------
> [  4] local <IP Addr node2> port 5001 connected with <IP Addr node1> port 6902
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-10.2 sec  20.9 MBytes  16.5 Mbits/sec
> 
> [  4] local <IP Addr node2> port 5001 connected with <IP Addr node1> port 6911
> [  5] local <IP Addr node2> port 5001 connected with <IP Addr node2> port 6912
> [ ID] Interval       Transfer     Bandwidth
> [  5]  0.0-10.1 sec  21.0 MBytes  16.7 Mbits/sec
> [  4]  0.0-10.3 sec  12.0 MBytes   9.4 Mbits/sec
> 
> node1> ./iperf -c node2 -w 300k
> ------------------------------------------------------------
> Client connecting to node2, TCP port 5001
> TCP window size:  299 KByte (WARNING: requested  300 KByte)
> ------------------------------------------------------------
> [  3] local <IP Addr node2> port 6902 connected with <IP Addr node1> port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.2 sec  20.9 MBytes  16.4 Mbits/sec
> 
> node1> iperf -c node2 -w 300k -P 2
> ------------------------------------------------------------
> Client connecting to node2, TCP port 5001
> TCP window size:  299 KByte (WARNING: requested  300 KByte)
> ------------------------------------------------------------
> [  4] local <IP Addr node2> port 6912 connected with <IP Addr node1> port 5001
> [  3] local <IP Addr node2> port 6911 connected with <IP Addr node1> port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-10.1 sec  21.0 MBytes  16.6 Mbits/sec
> [  3]  0.0-10.2 sec  12.0 MBytes   9.4 Mbits/sec
> ```

TCP 的辅助调谐问题是最大传输单元 （MTU）。 为了最有效，两台主机都应支持路径 MTU 发现。 没有路径 MTU 发现的主机通常使用 536 作为 MSS，这会浪费带宽和处理时间。 使用 -m 选项显示正在使用的 MSS，并查看这是否与预期匹配。 以太网通常约为 1460 字节。

> ```
> node3> iperf -s -m
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 60.0 KByte (default)
> ------------------------------------------------------------
> [  4] local <IP Addr node3> port 5001 connected with <IP Addr node4> port 1096
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0- 2.0 sec   1.8 MBytes   6.9 Mbits/sec
> [  4] MSS size 1448 bytes (MTU 1500 bytes, ethernet)
> [  4] Read lengths occurring in more than 5% of reads:
> [  4]   952 bytes read   219 times (16.2%)
> [  4]  1448 bytes read  1128 times (83.6%)
> ```

下面是不支持路径 MTU 发现的主机。它只会发送和接收小的 576 字节数据包。

> ```
> node4> iperf -s -m
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 32.0 KByte (default)
> ------------------------------------------------------------
> [  4] local <IP Addr node4> port 5001 connected with <IP Addr node3> port 13914
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0- 2.3 sec   632 KBytes   2.1 Mbits/sec
> WARNING: Path MTU Discovery may not be enabled.
> [  4] MSS size 536 bytes (MTU 576 bytes, minimum)
> [  4] Read lengths occurring in more than 5% of reads:
> [  4]   536 bytes read   308 times (58.4%)
> [  4]  1072 bytes read    91 times (17.3%)
> [  4]  1608 bytes read    29 times (5.5%)
> ```

iPerf 支持其他调谐选项，这些选项是为特殊网络情况（如 ATM 上的 HIPPI 到 HIPPI ）添加的。

## 调整 UDP 连接

iPerf 创建恒定比特率 UDP 流。这是一个非常人工的流，类似于语音通信，但除此之外没有太多。

您需要将数据报大小 （-l） 调整为应用程序使用的大小。

服务器通过数据报中的 ID 号检测 UDP 数据报丢失。 通常，一个UDP数据报会变成几个IP数据包。丢失单个 IP 数据包将丢失整个数据报。 要测量数据包丢失而不是数据报丢失，请使用 -l 选项使数据报足够小以适合单个数据包。 默认大小为 1470 字节适用于以太网。还会检测到无序数据包。 （无序数据包会导致丢失的数据包计数有些不明确; iPerf 假定它们不是重复的数据包，因此它们将从丢失的数据包计数中排除。 由于TCP不会向用户报告丢失，因此我发现UDP测试有助于查看路径上的数据包丢失。

抖动计算由服务器连续计算，指定如下： RFC 1889 中的 RTP。客户端在 包。服务器将相对传输时间计算为 （服务器的接收时间） - 客户端的发送时间）。客户端和服务器的时钟不需要 同步;在抖动计算中减去任何差异。抖动 是连续运输时间之间差值的平滑平均值。

> ```
> node2> iperf -s -u -i 1
> ------------------------------------------------------------
> Server listening on UDP port 5001
> Receiving 1470 byte datagrams
> UDP buffer size: 60.0 KByte (default)
> ------------------------------------------------------------
> [  4] local <IP Addr node2> port 5001 connected with <IP Addr node1> port 9726
> [ ID] Interval       Transfer     Bandwidth       Jitter   Lost/Total Datagrams
> [  4]  0.0- 1.0 sec   1.3 MBytes  10.0 Mbits/sec  0.209 ms    1/  894 (0.11%)
> [  4]  1.0- 2.0 sec   1.3 MBytes  10.0 Mbits/sec  0.221 ms    0/  892 (0%)
> [  4]  2.0- 3.0 sec   1.3 MBytes  10.0 Mbits/sec  0.277 ms    0/  892 (0%)
> [  4]  3.0- 4.0 sec   1.3 MBytes  10.0 Mbits/sec  0.359 ms    0/  893 (0%)
> [  4]  4.0- 5.0 sec   1.3 MBytes  10.0 Mbits/sec  0.251 ms    0/  892 (0%)
> [  4]  5.0- 6.0 sec   1.3 MBytes  10.0 Mbits/sec  0.215 ms    0/  892 (0%)
> [  4]  6.0- 7.0 sec   1.3 MBytes  10.0 Mbits/sec  0.325 ms    0/  892 (0%)
> [  4]  7.0- 8.0 sec   1.3 MBytes  10.0 Mbits/sec  0.254 ms    0/  892 (0%)
> [  4]  8.0- 9.0 sec   1.3 MBytes  10.0 Mbits/sec  0.282 ms    0/  892 (0%)
> [  4]  0.0-10.0 sec  12.5 MBytes  10.0 Mbits/sec  0.243 ms    1/ 8922 (0.011%)
> 
> node1> iperf -c node2 -u -b 10m
> ------------------------------------------------------------
> Client connecting to node2, UDP port 5001
> Sending 1470 byte datagrams
> UDP buffer size: 60.0 KByte (default)
> ------------------------------------------------------------
> [  3] local <IP Addr node1> port 9726 connected with <IP Addr node2> port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec  12.5 MBytes  10.0 Mbits/sec
> [  3] Sent 8922 datagrams
> ```

请注意，当使用较大的 32 KB 数据报时，由于数据报重组而导致的抖动更高，每个数据报拆分为 23 个 1500 字节的数据包。 此处看到的较高数据报丢失可能是由于流量的突发性，即 23 个背靠背数据包，然后是很长的数据包 暂停，而不是均匀分布的单个数据包。

> ```
> node2> iperf -s -u -l 32k -w 128k -i 1
> ------------------------------------------------------------
> Server listening on UDP port 5001
> Receiving 32768 byte datagrams
> UDP buffer size:  128 KByte
> ------------------------------------------------------------
> [  3] local <IP Addr node2> port 5001 connected with <IP Addr node1> port 11303
> [ ID] Interval       Transfer     Bandwidth       Jitter   Lost/Total Datagrams
> [  3]  0.0- 1.0 sec   1.3 MBytes  10.0 Mbits/sec  0.430 ms    0/   41 (0%)
> [  3]  1.0- 2.0 sec   1.1 MBytes   8.5 Mbits/sec  5.996 ms    6/   40 (15%)
> [  3]  2.0- 3.0 sec   1.2 MBytes   9.7 Mbits/sec  0.796 ms    1/   40 (2.5%)
> [  3]  3.0- 4.0 sec   1.2 MBytes  10.0 Mbits/sec  0.403 ms    0/   40 (0%)
> [  3]  4.0- 5.0 sec   1.2 MBytes  10.0 Mbits/sec  0.448 ms    0/   40 (0%)
> [  3]  5.0- 6.0 sec   1.2 MBytes  10.0 Mbits/sec  0.464 ms    0/   40 (0%)
> [  3]  6.0- 7.0 sec   1.2 MBytes  10.0 Mbits/sec  0.442 ms    0/   40 (0%)
> [  3]  7.0- 8.0 sec   1.2 MBytes  10.0 Mbits/sec  0.342 ms    0/   40 (0%)
> [  3]  8.0- 9.0 sec   1.2 MBytes  10.0 Mbits/sec  0.431 ms    0/   40 (0%)
> [  3]  9.0-10.0 sec   1.2 MBytes  10.0 Mbits/sec  0.407 ms    0/   40 (0%)
> [  3]  0.0-10.0 sec  12.3 MBytes   9.8 Mbits/sec  0.407 ms    7/  401 (1.7%)
> 
> node1> iperf -c node2 -b 10m -l 32k -w 128k
> ------------------------------------------------------------
> Client connecting to node2, UDP port 5001
> Sending 32768 byte datagrams
> UDP buffer size:  128 KByte
> ------------------------------------------------------------
> [  3] local <IP Addr node2> port 11303 connected with <IP Addr node1> port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec  12.5 MBytes  10.0 Mbits/sec
> [  3] Sent 401 datagrams
> ```



------

## 组 播

要测试多播，请在设置绑定选项（-B、--bind）的情况下运行多个服务器 到多播组地址。运行客户端，连接到多播 组地址并根据需要设置 TTL（-T、--ttl）。与普通的TCP和 UDP测试中，组播服务器可能会在客户端启动后启动。在这种情况下， 在服务器启动之前发送的数据报在第一个周期中显示为损失 报告（下面有 61 个关于 ARNO 的数据报）。

> ```
> node5> iperf -c 224.0.67.67 -u --ttl 5 -t 5
> ------------------------------------------------------------
> Client connecting to 224.0.67.67, UDP port 5001
> Sending 1470 byte datagrams
> Setting multicast TTL to 5
> UDP buffer size: 32.0 KByte (default)
> ------------------------------------------------------------
> [  3] local <IP Addr node5> port 1025 connected with 224.0.67.67 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0- 5.0 sec   642 KBytes   1.0 Mbits/sec
> [  3] Sent 447 datagrams
> 
> node5> iperf -s -u -B 224.0.67.67 -i 1
> ------------------------------------------------------------
> Server listening on UDP port 5001
> Binding to local address 224.0.67.67
> Joining multicast group  224.0.67.67
> Receiving 1470 byte datagrams
> UDP buffer size: 32.0 KByte (default)
> ------------------------------------------------------------
> [  3] local 224.0.67.67 port 5001 connected with <IP Addr node5> port 1025
> [ ID] Interval       Transfer     Bandwidth       Jitter   Lost/Total Datagrams
> [  3]  0.0- 1.0 sec   131 KBytes   1.0 Mbits/sec  0.007 ms    0/   91 (0%)
> [  3]  1.0- 2.0 sec   128 KBytes   1.0 Mbits/sec  0.008 ms    0/   89 (0%)
> [  3]  2.0- 3.0 sec   128 KBytes   1.0 Mbits/sec  0.010 ms    0/   89 (0%)
> [  3]  3.0- 4.0 sec   128 KBytes   1.0 Mbits/sec  0.013 ms    0/   89 (0%)
> [  3]  4.0- 5.0 sec   128 KBytes   1.0 Mbits/sec  0.008 ms    0/   89 (0%)
> [  3]  0.0- 5.0 sec   642 KBytes   1.0 Mbits/sec  0.008 ms    0/  447 (0%)
> 
> node6> iperf -s -u -B 224.0.67.67 -i 1
> ------------------------------------------------------------
> Server listening on UDP port 5001
> Binding to local address 224.0.67.67
> Joining multicast group  224.0.67.67
> Receiving 1470 byte datagrams
> UDP buffer size: 60.0 KByte (default)
> ------------------------------------------------------------
> [  3] local 224.0.67.67 port 5001 connected with <IP Addr node5> port 1025
> [ ID] Interval       Transfer     Bandwidth       Jitter   Lost/Total Datagrams
> [  3]  0.0- 1.0 sec   129 KBytes   1.0 Mbits/sec  0.778 ms   61/  151 (40%)
> [  3]  1.0- 2.0 sec   128 KBytes   1.0 Mbits/sec  0.236 ms    0/   89 (0%)
> [  3]  2.0- 3.0 sec   128 KBytes   1.0 Mbits/sec  0.264 ms    0/   89 (0%)
> [  3]  3.0- 4.0 sec   128 KBytes   1.0 Mbits/sec  0.248 ms    0/   89 (0%)
> [  3]  0.0- 4.3 sec   554 KBytes   1.0 Mbits/sec  0.298 ms   61/  447 (14%)
> ```

如上所述启动多个客户端或服务器，将数据发送到同一多播服务器。 （如果您有多台服务器侦听多播地址，则每个服务器都将获取数据）



------

## IPv6 模式

- 

  使用“ifconfig”命令获取节点的IPv6地址。 使用 -V 选项指示您使用的是 IPv6 地址 请注意，我们还需要显式绑定服务器地址。服务器端： $ iperf -s -V客户端： $ iperf -c <服务器IPv6地址> -V>注意：iPerf 版本 1.6.2 和 eariler 要求显式绑定 IPv6 地址 使用 [-B](https://iperf.fr/iperf-doc.php#bind) 选项表示服务器。



------

## 使用代表性流测量带宽

- 

  使用 -F 或 -I 选项。如果要测试网络的性能 使用压缩/未压缩流，只需创建代表性流和 使用 -F 选项对其进行测试。这通常是由于链接层 压缩数据。-F 选项用于文件输入。 -I 选项用于来自标准输入。 例如 客户端： $ iperf -c <服务器地址> -F <文件名> 客户端： $ iperf -c <服务器地址>  -I



------

## 将服务器作为守护程序运行

- 

  使用 -D 命令行选项将服务器作为守护程序运行。重定向 输出到文件。 例如 iperf -s -D > iperflog。这将使 iPerf 服务器运行 作为守护程序，服务器消息将记录在文件 iperfLog 中。



------

## 在 Win32 下使用 iPerf 作为服务

- 

  Win32 有三个选项：-o 输出文件名将消息输出到指定文件中-s -D将 iPerf 安装为服务并运行它-s -R卸载 iPerf 服务例子：iperf -s -D -o iperflog.txt将安装 iPerf 服务并运行它。消息将报告到“%windir%\system32\iperflog.txt”iperf -s -R将卸载 iPerf 服务（如果已安装）。注意：如果您停止想要重新启动iPerf服务，请在与Microsoft一起杀死它之后重新启动它 管理控制台或 Windows 任务管理器，请确保在服务属性对话框中使用正确的选项。



------

## 自适应窗口大小（开发中）

- 

  在客户机上使用 -W 选项以自适应窗口大小运行客户机。 确保此选项的服务器窗口大小相当大。 例如如果服务器 TCP 窗口大小为 8KB，则客户端 TCP 窗口大小为 256KB 无济于事。 256KB 服务器 TCP 窗口大小应该足以满足大多数高带宽网络的需求。客户端使用二进制指数算法更改 TCP 窗口大小。 这意味着您可能会注意到建议的 TCP 窗口大小可能会根据网络中的流量而有所不同， iPerf 将为当前网络方案建议最佳窗口大小。



------

## 编译

一旦你有了发行版，在UNIX上，使用gzip和tar解压缩它。 这将创建一个包含源文件和文档的新目录“iperf-<version#>”。

iPerf在许多系统上都能干净地编译，包括Linux，SGI IRIX，HP-UX， Solaris、AIX 和 Cray UNICOS。使用“**make**”为您的操作系统进行配置并编译源代码。

> ```
> gunzip -c iperf-<version>.tar.gz | tar -xvf -
> cd iperf-<version>
> ./configure
> make
> ```

要安装 iPerf，请使用“**进行**安装”，它会询问您在哪里安装它。 要重新编译，最简单的方法是重新开始。做'make **distclean**'，然后'**./configure; make'**。 有关更多选项，请参阅生成文件。