'-----------------------------------------------------------------------------------------
'һ�r�Ĥ˥ǩ`�����Ф���ե���������ɤ��륹����ץȡ�
'   1. ���Хե�����ڤ�User��-������������-�����ո��Υե���������ɤ��롣
'   2. ���ɤ��줿User��-������������-�����ո��Υե�����ؤΥ���`�ȥ��åȤ�
'      �g�Ф���User�Υǥ����ȥå��Ϥ˱��椹�롣
'   3. �ե������Drag&Drop����ȡ����ɤ�������`�ȥ��å��Ȥإ��åץ�`�ɤ��롣
'   4. ���ɤ�������`�ȥ��å��ȤΥѥ��򥯥�åץܩ`�ɤإ��ԩ`���롣
'   5. �˜ʥ�`��`�ˤ���Ҏ��`����Ԅ����ɤ����ѥ����Ԅ�ӛ�d���롣(HyperLink)
'-----------------------------------------------------------------------------------------
Option Explicit
On Error Resume Next

' �����O��--------------------------------------------------------------------------------
Dim strShareFolder
Dim strAppFolder
Dim intCharNo
Dim intAddDate
Dim intArgNum
Dim intMailFlag
Dim strUserName
Dim strRandomChar
Dim strDate
Dim strFolderName
Dim strShortcutPath
Dim strArgUser
Dim strMail
Dim strNewLine
Dim objFSO
Dim objNetwork
Dim objWSH
Dim objSH
Dim objSC
Dim objIE
Dim objOL
Dim ArgArray
Dim MailItem

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objNetwork = WScript.CreateObject("WScript.Network")
Set objWSH = CreateObject("WScript.Shell")
Set objSH = WScript.CreateObject("Shell.Application")
Set ArgArray = WScript.Arguments
set objIE = createobject("internetexplorer.application")

strShareFolder = "\\a89219\TempShare$"       ' ���Хե������ָ��
strAppFolder = "\\a89219\Soft$"       ' application folder
strUserName = objNetwork.UserName              ' VBScript��g�Ф�����`������ȡ��
intCharNo = 8                                  ' ���������֤�8����ȡ��
strRandomChar = RandomChar(intCharNo)          ' ָ�������������Υ����������Ф�ȡ��
intAddDate = 3                                 ' 3������ո���ָ��
strDate = CalculateDate(intAddDate)            ' ָ�������ո���YYYYMMDD��ʽ��ȡ��
strFolderName = strUserName & "-" & strRandomChar & "-" & strDate ' ���ɤ���ե��������ָ��
intArgNum = WScript.Arguments.Count            ' ����������ȡ��
intMailFlag = 0                                ' 0 - outlookֱ��`������, 1 - IE�U��

