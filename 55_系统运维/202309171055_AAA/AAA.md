AAA

副标题：

英文：

关键字：





> https://www.cisco.com/c/zh_cn/support/docs/wireless/catalyst-9800-series-wireless-controllers/213919-configure-802-1x-authentication-on-catal.html



**AAA Dead-Server检测注意事项**

配置RADIUS服务器后，您可以检查它是否被视为“ALIVE”：

```none
#show aaa servers | s WNCD
     Platform State from WNCD (1) : current UP
     Platform State from WNCD (2) : current UP
     Platform State from WNCD (3) : current UP
     Platform State from WNCD (4) : current UP
     ...
```

您可以配置 `**dead criteria**,` 以及 `**deadtime**` 在WLC上，尤其是当您使用多个RADIUS服务器时。 

```none
#radius-server dead-criteria time 5 tries 3
#radius-server deadtime 5
```

**注**: `**dead criteria**` 是用于将RADIUS服务器标记为停机的条件。它包括：1.超时（以秒为单位），表示从控制器上次从RADIUS服务器收到有效数据包到服务器被标记为停机的时间之间必须经过的时间。2.一个计数器，表示RADIUS服务器被标记为失效之前必须在控制器上发生的连续超时次数。

**注**: `**deadtime**` 指定在失效条件将其标记为失效后，服务器保持失效状态的时间（以分钟为单位）。一旦死区期满，控制器会将服务器标记为UP(ALIVE)，并向已注册的客户端通知状态变化。如果在状态标记为UP后服务器仍然无法访问，并且满足dead条件，则在死区间隔内，服务器将再次标记为dead。