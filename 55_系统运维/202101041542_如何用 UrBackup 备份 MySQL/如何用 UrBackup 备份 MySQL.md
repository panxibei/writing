如何用 UrBackup 备份 MySQL

副标题：







新建一个数据库

```mysql
CREATE DATABASE `www.sysadm.cc`
```



就像美食节目一样，做菜前的食材都已经准备好了。

图1





在 Linux 下安装 UrBackup 。

```shell
TF=$(mktemp) && wget "https://hndl.urbackup.org/Client/2.4.11/UrBackup%20Client%20Linux%202.4.11.sh" -O $TF && sudo sh $TF; rm -f $TF
```

按 Y 继续安装......

图2



选择快照

图3



我们在这里选择 `4) Use no snapshot` ，也就是不用快照功能。

因为快照功能会在本地磁盘上生成快照，然后再实施备份，所以它要占用很大磁盘空间。

当然还有其他一些问题，主要是我也是小白一个，对这个不是太懂，这次就暂且略过。



如果你想用快照功能，那么可以先参考下面这段 `dattobd` 的安装过程。

如果你不用快照功能，那么请直接进入下一节。



#### dattobd 的安装过程

按 1 报错，说 dattobd 没有安装，要先安装 dattobd 。

这个 dattobd 是个什么鬼？

图4



官方解释是，用于获取Linux块设备的块级快照和增量备份的内核模块。

感觉好像是类似于 Windows 的卷影服务，反正先安装了再说，请原谅我知识的匮乏，以后有空再细细研究。

找到其 github 上的项目页，按其 INSTALL.md 上的介绍执行安装命令。

```shell
sudo yum localinstall https://cpkg.datto.com/datto-rpm/repoconfig/datto-el-rpm-release-$(rpm -E %rhel)-latest.noarch.rpm
sudo yum install dkms-dattobd dattobd-utils
```

结果第一条就挂了，说什么要 `epel-release` 。

图5



我用的是OL，不是 CentOS ，所以还得自己动手安装啊。

OL安装epel-release源

```shell
wget https://mirrors.ustc.edu.cn/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
```



顺利安装好 `epel-release` 后，回头再次安装 `dattobd` 。

这回好使了！

图6



好，有了 `dattobd` 再来安装 `UrBackup` 。

图7





#### 使用 SQL DUMP 来备份 MySQL

需要修改一共**两个地方和三个文件**。



##### 先说两个地方：

一个是用户参数配置所在地

```
/usr/local/etc/urbackup/
```

另一个是 UrBackup 自己的配置所在地

```
/usr/local/share/urbackup/scripts/
```



下面就是针对这两个所在地修改三个文件，即可达到定制备份的目的。



##### 修改三个配置文件：

1、UrBackup 总列表 List

其中添加两点：

a、你自己的参数配置文件

b、给 UrBackup 看的配置文件





2、你自己的参数配置

```
cp /usr/local/etc/urbackup/mariadbdump.conf /usr/local/etc/urbackup/mysql_for_dump.conf
```



```shell
vim /usr/local/etc/urbackup/mysql_for_dump.conf
```







3、给 UrBackup 看的执行配置文件



```shell
cp /usr/local/share/urbackup/scripts/mariadbdump /usr/local/share/urbackup/scripts/mysql_for_dump
```



```
/usr/local/share/urbackup/scripts/mysql_for_dump
```



将其中的大概第26行的

 `. /usr/local/etc/urbackup/mariadbdump.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_dump.conf`



##### 测试备份与恢复

如果正确按以上配置好文件参数，那么备份很可能已经开始了。

到服务端查看，可以看到备份已经完成了。



备份是全自动的，但恢复可就需要我们手动来操作了。

其实用 `sqldump` 本来就很简单，只要把备份的 sql 文件导入到数据库中即可，本地导入或远程导入都是可以的。

就前面的参数设置举例，可以将备份 sql 文件上传到系统中，然后恢复执行命令。

```
mysql -uroot -p < mysql_for_dump.sql
```

