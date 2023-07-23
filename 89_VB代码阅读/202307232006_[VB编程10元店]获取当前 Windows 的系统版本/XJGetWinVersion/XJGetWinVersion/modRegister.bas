Attribute VB_Name = "modRegister"
Option Explicit
'Download by http://www.codefans.net
'*************************************************************************
'**模 块 名：RegWork
'**创 建 人：叶帆
'**日    期：2003年01月11日
'**修 改 人：
'**日    期：
'**描    述：注册表操作(不同类型,读写方法有一定区别)
'**版    本：版本1.0
'*************************************************************************+
'---------------------------------------------------------------
'-注册表 API 声明...
'---------------------------------------------------------------

'关闭登录关键字
Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Long) As Long

'建立关键字
Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegCreateKeyEx Lib "advapi32" Alias "RegCreateKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass As String, ByVal dwOptions As Long, ByVal samDesired As Long, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByRef phkResult As Long, ByRef lpdwDisposition As Long) As Long

'打开关键字
Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, ByRef phkResult As Long) As Long

'返回关键字的类型和值
Private Declare Function RegQueryValueEx_SZ Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, ByRef lpType As Long, ByVal lpData As String, ByRef lpcbData As Long) As Long
Private Declare Function RegQueryValueEx_DWORD Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Long, lpcbData As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, ByRef lpcbData As Long) As Long

'将文本字符串与指定关键字关联
Private Declare Function RegSetValueEx_SZ Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, ByVal lpData As String, ByVal cbData As Long) As Long
Private Declare Function RegSetValueEx_DWORD Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Long, ByVal cbData As Long) As Long
Private Declare Function RegSetValueEx_BINARY Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long

'删除关键字
Private Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long

'从登录关键字中删除一个值
Private Declare Function RegDeleteValue Lib "advapi32.dll" Alias "RegDeleteValueA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long

'删除带子项的注册表项
Private Declare Function SHDeleteKey Lib "shlwapi.dll" Alias "SHDeleteKeyA" (ByVal hKey As Long, ByVal pszSubKey As String) As Long

' 注册表的数据类型
Private Enum REGValueType

    REG_SZ = 1                             ' Unicode空终结字符串
    REG_EXPAND_SZ = 2                      ' Unicode空终结字符串
    REG_BINARY = 3                         ' 二进制数值
    REG_DWORD = 4                          ' 32-bit 数字
    REG_DWORD_BIG_ENDIAN = 5
    REG_LINK = 6
    REG_MULTI_SZ = 7                       ' 二进制数值串

End Enum

' 注册表创建类型值...
Const REG_OPTION_NON_VOLATILE = 0       ' 当系统重新启动时，关键字被保留

' 注册表关键字安全选项...
Const READ_CONTROL = &H20000
Const KEY_QUERY_VALUE = &H1
Const KEY_SET_VALUE = &H2
Const KEY_CREATE_SUB_KEY = &H4
Const KEY_ENUMERATE_SUB_KEYS = &H8
Const KEY_NOTIFY = &H10
Const KEY_CREATE_LINK = &H20
Const KEY_READ = KEY_QUERY_VALUE + KEY_ENUMERATE_SUB_KEYS + KEY_NOTIFY + READ_CONTROL
Const KEY_WRITE = KEY_SET_VALUE + KEY_CREATE_SUB_KEY + READ_CONTROL
Const KEY_EXECUTE = KEY_READ
'Const KEY_ALL_ACCESS = KEY_QUERY_VALUE + KEY_SET_VALUE + _
      KEY_CREATE_SUB_KEY + KEY_ENUMERATE_SUB_KEYS + _
      KEY_NOTIFY + KEY_CREATE_LINK + READ_CONTROL

' 重定向至注册表64位的samDesired参数
Const KEY_WOW64_64KEY = &H100 ' 从 32 位或 64 位应用程序访问 64 位密钥
Const KEY_WOW64_32KEY = &H200 ' 从 32 位或 64 位应用程序访问 32 位密钥

