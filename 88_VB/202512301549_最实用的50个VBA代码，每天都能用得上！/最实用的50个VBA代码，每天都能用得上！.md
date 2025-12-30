# 最实用的50个VBA代码，每天都能用得上！





# 一、数据处理必备（15个超实用代码）

# 1. 一键删除空白行

vba

```vb
Sub 删除空白行()
    On Error Resume Next
    Columns("A:A").SpecialCells(xlCellTypeBlanks).EntireRow.Delete
    On Error GoTo 0
    MsgBox "空白行已清理完毕！"
End Sub
' 最常用的数据清理功能，一键删除A列为空的所有行'
```

# 2. 快速筛选并复制数据

vba

```
Sub 筛选并复制()
    Range("A1:E100").AutoFilter Field:=2, Criteria1:="销售部"
    Range("A1:E100").Copy Destination:=Sheets("结果").Range("A1")
    ActiveSheet.ShowAllData
End Sub
' 筛选出销售部数据并复制到新表，日常统计必备'
```

# 3. 合并多个单元格内容

vba

```
Sub 合并内容()
    Dim result As String
    For Each cell In Range("A1:A10")
        If cell.Value <> "" Then
            result = result & cell.Value & "，"
        End If
    Next
    Range("B1").Value = Left(result, Len(result) - 1)
End Sub
' 将A列内容合并到一个单元格，用"，"分隔'
```

# 4. 批量添加前缀/后缀

vba

```
Sub 添加前缀()
    For Each cell In Range("A1:A100")
        cell.Value = "产品-" & cell.Value
    Next
End Sub
' 给A列所有内容加上"产品-"前缀，批量修改超方便'
```

# 5. 数据分列

vba

```
Sub 智能分列()
    Range("A1:A100").TextToColumns _
        Destination:=Range("B1"), _
        DataType:=xlDelimited, _
        TextQualifier:=xlDoubleQuote, _
        ConsecutiveDelimiter:=False, _
        Tab:=False, _
        Semicolon:=False, _
        Comma:=True, _
        Space:=False
End Sub
' 按逗号分列，适合处理CSV格式数据'
```

# 6. 快速删除重复值

vba

```
Sub 删除重复()
    ActiveSheet.Range("A1:C100").RemoveDuplicates _
        Columns:=Array(1, 2, 3), _
        Header:=xlYes
    MsgBox "重复数据已删除！"
End Sub
' 按三列判断重复，保留唯一值'
```

# 7. 数据快速转置

vba

```
Sub 行列转换()
    Range("A1:A10").Copy
    Range("C1").PasteSpecial Paste:=xlPasteAll, Transpose:=True
    Application.CutCopyMode = False
End Sub
' 竖排变横排，制作表格时经常用到'
```

# 8. 批量四舍五入

vba

```
Sub 统一小数位数()
    Range("B2:B100").NumberFormat = "0.00"
    For Each cell In Range("B2:B100")
        cell.Value = Round(cell.Value, 2)
    Next
End Sub
' 统一保留2位小数，财务工作必备'
```

# 9. 隔行填充颜色

vba

```
Sub 隔行着色()
    For i = 2 To 100 Step 2
        Rows(i).Interior.Color = RGB(240, 240, 240)
    Next i
End Sub
' 让表格更易读，自动隔行填充灰色'
```

# 10. 快速清空表格

vba

```
Sub 一键清空()
    If MsgBox("确定要清空所有数据吗？", vbYesNo + vbQuestion) = vbYes Then
        Cells.Clear
        MsgBox "已清空！"
    End If
End Sub
' 带确认提示，避免误操作'
```

# 11. 文本转数字

vba

```
Sub 文本转数值()
    Selection.Value = Selection.Value
    Selection.NumberFormat = "0"
End Sub
' 解决文本格式数字不能计算的问题'
```

# 12. 提取数字/文字

vba

```
Function 提取数字(文本 As String) As String
    Dim i As Integer, 结果 As String
    For i = 1 To Len(文本)
        If IsNumeric(Mid(文本, i, 1)) Then
            结果 = 结果 & Mid(文本, i, 1)
        End If
    Next
    提取数字 = 结果
End Function
' 自定义函数，从混合文本中提取纯数字'
```

# 13. 批量插入空行

