zabbix网络拓扑图

副标题：

英文：

关键字：





Zabbix 6.X 的标签格式为：

    自定义{?last(/主机名/键值)}


举例：

```
Gi1/1/4:↓{?last(/AOTA-OA-WS-C3850/net.if.in[ifHCInOctets.35])}
Gi1/1/4:↑{?last(/AOTA-OA-WS-C3850/net.if.out[ifHCOutOctets.35])}
```

