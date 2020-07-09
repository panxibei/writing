InstallShield静默安装折腾手记

副标题：



要说今年我们村办的最漂亮的事儿，当数开通网络了，着实解决了不少恼人麻烦事儿！

在2020年初新冠疫情的背景下，村里组织动员各家各户积极学习防疫知识，强调人人戴口罩、尽量少出门。

说到少出门，这开通的网络可就真正派上了大用场，如今很多单位也都鼓励员工居家办公。

在往常没有网络的日子里，有些非要靠跑腿的工作基本上算是完蛋。

不过有了网络，立马就体现出社会主义的优越感了！

这不，就有一个近在咫尺而鲜活的例子！



同村的刘流浪，人称流浪哥，没我帅，但去年考上了重点大学，学的是电子机械专业，如今还当上了传说中的专业课代表，让班里的班花刮目相看。

有那么一次流浪哥就找到我，说是要安装个叫做 `XVL Player` 的机械看图程序。

图1



我说机械我不懂，不过安装程序还不简单，现在有网络了，你下载个安装就是了。

流浪哥摇了摇头，推了推小眼镜，呲了呲牙笑着说道：

“我自己安装当然没问题，可现在没办法返校啊，我只能把它做成静默安装的样子。

我们学校都是小白不怎么会安装，不过我们学校里有公共网盘，我把这程序往那网盘里这么一放，通过静默安装的方式分发给同学们，哎，就自动安装上了，你说那有多得劲儿哈！

我说大哥啊，静默安装啊，全自动很牛X的，你知道不？

老师同学面前有面儿啊，人前显贵、鳌里夺尊，你知道不？

大哥行行好，咱对这不熟，给咱整一个呗！”

哦~我终于明白了，其实你小子是想在你们班花面前表现一把是吧！

就这点小心思，好吧，小case啦！

我让流浪哥放心回去撸串，一会处理一下，好了立马告诉他。

不过让我没想到的是，在这其间却遇到了不少麻烦，看看我是怎么踩坑的吧。



#### 一、按照官网设定静默安装

上 `Lattice3d` 官网，注册了邮箱后，顺利下载了 `xvl player` 的安装程序包。

打开安装程序，在其安装引导界面中可以看到 `InstallShield Wizard` 字样。

图2



定位为 `InstallShield` 安装打包程序，问题就简单了，遂找到官网的用户手册。

>InstallShield 官方用户手册部分内容
>
>### Running Installations in Silent Mode
>
>Silent installations are installations that run without an end-user interface. If you want your installation to run silently, InstallShield allows you to create silent installations for Basic MSI, InstallScript MSI, and InstallScript project types.
>
>##### Basic MSI Silent Installations
>
>To run a Basic MSI installation silently, type the following at the command line:
>
>`msiexec /i Product.msi /qn`
>
>If your release settings include Setup.exe, you can run the following command:
>
>`Setup.exe /s /v"/qn"`
>
>Basic MSI installations do not create or read response files. To set installation properties for a Basic MSI project, run a command line such as:
>
>`msiexec /i Product.msi /qn INSTALLDIR=D:\ProductFolder USERNAME="Valued Customer"`

照着上面的试了试，发现都不行。

用户手册后面有大量的说明，可惜都是E文看着太累。

就几个参数的事儿，有这么麻烦吗？

我决定把目标转向强大而万能的搜索引擎。





#### 二、网上找的内容比较凌乱，表述方面问题多多

##### 1、第一个坑

>  安装包参数获取 `/?` 或是 `/HELP`

我去，根本就没有弹出安装参数信息啊喂！



##### 2、第二个坑

> 安装完毕后，打开 `C:\Windows` 目录找到 `setup.iss` 文件

直接安装，没有找到 `setup.iss` 。

我是小白，很傻很天真，事后才知道这样是不会生成 `setup.iss` 文件的。

怎么会这样？后文会解释这诡异的现象。

通过不断地查找，发现有网友似乎也遇到过类似的问题。

如下图，没有生成 `setup.iss` 文件。

图3



其他网友给出了一些看法，建议加上 `f1` 参数，这个参数正是用来指定生成 `setup.iss` 文件的路径。

图4



##### 3、第三个坑

> 使用 `-R` 参数(即record) 运行安装程序

一时没有明白record的含义，于是直接犯错。

```shell
# 这是错误方法
setup.exe /r /f1"setup.iss"
```

程序直接提示错误： `Unable to write to repsonse file...`

图5



啥意思？翻译成人话就是，无法写入响应文件，请确保有足够空间。

怎么回事，为什么人话我也看不懂，我的空间明明很充足啊！





最后折腾得快不行了，才发现 `setup.iss` 应该加上绝对路径。

**原来 `/r` 这个开关是用来录制安装过程，生成 `setup.iss` 文件以备静默安装使用。**

```shell
# setup.iss必须加上了绝对路径才正确
setup.exe /r /f1"c:\foo\setup.iss"
```



我X，顿时三尸神暴跳，气炸连肝肺！

这里有个很搞的问题，如果加了上 `/f1` 开关，那么在 `C:\Windows` 下是找不到 `setup.iss` 的。

它去哪儿了？

其实应该是 `setup.exe /r` 这个样子，后面只要加个参数 `r` 就完了，这样在 `C:\Windows` 下是才能找到 `setup.iss` 。

你说搞不搞，网上写得也真是不明不白，我国通俗白话文亟待加强啊！！



##### 4、总结一下吧，让小伙伴们少走弯路，录制安装过程就两种，任选一种即可

```shell
# 到C:\Windows下去找setup.iss
setup.exe /r

# 到c:\foo下去找setup.iss，setup.iss必须加上了绝对路径才正确
setup.exe /r /f1"c:\foo\setup.iss"
```



#### 三、搞清楚上面的问题，接下来就容易了

**`InstallShield` 制作静默安装只需两步：**

1. **用 `/r` 开关录制安装过程**
2. **用 `/s` 开关执行静默安装**



清楚了没？

不需要特意安装 `InstallShield` 打包程序，也不需要麻烦地手工制作 `setup.iss` 文件。

那么 `/s` 开关怎么用？其实和 `/r` 几乎一样用法，也是带 `/f1` 和 `/f2` 两个参数。



在实际执行静默安装时，可以利用 `start` 命令确保程序顺序安装。

```shell
# 1. start /wait 等待程序运行完毕再执行接下来的程序
# 2. setup.exe、setup.iss和setup.log的文件名可以随意指定
# 3. 参数f2如果不指定，日志文件默认产生在setup.exe的当前目录中
start /wait setup.exe /s /f1"c:\foo\setup.iss" /f2"c:\foo\setup.log"
```

补充一点：`f1` 参数中的路径似乎不支持共享形式的路径，如：`\\server\foo` 。

临时解决方法是，先把 `setup.iss` 复制到本地，再引用本地的 `setup.iss` 即可。



如果你觉得脑子一片混乱，那么建议你多看几遍。

这里主要还是记录踩坑的过程，想要搞懂一些问题有时还是挺费劲的。

原以为挺简单的，没想到这么伤脑筋，不行不行，不能就这么便宜了流浪那小子！

让他请我搓一顿？还是给我发个大红包？

嘿嘿，小伙伴们有什么好主意啊，帮我一起想想吧，按比例分成哦！

> WeChat @网管小贾 | Blog @www.sysadm.cc

