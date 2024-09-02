scoop

副标题：

英文：

关键字：





scoop 首页。

图a01



```
# 修改安全策略级别，以便顺利安装Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

执行命令，按下 `y` 表示同意修改。

图a04



```
# 连接到官网安装Scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```



但是安装并不是那么的顺利。

有时是因为网络质量问题。

图b01



有时，是因为 `Github` 连接不上造成的。

图b02



最后找了半天，把完整版安装文件直接给下载下来了。

这样省去了各种网络连接不上的麻烦。

（文末有下载）

图b03



老习惯，看一下命令是否正常输出。

图b04



它被安装到哪儿了呢？

在这里。

```
C:\Users\用户名\scoop\apps\scoop\current\bin
```

图b05





查询应用程序。

图a02



`Buckets` 如下：

后面打对勾的是官方的 `Bucket` ，后面带问号的则是社区版。

图a01



