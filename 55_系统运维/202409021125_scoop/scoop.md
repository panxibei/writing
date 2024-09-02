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





查询应用程序。

图a02



`Buckets` 如下：

后面打对勾的是官方的 `Bucket` ，后面带问号的则是社区版。

图a01



