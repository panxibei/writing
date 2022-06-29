使用 UrBackup 备份和恢复 PostgreSQL

副标题：使用 UrBackup 备份和恢复 PostgreSQL

英文：

关键字：



使用 UrBackup 备份和恢复 PostgreSQL





安装 `PostgreSQL` 

我们选择版本 `12` 来做为测试对象。

系统平台为 `Rocky Linux 8.6` ，因此我们选择与 `redhat` 相同频道的安装方法。

> https://www.postgresql.org/download/linux/redhat/



安装方法很简单，照猫画虎就行了。

```
# 安装RPM源
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```

图b01



```
# 禁用可能的内置PostgreSQL模块
sudo dnf -qy module disable postgresql
```

图b02



```
# 安装PostgreSQL
sudo dnf install -y postgresql12-server
```

图b03



```
# 可选命令，初始化数据库和启用开机自动运行
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl enable postgresql-12
sudo systemctl start postgresql-12
```





查看 `UrBackup` 客户端是否正常运行。

图c01





### 最简单易上手的方法，使用 `SQLDUMP` 来备份

如果小伙伴们直接去看官网上写的说明，那可能就真的要出事了。

因为官网关于 `SQLDUMP` 的设置就一句话，将以下文件中的某参数开关从 `0` 改成 `1` 。

```
/usr/local/etc/urbackup/postgresqldump.conf
```



这么写的确是让人丈二高的和尚摸不着头脑啊！

因此，抛开官网写法，我在这儿详细地给小伙伴们说明为啥就改这一个文件。

实际上 `UrBackup` 在安装好以后就已经给我们准备好了备份 `PostgreSQL` 的自动化脚本程序。

这些脚本程序主要被放到了 **两个地方** ，一共有 **三个文件** ，我们去看看吧！



##### 先说说两个地方

一个是用户（也就是你自己）参数配置的所在地，路径如下。

```
/usr/local/etc/urbackup/
```

图c02



另一个是 `UrBackup` 程序本体系统的脚本所在地，路径如下。

```
/usr/local/share/urbackup/scripts/
```

图d08



这两个路径中的文件就是 `UrBackup` 给我们准备好的脚本，接着就是针对这两个所在地中的文件来操作，复制并修改其中的三个文件，即可达到定制备份的目的。



##### 再来聊聊三个配置文件

**1、`UrBackup` 总列表 `List` 文件**

这是一个总览列表文件，有点像一个备份的计划总表，在其中我们需要添加两项内容：

a、给 `UrBackup` 看的执行脚本文件（跑备份用的）

b、你自己定义的参数配置文件及路径（你想让它生成什么内容等等）

```
vim /usr/local/share/urbackup/scripts/list
```

图d01



这里我们照猫画虎，仿照带有 `postgresqldump` 字样的那一项，然后在其下方新增一项并将其命名为 `postgresqldump-sysadmcc` ，以区别原有的 `postgresqldump` 。

注意，千万不要复制错了，不同配置或脚本跑起来内容是不一样的哦！

记得在下方也要多复制一行脚本参数来对应前面的配置。

图d02



**2、给 `UrBackup` 看的执行脚本文件**

接着复制脚本文件 `postgresqldump` 到一个新文件，并将新文件重命名为 `postgresqldump-sysadmcc` ，然后再修改一下脚本内容。 

```shell
cd /usr/local/share/urbackup/scripts/
cp postgresqldump postgresqldump-sysadmcc
vim postgresqldump-sysadmcc
```

将其中的大概第 `26` 行的

```
. /usr/local/etc/urbackup/postgresqldump.conf
```

修改为

```
. /usr/local/etc/urbackup/postgresqldump-sysadmcc.conf
```

也就是指向前面那个新的配置文件。

图d09



**3、你自己的参数配置文件及路径**

然后，就是复制配置文件 `postgresqldump.conf` 到一个新文件，并将新文件重命名为 `mysql_for_dump.conf` ， ，然后再修改一下配置内容。

```
cd /usr/local/etc/urbackup/
cp postgresqldump.conf postgresqldump-sysadmcc.conf
vim mysql_for_dump.conf
```

开启 `sqldump` 备份开关。

```
POSTGRESQL_DUMP_ENABLED=1
```

图c03



##### 测试备份与恢复

OK，一切就绪，准备测试备份！

自信满满地开始备份，却发现执行备份，出错？！

```
postgresqldump.sql: could not find a "pg_dumpall" to execute
```

图d03



这就奇怪了，怎么可能没有 `pg_dumpall` 呢？！

手动输入命令都是可以完美运行的。

最后找到论坛中，有网友说通过编辑 `postgresqldump` 文件写入完全路径即可解决问题。

我有点不太相信啊，不过什么情况都是有可能的。

因此我先找到 `pg_dumpall` 的路径。

```
whereis pg-dumpall
```

图d04



然后再编辑 `postgresqldump` 文件，将 `pg_dumpall` 路径写完全。

