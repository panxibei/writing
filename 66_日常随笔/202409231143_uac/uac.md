uac

副标题：

英文：

关键字：







用户帐户控制窗口没有“是”，只有“否”。

图a01



正常情况下应该是这样的。

图a02



通过计算机管理中的用户项查看用户信息。

图a03



当前用户 `User` 隶属于 `Users` 组，也就是说它没有管理员组 `Administrators` 的权限。

所以如果以管理员权限运行程序时，就直接被拒绝了，因此用户帐户控制窗口就看不到“是”而只有“否”了。

图a04



怎么破？

打开 `设置` ，`系统` > `恢复` 。

图b01



选择高级启动，立即重新启动。

图b02



重启过后，选择疑难解答。

图d01



高级选项。

图d02



选择命令提示符。

图d03



这时我们变个戏法，将放大镜程序 `Magnify.exe` 改成 `cmd.exe` 。

```
# 切换到你的真实的Windows系统所在盘符
C:

# 切换到 System32 目录
cd C:\Windows\System32

# 将 Magnify.exe 重命名为 Magnify.bak
ren Magnify.exe Magnify.bak

# 拷贝 cmd.exe ，同时将副本文件命名为 Magnify.exe
copy cmd.exe Magnify.exe
```



关闭命令提示符窗口，继续或重启系统。

来到登录界面，点击右下角的 `辅助功能` （小人图标），点击或开启放大镜程序。

图c03



出现我们之前替换的命令提示符窗口。

在窗口中输入以下命令。

```
# 将用户 user 追加至 administrators 组中
net localgroup administrators user /add
```



命令执行完毕。

重启系统后，登录用户，再次确认，用户已经是管理员组成员。

图b03



用户帐户控制提示窗口中又可以选择“是”了。

