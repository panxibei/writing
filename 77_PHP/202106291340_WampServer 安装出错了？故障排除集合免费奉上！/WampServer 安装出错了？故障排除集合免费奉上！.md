WampServer 安装出错了？故障排除集合免费奉上！

副标题：WampServer 小白特辑~

英文：

关键字：wamp,wampserver,php,web,apache,mysql,mariadb



众所周知，搞开发需要先搭建相应的编程和调试环境。

对于 `PHPer` 来说，很多像我一样的新手小白们入门时的，通常会选择一些集成开发环境包，其中就有 `WampServer` 。

集成环境包被许多人所诟病，存在各种各样的问题，然后极力推荐 Linux 环境下开发。

我作为有个几年经验的老菜鸟，很想说的是，集成包有集成包的好处，特别是对于刚入门的新手，大大简化了搭建环境的流程。

而对于有一定经验的人来说，快速地建立一个测试用的开发环境，也是集成包的优势之一。

所以说，我们没有必要说一个好就说另一个坏，要看你用的场景，武器好与坏，关键要看你怎么用。



> 前文参考：《WampServer最新版一键安装》
>
> 文章链接：https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install



即便通过一键安装提高了不少效率，对于刚入门的小伙伴们也可能存在不少安装后遗症。

本文将就 WampServer 论坛上收集总结的关于故障排除的内容翻译成中文并增加一些具体的说明于此，以便为各位遇到困难的小伙伴们解惑。

需要注意的是，以下内容即使在你正式开始安装 WampServer 前，也是可以先来读上一读的，俗话说有备无患，只有好处没有坏处。



安装完成后 `WampServer` 正常的先决条件

* 任务栏中的 `WampServer` 图标正常情况下应该是绿色的。



如果图标不是绿色的，那么这意味着 `Apache/PHP/MySQL/MariaDB` 这些服务中至少有一项未正常启动。

那么接下来，让我们看看具体怎么处理问题。



### 0x01

如果你是尝试升级现有 `WampServer` 到更新版本或最新版本，那么请务必参考下面这篇文章。

如果还没开始升级，那么先看一遍是最佳选择。

> http://forum.wampserver.com/read.php?2,123606



### 0x02

必须以管理员身份安装 `WampServer` ，就是右键单击安装文件，然后从菜单中选择 `以管理员身份运行` 。

墙裂建议将 `WampServer` 安装在分区的根目录，比如 `C:\Wamp` 或 `D:\Wamp` 之类），并且不要使用包含空格、特殊符号或中文之类的字符来做为文件夹名称，比如不要安装在 `C:\Program Files` 之类。



### 0x03

如果你安装并运行着 `Skype` ，那么很不幸它占用了 80 或 443 端口。

依次找到 `Skype` 菜单中的 `工具` > `选项` > `高级设置` > `连接` ，然后取消选中 `使用80和443端口作为接入连接的备用端口` 。

图01

在 Windows 8/8.1/10 平台上的APP版本的 `Skype` 可能无法直接更改此设置，因此可以先卸载 APP ，然后再下载安装后按前面的设置操作即可。



### 0x04

如果 `WampServer` 图标不是绿色的，则表示至少有一项服务未启动成功。

注意：从 `WampServer 3.0.7` 开始，一共有三个服务（Apache、MySQL 和 BariaDB），不再只有两个（Apache  和 MySQL）。

* 32 位版本：wampapache、wampmysqld 和 wampmariadb
* 64 位版本：wampapache64、wampmysqld64 和 wampmariadb64



想检查那些服务未启动？

方法一：打开服务管理器程序（services.msc），检查名称为 wampapache、wampmysqld 和 wampmariadb 或 wampapache64、wampmysqld64 和 wampmariadb64 的服务状态。

方法二：右击 `WampManager` 图标，选择 `Tools` > `Check status of services` 。

图a02



可以看到，`wampapache64` 和 `wampmariadb64` 两个服务均已正常启动。

图a03



### 0x05

使用服务管理器来检查，除了 `wampapche(64)` 和 `wampmysqld(64)` 之外没有任何其他的 `Apcache` 或 `MySQL` 服务。



### 0x06

系统上是否还有其他未包含在 wamp 路径中的 `php.ini` 文件？

