scoop

副标题：

英文：

关键字：





毕业后的两个月，我接到了一家公司的面试通知。

面试地点很是奇怪，电话里说是在山上。

我一查地图，够偏的，坐完公交还得步行2里地。



走到山脚下，已是日上三竿，只觉得饥肠辘辘。

继续走了约莫几分钟，前面出现了一座酒馆。

门外旌旗招展，旗上赫然一个“酒”字。

再看店面门牌：景阳岗大酒店。



我一挑门帘迈步进店，嚯，好一个大酒店，拢共就两张桌子四条板凳，一只手都数得过来。

这时就听有人扯着嗓子喊了一声：“贵宾一位！里边请！”

我转过脸来一看，小二走了过来，笑脸相迎：客官，您来点什么？

一边说，一边擦抹桌案。



“小二，这儿就你们一家饭馆吗？”

“回您的话，没错，方圆十几里，只此一家，别无分号！”

“你们这儿还搞复古风啊，装修差点意思！”

“您说笑了，咱这儿比较偏，能吃上饭就不错了。对了客官，咱们这儿酒不错，要不先给您上点酒尝尝？”



我放下哨棒，找了个座位，一边坐下一边说道：“小二，给我切三斤牛肉、四个大鸡腿，再来两壶好酒！”

“得嘞！马上就来！”

小二满面春风、充满活力，一转眼不见了。



就在这等饭菜的工夫，我打开包袱，整理起我的简历和物品。

说快也快，小二再次出现，桌上摆上了酒和菜。

我一看就胃口大开，将简历放在一旁，开始吃了起来。



小二一旁帮我满酒，就看见我那份简历了。

“客官，您是去山上面试的啊？”

我只是点了点头，正吃得欢，嘴忙得没说上话。

“我能看看您的简历吗？”

我作了手势，意思你随便。

那小二拿起简历，端详了那么一会儿，直咂嘴。

嘿，我正吃得带劲的时候，你咂什么嘴啊？



我未曾开口，小二放下简历，就跟我白话上了。

“客官，恕我直言，您的简历虽然不错，但是现在竞争太过激烈，恐怕……”

“嗯……？”

我一听，这话里有话啊！

我放下咬了一半的鸡腿：“恐怕什么？有话就说，有P就放！”



小二满脸堆笑：“呵呵……客官，您老有所不知！”

“这山上面试喜欢择优录取，面试的人海了去了，什么985、清北的，大把的人。”

“所以说，他们在最后的面试环节，喜欢加一道自由发挥题！”

“什么人就栽在这上面，失败给淘汰了！”



“哦？还有这等事？什么自由发挥题？快快讲来，莫要卖关子！”

“是是是……这个……那个……”

哦，我明白了！

原来你还搞这等买卖，好吧，我给了他点散碎银子。

小二接过银子，一边左右环顾，一边手底下偷偷塞给我一张纸条。

“客官，莫要见怪，时局所迫，助人为乐，点到为止……”



什么乱七八糟的，不要耽误我吃饭！

小二眼珠一转，立刻退了下去……



我吃着吃着，过了一会儿，看四下无人，我偷偷打开了纸条……

哦！信息量还是很大的嘛！



今日面试之自由发挥题：

> 关于 `Scoop` 的介绍和简单使用。
>
> `Scoop` 是一款在 `Windows` 下的命令行安装器，目的在于可以让我们像使用类 `Unix` 程序那样，同样可以在 `Windows` 环境下自由安装软件。
>
> 说说你对 `Scoop` 的了解和认识……



`Scoop` 是啥，我心里一惊，以前没听说过啊，还好有这张纸条，接着往下看……



打开 `scoop` 官方首页，我们可以看到一个简洁的页面。

其中就有一个搜索框，用于搜索我们想要安装的软件。

图a03



既然是在 `Windows` 下使用的，那么我们就找一台 `Windows` 电脑来安装一下看看。

安装前，需要以管理员权限启动 `PowerShell` ，然后执行以下命令将安全策略降低。

