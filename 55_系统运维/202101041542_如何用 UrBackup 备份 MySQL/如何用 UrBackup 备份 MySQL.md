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





#### 需要修改一共**两个地方和三个文件**。

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

1、你自己的参数配置

```
cp /usr/local/etc/urbackup/mariadbdump.conf /usr/local/etc/urbackup/mysql_for_dump.conf
```



```shell
vim /usr/local/etc/urbackup/mysql_for_dump.conf
```



2、UrBackup 总列表 List

其中添加两点：

a、你自己的参数配置文件

b、给 UrBackup 看的配置文件





3、给 UrBackup 看的配置文件



```shell
cp /usr/local/share/urbackup/scripts/mariadbdump /usr/local/share/urbackup/scripts/mysql_for_dump
```



将其中的

 `. /usr/local/etc/urbackup/mariadbdump.conf`

修改为

`. /usr/local/etc/urbackup/mysql_for_dump.conf`