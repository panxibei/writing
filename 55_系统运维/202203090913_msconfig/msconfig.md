msconfig

副标题：

英文：

关键字：wdf_violation,violation,蓝屏,bluescreen





出现如下蓝屏错误提示。

```
终止代码：SYSTEM_THREAD_EXCEPTION_NOT_HANDLED
```

图a01







### 原因

出于好奇，将系统配置程序 `MsConfig` 里的设置给改了。

比如错误勾选了 `无GUI引导` 。

图b01



又比如点击了 `高级选项(V)...` 后，错误配置了 `处理器个数` 、 `最大内存` 或者 `PCI 锁定` 等等。

图b02



相对应的，我们可以在 `bcdedit` 命令输出结果中查看到，比原先默认启动配置多出来几项东西。

```
truncatememory          0x80000000
numproc                 2
quietboot               Yes
usefirmwarepcisettings  Yes
```

图b03



>  `BCDEdit` 命令选项参考传送门
>
> https://docs.microsoft.com/zh-cn/windows-hardware/drivers/devtest/bcd-boot-options-reference





正是这些新增的设置项导致了启动时系统加载错误致使蓝屏警告。

解决的方法也很简单，就是将这些错误启动项去除即可。

那么怎么去除呢？

很简单，用 `bcdedit` 命令删除这些设置项就行了。

```
# 删除无GUI引导设置项
bcdedit /deletevalue {default} quietboot

# 删除处理器个数设置项
bcdedit /deletevalue {default} numproc

# 删除PCI锁定设置项
bcdedit /deletevalue {default} usefirmwarepcisettings

# 删除最大内存设置项
bcdedit /deletevalue {default} truncatememory
```





### 触发蓝屏故障

理论很简单，但是实际解决起来麻烦不？

OK，动手实践课开课啦！



由于在较新版本中，我们直接通过系统配置 `MsConfig` 来修改引导配置可能会被限制在合理范围内而无法触发蓝屏错误效果。

简单地说，就是我们可能不能用 `MsConfig` 故意改成我们希望的错误配置。

那怎么办呢？

当然还是用 `bcdedit` 命令啦！



比如我们故意将处理器个数改成我们电脑上不合理的数值。

```
bcdedit /set {default} numproc 16
```



又或者我们故意开启PCI锁定。

```
bcdedit /set {default} usefirmwarepcisettings yes
```



OK，就这样我们会触发系统启动时的蓝屏故障，就像本文开头那样。

好，一旦蓝屏了，我们就可以开始修复工作了！





### 实际解决

经过测试，我发现虚拟机上无论你怎么乱改，它就是不蓝屏，就像无视这些配置一样，毫不受其影响。

于是我找了一台实体机，终于成功触发了蓝屏。

OK，手术刀准备！



通过启动时强行关机数次，或等待系统自动启动修复程序，我们就能看到如下图的修复提示画面。

图a02



选择 `高级选项` ，然后再选择 `疑难解答` 。

图a03



在 `疑难解答` 中选择 `高级选项` ，怎么突然感觉有点绕，哈哈！

图a04



在 `高级选项` 中选择 `命令提示符` ，准备开启命令行模式。

图a05



选择一个当前电脑的本地帐户，默认是本机的 `Administrator` 。

不过通常本机的 `Administrator` 是禁用的，因此你可能需要选择你自己命名的其他用户而非 `Administrator` ，注意选择有管理员权限的那个。

图a06



然后输入这个用户对应的密码。

图a07



密码通过后我们就可以顺利开启命令行模式了。

图a08



之后你懂的，就是按前面所学 `BCDEdit` 知识将那些有问题的项目删除即可。

如果你不知道有哪些需要删除的，那么就将下面这些都执行一遍。

```
bcdedit /deletevalue {default} quietboot
bcdedit /deletevalue {default} numproc
bcdedit /deletevalue {default} usefirmwarepcisettings
bcdedit /deletevalue {default} truncatememory
```



最后自然是重启你的电脑，看看有没有原地满血复活呢？



### 写在最后

除了手机，电脑也是日夜陪伴我们不可或缺的贴身伙伴。

现在，电脑君又回来了！

以后，一定要好好和他好好相处，不要再捉弄他了，要不然他也是会发些小脾气的哦！

好了，小伙伴们，在最后结束本文之时，麻烦举起你的小手，用手机君或是电脑君点赞、在看、转发分享吧！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