Const KEY_ALL_ACCESS = KEY_QUERY_VALUE + KEY_SET_VALUE + _
      KEY_CREATE_SUB_KEY + KEY_ENUMERATE_SUB_KEYS + _
      KEY_NOTIFY + KEY_CREATE_LINK + READ_CONTROL + KEY_WOW64_64KEY


' 注册表关键字根类型...
Private Enum REGRoot

    HKEY_CLASSES_ROOT = &H80000000
    HKEY_CURRENT_USER = &H80000001
    HKEY_LOCAL_MACHINE = &H80000002
    HKEY_USERS = &H80000003
    HKEY_PERFORMANCE_DATA = &H80000004

End Enum

' 返回值...
Const ERROR_NONE = 0
Const ERROR_BADKEY = 2
Const ERROR_ACCESS_DENIED = 8
Const ERROR_SUCCESS = 0

'- 注册表安全属性类型...
Private Type SECURITY_ATTRIBUTES

    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Boolean

End Type

'*************************************************************************
'**函 数 名：WriteRegKey
'**输    入：ByVal KeyRoot(REGRoot)         - 根
'**        ：ByVal KeyName(String)          - 键的路径
'**        ：ByVal SubKeyName(String)       - 键名
'**        ：ByVal SubKeyType(REGValueType) - 键的类型
'**        ：ByVal SubKeyValue(String)      - 键值
'**输    出：(Boolean) - 成功返回True，失败返回False
'**功能描述：写注册表
'**全局变量：
'**调用模块：
'**作    者：叶帆
'**日    期：2003年01月10日
'**修 改 人：
'**日    期：
'**版    本：版本1.0
'*************************************************************************

Private Function WriteRegKey(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String, ByVal SubKeyType As REGValueType, ByVal SubKeyValue As String) As Boolean

    Dim rc As Long                                      ' 返回代码
    Dim hKey As Long                                    ' 处理一个注册表关键字
    Dim hDepth As Long                                  ' 用于装载下列某个常数的一个变量
    ' REG_CREATED_NEW_KEY——新建的一个子项
    ' REG_OPENED_EXISTING_KEY——打开一个现有的项
    Dim lpAttr As SECURITY_ATTRIBUTES                   ' 注册表安全类型
    Dim i As Integer
    Dim bytValue(1024) As Byte

    lpAttr.nLength = 50                                 ' 设置安全属性为缺省值...
    lpAttr.lpSecurityDescriptor = 0                     ' ...
    lpAttr.bInheritHandle = True                        ' ...

    '- 创建/打开注册表关键字...
    rc = RegCreateKeyEx(KeyRoot, KeyName, 0, SubKeyType, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, lpAttr, hKey, hDepth)                                                                                          ' 创建/打开//KeyRoot//KeyName
    'rc = RegCreateKeyEx(KeyRoot, KeyName, 0, SubKeyType, REG_OPTION_NON_VOLATILE, KEY_WOW64_64KEY, lpAttr, hKey, hDepth)                                                                                          ' 创建/打开//KeyRoot//KeyName



    If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError   ' 错误处理...

    '- 创建/修改关键字值...

    If Len(SubKeyValue) = 0 Then SubKeyValue = " "        ' 要让RegSetValueEx() 工作需要输入一个空格...

    Select Case SubKeyType                                        ' 搜索数据类型...

        Case REG_SZ, REG_EXPAND_SZ                                ' 字符串注册表关键字数据类型

        rc = RegSetValueEx_SZ(hKey, SubKeyName, 0, SubKeyType, ByVal SubKeyValue, LenB(StrConv(SubKeyValue, vbFromUnicode)))

        If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError         ' 错误处理

        Case REG_DWORD                                            ' 四字节注册表关键字数据类型

        rc = RegSetValueEx_DWORD(hKey, SubKeyName, 0, SubKeyType, Val("&h" + SubKeyValue), 4)

        If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError         ' 错误处理

        Case REG_BINARY                                           ' 二进制字符串

        Dim intNum As Integer

        For i = 1 To Len(Trim$(SubKeyValue)) - 1 Step 3

            intNum = intNum + 1
            bytValue(intNum - 1) = Val("&h" + Mid$(SubKeyValue, i, 2))

        Next

        rc = RegSetValueEx_BINARY(hKey, SubKeyName, 0, SubKeyType, bytValue(0), intNum)

        If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError   ' 错误处理

        Case Else

        GoTo CreateKeyError                                    ' 错误处理

    End Select

    '- 关闭注册表关键字...
    rc = RegCloseKey(hKey)                              ' 关闭关键字

    WriteRegKey = True                                  ' 返回成功

    Exit Function                                       ' 退出

