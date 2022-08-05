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



刚刚介绍的安装方法非常适合作为新手的小伙伴，不过其他除此之外呢还有其他的安装方法。

在此也简单地介绍一下，让大家有更多的了解。



**方法二，利用 `xDebug` 官方的向导来安装。**

> http://xdebug.org/wizard



打开向导页面，将 `phpinfo` 显示的所有内容一字不落地复制并粘贴到向导页面的框框中。

然后呢，点击最下方的按钮来分析当前给出的 `phpinfo` 信息。

请放心，上面也有说明，系统只拿来做分析，并不会保存用户的什么信息，不放心的可以查看它的代码。

图c05



不得不说这个向导是真心方便，我们可以很轻松地从结果中获得很多有用的信息。

比如，所需要下载的文件，又比如，接下来怎么安装，等等。

图c06



简单地总结一下安装步骤（以我为例）：

1. 下载 `php_xdebug-3.1.5-7.4-vc15-x86_64.dll` 。

2. 将下载的文件移动到 `c:\wamp64\bin\php\php7.4.26\ext` ，重命名为 `php_xdebug.dll`

3. 更新 `C:\wamp64\bin\apache\apache2.4.51\bin\php.ini`

   （注意：`php.ini` 的实际路径为 `C:\wamp64\bin\php\php7.4.26\phpForApache.ini`）

   并添加以下行：

   ```
   zend_extension = xdebug
   ```

   确保 `zend_extension = xdebug` 位于 **`OPcache`** 所在行的下方。

4. 也请更新 `php.ini`相邻文件目录，因为您的系统似乎配置了单独的 `php.ini` `Web` 服务器和命令行的文件。

   这句话的意思是，`php.ini` 不止一个，除 `WEB` 所属 `php.ini` ，其他都要更新，比如终端命令行所属 `php.ini` ，或其他 `PHP` 版本等等。

5. 重新启动 `Apache` 网络服务器。



重启服务后再查看 `phpinfo` 来确认 `xDebug` 加载是否成功。



**方法三，直接下载 `xDebug` 扩展后手动安装。**

> https://pecl.php.net/package/xdebug



下载 `PECL` 上最新稳定版 `3.1.3` 的 `DLL` 文件，这个文件就是在 `Windows` 下可使用的扩展文件。

图c01



接下来区分选择你正在使用的 `PHP` 版本、`64` 还是 `32` 位系统以及线程安全 `TS` 还是非安全 `NTS` 。

前面我们介绍过，在 `Windows` 下你可以简单地记忆为线程安全 `TS` ，然后再结合你的 `PHP` 版本及 `x64/x32` 就可以知道选哪个了。

比如我的 `PHP` 版本是 `7.4.26` ，`64` 位 `Windows` 系统，因此我下载到的文件名为 `php_xdebug-3.1.3-7.4-ts-vc15-x64.zip` 。

图c02



将下载的压缩文件解压缩后，找到 `php_xdebug.dll` 文件。

图c03



将 `php_xdebug.dll` 拷贝或移动到相应 `PHP` 版本的 `ext` 文件夹内。

```
C:\wamp(64)\bin\php\phpX.X.XX\ext
```



 然后打开 `php.ini` 配置文件，在文件的最后底部添加以下代码。

```
[xdebug]
zend_extension=C:/wamp(64)/bin/php/phpX.X.XX/ext/php_xdebug.dll
xdebug.profiler_output_dir="C:/wamp(64)/tmp"
xdebug.trace_output_dir="C:/wamp(64)/tmp"
xdebug.remote_port=9000
xdebug.idekey=SYSADM.CC
xdebug.remote_autostart=1
xdebug.remote_host=localhost
xdebug.remote_enable=1
```

注意，不是简单地添加 `extension=xdebug.dll` 哦！

重新加载服务并刷新 `phpinfo` ，可以看到 `xDebug` 出现了！

图c04





### xDebug

我们打开 `localhost` 主页，在页面左侧工具区域就能看到 `xdebug_info()` 。

图b01



点开它你就能看到 `xDebug` 的样貌了，这在 `phpinfo` 中看到的应该是一样的。

图b02



### 启用 `xDebug` 的三大功能

##### 开发助手 - `Development Helpers`

`xDebug` 的开发助手可以优化你的调试错误信息，比如 `var_dump()` 功能的更新等等。

还是举例来说明比如直观一些。



在 `wamp(64)/www` 下新建一个 `testxdebug.php` 文件，并用以下测试代码填充。

```
<?php
$arr = array (
  "one" => 
    array (
	  "a" => "欢迎关注微信公众号：网管小贾！",
	  "b" => "网管小贾 / sysadm.cc"
	),
  "two" =>
    array (
      "two.one" =>
        array (
          "two.one.zero" => 210,
          "two.one.one" =>
            array (
              "two.one.one.zero" => 3.141592564,
              "two.one.one.one" => 2.7
            )
        )
    )
);

var_dump($arr);
?>
```



没有使用 `xDebug` 扩展的情况下，会被添加 `<pre>` 标签。

图d01



即便手动加了 `<pre>` 标签，一旦数据结构比较复杂，这没层次没重点的标识也很容易眼花。

