如何用 UrBackup 备份 MySQL

副标题：官网说明太简单，我来踩踩坑~



移动互联网如此发达的今天，伴随其一起成长起来的 `MySQL` 可以说是众多重要元老之一了。

`MySQL` 是最流行的关系型数据库，很显然它的备份非常重要，备份方式也是五花八门、不尽相同。

而 `UrBackup` 作为开源免费的备份解决方案，也同样提供对 `MySQL` 备份的支持。

那么今天我们就来看看，这哥俩能不能互相配合默契、一块有效工作。



我们假定服务端已经安装好了，如果你还没有服务端，可以参考前文，最简单地使用 Windows 来做。

> 《如何用 UrBackup 备份 SQL Server》
>
> https://www.sysadm.cc/index.php/xitongyunwei/800-how-to-backup-sql-server-with-urbackup



MySQL客户端测试运行环境

> 操作系统：Oracle Linux 7.9
>
> 数据库：Percona MySQL 5.7





#### 准备好 `MySQL` 数据库

安装 `MySQL` ，我这里用的是 `Percona MySQL 5.7` 作例子，具体安装过程就不赘述了。

反正假定你已经安装好 `MySQL` ，注意哦不是 `MariaDB` ，当然其实都是一样的，只是接下来的测试中脚本内容会不一样。

好了，新建一个数据库，对其增删好用于测试备份恢复情况。

```mysql
CREATE DATABASE `www.sysadm.cc`
```

图1





#### 准备 `UrBackup` 备份系统

在 `Linux` 下安装 `UrBackup`，按照官网说明直接使用一行命令。

注意：可能会提示找不到 `wget` 命令，用 `yum install wget` 安装它即可。

官网链接：https://www.urbackup.org

```shell
TF=$(mktemp) && wget "https://hndl.urbackup.org/Client/2.4.11/UrBackup%20Client%20Linux%202.4.11.sh" -O $TF && sudo sh $TF; rm -f $TF
```

按 `Y` 继续安装......

下载过程可能会花些时间，别着急，可以先关注一下@网管小贾，后面可能会用到哦。

图2



选择快照，备份的一种机制。

图3



我们在这里选择 `4) Use no snapshot` ，也就是不用快照功能。

因为快照功能会先在本地磁盘上生成快照文件，然后再执行和传输备份，所以它要占用很大的磁盘空间。

当然还有其他一些问题，主要是我也是小白一个，对这个不是太懂，以后有机会再研究研究，这次测试就暂且略过吧。

OK！`UrBackup` 也很顺利地安装完成了！

图4



同一网段下，服务端很快就找到了客户端。

图5



好了，就像众多美食节目一样，各种菜品出炉前的食材都已经准备就绪，接下来正式上手！





#### 最简单易上手的方法，使用 SQL DUMP 来备份 MySQL

我们这次不完全按照官网的说明来操作，我们按照模板自己来定义配置参数和脚本，这样做的好处就是可以做到多个目标服务的备份。

官网的脚本都已经帮我们写好了，我们只要复制后再改一改就能用了。

具体怎么复制，又怎么改呢？

简单哦，只需要修改 **两个地方 和 三个文件** 就行了。



##### 先说两个地方：

一个是用户（也就是你自己）参数配置的所在地，路径如下。

```
/usr/local/etc/urbackup/
```

图6



另一个是 `UrBackup` 本体系统的脚本所在地，路径如下。

```
/usr/local/share/urbackup/scripts/
```

图7



这两个路径中的文件就是 `UrBackup` 给我们准备好的脚本，接着就是针对这两个所在地复制并修改三个文件，即可达到定制备份的目的。



##### 修改三个配置文件：

**1、`UrBackup` 总列表 `List` 文件**

这是个总览文件，其中需要添加两项：

a、给 `UrBackup` 看的执行脚本文件

b、你自己定义的参数配置文件及路径

```
vim /usr/local/share/urbackup/scripts/list
```

这里我将新增项命名 `mysql_for_dump` ，以区别原先的 `mariadbdump` 。

图8



**2、给 UrBackup 看的执行脚本文件**

最后，复制脚本文件 `mariadbdump` ，再修改一下脚本内容。 

```shell
cp /usr/local/share/urbackup/scripts/mariadbdump /usr/local/share/urbackup/scripts/mysql_for_dump
vim /usr/local/share/urbackup/scripts/mysql_for_dump
```

