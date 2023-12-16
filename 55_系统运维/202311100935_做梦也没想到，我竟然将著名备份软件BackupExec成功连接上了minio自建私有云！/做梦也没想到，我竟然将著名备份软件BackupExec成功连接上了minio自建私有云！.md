做梦也没想到，我竟然将著名备份软件BackupExec成功连接上了minio自建私有云！

副标题：做梦也没想到，我竟然将著名备份软件BackupExec成功连接上了minio自建私有云！

英文：i-never-dreamed-that-i-could-successfully-connect-the-famous-backup-software-backupexec-to-s3-compatible-object-store-named-minio-private-cloud

关键字：s3,s4,私有云,云,cloud,backupexec,be,backup,object store,对象存储,minio,instance



我必须夸赞一句，我们老板是少有的重视信息化建设的，可以算是这方面的专业人士。

特别是成本这块，抓得特严，能节省则节省，交换机能用5个口的，绝不用6个口的。

这天他又来视察我们的工作了，还特别提出了一些要求，比如远程备份。



好不容易熬到了周五，结果整这么一出，看样子周末又没得休息了。

虽然大家伙都已经习惯了，可新来的小钱却不服不愤挺有个性，我们都劝他既来之则安之。

结果不劝还好，一劝他还横眉立目扬言要找老板评理，大不了不干了。

啧啧啧……看来传言不假，如今的职场确实是要00后来整顿。

好了，好了，别扯这没用的了，还是好好考虑考虑老板留的作业吧！

到底如何实现远程备份？

对了，还有几个附加条件，不用共享，不用磁带，就用云存储，老板果然是专业滴！



我们现在使用的是备份软件 `Backup Exec` （以下简称 `BE` ），一款非常常见的备份软件，记得里边的确是有云存储这么一个备份目标来着。

我找了个备份服务器，看了一下 `BE` 中添加云存储的配置设定，发现只有 `Alibaba` 、 `Amazon` 以及 `Google` 之类的云存储商提供的选项。

图01



难道我应该向老板申请买一个？

瞬间老板那满脸的褶子的形象浮现在我眼前，算了，给他老人家添麻烦我是真有点于心不忍。

可没有云存储，你让我怎么办呢？

巧妇难为无米之炊，这可真是急刹我也！

我在机房转了八圈半，愣是没点头绪，还好新来的小钱提醒了我：“哥，我刚来的时候咱不是做了个 `MinIO` 的测试机嘛！”



对啊！一个星期前我用 `MinIO` 做了个测试系统，完全可以先拿这个来用嘛，它也是对象存储服务啊！

我拍了拍小钱的肩膀，感谢这位小伙子的及时提醒，接下来开始动手干活吧！



手头测试用的 `MinIO` ，可以提供对象存储服务，当远程存储用自然没问题，可问题是 `BE` 怎么连接 `MinIO` 呢？

就如前面提到的，`BE` 默认仅能连接 `Alibaba` 、 `Amazon` 以及 `Google` 这几个厂商的存储对象，我们自己做的存储实例不在列表里没得选啊，这是个大问题！

得，找找官方文档吧。

别说，还真找着了，按照官方文档指示，可以通过 `BE` 自带的控制台命令行 `BEMCLI` 来创建私有云。

图b03



这个 `BEMCLI` 在哪儿呢？

其实它就在 `BE` 程序的安装路径中，在以下路径中就找到 `BE` 的这个命令行程序，名称 `CLILauncher.exe` 。

```
C:\Program Files\Veritas\Backup Exec\CLILauncher.exe
```

图a01



来吧，双击它，出现一个新的命令行窗口，有点像 `cmd` ，也有点像 `PowerShell` 。

图a02



尝试按照官方文档操作，怎么老是失败呢？

图b01



估摸着可能是参数设定有误，输入以下帮助命令具体查看一下如何添加私有云实例。

```
BEMCLI> get-help New-BECloundInstance -detailed
```

图a03



