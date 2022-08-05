【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！

副标题：【快速全面掌握 WAMPServer】13.PHP调试麻烦？请 xDebug 来帮忙！

英文：master-wampserver-quickly-and-php-debugging-too-troublesome-ask-xdebug-to-help

关键字：wamp,wampserver,php,web,apache,mysql,mariadb,check,problem,troubleshooting,tips,xdebug,debug,调试





> **WAMPSERVER免费仓库镜像（中文）**
> https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files



对于能否快速高效地编写程序，代码调试水平是多个重要指标之一。

按照这个逻辑，自然而然如何高效地调试代码也就成了一件非常重要而不得不让众多程序员面对的课题了。

其他编程语言的调试可能还好些，可是有过 `PHP` 程序调试经验的小伙伴们肯定多少有些感触，这似乎就不是人干的活啊！

虽然 `WAMPServer` 帮我们搞定了纷繁复杂的开发环境，但是程序调试这一块的确是一座不可逾越的大山。

虽然这么说，其实还好了，多亏 `WAMPServer` 多少还是帮我们做了一些工作的，不过之后还是需要我们自己动手才能更完美地搞定困难。

还好我们有神器 `xDebug` ，一款用来调试 `PHP` 程序的强大工具！

用它来结合 `WAMPServer` 使用，简直是天作之合！



在这里我先要和大家说清楚，实际上这个 `xDebug` 是可以安装在任何 `PHP` 开发环境的，这和 `WAMPServer` 本身没有太大关联。

在稍后一些的文章内容中我也会提到这一点。



### 安装 `xDebug`

有了 `WAMPServer` ，说实话，安装 `xDebug` 是真省心啊！

安装包就有现成的，可以到本文开头的 **WAMPSERVER免费仓库镜像（中文）**中下载。



双击安装包就可以开始安装了。

图01



到了第二步给我们一个提示：当前版本的 `Xdebug` 仅适用于 `PHP` 版本 `7.2` 、`7.3` 、`7.4` 、`8.0` 和 `8.1` ，不应安装在旧版本上。

也就是说，这个更新程序将只考虑 `PHP` `7.2` 到 `8.1` 之间的版本。

图02



没问题，我们继续安装。

图03

图04



再次出现提示信息，说什么在 `php.ini` 配置文件中不存在 `[xdebug]` 区域或内容为空。

图05



如果你在前面的教程中认真学习过的话，那么应该还记得 `WAMPServer` 中其实存在两种 `php.ini` 配置文件。

一个是 `php.ini` ，还有一个是 `phpForApache.ini` 。

前者负责终端命令行环境，而后者则是应用于浏览器访问的 `WEB` 引擎。

也就是说，后者 `phpForApache.ini` 才是我们访问 `WEB` 时的真实配置文件。

打开 `phpForApache.ini` 即可验证，的确已经有 `[xdebug]` 的设定内容。

而作为终端命令行环境的 `php.ini` 的确还没有 `[xdebug]` 设定，有前面的提示信息也就不足为奇了。



由于 `xDebug` 高低算是个在图形下运行的程序，因此保持目前配置不变也能正常使用。

图06



因此忽略提示，直接下一步，安装完成！

图07



刚刚介绍的安装方法非常适合作为新手的小伙伴，不过除此之外呢还有其他的安装方法。

在此也简单地介绍一下，让大家有更多的了解。



### 安装 `xDebug` 的方法二，利用 `xDebug` 官方向导来安装

官方向导链接：

> http://xdebug.org/wizard



打开向导页面，将 `phpinfo` 显示的所有内容一字不落地复制并粘贴到向导页面的框框中。

然后呢，点击最下方的按钮来分析当前给出的 `phpinfo` 信息。

请放心，上面也有说明，系统只拿来做分析，并不会保存用户的什么信息，不放心的可以查看它的源代码。

图08



不得不说这个向导是真心方便，我们可以很轻松地从结果中获得很多有用的信息。

比如，所需要下载的文件，又比如，接下来怎么安装，等等。

图09



简单地总结一下安装步骤（以我当前版本为例）：

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



### 安装 `xDebug` 的方法三，直接下载 `xDebug` 扩展后手动安装

`PECL` 下载链接：

> https://pecl.php.net/package/xdebug



