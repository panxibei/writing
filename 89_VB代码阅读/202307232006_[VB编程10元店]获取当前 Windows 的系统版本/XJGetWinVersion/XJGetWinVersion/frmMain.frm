VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "XJGetWinVersion"
   ClientHeight    =   1840
   ClientLeft      =   110
   ClientTop       =   450
   ClientWidth     =   2980
   LinkTopic       =   "Form1"
   ScaleHeight     =   1840
   ScaleWidth      =   2980
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   610
      Left            =   840
      TabIndex        =   0
      Top             =   720
      Width           =   1450
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
    Dim strRegPath As String
    Dim strKey As String
    Dim strValue As String



    strRegPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion"

    strKey = "ProductName"
    'strValue = "1"
    MsgBox ReadRegHKLM(strRegPath, strKey)



End Sub