CreateKeyError:

    WriteRegKey = False                                 ' 设置错误返回代码
    rc = RegCloseKey(hKey)                              ' 试图关闭关键字

End Function

'*************************************************************************
'**函 数 名：ReadRegKey
'**输    入：KeyRoot(Long)     - 根
'**        ：KeyName(String)   - 键的路径
'**        ：SubKeyRef(String) - 键名
'**输    出：(String) - 返回键值
'**功能描述：读注册表
'**全局变量：
'**调用模块：
'**作    者：叶帆
'**日    期：2003年01月10日
'**修 改 人：
'**日    期：
'**版    本：版本1.0
'*************************************************************************

Private Function ReadRegKey(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String) As String

    Dim i As Long                                            ' 循环计数器
    Dim rc As Long                                           ' 返回代码
    Dim hKey As Long                                         ' 处理打开的注册表关键字
    Dim hDepth As Long                                       '
    Dim sKeyVal As String
    Dim lKeyValType As Long                                  ' 注册表关键字数据类型
    Dim tmpVal As String                                     ' 注册表关键字的临时存储器
    Dim KeyValSize As Long                                   ' 注册表关键字变量尺寸
    Dim lngValue As Long
    Dim bytValue(1024) As Byte

    ' 在 KeyRoot下打开注册表关键字

    rc = RegOpenKeyEx(KeyRoot, KeyName, 0, KEY_ALL_ACCESS, hKey)   ' 打开注册表关键字
    'rc = RegOpenKeyEx(KeyRoot, KeyName, 0, KEY_WOW64_64KEY, hKey)   ' 打开注册表关键字

    If (rc <> ERROR_SUCCESS) Then GoTo GetKeyError                 ' 处理错误...

    ' 检测键的类型

    rc = RegQueryValueEx(hKey, SubKeyName, 0, lKeyValType, ByVal 0, KeyValSize)  ' 获得/创建关键字的值lKeyValType

    If (rc <> ERROR_SUCCESS) Then GoTo GetKeyError                 ' 处理错误...

    '读相应的键值

    Select Case lKeyValType                                         ' 搜索数据类型...

        Case REG_SZ, REG_EXPAND_SZ                                  ' 字符串注册表关键字数据类型

        tmpVal = String$(1024, 0)                                   ' 分配变量空间
        KeyValSize = 1024                                           ' 标记变量尺寸

        rc = RegQueryValueEx_SZ(hKey, SubKeyName, 0, 0, tmpVal, KeyValSize)     ' 获得/创建关键字的值
        
        If rc <> ERROR_SUCCESS Then GoTo GetKeyError           ' 错误处理

        If InStr(tmpVal, Chr$(0)) > 0 Then sKeyVal = Left$(tmpVal, InStr(tmpVal, Chr$(0)) - 1)     ' 复制字符串的值,并去除空字符.
        
        Case REG_DWORD                                             ' 四字节注册表关键字数据类型
        
        KeyValSize = 1024                                          ' 标记变量尺寸
        rc = RegQueryValueEx_DWORD(hKey, SubKeyName, 0, 0, lngValue, KeyValSize)     ' 获得/创建关键字的值
        
        If rc <> ERROR_SUCCESS Then GoTo GetKeyError            ' 错误处理
        
        sKeyVal = "0x" + Hex$(lngValue)
        
        Case REG_BINARY                                            ' 二进制字符串
        
        rc = RegQueryValueEx(hKey, SubKeyName, 0, 0, bytValue(0), KeyValSize)       ' 获得/创建关键字的值

        If rc <> ERROR_SUCCESS Then GoTo GetKeyError            ' 错误处理

        sKeyVal = ""
        
        For i = 1 To KeyValSize

            If Len(Hex$(bytValue(i - 1))) = 1 Then
            
                sKeyVal = sKeyVal + "0" + Hex$(bytValue(i - 1)) + " "
                
            Else
            
                sKeyVal = sKeyVal + Hex$(bytValue(i - 1)) + " "
                
            End If

        Next

        Case Else
        
        sKeyVal = ""
    
    End Select

    ReadRegKey = sKeyVal                                      ' 返回值
    rc = RegCloseKey(hKey)                                    ' 关闭注册表关键字
    
    Exit Function                                             ' 退出

