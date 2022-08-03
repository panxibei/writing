【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！

副标题：【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！

英文：master-wampserver-quickly-and-php-debugging-too-troublesome-ask-xdebug-to-help

关键字：wamp,wampserver,php,web,apache,mysql,mariadb,check,problem,troubleshooting,tips,xdebug,debug





> **WAMPSERVER免费仓库镜像（中文）**
> https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files







### 安装 `XDebug`

安装包可以到本文开头的 **WAMPSERVER免费仓库镜像（中文）**中下载。



双击安装包。

图a01



给我们提示，当前版本的 `Xdebug` 仅适用于 `PHP` 版本 `7.2` 、`7.3` 、`7.4` 、`8.0` 和 `8.1` ，不应安装在旧版本上。

也就是说，这个更新程序将只考虑 `PHP` `7.2` 到 `8.1` 之间的版本。

图a02



继续安装。

图a03

图a04



再次出现提示信息，说什么在 `php.ini` 配置文件中不存在 `[xdebug]` 区域或内容为空。

图a05



如果你在前面的教程中认真学习过的话，那么应该还记得 `WAMPServer` 中存在两种 `php.ini` 配置文件。

一个是 `php.ini` ，还有一个是 `phpForApache.ini` 。

前者负责终端环境，而后者则是应用于 `WEB` 引擎。

也就是说，后者 `phpForApache.ini` 才是我们访问 `WEB` 时的真实配置文件。

打开 `phpForApache.ini` 即可验证，的确已经有 `[xdebug]` 的设定内容。

由于 `xDebug` 高低算是个图形程序，因此保持目前配置不变也能正常使用。

图a07



Ok，直接下一步，安装完成！

图a06



### xDebug

我们打开 `localhost` 主页，在页面左侧工具区域就能看到 `xdebug_info()` 。

图b01



点开它你就能看到 `xDebug` 的样貌了。

图b02















 在默认的 php.ini 中包含一个完整的 [xdebug] 部分： 

```
; XDEBUG Extension
[xdebug]
zend_extension="c:/wamp(64)/bin/php/php7.4.26/zend_ext/php_xdebug-3.1.1-7.4-vc15-x86_64.dll"
;xdebug.mode allowed are : off develop coverage debug gcstats profile trace
xdebug.mode = develop
xdebug.output_dir = "/tmp"
xdebug.profiler_output_name = trace.%H.%t.%p.cgrind
xdebug.use_compression = false
xdebug.show_local_vars = 0
xdebug.log = "/tmp/xdebug.log"
xdebug.log_level = 7
```









*PS：《【小白PHP入坑必备系列】快速全面掌握 WAMPServer》教程列表：*

* *【快速全面掌握 WAMPServer】01.初次见面，请多关照*
* *【快速全面掌握 WAMPServer】02.亲密接触之前你必须知道的事情*
* *【快速全面掌握 WAMPServer】03.玩转安装和升级*
* *【快速全面掌握 WAMPServer】04.人生初体验*
* *【快速全面掌握 WAMPServer】05.整明白 Apache*
* *【快速全面掌握 WAMPServer】06.整明白 MySQL 和 MariaDB*
* *【快速全面掌握 WAMPServer】07.整明白 PHP*
* *【快速全面掌握 WAMPServer】08.想玩多个站点，你必须了解虚拟主机的创建和使用*
* *【快速全面掌握 WAMPServer】09.如何在 WAMPServer 中安装 Composer*
* *【快速全面掌握 WAMPServer】10.HTTP2.0时代，让 WampServer 开启 SSL 吧！*
* *【快速全面掌握 WAMPServer】11.安装 PHP 扩展踩过的坑*
* *【快速全面掌握 WAMPServer】12.WAMPServer 故障排除经验大总结*
* *【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！*
* *【快速全面掌握 WAMPServer】14.各种组件的升级方法*



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾的博客 / www.sysadm.cc