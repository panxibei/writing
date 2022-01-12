如何在 WAMPServer 中安装 Composer

副标题：wampserver与composer配合使开发更高效~

英文：how-to-install-composer-in-wampserver

关键字：composer,how to,install,wamp,wampserver,php,cmd



`WAMPServer` 的大名想必应该有不少人特别是新手小白们略有耳闻吧。

它是出自法国大神之手的一款 `PHP` 开发环境集成包，工作于 Windows 环境，类似于它这样的集成包在 Linux 平台上反正我是没找到，所以它应该算是对使用 Windows 新手们极其友好的一款神器。

虽然它的知名度还算不上家喻户晓，但的确是一部分人入门 `PHP` 的首选开发环境之一，毕竟用 Windows 的人多嘛。

既然用的人多，又作为一款多数人入门要用到的神器，那么围绕它的一些辅助功能肯定还是有研究和使用价值的。

比如这里我们正要提到的用于学习 `PHP` 开发的另一款神器：`Composer` 。



`Composer` 翻译过来应该是指挥家的意思，指挥家嘛就是协调统一整个乐队的演出，以达到最佳演出效果。

那这个和 `PHP` 又有啥关系呢？

这个 `Composer` 呢，可能作为新手知道的人要少一些了，它是 `PHP` 用来管理依赖关系的一款工具软件，类似于 Linux 中的程序依赖库文件的管理器，有点像指挥家的意思对吧。

使用过 Linux 的小伙伴们应该都有过这样的体验，就是你安装使用一款程序期间，你必须要同时安装这个程序的一些附加的依赖关系文件，否则这个程序可能无法正常跑起来。

打个比方，类似于 `C` 语言前面要 `include` 的一些库文件，没有这些库文件，最后程序可是无法运行的。

而要手动一个一个去处理这些依赖关系，就好像让你一个人同时要照顾好几个甚至十几二十个学龄前的小朋友一样，不是忙死就是累死，要么就是气死，哈哈你们自己体会一下！

因此可以说 `Composer` 的作用很大、功能很强，可以帮助我们自动地完美地安装项目中声明的一些依赖库文件而无需我们自己一个一个去搞定，可以说是学习 `PHP` 开发必须接触和了解的一款神器。

对于初学者们，往往经常使用的 Windows 上的 `PHP` 集成开发环境就是 `WAMPServer` 了，而 `Composer` 又是我们必学的一款神器，那么问题来了，我们怎么将两者结合在一起，怎么能让这俩个好哥们更好地为我们服务呢？

欢迎走进本期的走进科学（删掉）！



### 创建可随时访问 php.exe 的批处理程序

首先，我们要知道，`Composer` 是一款命令行工具，它其实是要用到 `PHP` 本身的主程序 `php.exe` 的，因此我们的首要任务就是要确保在命令行模式下 `php.exe` 这个主程序必须在任何路径下都能正常识别和运行。

因此没什么大的花样，你只要在 Windows 系统中追加变量值到 `PATH` 这个环境变量中即可。

听上去很简单很 easy 是不是？

所以我们可以这样，创建一个批处理小程序，当你打开它时它运行命令输入窗口，此时 `Composer` 所用的完全路径 `php.exe` 文件会被自动追加到 `PATH` 环境变量中。



注意啦，这种情况下，`WAMPServer` 也无法感知 `PATH` 的临时变动。

但是请记住是临时变动，而非全局，你另外打开一个命令你输入窗口并不起作用哦。



这个批处理文件命名为 `phppath.cmd` ，并将其保存到系统环境变量 `PATH` 所指向的任意路径中，这么一来，我们就可以在任何地方启动这个批处理程序了。



可以直接下载批处理文件，也可参考如下内容。

**phppath.7z (29KB)**

下载链接：https://pan.baidu.com/s/1tnztK20hFhgseIJClmJiww

提取码：ozhk



批处理文件内容：

