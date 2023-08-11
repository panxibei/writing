VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Program 2"
   ClientHeight    =   5070
   ClientLeft      =   5925
   ClientTop       =   555
   ClientWidth     =   5295
   Icon            =   "frmProg2.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "frmProgram2"
   MaxButton       =   0   'False
   ScaleHeight     =   5070
   ScaleWidth      =   5295
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   120
      LinkItem        =   "Text3"
      Locked          =   -1  'True
      TabIndex        =   10
      Top             =   3960
      Width           =   5055
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   120
      LinkItem        =   "Text2"
      TabIndex        =   7
      Top             =   3120
      Width           =   5055
   End
   Begin VB.PictureBox Picture2 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   360
      LinkItem        =   "Picture2"
      Picture         =   "frmProg2.frx":0442
      ScaleHeight     =   495
      ScaleWidth      =   1410
      TabIndex        =   6
      Top             =   2160
      Width           =   1410
   End
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      Height          =   495
      Left            =   360
      LinkItem        =   "Picture1"
      ScaleHeight     =   435
      ScaleWidth      =   1410
      TabIndex        =   3
      Top             =   1200
      Width           =   1470
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      LinkItem        =   "Text1"
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   360
      Width           =   5055
   End
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "Exit"
      Height          =   495
      Left            =   2100
      TabIndex        =   0
      Top             =   4440
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "5) This is the destination textbox in Program 1's section 5's experinent:"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   3600
      Width           =   5055
   End
   Begin VB.Label Label4 
      Caption         =   "4) Type something into this textbox:"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   2760
      Width           =   5055
   End
   Begin VB.Label Label3 
      Caption         =   "3) This picture will be sent to Program 1 if it requests it:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1800
      Width           =   5055
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "2) Here will be the same picture as in Program 1 if you click the <Send> button in Program 1:"
      Height          =   390
      Left            =   120
      TabIndex        =   4
      Top             =   720
      Width           =   5115
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "1) Here will be the text you type to the textbox in Program 1:"
      Height          =   195
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   4200
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Please begin exploring this tutorial's code from Program1's
'code!

Option Explicit

Private Sub Command1_Click()
    'Tell Program 1 that I (Program 2) am closing.
    With Text1
        .LinkMode = 0
        .LinkTopic = "Program1|frmProgram1"
        On Error Resume Next 'This line is because if
                             'Program 1 is not opened this
                             'program can't tell him/her
                             'that I (Program2) am closing!
        .LinkMode = 2
        .LinkExecute "Closed" 'Tells Program 1 that I am
                              'closing.
    End With
    End 'Exits the program
End Sub

Private Sub Form_LinkExecute(CmdStr As String, Cancel As Integer)
    Select Case CmdStr
        Case "SendThePicture"
            With Picture1
                .LinkMode = 0
                .LinkTopic = "Program1|frmProgram1"
                .LinkItem = "Picture1"
                .LinkMode = 2
                'Give me a picture:
                .LinkRequest
            End With
        Case "GiveMeAPicture"
            'Because a connection is already opened you don't
            'need to establish a new one.
            'So send the Picture:
            Picture2.LinkSend
        Case "Quit"
            Cancel = 0 'Before quitting you need to tell
                       'to Program 1 that everything went
                       'well. If you don't type this line,
                       'Program 1 will generate an error!
            End
    End Select
    Cancel = 0 'Everything went well. If you don't type
               'this line, Program 1 will generate an error!
End Sub

Private Sub Form_Load()
    'This event tells to Program 1 that I (Program2) am now
    'opened!
    With Text1
        .LinkMode = 0
        .LinkTopic = "Program1|frmProgram1"
        On Error Resume Next 'This line is because if
                             'Program 1 is not opened this
                             'program can't tell him/her
                             'that I (Program2) am opened!
        .LinkMode = 2
        .LinkExecute "Opened" 'Tells Program 1 that I am
                              'opened now.
    End With
End Sub

Private Sub Form_Unload(Cancel As Integer)
    'This event occurs if this program closes.
    With Text1
        .LinkMode = 0
        .LinkTopic = "Program1|frmProgram1"
        On Error Resume Next 'This line is because if
                             'Program 1 is not opened this
                             'program can't tell him/her
                             'that I (Program2) am closing!
        .LinkMode = 2
        .LinkExecute "Closed" 'Tells Program 1 that I am
                              'closing.
    End With
End Sub