如果有，请删除它们。

`php.ini` 文件是 `PHP` 的主配置文件，同时存在多个主配置文件可能会造成系统加载配置错乱。

可以使用命令切换到分区根目录，然后执行 `dir /s php.ini` 来查找是否还有其他的 `php.ini` 文件。



### 0x07

系统上是否还有其他未包含在 wamp 路径中的 `my.ini` 文件？

如果有，请删除它们。

`my.ini` 文件是 `MySQL` 的主配置文件，同时存在多个主配置文件可能会造成系统加载配置错乱。

可以使用命令切换到分区根目录，然后执行 `dir /s my.ini` 来查找是否还有其他的 `my.ini` 文件。



### 0x08

**你是否安装了 IIS ？**

按不同的系统平台，可以这样来检查。

* (XP) 控制面板 > 添加/删除程序 > Windows 组件
* (W7/W8/W10) 控制面板 > 程序和功能 > 打开或关闭 Windows 功能



**如何删除 IIS ？**

* (XP/W7/W8) 取消选中：
  * Main Web Internet 服务实例 ( IIS)
  * 分支的所有项目: Internet services (IIS)
  * 分支的所有项目: Activation Windows service process

图a04



* (W10) 取消选中：
  * Internet Information Services (IIS) 的主要实例 Web
  * 分支的所有项目：Internet Information Services

图a05



### 0x09

以管理员身份编辑 `Windows\System32\drivers\etc\hosts` 文件，确保其中含有以下内容。

```
# 确保存在这么一行解析记录。
127.0.0.1 localhost

# 如果系统支持 IPv6 ，则可以再加上一行。
::1 localhost
```



### 0x10

确保杀毒软件或其他安全软件不会阻止访问以下相关文件。

比如，在 `Windows Defender` 中设置排除 `C:\Wamp` 文件夹的检查扫描。

- Windows\System32\drivers\etc\hosts
- wamp\Wampmanager.exe
- wamp\bin\apache\apache2.2.x\bin \httpd.exe
- wamp\bin\mysql\mysql5.xy\bin\mysql.exe
- wamp\bin\mysql\mysql5.xy\bin\mysqlcheck.exe
- wamp\bin\mysql\mysql5.xy\ bin\mysqld.exe
- wamp\bin\php\php5.3.x\php.exe



### 0x11

任何其他类似的集成软件（ `EasyPHP` 、`XAMPP` 、`IIS` 或其他）均与 `Wampserver` 不兼容，故必须在安装 `WampServer` 之前完全卸载之。



### 0x12

`MySQL` 或 `Apache` 日志文件中是否有任何错误？

日志文件位于 `/wamp/logs/` 文件夹中。



### 0x13

Windows 事件查看器中是否有错误记录？



### 0x14

确保您的防火墙和防病毒保护**允许**（而不是禁止）访问端口 `80` 和 `3306` 。



### 0x15

如果您之前卸载了 `Wampserver` ，请务必验证在安装新版本之前，`wampapache(64)` 和 `wampmysqld(64)` 服务均已被正确删除。



### 0x16

**仅当**您拥有 Windows 64 位操作系统时才安装 `Wampserver` 64位程序，在这种情况下，请始终使用最新版本的 `WampServer` 。

请注意，使用 64 位 `Apache` 、`PHP` 和 `MySQL` 以及所有扩展和模块必须始终**编译为 64 位线程安全（Thread Safe）**。



### 0x17

访问 `PhpMyAdmin` 时提示消息“禁止访问，您无权访问此服务器上的 /phpmyadmin/”。

这时你可以编辑 `wamp\alias\phpmyadmin.conf` 文件。

```
# 如果你用的是 Apcache 2.2.x

# 那么将
Allow from 127.0.0.1
# 修改为
Allow from localhost 127.0.0.1
# 如果系统支持 IPv6，则修改为
Allow from locahost ::1 127.0.0.1
```



```
# 如果你用的是 Apache 2.4.x，那么只要一行
Require local
```



此外如果为了兼顾 `Apache 2.2.x` 和 `Apache 2.4.x` 的其他配置而无需修改 `php.ini` 文件，你可以参考如下代码来编辑调整 `wamp\alias\phpmyadm.conf` 文件。

