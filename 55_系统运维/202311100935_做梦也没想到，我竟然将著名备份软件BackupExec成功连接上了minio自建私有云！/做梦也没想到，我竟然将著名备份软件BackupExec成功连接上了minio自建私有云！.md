做梦也没想到，我竟然将著名备份软件BackupExec成功连接上了minio自建私有云！

副标题：做梦也没想到，我竟然将著名备份软件BackupExec成功连接上了minio自建私有云！

英文：i-never-dreamed-that-i-could-successfully-connect-the-famous-backup-software-backupexec-to-s3-compatible-object-store-named-minio-private-cloud

关键字：s3,s4,私有云,云,cloud,backupexec,be,backup,object store,对象存储



算命摊

神秘小屋

秘密通道

支付小费，询问问题的解决方案。



小区大门口新开了一间面馆，听人说刚开张，价格实惠、味道不错，光顾的客人不少。

礼拜天我起了个大早，不为别的，就为第一时间去体验一下。



我推开店门，迈步进去，眼前窗明几亮，装修一新。

店员异常热情，男女和声一齐招呼道：“欢迎您来！”

好，好，我挺直了腰杆，心情不错。

一位年轻店员示意我点餐，我抓了抓口袋，又看了看两位数字的微信，腰部略微放松，点了一份最能体现我优秀节俭品质的超级实惠面。

吃面的人太多，店员怕我耳背，好心大声提醒我：“先生，本店可以无限续面，不够可以再加哦！”



我在众人的瞩目下，迅速找了个僻静的座位坐下。

趁着等面的功夫我只好东瞅瞅西望望，打发时间。

这时我瞧见坐在不远处有一哥们似乎不同寻常。

这哥们看上去约莫四十多岁，有点地方支援中央，蒜头鼻子方开口，戴副高度的近视眼镜，仔细一瞧满脸的骚疙瘩，甭挺多难看。

奇怪的是，此人行色匆匆，没嘬几口面就接了个电话。

没一会儿便抓起桌上的皮包夹在咯吱窝下，起身离开座位。

这人边走边讲着电话，从我身边经过，想是有什么急事。



等面来了，我刚想开吃，忽然发现地上掉了张红纸条。

我一脚踩住纸条，看了看前后左右，没人注意。

我放下筷子，若无其事地将那纸条捡了起来。

偷偷展开这么一看，我就是一愣。

上写：凭此条免费酬宾，价值999元，先到先得，仅此一次，机不可失，有效期某年某月某日……

啧啧，这印刷质量也太糙了点，哦，下面还有一行小字，是一处地址。



嗯？这怎么个意思？

难不成是刚才那哥们不小心落下的？

刚才也没人从我边上过啊？

这纸条上边写的是真的假的？

接下来的十多分钟我就完全处在胡思乱想之中，最后面是吃完了，结果愣是忘了什么味儿，吃了个寂寞！

后来我心想，这背不住是哪个超市商家为答谢客户，整的优惠券之类的呗。

可又仔细想想，不对啊，这地址明明写的就是我这小区，难道小区里有超市？



我坐那又等了一会儿，不见那哥们回来，心想算了，我还是回家吧。

付了面钱，我径直往家走，却不经意路过纸条地址上写的那个单元。

中国有句老话，叫做“来都来了”！

得，进去看看，不会还有人在居民楼里开超市吧！



登上楼梯，来到门口，我上下打量，也没看出来这家的大门和别家有啥两样。

我试着敲了敲门，半天门才打开，从门缝里边探出一个头来。

“你找谁？”

“哦……这个……”我急忙举起那张纸条。

那人





老板要求做远程备份。

到底怎么做呢？



我看了一下 `Backup Exec` （以下简称 `BE` ）中添加云存储的配置设定，发现只有 `Alibaba` 、 `Amazon` 以及 `Google` 之类的云存储。

难道我应该向老板申请买一个？

老板上了年纪，望着他满脸的褶子，打扰他我有点于心不忍。

可没有云存储，你让我怎么办呢？

这可真是急刹我也！

算了，到外面溜达一圈，放松一下再想想折！



公司后院环境不错，要不上那儿转转吧！

溜达了好半天，我寻思着时间不短，得赶紧回去，生怕老板看见了又要关照我了。

想到这儿我加快脚步，想着从墙角边的草地抄近路回去。

哪知道绕着绕着，发现布满爬山虎的墙边居然有一扇破旧不堪的木板门。

也不知道我当时是咋想的，停下脚步就去推这扇门。

结果“吱呀”一声，门竟然开了，里面露出了一条只有一人宽的过道……



昏暗的过道不知通往何处，一阵香风扑面，顿时勾起了我的好奇心。

这里边有什么呢？

