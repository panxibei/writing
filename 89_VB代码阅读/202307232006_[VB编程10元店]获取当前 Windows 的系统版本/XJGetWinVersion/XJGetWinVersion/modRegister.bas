Attribute VB_Name = "modRegister"
Option Explicit
'Download by http://www.codefans.net
'*************************************************************************
'**ģ �� ����RegWork
'**�� �� �ˣ�Ҷ��
'**��    �ڣ�2003��01��11��
'**�� �� �ˣ�
'**��    �ڣ�
'**��    ����ע������(��ͬ����,��д������һ������)
'**��    �����汾1.0
'*************************************************************************+
'---------------------------------------------------------------
'-ע��� API ����...
'---------------------------------------------------------------

'�رյ�¼�ؼ���
Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Long) As Long

'�����ؼ���
Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegCreateKeyEx Lib "advapi32" Alias "RegCreateKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass As String, ByVal dwOptions As Long, ByVal samDesired As Long, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByRef phkResult As Long, ByRef lpdwDisposition As Long) As Long

'�򿪹ؼ���
Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, ByRef phkResult As Long) As Long

'���عؼ��ֵ����ͺ�ֵ
Private Declare Function RegQueryValueEx_SZ Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, ByRef lpType As Long, ByVal lpData As String, ByRef lpcbData As Long) As Long
Private Declare Function RegQueryValueEx_DWORD Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Long, lpcbData As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, ByRef lpcbData As Long) As Long

'���ı��ַ�����ָ���ؼ��ֹ���
Private Declare Function RegSetValueEx_SZ Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, ByVal lpData As String, ByVal cbData As Long) As Long
Private Declare Function RegSetValueEx_DWORD Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Long, ByVal cbData As Long) As Long
Private Declare Function RegSetValueEx_BINARY Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long

'ɾ���ؼ���
Private Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long

'�ӵ�¼�ؼ�����ɾ��һ��ֵ
Private Declare Function RegDeleteValue Lib "advapi32.dll" Alias "RegDeleteValueA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long

'ɾ���������ע�����
Private Declare Function SHDeleteKey Lib "shlwapi.dll" Alias "SHDeleteKeyA" (ByVal hKey As Long, ByVal pszSubKey As String) As Long

' ע������������
Private Enum REGValueType

    REG_SZ = 1                             ' Unicode���ս��ַ���
    REG_EXPAND_SZ = 2                      ' Unicode���ս��ַ���
    REG_BINARY = 3                         ' ��������ֵ
    REG_DWORD = 4                          ' 32-bit ����
    REG_DWORD_BIG_ENDIAN = 5
    REG_LINK = 6
    REG_MULTI_SZ = 7                       ' ��������ֵ��

End Enum

' ע���������ֵ...
Const REG_OPTION_NON_VOLATILE = 0       ' ��ϵͳ��������ʱ���ؼ��ֱ�����

' ע���ؼ��ְ�ȫѡ��...
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

' �ض�����ע���64λ��samDesired����
Const KEY_WOW64_64KEY = &H100 ' �� 32 λ�� 64 λӦ�ó������ 64 λ��Կ
Const KEY_WOW64_32KEY = &H200 ' �� 32 λ�� 64 λӦ�ó������ 32 λ��Կ

Const KEY_ALL_ACCESS = KEY_QUERY_VALUE + KEY_SET_VALUE + _
      KEY_CREATE_SUB_KEY + KEY_ENUMERATE_SUB_KEYS + _
      KEY_NOTIFY + KEY_CREATE_LINK + READ_CONTROL + KEY_WOW64_64KEY


' ע���ؼ��ָ�����...
Private Enum REGRoot

    HKEY_CLASSES_ROOT = &H80000000
    HKEY_CURRENT_USER = &H80000001
    HKEY_LOCAL_MACHINE = &H80000002
    HKEY_USERS = &H80000003
    HKEY_PERFORMANCE_DATA = &H80000004