参数一大堆，耐着性子看了一会儿，其实只要看看例子就行。

```
-------------------------- EXAMPLE 1 --------------------------
C:\PS> New-BECloudInstance -Name "CloudInstance0001" -Provider "cloudian" -ServiceHost "s3.cloudian.com" -SslMode "Disabled" -HttpPort 80 -HttpsPort 443

-------------------------- EXAMPLE 2 --------------------------
C:\PS> New-BECloudInstance -Name "CloudInstance0002" -Provider "cloudian" -ServiceHost "s3.cloudian1.com" -SslMode
"AuthenticationOnly" -UrlStyle "Path"
```

图a04



总结起来就这么几样。

* `-Name "CloudInstance0001"` ：云存储实例名称
* `-Provider "cloudian"` ：云存储提供商
* `-ServiceHost "s3.cloudian.com"` ：服务器访问地址
* `-SslMode "Disabled"` （`"AuthenticationOnly"` 、 `"Full"`） ：加密模式
* `-HttpPort 80` 和 `-HttpsPort 443` ：`HTTP/HTTPS` 端口
* `-UrlStyle "Path"` ：`URL` 样式



依葫芦画瓢往上套呗，嘿，搞定了！

图b02



添加我们自定义的云存储实例成功了，那接下来怎么玩呢？

接下来我们就应该到 `BE` 里添加刚才新建的云存储实例了。



打开配置存储向导，选择云存储。

图c01



给云存储起个响亮的名字，以后你还是要经常来看它的。

图c02



选择 `S3` ，我们的 `MinIO` 是兼容 `S3` 的嘛！

图c03



注意啦，在这一步中，云存储的连接信息选项中，我们可以看到这里已经有了前面添加过的自定义私有云实例。

图c04



选择我们自定义的私有云实例，接下来需要指定访问它的账号密码，没有账号密码是没办法访问的。

然而当前默认保存在 `BE` 中的登录账户（像 `Administrator` 之类）肯定是不合适的啦，那我们就单独给它添加一下吧。

在当前界面中点击 `添加/编辑(E)` 按钮。

图c05



再点击 `添加(A)` 按钮，给我们的私有云指定登录账号和密码。

图c06



把我们私有云的 `Access-key` 和 `Secret-key` 都给它填上，像这个样子。

图c07



现在OK了，点击确定继续。

图c08



准备好了哈，点击下一步。

如果无法访问，出现如下错误代码，那么说明云存储的加密连接失败了。

注意，注意，注意，是加密连接失败，重点是加密！

```
BEMSDK Failure Code: E0009B3F
```

图c081



找来解决方法。

> https://www.veritas.com/support/en_US/article.100034293

图c082



怎么就加密连接失败了呢？

其实说白了就是访问私有云时证书没给准备好，光有账号密码人家也不让用，所以连接自然就失败了。

行，那具体怎么解决呢？

好办，简单地说，就是将 `MinIO` 服务端生成的 `pubic.crt` 证书中的内容复制到如下文件中即可。

```
C:\Program Files\Veritas\Backup Exec\cacert.pem
```

> Use the following instructions to add a missing or replace an expired certificate issued by the cloud provider, or Certificate Authority (CA) to the cacert.pem file at BE Install Path.
>
> ** NOTE ** An upgrade of the Backup Exec will revert any changes made to the cacert.pem file. The steps will need to be done again when BE is upgraded or updated. 
>
> **1)** Confirm that the self-signed or public CA certificate is in Base64 PEM (Privacy Enhanced Mode) format.
>
> **2)** Edit cacert.pem from BE Install Path on BE server : 
>
> **3)** Append the self-signed or public CA certificate to the beginning or at the bottom of cacert.pem, and save the file. 



这个 `cacert.pem` ，你看它的名字，就知道是专门用来保存对象目标的证书信息的。

`MinIO` 生成存储时肯定会有证书信息的，直接把证书文本内容粘贴到 `cacert.pem` 中，`BE` 连接时就能识别存储了。

图d01

图d02



好了，账号密码没问题，证书也没问题，那么应该就可以成功连接了。

接着选择逻辑存储单元，也就是选哪个桶 `Bucket` ，这个 `Bucket` 是对象存储中的概念了，简单地可以理解为存储文件夹。

图c09



并发操作数，默认是 `2` ，也就是两个并发，视你的存储性能而定，一般来说肯定是并发越多越好，但太多了可能容易挂机。

图c10



一切就绪，确认没啥毛病，点击 `完成` 。

图c11



`BE` 此时会提示需要重启服务，老实照做，否则存储会以脱机形式存在而无法使用。

图c12



一旦添加的云存储处于联机状态，那么我们就可以拿它做备份测试了。

创建备份作业我就不演示了，我们直接看一下云存储实例 `MinIO` 那边是否有备份文件生成。

果然，备份文件有了（不好意思，截图用的是 `Bucket01` ）。

图c13



至此，测试成功，大功造成！

再送小伙伴们几个小技巧吧。

一旦成功添加了自定义云存储，如果我们想要修改它的参数，这可咋整呢？

用 `Set-BECloudInstance` 这个命令。



比如，在 `BE` 端修改主机名称。

```
Get-BECloudInstance "CloudInstance0001" | Set-BECloudInstance -ServiceHost "MinioServer"
```



又比如，在 `BE` 端修改加密模式。

```
Get-BECloudInstance "CloudInstance0001" | Set-BECloudInstance -SslMode "Full"
```



后来加班还没到12点，又研究了一下，发现 `BE` 新版和旧版还有点不一样。

新版 `BE` （`22.X` 版本）在添加私有云向导中追加了图形工具向导，方便用户以 `GUI` 的方式添加私有云实例。

`21.X` 及以下版本是没有这一项的，只能用手打命令来实现。

图e01



实际上这个 `Generic S3 Configurator` 工具就是前面介绍的命令行的 `GUI` 模式。

用户只要点点选选就能实现输入命令行同样的功能效果。

比如，输入私有云名称、服务器地址、加密模式、云提供商以及访问端口，最后点击 `Execute Command` 执行按钮即可。

图e02



随后程序会自动生成命令行并执行。

图e03



一旦连接成功，我们可以看到在黑色区域里输出结果，以便判断操作是否正确。

图e04



同样这个 `Generic S3 Configurator` 工具不单可以添加，还可以删除。

图e05



然后再接着设定连接生成的云存储实例就显得很方便了。

图e06



做到这儿，我们都松了一口气，只希望接下来周末能有时间休息一下。

没想到老板居然不辞辛劳，大晚上还视频连线询问我们的工作进展情况。

我们如实汇报，老板非常满意。

但当提到需要购买云存储时，老板就强调成本是企业的生命，说我们不尊重生命，要求我们想尽一切办法尊重生命。

当场，小钱站了出来，把心里想说的连同之前的抱怨一股脑儿都倒了出来。

这位小钱同学说得是义愤填膺、慷慨激昂，我们连拽胳膊带捂嘴是拦都拦不住啊！

不用猜，结果可想而知，老板哪受得了这个，面子上挂不住了，一下被激怒了。

急得在场的几位直吐舌头，一边跺脚一边说，完了完了……



最后我也不知道老板是什么时候挂断的连线，反正整个人都晕晕惚惚的。

已经很晚了，几个同事都先回家了。

我和小钱分手时，我还一个劲儿地安慰他，让他不要有心理负担，准备等上班了再帮他说说情。

小钱冲我一笑：“哥，你甭管，我没事儿！我就看不惯我爸那盛气凌人的样儿，不过我保证下回不这样了！我也看得出你们都挺照顾我的，也不想给你们添麻烦……”

我先是一愣，后来急忙说道：“哦哦……这就对了嘛！来来来，我送你，我送你！顺路，顺路……”



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc