VB+Sqlite组合，真香！（二）

副标题：对，还是那个味！



上文书我们说到 `VB+SQLite` 组合带给我们单机数据库应用的光明前景。

什么？上一篇还没有看？

好吧，给你链接，省得找了。

链接：

咳咳，虽然解决了单机访问数据库速度和品质的问题，但原始代码还是有点不够简单和人性化。

这不，我研究了一下，搞了一个简单版的自定义类，方便调用。



调用这个类很简单，只要先New个对象，再给些参数即可完成任务。

完成任务后释放对象即可，全程不再需要自己先打开数据库再关闭等等额外的复杂操作。

超级简便有木有？

另外，SQL语句也可以保持标准语法，不用记住那些特殊怪异的单词和符号啦。

好，快来看看接下来的实例吧。



1、查询记录

```vb
' 自定义类
Dim objSQLite As New ClsSQLite

'定义数据库文件路径
objSQLite.p_DbFilePath = App.Path & "\user.db"
    
'定义SQL语句，此处可设定textbox为任意SQL语句
objSQLite.p_Sql = "select * from tbl_user where id > 1"
    
'执行语句
If objSQLite.SelectSQL = False Then
    MsgBox "查询失败！" & vbCrLf & vbCrLf & objSQLite.p_Msg
Else
    MsgBox "查询成功！" & vbCrLf & vbCrLf & objSQLite.p_Msg
    MsgBox "字段数: " & objSQLite.p_ColumeCount
    MsgBox "记录数: " & objSQLite.p_RecordCount
        
    Dim i As Long, j As Long
    Dim intColumeCount As Long, intRecordCount As Long
    
    intColumeCount = objSQLite.p_ColumeCount - 1
    intRecordCount = objSQLite.p_RecordCount - 1
        
    '字段名称遍历
    For i = 0 To intColumeCount
        MsgBox objSQLite.p_RecordSetField(i)
    Next
        
    '记录值遍历
    For j = 0 To intRecordCount
        For i = 0 To intColumeCount
            MsgBox objSQLite.p_RecordSetValue(j, i)
        Next
    Next
        
End If

' 释放对象
Set objSQLite = Nothing
```



2、更新记录

```vb
' 自定义类
Dim objSQLite As New ClsSQLite

'定义数据库文件路径
objSQLite.p_DbFilePath = App.Path & "\user.db"
    
'定义SQL语句，此处可设定textbox为任意SQL语句
objSQLite.p_Sql = "update tbl_user set value='" & txtUpdateItem2.Text & "' where id=" & txtUpdateItem1.Text
    
'执行语句
If objSQLite.ExecuteSQL = False Then
    MsgBox "更新失败！" & vbCrLf & vbCrLf & objSQLite.p_Msg
Else
    MsgBox "更新成功！" & vbCrLf & vbCrLf & objSQLite.p_Msg
End If
    
' 释放对象
Set objSQLite = Nothing
```



3、批量执行SQL语句之一

```vb
' 自定义类
Dim objSQLite As New ClsSQLite

'定义数据库文件路径
objSQLite.p_DbFilePath = App.Path & "\user.db"
    
'批量SQL语句，用分号相隔
'objSQLite.p_Sql = "update tbl_user set value='J055555555' where id=5;update tbl_user set value='K066666666' where id=6;insert into tbl_user(id,value) values(9,'ABC123')"
'objSQLite.BatchExecuteSql
    
'单独SQL语句
objSQLite.p_Sql = "insert into tbl_user(id,value) values(8,'88888888')"
objSQLite.ExecuteSQL
    
MsgBox objSQLite.p_Msg
    
' 释放对象
Set objSQLite = Nothing
```



4、批量执行SQL语句之二

```vb
' 自定义类
Dim objSQLite As New ClsSQLite

'定义数据库文件路径
objSQLite.p_DbFilePath = App.Path & "\user.db"
    
'定义批量SQL语句------定义数组上限
objSQLite.p_BatchSqlUbound = 3
    
'定义批量SQL语句------定义各语句
Dim i As Integer
For i = 0 To 3
	objSQLite.p_BatchSql(i) = "INSERT into tbl_user(id, value) values(" & i + 10 & ",'xxxxxxxx')"
Next
objSQLite.BatchExecuteSql
    
MsgBox objSQLite.p_Msg

' 释放对象
Set objSQLite = Nothing
```



基本的CRUD都可以用了，调用SQL大概分为 `SELECT` 和 `EXECUTE` 两种方式。

`SQLite`自定义类的文件名是 `ClsSQLite.cls` ，下载链接：

链接

注意了，这个类文件需要以上一篇的程序为基础才能使用，单独使用无效。

上一篇文章链接：



另外抱歉哈！由于站长工作繁忙时间紧张，没有放出完整的程序。

如有需要请留言给我，我会再抽时间制作。

最后，真心希望以上内容能帮到你！

好，老板喊我去搬砖了...... 拜拜......