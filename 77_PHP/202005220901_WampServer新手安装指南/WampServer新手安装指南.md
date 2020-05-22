WampServer新手安装指南

副标题：欢迎入坑~



> WampServer是一款由法国人开发的Apache Web服务器、PHP解释器以及MySQL数据库的整合软件包。
>
> 免去了开发人员将时间花费在繁琐的配置环境过程，从而腾出更多精力去做开发。



WampServer作为一款在Windows下编写调试PHP代码的神器，一度受到新手小白们的热捧。

无奈对于新手小白们来说，其安装略显复杂，出现各种各样的问题后想重装又往往令人生畏。

不要怕！（怕也没用~）

我们这次就整理精练一下WampServer的安装过程，以飨新手。



> 环境：
>
> Windows 10
>
> 准备作料：
>
> check_vcredist.exe    # 检查VC++包是否正确安装
>
> all_vc_redist_x86_x64.zip    # WampServer需要的所有VC++安装包
>
> wampserver3.2.0_x64.exe    # WampServer本尊，版本3.2.0
>
> wampserver3_x86_x64_update3.2.2.exe    # WampServer升级包，版本3.2.2
>
> wamp3_x86_x64_language.exe    # 各国语言包，英文障碍者的福音



**以上文件可以到 [WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files) 下载。**

另请参考前文：[WampServer官方下载去哪儿了？](https://www.sysadm.cc/index.php/xitongyunwei/692-wampserver)



Round 1 - WampServer安装的前提条件，VC++包先要安装好

执行 `check_vcredist.exe` 文件，直接点击 `check` 进行检查。

图1



有很多没有安装好，找到 `all_vc_redist_x86_x64.zip` 解压后分别执行安装。

**注意：如果安装64位的WampServer，那么32位VC++包也是要安装的。**

图2



安装好了没？

好，我们再执行一次 `check_vcredist.exe` 检查看看。

出现以下提示说明你安装成功啦，否则还是要找到相应的包包来安装。

说实话，官网不仅查找安装包麻烦而且下载还慢，这就是WampServer被很多人诟病的原因之一。

不过不用担心哦，我这已经打包好了所需的安装包，一次搞定，想要节省时间就速速下载吧。

链接：

图3



