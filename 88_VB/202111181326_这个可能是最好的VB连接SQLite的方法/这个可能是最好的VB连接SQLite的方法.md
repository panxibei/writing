这个可能是最好的VB连接SQLite的方法

副标题：VB连接SQLite，这个方法更牛~

英文：this-is-probably-the-best-way-to-connect-sqlite-with-vb

关键字：sqlite,vb,vb6,数据库,vbrichclient



关注我的小伙伴可能知道，去年我曾写过一篇关于如何用 `VB` 连接操作 `SQLite` 的文章。

方法超级简单，就是单纯用一个 `DLL` 文件，然后代码调用就可以实现，新手都很容易上手。

这种方法的优点是，简单到根本不需要注册 `DLL` 库文件或其他额外多余的操作，直接代码调用操作，而且代码也非常直白容易理解，堪称绝对的小白界福音！

一共两篇文章，可以到网管小贾的博客中搜索，演示代码也提供免费下载，供有缘人研究哈。



> 1.《VB+SQLite组合，真香！（一）》
>
> 文章链接：https://www.sysadm.cc/index.php/vbbiancheng/721-vb-sqlite#comment-3056
>
> 2.《VB+SQLite组合，真香！（二）》
>
> 文章链接：https://www.sysadm.cc/index.php/vbbiancheng/723-vb-sqlite-2



其中第一篇是针对如何操作使用 `DLL` 的具体代码写法演示，而第二篇则是我在第一篇演示代码基础上改造创建了一个自定义类模块，代码更加精简，使用更加方便。

不过前不久有位爱钻研的小伙伴给我出了一道难题，他在测试过程中发现，通过操作这个 `SQLite.DLL` 的代码有时会无法正常连接到某度网盘的缓存数据库文件。

我收到反馈后立刻展开了研究，经过几天的测试，我这才发现，这种方法似乎有个比较尴尬却又算不上 `BUG` 的坑。

那就是，如果数据库文件在比较大的情况下，它就会连接失败！

到底文件上限是多大，到底是否真的存在这样的问题，到底还有没有其他的 `BUG` ，说实话我也不太清楚。

因为这些演示代码是10多年前我在某个网站上偶然获得的，出处早已不可考了。

现在仅仅知道的线索是，这个 `SQLite.DLL` 可能是由 `Dephi` 编译构建的。

我猜测可能其中有参数针对文件大小读入的限制。

当然，目前仅仅只是猜测而已。



不好意思，这里插播一条补充说明。

在行文的后续，我又查了不少资料，类似的 `SQLite.DLL` 文件其实是可通过修改编译 `SQLite` 源代码来生成符合 `VB` 调用的动态库文件的。

之前使用的这个文件也不例外，现在怀疑是其版本太老，不支持较大文件或较高版本 `SQLite` 数据库的读写。

至于具体的编译方法，有兴趣的小伙伴可以留言给我，我会把相关资料分享给大家。

反正吧，我研究了半天也没有编译成功，可以说至少需要你具备一些 `C/C++` 语言的功底才行，否则几百个错误和警告就搞自己头昏眼花了。



好了，插播完毕！

对于这么好用的一个库文件居然存在这么大一个坑，我当时就感觉真的是非常非常对不起小伙伴们，在此深表内疚和遗憾。

经过我数天的努力研究，找到三种不同的 `VB` 连接 `SQLite` 的方法。

这三种不同的方法都能实现对某度网盘大容量缓存文件的读写。

不过这三种方法中，我感觉最靠谱最强大的还是最后一个，通过 `vbRichClient` 来实现的方法。

因此，为了节省大家的时间，本文就重点给小伙伴们分享这个最好的方法吧。



话说虽然不如前面文章中的那个使用 `SQLite.DLL` 库文件的连接方法简便 `easy` ，但这种方法也只要注册一下 `DLL` 文件即可开始使用。

并且更令人兴奋的是，它还包含了其他非常强大的操纵 `SQLite` 的功能，比如存取 `blob` 类型数据等等。

下面我就贴一些我整理过后的基本演示代码吧。

图01



### 使用前注册 `DLL` 文件

注册一下 `DLL` 文件也不算什么麻烦事吧，就算是制作安装包时，也可以顺便给注册了。

虽然我们需要用到两个 `DLL` 文件（`cairo_sqlite.dll` 和 `rc6.dll` ），但其实只要注册一个就OK了。

```
# 管理员权限下执行，注册 RC6.dll
Regsvr32.exe RC6.dll

# 如果不想用了，可以取消注册 rc6.dll
Regsvr32.exe RC6.dll /u
```



### 基本的增删改查操作

##### 连接并打开数据库

给定 `DB` 文件路径，通过 `OpenRecordset` 方法即可开启连接并获取记录集。

```
DBName = App.path & "\database.db"

Set Cnn = New_c.Connection
Cnn.OpenDB DBName

Set Rs = Cnn.OpenRecordset("SELECT * FROM table")
MsgBox "数据库被成功打开！共有记录数：" & Rs.RecordCount, vbInformation
```



##### 查询

有了前面的数据集 `Rs` ，我们就可以列出字段名称和相应的记录值了。

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



##### 插入

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



##### 更新

同样使用 `SQL` 语句即可完成数据更新操作。

```
strSQL = "UPDATE Employees " & _
    "SET LastName='史蒂夫'," & _
    "FirstName='乔布斯'," & _
    "Title='苹果创始人' " & _
    "WHERE EmployeeID=" & txtEmployeeID.Text

lngResult = Cnn.Execute(strSQL)
```



##### 删除

删除最简单了，单纯就是给定 `SQL` 语句了。

```
strSQL = "DELETE FROM Employees " & _
	"WHERE EmployeeID=" & intEmployeeID

lngResult = Cnn.Execute(strSQL)
```



至此，基本的增删改查操作已经没有什么问题了，我们从代码上也能看出来，超级简单有木有？

好了，在完成简单的增删改查后，如果还需要 `SQLite` 支持的更高级的一些操作，比如操作 `blob` 类型字段，那我们应该怎么办呢？

好办，往下看！



### 其他高级操作

现在的 `SQLite` 版本已经很高了，支持功能比数年前强大了不少。

诸如存取照片等功能，我们通过代码操作 `SQLite` 已经变成了现实，这在此之前的文章中似乎还做不到。

至于文章开头所说的数据库文件大小限制的尴尬问题，在使用这个方法后也被顺利化解不复存在了。



在此处的示例中，需要用到几个用户自定义控件和类模块，用于控制显示照片。

图02.GIF



具体用户控件如何操作，还是请仔细研读代码吧，我就不在这儿一一列出了，文末有源码下载。



### 写在最后

说到这儿，我想呼叫一下上次联系我的小伙伴，因为公众号回复有48小时的时限，所以时间过期后我就无法回复导致失联了。

因此希望这位小伙伴看到后，如果想要了解更多，我会把另外两个方法分享出来。

在此我也感谢小伙伴们与我沟通联系，真心希望你们每天进步多一点，快乐也多一点！



**网管小贾的VB+SQLite演示程序.7z(2.72M)**

下载链接：https://pan.baidu.com/s/1FYOu7YvJDHkPGNv89jdltw

提取码：n2vt



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc