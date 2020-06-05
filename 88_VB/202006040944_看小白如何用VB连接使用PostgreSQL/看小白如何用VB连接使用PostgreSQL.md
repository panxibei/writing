看小白如何用VB连接使用PostgreSQL

副标题：说得容易，做起来难~



号称世界上最高级的开源关系数据库 `PostgreSQL` ，在以前可能听说的人不多。

但是在当下却如日中天，即便还没有达到 `MySQL` 那样尽人皆知、家喻户晓的地步，至少也算是有些脸熟、略有耳闻的主流之一。

说起 `PostgreSQL` 的第一印象，往往熟知的人脑海中会浮现出一头大象，好像和 `PHP` 语言有点类似哈~

你别看大象笨重，但它是很聪明的，而 `PostgreSQL` 官方和第三方也提供了众多的接口驱动，方便我们连接使用它。

在这里，我们用古老的VB，看看如何连接 `PostgreSQL` 并使用它。

小白们看好不要眨眼哦！



#### 一、安装ODBC驱动程序

通过使用ODBC驱动程序来连接使用数据库是最简单直接的方法，想成为时间管理大师的小伙伴们都喜欢。

可惜在Win10系统下，默认是没有安装 `PostgreSQL` 的ODBC驱动的，强行连接就会报错，就像这个样子：

图1



怎么办，ODBC驱动在哪里能买到呢？

别担心，官网有下载的，不用买哦！

打开官网 `https://www.postgresql.org` ，点击顶部菜单 `Download` 。

在左侧快捷链接那边点击 `Software` ，跳转后再点击右边的 `Drivers and interfaces` 。

图2



打开了，有好多好多的程序啊，有的要钱的，有的则不要钱。

我想你肯定不是有钱人，有钱人都是让别人搞定的，对吧？

所以别选错了哦，找到 `psqlODBC` 这一项，嗯，这个是不要钱的，嘿嘿~~

图3



又打开了一个页面，啊，有好几个目录，怎么办？

呃...有个 `msi` 的目录看上去比较和蔼可亲，就选这一项。

图4



又又打开了一个页面，有一堆文件啊，不用怕，最后三个文件中选一个吧。

> psqlodbc_12_02_0000-x64.zip    # 64位驱动
>
> psqlodbc_12_02_0000-x86.zip    # 32位驱动
>
> psqlodbc_12_02_0000.zip    #64位和32位我都有

一步到位，下载最后一个文件 `psqlodbc_12_02_0000.zip`。

下载完成后解压有一个 `psqlodbc-setup.exe` 的文件，没错，运行它吧。

图5



也就点了两下鼠标，安装完成了。

打开 `控制面板` ，搜索 `odbc` ，看看 `PostgreSQL` 驱动是否OK。

有两项 `设置ODBC数据源` ，一个是32位，另一个是64位。

图7

图8



不错哦，驱动安装OK，非常简单吧。

接下来就是要连接数据库了。



#### 二、VB连接使用PostgreSQL

很多编程语言都可以连接数据库，VB当然也不例外。

最简单直接就是调用ODBC驱动程序来连接数据库，VB完全胜任。

当然，因为VB是32位的，所以，你至少要安装好32位的ODBC驱动程序。

刚刚我们已经安装好了 `PostgreSQL` 的ODBC驱动程序，那么使用VB怎么连接呢？

基本的连接代码字符串如下：

```vb
"Driver=PostgreSQL Unicode;Server=x.x.x.x;Port=5432;Database=dbname;Uid=postgres;Pwd=12345678;"
```

具体怎么做，我已经做成了一个演示程序。

里面基本的增删改查已经模块化，具体可以参考里面的源代码。（后面有下载）

随便举个例子：

```vb
' 定义变量
Dim rs As ADODB.Recordset, strSql As String, strMsg As String
  
' 构建SQL查询字符串
strSql = "select * from pgSchema" & "." & "pgTable"

' 调用SELECT查询模块
Set rs = SelectSQL(strSql, strMsg)

' 填充数据
Set DataGrid1.DataSource = rs
```

图9演示图



**可能会出现的问题：**

在使用演示程序时，可能会出现如下报错提示。

图10



这是因为程序使用了 `DataGrid` 控件，它是用来展示数据的。

而单纯注册 `DataGrid` 控件自身还不能解决错误，还需要注册另一个动态库 `msstdfmt.dll` ，应该像这个样子：

```powershell
regsvr32 msdatgrd.ocx
regsvr32 msstdfmt.dll
```



现如今越来越多的人开始使用 `PostgreSQL` ，而作为只熟悉VB的古董玩家，也同样可以享受地表最强数据库带来的爽快感。

本文旨在为新手小白们入门带路， 同时也为VB老玩家们抛砖引玉，希望能带给你们些许助益。

快快关注我的微信公众号@网管小贾，要不我除了搬砖还得去摆摊儿，谢谢你们！



---

**以下演示数据库的导入方法，其中有网管小贾的靓照哦！**

下载文件后解压，使用以下命令导入 `PostgreSQL` 数据库。

```
# postgres是你的用户名
# db: database1 | schema: schema1 | table: table1
psql -Upostgres database1 < database1.sql
```

下载链接：https://o8.cn/uCQgae 密码：0u74