```
vim /usr/local/share/urbackup/scripts/postgresqldump
```



将原代码行

```
su postgres -c "pg_dumpall"
```

修改成

```
su postgres -c "/usr/bin/pg_dumpall"
```

敲黑板：如果你有多个不同的 `sqldump` 脚本，那么不管这些脚本有没有被启用，都请务必将这些脚本中的 `pg_dumpall` 路径补齐。

图d05



最后再来测试一下，果然没有问题了！

小伙伴们这里一定要注意这个非常弱智的坑啊！

图d06



备份文件也正常生成了！

图d07



好了，实际上一旦设置完成，备份都是自动实现的，就是前面有那么一个坑，所以我不得不在这儿手动备份一下让大家看一看。

虽说备份自动，但恢复的话还是需要我们手动来操作的，我们来试一下。

其实很简单，就是将备份的 `sql` 文件导入数据库即可。

```
psql -f postgresqldump.sql postgres
```



不过在恢复过程中有可能遭遇如下错误：

```
psql: FATAL: role "root" does not exist
```

这是由于 `PostgreSQL` 默认不让使用 `root` 用户来直接操作。

折中的解决办法就是给一个 `root` 用户，并赋予相应权限。

```
// 切换到 postgres 用户
root# su - postgres

// 登录到 PostgreSQL
postgres$ psql -U postgres

// 创建 root 用户，这个 root 用户是指 pgsql 中的
postgres=# create user root superuser;
```



小结一下，本方法就是利用 `UrBackup` 自带的备份脚本来实现 `SQL` 备份的，只不过如果我们想要更加灵活地实现一些备份效果，那最好是参考复制这些自带的脚本并修改其中一些参数。



通过 `SQL DUMP` 来实现备份的方法比较简单直观，由官方脚本背书不太会出大错，但它还是存在一些优缺点的，需要我们根据实际场景来调整切换使用。



**比如它有以下几个优点：**

* 易于设置，这个不用多说，拿现成脚本复制修改即可。
* 允许在恢复时迁移到不同的 `PostgreSQL` 版本，因为它本质是执行 `SQL` 语句嘛！
* 备份结果为非二进制，因此你可以在恢复数据之前手动做一些删除表或修改数据的动作。 
* 备份容量可以更小，因为它不包含索引。 

**同时缺点也不少：** 

- 恢复时间可能会更长，因为 `PostgreSQL` 必须重建索引。
- 增量备份可能会导致 `UrBackup` 增加较为明显地传输数据量。
- 在增量备份期间必须读取完整的数据库（不包括索引）。 



因此结论是，如果你拥有一个较小规模不是太大的数据库（比如 `1GB` ），那么可以考虑这个方法。

当然了，随着现在硬件性能的高速提升，这个 `1GB` 的官方提法并不是绝对的，还是要我们实际测试过了才算有比较可靠的结论。

PS：如果你在测试过程中遇到错误或失败，那么仔细对照前面的步骤，很可能有哪些地方你没有修改正确。





### 适合 `Windows` 平台使用的快照备份

这部分内容在之前的旧文章中并没有写进来，即使官网有这么一小块介绍。

我没有写它的原因是，在 `Windows` 所谓实现 `PostgreSQL` 备份的本质怎么看都是文件备份的一种。

这次为了使文章内容更加完整，因此将其一起记录下来。



前面我们也说过，默认 `Linux` 是无法开启快照功能的，这要依靠某些模块配合，实施起来有点复杂。

但是换到 `Windows` 上就完全不一样了，妥妥地一切已经就绪，就等用户来用就是了。

原因很简单，`Windows` 就文件系统来说已经支持快照备份功能了，这个我们可以通过阅读 `UrBackup` 管理手册了解。

那么这个方法有哪些优缺点呢？



**优点：** 

- 易于在 `Windows` 上配置部署。
- `UrBackup` 仅传输更改变动的数据。
- 正确的进度指示。
- 如果网络速度很快，则可以快速恢复，因为备份中包含索引。

**缺点：** 

- 你可能无法在 `Linux` 上设置快照方法。
- 因为备份了索引，所以备份可能比 `sqldump` 方法生成的备份大。
- 数据无法被恢复到以前较旧的 `PostgreSQL` 版本。
- 如果没有可用的更改块跟踪，则必须在增量备份期间读取完整的数据库。
- 快照可能会降低数据库访问速度，具体取决于快照存储写时复制数据的位置（ `Windows` 上的影子存储）。 



备份设置方法比较简单，只需设定客户端 `PostgreSQL` 的备份路径即可。

想要恢复时需要先停止 `PostgreSQL` 服务，然后再将备份文件恢复到原来的路径中，最后启动服务就OK了！



小结一下：这个应该是 `Windows` 用户最可接受的方法了，不过经过我的一些测试，感觉对于恢复数据来说不是非常可靠，可能会有各种各样的问题存在，请务必小心使用此方法。

