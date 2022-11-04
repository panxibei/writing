RustDesk

副标题：

英文：

关键字：





- `hbbs` - `RustDesk` `ID` 注册服务器
- `hbbr` - `RustDesk` 中继服务器



开放端口：

默认情况下，`hbbs` 监听 `21115(tcp)` , `21116(tcp/udp)` ,  `21118(tcp)` ，`hbbr` 监听 `21117(tcp)` ，  `21119(tcp)` 。

务必在防火墙开启这几个端口， **注意 `21116` 同时要开启 `TCP` 和 `UDP` **。 



* `TCP/21115` - `hbbs` 用作 `NAT` 类型测试
* `UDP/21116` - `hbbs` 用作 `ID` 注册与心跳服务
* `TCP/21116` - `hbbs` 用作 `TCP` 打洞与连接服务
* `TCP/21117` - `hbbr` 用作中继服务
* ` TCP/21118/21119` - 网页客户端





> https://rustdesk.com/docs/en/self-host/install/



```
sudo docker image pull rustdesk/rustdesk-server
sudo docker run --name hbbs -p 21115:21115 -p 21116:21116 -p 21116:21116/udp -p 21118:21118 -v `pwd`:/root -td --net=host rustdesk/rustdesk-server hbbs -r <relay-server-ip[:port]>
```



```
sudo docker image pull rustdesk/rustdesk-server
sudo docker run --name hbbs -p 21115:21115 -p 21116:21116 -p 21116:21116/udp -p 21118:21118 -v `pwd`:/root -td --net=host rustdesk/rustdesk-server hbbs -r 192.168.1.1
```

