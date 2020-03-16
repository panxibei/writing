给Laravel写个任务调度定时器



Laravel的任务调度很棒，统一把任务定义在源代码中而非操作系统中。

这样做当然方便维护，只需一个命令就可以启动任务：

`php artisan schedule:run`



不过嘛，由于任务是写在源代码中的，只有执行了这个命令，任务才有可能被触发执行。

要不说Linux强大呢，早就有Cron这样的调度器了。

再看看Windows呢，好像有个任务计划程序，貌似也能实现相同的功能。

我通常调试程序都在Windows下，所以现在我想自己写个简单的定时器。

翻开以前的VB文档，依葫芦画瓢地攒了个任务调度定时器。



一、要实现的功能

1.每单位时间循环执行一次程序

2.可自定义循环时间（1000ms ~ 60000ms)

3.可自定义执行的程序（Path\foo.bat）



部分代码：

>```vb
>'*************************************************************************
>'**代码名称：给Laravel写个任务调度定时器
>'**描    述：每隔自定义时间定时执行指定程序，用于Laravel任务调度
>'**模 块 名：frmMain
>'**创 建 人：网管小贾
>'**日    期：2020-03-16 16:16:16
>'**修 改 人：
>'**版    本：V2003.16.0.1616
>'*************************************************************************
>Private Const STR_MESSAGE_TITLE = "AT for Laravel"
>Private Const STR_VERSION = "2003.12.0.1645"
>Private Const STR_COPYRIGHT = "<---- 扫描二维码关注微信公众号<网管小贾>"
>
>Private strIniFileName As String '配置文件名
>Private strSectionText As String '配置项
>Private strKeyText As String '配置键
>Private strKeyValueText As String '配置健值
>
>Private strInterval As String '时钟间隔
>Private strProgram As String '执行程序路径
>
>Private Sub Form_Load()
>    On Error GoTo errorHandle
>    
>    lblTitle.Caption = STR_MESSAGE_TITLE
>    lblVersion.Caption = STR_VERSION
>    lblExplain.Caption = "Ini File: Interval:1000 - 60000 | Program: Path\foo.bat"
>    lblEmail.Caption = "作者：网管小贾    微信公众号：网管小贾"
>    lblCopyright.Caption = STR_COPYRIGHT
>
>    strIniFileName = App.Path & "\" & App.ProductName & ".ini"
>    strSectionText = "CONFIGURATION"
>    
>    If SectionExists(strIniFileName, strSectionText) Then
>        Dim tmpKeyValueText(2) As String
>        
>        strKeyText = "INTERVAL"
>        tmpKeyValueText(0) = GetKeyVal(strIniFileName, strSectionText, strKeyText)
>        
>        strKeyText = "PROGRAM"
>        tmpKeyValueText(1) = GetKeyVal(strIniFileName, strSectionText, strKeyText)
>        
>        If Len(Trim(tmpKeyValueText(0))) = 0 Or Len(Trim(tmpKeyValueText(1))) = 0 Then
>            MsgBox "Configuration is not correct!!", vbExclamation + vbOKOnly, STR_MESSAGE_TITLE
>            End
>        Else
>            strInterval = tmpKeyValueText(0)
>            strProgram = tmpKeyValueText(1)
>        End If
>    Else
>        MsgBox "Configuration is not correct!!", vbExclamation + vbOKOnly, STR_MESSAGE_TITLE
>        End
>    End If
>    
>	'程序打开即开始检查执行
>    tmrAT.Interval = strInterval
>    
>    Exit Sub
>
>errorHandle:
>    MsgBox Err.Description, vbCritical + vbOKOnly, STR_MESSAGE_TITLE
>    End
>End Sub
>
>Private Sub tmrAT_Timer()
>	On Error resume next
>    Shell strProgram, vbHide
>End Sub
>```
>



二、其中注意事项

1、由于VB时钟控件的限制，最大间隔为60秒，即一分钟。

每一分钟检查并执行我们指定的程序，这对执行Laravel任务是足够了。

如果需要间隔更大时间，可以采用其他方法，以后有机会会介绍。

2、为保存配置内容，使用了ini文件读取配置的方法。

具体可参看代码，不难。

当然，如果要在程序运行时实时读取保存配置值，可以另外写代码实现。

3、执行程序的路径应该是完全路径，不要使用相对路径。

即 `C:\mypath\foo.exe`

4、执行程序 `foo.bat` 中也应该是完全路径。

如：`C:\php\phpx.x.x\php.exe C:\laravelproject\artisan schedule:run`



如有什么问题，欢迎关注我的公众号参与留言讨论。

最后附上下载链接，慵懒的同学可以直接拿来用。



程序安装包（可直接使用）

程序源代码