```
Alias /phpmyadmin j:/wamp/apps/phpmyadmin4.x.y/

<Directory j:/wamp/apps/phpmyadmin4.x.y/>
  Options Indexes FollowSymLinks MultiViews
  AllowOverride all
  
  # 如果是 Apache 2.4.x，则
  <ifDefine APACHE24>
    Require local
  </ifDefine>
  
  # 如果不是 Apache 2.4.x，则
  <ifDefine !APACHE24>
    Order Deny,Allow
    Deny from all
    Allow from localhost ::1 127.0.0.1
  </ifDefine>

  php_admin_value upload_max_filesize 256M
  php_admin_value post_max_size 256M
  php_admin_value max_execution_time 360
  php_admin_value max_input_time 360
</Directory>
```



### 0x18

本地访问提示“禁止访问，你没有权限访问服务器的 / ” 。

```
# 如果你用的是 Apache 2.2.x
# 编辑文件 “wamp\bin\apache\Apache2.2.xx\conf\httpd.conf”

# 将
Allow from 127.0.0.1
# 修改为
Allow from localhost 127.0.0.1
# 如果系统支持 IPv6，则修改为
Allow from locahost ::1 127.0.0.1
```

```
# 如果你用的是 Apache 2.4.x
# 编辑文件 "wamp\bin\apache\Apache2.4.xx\conf\httpd.conf"，就一行
Require local
```



### 0x19

**PhpMyAdmin**

安装 `Wampserver` 或新版本的 `MySQL` 或 `MariaDB` 后， `PhpMyAdmin` 登录的默认用户名是 `root`，而密码为空。



**Adminer**

`Adminer` 不接受空密码的连接。

安装 `Wampserver` 或新版本的 `MySQL` 或 `MariaDB` 后，唯一的用户是 `root` ，没有密码。

要连接到 `Adminer`，必须首先为 `root` 用户设置密码。



怎么事先设置密码呢？

可以这么干，两个办法：

1. 连接到 `PhpMyAdmin` ，找到用户帐户选项卡，找到 `root` ，然后编辑权限，最后更改密码。

2. 使用的数据库管理程序或命令控制台连接到 `MySQL` 或 `MariaDB` ，然后执行以下语句。

   

   修改 `root` 用户密码和权限。

   ```sql
   # MySQL 8 以下版本
   
   # Privileges for `root`@`127.0.0.1`
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'password' WITH GRANT OPTION;
   
   # Privileges for `root`@`::1`
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'::1' IDENTIFIED BY 'password' WITH GRANT OPTION;
   
   # Privileges for `root`@`localhost`
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
   GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION;
   ```

   ```sql
   # MySQL 8 以上版本
   
   # Privileges for `root`
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password' PASSWORD EXPIRE NEVER;
   ALTER USER 'root'@'localhost' DEFAULT ROLE ALL;
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
   GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION;
   CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY 'password' PASSWORD EXPIRE NEVER;
   ALTER USER IF EXISTS 'root'@'127.0.0.1' DEFAULT ROLE ALL;
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
   CREATE USER IF NOT EXISTS 'root'@'::1' IDENTIFIED WITH mysql_native_password BY 'password' PASSWORD EXPIRE NEVER;
   ALTER USER IF EXISTS 'root'@'::1' DEFAULT ROLE ALL;
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'::1' WITH GRANT OPTION;
   ```

   

   添加其他用户。

   ```sql
   # MySQL 8 以下版本
   
   # Usage privileges for `username`@`127.0.0.1`
   GRANT USAGE ON *.* TO 'username'@'127.0.0.1' IDENTIFIED BY 'plaintext password';
   
   # Usage privileges for `username`@`localhost`
   GRANT USAGE ON *.* TO 'username'@'localhost' IDENTIFIED BY 'plaintext password';
   
   # Usage privileges for `username`@`::1`
   GRANT USAGE ON *.* TO 'username'@'::1' IDENTIFIED BY 'plaintext password';
   
   # Eventual privileges on a database
   GRANT SELECT, INSERT, UPDATE, DELETE ON `mabase`.* TO 'username'@'127.0.0.1';
   GRANT SELECT, INSERT, UPDATE, DELETE ON `mabase`.* TO 'username'@'localhost';
   GRANT SELECT, INSERT, UPDATE, DELETE ON `mabase`.* TO 'username'@'::1';
   ```

   ```sql
   # MySQL 8 以上版本
   
   # Usage privileges for `username`
   CREATE USER 'username'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'plaintext password' REQUIRE NONE PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK;
   GRANT USAGE ON *.* TO 'username'@'localhost';
   CREATE USER 'username'@'127.0.0.1' IDENTIFIED WITH 'mysql_native_password' BY 'plaintext password' REQUIRE NONE PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK;
   GRANT USAGE ON *.* TO 'username'@'127.0.0.1';
   CREATE USER 'username'@'::1' IDENTIFIED WITH 'mysql_native_password' BY 'plaintext password' REQUIRE NONE PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK;
   GRANT USAGE ON *.* TO 'username'@'::1';
   
   # Eventual privileges on a database
   GRANT SELECT, INSERT, UPDATE, DELETE ON `mabase`.* TO 'username'@'127.0.0.1';
   GRANT SELECT, INSERT, UPDATE, DELETE ON `mabase`.* TO 'username'@'localhost';
   GRANT SELECT, INSERT, UPDATE, DELETE ON `mabase`.* TO 'username'@'::1';
   ```

   