vba

```
Sub 每行后插空行()
    For i = 100 To 2 Step -1
        Rows(i).Insert Shift:=xlDown
    Next i
End Sub
' 从下往上处理，避免行号错乱'
```

# 14. 合并相同内容单元格

vba

```
Sub 合并相同项()
    Dim startRow As Integer, endRow As Integer
    startRow = 2
    For i = 3 To 200
        If Cells(i, 1).Value <> Cells(i - 1, 1).Value Then
            endRow = i - 1
            If endRow > startRow Then
                Range(Cells(startRow, 1), Cells(endRow, 1)).Merge
            End If
            startRow = i
        End If
    Next i
End Sub
' 自动合并相同内容的单元格，美化表格'
```

# 15. 拆分合并单元格

vba

```
Sub 取消合并并填充()
    Selection.UnMerge
    Selection.SpecialCells(xlCellTypeBlanks).FormulaR1C1 = "=R[-1]C"
    Selection.Value = Selection.Value
End Sub
' 拆分合并单元格，并向下填充内容'
```

------

# 二、表格操作技巧（10个效率代码）

# 16. 自动调整列宽

vba

```
Sub 智能列宽()
    Cells.EntireColumn.AutoFit
    MsgBox "列宽已自动调整到最佳宽度！"
End Sub
' 一键让所有列宽刚好适合内容'
```

# 17. 冻结窗格

vba

```
Sub 冻结首行首列()
    ActiveWindow.FreezePanes = False
    Range("B2").Select
    ActiveWindow.FreezePanes = True
End Sub
' 冻结第一行和第一列，查看大数据更方便'
```

# 18. 保护工作表

vba

```
Sub 简单保护()
    ActiveSheet.Protect Password:="123", _
        AllowFormattingCells:=True, _
        AllowSorting:=True
End Sub
' 设置保护但允许格式化和排序'
```

# 19. 隐藏零值

vba

```
Sub 不显示零()
    ActiveWindow.DisplayZeros = False
End Sub
' 让0值不显示，表格更清爽'
```

# 20. 快速跳转到最后一行

vba

```
Sub 跳到最后()
    Cells(Rows.Count, "A").End(xlUp).Offset(1, 0).Select
End Sub
' 直接定位到A列最后一个数据下方'
```

# 21. 批量重命名工作表

vba

```
Sub 按月命名()
    For i = 1 To 12
        Sheets.Add After:=Sheets(Sheets.Count)
        ActiveSheet.Name = i & "月"
    Next i
End Sub
' 快速创建1-12月的工作表'
```

# 22. 工作表排序

vba

```
Sub 工作表排序()
    Dim i As Integer, j As Integer
    For i = 1 To Sheets.Count - 1
        For j = i + 1 To Sheets.Count
            If Sheets(j).Name < Sheets(i).Name Then
                Sheets(j).Move Before:=Sheets(i)
            End If
        Next j
    Next i
End Sub
' 按工作表名称字母顺序排序'
```

# 23. 复制工作表结构

vba

```
Sub 复制模板()
    Sheets("模板").Copy After:=Sheets(Sheets.Count)
    ActiveSheet.Name = "新表格"
End Sub
' 复制模板工作表，保持格式不变'
```

# 24. 快速创建目录

vba

```
Sub 生成目录()
    Dim ws As Worksheet, i As Integer
    i = 1
    For Each ws In Worksheets
        Sheets("目录").Cells(i, 1).Value = ws.Name
        i = i + 1
    Next
End Sub
' 自动生成所有工作表的目录链接'
```

# 25. 隐藏除当前表外的所有表

vba

```
Sub 专注当前表()
    Dim ws As Worksheet
    For Each ws In Worksheets
        If ws.Name <> ActiveSheet.Name Then
            ws.Visible = xlSheetHidden
        End If
    Next
End Sub
' 只显示正在操作的工作表，减少干扰'
```

------

# 三、常用公式与计算（10个实用代码）

# 26. 批量插入公式

vba

```
Sub 自动计算合计()
    Range("B100").Formula = "=SUM(B2:B99)"
    Range("B100").Copy Destination:=Range("C100:F100")
End Sub
' 快速插入求和公式并向右填充'
```

# 27. 公式转数值

vba