晚点回去老板应该不知道，进去看看！

我不顾光线昏暗，深一脚浅一脚迷迷糊糊地走了进去。

大概走了二三十米远吧，我就摸着好像又是一扇门。

只不过这是一扇防盗门，门把手反着光，上面并没有灰尘，似乎经常有人出入这里。

我正犹豫这门突然





手头上有测试用的 `minio` ，可以提供对象存储服务。

问题是 `Backup Exec` （以下简称 `BE` ）怎么连接 `minio` ？





按照官方文档指示，可以通过 `BE` 自带的控制台创建私有云。

图b03





在以下路径中找到 `BE` 的命令行程序。

```
C:\Program Files\Veritas\Backup Exec\CLILauncher.exe
```

图a01



出现一个新的命令行窗口，有点像 `cmd` ，也有点像 `PowerShell` 。

图a02



按照官方文档操作总是失败。

图b01



输入以下命令查看如何添加私有云。

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

* `-Name "CloudInstance0001"`
* `-Provider "cloudian"`
* `-ServiceHost "s3.cloudian.com"`
* `-SslMode "Disabled"` （`"AuthenticationOnly"` 、 `"Full"`）
* `-HttpPort 80` 和 `-HttpsPort 443`
* `-UrlStyle "Path"`



图b02





接下来添加我们的云存储。

打开配置存储向导，选择云存储。

图c01



给云存储起个响亮的名字，以后你还是要经常来看它的。

图c02



选择 `S3` ，我们的 `MinIO` 是兼容 `S3` 的嘛！

图c03



云存储的连接信息中，我们可以看到前面已经有了添加过的自定义私有云。

图c04



选择我们自定义的私有云，接下来需要指定访问它的账号密码。

然而所用的登录账户直接使用系统原有的（像 `Administrator` 之类）肯定是不合适的啦，那我们就单独给它添加一下吧。

在当前界面中点击 `添加/编辑(E)` 按钮。

图c05



再点击 `添加(A)` 按钮，给我们的私有云指定登录账号和密码。

图c06



把我们私有云的 `Access-key` 和 `Secret-key` 都给它填上，像这样。

图c07



现在OK了，点击确定继续。

图c08



准备好了哈，点击下一步。

如果无法访问，出现如下错误代码，那么说明加密连接失败了。

```
BEMSDK Failure Code: E0009B3F
```

图c081



找来解决方法。

> https://www.veritas.com/support/en_US/article.100034293

图c082



怎么回事呢？

其实说白了就是访问私有云时证书没给准备好，人家不让用，所以连接自然就失败了。

具体怎么解决呢？

好办，简单地说，就是将 `MinIO` 服务端生成的 `pubic.crt` 证书中的内容复制到如下文件中。

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

图d01

图d02





好了，账号密码没问题，证书也没问题，那么应该就可以成功连接了。

接着选择逻辑存储单元，也就是选哪个桶 `Bucket` 。

图c09



并发操作数，默认是 `2` ，也就是两个并发，视你的存储性能而定，一般来说肯定是并发越多越好，但太多了可能容易挂机。

图c10



一切就绪，确认没毛病，点击 `完成` 。

图c11



`BE` 此时会提示需要重启服务，老实照做，否则存储会以脱机形式存在而无法使用。

图c12



一旦添加的云存储处于联机状态，那么我们就可以拿它做备份测试了。

创建备份作业我就不演示了，我们直接看一下云存储那边是否有备份文件生成。

果然，备份文件有了（不好意思，截图用的是 `Bucket01` ）。

图c13



至此，大功造成！





送两个技巧：



在 `BE` 端修改主机名称：

```
Get-BECloudInstance "CloudInstance0001" | Set-BECloudInstance -ServiceHost "MinioServer"
```





在 `BE` 端修改加密模式：

```
Get-BECloudInstance "CloudInstance0001" | Set-BECloudInstance -SslMode "Full"
```





新版 `BE` （`22.X` 版本）在添加私有云向导中追加了工具向导，方便用户以 `GUI` 的方式添加私有云。

图e01



实际上这个 `Generic S3 Configurator` 工具就是前面介绍的命令行的 `GUI` 模式。

用户只要点点选选就能实现输入命令行同样的功能效果。

比如，输入私有云名称、服务器地址、加密模式、云提供商以及访问端口，最后点击 `Execute Command` 执行按钮即可。

图e02



随后程序会自动生成命令行并执行。

图e03



一旦连接成功，我们可以看到输出结果，以便判断操作是否正确。

图e04



同样这个 `Generic S3 Configurator` 工具不单可以添加，还可以删除。

图e05



然后再接着设定连接生成的云存储实例就显得很方便了。

图e06