将其中的大概第26行的

 `. /usr/local/etc/urbackup/mariadbdump.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_dump.conf`

图9



**3、你自己的参数配置文件及路径**

然后，就是复制配置文件 `mariadbdump.conf` ，再修改一下配置内容。

```
cp /usr/local/etc/urbackup/mariadbdump.conf /usr/local/etc/urbackup/mysql_for_dump.conf
vim /usr/local/etc/urbackup/mysql_for_dump.conf
```

将其中几个字段按实际情况修改，比如：

开启 DUMP 备份： `MYSQL_FOR_DUMP_ENABLED=1` 

别忘记确保访问数据库的帐号和密码。

图10



##### 测试备份与恢复

如果正确地按以上配置设定好文件及其参数，那么备份很可能已经自动开始了。

到服务端查看，可以看到备份已经完成了。

图11



备份是全自动的，不用操心了，但恢复可就需要我们手动来操作了，正好我们也要测试一下恢复功能。

其实用 `sqldump` 的恢复本来就很简单，只要把备份的 sql 文件导入到数据库中即可，本地导入或远程导入都是可以的，怎么爽怎么来。

以前面的参数设置为基础举例，可以将备份 sql 文件上传到系统中，然后执行恢复命令。

```
mysql -uroot -p < mysql_for_dump.sql
```



PS: 如果你在测试过程中遇到错误或失败，那么仔细对照前面的步骤，很可能有哪些地方你没有修改正确。





#### 专业却有些复杂的方法，使用 Percona XtraBackup 备份

前面使用的 `sqldump` 简单易用，但它有个重大缺陷，通常只能满足数据库本身容量不大的场景（官方建议大小不超过1GB）。

如果数据库日积月累吃成了一个200多斤的胖子，那么 `sqldump`可能就真的拖不动它了。

这个时候怎么办？

别急，还有更专业的解决方案，它就是 `XtraBackup` 。



使用 `XtraBackup` 来备份数据库，缺点之一就是要额外安装它，缺点之二就是它比较复杂。

不过这些也不算什么缺点了，毕竟它是应用于一般生产环境，当然要搞定它了。



##### XtraBackup 安装

```
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
yum install percona-xtrabackup-24
```

图12



按照官网的说明，安装好后我们先小小测试它一下。

```
/usr/local/share/urbackup/scripts/mariadbxtrabackup > /dev/null
```

图13



从上面的图片中可以看出，`xtrabackup` 命令可以正常调用了，但因为没有提供更多有效的参数（比如帐号密码），所以也无法验证是否可以正确备份。

那么接下来我们给它配置所需的备份参数。

和之前 `sqldump` 一样，我们不直接使用官方提供的文件，而是复制模板自定义自己的文件。

这里需要复制和修改的文件也有 **两个地方 和 三个文件**。



**两个地方，一个是配置路径，另一个是脚本路径：**

```
/usr/local/etc/urbackup/
/usr/local/share/urbackup/scripts/
```



**1、UrBackup 总列表 List 文件**

其中添加两项：

a、你自己定义的参数配置文件及路径

b、给 `UrBackup` 看的脚本文件及路径

```
vim /usr/local/share/urbackup/scripts/list
```

这里我将新增项命名 `mysql_for_xtrabackup` ，以区别原先的 `mariadbxtrabackup` 。

图14



**2、你自己定义的参数配置**

然后，就是复制配置文件 `mariadbxtrabackup.conf` ，再修改一下配置内容。

```
cp /usr/local/etc/urbackup/mariadbxtrabackup.conf /usr/local/etc/urbackup/mysql_for_xtrabackup.conf
vim /usr/local/etc/urbackup/mysql_for_xtrabackup.conf
```

将其中几个字段按实际情况修改，比如：

开启 XtraBackup 备份： `MYSQL_FOR_XTRABACKUP_ENABLED=1` 

另外还有一些设定，参考图片吧。

图15



**3、给 UrBackup 看的执行脚本文件**

a、再然后，复制脚本文件 `mariadbxtrabackup` ，再修改一下脚本内容。 

```shell
cp /usr/local/share/urbackup/scripts/mariadbxtrabackup /usr/local/share/urbackup/scripts/mysql_for_xtrabackup
vim /usr/local/share/urbackup/scripts/mysql_for_xtrabackup
```

将其中的大概第26行的

 `. /usr/local/etc/urbackup/mariadbxtrabackup.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_xtrabackup.conf`

图16



b、再再然后，复制设定脚本。