```
# 修改安全策略级别，以便顺利安装Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

执行命令，按下 `y` 表示同意修改。

图a04



接下来就可以安装 `Scoop` ，一条命令就搞定。

```
# 连接到官网安装Scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```



不过多半安装并不会那么的顺利，原因你懂的，有时是因为网络质量问题。

图b01



有时，是因为 `Github` 摆烂连接不上造成的。

图b02



最后找了半天，干脆把完整版安装文件直接给下载下来了。

这样省去了各种网络连接不上的麻烦。

（文末有下载）

图b03



搞定安装，老习惯，看一下命令是否正常输出。

图b04



OK，正常输出，但是它被安装到哪儿了呢？

在这里。

```
C:\Users\用户名\scoop\apps\scoop\current\bin
```

图b05



那接下来怎么用呢？

我们先介绍一下如何查询想要安装的应用程序。

打开官网，其中有一个 `App` 的菜单，就在搜索框里输入目标即可。

当然了，在官网首页直接搜索也完全没问题。

图a02



一般情况下，`scoop` 会到 `main` 默认的软件仓库中找你要安装的软件。

不过可能 `main` 仓库中并不一定有你想要的，所以诞生了更多的软件仓库。

他们管这些软件仓库叫作 `Buckets` 。



通常的 `Buckets` 有这些，可以到对应的 `Buckets` 中搜索想要安装的软件。

1. `main` - Default bucket for the most common (mostly CLI) apps
2. `extras` - Apps that don’t fit the main bucket’s criteria
3. `games` - Open source/freeware games and game-related tools
4. `nerd-fonts` - Nerd Fonts
5. `nirsoft` - A subset of the 250 Nirsoft apps
6. `java` - Installers for Oracle Java, OpenJDK, Zulu, ojdkbuild, AdoptOpenJDK, 7、Amazon Corretto, BellSoft Liberica & SapMachine
7. `jetbrains` - Installers for all JetBrains utilities and IDEs
8. `nonportable` - Non-portable apps (may require UAC)
9. `php` - Installers for most versions of PHP
10. `versions` - Alternative versions of apps found in other buckets





打开官网页面，其中 `Buckets` 菜单中，所有的仓库都在这儿了。

`Buckets` 如下：

后面打对勾的是官方的 `Bucket` ，后面带问号的则是社区版。

图a01



安装 `Buckets` 。

```
scoop bucket add <Bucket名称>
```







玩法：

有个东东叫作 `aria2` 是一种下载器软件。

`scoop` 可以利用这个 `aria2` 来加速下载软件，因此我们可以先安装 `aria2` 。

```
scoop install aria2
```

图c01



但是有时因 `Github` 脑抽而无法正常下载安装包。

只好将安装包先想办法下载下来，接着手动解压到相应文件夹内即可。

放在下面这个路径中，通常应该在 `scoop` 的 `apps` 文件夹中。

```
C:\Users\用户名\scoop\apps\aria2\1.37.0-1\
```

文末打包 `aria2` 一块下载。

图c02





安装软件

```
scoop install <软件名称>
```





安装 `hotkeyslist` ，一款查看当前系统中快捷键的小程序。

```
scoop install hostkeyslist
```



发现没找到。

图d01



这个 `hostkeyslist` 应该是在 `nirsoft` 的 `Buckets` 中。

因此我们先要安装仓库 `nirsoft` 。

```
scoop bucket add nirsoft
```



正常情况下安装很简单。

图d03



你说什么？`Github` 又抽了？

图d02



好吧，操不完的心啊，干脆还是手动安装吧！

文末提供下载。

将 `Buckets` 放到相应的文件夹内。

```
C:\Users\用户名\scoop\buckets\
```

图d04





更换国内镜像。

```
# 更换scoop的repo地址
scoop config SCOOP_REPO "https://gitee.com/scoop-installer/scoop"

# 拉取新库地址
scoop update
```

图d05











