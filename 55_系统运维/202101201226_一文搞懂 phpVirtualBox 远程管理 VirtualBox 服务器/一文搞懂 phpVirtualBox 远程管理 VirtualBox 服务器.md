一文搞懂 phpVirtualBox 远程管理 VirtualBox 服务器

副标题：远程管理多台 VirtualBox 服务不是梦~



我相信一定有不少小伙伴使用过虚拟机软件，其中不乏广大的 `VirtualBox` 爱好者。

我自然也是其中一员，平时测试个系统啥的也经常用到它。

至于说到如何操作管理 `VirtualBox` 虚拟系统，因为自己的水平有限，平时也就是用用它自带的 `GUI` 来操作。

但是，你也可能曾经思考过一个问题，假如有一天，由于某些原因你不再能依靠 `GUI` 而需要远程管理它，甚至可能还要管理多台 `VirtualBox` 服务。

这个可能在过生日的那一天真的会实现吗？

我现在就可以告诉你，不用等到过生日那一天，现在就能实现！

这就不得不提到的目前相对来说较为简便易上手的解决方案 `phpVirtualBox` 了。



`VirtualBox` 的官网首页上就有它。

图1



其实说到 `phpVirtualBox` ，很可能有的小伙伴在以前过生日的时候就认识它了，怀念那时大家还毛发茂密的年轻态。

事实是它的身影早已出现在了各大流利操作系统平台之上。

比如，我们使用过的网红 NAS 网盘等系统等（例如 `XigmaNas` ），都搭载预设了 `phpVirtualBox` 。

图2



只不过嘛多少有那么一点点小遗憾，这些内嵌的 `VirtualBox` 普遍版本较低，不是 `4.x` 的，就是 `5.x` 的。

打开如今的 `VirtualBox` 官网，最新版本可是当红的 `6.1` 。

而 `phpVirtualBox` 的应用又如此之广泛，那么即使没有远程管理的需求，我不禁在想如果自己徒手安装使用它可不可以呢？

答案当然是肯定的，而且自己安装有好处可以自由定义配置，我已经给小伙伴们踩过坑了，下面我们就来看看具体怎么做吧。





#### 先来个简单快速地搞定 `phpVirtualBox`

开始前的先决条件（假定我们已经有这样的环境了）。

当然你也可以在 `Linux` 上操作，都是类似的内容，只要保证有能解释 `php` 的 WEB 环境即可。

> 1、本机 Windows 系统上已安装有 VirtualBox 6.1.x
>
> 2、本机 Windows 系统上已安装有 WampServer 3.2.x （WEB环境支持PHP，版本>=5.2）
>
> ​    参考文章：[《WampServer最新版一键安装》](https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install)
>
> ​    文章链接：https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install



##### 一、下载 `phpVirtualBox`

安装前我们需要先获取最新版的 `phpVirtualBox` ，可以通过以下链接来下载。

```
https://github.com/phpvirtualbox/phpvirtualbox/archive/develop.zip
```

如果你嫌下载慢，我这儿有国内备用下载，我怕 `GitHub` 崩了自己留了一份，速度会快很多。

**phpvirtualbox-develop.zip（4.33M）**

下载链接：https://www.90pan.com/b2249063

提取码：z2ay



##### 二、安装 `phpVirtualBox`

将下载下来的 `phpvirtualbox-develop.zip` 文件解压缩，得到名为 `phpvirtualbox-develop` 的一个文件夹。

再将这个文件夹移动到 Web 服务发布的根目录下，并重命名为 `phpvirtualbox` 。

我这儿使用的是 `WampServer`，所以默认情况下应该像下面这样放置文件夹。

```
# 32位 WampServer
C:\Wamp\www\phpvirtualbox\

# 64位 WampServer
C:\Wamp64\www\phpvirtualbox\
```

图3



##### 三、配置 `phpVirtualBox`

我们在刚才移动好的文件夹中找一个叫作 `config.php-example` 的文件，它是一份配置模板文件，将它复制为一份新文件并将其重命名为 `config.php` 。

嗯，你没猜错，这个新复制的文件就是我们接下来要对其大动手术的 `phpVirtualBox` 的主要配置文件。



用你喜欢的文本编辑器打开这个 `config.php` ，这里面有很多配置项，不过不要眼花，我们先只做简单的一两项变动即可。

找到大概第12、13行的地方，就像下面那样。

```
/* Username / Password for system user that runs VirtualBox */
var $username = 'vbox';
var $password = 'pass';
```



看出来了吧，用户和密码嘛，不过你肯定会问这是什么的用户和密码呢？

问得好！

