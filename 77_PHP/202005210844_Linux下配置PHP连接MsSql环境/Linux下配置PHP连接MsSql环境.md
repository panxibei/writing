Linux下配置PHP连接MsSql环境

副标题：小朋友打架，看看怎么劝架



> WeChat: @网管小贾
>
> Blog: @www.sysadm.cc



上次我们说到幼儿园班上的 `PHP` 和 `Sql Server ` （简称MsSql）两位小朋友关系不太好，有点小矛盾。

但毕竟在微软爸爸的地盘上（Windows），两位小朋友还算能相对地和谐相处。

> 请参看前文：[Windows下配置PHP连接SQL Server环境](https://www.sysadm.cc/index.php/webxuexi/728-windows-php-sql-server)



这一天，两位小朋友来到了Linux老师的教室里，不知道什么原因，居然又打了起来！

Linux老师怎么拉架都没办法解决，只要他们在一起就要闹各种各样的问题。

最后实在没招了，被折磨得焦头烂额的Linux老师把各自的家长都找来，发誓一定要解决问题！

最终双方家长坐了下来，冷静思考后各让一步，给出了解决方案。

* `MsSql` 提供 `Microsoft ODBC Driver for SQL Server (Linux)` 的驱动程序
* `PHP` 提供 `sqlsrv` 的扩展程序



嗯，要想让PHP连接MsSql，最最主要条件就是这两个了。

在直播带货还没火之前，还有诸如 `freetds` 或 `unixODBC` 这类的第三方存在，他们提供的方法也可以用，但非常复杂，操作起来巨麻烦。

为了小白，这边只演示简单好用的办法，就是直接走微软官方提供的驱动方法。

下面就来具体看看怎么实现这两个条件吧。



#### 一、安装 Microsoft ODBC Driver for SQL Server (Linux)

来到微软官网，找到ODBC驱动下载页面。

官方链接：`https://docs.microsoft.com/zh-cn/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15`

注意，在Linux可以很方便地在线安装驱动，下载下来手动安装反而相对麻烦。

在这里，我们使用 `CentOS7` 做例子，安装命令大概是这个样子的：

```bash
# 下载安装源
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

# 防止冲突，制裁旧包（可选）
sudo yum remove unixODBC-utf16 unixODBC-utf16-devel

# 开始安装ODBC驱动
sudo ACCEPT_EULA=Y yum install msodbcsql17
```

图1





#### 二、安装PHP的sqlsrv扩展

在这里拿PHP7.3来举例吧，安装命令大概是这个样子的：

```bash
# 安装PHP7.3的sqlsrv扩展
yum install php73-php-sqlsrv
```

安装好后，会有两个东东，一个叫 `sqlsrv`，另一个叫 `pdo_sqlsrv`。

另外，虽然可以自行编译安装，但还是推荐使用YUM来安装扩展，减少折腾。

一般来说，PHP在默认安装时是不带 `sqlsrv` 扩展的，所以安装后需要检查一下子。

```bash
# 检查一下sqlsrv扩展是否安装正确
php --ri sqlsrv
php --ri pdo_sqlsrv
```

执行检查命令后，会出现一堆英文，通常是没有问题的。

但你如果看到如下这个样子的提示，那就说明扩展引用有问题了。

这里插播一下如何填这个大坑，话说挺磨人的！

图2



**那么这个坑怎么填呢？**

1. **先找出扩展路径瞧瞧**

   两个办法，一个是查看 `phpinfo` 页面，还有一个是用命令查看。

   ```bash
   # 没有安装Apache或Nginx的小伙伴还是直接用命令吧
   # 先新建一个phpinfo.php
   echo "<?php phpinfo(); ?>" > phpinfo.php
   # 再查找扩展路径
   php phpinfo.php | grep extension_dir
   ```

   输出结果：

   ```shell
   extension_dir => /usr/lib64/php/modules => /usr/lib64/php/modules
   ```

   

2. **再查找扩展文件在哪个地方**

   ```bash
   find / -name sqlsrv.so
   ```

   输出结果：

   ```shell
   /opt/remi/php73/root/usr/lib64/php/modules/sqlsrv.so
   ```

   原来是因为PHP的扩展路径不对，默认路径下没有扩展文件。

   好吧，我懒得改默认路径，直接把文件复制过去吧。

   重试再测试，居然还是报错。

   

3. **在 `PHP.INI` 中加载扩展描述**

   ```ini
   # pdo一项千万别忘记，如果没有加载，那么pdo_sqlsrv也不会生效了
   extension=pdo
   extension=sqlsrv
   extension=pdo_sqlsrv
   ```



我是小白，花了不少时间，坑就这么给填好了，一言难尽！



#### 三、测试PHP是否能连接MsSql

我们还是用之前文章的源代码，同时也是符合官方提供的示例。



1、测试使用 `sqlsrv` 扩展连接 `MsSql` ，命令：`php test_mssql.php`。

```php
<?php
// *********************
// 这是测试sqlsrv扩展的例子
// 文件名：test_mssql.php
// *********************

$serverName = "x.x.x.x";	// SQL Server服务器的IP地址
$connectionInfo = array(
    "UID"        =>    "sa",        // 用户名
    "PWD"        =>    "123456",    // 密码
    "Database"    =>    "master"    // 数据库名称
);

// 建立连接
$conn = sqlsrv_connect($serverName, $connectionInfo);

// 判断连接是否成功
if ($conn) {
    echo "成功连接SQL Server！\n";
} else {
    echo "无法连接SQL Server！\n";
    var_dump(sqlsrv_errors());
}
?>
```



2、测试使用 `pdo_sqlsrv` 扩展连接 `MsSql`，命令：`php test_mssqlpdo.php`。

```php
<?php
// *********************
// 这是测试pdo_sqlsrv扩展的例子
// 文件名：test_mssqlpdo.php
// *********************

$serverName = "x.x.x.x";	// SQL Server服务器的IP地址

try
{
	$conn = new PDO( "sqlsrv:server=$serverName ; Database=master", "sa", "123456");
	$conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
}
catch(Exception $e)
{
    echo "无法连接SQL Server！\n";
	die(print_r($e->getMessage()));
}
	echo "成功连接SQL Server！\n";
?>
```



如果你看到连接成功的字样，那么就一切OK啦！（撒花撒花~）

可是如果你看到如下这个样子，那么只能回头再看一看前面的填坑记录（这里有张摊手的动图）。

图3



好了，一切搞定后 `PHP` 和 `SQL Server` 两位小朋友总算能好好相处了。

但说实话，Linux平时是个和蔼可亲的老师，但就是因为他脾气太好了，使得班里的小朋友们出现各种淘气。

那么，下一回又会是哪些小朋友闹脾气呢，老师又会怎么做呢？

请看下回分解！



> WeChat: @网管小贾
>
> Blog: @www.sysadm.cc