End Enum

' ����ֵ...
Const ERROR_NONE = 0
Const ERROR_BADKEY = 2
Const ERROR_ACCESS_DENIED = 8
Const ERROR_SUCCESS = 0

'- ע���ȫ��������...
Private Type SECURITY_ATTRIBUTES

    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Boolean

End Type

'*************************************************************************
'**�� �� ����WriteRegKey
'**��    �룺ByVal KeyRoot(REGRoot)         - ��
'**        ��ByVal KeyName(String)          - ����·��
'**        ��ByVal SubKeyName(String)       - ����
'**        ��ByVal SubKeyType(REGValueType) - ��������
'**        ��ByVal SubKeyValue(String)      - ��ֵ
'**��    ����(Boolean) - �ɹ�����True��ʧ�ܷ���False
'**����������дע���
'**ȫ�ֱ�����
'**����ģ�飺
'**��    �ߣ�Ҷ��
'**��    �ڣ�2003��01��10��
'**�� �� �ˣ�
'**��    �ڣ�
'**��    �����汾1.0
'*************************************************************************

Private Function WriteRegKey(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String, ByVal SubKeyType As REGValueType, ByVal SubKeyValue As String) As Boolean

    Dim rc As Long                                      ' ���ش���
    Dim hKey As Long                                    ' ����һ��ע���ؼ���
    Dim hDepth As Long                                  ' ����װ������ĳ��������һ������
    ' REG_CREATED_NEW_KEY�����½���һ������
    ' REG_OPENED_EXISTING_KEY������һ�����е���
    Dim lpAttr As SECURITY_ATTRIBUTES                   ' ע���ȫ����
    Dim i As Integer
    Dim bytValue(1024) As Byte

    lpAttr.nLength = 50                                 ' ���ð�ȫ����Ϊȱʡֵ...
    lpAttr.lpSecurityDescriptor = 0                     ' ...
    lpAttr.bInheritHandle = True                        ' ...

    '- ����/��ע���ؼ���...
    rc = RegCreateKeyEx(KeyRoot, KeyName, 0, SubKeyType, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, lpAttr, hKey, hDepth)                                                                                          ' ����/��//KeyRoot//KeyName
    'rc = RegCreateKeyEx(KeyRoot, KeyName, 0, SubKeyType, REG_OPTION_NON_VOLATILE, KEY_WOW64_64KEY, lpAttr, hKey, hDepth)                                                                                          ' ����/��//KeyRoot//KeyName



    If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError   ' ������...

    '- ����/�޸Ĺؼ���ֵ...

    If Len(SubKeyValue) = 0 Then SubKeyValue = " "        ' Ҫ��RegSetValueEx() ������Ҫ����һ���ո�...

    Select Case SubKeyType                                        ' ������������...

        Case REG_SZ, REG_EXPAND_SZ                                ' �ַ���ע���ؼ�����������

        rc = RegSetValueEx_SZ(hKey, SubKeyName, 0, SubKeyType, ByVal SubKeyValue, LenB(StrConv(SubKeyValue, vbFromUnicode)))

        If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError         ' ������

        Case REG_DWORD                                            ' ���ֽ�ע���ؼ�����������

        rc = RegSetValueEx_DWORD(hKey, SubKeyName, 0, SubKeyType, Val("&h" + SubKeyValue), 4)

        If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError         ' ������

        Case REG_BINARY                                           ' �������ַ���

        Dim intNum As Integer

        For i = 1 To Len(Trim$(SubKeyValue)) - 1 Step 3

            intNum = intNum + 1
            bytValue(intNum - 1) = Val("&h" + Mid$(SubKeyValue, i, 2))

        Next

        rc = RegSetValueEx_BINARY(hKey, SubKeyName, 0, SubKeyType, bytValue(0), intNum)

        If (rc <> ERROR_SUCCESS) Then GoTo CreateKeyError   ' ������

        Case Else

        GoTo CreateKeyError                                    ' ������

    End Select

    '- �ر�ע���ؼ���...
    rc = RegCloseKey(hKey)                              ' �رչؼ���

    WriteRegKey = True                                  ' ���سɹ�

    Exit Function                                       ' �˳�

CreateKeyError:

    WriteRegKey = False                                 ' ���ô��󷵻ش���
    rc = RegCloseKey(hKey)                              ' ��ͼ�رչؼ���

End Function

'*************************************************************************
'**�� �� ����ReadRegKey
'**��    �룺KeyRoot(Long)     - ��
'**        ��KeyName(String)   - ����·��
'**        ��SubKeyRef(String) - ����
'**��    ����(String) - ���ؼ�ֵ
'**������������ע���
'**ȫ�ֱ�����
'**����ģ�飺
'**��    �ߣ�Ҷ��
'**��    �ڣ�2003��01��10��
'**�� �� �ˣ�
'**��    �ڣ�
'**��    �����汾1.0
'*************************************************************************

Private Function ReadRegKey(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String) As String

    Dim i As Long                                            ' ѭ��������
    Dim rc As Long                                           ' ���ش���
    Dim hKey As Long                                         ' ����򿪵�ע���ؼ���
    Dim hDepth As Long                                       '
    Dim sKeyVal As String
    Dim lKeyValType As Long                                  ' ע���ؼ�����������
    Dim tmpVal As String                                     ' ע���ؼ��ֵ���ʱ�洢��
    Dim KeyValSize As Long                                   ' ע���ؼ��ֱ����ߴ�
    Dim lngValue As Long
    Dim bytValue(1024) As Byte

    ' �� KeyRoot�´�ע���ؼ���

    rc = RegOpenKeyEx(KeyRoot, KeyName, 0, KEY_ALL_ACCESS, hKey)   ' ��ע���ؼ���
    'rc = RegOpenKeyEx(KeyRoot, KeyName, 0, KEY_WOW64_64KEY, hKey)   ' ��ע���ؼ���

    If (rc <> ERROR_SUCCESS) Then GoTo GetKeyError                 ' �������...

    ' ����������

    rc = RegQueryValueEx(hKey, SubKeyName, 0, lKeyValType, ByVal 0, KeyValSize)  ' ���/�����ؼ��ֵ�ֵlKeyValType

    If (rc <> ERROR_SUCCESS) Then GoTo GetKeyError                 ' �������...

    '����Ӧ�ļ�ֵ

    Select Case lKeyValType                                         ' ������������...

        Case REG_SZ, REG_EXPAND_SZ                                  ' �ַ���ע���ؼ�����������

        tmpVal = String$(1024, 0)                                   ' ��������ռ�
        KeyValSize = 1024                                           ' ��Ǳ����ߴ�

        rc = RegQueryValueEx_SZ(hKey, SubKeyName, 0, 0, tmpVal, KeyValSize)     ' ���/�����ؼ��ֵ�ֵ
        
        If rc <> ERROR_SUCCESS Then GoTo GetKeyError           ' ������

        If InStr(tmpVal, Chr$(0)) > 0 Then sKeyVal = Left$(tmpVal, InStr(tmpVal, Chr$(0)) - 1)     ' �����ַ�����ֵ,��ȥ�����ַ�.
        
        Case REG_DWORD                                             ' ���ֽ�ע���ؼ�����������
        
        KeyValSize = 1024                                          ' ��Ǳ����ߴ�
        rc = RegQueryValueEx_DWORD(hKey, SubKeyName, 0, 0, lngValue, KeyValSize)     ' ���/�����ؼ��ֵ�ֵ
        
        If rc <> ERROR_SUCCESS Then GoTo GetKeyError            ' ������
        
        sKeyVal = "0x" + Hex$(lngValue)
        
        Case REG_BINARY                                            ' �������ַ���
        
        rc = RegQueryValueEx(hKey, SubKeyName, 0, 0, bytValue(0), KeyValSize)       ' ���/�����ؼ��ֵ�ֵ

        If rc <> ERROR_SUCCESS Then GoTo GetKeyError            ' ������

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

    ReadRegKey = sKeyVal                                      ' ����ֵ
    rc = RegCloseKey(hKey)                                    ' �ر�ע���ؼ���
    
    Exit Function                                             ' �˳�

GetKeyError:

    ' ����������������...

    ReadRegKey = ""                                      ' ���÷���ֵΪ����

    rc = RegCloseKey(hKey)                                    ' �ر�ע���ؼ���

End Function

'*************************************************************************
'**�� �� ����DelRegKey
'**��    �룺KeyRoot(Long)     - ��
'**        ��KeyName(String)   - ����·��
'**        ��SubKeyRef(String) - ����
'**��    ����(Long) - ״̬��
'**����������ɾ���ؼ���
'**ȫ�ֱ�����
'**����ģ�飺
'**��    �ߣ�Ҷ��
'**��    �ڣ�2003��01��11��
'**�� �� �ˣ�
'**��    �ڣ�
'**��    �����汾1.0
'*************************************************************************

Private Function DelRegKey(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String) As Long

    Dim lKeyId          As Long
    Dim lResult         As Long

    '������õĲ���
    If Len(KeyName) = 0 And Len(SubKeyName) = 0 Then

        ' ��ֵû�����򷵻���Ӧ������
        DelRegKey = ERROR_BADKEY

        Exit Function

    End If

    ' �򿪹ؼ��ֲ����Դ�����,����Ѵ���,�򷵻�IDֵ
    lResult = RegCreateKey(KeyRoot, KeyName, lKeyId)

    If lResult = 0 Then

        'ɾ���ؼ���
        DelRegKey = RegDeleteKey(lKeyId, ByVal SubKeyName)

    End If

End Function

'*************************************************************************
'**�� �� ����DelRegValue
'**��    �룺KeyRoot(Long)     - ��
'**        ��KeyName(String)   - ����·��
'**        ��SubKeyRef(String) - ����
'**��    ����(Long) - ״̬��
'**�����������ӵ�¼�ؼ�����ɾ��һ��ֵ
'**ȫ�ֱ�����
'**����ģ�飺
'**��    �ߣ�Ҷ��
'**��    �ڣ�2003��01��11��
'**�� �� �ˣ�
'**��    �ڣ�
'**��    �����汾1.0
'*************************************************************************

Private Function DelRegValue(ByVal KeyRoot As REGRoot, ByVal KeyName As String, ByVal SubKeyName As String) As Long

    Dim lKeyId As Long
    Dim lResult As Long

    '������õĲ���
    If Len(KeyName) = 0 And Len(SubKeyName) = 0 Then

        ' ��ֵû�����򷵻���Ӧ������
        DelRegValue = ERROR_BADKEY

        Exit Function

    End If

    ' �򿪹ؼ��ֲ����Դ�����,����Ѵ���,�򷵻�IDֵ
    lResult = RegCreateKey(KeyRoot, KeyName, lKeyId)

    If lResult = 0 Then

        '�ӵ�¼�ؼ�����ɾ��һ��ֵ
        DelRegValue = RegDeleteValue(lKeyId, ByVal SubKeyName)

    End If

End Function

Public Sub AddStart()       '����ʱ����������Ŀ

    'WriteRegKey HKEY_LOCAL_MACHINE, ByVal "Software\Microsoft\Windows\CurrentVersion\Run", _
                ByVal "����", REG_SZ, ByVal App.Path & "\����1.exe"
    WriteRegKey HKEY_LOCAL_MACHINE, ByVal "Software\Microsoft\Windows\CurrentVersion\Run", _
                ByVal "����", REG_SZ, ByVal App.Path & "\����1.exe"

End Sub