' Create TempShare folder-------------------------------------------------------------------
objFSO.CreateFolder(strShareFolder & "\" & strFolderName)
If Err.Number <> 0 Then
	Msgbox err.description
   msgbox "An error occurred during folder creating." & vbCrLf & "ErrNo: " & Err.Number
End If

' Change privileges
ModifyFolderPermissions(strShareFolder & "\" & strFolderName)

' Create shortcut of remote folder into desktop
strShortcutPath = objWSH.SpecialFolders("Desktop")
Set objSC = objWSH.CreateShortcut(strShortcutPath & "\" & strFolderName & ".lnk")
objSC.TargetPath = strShareFolder & "\" & strFolderName
objSC.IconLocation = strAppFolder & "\TempShareOpenIcon.ico, 0"
objSC.Save
If Err.Number <> 0 Then
   msgbox "An error occurred during shortcut creating ." & vbCrLf & "ErrNo: " & Err.Number
End If


' TempShare�ե�����Υѥ��򥯥�åץܩ`�ɤإ��ԩ`����Office365�ä�<PATH>����ʽ�Ȥ���------
PutInClipboardText "file:///" & strShareFolder & "\" & strFolderName & "\"
If Err.Number <> 0 Then
   msgbox "Could not copy TempShare path to clibpoard." & vbCrLf & "ErrNo: " & Err.Number
End If

' ��`��`:outlook���i���z�ߡ���`�����ɡ�outlook���o�����Ϥ�IE�U�ɤ��ƥ�`��`������-----
' ������IE�U�ɤ���Web����ƥ�ĥ��������S�ɴ_�J�ξ��������������ʾ�����---------------

Set objOL = CreateObject("Outlook.Application")
Set MailItem = objOL.CreateItem(0)
If Err.Number <> 0 Then
   intMailFlag = 1
End If

' �ƥ�ץ�`�ȥ�`������ (outlook�θ���:vbCrLf��IE�U�ɤǤθ��У�%0D%0A--------------------
If intMailFlag = 0 Then
   strNewLine=vbCrLf
'   strNewLine=vbNewLine
'   strNewLine=vbLf
'   strNewLine=vbCr
Else
   strNewLine = "%0D%0A"
End If
strMail = " " & strNewLine & " " & strNewLine &_
          "<--------------------------------------------------------------------------------------------------------------->" & strNewLine &_
          "   AccessPATH:  file:///" & strShareFolder & "\" & strFolderName & "\" & strNewLine & " " &_
          strNewLine &_
          "  [Guidance]" & strNewLine &_
"     This is a temporary folder for transmitting files between company PCs." & strNewLine &_
"     Click the above AccessPATH, and you can download/upload files freely." & strNewLine &_
"     Attention, files will be deleted automatically after " & Mid(strDate, 5, 2) & "/" & Right(strDate, 2) & "/" &Left(strDate, 4) & "(MM/DD/YYYY)." & strNewLine &_
          "<--------------------------------------------------------------------------------------------------------------->" & strNewLine & strNewLine & strNewLine


If intMailFlag = 0 Then
' Create Template mail via outlook
   MailItem.Body = strMail
   MailItem.Display
Else
' Create Template mail via Internet Explorer
   objIE.visible=false
   objIE.navigate("mailto:?body=" & strMail)
End If


'If intArgNum = 0 Then
   objSH.Explore strShareFolder & "\" & strFolderName & "\"
   If Err.Number <> 0 Then
      msgbox "Could not create template mail via Internet Explorer." & vbCrLf & "ErrNo: " & Err.Number
   End If
'End If

Set MailItem = Nothing
Set objOL = Nothing
Set objSC = Nothing
Set objSH = Nothing
Set ArgArray = Nothing
set objIE = Nothing
Set objWSH = Nothing
Set objFSO = Nothing
Set objNetwork = Nothing



' �����Ф򥯥�åץܩ`�ɤإ��ԩ`����Function----------------------------------------------
Function PutInClipboardText(ByVal strString)
   Dim cmd

   cmd = "cmd /c ""echo " & strString & "| clip"""
   CreateObject("WScript.Shell").Run cmd, 0

End Function

' Modify Folder Permissions Function----------------------------------------------
Function ModifyFolderPermissions(ByVal strFolder)
   Dim strCmd

   
   strCmd = "cmd /c ""ICACLS " & strFolder & " /inheritance:d"""
   CreateObject("WScript.Shell").Run strCmd, 0
   
   strCmd = "cmd /c ""ICACLS " & strFolder & " /remove ""TempShare"""
   CreateObject("WScript.Shell").Run strCmd, 0

   strCmd = "cmd /c ""ICACLS " & strFolder & " /remove ""Domain Users"""
   CreateObject("WScript.Shell").Run strCmd, 0

   
	' Paramete of Argument, Users who would be added to access
	If intArgNum > 0 Then
	   For Each strArgUser in ArgArray

		  ' ֻ��Ȩ��
		  'strCmd = "cmd /c ""ICACLS " & strFolder & " /grant:r " & strArgUser & ":(RC,RD,REA,X,RA)"""
		  'CreateObject("WScript.Shell").Run strCmd, 0

		  ' ��дȨ��
		  strCmd = "cmd /c ""ICACLS " & strFolder & " /grant:r " & strArgUser & ":(OI)(CI)(RC,S,RD,WD,AD,DC,REA,WEA,X,RA,WA)"""
		  CreateObject("WScript.Shell").Run strCmd, 0
	   
	      If Err.Number <> 0 Then
			Msgbox "Permissions setup error!" & vbCrLf & "ErrNo: " & Err.Number
		  End If

	   
	   Next
	End If
   
End Function



' ������ָ�����줿�������ǥ�����������(1��9/A��Z/a��z/_-$!)�����ɤ���Function----------
Function RandomChar(intCharNo)
   Dim intValue
   Dim i
   Dim strRND
   Dim strTMP

   i = 1
   strRND = ""
   Do While i <= intCharNo
      intValue = 0
      Randomize
      intValue = Int((65) * Rnd + 1)
      strTMP = intValue
      Select Case intValue
         Case 10
            strTMP = "A"
         Case 11
            strTMP = "B"
         Case 12
            strTMP = "C"
         Case 13
            strTMP = "D"
         Case 14
            strTMP = "E"
         Case 15
            strTMP = "F"
         Case 16
            strTMP = "G"
         Case 17
            strTMP = "H"
         Case 18
            strTMP = "I"
         Case 19
            strTMP = "J"
         Case 20
            strTMP = "K"
         Case 21
            strTMP = "L"
         Case 22
            strTMP = "M"
         Case 23
            strTMP = "N"
         Case 24
            strTMP = "O"
         Case 25
            strTMP = "P"
         Case 26
            strTMP = "Q"
         Case 27
            strTMP = "R"
         Case 28
            strTMP = "S"
         Case 29
            strTMP = "T"
         Case 30
            strTMP = "U"
         Case 31
            strTMP = "V"
         Case 32
            strTMP = "W"
         Case 33
            strTMP = "X"
         Case 34
            strTMP = "Y"
         Case 35
            strTMP = "Z"
         Case 36
            strTMP = "_"
         Case 37
            strTMP = "-"
         Case 38
            strTMP = "$"
         Case 39
            strTMP = "!"
         Case 40
            strTMP = "a"
         Case 41
            strTMP = "b"
         Case 42
            strTMP = "c"
         Case 43
            strTMP = "d"
         Case 44
            strTMP = "e"
         Case 45
            strTMP = "f"
         Case 46
            strTMP = "g"
         Case 47
            strTMP = "h"
         Case 48
            strTMP = "i"
         Case 49
            strTMP = "j"
         Case 50
            strTMP = "k"
         Case 51
            strTMP = "l"
         Case 52
            strTMP = "m"
         Case 53
            strTMP = "n"
         Case 54
            strTMP = "o"
         Case 55
            strTMP = "p"
         Case 56
            strTMP = "q"
         Case 57
            strTMP = "r"
         Case 58
            strTMP = "s"
         Case 59
            strTMP = "t"
         Case 60
            strTMP = "u"
         Case 61
            strTMP = "v"
         Case 62
            strTMP = "w"
         Case 63
            strTMP = "x"
         Case 64
            strTMP = "y"
         Case 65
            strTMP = "z"
      End Select
      strRND = strRND & strTMP
      i = i+1
   Loop
   RandomChar = strRND
End Function


' ָ��������������㤷���ո��򷵤�(��ʽ��YYYYMMDD)��Function-----------------------------
Function CalculateDate(intAddDate)
   Dim strDate
   strDate = Year(DateAdd("d", intAddDate, Date)) & Right("0" & Month(DateAdd("d", intAddDate, Date)), 2) & Right("0" & Day(DateAdd("d", intAddDate, Date)), 2)
   CalculateDate = strDate
End Function

 '----------------------------------------------------------------------------------------