下载 `PECL` 上最新稳定版 `3.1.3` 的 `DLL` 文件，这个文件就是在 `Windows` 下可使用的扩展文件。

图10



接下来区分选择你正在使用的 `PHP` 版本、`64` 还是 `32` 位系统以及线程安全 `TS` 还是非安全 `NTS` 。

前面我们介绍过，在 `Windows` 下你可以简单地记忆为线程安全 `TS` ，然后再结合你的 `PHP` 版本及 `x64/x32` 就可以知道选哪个了。

比如我的 `PHP` 版本是 `7.4.26` ，`64` 位 `Windows` 系统，因此我下载到的文件名为 `php_xdebug-3.1.3-7.4-ts-vc15-x64.zip` 。

图11



将下载的压缩文件解压缩后，找到 `php_xdebug.dll` 文件。

图12



将 `php_xdebug.dll` 拷贝或移动到相应 `PHP` 版本的 `ext` 文件夹内。

```
C:\wamp(64)\bin\php\phpX.X.XX\ext
```



 然后打开 `php.ini` 配置文件，在文件的最后底部添加以下类似代码。

（不要照抄啊，代码不一样没关系，后面会介绍的。）

```
[xdebug]
zend_extension=C:/wamp(64)/bin/php/phpX.X.XX/ext/php_xdebug.dll
xdebug.profiler_output_dir="C:/wamp(64)/tmp"
xdebug.trace_output_dir="C:/wamp(64)/tmp"
xdebug.remote_port=9000
xdebug.idekey=VSCODE
xdebug.remote_autostart=1
xdebug.remote_host=localhost
xdebug.remote_enable=1
```

注意，不是简单地添加 `extension=xdebug` 哦！

重新加载服务并刷新 `phpinfo` ，可以看到 `xDebug` 出现了！

图13



### 确认 `xDebug` 是否安装成功

我们打开 `localhost` 主页，在页面左侧工具区域就能看到 `xdebug_info()` 。

图14



点开它你就能看到 `xDebug` 的样貌了，这在 `phpinfo` 中看到的应该是一样的。

图15



### 启用 `xDebug` 的开发助手 - `Development Helpers`

`xDebug` 的开发助手可以优化你的调试错误信息，比如 `var_dump()` 功能的更新等等，使输出的结果更加优雅，看得眼睛不累。

还是举例来说明比如直观一些。



在 `wamp(64)/www` 下新建一个 `testxdebug.php` 文件，并用以下测试代码填充。

```
<?php
// 定义一个数组变量
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

// 输出这个数组变量
var_dump($arr);
?>
```



没有使用 `xDebug` 扩展的情况下，所有的内容挤在了一起，这怎么看，简直是一团糟啊！

图16



即便手动加了 `<pre>` 标签，一旦数据结构比较复杂，这没层次没重点的标识也很容易眼花。

图17



但是加载 `Xdebug` 后它的感觉就完全不一样了！

眼睛、鼻子、嘴巴和耳朵，分分钟看得清啊！

图18



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

图19



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

图20



如果在 `CLI` 下也需要显示不同颜色，那么也是可以做到的，只要在 `php.ini` 的 `xDebug` 区域添加或修改以下参数。

```
xdebug.cli_color=2
```

如果这个参数设定为 `1` ，那么还需要安装 `ANSICON` 工具，具体请参考官网。

只是这里设定为 `2` 呢，有可能会看到一些转义码。

图21



还有一个堆栈跟踪 `Stack Traces` ，说白了就是可让我们更清楚明白地查看错误中的细节。

调试期间代码出错再所难免，但是没有加载 `xDebug` 的错误处理信息就显得有些干巴巴。

图22



而加载了 `xDebug` 扩展的话，它会在原有的标准错误回调基础上显示得更像是在调试错误。

图23



具体如何显示调试信息，由于内容庞大，请小伙伴们移驾官网说明页面吧。

> http://xdebug.org/docs/develop



### 启用 `xDebug` 的分步调试 - `Step Debugging`

啥叫分步调试呢？

其实只要调试过程序代码的小伙伴肯定会理解，实质上是指一行一行、一段一段地执行代码，而不是一下子全部执行代码的方式。

这样做有利于我们快速有效地定位代码问题。

