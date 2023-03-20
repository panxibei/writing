ncsi

副标题：

英文：

关键字：





`NCSI` ，即 `Network Connectivity Status Indicator` 的缩写，如果直译成中文就是 `网络连接状态指示器` 。

但是吧，就算翻译过来也挺让人犯懵，其实用大白话讲，就是 `Windows` 系统用来判断电脑是否连接到 `Internet` 的一种技术。

这种技术具体怎么做出判断的呢？

说穿了其实非常简单，咱们往下看！





尝试直接用浏览器访问

```
http://www.msftconnecttest.com/connecttest.txt
```

结果：

```
Microsoft Connect Test
```



```
http://www.msftncsi.com/ncsi.txt
```

结果：

```
Microsoft NCSI
```





解析

```
23.215.102.91 dns.msftncsi.com
```



可以自行修改以下字段。

```
ActiveWebProbeHost=www.msftncsi.com
ActiveWebProbePath=ncsi.txt
ActiveWebProbeContent=Microsoft NCSI
```



修改成自己的 `HTTP` 服务器上的链接即可。

```
ActiveWebProbeHost=www.xxxx.com
ActiveWebProbePath=yyyy.txt
ActiveWebProbeContent=zzzz
```







