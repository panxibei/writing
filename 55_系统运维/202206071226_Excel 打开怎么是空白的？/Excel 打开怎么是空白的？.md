Excel 打开怎么是空白的？

副标题：

英文：

关键字：





打开 `Excel` 并没有显示文件内容，取而代之的是没有任何内容的背景样板。

`Excel` 程序是正常启动了，可是连个空白工作簿都没打开，是不是有点过分了呢？

图a01



而在现在这种情况下，除非再次双击那个文件，或是从 `Excel` 导航菜单的 `打开` 项才能成功打开文件内容。

如果你遇到这种情况，不妨检查一下，是否是选项设置上有什么不对。



首先，点击 `Excel` 左上角的 `文件` 菜单。

图a02



在左下角找到 `选项` ，点击它。

图a03



在出现的选项设置窗口中，我们在左侧找到 `高级` ，并在右侧向下滚动，直到找到 `常规` 区域。

在其中有一项 `忽略使用动态数据交换(DDE)的其他应用程序` ，赶紧看看是不是打上了勾。

如果被勾选了，那么把勾去掉，保存并关闭 `Excel` 再试试问题有没有解决。

图a04



如果还是不行，那么我们就要动手术了。





手动修改 `默认` 项的键值。

找到以下注册表项

```
HKEY_CLASSES_ROOT\Excel.csv\shell\Open\command
HKEY_CLASSES_ROOT\Excel.Sheet.12\shell\Open\command
HKEY_CLASSES_ROOT\Excel.Sheet.8\shell\Open\command
```



原先是这样的：

```
"C:\Program Files\Microsoft Office\Root\Office16\EXCEL.EXE" /dde
```

图 a05



修改后是这样的：

```
"C:\Program Files\Microsoft Office\Root\Office16\EXCEL.EXE" "%1"
```

图a06





还可以将其保存为 `.reg` 的注册表文件，想用时就可以直接导入到系统中。

复制以下文本到记事本，然后保存成 `.reg` 文件备用即可。

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Excel.csv\shell\Open\command]
@="\"C:\\Program Files\\Microsoft Office\\Root\\Office16\\EXCEL.EXE\" \"%1\""

[HKEY_CLASSES_ROOT\Excel.Sheet.12\shell\Open\command]
@="\"C:\\Program Files\\Microsoft Office\\Root\\Office16\\EXCEL.EXE\" \"%1\""

[HKEY_CLASSES_ROOT\Excel.Sheet.8\shell\Open\command]
@="\"C:\\Program Files\\Microsoft Office\\Root\\Office16\\EXCEL.EXE\" \"%1\""
```