通常很多开发环境或编辑器都有这个逐步执行调试代码的功能，但是当我们调试 `PHP` 代码时你就会发现，我去，这玩意好像只能一开始就跑到底啊！

原因是由于 `PHP` 程序通常是使用浏览器等客户端执行的，而服务端又没有调试中断机制。



一般程序如果不复杂，那么我们在代码中插入 `echo` 或 `var_dump()` 来凑合调试，这倒也没啥。

不过一旦代码复杂起来，并且如果是团队工作，那么这么玩肯定是死路一条，不累死也是被玩死！

真的没有办法了吗？

有！



这就要用到 `xDebug` 的分步调试功能，它主要是利用 `DBGp` 协议。

有了这个好东东，几乎所有的 `PHP` `IDE` 以及很多文本编辑器都能玩断点调试了，惊不惊喜？

至于这个什么 `DBGp` 协议是啥，说实话，我还没来得及研究，有兴趣大家可以到官网学习。

我们现在只要先学会应用即可，下面开始！



以 `VSCode/VSCodium` 为例：

首先我们修改一下 `php.ini` 中的 `[xDebug]` 区域的参数设定。

```
; 调试模式
xdebug.mode = debug

; 在PHP请求开始时激活调试功能
xdebug.start_with_request = yes

; 调试客户端的端口
xdebug.client_port = 9003

; 调试客户端的IP
xdebug.client_host= 127.0.0.1

; 连接VSCODE调试客户端
xdebug.idekey=VSCODE
```



打开 `VSCodium` ，点击左侧的 `扩展` ，在搜索栏内输入 `xdebug` ，查找到 `PHP Debug` 并安装。

图24



然后编辑 `launch.json` 启动文件。

点击 `VSCodium` 左侧的 `运行和调试` ，然后再点击 `打开文件夹` 。

此处需要注意的是，我们必须先要打开某个文件或某个文件夹（项目）中的文件，在文件编辑状态下才能开启并修改启动文件 `launch.json` 。

图25



比如我们随便打开一个 `.php` 文件，这时我们再点击左侧的 `运行和调试` ，就可以看到可以点击 `创建 launch.json 文件` 了。

图26



点击 `创建 launch.json 文件` ，然后在下拉列表中选择 `PHP` 。

我们用的是 `xDebug` ，调试的是 `PHP` 程序，因此选择 `launch.json` 创建类型选择 `PHP` 。

图27



这个 `launch.json` 文件实际位于你打开项目中名为 `.vscode` 的隐藏文件夹内，直接编辑它也是可以的。

图28



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

图29



如何使用呢，也就是如何触发断点调试机制呢？

设定代码调试的断点，用鼠标点击来标记，也可以按下 `F9` 来设置。

图30



打开浏览器，访问正在编辑调试代码的文件。

此时程序就会自动运行直至跑到断点处停下来，并且显示为一个箭头。

图31



接下来应该就懂了吧，结合输出效果，一边按下 `F11` 等单步调试按钮，一边调试代码查找问题。

图32



浏览器访问 `PHP` 代码程序调试已经OK，那终端命令行模式下呢？

其实很简单，配置和前面差不多，只是在 `CLI` 的 `php.ini` 中编辑而已。



关于分步调试还有很多参数，更多具体说明请大家参考官网吧。

> http://xdebug.org/docs/step_debug





教程小结

关于利用 `xDebug` 来实现远程服务端代码的调试功能，因为内容比较多，还是请小伙伴们先参考官方或网上的其他教程。

如果有时间我会另外给大家介绍的，本教程旨在带大家先入个门，把基础的东西熟悉了，之后再复杂一点的东西就问题不大了。

即使如今 `PHP` 框架大行其道、非常流行，对于我们快速调试程序、高效定位 `BUG` 已经有了质的飞跃。

但是要想深入学习，或是编写更加复杂一些的程序代码，那么这种局部调试的技术还不算过时，仍然是有用武之地的。

因此，就算我们学得不那么深，多掌握一些调试技术也可以技多不压身，总归有好处没坏处吧！

好了，我本人也只是众多初学者中的一个，写完本文的同时也希望与各位小伙伴们一起再学习、再进步。

敬请期待下一节教程，谢谢！



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc





 







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