```powershell
@echo off
REM **********************************************************************
REM * 将此批处理文件放在 PATH 所能访问到的文件夹中，比如 C:\Windows
REM * 以下参数可自行调整，比如32位 wamp 则 baseWamp=C:\wamp
REM * PLACE This file in a folder that is already on your PATH
REM * Or just put it in your C:\Windows folder as that is on the
REM * Search path by default
REM * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
REM * EDIT THE NEXT 3 Parameters to fit your installed WAMPServer
REM * - baseWamp : is the drive and folder where you installed WAMPServer
REM * - defaultPHPver : is the version of PHP that will be pathed
REM *                   if no Parameter is put on the bat file
REM * - composerInstalled : Where I installed Composer
REM * This next one probably does not need changing but is there just in case
REM * - phpFolder : The folder structure that contains the Multiple
REM *               possible version of PHP WAMPServer has installed
REM **********************************************************************

set baseWamp=C:\wamp64
set defaultPHPver=8.0.1
set composerInstalled=%baseWamp%\composer

set phpFolder=\bin\php\php

if %1.==. (
    set phpver=%baseWamp%%phpFolder%%defaultPHPver%
) else (
    set phpver=%baseWamp%%phpFolder%%1
)

PATH=%PATH%;%phpver%
php -v
echo ---------------------------------------------------------------

REM IF PEAR IS INSTALLED IN THIS VERSION OF PHP

IF exist %phpver%\pear (
    set PHP_PEAR_SYSCONF_DIR=D:\wamp\bin\php\php%phpver%
    set PHP_PEAR_INSTALL_DIR=D:\wamp\bin\php\php%phpver%\pear
    set PHP_PEAR_DOC_DIR=D:\wamp\bin\php\php%phpver%\docs
    set PHP_PEAR_BIN_DIR=D:\wamp\bin\php\php%phpver%
    set PHP_PEAR_DATA_DIR=D:\wamp\bin\php\php%phpver%\data
    set PHP_PEAR_PHP_BIN=D:\wamp\bin\php\php%phpver%\php.exe
    set PHP_PEAR_TEST_DIR=D:\wamp\bin\php\php%phpver%\tests

    echo PEAR INCLUDED IN THIS CONFIG
    echo ---------------------------------------------------------------
) else (
    echo PEAR DOES NOT EXIST IN THIS VERSION OF php
    echo ---------------------------------------------------------------
)

REM IF COMPOSER EXISTS ADD THAT TOO
REM **************************************************************
REM * IF A COMPOSER EXISTS ADD THAT TOO
REM *
REM * Ensure you have set variable 'composerInstalled' above
REM *
REM * Done this way as W10 has issues with setting path with (86)
REM * in the path inside an IF with parentheses, would you believe
REM **************************************************************

IF NOT EXIST %composerInstalled% GOTO NOCOMPOSER

echo COMPOSER INCLUDED IN THIS CONFIG
set COMPOSER_HOME=%composerInstalled%
set COMPOSER_CACHE_DIR=%composerInstalled%
PATH=%PATH%;%composerInstalled%
composer -V
echo TO UPDATE COMPOSER ITSELF do > composer self-update
echo ---------------------------------------------------------------
GOTO END

:NOCOMPOSER
echo ---------------------------------------------------------------
echo COMPOSER IS NOT INSTALLED
echo ---------------------------------------------------------------

:END

set baseWamp=
set defaultPHPver=
set composerInstalled=
set phpFolder=
```



在命令行中调用批处理，像这个样子。

```
// 使用默认路径下版本的 PHP
C:\> phppath
```

或者

```
// 使用指定路径下版本的 PHP
C:\> phppath 7.4.22
```



**最好以管理员身份运行此批处理程序哦！**

效果图：

图01



本教程的其余部分假设你已完成（比如 `WAMPServer` 都是 OK 的），并且 `phppath.cmd` 可以正常工作。

接下来我们就要来安装 `Composer` 啦！



### 安装 `Composer`

