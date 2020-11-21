'-----------------------------------------------------------------------------------------
'一時的にデータを共有するフォルダを作成するスクリプト　
'   1. 共有フォルダ内へUser名-ランダム文字列-削除日付のフォルダを生成する。
'   2. 生成されたUser名-ランダム文字列-削除日付のフォルダへのショートカットを
'      実行したUserのデスクトップ上に保存する。
'   3. ファイルをDrag&Dropすると、作成したショートカット先へアップロードする。
'   4. 作成したショートカット先のパスをクリップボードへコピーする。
'   5. 標準メーラーにて新規メールを自動作成し、パスを自動記載する。(HyperLink)
'-----------------------------------------------------------------------------------------
Option Explicit
On Error Resume Next

' 初期設定--------------------------------------------------------------------------------
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

strShareFolder = "\\a89219\TempShare$"       ' 共有フォルダを指定
strAppFolder = "\\a89219\Soft$"       ' application folder
strUserName = objNetwork.UserName              ' VBScriptを実行したユーザ名を取得
intCharNo = 8                                  ' ランダム文字を8文字取得
strRandomChar = RandomChar(intCharNo)          ' 指定した文字数のランダム文字列を取得
intAddDate = 3                                 ' 3日後の日付を指定
strDate = CalculateDate(intAddDate)            ' 指定した日付をYYYYMMDD形式で取得
strFolderName = strUserName & "-" & strRandomChar & "-" & strDate ' 作成するフォルダ名を指定
intArgNum = WScript.Arguments.Count            ' 引数の数を取得
intMailFlag = 0                                ' 0 - outlook直メール作成, 1 - IE経由

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


' TempShareフォルダのパスをクリップボードへコピー　（Office365用に<PATH>の形式とする------
PutInClipboardText "file:///" & strShareFolder & "\" & strFolderName & "\"
If Err.Number <> 0 Then
   msgbox "Could not copy TempShare path to clibpoard." & vbCrLf & "ErrNo: " & Err.Number
End If

' メーラー:outlookを読み込み、メール作成。outlookが無い場合はIE経由してメーラーを起動-----
' 但し、IE経由だとWebコンテンツアクセス許可確認の警告ダイアログが表示される---------------

Set objOL = CreateObject("Outlook.Application")
Set MailItem = objOL.CreateItem(0)
If Err.Number <> 0 Then
   intMailFlag = 1
End If

' テンプレートメール作成 (outlookの改行:vbCrLf、IE経由での改行：%0D%0A--------------------
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



' 文字列をクリップボードへコピーするFunction----------------------------------------------
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

		  ' 只读权限
		  'strCmd = "cmd /c ""ICACLS " & strFolder & " /grant:r " & strArgUser & ":(RC,RD,REA,X,RA)"""
		  'CreateObject("WScript.Shell").Run strCmd, 0

		  ' 可写权限
		  strCmd = "cmd /c ""ICACLS " & strFolder & " /grant:r " & strArgUser & ":(OI)(CI)(RC,S,RD,WD,AD,DC,REA,WEA,X,RA,WA)"""
		  CreateObject("WScript.Shell").Run strCmd, 0
	   
	      If Err.Number <> 0 Then
			Msgbox "Permissions setup error!" & vbCrLf & "ErrNo: " & Err.Number
		  End If

	   
	   Next
	End If
   
End Function



' 引数で指定された文字数でランダム文字列(1～9/A～Z/a～z/_-$!)を生成するFunction----------
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


' 指定した日数を加算した日付を返す(形式：YYYYMMDD)　Function-----------------------------
Function CalculateDate(intAddDate)
   Dim strDate
   strDate = Year(DateAdd("d", intAddDate, Date)) & Right("0" & Month(DateAdd("d", intAddDate, Date)), 2) & Right("0" & Day(DateAdd("d", intAddDate, Date)), 2)
   CalculateDate = strDate
End Function

 '----------------------------------------------------------------------------------------


