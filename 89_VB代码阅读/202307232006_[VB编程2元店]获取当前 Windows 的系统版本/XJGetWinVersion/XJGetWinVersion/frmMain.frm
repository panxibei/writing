VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "XJGetWinVersion"
   ClientHeight    =   1815
   ClientLeft      =   105
   ClientTop       =   450
   ClientWidth     =   3975
   LinkTopic       =   "Form1"
   ScaleHeight     =   1815
   ScaleWidth      =   3975
   StartUpPosition =   2  '屏幕中心
   Begin VB.CommandButton Command3 
      Caption         =   "通过WMI查询操作系统信息"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   1200
      Width           =   3495
   End
   Begin VB.CommandButton Command2 
      Caption         =   "通过WMI查询操作系统版本"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   600
      Width           =   3495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "通过注册表查询操作系统版本"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   3495
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' **************************************
'
'    模块: 网管小贾的获取Windows版本演示代码
'
'
'          XJGetWinVersion
'
'
'    日期: 2023/08/02
'
'    作者: 网管小贾
'
'    微信公众号: 网管小贾
'
'    个人博客: www.sysadm.cc
'
' **************************************

' 通过注册表查询操作系统版本
Private Sub Command1_Click()
    Dim strRegPath As String
    Dim strKey As String
    Dim strValue As String

    strRegPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion"

    strKey = "ProductName"
    MsgBox ReadRegHKLM(strRegPath, strKey)
End Sub


' 通过WMI查询操作系统版本
Private Sub Command2_Click()
    Dim strComputer As String
    Dim objWMIService As Object, objItem As Object, objColItems As Object
    
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
    Set objColItems = objWMIService.ExecQuery( _
        "SELECT * FROM Win32_OperatingSystem", , 48)
    For Each objItem In objColItems
        MsgBox objItem.Caption
    Next
End Sub