```
cp /usr/local/share/urbackup/scripts/setup-mariadbbackup /usr/local/share/urbackup/scripts/setup-mysql_for_xtrabackup
vim /usr/local/share/urbackup/scripts/setup-mysql_for_xtrabackup
```

按图中修改。

图17



c、最后，用官方的 `setup` 脚本生成并修改另外两个脚本文件的内容。

执行 `/usr/local/share/urbackup/scripts/setup-mysql_for_xtrabackup` 。

图18



其中生成的两个脚本文件都需要修改一下才可以正常为我们工作，它们分别是：

```
/usr/local/etc/urbackup/prefilebackup
/usr/local/etc/urbackup/postfilebackup
```

将其中的大概第26行的

 `. /usr/local/etc/urbackup/mariadbxtrabackup.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_xtrabackup.conf`



PS：`setup` 脚本的作用，是在服务端生成一个虚拟的客户端，其名称为当前客户端名称后再加个 `[incr]` ，用作增量备份。

官方建议增量备份时间间隔设定足够小，完整备份时间间隔设定足够大。

图19



##### 测试备份与恢复

如果正确按以上配置好文件参数，那么备份很可能已经自动开始了。

系统会自动调用 `xtrabackup` 来备份数据库，然后传输到服务端。



先来测试一下备份，没错，小同学你的眼神很好，还是前面的那个命令。

```
/usr/local/share/urbackup/scripts/mariadbxtrabackup > /dev/null
```

之前因为参数配置不完整所以报错，现在OK。

图20



与 `sqldump` 恢复可以直接用命令不同的是，`XtraBackup` 恢复还需要配置一个恢复脚本。

这个脚本其实和备份脚本像哥俩一样，是成对出现的。

前面我们用的备份脚本是

```
/usr/local/share/urbackup/scripts/mysql_for_xtrabackup
```

那么我们的恢复脚本就可以这样生成

```
cp /usr/local/share/urbackup/scripts/restore-mariadbbackup /usr/local/share/urbackup/scripts/restore-mysql_for_xtrabackup
```

然后我们也要改一改它。

```
vim /usr/local/share/urbackup/scripts/restore-mysql_for_xtrabackup
```

图21



好了，我们尝试执行恢复命令。

```shell
/usr/local/share/urbackup/scripts/restore-mysql_for_xtrabackup
```

图22



没想到准备了这么多，在这儿居然会出错，说什么缺少 `jq` ，遂安装之。

```
# yum install jq
```



再次执行恢复命令。

此时要注意，如果出现恢复失败的情况，那么就要根据提示来判断问题，通常应该是脚本程序没配置好。

图23



出现如图错误，通过对比恢复脚本中的代码与实际 `mysql`  服务名称后才发现，脚本中服务名称少了一个字母 `d`  。

```
# systemctl -a | grep mysql
mysqld.service		loaded	active	running MySQL Server
```



遂打开 `vim` 将脚本中的 `mysql.service` 全部替换成 `mysqld.service` 。

```
%s/mysql.service/mysqld.service/g
```



再来尝试执行恢复，还是不行，再找找原因吧。

脚本程序中修改一处如下，将最后的 `mariadbxtrabackup` 修改成 `mysql_for_xtrabackup`  。

```
echo "Restoring full database backup..."
urbackupclientctl restore-start -b $RESTORE_FULL_BACKUP -d urbackup_backup_scripts/mysql_for_xtrabackup
```

图24



保存退出后再试一次，这次终于成功了！

图25



需要额外说明一下，在以上完成恢复的过程中如果你看到了 `mariadb.service: Unit not found`  之类的错误提示的话，也不用太在意。

因为我们根本就没有安装 `mariadb` 服务，`UrBackup` 实际上是自动判断、执行和重启 `mysql` 和 `mariadb` 两个服务的，并无特别影响。





#### 写在最后

本篇以我个人惨痛的填坑经历简要地给小伙伴们说明了如何使用 `UrBackup` 来备份 `MySQL` 的过程和方法。

`MySQL` 作为应用场景非常广泛的数据库，其数据备份自然也显得至关重要。

通过本文的了解，也可以让小伙伴们多一个可选之项。

当然我也是新手，经验不足，在此仅做抛砖引玉，供小伙伴们参考。

如果有什么疏漏之处还请先关注@网管小贾，然后再狠狠地批评指正，也欢迎在留言区发表你的看法哦！



WeChat@网管小贾 | www.sysadm.cc