说实话我一开始也是懵的，难道是 `phpVirtualBox` 的登录帐号和密码吗？

其实不是的，这里的用户和密码是指运行 `VirtualBox` 的 WEB 服务（ `vboxwebsrv` ）的用户和密码。

纳尼纳尼，从哪儿冒出来个 `VirtualBox` 的 WEB 服务？

好吧，怪我没先说清楚，骚瑞！

我们先来快速恶补一下官方的一张 `phpVirtualBox` 运行原理图。



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



有的小伙伴可能要骂人了，乖乖，欺负我看不懂鸟语是吧。

骚瑞骚瑞，你看我这么骚就原谅我吧，其实我也不是很懂，不过你只要理解一点，使用 `phpVirtualBox` 来管理 `VirtualBox` ，是需要通过运行 `vboxwebsrv` 服务的。

**第一，`vboxwebsrv` 服务与 `VirtualBox` 交互，提供了访问 `VirtualBox` 的接口。**

**第二，`phpVirtualBox` 连接 `vboxwebsrv` 服务，通过 `vboxwebsrv` 服务接口达到访问 `VirtualBox` 的目的。**



朦朦胧胧，迷迷糊糊，似懂非懂？

好吧，不管那么多了，总而言之我们要先找到这个 `vboxwebsrv` 服务，然后将它运行起来就行了。

告诉你个好消息，实际上只要你正常安装了 `VirtualBox` ，那么其实它就随着主程序默认地躺在了根目录下。

比如 Windows 系统下，它在这儿（就是个可执行文件）：

```
%ProgramFiles%\Oracle\VirtualBox\VBoxWebSrv.exe
```

图4



而根据官方说明，`Windows` 或 `MacOS` 两种系统环境下，其 `vboxwebsrv` 服务运行使用的应该是与当前登录系统的帐号和密码相同。

大白话也就是说，你现在的 Windows 当前登录的用户名叫“狗蛋”，密码是“5201314”，那么这个服务要运行起来，用的就是“狗蛋”和“5201314“了。

好了，这回总算是看明白了，那我们马上来试一试。



**1、修改 `config.php` 中的帐号和密码**

比如你当前登录的 Windows 帐号是 “admin”，密码是 “www.sysadm.cc” ，那么应该这样修改。

```
/* Username / Password for system user that runs VirtualBox */
var $username = 'admin';
var $password = 'www.sysadm.cc';
```



**2、运行 `vboxwebsrv` 服务**

打开一个命令控制台，输入以下命令行（因为引用了环境变量，实际运行时最好带上两侧的引号）。

```
"%ProgramFiles%\Oracle\VirtualBox\VBoxWebSrv.exe"
```

图5



这里我们没有加任何参数，可以看到执行后控制台有输出显示。

其实不加参数直接拿来用可以作为调试之用，在实际后台运行时可以加上管道符 `> nul` ，避免无用信息输出。

实际把服务放到后台运行，可以这样：

```
"%ProgramFiles%\Oracle\VirtualBox\VBoxWebSrv.exe" -H 127.0.0.1 > nul
```

我们可以通过诸如 Windows 的任务计划，或 Linux 的 `corn` 等自动启动该服务，当前我们手动运行服务仅作为测试之用。

我们不加参数运行服务，在窗口输出中还能看到服务是运行于 `localhost` ，说明服务默认主机就是本地，服务端口 `18083`  。



在 `config.php` 中大概16行处，填写服务运行的主机地址，这里我们是运行在本地的，所以是 `127.0.0.1` 。

另外别忘记开放端口 `18083` ，当然本地访问端口都是开放的。

```php
/* SOAP URL of vboxwebsrv (not phpVirtualBox's URL) */
var $location = 'http://127.0.0.1:18083/';
```



好，服务运行起来了，接下来我们就可以尝试访问登录了。



##### 四、登录 `phpVirtualBox` 

打开浏览器，输入网址，例如：

```
http://127.0.0.1/phpvirtualbox
```

跳出个登录框，如图：

图6



看来访问站点没问题，但这 WEB 登录的用户和密码又是多少呢？

注意，和前面说的配置文件中的用户和密码不是一回事哦！

官网上有说明，默认是 “admin” 和 “admin”，那就试试看。



如果登录失败，出现如下错误提示的话，那就说明 `vboxwebsrv` 的配置有问题，回头再仔细检查检查。

图7

比如，你看看控制台这边的输出，很有可能是服务运行的帐号和密码不对。

图8



有时候，Windows 的登录用户是没有设定密码（空密码）的，所以**一定要给用户设定一个密码**。

