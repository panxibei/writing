另一种非常强大的VB连接SQLite的方法

副标题：

英文：

关键字：



在去年我曾写过一篇关于如何用 `VB` 连接操作 `SQLite` 的文章。

方法超级简单，就是用一个 `DLL` 文件就能实现了，新手都很容易上手。

这种方法简单到根本不需要注册库文件等额外多余的操作，直接代码操作，堪称小白福音啊！

一共两篇文章，可以到网管小贾的博客中搜索。



> 1.《VB+SQLite组合，真香！（一）》
>
> 文章链接：https://www.sysadm.cc/index.php/vbbiancheng/721-vb-sqlite#comment-3056
>
> 2.《VB+SQLite组合，真香！（二）》
>
> 文章链接：https://www.sysadm.cc/index.php/vbbiancheng/723-vb-sqlite-2



其中第一篇是针对如何操作使用 `DLL` 的具体代码写法演示，而第二篇则是我在第一篇演示代码基础上改造创建了一个自定义类模块，方便精简代码，更易于使用。

不过前不久有位小伙伴给我出了一道难题，他在测试过程中发现，通过操作这个 `SQLite.DLL` 的代码无法正常连接到某度网盘的缓存数据库文件。

我收到反馈后立刻展开了研究，经过几天的测试，我这才发现，这种方法似乎有个比较尴尬的却又算不上 `BUG` 的坑。

那就是，如果数据库文件在比较大的情况下，它就会连接失败。

具体文件多大是个限制，具体是否真的存在这样的问题，具体还有没有其他的 `BUG` ，说实话我也不太清楚。

因为这些演示代码是10多年前我在某个网站上偶然获得的，出处早已不可考了。

现在仅仅知道的线索是，这个 `SQLite.DLL` 是由 `Dephi` 编译构建的。

我猜测可能其中有参数针对文件大小读入的限制。

当然，目前仅仅只是猜测而已。



对于这么好用的一个库文件居然存在这么一个坑，我感觉真的是非常遗憾。

不过最后却有一个好消息要告诉小伙伴们，我又研究出另一种非常强大的方法。

虽然不如前面那个库文件的连接方法 `easy` ，但这种方法也只要注册一下 `DLL` 文件即可开始使用。

并且更令人兴奋的是，它还包含了很强大的其他操纵 `SQLite` 的功能，比如存取 `blob` 类型数据等。

下面我就贴一些我整理过后的基本演示代码吧。

图a01



### 连接并打开数据库

给定 `DB` 文件路径，通过 `OpenRecordset` 方法即可开启连接并获取记录集。

```
DBName = App.path & "\database.db"

Set Cnn = New_c.Connection
Cnn.OpenDB DBName

Set Rs = Cnn.OpenRecordset("SELECT * FROM table")
MsgBox "数据库被成功打开！共有记录数：" & Rs.RecordCount, vbInformation
```



### 查询

有了前面的数据集，我们就可以列出字段名称和相应的记录值了。

```
' 列出表字段名称
For i = 0 To intFieldsCount
    picData.Print Rs.Fields(i).Name
Next

' 输出记录值，字段数组索引可以用数值也可以用字段名称
Do While Not Rs.EOF
	picData.Print Rs.Fields(0).Value, Rs.Fields(1).Value, Rs.Fields("LastName").Value
	Rs.MoveNext
Loop
```



### 插入

使用 `SQL` 语句即可完成数据插入操作。

```
Rs.MoveLast
intLastRow = Rs.Fields("EmployeeID").Value + 1

strSQL = "INSERT INTO Employees (EmployeeID,LastName,FirstName,Title) VALUES (" & _
    intLastRow & ", '" & _
    "比尔" & "', '" & _
    "盖茨" & "', '" & _
    "微软创始人" & "')"

lngResult = Cnn.Execute(strSQL)
```



### 更新

同样使用 `SQL` 语句即可完成数据更新操作。

```
strSQL = "UPDATE Employees " & _
    "SET LastName='史蒂夫'," & _
    "FirstName='乔布斯'," & _
    "Title='苹果创始人' " & _
    "WHERE EmployeeID=" & txtEmployeeID.Text

lngResult = Cnn.Execute(strSQL)
```



### 删除

删除最简单了，单纯就是给定 `SQL` 语句了。

```
strSQL = "DELETE FROM Employees " & _
	"WHERE EmployeeID=" & intEmployeeID

lngResult = Cnn.Execute(strSQL)
```



其他操作，诸如照片等，凡是 `SQLite` 支持的操作基本都可以实现了。

至于文章开头所说的数据库文件大小限制的尴尬问题，在使用这个方法后也顺利地化解掉了。

