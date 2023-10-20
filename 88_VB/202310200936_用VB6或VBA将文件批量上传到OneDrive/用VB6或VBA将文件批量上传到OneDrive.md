用VB6或VBA将文件批量上传到OneDrive

副标题：

英文：

关键字：





在命令提示窗口中打个 `set` 命令回车，仔细找上这么一找，就能发现有我们需要的 `OneDrive` 文件夹变量。

通常应该是这样式儿的。

```
OneDrive=C:\Users\username\OneDrive - COMPANY
OneDriveCommercial=C:\Users\username\OneDrive - COMPANY
```



那么转换成 `VB/VBA` ，可以直接上环境变量函数。

```
Environ$("OneDrive")
Environ$("OneDriveCommercial")
```



至于要用哪个，就看你的需要了，用的是个人版还是商业版，不过怎么看上去好像文件夹路径都一样哈。



还有，保存文件的格式，可以使用数字来替代。

```
50 = xlExcel12 (Excel binary formatted workbook, with or without macros, .xlsb)
51 = xlOpenXMLWorkbook (macro-free Excel workbook, .xlsx)
52 = xlOpenXMLWorkbookMacroEnabled(Excel workbook with or without macros, .xlsm)
56 = xlExcel8 (Excel 97 through Excel 2003 formatted files .xls)
```



我们可以将文件格式简写成这样。

```
FileFormat:=##
```

比如，普通是 `.xlsx` ，那么这样式儿写就行了。

```
FileFormat:=51
```





保存文档到本地 `OneDrive` 。

```
' 生成一个新的演示文档
Workbooks.Add
ActiveWorkbook.Sheets(1).Range("A1") = "网管小贾 / sysadm.cc"

' xlsx格式
FileFormat = 51 'xlOpenXMLWorkbook

' 根据OneDrive环境变量保存到OneDrive文件夹内
ActiveWorkbook.SaveAs Filename:=Environ$("OneDrive") & "\test123.xlsx", FileFormat:=FileFormat, CreateBackup:=False

' 关闭保存的文档
ActiveWorkbook.Close
```





打开远程OneDrive上的文件。



通常我们会通过复制文件链接来揣摩实际的链接路径。

图a01



得到如下类似链接。

```
https://xxxx-my.sharepoint.com/:x:/r/personal/username_xx_yy_com/Documents/123.xlsx?d=w8e402b322ff148b594562e8624c252c2&csf=1&web=1&e=diu3Zg
```



接着尝试将后半部分的文件名和参数去掉，放到浏览器的地址栏内访问。

可能会报错，因为这里边有加密或干扰项。

最后还是通过查找资料才发现 `OneDrive` 的路径和 `Sharepoint` 其实是差不多的。



`OneDrive` 远程链接与 `SharePoint` 类似，一般为以下路径形式。

```
https://tenant-my.sharepoint.com/personal/username/Documents/

```



例如，你的公司域名假设叫作 `sysadm.local` ，那么可能是如下这个样子。

```
https://sysadm-my.sharepoint.com/personal/userid_sysadm_local/Documents/
```



接下来就好办了。

```
sfilename = "https://sysadm-my.sharepoint.com/personal/userid_sysadm_local/Documents/test123.xlsx"
Set xl = CreateObject("Excel.Sheet")
Set xlsheet = xl.Application.Workbooks.Open(Filename:=sfilename, ReadOnly:=True)
```





不过说一千道一万，前面说的这么一大堆，还是建立在 `OneDrive` 客户端正常工作的情况下的。

虽说打开远程文档可以不需要 `OneDrive` 客户端（亲测），但是上传文档毕竟还是靠的客户端偷摸在后台完成的。

有点魔术障眼法的感脚，总归有欺骗大众的嫌疑对吧，因此还是要想办法真正地实现远程上传的功能才行。





