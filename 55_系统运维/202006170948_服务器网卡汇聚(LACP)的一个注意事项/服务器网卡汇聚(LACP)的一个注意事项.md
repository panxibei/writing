服务器网卡汇聚(LACP)的一个注意事项

副标题：系统维护的坑永远也填不完~



为了保障网络稳定可靠，通常服务器等设备都是具备双网卡甚至是更多的网卡。

而再多的网卡，如果不能汇聚整合也只能当作单独的网卡使用，发挥不了应有的作用。



有一台服务器，搭载了 `Broadcom` 的四块网卡，通过 `Broadcom Advanced Control Suite` 可以做到汇聚整合成一个 `Team` 。

一个 `Team` 就可以当作是一个独立的网卡，拥有独立的IP地址。

而在使用过程中，在思科交换机的日志中发现一个问题。

类似如图，会有网卡连接的两个端口之间出现摆动的现象。

图1



细究下来，应该是网卡组队时，选择了网卡汇聚协议（LACP）方式，而相应的交换机没有做相应设定。

通常博通网卡组队有几种选择，其中之一就是 `LACP` 。

图2



相应的，对于支持 `LACP` 的交换机应该做相应的端口设定。

思科交换机一般做如下设定：

```
# Port-channel端口汇聚设定
interface Port-channel20
    switchport access vlan 123
    switchport mode access

# 两个对应网卡的端口，相应地开启LACP
interface GigabitEthernet1/0/20
    switchport access vlan 123
    switchport mode access
    channel-group 20 mode active
    channel-protocol lacp

interface GigabitEthernet2/0/20
    switchport access vlan 123
    switchport mode access
    channel-group 20 mode active
    channel-protocol lacp
```



经过服务器与交换机两个地方的调整，网卡已经稳定地运行了较长一段时间没有问题。

但个人感觉，如果是普通非网管交换机，没有必要也没地方去设定 `LACP` ，一般也能正常使用。

再深入的就不太懂的，还请前辈高手批评！