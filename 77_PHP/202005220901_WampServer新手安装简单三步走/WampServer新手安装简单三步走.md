WampServer新手安装简单三步走

副标题：小白也能成为时间管理大师~



WampServer作为一款在Windows下编写调试PHP代码的神器之一，一度受到新手小白们的热捧。

无奈对于新手小白们来说，其安装略显复杂，易于爆出的各类问题层出不穷、令人生畏。

瞧瞧这简介：

> WampServer是一款由法国人开发的Apache Web服务器、PHP解释器以及MySQL数据库的整合软件包。
>
> 免去了开发人员将时间花费在繁琐的配置环境过程，从而腾出更多精力去做开发。



孙悟空初见定海神针，一眼瞧上了，说道“再短细些更妙！”，金箍棒也就成了称手的兵器。

咱们的愿望也挺简单啊，就是想让WampServer的安装再简单些就好了。

愿望能实现吗？

好了，少说话多做事，咱们这次就来好好整理精练一下WampServer的安装过程。

还是经典的三步走，思路清晰明了，以飨各位新手小白。



> 操作系统：
>
> Windows 10 x64
>
> 准备作料：
>
> check_vcredist.exe    # 检查VC++包是否正确安装的宝物
>
> all_vc_redist_x86_x64.zip    # WampServer需要的所有VC++安装包（官网的不全）
>
> wampserver3.2.0_x64.exe    # WampServer本尊，版本3.2.0
>
> wampserver3_x86_x64_update3.2.2.exe    # WampServer升级包，版本3.2.2
>
> wamp3_x86_x64_language.exe    # 多国语言包，英文障碍者的福音



**以上文件可以到 [WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files) 下载。**

`all_vc_redist_x86_x64.zip` 官网的可能不全，

请到 [这里](https://o8.cn/YWjUEE) 下载，密码：62v9，

解压密码是本站网址（www.sysadm.cc）。

> 扩展阅读：[WampServer官方下载去哪儿了？](https://www.sysadm.cc/index.php/xitongyunwei/692-wampserver)





#### Round 1 - WampServer安装的前提条件，安装VC++包

执行 `check_vcredist.exe` 文件，直接点击 `check` 进行检查。

图1



有很多没有安装好，找到 `all_vc_redist_x86_x64.zip` 解压后分别执行安装。

**注意：如果安装64位的WampServer，那么32位VC++包也是要安装的哦！**

图2



安装好了没？

好，我们再执行一次 `check_vcredist.exe` 检查看看。

出现以下提示说明你安装成功啦，否则还是要找到相应的包包来安装。

图3



说实话，官网不仅查找安装包麻烦而且下载还慢，而且还不完整，缺这个包那个包，这就是WampServer被很多人诟病的原因之一吧。

不过不用担心哦，我这已经打包好了所需的安装包，一次搞定，想要节省时间就速速下载吧。

链接：[https://o8.cn/YWjUEE](https://o8.cn/YWjUEE) ，密码：62v9

解压密码是本站网址（www.sysadm.cc）



#### Round 2  - 安装WampServer本体

执行安装程序 `wampserver3.2.0_x64.exe` 开始安装，选择默认安装路径即可。

点击下一步来到 `选择组件` 画面，选择你喜欢的组件。

比如：`PHP7.2` 或 `MySQL5.7` 。

需要注意的是：

> WampServer默认安装的数据库是MariaDB。
>
> PHP7.2可能官方到2020年12月就不维护了，建议使用PHP7.3以上。
>
> MariaDB和MySQL使用上可能会存在冲突，你喜欢哪个，最好二选一。

图4



选择好喜欢的组件后继续下一步。

提示是否更换WampServer使用的浏览器，点击 `否` 。

图5



提示是否更换WampServer使用的文本编辑器，还是点击 `否` 。

图6



OK，最后安装完成，easy不？

图7



#### Round 3 - 安装升级包和语言包

实际上前面两步走，WampServer基本上已经可以使用了。

不过咱有点强迫症不是，完美追求最新版本。

好，直接执行文件 `wampserver3_x86_x64_update3.2.2.exe` 来升级。

出现 `选择菜单颜色` ，默认直接下一步。

图8



升级安装很简单吧，需要说明的是，这个升级包只针对WampServer程序本身更新，并不会影响组件（如PHP或MySQL等）的版本更新。



接下来是安装语言包，这是个可选项，但对英文小白来讲可是福音啊！

双击执行 `wamp3_x86_x64_language.exe` ，点几下就完事儿了，完全没花样。

安装完成后，通过右击任务栏中的WampServer图标，找到 `language` ，选择 `Chinese` ，过一会程序重启后界面就会变成中文啦。

图9





#### Final - 最后的测试

现在我们已经拥有了最新版本（3.2.2）的WampServer，并且它还是中文界面的，有没有点小激动呢？

好，让我们来验证WampServer是否已经正常工作。

打开你喜欢的浏览器，在地址栏中输入 `http://localhost` ，来个回车。

嗯，出现如下画面，那么恭喜你哈，WampServer已经开始为你工作了！

图10





怎么样？三步走大法好用不？

如上几个步骤即可完成WampServer的安装，省时省力，让你也能迅速成为时间管理大师哦！

如果在安装过程中，或者在使用过程中有什么疑问，欢迎您留言讨论！



>  扩展阅读：
>
> [1. WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files)
>
> [2. WampServer官方下载去哪儿了？](https://www.sysadm.cc/index.php/xitongyunwei/692-wampserver)
>
> [3. 用HTTPS更高大上，让WampServer开启SSL](https://www.sysadm.cc/index.php/webxuexi/729-https-wampserver-ssl)



> WeChat: @网管小贾
>
> Blog: @www.sysadm.cc

