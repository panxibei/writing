同一台电脑上不通过网络，如何做到两个程序之间畅快通话？VB的DDE会话介绍

副标题：

英文：

关键字：



这个标题是啥意思？

简单地说，就是两个独立的 `APP` 之间实现互通，不用网络是因为都在同一台电脑上。

有小伙伴会说，那这种功能有什么用啊？

哎，其实用处非常大，通常管这玩意叫做 `DDE` 。



`DDE` ，专业词汇，说白了就是是一种动态数据交换机制，英文 `Dynamic Data Exchange` 的缩写。

实际所谓的程序间的互通就是一些数据的通信传输。

这在网络还不是很发达的时候非常有用，当时网络发达了也还是有用的，至少你不用费劲建立网络连接嘛！

在 `VB` 中就可以使用对象的 `Link` 操作。



##### `DDE` 的工作原理

两个同时运行的程序间通过 `DDE` 方式交换数据时是 `客户端/伺服器` 关系。

一旦客户端和伺服器建立起来连接关系，则当伺服器中的数据发生变化后就会马上通知客户端。

通过 `DDE` 方式建立的数据连接通道是双向的，即客户端不但能够读取伺服器中的数据，而且还可以对其进行修改。



##### 交换方式

1. 冷连接（ `CoolLink` ）：数据交换是一次性数据传输，与剪贴板相同。

   当服务器中的数据发生变化后不通知客户端，但客户端可以随时从服务器读写数据；

2. 温连接（ `WarmLink` ）：当服务器中的数据发生变化后马上通知客户端，客户端得到通知后将数据取回；

3. 热连接（ `HotLink` ）：当服务器中的数据发生变化后马上通知客户端，同时将变化的数据直接送给客户端。

可以看得出来，随着热度不断地上升，服务器的主动性越来越强，客户端获取数据的方式也发生了变化。



`DDE` 客户程序向 `DDE` 服务器程序请求数据时，它必须首先知道服务器的名称（即 `DDEService` 名）、`DDE` 主题名称（ `Topics` 名），还要知道请求哪一个数据项的项目名称（ `Items` 名）。

`DDEService` 名应该具有唯一性，否则容易产生混乱。

图a01



##### `DDE` 会话基本设计

发送方设置：

这里用 `Control` 代表窗体中发送 `DDE` 会话的某控件，比如 `TextBox` 、`Label` 等。

示例代码：

```
Control.LinkMode = 0
Control.LinkTopic = "Program1|Form1"    ' 文件名|窗体名
Control.LinkItem = "Text1"              ' 控件名
Control.LinkMode = Mode                 ' 0（断开），1（自动），2（手动），3（通知）

Control.LinkPoke                        '发送源程序控件Control的字符到本程序的Text1中
Control.LinkRequest                     '源程序将本程序Text1字符取回放入Control
Control.LinkExecute Cmd                 '触发本标程序的Form_LinkExecute事件
```



接收方设置：

必须在设计状态下设置本程序的窗口属性：`LinkMode = 1` 。

图a02



在 `Form_LinkExecute` 事件中接收发送程序发出的 `DDE` 会话消息。

```
Private Sub Form_LinkExecute(CmdStr As String, Cancel As Integer)
    ......
End Sub
```



##### `DDE` 会话的事件

1. `LinkClose` 事件

   `DDE` 对话结束。

2. `LinkError (linkerr As Integer)` 事件

   `DDE` 对话出错。

3. `LinkExecute (cmdstr As String, cancel As Integer)` 事件

   当一个 `DDE` 对话中的命令字符串由一个接收端应用程序发出时而发生的。

4. `LinkOpen (cancel As Integer)` 事件

   `DDE` 对话正在启动时。

5. `LinkNotify` 事件

   如果接收端控件的 `LinkMode` 属性被设置为 `3`（通知），当发送端已经改变了由 `DDE` 链接定义的数据时，此事件发生。



##### `DDE` 会话的有关属性

1. `LinkTimeout [ = Number]` 属性

   返回或设置等待 `DDE` 响应消息的时间。
   缺省为 `50`（相当于 `5` 秒），最大等待时间长度为 `65,535` 个十分之一秒，或大约为 `1` 时 `49` 分钟。

2. `LinkItem [ = String]` 属性

   返回或设置传给接收端的数据。

3. `LinkTopic [ = value]` 属性

   对于接收端控件－返回或设置发送端应用程序和主题。

4. `LinkMode [ = Number]` 属性

   `DDE` 会话方式。



对于 `DDE` 会话中用做目标的控件，`Number` 的设置值为：

* `０- vbLinkNone`    无：     无 `DDE` 交互。（缺省值）
* `１- vbLinkAutomatic`    自动：   每次链接数据改变，目标控件都要更新。
* `２- vbLinkManual`    手动：   只有激活 `LinkRequest` 方法时，才更新目标控件。
* `３- vbLinkNotify`    通知：   链接数据改变时，会产生 `LinkNotify` 事件，但是只有在 `LinkRequest` 方法激活时才会更新目标控件。



对作为 `DDE` 会话源的窗体，`number` 的设置值为：

* `０- vbLinkNone`（缺省值）  无：     没有 DDE 交互。

  没有目标应用程序能够启动与源窗体的主题会话，没有应用程序能够向窗体放置数据。

  如果在设计时 `LinkMode` 为 `0`（无），在运行时不能将其改变为 `1`（源）。

* `１- vbLinkSource`     源：     允许窗体上的任何 `Label` 、`PictureBox` 或 `TextBox` 控件为与该窗体建立  `DDE` 会话的目标应用程序提供数据。



如果存在这种链接，`Visual Basic` 在控件内容改变时会自动提醒目标应用程序。

另外，目标应用程序能够向窗体上的 `Label` 、`PictureBox` 、`TextBox` 控件存放数据。

如果设计时 `LinkMode` 为 `1`（源），运行时可以将它改为 `0`（无）也可以再改回来。

返回一个代表包含该窗口的框架的 `Window` 对象，此属性为只读，只应用于 `Window` 对象。



##### `DDE` 会话的有关方法

1. `LinkSend`
   在一次 `DDE` 对话中将 `PictureBox` 控件的内容传输到的接收端应用程序。
2. `LinkExecute`
   `DDE` 对话过程中将命令字符串发送给发送端应用程序。
3. `LinkPoke`
   `DDE` 对话过程中将 `Label` 、`PictureBox` 或 `TextBox` 控件的内容传送给发送端应用程序。
4. `LinkRequest`
   `DDE` 对话中请求发送端应用程序更新 `Label` 、`PictureBox` 或 `TextBox` 控件中的内容。



如果 `object` 的 `LinkMode` 属性设置为自动（ `1` 或 `vbLinkAutomatic` ），则源应用程序自动更新 `object` 而不需要 `LinkRequest` 。

如果 `object` 的 `LinkMode` 属性设置为手工（ `2` 或 `vbLinkManual` ），则只有使用 `LinkRequest` 时源应用程序才更新 `object` 。

如果 `object` 的 `LinkMode` 属性设置为通知 `Notify`（ `3` 或 `vbLinkNotify` ），则源端通过调用 `LinkNotify` 事件通知接收端已更改数据。

然后接收端必须使用 `LinkRequest` 更新数据。

设置一指示对象为可见或隐藏的值。



##### `DDE` 会话的集合

`LinkedWindows` 集合

* Count  （属性）    集合内成员的个数，此属性为只读

* Parent （属性）    返回包含另一对象或集合的对象或集合，此属性为只读

* VBE    （属性）    返回该 VBE 对象的根，此属性为只读。

  例  返回活动工程名称：Debug. Print Application.VBE.ActiveVBProject.Name

* Add  (component )  （方法）  将一个对象添加到集合。
  component 参数：
  vbext_ct_ClassModule 将一个类模块添加到集合。
  Vbext_ct_MSForm 将窗体添加到集合。
  vbext_ct_StdModule 将标准模块添加到集合。

* Item (index )      （方法）返回集合中所索引的成员。
  index 参数可以是数值或包含对象标题的字符串。字符串必须和集合的 key 参数匹配。
  Key 参数：
  Windows          Caption 属性设置
  LinkedWindows    Caption 属性设置
  CodePanes        无唯一字符串与此集合相关。
  VBProjects       Name 属性设置
  VBComponents     Name 属性设置
  References       Name 属性设置
  Properties       Name 属性设置

* Remove (component ) （方法）从集合中删除一项
  component参数是必需的。
  对于 LinkedWindows 集合来说，是一个对象。
  对于 References 集合来说，是一个对类型库，或者对工程的引用。
  对于 VBComponents 集合来说，是一个枚举型的常数，它代表一个类模块、一个窗体，或者是一个标准模块。



`DDE` 会话的 `Link` 操作示例

本示例建立一个 Microsoft Excel 的 DDE 链接，将一些值放置到一个新工作单的第一行的单元里，并按照这些值画图。 LinkExecute 向 Microsoft Excel 发送激活工作单的命令，选择一些值并按照它们画图。

```
Private Sub Form_Click ()
     Dim Cmd, I, Q, Row, Z                                    '' 声明变量。
    Q  =  Chr (34 )                                              '' 定义引用标记。
    '' 创建一个含有 Microsoft Excel 宏指令的字串。
    Cmd  = " [ACTIVATE("  & Q  & " SHEET1"  & Q  & " )]"
    Cmd  = Cmd  & " [SELECT("  & Q  & " R1C1:R5C2"  & Q  & " )]"
    Cmd  = Cmd  & " [NEW(2,1)][ARRANGE.ALL()]"
     If Text1.LinkMode  = vbNone  Then
        Z  =  Shell (" C:\Program Files\Microsoft Office\Office\EXCEL.EXE", 4 )  '' 启动 Microsoft Excel。
        Text1.LinkTopic  = " Excel|Sheet1"                     '' 设置连接主题。
        Text1.LinkItem  = " R1C1"                              '' 设置连接项目。
        Text1.LinkMode  = vbLinkManual                        '' 设置连接模式。
     End If
    For I  = 1  To 5
        Row  = I                                              '' 定义行号。
        Text1.LinkItem  = " R"  & Row  & " C1"                    '' 设置连接项目。
        Text1.Text  =  Chr (64  + I )                             '' 将值放置在 Text 中。
        Text1.LinkPoke                                       '' 将值放入单元。
        Text1.LinkItem  = " R"  & Row  & " C2"                    '' 设置连接项目。
        Text1.Text  = Row                                     '' 将值放置在 Text 中。
        Text1.LinkPoke                                       '' 将值放入单元。
     Next I
     on Error Resume Next
    Text1.LinkExecute Cmd                                    '' 执行 Microsoft Excel 命令。
     MsgBox " LinkExecute DDE demo with Microsoft Excel finished.", 64
     End
End Sub
```



使用 LinkRequest 更新含有 Microsoft Excel 工作单中值的正文框的内容
计算机上必需正在运行着 Microsoft Excel

```
Private Sub Form_Click ()
     If Text1.LinkMode  = vbNone  Then                          '' 测试连接模式。
        Text1.LinkTopic  = " Excel|Sheet1"                     '' 设置连接主题。
        Text1.LinkItem  = " R1C1"                              '' 设置连接项目。
        Text1.LinkMode  = vbLinkManual                        '' 设置连接模式。
        Text1.LinkRequest                                    '' 更新正文框内容。
     Else
        If Text1.LinkItem  = " R1C1"  Then
            Text1.LinkItem  = " R2C1"
            Text1.LinkRequest                                '' 更新正文框内容。
         Else
            Text1.LinkItem  = " R1C1"
            Text1.LinkRequest                                '' 更新正文框内容。
         End If
    End If
End Sub
```



3.LinkItem、LinkMode、LinkTopic 属性示例

在这个例子中，每一次敲击鼠标都会使 Microsoft Excel 工作单中的单元更新 Visual Basic
的 TextBox   先启动 Microsoft Excel，打开一个新的名叫 Sheet1 的工作单，在第一列中放入一些数据。

```
Private Sub Form_Click ()
     Dim CurRow  As String
    Static Row                                               '' 工作单的行数.
    Row  = Row  + 1                                            '' 增加行.
     If Row  = 1  Then                                          '' 只第一次.
        '' 确保连接不是活动的.
        Text1.LinkMode  = 0
         '' 设置应用程序的名字和题目名.
        Text1.LinkTopic  = " Excel|Sheet1"
        Text1.LinkItem  = " R1C1"                              '' 设置 LinkItem.
        Text1.LinkMode  = 1                                   '' 设置 LinkMode 为自动.
     Else
         ''在数据项目中更新行.
        CurRow  = " R"  & Row  & " C1"
        Text1.LinkItem  = CurRow                              '' 设置 LinkItem.
     End If
End Sub
```