图



#### 使用 Percona XtraBackup 备份

前面使用的 `MySqlDump` 简单易用，但它只能满足数据库本身不大的场景。

如果数据库日积月累成了一个胖子，那么 `MySqlDump`可能就拖不动它了。

这个时候怎么办？

别急，还有更好用的，它就是 `XtraBackup` 。



通过使用 `XtraBackup` 来备份数据库，缺点之一就是要先安装它。

不过这也不算什么缺点了，毕竟它比较好用，当然要先安装它了。



##### XtraBackup 安装

```
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
yum install percona-xtrabackup-24
```

图b1



安装好后我们测试一下。

```
/usr/local/share/urbackup/scripts/mariadbxtrabackup > /dev/null
```

图b2



从上面的图片中可以看出，`xtrabackup` 命令是可以正常调用，但因为没有提供更多有效的参数（比如帐号密码），所以也无法验证是否可以正确备份。

那么接下来我们给它配置所需的备份参数。



和之前 mysqldump 一样，这里修改配置文件也有两个地方和三个文件。



两个地方：

```
/usr/local/etc/urbackup/
/usr/local/share/urbackup/scripts/
```



1、UrBackup 总列表 List

其中添加两点：

a、你自己的参数配置文件

b、给 UrBackup 看的配置文件

图b3



2、你自己的参数配置

```
cp /usr/local/etc/urbackup/mariadbxtrabackup.conf /usr/local/etc/urbackup/mysql_for_xtrabackup.conf
```



```
vim /usr/local/etc/urbackup/mysql_for_xtrabackup.conf
```

图b4





3、给 UrBackup 看的执行配置文件



```shell
cp /usr/local/share/urbackup/scripts/mariadbxtrabackup /usr/local/share/urbackup/scripts/mysql_for_xtrabackup
```



```
/usr/local/share/urbackup/scripts/mysql_for_xtrabackup
```

将其中的大概第26行的

 `. /usr/local/etc/urbackup/mariadbxtrabackup.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_xtrabackup.conf`

图b5



复制设定脚本

```
cp /usr/local/share/urbackup/scripts/setup-mariadbbackup /usr/local/share/urbackup/scripts/setup-mysql_for_xtrabackup
```

按图中修改

图b8



执行 `/usr/local/share/urbackup/scripts/setup-mysql_for_xtrabackup` 。

其中生成的两个文件都需要修改一下才可以正常工作。

```
/usr/local/etc/urbackup/prefilebackup
/usr/local/etc/urbackup/postfilebackup
```

将其中的大概第26行的

 `. /usr/local/etc/urbackup/mariadbxtrabackup.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_xtrabackup.conf`





##### 测试备份与恢复

如果正确按以上配置好文件参数，那么备份很可能已经开始了。

系统会自动调用 `xtrabackup` 来备份数据库，然后传输到服务端。



先测试备份。

```
/usr/local/share/urbackup/scripts/mariadbxtrabackup > /dev/null
```

之前因为参数配置不完整所以报错，现在OK。



与 `MySqlDump` 不同的是，`XtraBackup` 恢复还需要配置一个恢复脚本。

这个脚本其实和备份脚本一样，是成对出现的。

前面我们用的备份脚本是

```
/usr/local/share/urbackup/scripts/mysql_for_xtrabackup
```

那么我们的恢复脚本就可以这样生成

```
cp /usr/local/share/urbackup/scripts/restore-mariadbbackup /usr/local/share/urbackup/scripts/restore-mysql_for_xtrabackup
```

```
vim /usr/local/share/urbackup/scripts/restore-mysql_for_xtrabackup
```

图b6



尝试执行恢复命令

```shell
/usr/local/share/urbackup/scripts/restore-mysql_for_xtrabackup
```

图b7



出错，说什么缺少 `jq` ，遂安装之。

```
yum install jq
```



再次执行恢复命令

图b9



```
cp setup-mariadbbackup setup-mysql_for_xtrabackup
```









