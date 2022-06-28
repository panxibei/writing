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



再查看一下 `sqldump` 所涉及的脚本文件。

```
/usr/local/etc/urbackup/postgresqldump.conf
```

图c02



我们将它复制一份新文件出来，然后在新文件上修改，新文件名称随意，只要能看懂是给哪个 `PgSQL` 系统用的就行。

```
cp postgresqldump.conf postgresqldump-sysadmcc.conf
```

然后打开文件将其中的内容参数修改一下。

```
vim postgresqldump-sysadmcc.conf
```



开启 `sqldump` 备份。

```
POSTGRESQL_DUMP_ENABLED=1
```

图c03