' 通过WMI查询操作系统信息
Private Sub Command3_Click()
    Dim strComputer As String, strMsg As String
    Dim objWMIService As Object, objItem As Object, objColItems As Object, ObjCvDate As Object
    
    strComputer = "."
    Set ObjCvDate = CreateObject("WbemScripting.SWbemDateTime")
    Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
    Set objColItems = objWMIService.ExecQuery( _
        "SELECT * FROM Win32_OperatingSystem", , 48)
    For Each objItem In objColItems
    
        strMsg = "-----------------------------------" & vbCrLf & _
            "Win32_OperatingSystem instance" & vbCrLf & _
            "-----------------------------------" & vbCrLf & _
            "BootDevice: " & objItem.BootDevice & vbCrLf & _
            "BuildNumber: " & objItem.BuildNumber & vbCrLf & _
            "BuildType: " & objItem.BuildType & vbCrLf & _
            "Caption: " & objItem.Caption & vbCrLf & _
            "CodeSet: " & objItem.CodeSet & vbCrLf & _
            "CountryCode: " & objItem.CountryCode & vbCrLf & _
            "CreationClassName: " & objItem.CreationClassName & vbCrLf & _
            "CSCreationClassName: " & objItem.CSCreationClassName & vbCrLf & _
            "CSDVersion: " & objItem.CSDVersion & vbCrLf & _
            "CSName: " & objItem.CSName & vbCrLf & _
            "CurrentTimeZone: " & objItem.CurrentTimeZone & vbCrLf & _
            "DataExecutionPrevention_32BitApplications: " & objItem.DataExecutionPrevention_32BitApplications & vbCrLf & _
            "DataExecutionPrevention_Available: " & objItem.DataExecutionPrevention_Available & vbCrLf & _
            "DataExecutionPrevention_Drivers: " & objItem.DataExecutionPrevention_Drivers & vbCrLf

        ObjCvDate.Value = objItem.InstallDate
        
        strMsg = strMsg & "DataExecutionPrevention_SupportPolicy: " & objItem.DataExecutionPrevention_SupportPolicy & vbCrLf & _
            "Debug: " & objItem.Debug & vbCrLf & _
            "Description: " & objItem.Description & vbCrLf & _
            "Distributed: " & objItem.Distributed & vbCrLf & _
            "EncryptionLevel: " & objItem.EncryptionLevel & vbCrLf & _
            "ForegroundApplicationBoost: " & objItem.ForegroundApplicationBoost & vbCrLf & _
            "FreePhysicalMemory: " & objItem.FreePhysicalMemory & vbCrLf & _
            "FreeSpaceInPagingFiles: " & objItem.FreeSpaceInPagingFiles & vbCrLf & _
            "FreeVirtualMemory: " & objItem.FreeVirtualMemory & vbCrLf & _
            "InstallDate: " & CDate(ObjCvDate.GetVarDate) & vbCrLf & _
            "LargeSystemCache: " & objItem.LargeSystemCache & vbCrLf & _
            "LastBootUpTime: " & objItem.LastBootUpTime & vbCrLf & _
            "LocalDateTime: " & objItem.LocalDateTime & vbCrLf & _
            "Locale: " & objItem.Locale & vbCrLf & _
            "Manufacturer: " & objItem.Manufacturer & vbCrLf & _
            "MaxNumberOfProcesses: " & objItem.MaxNumberOfProcesses & vbCrLf & _
            "MaxProcessMemorySize: " & objItem.MaxProcessMemorySize & vbCrLf

        MsgBox strMsg

        If IsNull(objItem.MUILanguages) Then
            strMsg = "MUILanguages: " & vbCrLf
        Else
            strMsg = "MUILanguages: " & Join(objItem.MUILanguages, ",") & vbCrLf
        End If
        
        strMsg = strMsg & "Name: " & objItem.Name & vbCrLf & _
            "NumberOfLicensedUsers: " & objItem.NumberOfLicensedUsers & vbCrLf & _
            "NumberOfProcesses: " & objItem.NumberOfProcesses & vbCrLf & _
            "NumberOfUsers: " & objItem.NumberOfUsers & vbCrLf & _
            "OperatingSystemSKU: " & objItem.OperatingSystemSKU & vbCrLf & _
            "Organization: " & objItem.Organization & vbCrLf & _
            "OSArchitecture: " & objItem.OSArchitecture & vbCrLf & _
            "OSLanguage: " & objItem.OSLanguage & vbCrLf & _
            "OSProductSuite: " & objItem.OSProductSuite & vbCrLf & _
            "OSType: " & objItem.OSType & vbCrLf & _
            "OtherTypeDescription: " & objItem.OtherTypeDescription & vbCrLf & _
            "PAEEnabled: " & objItem.PAEEnabled & vbCrLf & _
            "PlusProductID: " & objItem.PlusProductID & vbCrLf & _
            "PlusVersionNumber: " & objItem.PlusVersionNumber & vbCrLf & _
            "PortableOperatingSystem: " & objItem.PortableOperatingSystem & vbCrLf & _
            "Primary: " & objItem.Primary & vbCrLf

        strMsg = strMsg & "ProductType: " & objItem.ProductType & vbCrLf & _
            "RegisteredUser: " & objItem.RegisteredUser & vbCrLf & _
            "SerialNumber: " & objItem.SerialNumber & vbCrLf & _
            "ServicePackMajorVersion: " & objItem.ServicePackMajorVersion & vbCrLf & _
            "ServicePackMinorVersion: " & objItem.ServicePackMinorVersion & vbCrLf & _
            "SizeStoredInPagingFiles: " & objItem.SizeStoredInPagingFiles & vbCrLf & _
            "Status: " & objItem.Status & vbCrLf & _
            "SuiteMask: " & objItem.SuiteMask & vbCrLf & _
            "SystemDevice: " & objItem.SystemDevice & vbCrLf & _
            "SystemDirectory: " & objItem.SystemDirectory & vbCrLf & _
            "SystemDrive: " & objItem.SystemDrive & vbCrLf & _
            "TotalSwapSpaceSize: " & objItem.TotalSwapSpaceSize & vbCrLf & _
            "TotalVirtualMemorySize: " & objItem.TotalVirtualMemorySize & vbCrLf & _
            "TotalVisibleMemorySize: " & objItem.TotalVisibleMemorySize & vbCrLf & _
            "Version: " & objItem.Version & vbCrLf & _
            "WindowsDirectory: " & objItem.WindowsDirectory

        MsgBox strMsg

    Next

End Sub
