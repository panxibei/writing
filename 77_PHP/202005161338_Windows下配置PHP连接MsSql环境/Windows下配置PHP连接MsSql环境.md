Windows下配置PHP连接SQL Server环境

副标题：PHP连接MsSql忒麻烦

> 微信公众号：@网管小贾
>
> 个人博客：@www.sysadm.cc



众所周知，PHP和MySql是组黄金搭档，哥俩儿个关系不是一般的铁，自然在一起干活互相配合得十分默契。

但要让PHP和微软的SQL Server（简称MsSql）搭在一起，那真是各种鸡飞狗跳，忒麻烦！

这个世界就是这样，有人喜欢萝卜，就有人喜欢白菜。

PHP是最好的语言，这可不是我说的哦！

喂！你们住手，说好了不能打脸的~~

你瞧瞧，萝卜和白菜打起来。。。Sorry！是人打起来了！

不过嘛，毕竟MsSql是微软爸爸家的，聪明机智的网友们纷纷开动脑筋，用了很多大招。

但是大招再厉害，也不如微软爸爸亲自出手啊。

好吧，谁让这二位都挺受大家伙儿欢迎的呢，于是微软爸爸也祭出了法宝。

这次咱们先搞定WampServer环境下PHP使用MsSql的问题，Linux的小伙伴们请稍等在后面排下队哈。

OK，咱们顺势走起。。。



#### Part. 1 下载安装SQL Server官方ODBC驱动

登上微软官网，找到 [下载 ODBC Driver for SQL Server](https://docs.microsoft.com/zh-cn/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver15) 页面。

我的WampServer是32位的，所以找到 [`Microsoft ODBC Driver 17 for SQL Server (x86)`](https://go.microsoft.com/fwlink/?linkid=2120140) 下载。

下载后，直接点击安装。

图1



打开Windows的 `控制面板`，在搜索栏中输入 `odbc`，选择如图一项 `设置ODBC数据源(32位)`。

在 `驱动程序` 选项卡中，确定能看到 `ODBC Driver 17 for SQL Server` ，说明驱动安装成功。

图2

图3



有眼尖的小伙伴会看到有一项 `ODBC Driver 11 for SQL Server`，版本不一样，有什么区别呢？

其实，这些不同版本的驱动程序，针对的是不同版本的SQL Server。

比如11版支持SQL Server 2014，13版支持SQL Server 2016，当然还有一些其他高级特性。

我们现在安装的是17版，是当前最新版本，应该支持当前最新版本的SQL Server。

总之，我们保证PHP能连接成功就行，有兴趣的话可以登录官网查看细节内容。



#### Part. 2 开启PHP的ODBC扩展，以便PHP可以使用ODBC驱动

在 `php.ini` 中开启 `odbc` 扩展：

```ini
; 在php.ini中找到以下两项，并去掉前面的分号，记得重启服务
extension=odbc
extension=pdo_odbc
```

查看 `phpinfo` 中的信息是否有 `ODBC` 和 `PDO_ODBC` 字样。

如果没有，看看是不是没重启。

图4



#### Part. 3 测试PHP连接SQL Server

如果一切OK，那么这个时候就可以开始测试啦。

一个简单的测试代码：

```php
<?php
// SqlServer身份验证，参数使用数组的形式，依次是用户名，密码，数据库名
// 如果你使用的是Windows身份验证，那么可以去掉用户名和密码

$serverName = "x.x.x.x"; // SQL Server服务器的IP地址
$connectionInfo = array(
	"UID"		=>	"sa",		// 用户名
	"PWD"		=>	"123456",	// 密码
	"Database"	=>	"master"	// 数据库名称
);

// 建立连接
$conn = sqlsrv_connect($serverName, $connectionInfo);

// 判断连接是否成功
if ($conn) {
	echo "成功连接SQL Server！";
} else {
	echo "无法连接SQL Server！<br>";
	var_dump(sqlsrv_errors());
}
?>
```



测试中可能会遇到的问题：

* 输出内容出现乱码（如下图），可以把网页文字编码由 `unicode` 修改为 `简体中文` 后再刷新重试。
* 即便是本地测试，SQL Server连接也需要开启TCP/IP，并且保证SQL Browse服务正常运行。
* 注意WampServer是32位的还是64位的，对应的驱动要区分。

图5





看着PHP和MsSql两位小朋友能够和谐相处，是不是打心底里那个开心啊！

前面一二三的步骤走下来，小伙伴们应该还顺利吧？

如果在操作过程中有什么问题，欢迎和我交流探讨。

有机会我会补上下一期，在Linux下实现PHP连接MsSql。

感谢你的关注，拜拜~~



微信公众号：@网管小贾

个人博客：@www.sysadm.cc