图d02



 但是加载 `Xdebug` 后它的感觉就完全不一样了！

眼睛、鼻子、嘴巴和耳朵，分分钟看清啊！

图d03



哎，有的小伙们眼尖，为啥最后有三个黑点，我想看看后面不行？

其实这是因为 `xDebug` 默认设定了显示字符限制。

我们只要在 `php.ini` 的 `xDebug` 区域追加或修改以下参数即可。

```
; 允许一个数组最多显示多少个元素
xdebug.var_display_max_children=128

; 允许一个字符串变量最多显示多少个字节
xdebug.var_display_max_data=512

; 允许一个数组最多显示多少个维度
xdebug.var_display_max_depth=5
```



重启服务后我们再来试一试，果然显示完整了！

图d04



那这期间 `xDebug` 都为我们做了哪些工作呢？

- 它帮我们自动添加了 `<pre>` 标签。

- 它在输出信息最上部显示了 `文件/行` 信息，比如：

  ```
  /tmp/var_dump.php:23
  ```

- 格式更简洁，数组键和类型在同一行。 

- 为每种数据类型添加了不同的颜色。 

- 它特意压缩限制了嵌套级别的深度。

  这样有利于全局查看变量，如果要看完整内容，则应该设定前面说明过的三个参数。

  ```
  array (size=2)
     ...
  ```

- 指示递归是针对哪个对象。 

  ```
  &object(test)[1]
  ```



针对 `CLI` 终端命令行下的调试也是一样的。

图d05



如果在 `CLI` 下也需要显示不同颜色，那么也是可以做到的，只要在 `php.ini` 的 `xDebug` 区域添加或修改以下参数。

```
xdebug.cli_color=2
```

如果这个参数设定为 `1` ，那么还需要安装 `ANSICON` 工具，具体请参考官网。

只是这里设定为 `2` 呢，有可能会看到一些转义码。

图d06



堆栈跟踪

调试期间代码出错再所难免，但是没有加载 `xDebug` 的错误处理信息显得有些干巴巴。

图d07



而加载了 `xDebug` 扩展的话，它会在原有的标准错误回调基础上显示得更像是在调试错误。

图d08



具体如何显示调试信息，由于内容庞大，请小伙伴们移驾官网说明页面吧。

> http://xdebug.org/docs/develop



##### 分步调试





以 `VSCodium` 为例：

打开 `VSCodium` ，点击左侧的 `扩展` ，在搜索栏内输入 `xdebug` ，查找到 `PHP Debug` 并安装。

图d09



然后编辑 `launch.json` 启动文件。

点击 `VSCodium` 左侧的 `运行和调试` ，然后再点击 `打开文件夹` 。

此处需要注意的是，我们必须先要打开某个文件或某个文件夹（项目）中的文件，在文件编辑状态下才能开启并修改启动文件 `launch.json` 。

图f01



比如我们随便打开一个 `.php` 文件，这时我们再点击左侧的 `运行和调试` ，就可以看到可以点击 `创建 launch.json 文件` 了。

图f02



点击 `创建 launch.json 文件` ，然后在下拉列表中选择 `PHP` 。

我们用的是 `xDebug` ，调试的是 `PHP` 程序，因此选择 `launch.json` 创建类型选择 `PHP` 。

图f04



这个 `launch.json` 文件实际位于你打开项目中名为 `.vscode` 的隐藏文件夹内，直接编辑它也是可以的。

图f03



我这儿的代码内容是这样的。

```
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 0,
            "runtimeArgs": [
                "-dxdebug.start_with_request=yes"
            ],
            "env": {
                "XDEBUG_MODE": "debug,develop",
                "XDEBUG_CONFIG": "client_port=${port}"
            }
        },
        {
            "name": "Launch Built-in web server",
            "type": "php",
            "request": "launch",
            "runtimeArgs": [
                "-dxdebug.mode=debug",
                "-dxdebug.start_with_request=yes",
                "-S",
                "localhost:0"
            ],
            "program": "",
            "cwd": "${workspaceRoot}",
            "port": 9003,
            "serverReadyAction": {
                "pattern": "Development Server \\(http://localhost:([0-9]+)\\) started",
                "uriFormat": "http://localhost:%s",
                "action": "openExternally"
            }
        }
    ]
}
```



从上述代码中我们可以看到，端口是 `9003` ，这个端口应该和再前面的 `php.ini` 中的 `xDebug` 区域中的端口设定一致。



最后确保 `VSCodium` 左上角的运行一栏是设定为 `Listen for Xdebug` 。

图f05



如何使用呢？

设定代码调试的断点，用鼠标点击来标记，也可以按下 `F9` 来设置。

图f06



打开浏览器，访问正在编辑调试代码的文件。

此时程序就会自动运行直至跑到断点处停下来，并且显示为一个箭头。

图f07



接下来应该就懂了吧，结合输出效果，一边按下 `F11` 等单步调试按钮，一边调试代码查找问题。

图f08



浏览器访问 `PHP` 代码程序调试已经OK，那终端命令行模式下呢？

其实很简单，配置和前面差不多，只是在 `CLI` 的 `php.ini` 中编辑而已。

















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