GetKeyError:

    ' 错误发生过后进行清除...

    ReadRegKey = ""                                      ' 设置返回值为错误

    rc = RegCloseKey(hKey)                                    ' 关闭注册表关键字

End Function

'*************************************************************************
'**函 数 名：DelRegKey
'**输    入：KeyRoot(Long)     - 根
'**        ：KeyName(String)   - 键的路径
'**        ：SubKeyRef(String) - 键名
'**输    出：(Long) - 状态码
'**功能描述：删除关键字
'**全局变量：
'**调用模块：
'**作    者：叶帆
'**日    期：2003年01月11日
'**修 改 人：
'**日    期：
'**版    本：版本1.0
'*************************************************************************

Private Function DelRegKey(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String) As Long

    Dim lKeyId          As Long
    Dim lResult         As Long

    '检测设置的参数
    If Len(KeyName) = 0 And Len(SubKeyName) = 0 Then

        ' 键值没设置则返回相应错误码
        DelRegKey = ERROR_BADKEY

        Exit Function

    End If

    ' 打开关键字并尝试创建它,如果已存在,则返回ID值
    lResult = RegCreateKey(KeyRoot, KeyName, lKeyId)

    If lResult = 0 Then

        '删除关键字
        DelRegKey = RegDeleteKey(lKeyId, ByVal SubKeyName)

    End If

End Function

'*************************************************************************
'**函 数 名：DelRegValue
'**输    入：KeyRoot(Long)     - 根
'**        ：KeyName(String)   - 键的路径
'**        ：SubKeyRef(String) - 键名
'**输    出：(Long) - 状态码
'**功能描述：从登录关键字中删除一个值
'**全局变量：
'**调用模块：
'**作    者：叶帆
'**日    期：2003年01月11日
'**修 改 人：
'**日    期：
'**版    本：版本1.0
'*************************************************************************

Private Function DelRegValue(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String) As Long

    Dim lKeyId As Long
    Dim lResult As Long

    '检测设置的参数
    If Len(KeyName) = 0 And Len(SubKeyName) = 0 Then

        ' 键值没设置则返回相应错误码
        DelRegValue = ERROR_BADKEY

        Exit Function

    End If

    ' 打开关键字并尝试创建它,如果已存在,则返回ID值
    lResult = RegCreateKey(KeyRoot, KeyName, lKeyId)

    If lResult = 0 Then

        '从登录关键字中删除一个值
        DelRegValue = RegDeleteValue(lKeyId, ByVal SubKeyName)

    End If

End Function

Public Sub AddStart()       '启动时加入启动项目

    'WriteRegKey HKEY_LOCAL_MACHINE, ByVal "Software\Microsoft\Windows\CurrentVersion\Run", _
                ByVal "例子", REG_SZ, ByVal App.Path & "\工程1.exe"
    WriteRegKey HKEY_LOCAL_MACHINE, ByVal "Software\Microsoft\Windows\CurrentVersion\Run", _
                ByVal "例子", REG_SZ, ByVal App.Path & "\工程1.exe"