或者你另外新建一个用户，并给它设定密码，然后以这个新建用户的身份运行 `VBoxWebSrv` 服务也是可以的。



另外需要提一嘴的是，当你忘记 WEB 登录密码时，可以用下列方法尝试重置登录密码。

1. 到 `phpVirtualBox` 根目录中找到 `recovery.php-disabled` ，将它复制一份并重命名为 `recovery.php` 。

   

2. 用浏览器直接打开 `recovery.php` ，会出现重置登录密码的页面。

   ```
   http://主机名和IP地址/phpvirtualbox/recovery.php
   ```

   图9

   

3. 点击 `Recover` 按钮，系统就会重置登录用户名和密码为默认的“admin”和“admin”。

   

4. 将 `recovery.php` 删除或重命名为 `recovery.php-disabled` ，否则系统是不会让你登录的。

   

5. 登录成功后，可以通过页面左上角的菜单 `File` > `Change Password` 来修改登录密码。



OK，一切调整好后，再来尝试登录。

随着控制台不断翻滚着字符，终于顺利进入界面啦！

看着英文不爽是吧，那就改成中文吧。

左上角菜单 `File` > `Preferences...` > `Language` > `简体中文（中国）` 。

图10



#### 登录后可能会遇到的各种坑

##### 一、版本不兼容问题

登录后你有可能会看到这样的提示。

图11



这个提示是几个意思呢？

我询问过翻译君，他告诉我这是当前的 `phpVirtualBox` 版本与 `VirtualBox` 版本不兼容的意思，前者是 `5.2.x` ，而后者是 `6.1.x` 。

会不会影响使用啊？

按提示看，它好像引导我们去下载 `6.1.x` 版本，可翻遍了整个互联网也没找着这该死的 `6.1.x` 。



实际上这是由于使用了 `phpVirtualBox` 的 `master` 版本所致，**建议用本文中的开发版本（免费下载）**。

官方主分支给出的是 `5.2`  版本，由于某些不可描述的原因，原维护者没有在原版本上继续升级维护，而后续其他网友陆续加入进来后，目前只有最新的开发版本才能适用于 `6.1` 。

这个坑我已经帮你们踩好了，即使是通过 `SDK` 中的文件替换也不好使。

请珍惜生命，不要轻易尝试，说多了都是泪，老老实实用我说的那个版本吧。

```
# 即使将 phpVirtualBox 中的文件替换成 SDK 中的相应文件也无法修复问题
cp -v ../sdk-6.1.0/bindings/webservice/vboxweb.wsdl endpoints/lib/vboxweb-6.1.wsdl
cp -v ../sdk-6.1.0/bindings/webservice/vboxwebService.wsdl endpoints/lib/vboxwebService-6.1.wsdl
```



##### 二、提示 `IMachine_getGraphicsAdapter` 或 `ns1:IMachine_getVRAMSize` 等错误

出现类似于如图的错误提示，导致虚拟机无法进一步查看和操作。

图12



我又查遍了整个互联网，只有前面坑一说的那种方法也就是替换文件可以尝试，余者皆无，最终也没能修复问题。

难道我查了个假的互联网？

这个问题的确挺诡异的，我遇到的真实情况是，在自己电脑上怎么试都不行，而换了台电脑，同样的环境两样的配置却没有任何问题。

最后才发现，可能是我的 `PHP` 环境有问题，从 `7.3` 切换成 `7.4` 瞬间就好了！

当然当然，这并不是 `PHP` 版本的问题，因为我在其他电脑上同样是用的 `7.3` 就是好的，所以猜测应该是我自己电脑系统本身哪有问题吧。

结论就是尝试调整运行环境。



##### 三、`VBoxWebSrv` 运行错乱

如图，控制台画面不停翻滚，上面显示了很多错误信息。

图13



这种情况可能是 `VirtualBox` 程序本身的问题，也可能是扩展包的问题，建议全部卸载后重新安装。





#### 如何配置管理多台服务器

如果只是管理一台服务器，那可能就没必要大费周章搞 `phpVirtualBox` ，所以重点是要能管理多台服务器。

还是那个最初的配置文件 `config.php` ，找到大概在39行处，将前后注释取消，修改成相应的服务器连接信息。

```php
var $servers = array(
        array(
                'name' => '网管小贾一号服务器',
                'username' => 'user1',
                'password' => 'pass1',
                'location' => 'http://192.168.1.1:18083/',
        ),
        array(
                'name' => '网管小贾二号服务器',
                'username' => 'user2',
                'password' => 'pass2',
                'location' => 'http://192.168.1.2:18083/'
        ),
);
```

图14



