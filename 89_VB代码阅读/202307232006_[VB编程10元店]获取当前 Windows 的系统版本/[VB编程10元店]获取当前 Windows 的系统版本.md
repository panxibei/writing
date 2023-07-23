获取当前 Windows 的系统版本



通过读取注册表项

比如Win10：

CurrentVersion=6.3

ProductName=Windows 10 Enterprise

```
Dim s1 As String, s2 As String
Dim c As New cRegistry
            With c
                .ClassKey = HKEY_LOCAL_MACHINE
                .SectionKey = "Software\Microsoft\Windows NT\CurrentVersion"
                .ValueType = REG_SZ
                
                .ValueKey = "CurrentVersion"
                s1 = .Value
                
                .ValueKey = "ProductName"
                s2 = .Value
            End With
MsgBox s1 & " | " & s2
```

