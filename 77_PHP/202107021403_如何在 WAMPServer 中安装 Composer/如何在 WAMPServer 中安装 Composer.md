如何在 WAMPServer 中安装 Composer

副标题：

英文：

关键字：



`WAMPServer` 应该有不少人特别是新手小白认识，它是出自法国大神的一款 `PHP` 开发环境集成包。

而 `Composer` 呢，可能知道的人要少一些了，它则是 `PHP` 用来管理依赖关系的一款工具软件，类似于 Linux 中的程序依赖库文件的管理器。

它功能强大，可以帮助我们自动安装项目中声明的一些依赖库文件而无需我们自己一个一个去搞定，可以说是学习 `PHP` 开发必须接触和了解的一款神器。

对于初学者们，往往经常使用的 Windows 上的 `PHP` 集成开发环境就是 `WAMPServer` 了，而 `Composer` 又是我们必学的一款神器，那么问题来了，我们怎么将两者结合在一起，怎么能让这俩个好兄弟更好地为我们服务呢？

欢迎进入我们今天的（走进科学）节目！



### 01

首先，我们要知道，`Composer` 是一款命令行工具，它其实是要用到 `PHP` 的，因此我们的首要任务就是要确保在命令行模式下 `php.exe` 这个主程序必须在任何路径下都能正常识别和运行。

因此没什么大的花样，你只要在 Windows 系统中追加变量值到 `PATH` 这个环境变量中即可。

听上去很简单很 easy 是不是？

所以我们可以这样，创建一个批处理小程序，当你打开它时它运行命令输入窗口，此时 `Composer` 所用的完全路径 `php.exe` 文件会被自动追加到 `PATH` 环境变量中。

这种情况下，`WAMPServer` 也无法感知 `PATH` 的临时变动。



这个批处理文件命名为 `phppath.cmd` ，并将其保存到系统环境变量 `PATH` 所指向的任意路径中，这么一来，我们就可以在任何地方启动这个批处理程序了。



可以直接下载批处理文件，也可参考如下内容。

下载链接：



批处理文件内容：

```powershell
@echo off
REM **********************************************************************
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

作为举例，按前面批处理中的参数设定，我将把 `Composer` 安装到 `c:\wamp64\composer`  。

当然了它可以被放置在任何地方任何文件夹，只要你修改上面的批处理文件参数 `composerInstalled` 即可。



1. 启动命令提示符，指定你在 `WAMPServer` 中安装的 PHP 版本，然后创建一个文件夹来放置 `Composer` 。

   ```
   // 指定版本 8.0.1 的 php.exe
   > phppath 8.0.1
   
   // 切换到 \wamp64 目录
   > CD \wamp64
   
   // 创建名称为 composer 的新文件夹
   > MKDIR composer
   
   // 切换到 \wamp64\composer 目录
   > CD composer
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



一劳永逸的方法

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



