Public Sub RemoveStart()    '�Ƴ�������Ŀ,������õ�DelRegValue,DelRegKey��һ���Ĳ���,�Ͳ�д������.

    DelRegValue HKEY_LOCAL_MACHINE, ByVal "Software\Microsoft\Windows\CurrentVersion\Run", ByVal "����"

End Sub

'=============================================================================================

'ɾ��ע�����
Public Function DeteleRegItem(rRoot As Long, SoftPath As String) As Boolean
    Dim lngFlag As Long
    lngFlag = SHDeleteKey(rRoot, SoftPath)
    If lngFlag = 0 Then
        DeteleRegItem = True
    Else
        DeteleRegItem = False
    End If
End Function

'ɾ��ע����HKEY_LOCAL_MACHINE
Public Function DeleteRegKeyHKLM(SoftPath As String, KW As String) As Boolean
    DeleteRegKeyHKLM = DelRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW)
End Function

'ɾ��ע����HKEY_CURRENT_USER
Public Function DeleteRegKeyHKCU(SoftPath As String, KW As String) As Boolean
    DeleteRegKeyHKCU = DelRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW)
End Function

'ɾ��ע����ֵHKEY_LOCAL_MACHINE
Public Function DeleteRegValueHKLM(SoftPath As String, KW As String) As Boolean
    DeleteRegValueHKLM = DelRegValue(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW)
End Function

'ɾ��ע����ֵHKEY_CURRENT_USER
Public Function DeleteRegValueHKCU(SoftPath As String, KW As String) As Boolean
    DeleteRegValueHKCU = DelRegValue(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW)
End Function

'д��HKEY_LOCAL_MACHINE
Public Function WriteRegHKLM(SoftPath As String, ValueType As String, KW As String, Description As String) As Boolean
    If UCase(ValueType) = "REG_DWORD" Then
        WriteRegHKLM = WriteRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW, REG_DWORD, ByVal Description)
    Else
        WriteRegHKLM = WriteRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW, REG_SZ, ByVal Description)
    End If
End Function

'д��HKEY_CURRENT_USER
Public Function WriteRegHKCU(SoftPath As String, ValueType As String, KW As String, Description As String) As Boolean
    If UCase(ValueType) = "REG_DWORD" Then
        WriteRegHKCU = WriteRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW, REG_DWORD, ByVal Description)
    Else
        WriteRegHKCU = WriteRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW, REG_SZ, ByVal Description)
    End If
End Function

'��ȡHKEY_LOCAL_MACHINE
Public Function ReadRegHKLM(SoftPath As String, KW As String) As String
    ReadRegHKLM = ReadRegKey(HKEY_LOCAL_MACHINE, ByVal SoftPath, ByVal KW)
End Function

'��ȡHKEY_CURRENT_USER
Public Function ReadRegHKCU(SoftPath As String, KW As String) As String
    ReadRegHKCU = ReadRegKey(HKEY_CURRENT_USER, ByVal SoftPath, ByVal KW)
End Function

'=============================================================================================


Public Function ReadscrKeyValue() As String  '��ȡ�Ƿ�����Ļ��������
    ReadscrKeyValue = ReadRegKey(HKEY_CURRENT_USER, ByVal "Control Panel\Desktop", ByVal "SCRNSAVE.EXE")
End Function

Public Function DelscrKeyValue() As String   'ɾ����Ļ��������
    DelRegValue HKEY_CURRENT_USER, ByVal "Control Panel\Desktop", ByVal "SCRNSAVE.EXE"
End Function

Public Function SetScrKeyValue(scrfilePath As String) As Boolean
    'myReg.UpdateKey HKEY_CURRENT_USER, "Control Panel\Desktop", "SCRNSAVE.EXE", strSavername
    SetScrKeyValue = WriteRegKey(HKEY_CURRENT_USER, "Control Panel\Desktop", "SCRNSAVE.EXE", REG_SZ, ByVal scrfilePath)
End Function