```
Sub 公式固化()
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues
    Application.CutCopyMode = False
End Sub
' 将公式结果转为固定数值，防止引用错误'
```

# 28. 快速百分比计算

vba

```
Sub 计算占比()
    Range("C2:C100").Formula = "=B2/SUM(B:B)"
    Range("C2:C100").NumberFormat = "0.00%"
End Sub
' 自动计算每个项目占总数的百分比'
```

# 29. 条件求和

vba

```
Sub 条件汇总()
    Dim 合计 As Double
    合计 = Application.WorksheetFunction.SumIf(Range("A:A"), "北京", Range("B:B"))
    Range("D1").Value = "北京地区合计：" & 合计
End Sub
' 按条件汇总数据，比公式更快'
```

# 30. 查找最大值

vba

```
Sub 找最大最小值()
    Dim maxVal As Double, minVal As Double
    maxVal = Application.WorksheetFunction.Max(Range("B:B"))
    minVal = Application.WorksheetFunction.Min(Range("B:B"))
    MsgBox "最大值：" & maxVal & vbCrLf & "最小值：" & minVal
End Sub
' 快速找出数据中的极值'
```

# 31. 排名计算

vba

```
Sub 自动排名()
    Range("C2:C100").Formula = "=RANK(B2,B:B,0)"
    Range("C2:C100").Value = Range("C2:C100").Value
End Sub
' 为数据添加排名，销售业绩统计常用'
```

# 32. 平均值计算

vba

```
Sub 分段平均()
    Dim avg1 As Double, avg2 As Double
    avg1 = Application.Average(Range("B2:B50"))
    avg2 = Application.Average(Range("B51:B100"))
    Range("E1").Value = "前半段平均：" & avg1
    Range("E2").Value = "后半段平均：" & avg2
End Sub
' 分段计算平均值，分析数据变化趋势'
```

# 33. 四则运算批量处理

vba

```
Sub 批量计算()
    For Each cell In Range("C2:C100")
        cell.Value = cell.Offset(0, -1).Value * 1.1 '涨价10%
    Next
End Sub
' 批量进行加减乘除运算'
```

# 34. 统计个数

vba

```
Sub 数量统计()
    Dim 总数 As Long, 非空数 As Long
    总数 = Range("A:A").Cells.Count
    非空数 = Application.CountA(Range("A:A"))
    MsgBox "总单元格数：" & 总数 & vbCrLf & "有内容的单元格：" & 非空数
End Sub
' 统计各种数量信息'
```

# 35. 日期计算

vba

```
Sub 日期加减()
    Range("C2:C100").Formula = "=B2+30" '加30天
    Range("C2:C100").NumberFormat = "yyyy-mm-dd"
End Sub
' 批量进行日期计算'
```

------

# 四、文件与打印设置（8个常用代码）

# 36. 批量保存为PDF

vba

```
Sub 导出PDF()
    ActiveSheet.ExportAsFixedFormat _
        Type:=xlTypePDF, _
        Filename:="C:\报表.pdf", _
        Quality:=xlQualityStandard, _
        IncludeDocProperties:=True, _
        IgnorePrintAreas:=False
    MsgBox "PDF已保存！"
End Sub
' 一键导出当前表为PDF，方便分享'
```

# 37. 设置打印区域

vba

```
Sub 设置打印范围()
    ActiveSheet.PageSetup.PrintArea = "$A$1:$G$50"
    ActiveSheet.PageSetup.Orientation = xlLandscape '横向
    ActiveSheet.PageSetup.Zoom = 90 '缩放90%
End Sub
' 精确控制打印内容和格式'
```

# 38. 每页都打印标题行

vba

```
Sub 重复标题()
    With ActiveSheet.PageSetup
        .PrintTitleRows = "$1:$2" '第1-2行作为标题
        .PrintTitleColumns = "$A:$B" 'A-B列作为标题
    End With
End Sub
' 长表格打印时每页都有标题'
```

# 39. 添加页眉页脚

vba

```
Sub 自定义页眉页脚()
    ActiveSheet.PageSetup.CenterHeader = "&""宋体,常规""公司月度报表"
    ActiveSheet.PageSetup.CenterFooter = "第&P页/共&N页"
    ActiveSheet.PageSetup.RightFooter = "打印日期：&D"
End Sub
' 添加专业的页眉页脚信息'
```