End Sub

Public Sub RemoveStart()    '移除启动项目,这里调用的DelRegValue,DelRegKey是一样的参数,就不写例子了.

    DelRegValue HKEY_LOCAL_MACHINE, ByVal "Software\Microsoft\Windows\CurrentVersion\Run", ByVal "例子"

End Sub

'=============================================================================================

'删除注册表项
Public Function DeteleRegItem(rRoot As Long, SoftPath As String) As Boolean
    Dim lngFlag As Long
    lngFlag = SHDeleteKey(rRoot, SoftPath)
    If lngFlag = 0 Then
        DeteleRegItem = True
    Else
        DeteleRegItem = False
    End If
End Function

'删除注册表键HKEY_LOCAL_MACHINE
Public Function DeleteRegKeyHKLM(SoftPath As String, KW As String) As Boolean
    DeleteRegKeyHKLM = DelRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW)
End Function

'删除注册表键HKEY_CURRENT_USER
Public Function DeleteRegKeyHKCU(SoftPath As String, KW As String) As Boolean
    DeleteRegKeyHKCU = DelRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW)
End Function

'删除注册表键值HKEY_LOCAL_MACHINE
Public Function DeleteRegValueHKLM(SoftPath As String, KW As String) As Boolean
    DeleteRegValueHKLM = DelRegValue(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW)
End Function

'删除注册表键值HKEY_CURRENT_USER
Public Function DeleteRegValueHKCU(SoftPath As String, KW As String) As Boolean
    DeleteRegValueHKCU = DelRegValue(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW)
End Function

'写入HKEY_LOCAL_MACHINE
Public Function WriteRegHKLM(SoftPath As String, ValueType As String, KW As String, Description As String) As Boolean
    If UCase(ValueType) = "REG_DWORD" Then
        WriteRegHKLM = WriteRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW, REG_DWORD, ByVal Description)
    Else
        WriteRegHKLM = WriteRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW, REG_SZ, ByVal Description)
    End If
End Function

'写入HKEY_CURRENT_USER
Public Function WriteRegHKCU(SoftPath As String, ValueType As String, KW As String, Description As String) As Boolean
    If UCase(ValueType) = "REG_DWORD" Then
        WriteRegHKCU = WriteRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW, REG_DWORD, ByVal Description)
    Else
        WriteRegHKCU = WriteRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW, REG_SZ, ByVal Description)
    End If
End Function

'读取HKEY_LOCAL_MACHINE
Public Function ReadRegHKLM(SoftPath As String, KW As String) As String
    ReadRegHKLM = ReadRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW)
End Function

'读取HKEY_CURRENT_USER
Public Function ReadRegHKCU(SoftPath As String, KW As String) As String
    ReadRegHKCU = ReadRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW)
End Function

'=============================================================================================


Public Function ReadscrKeyValue() As String  '读取是否有屏幕保护设置
    ReadscrKeyValue = ReadRegKey(HKEY_CURRENT_USER, ByVal "Control Panel\Desktop", ByVal "SCRNSAVE.EXE")
End Function

Public Function DelscrKeyValue() As String   '删除屏幕保护设置
    DelRegValue HKEY_CURRENT_USER, ByVal "Control Panel\Desktop", ByVal "SCRNSAVE.EXE"
End Function

Public Function SetScrKeyValue(scrfilePath As String) As Boolean
    'myReg.UpdateKey HKEY_CURRENT_USER, "Control Panel\Desktop", "SCRNSAVE.EXE", strSavername
    SetScrKeyValue = WriteRegKey(HKEY_CURRENT_USER, "Control Panel\Desktop", "SCRNSAVE.EXE", REG_SZ, ByVal scrfilePath)
End Function