### 0x20

启动 `Wampserver` 时出现系统错误 “托盘菜单 Aestan 遇到问题，需要关闭” 。

或者有时打开 `PhpMyAdmin` 和/或 `localhost` 是空白页（未加载页面）。

最新版本的 `WampServer`（包括最新版本的 Apache、PHP 或 MySQL）针对 `PHP 7` 由 `VC9`  (Microsoft Visual C++ 2008)、`VC10`  (Microsoft Visual C++ 2010)、`VC11`  (Microsoft Visual C++ 2012)、`VC14` 、`VC15`  和 `VC16`  (Microsoft Visual C++ 2015-2019) 编译生成，因此你必须确保已安装了所有的 `Microsoft Visual C++` 组件包。

另外还要确保这些发行包 VC9、VC10、VC11、VC13、VC14、VC15 和 VC16 都是最新的。

即使你认为自己安装的已经是最新的了，但是也请以管理员身份安装每一个软件包，如果出现“已安装”提示，验证修复它即可。

`Wampserver` 的 `2.4`、`2.5` 和 `3.0.0` 必须安装这些软件包（VC9、VC10、VC11），即使你只使用  `Apache 2.4.17+` 和 `PHP 7` （VC11 和 VC13、VC14、VC15 和 VC16），前面提及的那些软件包仍然是必需安装的。





> VC9 Packages
> For Windows 2000 Service Pack 4; Windows Server 2003; Windows Server 2008; Windows Vista; Windows XP, W7, W8
> Microsoft Visual C++ 2008 SP1 Redistributable Package (x86) (32bits)
> Microsoft Visual C++ 2008 SP1 Redistributable Package (x64) (64bits)
>
> 
>
> VC10 Packages
> For Windows 7; Windows Server 2003; Windows Server 2008; Windows Server 2008 R2; Windows Vista; Windows XP
> Microsoft Visual C++ 2010 SP1 Redistributable Package (x86)
> Microsoft Visual C++ 2010 SP1 Redistributable Package (x64) 
>
> 
>
> VC11 Packages Nota: VC11 is not supported by Windows XP
> Windows 7 Service Pack 1; Windows 8; Windows Server 2008 R2 SP1; Windows Server 2012; Windows Vista Service Pack 2
> The two files VSU4\vcredist_x86.exe and VSU4\vcredist_x64.exe to be download are on the same page:
> Visual C++ Redistributable for Visual Studio 2012 Update 4 (x86 and x64)
>
> 
>
> VC13 Packages (Required for Apache 2.4.17 and PHP 7)
> Windows 7 Service Pack 1; Windows 8; Windows Server 2008 R2 SP1; Windows Server 2012; Windows Vista Service Pack 2
> The two files VSU4\vcredist_x86.exe and VSU4\vcredist_x64.exe to be download are on the same page:
> Visual C++ Redistributable Packages for Visual Studio 2013
>
> 
>
> VC14 and VC15 Packages are replaced by VC16 (VC 2015-2019) packages
>
> 
>
> VC16 Paquetages - VC 2015-2019 14.23.27820
> Visual C++ Redistributable Packages for Visual Studio 2015-2019 x86
> Visual C++ Redistributable Packages for Visual Studio 2015-2019 x64
>
> VC2015-2019 (VC16) is backward compatible to VC2015 (VC14) and VC2017 (VC15). 
>
> That means, a VC14 or VC15 module can be used inside a VC16 binary. 
>
> Because this compatibility the version number of the Redistributable is 14.2x.xx and after you install the Redistributable VC2015-2019, the Redistributable packages VC2015 (VC14) and VC2017 (VC15) are eventually deleted but you can still use VC14 and VC15.





