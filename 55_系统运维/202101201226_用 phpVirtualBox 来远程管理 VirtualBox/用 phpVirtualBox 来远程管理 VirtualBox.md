用 phpVirtualBox 来远程管理 VirtualBox

副标题：还可以管理多台 VirtualBox 服务哦~



我相信一定有不少小伙伴使用过虚拟机软件，其中不乏 `VirtualBox` 爱好者。

我自然是其中一员，平时也经常使用它。

至于说到如何管理 VitualBox 虚拟系统，因为自己的水平有限，平时也就是使用它自带的 GUI 来操作。

但是，如果有一天，你需要远程管理它，或者要管理多台 VirtaulBox 服务呢？

这就不得不提到的目前较为简便易上手的解决方案 `phpVirtualBox` 了。

图1



其实说到 `phpVirtualBox` ，很可能有的小伙伴早就认识它了。

而它的身影实际上早就出现在各种系统平台上了。

比如，我们使用过的众多 NAS 网盘等系统（例如 `XigmaNas` ），都预设包含了它。

图2



`phpVirtualBox` 的应用如此广泛，那么即使没有远程管理的需求，我想自己安装使用它可以吗？

答案当然是肯定的，而且自己安装可以自由定义配置，下面我们就来看看怎么做吧。





#### 简单快速地搞定 `phpVirtualBox`

开始前的先决条件：

> 1、本机 Windows 系统上已安装有 VirtualBox 6.1.x
>
> 2、本机 Windows 系统上已安装有 WAMP 3.2.x （WEB环境支持PHP，版本>=5.2）
>
> 参考文章：[《WampServer最新版一键安装》](https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install)
>
> 文章链接：https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install



##### 一、下载 `phpVirtualBox`

安装前我们需要先获取最新版的 phpVirtualBox ，可以通过以下链接来下载。

```
https://github.com/phpvirtualbox/phpvirtualbox/archive/master.zip
```

如果你嫌下载慢，我这儿有国内备用下载，速度会快很多。

下载链接：



##### 二、安装 `phpVirtualBox`

将下载下来的 `phpvirtualbox-master.zip` 文件解压缩，得到名为 `phpvirtualbox-master` 的一个文件夹。

再将这个文件夹移动到 Web 服务发布的根目录下，并重命名为 `phpvirtualbox` 。

我们这儿使用的是 WAMP，所以默认情况下应该像下面这样放置文件夹。

```
# 32位 WAMP
C:\Wamp\www\phpvirtualbox

# 64位 WAMP
C:\Wamp64\www\phpvirtualbox
```

图3



##### 三、配置 `phpVirtualBox`

我们在刚才移动好的文件夹中找一个叫作 `config.php-example` 的文件，将它复制一份并重命名为 `config.php` 。

嗯，你没猜错，这就是我们要用到的 `phpVirtualBox` 的配置文件。

用你喜欢的文本编辑器打开这个 `config.php` ，这里面有很多配置项，不过不要眼花，我们只做简单的一两个变动即可。

找到大概第12、13行的地方，就像下面那样。

```
/* Username / Password for system user that runs VirtualBox */
var $username = 'vbox';
var $password = 'pass';
```



看出来了啊，用户和密码嘛，不过这是什么的用户和密码呢？

问得好！

说实话我一开始也是懵的，难道是 `phpVirtualBox` 的登录帐号和密码吗？

其实不是的，这里的帐号密码是指运行 `VirtualBox` 的 WEB 服务（ `vboxwebsrv` ）的用户和密码。

纳尼纳尼，从哪儿冒出来个 `VirtualBox` 的 WEB 服务？

怪我没先说清楚，骚瑞！

我们先来恶补一下官方的一张 `phpVirtualBox` 运行原理图。



> ```
>  -----------------------------------------------------
>  | Web Server                                        |
>  |    phpVirtualBox (config.php contains VirtualBox  |
>  |     |              access information)            |
>  ------|----------------------------------------------
>        |
>    Authentication and VirtualBox communication
>        |
>        |  -----------------------------------------------
>        |  | VirtualBox Installation                     |
>        |  |                                             |
>        '---- vboxwebsrv (running as user X)             |
>           |    |                                        |
>           |    '--- User X's VirtualBox configuration   |
>           |         and virtual machines                |
>           |                                             |
>           -----------------------------------------------
> ```



有的小伙伴要骂人了，你欺负我看不懂鸟语吧。

好吧，其实我也不是很懂，不过你只要理解，使用 `phpVirtualBox` 管理 `VirtualBox` ，是需要通过运行 `vboxwebsrv` 服务的，是这个服务提供了访问 `VirtualBox` 的接口。

似懂非懂？

好吧，不管那么多了，总而言之我们先找到这个 `vboxwebsrv` ，然后将它运行起来就行了。

其实只要你正常安装了 `VirtualBox` ，那么它就在程序的根目录下。

比如 Windows 系统下：

```
%ProgramFiles%\Oracle\VirtualBox\VBoxWebSrv.exe
```

图4



而根据官方说明，`Windows` 或 `MacOS` 两者环境下，应该是与当前登录的帐号和密码相同。

好了，这回总算明白了，其实就是看运行 `VBoxWebSrv.exe` 时，用的是什么用户和密码。

那我们来试一试。



1、修改 `config.php` 中的帐号和密码

比如你当前的 Windows 帐号是 “admin”，密码是 “www.sysadm.cc” 。

```
/* Username / Password for system user that runs VirtualBox */
var $username = 'admin';
var $password = 'www.sysadm.cc';
```



2、运行 `vboxwebsrv` 服务

打开一个命令控制台，输入以下命令行（因为引用了环境变量，最好带上引号）。

```
"%ProgramFiles%\Oracle\VirtualBox\VBoxWebSrv.exe"
```

图5



我们没有加任何参数，可以看到执行后控制台有输出显示。

其实这方法是用来调试的，在实际后台运行时可以加上管道符 `> nul` 。

其中还能看到服务是运行于 `localhost` ，也就是本地，服务端口 `18083`  。

接下来我们就可以尝试访问登录了。



##### 四、登录 `phpVirtualBox` 

打开浏览器，输入网址，例如：

```
http://127.0.0.1/phpvirtualbox
```

跳出个登录框，如图：

图6



看来链接是打开了，但这WEB登录的用户和密码又是多少呢？

官网说默认是 “admin” 和 “admin”，那就试试看。



如果登录失败，出现如下错误提示的话，那就说明你的配置有问题。

图7

你再看看控制台这边。

图8



有时候，Windows 的登录用户是没有设定密码的，所以一定要给用户设定一个密码。

或者你新建一个用户，并给它设定密码，然后以这个用户身份运行 `VBoxWebSrv` 服务即可。



一切调整好后，再来尝试登录。

随着控制台不断翻滚着字符，终于顺利进入界面啦！

图9



不过，这个提示是几个意思？

我询问了翻译君，他简单地告诉我，当前的 `phpVirtualBox` 版本与 `VirtualBox` 版本不兼容，前者是 `5.2.x` ，而后者是 `6.1.x` 。

我急得直搓手，会不会影响使用啊？

按提示看，它引导我们去下载 `6.1.x` 版本，可我翻遍了半个互联网也没找着这该死的 `6.1.x` 。

最后在一个老外那儿找到了不算答案的答案。

```
https://github.com/phpvirtualbox/phpvirtualbox/issues/253
```

图10



也就是说，当前这种情况在使用上不会有什么问题。

图11



看着英文不爽，那就改成中文的吧。

`File` > `Preferences...` > `Language` > `简体中文（中国）`