***注：此时要小心仔细，别忘记开放服务器端防火墙的 `18083` 端口。***



重新登录 `phpVirtualBox` ，在左上角就可以通过服务器名称查看和切换目标服务器了。

图15



很棒吧？

这里需要有几点注意。



**1、设定管理多台服务的配置，会覆盖前面的单独一台服务的配置。**

即如下 `config.php` 中大概16行处的设定，你无需改动它，系统会自动判断而应用多台服务器配置。

```php
/* SOAP URL of vboxwebsrv (not phpVirtualBox's URL) */
var $location = 'http://127.0.0.1:18083/';
```



**2、用户名和密码的保存**

`phpVirtualBox` 默认会将登录用户名和密码保存在多台中的某一台服务器上以便能验证从而正常访问它们。

通常默认情况下会保存在 `$server` 数组列表中指向的第一台服务器中，不过也可以通过参数 `'authMaster' => true` 强制指定验证服务器。

比如下面是将验证指定到第二台服务器（注意数组每项最后不要缺少逗号）。

```php
var $servers = array(
        array(
                'name' => '网管小贾一号服务器',
                'username' => 'user1',
                'password' => 'pass1',
                'location' => 'http://192.168.1.1:18083/'
        ),
        array(
                'name' => '网管小贾二号服务器',
                'username' => 'user2',
                'password' => 'pass2',
                'location' => 'http://192.168.1.2:18083/',
            	'authMaster' => true	// 指定保存登录用户名和密码的服务器
        ),
);
```

***其中有一点要当心，务必要确保保存验证的服务器是可访问的，否则可能会出现如图的错误提示而无法登录系统。***

图16



如果退一万步假如这个用于验证的服务器真挂了，那么这个时候如果你通过刷新页面来重新加载登录，那么非常遗憾你会发现无论如何也无法回到过去了，它会一直提示这个错误。

这也是我遇到的坑之一啊，挺头大的不是吗？

不过不要紧张，不要抱怨，想回到过去其实简单得超乎你的想象，请你仔细认真地再看看这个错误提示。

发现什么鬼没有？

呵呵，当你点击那个 `Server List` 后面的服务器名字，只要它是有效在线的，就可以正常切换过去从而再次加载页面。

我是经历了多次重启服务、修改配置等等像傻瓜一样的一顿乱操作，踩遍了所有的坑之后才最终发现的！

呵呵哒，我完全是在用绳命试错啊，无奈而又辛酸，这个坑是不是有点坑爹啊喂？！





#### 远程显示及管理

选择你要想管理的虚拟机，然后点击 `Settings` > `Remote Display` 开启远程连接功能。

在远程功能开启前，我们可以注意到右上角的 `Console` （终端）项是灰色未启用的状态。

图17



一旦开启了远程连接，就可以使用远程桌面连接虚拟机了。

这里要注意，所在连接的IP地址是虚拟服务器的地址而不是虚拟客户机的地址。

此外，`Console` 选项也被开启，但可能会提示需要安装 `Flash` 插件。

我在之前的文章中给小伙伴们留了各种浏览器的 `Flash` 插件下载地址，可以参考下面的文章链接来下载安装。

> 《2021年开始，Adobe Flash Player 不能用了？》
>
> 文章链接：https://www.sysadm.cc/index.php/xitongyunwei/799-since-2021-adobe-flash-player-can-no-longer-be-used

图18



我用的是火狐，安装好火狐适用的 `Flash` 插件后重启浏览器，就可以看到是否允许使用的安全提示。

图19



点击“允许”，再点击 `connect` 连接按钮就可以使用终端远程管理了。

虽然说这种方式操作起来可能有点卡顿，但可以免去使用远程桌面程序的麻烦，比如在手机端操作远程管理也算还不错吧。

图20





#### 最后总结

关于 `phpVirtualBox` 的更高级的用法还有不少，有兴趣可以参考官方的 `wiki` 文档。

> https://github.com/phpvirtualbox/phpvirtualbox/wiki

虽然 WEB 界面无法和 GUI 相媲美，但至少从远程管理这个角度我们可以有多一种的选择。

目前暂时还没来得及研究其他高级用法，等将来有时间研究后再来和小伙伴们分享吧。

能看到最后的小伙伴们要为你们点个赞，你们是认真学习的好孩子！

最后如果小伙伴们有什么需要补充的，欢迎留言区评论、点赞和在看哦！



**`phpVirtualBox` 开发版本 `6.1` 国内备用下载**

下载链接：https://pan.baidu.com/s/1uHdFtBWzorH42SI3uLNwsg

提取码：7od4





WeChat@网管小贾 | www.sysadm.cc