# 40. 快速打印预览

vba

```
Sub 一键预览()
    ActiveSheet.PrintPreview
End Sub
' 快速查看打印效果'
```

# 41. 批量打印工作表

vba

```
Sub 打印所有表()
    Dim ws As Worksheet
    For Each ws In Worksheets
        ws.PrintOut Copies:=1
    Next
End Sub
' 一次性打印所有工作表'
```

# 42. 保存时自动备份

vba

```
Private Sub Workbook_BeforeSave(ByVal SaveAsUI As Boolean, Cancel As Boolean)
    ThisWorkbook.SaveCopyAs "C:\Backup\" & Format(Now, "yyyymmdd_hhmm") & ".xlsx"
End Sub
' 自动保存备份文件，防止数据丢失'
```

# 43. 关闭前自动保存

vba

```
Private Sub Workbook_BeforeClose(Cancel As Boolean)
    If Not ThisWorkbook.Saved Then
        If MsgBox("是否保存更改？", vbYesNo) = vbYes Then
            ThisWorkbook.Save
        End If
    End If
End Sub
' 关闭文件前自动提示保存'
```

------

# 五、实用小工具（7个贴心代码）

# 44. 定时提醒

vba

```
Sub 会议提醒()
    Application.OnTime TimeValue("15:00:00"), "会议开始"
End Sub

Sub 会议开始()
    MsgBox "下午3点会议即将开始！", vbExclamation
End Sub
' 设置定时提醒，再也不会忘记会议'
```

# 45. 生成随机数据

vba

```
Sub 填充测试数据()
    For i = 2 To 101
        Cells(i, 2).Value = Int((1000 - 100 + 1) * Rnd + 100)
        Cells(i, 3).Value = Date - Int(365 * Rnd)
    Next
End Sub
' 快速生成测试数据，方便演示和测试'
```

# 46. 单元格批注管理

vba

```
Sub 批量添加批注()
    For Each cell In Selection
        If cell.Comment Is Nothing Then
            cell.AddComment "需要核对"
        End If
    Next
End Sub
' 为选中单元格批量添加批注'
```

# 47. 快速选中特定区域

vba

```
Sub 选中数据区()
    Range("A1").CurrentRegion.Select
End Sub
' 选中当前数据区域，比鼠标拖动更快'
```

# 48. 显示文件信息

vba

```
Sub 文件信息()
    Dim info As String
    info = "文件名：" & ThisWorkbook.Name & vbCrLf
    info = info & "路径：" & ThisWorkbook.Path & vbCrLf
    info = info & "最后保存：" & Format(FileDateTime(ThisWorkbook.FullName), "yyyy-mm-dd hh:mm")
    MsgBox info
End Sub
' 快速查看当前文件信息'
```

# 49. 恢复默认设置

vba

```
Sub 重置视图()
    ActiveWindow.Zoom = 100
    ActiveWindow.DisplayGridlines = True
    ActiveWindow.DisplayHeadings = True
    Cells.EntireColumn.AutoFit
End Sub
' 恢复Excel默认显示设置'
```

# 50. 一键运行所有宏

vba

```
Sub 执行日常任务()
    Call 删除空白行
    Call 智能列宽
    Call 隔行着色
    Call 导出PDF
    MsgBox "所有日常任务已完成！", vbInformation
End Sub
' 把常用操作打包，一键完成多项任务'
```

------

#  使用指南（必看！）

# 如何快速上手？

1. **按Alt+F11**打开VBA编辑器
2. **插入 → 模块**，粘贴代码
3. **按F5运行**，或**Alt+F8**选择运行

# 三个黄金法则：

1. **先备份数据**再运行新代码
2. **从小范围开始**测试（如选10行测试）
3. **修改参数**适应你的表格

# 最推荐的入门路径：

1. 先学会第1、2、16、36条
2. 每天用1-2个新代码
3. 一周后组合使用多个代码

------

#  进阶提示

这些代码都经过精心挑选，**没有复杂的理论，只有实用的操作**。每个代码都解决一个具体问题，你可以像搭积木一样组合使用。

**真正的高手不是会写复杂代码，而是能用最简单的方法解决问题。**