作为举例，按前面批处理中的参数设定，我将把 `Composer` 安装到 `C:\wamp64\composer`  。

当然了它可以被放置在任何地方任何文件夹，只要你修改上面的批处理文件参数 `composerInstalled` 即可。



1. 启动命令提示符，指定你在 `WAMPServer` 中安装的 PHP 版本，然后创建一个文件夹来放置 `Composer` 。

   ```
   // 指定版本 8.0.1 的 php.exe
   C:\> phppath 8.0.1
   
   // 切换到 \wamp64 目录
   C:\> CD \wamp64
   
   // 创建名称为 composer 的新文件夹
   C:\> MKDIR composer
   
   // 切换到 \wamp64\composer 目录
   C:\> CD composer
   ```

   

2. 打开链接 `https://getcomposer.org/download` ，进入 `Composer` 官网。

   * 切记**不要**使用 **Windows Installer** 
   * 而是找到标有 **Command-line installation** 字样的区域

   

   此处共有四行命令，按顺序分四次每次只复制一行并执行之，一共复制执行四次。

图02



为了使其更容易运行我们现在创建一个 `composer.bat` 文件，这样我们就可以像运行普通命令一样运行 `composer` 了。

OK，还是继续在刚才的 `composer` 文件夹中，然后复制粘贴并执行下面命令行，就可以创建 `composer.bat` 文件了。

```
echo @php "%~dp0composer.phar" %*>composer.bat
```



好了，现在你可以随时随地启动命令提示符并执行 `phppath.php` ，然后再执行 `composer` 命令了。

通过执行以下命令来查看 `Composer` 的状态信息。

```
composer -v
```

图03



如果你在前面的安装过程中遭遇任何问题，别担心，完全可以将那个 `composer` 文件夹删除，然后再重新来过。



### 一劳永逸的方法

经过上面的操作，基本上我们就可以很好地使用 `Composer` 了，这也是官方建议的方法。

不过这里有一个问题，那就是每次我们需要用到 `Composer` 的时候，总是要先执行一下 `phppath` 这个批处理程序。

我是个完美主义者，我不想每次都要先执行这个 `phppath` ，而是想直接打开了命令提示符就能用上 `Composer` 。

嗯，其实这还是可以做到的！



之所以非要先运行 `phppath` ，其根本原因就是 `php.exe` 并不是在任何地方都能被找到并成功执行。

所以解决的方法就很简单了，那就是在系统环境变量中追加 `php.exe` 所在的文件夹路径。

怎么追加？往下看！



1、控制面板 > 系统和安全 > 系统，点击左侧的 `高级系统设置` 。

图04



2、在 `系统属性` 中的 `高级` 选项卡中点击 `环境变更(N)...` 。

图05



3、点击**系统变更**一栏中的 `Path` 那一行，再点击 `编辑(I)...` 。

图06



4、点击 `新建(N)` ，追加一行 `composer.bat` 的所在路径，比如 `C:\wamp64\composer` 。

图07



一顿确定、保存后退出，OK，搞定！

然后重新打开一个命令提示符窗口，再输入 `composer` 回车试一试，是不是可以直接用啦？



### 写在最后

`Composer` 本质上只是一段用 `PHP` 写的程序代码文件，是通过调用 `php.exe` 来解释执行的，实际与你自己写的 `php` 文件没有本质上的区别。

它与开发环境的 `WAMPServer` 并没有什么直接关联，所以你完全可以通过官网直接安装和使用 `Composer` ，这都是没什么问题的。

`Composer` 中文官方网址有详细地介绍和使用文档，小伙伴们可以去官网上参考学习。

中文网址：https://www.phpcomposer.com/

此外友情提醒一下，`Composer 1.x` 版本已被弃用，现在使用的版本是 `2.x` ，注意识别，在学习和开发中可能会遇到一些奇怪问题。

好了，最后如有什么疑问，欢迎大家关注讨论，祝小伙伴们工作学习好运连连！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

