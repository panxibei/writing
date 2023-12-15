minio

副标题：

英文：

关键字：



算命摊

神秘小屋

秘密通道

支付小费，询问问题的解决方案。







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