如果出现 `api-ms-win-crt-runtimel1-1-0.dll` 丢失的提示，那么你可能还需要安装 Windows 通用 C 运行库更新。

参考链接如下：

[Update for Universal C Runtime in Windows](https://support.microsoft.com/en-gb/kb/2999226)

https://support.microsoft.com/en-gb/kb/2999226



**如果你使用的是 64 位 Windows，则必须同时安装 32 位和 64 位版本的 VC 组件，注意，即使你安装的不是 64 位  `Wampserver` 也要这么做。**

警告：有时 `Microsoft` 会禁用一些 VC++ 组件的下载链接，所以你可以在我的网站上查找所需的发行软件包来下载安装。



**验证是否已安装所有 VC ++ 软件包并使用最新版本的工具。**

[Checks VC++ packages installed](https://wampserver.aviatechno.net/files/tools/check_vcredist.exe)

https://wampserver.aviatechno.net/files/tools/check_vcredist.exe

将网站上所有的 `Visual C++ Redistribuable Packages` 都要安装，并且不要忘记：

* 64位 Windows 上，32位和64位组件包都要安装
* 必须以管理员身份运行来安装每一个组件包



### 0x21

昨天 `MySQL` 还是正常的，但是今天我的 `wampmanager` 图标变成了橙色，并且 `MySQL` 无法启动。

- 相较于 `MYISAM` 数据库引擎而言，这种情况往往多发于 `INNODB` 数据库引擎。

- 在“/wamp/logs/”中检查 MySQL 日志，如果你在日志中看到有提示信息说 MySQL 已尝试修复数据库或数据库表但失败了。无论出于其他何种原因，一般来说很可能是你的数据库已损坏从而导致 `MYSQL` 无法启动，因为它无法正确修复数据库。

- 最简单的解决方案就是恢复上一次的备份。（当然是假设你有一个备份，你肯定会做备份的，因为你不会傻得忘记做备份，对吧！）

- 好吧，如果你真的没有做任何备份，那么你应该检查一下 MYSQL 日志中的相关信息，里面会建议一些可能的恢复机制。

  亦或者，你只好自己阅读一下  [InnoDB Backup and Recovery](https://dev.mysql.com/doc/refman/5.6/en/innodb-backup.html) 。

  https://dev.mysql.com/doc/refman/5.6/en/innodb-backup.html

- 为了减少这种情况发生的可能性，请确保您可以通过使用 wampmanager 菜单上的“退出”关闭 WAMPServer

- - 右键单击 wampmanager -> 退出

- 或停止使用 MYSQL 服务

- - 左键单击 wampmanager ->
在重新启动或关闭 WINDOWS 21之前停止所有服务-a为什么我需要在关闭 Windows 之前关闭 Wampserver 吗？


Wampserver 的“正常”关闭执行以下操作：
- 停止 Apache 服务
- 停止 MySQL 服务
- 停止 mariaDB 服务

当服务“正常”停止时会发生什么？
- 对于 Apache：
- 关闭 Apache 服务器
- 关闭所有 Apache 进程
- 关闭Apache的“子”服务器

- 对于 MySQL 或 MariaDB
- 清除队列。
-- Dumping buffer pool(s)
-- 删除临时表空间数据文件
-- Close MySQL server

当Windows在没有之前关闭Wampserver的情况下关闭时，在某些情况下，服务没有正常停止，但任务httpd.exe和mysqld .exe 被“杀死”（TASKKILL）。
因此，队列和缓冲区不会运行或转储，这可能会损坏数据库，这可能会导致以下症状：
“昨天运行良好，但今天不起作用！”
