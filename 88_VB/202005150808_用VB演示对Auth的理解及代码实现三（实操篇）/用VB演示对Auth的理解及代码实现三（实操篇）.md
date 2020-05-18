用VB演示对Auth的理解及代码实现三（实操篇）

副标题：把理论应用到伟大的实践中去吧



> 微信公众号：@网管小贾
>
> 个人博客：@www.sysadm.cc



前两篇关于Auth权限控制，从提出问题到分析理论，实际上已经说得差不多了。

接下来就是具体代码实现，当然了使用任何编程语言都可以实现，只是我用我熟悉的VB来做。

多说一句，大部分现代高级编程语言实际上有很多框架都已经包含了Auth权限的实现机制。

而VB比较古老，不是很现代化，所以需要我们手动实现，在以后的项目中权限问题是绕不开的问题，搞明白会很有用的哦！

我们现在来点实在的做做看，说不定毕业设计中也会用到啊！



> 前文导读：
>
>  [《用VB演示对Auth的理解及代码实现一（引言篇）》](#) 
>
>  [《用VB演示对Auth的理解及代码实现二（理论篇）》](#) 



好，我们先回顾一下需求：

> 居所和主子、丫环们的关系：
>
> | 序号 | 房子   | 主人 | 丫鬟                   |
> | ---- | ------ | ---- | ---------------------- |
> | 1    | 怡红院 | 宝玉 | 袭人、晴雯、麝月、秋纹 |
> | 2    | 潇湘馆 | 黛玉 | 雪雁、紫鹃             |
> | 3    | 蘅芜苑 | 宝钗 | 莺儿                   |
>
> 权限说明：
>
> 1. 各房子的主人可自由出入每个房子。
> 2. 自家丫鬟只可出入自家房子。
> 3. 袭人、晴雯可以出入潇湘馆。
> 4. 莺儿可以出入怡红院。



具体实现：

#### 一、创建三张实物表和两张关系表

1、创建用户表（user）

```sqlite
CREATE TABLE [user](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL, 
  [password] VARCHAR NOT NULL, 
  [status] TINYINT NOT NULL DEFAULT 1);
```

2、创建角色表（role）

```sqlite
CREATE TABLE [role](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL);
```

3、创建权限表（permission）

```sqlite
CREATE TABLE [permission](
  [id] INTEGER PRIMARY KEY AUTOINCREMENT, 
  [name] VARCHAR NOT NULL);
```

4、创建用户和角色关系表

```sqlite
CREATE TABLE [user_role](
  [uid] INTEGER NOT NULL, 
  [rid] INTEGER NOT NULL);
```

5、创建角色和权限关系表

```sqlite
CREATE TABLE [role_permission](
  [rid] INTEGER NOT NULL, 
  [pid] INTEGER NOT NULL);
```



#### 二、填充数据

1、用户表

```sqlite
INSERT INTO "user" (name,password,status) VALUES (
'宝玉','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'黛玉','12345678',1);
INSERT INTO "user" (name,password,status) VALUES (
'宝钗','123456',1);
INSERT INTO "user" (name,password,status) VALUES (
'袭人','888',1);
INSERT INTO "user" (name,password,status) VALUES (
'晴雯','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'麝月','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'秋纹','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'雪雁','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'紫鹃','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'莺儿','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'素云','123',1);
INSERT INTO "user" (name,password,status) VALUES (
'司棋','123',1);
```

2、角色表

```sqlite
INSERT INTO "role" (name) VALUES (
'怡红院通行证');
INSERT INTO "role" (name) VALUES (
'潇湘馆通行证');
INSERT INTO "role" (name) VALUES (
'蘅芜苑通行证');
INSERT INTO "role" (name) VALUES (
'稻香村通行证');
INSERT INTO "role" (name) VALUES (
'紫菱洲通行证');
```

3、权限表

```sqlite
INSERT INTO permission (name) VALUES (
'怡红院');
INSERT INTO permission (name) VALUES (
'潇湘馆');
INSERT INTO permission (name) VALUES (
'蘅芜苑');
INSERT INTO permission (name) VALUES (
'稻香村');
INSERT INTO permission (name) VALUES (
'紫菱洲');
INSERT INTO permission (name) VALUES (
'秋爽斋');
INSERT INTO permission (name) VALUES (
'藕香榭');
```

4、用户和角色关系表

```sqlite
INSERT INTO user_role (uid,rid) VALUES (
1,1);
INSERT INTO user_role (uid,rid) VALUES (
1,2);
INSERT INTO user_role (uid,rid) VALUES (
1,3);
INSERT INTO user_role (uid,rid) VALUES (
2,1);
INSERT INTO user_role (uid,rid) VALUES (
2,2);
INSERT INTO user_role (uid,rid) VALUES (
2,3);
INSERT INTO user_role (uid,rid) VALUES (
3,1);
INSERT INTO user_role (uid,rid) VALUES (
3,2);
INSERT INTO user_role (uid,rid) VALUES (
3,3);
INSERT INTO user_role (uid,rid) VALUES (
4,1);
INSERT INTO user_role (uid,rid) VALUES (
4,2);
INSERT INTO user_role (uid,rid) VALUES (
5,1);
INSERT INTO user_role (uid,rid) VALUES (
5,2);
INSERT INTO user_role (uid,rid) VALUES (
6,1);
INSERT INTO user_role (uid,rid) VALUES (
7,1);
INSERT INTO user_role (uid,rid) VALUES (
10,1);
INSERT INTO user_role (uid,rid) VALUES (
10,3);
INSERT INTO user_role (uid,rid) VALUES (
9,2);
INSERT INTO user_role (uid,rid) VALUES (
8,2);
```

5、角色和权限关系表

```sqlite
INSERT INTO role_permission (rid,pid) VALUES (
2,2);
INSERT INTO role_permission (rid,pid) VALUES (
1,1);
INSERT INTO role_permission (rid,pid) VALUES (
3,3);
```



#### 三、部分代码举例

演示程序界面：

图1



如下，是基本的操作。

1、查询用户当前拥有的角色

```vb
    '自定义类
    Dim objSQLite As New ClsSQLite
    Dim j As Long, intRecordCount As Long

    '定义数据库文件路径
    objSQLite.p_DbFilePath = App.Path & "\Auth.db"
    
    lstUserRoleCurrent.Clear
     
    '查询用户拥有角色
    objSQLite.p_Sql = "SELECT c.id, c.name FROM user_role AS A INNER JOIN user AS B ON a.uid=b.id INNER JOIN role AS C ON a.rid=c.id WHERE b.id='" & getIdString(txtUserUser.Text) & "'"
    
    '执行语句
    If objSQLite.SelectSQL = False Then
        MsgBox "查询失败！" & vbCrLf & vbCrLf & objSQLite.p_Msg
    Else
        If objSQLite.p_RecordCount = 0 Then GoTo goEnd
    
        intRecordCount = objSQLite.p_RecordCount - 1
        
        '记录值遍历
        For j = 0 To intRecordCount
            lstUserRoleCurrent.AddItem objSQLite.p_RecordSetValue(j, 0) & "|" & objSQLite.p_RecordSetValue(j, 1)
        Next
        
    End If

goEnd:
    ' 释放对象
    Set objSQLite = Nothing
```

2、更新用户的角色

```vb
    '自定义类
    Dim objSQLite As New ClsSQLite
    Dim strSql As String

    '定义数据库文件路径
    objSQLite.p_DbFilePath = App.Path & "\Auth.db"
    
    '删除原有权限
    strSql = "DELETE FROM user_role WHERE uid IN (SELECT id FROM user WHERE id='" & getIdString(txtUserUser.Text) & "')"
    objSQLite.p_Sql = strSql
    objSQLite.ExecuteSQL
    
    '追加权限
    '通过SendMessage查询listbox中选中的项目
    Dim ItemIndexes() As Long, x As Integer, iNumItems As Integer
    iNumItems = lstUserRole.SelCount
    If iNumItems Then
        ReDim ItemIndexes(iNumItems - 1)
        SendMessage lstUserRole.hwnd, LB_GETSELITEMS, iNumItems, ItemIndexes(0)
    End If
    
    '定义批量SQL语句------定义数组上限
    objSQLite.p_BatchSqlUbound = iNumItems - 1

    For x = 0 To iNumItems - 1
        strSql = "INSERT INTO user_role "
        strSql = strSql & " (rid, uid) VALUES(" & getIdString(lstUserRole.List(ItemIndexes(x))) & ", " & getIdString(txtUserUser.Text) & ")"

        objSQLite.p_BatchSql(x) = strSql
    Next
    objSQLite.BatchExecuteSql

    '刷新显示当前用户的权限
    Call cmdUserRole_Click
    
    '清除选定状态
    Dim i As Integer
    For i = 0 To lstUserRole.ListCount - 1
        lstUserRole.Selected(i) = False
    Next

goEnd:

    ' 释放对象
    Set objSQLite = Nothing
```

3、查询角色拥有权限

```vb
    ' 自定义类
    Dim objSQLite As New ClsSQLite
    Dim j As Long, intRecordCount As Long

    '定义数据库文件路径
    objSQLite.p_DbFilePath = App.Path & "\Auth.db"
    
    lstRolePermissionCurrent.Clear
    
    '查询角色拥有权限
    objSQLite.p_Sql = "SELECT c.id, c.name FROM role_permission AS A INNER JOIN role AS B ON a.rid=b.id INNER JOIN permission AS C ON a.pid=c.id WHERE b.id='" & getIdString(txtRoleRole.Text) & "'"
    
    '执行语句
    If objSQLite.SelectSQL = False Then
        MsgBox "查询失败！" & vbCrLf & vbCrLf & objSQLite.p_Msg
    Else
        If objSQLite.p_RecordCount = 0 Then GoTo goEnd
    
        intRecordCount = objSQLite.p_RecordCount - 1
        
        '记录值遍历
        For j = 0 To intRecordCount
            lstRolePermissionCurrent.AddItem objSQLite.p_RecordSetValue(j, 0) & "|" & objSQLite.p_RecordSetValue(j, 1)
        Next
        
    End If

goEnd:
    ' 释放对象
    Set objSQLite = Nothing
```

4、更新角色的权限

```vb
    ' 自定义类
    Dim objSQLite As New ClsSQLite
    Dim strSql As String

    '定义数据库文件路径
    objSQLite.p_DbFilePath = App.Path & "\Auth.db"
    
    '删除原有权限
    strSql = "DELETE FROM role_permission WHERE rid IN (SELECT id FROM role WHERE id='" & getIdString(txtRoleRole.Text) & "')"
    objSQLite.p_Sql = strSql
    objSQLite.ExecuteSQL
            
    '追加权限
    '通过SendMessage查询listbox中选中的项目
    Dim ItemIndexes() As Long, x As Integer, iNumItems As Integer
    iNumItems = lstRolePermission.SelCount
    If iNumItems Then
        ReDim ItemIndexes(iNumItems - 1)
        SendMessage lstRolePermission.hwnd, LB_GETSELITEMS, iNumItems, ItemIndexes(0)
    End If
    
    '定义批量SQL语句------定义数组上限
    objSQLite.p_BatchSqlUbound = iNumItems - 1

    For x = 0 To iNumItems - 1
        strSql = "INSERT INTO role_permission "
        strSql = strSql & " (pid, rid) VALUES(" & getIdString(lstRolePermission.List(ItemIndexes(x))) & ", " & getIdString(txtRoleRole.Text) & ")"

        objSQLite.p_BatchSql(x) = strSql
    Next
    objSQLite.BatchExecuteSql

    '刷新显示当前用户的权限
    Call cmdRolePermission_Click
    
    '清除选定状态
    Dim i As Integer
    For i = 0 To lstRolePermission.ListCount - 1
        lstRolePermission.Selected(i) = False
    Next

goEnd:

    ' 释放对象
    Set objSQLite = Nothing
```

5、测试权限（重点）

```vb
    Dim strPermissionId As String, strSql As String

    ' 自定义类
    Dim objSQLite As New ClsSQLite

    '定义数据库文件路径
    objSQLite.p_DbFilePath = App.Path & "\Auth.db"
    
    '取出当前模块的权限，如Permission1。
    strSql = "SELECT id FROM permission WHERE name='" & Trim(txtTestPermission.Text) & "'"
    objSQLite.p_Sql = strSql
    
    '执行语句
    If objSQLite.SelectSQL = False Then
        MsgBox "查询失败！" & vbCrLf & vbCrLf & objSQLite.p_Msg: GoTo goEnd
    Else
        
        If objSQLite.p_RecordCount = 0 Then
            MsgBox "用户 " & Trim(txtTestUser.Text) & " 没有 " & Trim(txtTestPermission.Text) & " 权限！", vbCritical + vbOKOnly
            GoTo goEnd
        End If
    
        strPermissionId = objSQLite.p_RecordSetValue(0, 0)
        
    End If

    '查询当前用户所拥有哪些组和哪些权限。每个组的权限遍历一次，与当前权限对比。
    strSql = "SELECT id FROM permission WHERE id IN ("
    strSql = strSql & " SELECT pid FROM role_permission WHERE rid IN ("
    strSql = strSql & " SELECT rid FROM user_role WHERE uid = ("
    strSql = strSql & " SELECT id FROM user WHERE name='" & Trim(txtTestUser.Text) & "')))"
    objSQLite.p_Sql = strSql
    
    '执行语句
    If objSQLite.SelectSQL = False Then
        MsgBox "查询失败！" & vbCrLf & vbCrLf & objSQLite.p_Msg: GoTo goEnd
    Else
    
        If objSQLite.p_RecordCount = 0 Then
            MsgBox "用户 " & Trim(txtTestUser.Text) & " 没有 " & Trim(txtTestPermission.Text) & " 权限！", vbCritical + vbOKOnly
            GoTo goEnd
        Else
            Dim j As Long, intRecordCount As Long, booFlag As Boolean
    
            intRecordCount = objSQLite.p_RecordCount - 1
            booFlag = False
            
            '记录值遍历
            For j = 0 To intRecordCount
                If strPermissionId = objSQLite.p_RecordSetValue(j, 0) Then
                    booFlag = True: Exit For
                End If
            Next
            
            If booFlag = False Then
                MsgBox "用户 " & Trim(txtTestUser.Text) & " 没有 " & Trim(txtTestPermission.Text) & " 权限！", vbCritical + vbOKOnly
            Else
                MsgBox "用户 " & Trim(txtTestUser.Text) & " 拥有 " & Trim(txtTestPermission.Text) & " 权限！", vbInformation + vbOKOnly
            End If

        End If
    
    End If

goEnd:

    ' 释放对象
    Set objSQLite = Nothing
```





由于我之前写的 [VB+Sqlite组合，真香！（二）](#) 文章中，用自己写的自定义类把操作SQLite大大地简化了。

所以这里的代码大同小异，非常容易看懂，如果还不理解就多看几遍，学习编程还是要多看代码啊。



如果直接看代码可能会有点晕，那咱先举例操作一下看看。

简单的增删改查就不多说了，当然还是拿袭人做例子。

按照权限需要，她应该有两张通行证，分别是**怡红院**和**潇湘馆**。

那么她就会......



#### 一、袭人发现自己没有任何通行证，于是过来领了两张通行证。

**查询并更新用户拥有的角色。**

我们先找到袭人的ID是4，查询一下她拥有的角色。

发现她当前没有任何通行证，选择 `怡红院通行证` 和 `潇湘馆通行证` ，点击 `更新用户角色`。

图2



#### 二、要让通行证有效，必须把通行证与房子关联起来。

**查询并更新角色拥有的权限。**

分别给 `怡红院通行证` 和 `潇湘馆通行证` 赋予相应的权限。

图3



#### 三、为保证通行证无误，拿着通行证试试能不能进入房子。

**测试权限是否正确。**

在程序界面左上角，有相应的测试项目。

输入用户名称和权限名称，可任意测试当前用户是否具有给定的权限。

另外，也可以测试具体权限，比如 `怡红院` 等。

可以看得出，Auth权限控制可以细化到一个按钮。



完成以上三步，袭人姐姐基本就可以自由出入了，很简单吧？

其他人也如法炮制，大观园的各位都顺利拿到对应的通行证。

这下刘姥姥再来，也不怕她乱撞了，宝二爷肯定得赏我了，哇咔咔！



另外，程序实现还有一些补充说明：

1、代码经过简化，目的是为了方便理解原理并最终能应用到实际中。

2、在更新等操作中，应该使用事务。

3、演示程序中操作一般以数据项ID为基准，请确保不要搞混了。

4、Auth权限控制可细化到一个按钮或一个文本框，而且，权限设定灵活，不仅可以固定写在代码中，还可以动态地体现在数据库中。



最后给出下载演示程序：







> 微信公众号：@网管小贾
>
> 个人博客：@www.sysadm.cc

