minio

副标题：

英文：

关键字：





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



然而登录账户直接使用系统本身的肯定是不行的啦，那我们就单独给它添加一个吧。

点击 `添加/编辑(E)` 。

图c05



再点击 `添加(A)` 。

图c06



把我们私有云的 `Access-key` 和 `Secret-key` 都给它填上。

图c07



现在OK了，继续下一步。

图c08



选择逻辑存储单元，也就是选哪个桶 `Bucket` 。

图c09



并发操作数，默认是 `2` ，也就是两个并发，视你的存储性能而定，一般来说肯定是并发越多越好，但太多了容易挂机。

图c10



一切就绪，确认没毛病，点击 `完成` 。

图c11



`BE` 此时会提示需要重启服务，老实照做，否则存储会以脱机形式存在而无法使用。

图c12



一旦我们添加的云存储处于联机状态，那么我们就可以拿它做备份测试了。

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

