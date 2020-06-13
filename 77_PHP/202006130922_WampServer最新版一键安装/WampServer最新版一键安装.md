WampServer最新版一键安装

副标题：人人争当时间管理大师~



标题够老套吧，可是时间是最宝贵的，这点毋庸置疑！

只要想想人家罗大师是怎么荣获时间管理大师美誉的，我们就很容易知道时间宝贵，应该用到该用的地方。

罗大师曾说过，他如果骗人他就是小猪！

我坚定地选择了相信他，那些不必大费周章的地方务必要开源节流，力争做到用时最小化。



话说回到 `WampServer` ，它是很多人使用过或正在使用的工具程序，这些使用人群中包括了大批的新手小白，其中当然也包括我。

按照以前给小伙伴们分享过的几篇文章，步骤虽经整理简化，但对新手来说仍然较为繁琐。

> [WampServer新手安装简单三步走](https://www.sysadm.cc/index.php/webxuexi/731-wampserver-install)
>
> [WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files)



依葫芦画瓢一步一步也是能安装 `WampServer` ，可正是由于小白出身，很容易在此等事情上折腾而浪费了时间。

老话有云，浪费时间就是浪费生命。

好吧，为了自己和他人的生命，我辈当身先士卒自愿站出来，不惜牺牲个人生命（时间），发奋整理出一套**一键安装 `WampServer`** 的方法。



一键安装 `WampServer` 程序包内含官网最新版本，仅提供64位，组件版本如下：

> Wampserver 3.2.x 64 bit x64 - Apache 2.4.41 - PHP 5.6.40/7.3.12/7.4.0 - MariaDB 10.4.10|10.3.20
>
> Wampserver update 3.2.2 
>
> Wampserver language



功能很简单，实现原理就是使用批处理程序自动化安装。

不过有些注意事项需要说明一下：

1. 如果你已经安装了 `WampServer` ，那么请提前做好数据备份（比如www目录或MySQL数据等）。
2. 开始安装前请确认已经退出 `WampServer` 程序。
3. 本程序仅自动安装默认组件，可重复安装，多次运行。
4. 本程序只作为测试使用，一切使用后果由使用者承担，与作者无关。



嘿嘿，给你下载链接吧！

为了照顾不同情况的小伙伴，有两种下载方法供你选择。



##### 1、直接下载完整一键安装包

这个省事儿，就是慢，你懂的~

百度网盘链接：https://pan.baidu.com/s/1kr2RuOyXtlJ_mswct1PMAA

提取码：s22f    解压密码：www.sysadm.cc



##### 2、只下载脚本文件，其他安装包需手动收集

如果你嫌百度网盘下载太慢，也可以直接下载批处理脚本文件。

不过，需要你手动将那些安装包放到脚本文件所在的同一目录中。

以下安装包可以到这里下载，都是官方安装包 ➡ [WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files)

```
所需安装包文件列表：
 check_vcredist.exe
 vcredist_2008_sp1_atl_x64.exe
 vcredist_2008_sp1_atl_x86.exe
 vcredist_2008_sp1_mfc_x64.exe
 vcredist_2008_sp1_mfc_x86.exe
 vcredist_2008_sp1_x64.exe
 vcredist_2008_sp1_x86.exe
 vcredist_2010_sp1_x64.exe
 vcredist_2010_sp1_x86.exe
 vcredist_2012_upd4_x64.exe
 vcredist_2012_upd4_x86.exe
 vcredist_2013_upd5_x64.exe
 vcredist_2013_upd5_x86.exe
 vcredist_2019_VC16_14.26.28720.x64.exe
 vcredist_2019_VC16_14.26.28720.x86.exe
 wamp3_x86_x64_language.exe
 wampserver3.2.0_x64.exe
 wampserver3_x86_x64_update3.2.2.exe
```



脚本文件下载链接：https://o8.cn/3vUmtX

密码：o396    解压密码：www.sysadm.cc



好了，不用再苦逼地点击安装了，一键搞定解放你的双手！

有木有一种突如其来的幸福扑面而来的感觉？

如果你觉得好用，记得关注我的微信公众号，同时帮忙转发分享哦！

举手之劳，万分感谢哈（抱拳拱手）！



> WeChat @网管小贾
>
> Blog @www.sysadm.cc