如果你仍然坚持使用 `Linux` ，那么请务必确保开启了快照机制功能。





### 专业却有些复杂的方法，不用快照和日志传输的二进制备份



找到以下路径，编辑 `postgresbase.conf` 文件，将开关打开。

```
/usr/local/etc/urbackup/postgresbase.conf
```

图e01



添加一个虚拟客户端，用于本地复制。

```
urbackupclientctl set-settings -v virtual_clients -k wal
```

图e03



确保 `postgres` 用户可以建立本地复制连接，我们需要在 `pg_hba.conf` 文件中开放本地复制连接。

```
local	replication	postgres	peer
```

图e02



接下来在 `postgresql.conf` 文件中设定以下两个参数。

```
# 预定式日志，最大发送进程数量，大于0即可
max_wal_senders = 10
```

图e04



```
# 预写式日志级别，minimal、replica 或 logical
wal_level = replica
```

此参数值与官网描述有出入，应该以配置文件描述为准。

图e05



修改脚本文件 `postgresbase` ，将其中的 `pg_basebackup` 命令补全路径。

```
/usr/bin/pg_basebackup
```

图e15



以上设定完毕后重启 `PostgreSQL` ，然后使用以下命令测试完全备份是否工作正常。

```
/usr/local/share/urbackup/scripts/postgresbase > /dev/null
```

图e06



如果你不想进行连续的 `WAL` 备份，那么可以到此为止了。

要是想经常将 `WAL` 数据备份到备份服务器，则必须配置 `PostgreSQL` ，以便将 `WAL` 数据复制到某处，然后在 `WAL` 备份完成后将其删除。

若要配置 `PostgreSQL` ，将 `WAL` 文件归档到某个目录中，则应该将 `archive_mode` 参数打开。

```
archive_mode = on
```

并且将以下代码写入 `archive_command` 中。

```
archive_command = 'cp %p /var/lib/walarchive/incoming/%f; mv /var/lib/walarchive/incoming/%f /var/lib/walarchive/staging/%f'
```

图e07



命令有了，相应的归档目录也要建立。

```
mkdir -p /var/lib/walarchive/{incoming,staging,backup}
chown postgres:postgres /var/lib/walarchive/{incoming,staging,backup}
```

图e08



 配置要备份的 `WAL` 归档。

```
urbackupclientctl add-backupdir --keep -d /var/lib/walarchive/backup -v wal
```

图e09



添加备份前置脚本。

```
vim /usr/local/etc/urbackup/prefilebackup
```

代码如下：

```
#!/bin/bash
set -e
exists() { [[ -e $1 ]]; }
# Argument three not null means virtual client
if [ $3 != 0 ] && exists /var/lib/walarchive/staging/*
then
	mv /var/lib/walarchive/staging/* /var/lib/walarchive/backup/
fi
```



添加备份后置脚本。

```
/usr/local/etc/urbackup/postfilebackup
```

代码如下：

```
#!/bin/bash
set -e
exists() { [[ -e $1 ]]; }
# Argument one null means main client
if [ $1 = 0 ]
then
	urbackupclientctl reset-keep -v wal
elif exists /var/lib/walarchive/backup/*
then
	rm /var/lib/walarchive/backup/*
fi
```



千万不要忘记给脚本赋予可执行权限。

```
chmod +x /usr/local/etc/urbackup/prefilebackup
chmod +x /usr/local/etc/urbackup/postfilebackup
```

图e10



然后将 `WAL` 备份间隔配置为相对较小，将含有基础备份脚本的主客户端的备份间隔配置为相对较大，并通过备份窗口将其计划安排在不干扰数据库正常使用的时间范围内。



备份成功应该是这个样子的。

图e14

图e13



最后请注意，这里也有一个坑。

和前面类似的，`psql` 命令也需要补全路径，否则也会出现找不到命令的奇葩错误。

图e11

图e12



**恢复方法（暂未验证）：**

首先通过以下命令行恢复基本备份。

```
urbackupclientctl restore-start -b last -d urbackup_backup_scripts/postgresbase
```



然后将最新的一组 `WAL` 文件复制到数据库服务器并按照恢复小节 `25.3.4` 的说明

此处以 `PostgreSQL 12` 版本为例，其他版本的章节数有些许出入。

具体请参考官方链接。

> https://www.postgresql.org/docs/12/continuous-archiving.html

```
// 使用连续存档备份进行恢复
25.3.4. Recovering Using a Continuous Archive Backup
```











优点： 

- UrBackup 仅传输更改的数据 
- 在更频繁的备份期间不会读取完整的数据库 
- 如果网络很快，则可以快速恢复，因为备份中包含索引 
- 数据库没有变慢。  备份被适当地限制，这样它就不会过多地干扰数据库的使用 

缺点： 

- 难以设置 
- 可能比使用快照的备份稍慢 
- 更难恢复 
- 目前仅针对 Linux 实现和记录 

*结论：* 高流量和大型 PostgreSQL 实例的最佳方法。 















