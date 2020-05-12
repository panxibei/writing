VB+SQLite组合，真香！（一）

副标题：对，就是这个味儿！



> 微信公众号：网管小贾
>
> 个人博客：www.sysadm.cc



嗨！你好！我是网管小贾！

当你看到这个标题时，是不是感觉很奇怪呢？

老掉牙的VB和“玩具”数据库SQLite搞在一起是个什么玩意？

待我慢慢道来哈。。。



SQLite众所周知，是个文件数据库，小而快，号称世界上使用最广泛的数据库（官网描述居然没有“之一”）。

官方是在吹牛吗？

出于好奇和兴趣，我抽空简单地学习了一下SQLite。



SQLite一般应用在单机场景，没有服务器的概念，很适合做些单机应用。

而在Windows环境下，一般情况都会使用Access作为本地数据库系统。

但Access太磨人了，是时候把SQLite扶上正位了。

关于SQLite和Access的性能对比，请小伙伴们自行百度，差得不是一点半点啊。

我自己测试过，同样环境同样导入500条记录，SQLite耗时1秒都不到，而Access却要用36秒之多，真是令人瞠目！



使用其他高级语言可以很简单的调用SQLite，但对于古老的VB似乎是有些不可能完成的任务。

另外，调用某数据库，通常讲是需要数据库驱动的，比如在ODBC中添加驱动。

由于Windows里集成了SqlServer的驱动，所以用户调用SqlServer数据库并不需要专门安装驱动程序而直接可以连接访问数据库。

而SQLite虽然也是要先驱动才能使用的，但是要简单的多啊。

这里告诉你一个好消息，本文要介绍的VB调用SQLite是不需要额外安装驱动的，只要一个DLL文件即可，而且DLL文件是不需要注册的。（文末有下载）



哦？！这么神奇吗？！

是的，N年前一次偶然机缘，从网上某位大神那里得到了一个SQLite的VB调用库，自此开启VB访问数据库飞一般的神奇之旅。

（出处已不可考，在此向大神致敬！）

好了，让我们丢开Access，投入SQLite的怀抱吧！

小伙伴们的毕业设计是不是有希望了呢，想想都有些小激动啊！

接下来我们看看怎么玩转 `VB+SQLite` 组合，不难的哦。



首先，我们得建个数据库。

先从网上找个SQLite数据库工具软件，我用的是 `SQLite Expert Personal`，个人版免费，你也可以用其他的，网上有很多。

图1

建立一个数据库名称为 `db_user.db`，再建一个表 `tbl_user`，保存文件为 `user.db`。

```sqlite
-- 建立tbl_user表
CREATE TABLE tbl_user (id integer primary key, value text);
```

很简单吧！



其次，打开VB编辑器，新建工程，导入模块 `ModSQLite.bas`。

我做了个测试程序，分享给你参考。（文末有下载）

下面演示数据库的连接访问及CRUD的方法。

图2



1、连接数据库

```vb
'打开数据库
Private lngDB as long
SQLite_open App.Path + "\user.db", lngDB
```



2、关闭数据库

```visual basic
'关闭数据库
Private lngDB as long
SQLite_close lngDB
```


3、添加记录

```vb
Dim sqlite3_stmt As Long
' SQL语句查询
Call SQLite_prepare(lngDB, "insert into tbl_user (id, value) values(" & txtInsertItem1.Text + ",'" & txtInsertItem2.Text & "')", sqlite3_stmt)
SQLite_step sqlite3_stmt
SQLite_finalize sqlite3_stmt
```


4、删除记录

```vb
Dim sqlite3_stmt As Long
' SQL语句查询
Call SQLite_prepare(lngDB, "delete from tbl_user where id=1", sqlite3_stmt)
SQLite_step sqlite3_stmt
SQLite_finalize sqlite3_stmt
```



5、更新记录

```vb
Public Const SQLITE_OK = 0
Dim sqlite3_stmt  As Long
Dim hRet As Long
' SQL语句查询
hRet = SQLite_prepare(lngDB, "update tbl_user set id=?, value=? where id=?1", sqlite3_stmt)
If hRet = SQLITE_OK Then
    Call SQLite_bind_int(sqlite3_stmt, 1, Val(txtUpdateItem1.Text)) '代替上面sql语句里第1个问号
    Call SQLite_bind_text(sqlite3_stmt, 2, txtUpdateItem2.Text) '代替上面sql语句里第2个问号
    SQLite_step sqlite3_stmt
    SQLite_finalize sqlite3_stmt
End If
```



6、查询数据

```vb
Public Const SQLITE_OK = 0
Dim sqlite3_stmt As Long	' SQL状态值
Dim hRet As Long	' 查询返回句柄
' SQL语句查询
hRet = SQLite_prepare(lngDB, "select * from tbl_user", sqlite3_stmt)
' 如果返回OK，则输出记录
If hRet = SQLITE_OK Then
	' 打印表头
	picData.Print SQLite_column_name(sqlite3_stmt, 0), SQLite_column_name(sqlite3_stmt, 1)
	' 循环输出记录值
	Do While SQLite_next(sqlite3_stmt)
		picData.Print SQLite_column_text(sqlite3_stmt, 0), SQLite_column_text(sqlite3_stmt, 1)
	Loop
End If
' 关闭查询
SQLite_finalize sqlite3_stmt
```



基本的增删改查就是这些啦，当然，还有很多操作，比如获取记录数或执行更复杂的SQL语句。

不过这里有个小问题，在上面的更新记录代码中也能看到，UPDATE语句有些怪怪的。比如：

```sql
update tbl_user set id=?, value=? where id=?1
```

虽然还有很多怪异的语句可能会给写代码带来不便，但是不用太过担心，我在原始模块的基础上攒了个简化版的自定义类，调用这个类就可以使用正常标准的SQL语句啦！

关于这个类的内容，会在下一篇 [VB+SQLite组合，真香（二）](#) 中详细介绍，敬请期待吧！



源代码下载