胡乱修改 msconfig 配置会导致系统蓝屏，是真的吗？

副标题：修复 msconfig 引导配置错误~

英文：casually-modifying-msconfig-configuration-will-cause-system-blue-screen-halt-is-it-true

关键字：wdf_violation,violation,蓝屏,bluescreen,超频,halt,msconfig,overclocking





同事小Y是个自称电脑发烧友的半桶水，最近看了几篇CPU超频的文章就叫嚣着要大干一番。

结果把自个电脑给搞残了！



最后实在搞不定了，厚着脸皮来找我说：“哥，帮个忙呗！”

我头都没抬，刷着头条拒绝了他：“我现在平均年薪百万，哪有那闲功夫！”

小Y也不含糊，竖起三根手指指天发誓，不就一顿饭的事儿嘛！

我立刻放下手机站起身来，一边接过电脑，一边笑道：“再来两瓶酒哈！”



当我打开小Y的电脑，看到如下的蓝屏，心里有点后悔要价太低，应该再打包两个菜！

嘿嘿，得了，先看看怎么解决吧！



蓝屏错误提示如下：

```
终止代码：SYSTEM_THREAD_EXCEPTION_NOT_HANDLED
```

图a01



这是啥毛病？没见过啊！



### 事出有因

见我有点发愣，小Y就道出了其中原委。

他说他自己好歹也是个多年玩电脑的老鸟，最近想试试超频，结果刚改个 `MsConfig` 就给整这样了。

哦，原来如此！



经过一番确认，我才知道，他误将系统配置程序 `MsConfig` 里的设置给改了。

比如错误勾选了 `无GUI引导` 。

图b01



又比如点击了 `高级选项(V)...` 后，错误配置了 `处理器个数` 、 `最大内存` 或者 `PCI 锁定` 等等。

图b02



相对应的，我们可以在 `bcdedit` 命令输出结果中查看到，比原先默认启动配置多出来几项东西。

```
truncatememory          0x80000000    # 最大内存
numproc                 2             # 处理器个数
quietboot               Yes           # 无GUI引导
usefirmwarepcisettings  Yes           # PCI锁定
```

图b03



>  `BCDEdit` 命令选项参考传送门
>
> https://docs.microsoft.com/zh-cn/windows-hardware/drivers/devtest/bcd-boot-options-reference



正是这些新增的设置项导致了启动时系统加载错误致使蓝屏警告。

解决的方法也很简单，就是将这些错误启动项去除即可。

那么怎么去除呢？



很简单，还是用 `bcdedit` 命令删除这些设置项就行了。

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



### 蓝屏故障复现

理论很简单，但是实际解决起来麻烦不？

OK，动手实践课开始啦！



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



所以说，小Y是怎么找这些设置给改乱的，有可能是个迷！

OK，就这样我们会触发系统启动时的蓝屏故障，就像本文开头那样。

好，知道了原理，我们就可以开始修复工作了！



### 实际解决，一招搞定

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

如果你不清楚有哪些需要删除的，那么就将下面这些都执行一遍。

```
bcdedit /deletevalue {default} quietboot
bcdedit /deletevalue {default} numproc
bcdedit /deletevalue {default} usefirmwarepcisettings
bcdedit /deletevalue {default} truncatememory
```



最后自然是重启你的电脑，看看有没有原地满血复活呢？



### 写在最后

经过一番折腾，小Y的电脑总算是活过来了，我呢也赠了一顿饭钱。

话说现在除了手机，电脑也是日夜陪伴我们不可或缺的贴身伙伴。

我想对小伙伴们说，现在，电脑君又回来了！

以后，一定要好好和他好好相处，不要再捉弄他了，要不然他也是会发些小脾气的哦！

好了，小伙伴们，在最后结束本文之时，麻烦举起你可爱的小手，用手机君或是电脑君点赞、在看、转发分享吧！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

