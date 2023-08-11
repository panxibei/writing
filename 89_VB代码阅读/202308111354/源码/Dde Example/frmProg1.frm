VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Program 1"
   ClientHeight    =   6495
   ClientLeft      =   270
   ClientTop       =   555
   ClientWidth     =   5295
   Icon            =   "frmProg1.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "frmProgram1"
   MaxButton       =   0   'False
   ScaleHeight     =   6495
   ScaleWidth      =   5295
   Begin VB.CommandButton Command8 
      Caption         =   "Change text and Send"
      Enabled         =   0   'False
      Height          =   375
      Left            =   3120
      TabIndex        =   19
      Top             =   4275
      Width           =   2055
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Send"
      Enabled         =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   18
      Top             =   4275
      Width           =   855
   End
   Begin VB.TextBox Text3 
      Enabled         =   0   'False
      Height          =   285
      Left            =   120
      LinkItem        =   "Text3"
      TabIndex        =   17
      Top             =   4350
      Width           =   1935
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Close connection"
      Enabled         =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   15
      Top             =   5280
      Width           =   1575
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Open connection"
      Enabled         =   0   'False
      Height          =   375
      Left            =   360
      TabIndex        =   14
      Top             =   5280
      Width           =   1575
   End
   Begin VB.TextBox Text2 
      Enabled         =   0   'False
      Height          =   285
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   3240
      Width           =   5055
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Close P2"
      Enabled         =   0   'False
      Height          =   375
      Left            =   360
      TabIndex        =   3
      Top             =   5980
      Width           =   1215
   End
   Begin VB.PictureBox Picture2 
      AutoSize        =   -1  'True
      Height          =   495
      Left            =   1800
      ScaleHeight     =   435
      ScaleWidth      =   1395
      TabIndex        =   10
      Top             =   2115
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Request"
      Enabled         =   0   'False
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   2200
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Left            =   120
      TabIndex        =   0
      Top             =   420
      Width           =   5055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Send"
      Enabled         =   0   'False
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   1155
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   2520
      LinkItem        =   "Picture1"
      Picture         =   "frmProg1.frx":0442
      ScaleHeight     =   495
      ScaleWidth      =   1410
      TabIndex        =   7
      Top             =   1080
      Width           =   1410
   End
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "Exit"
      Height          =   375
      Left            =   4200
      TabIndex        =   6
      Top             =   5880
      Width           =   735
   End
   Begin VB.Label Label7 
      Caption         =   $"frmProg1.frx":0923
      Height          =   855
      Left            =   120
      TabIndex        =   16
      Top             =   3560
      Width           =   5055
   End
   Begin VB.Label Label6 
      Caption         =   $"frmProg1.frx":0A02
      Height          =   615
      Left            =   120
      TabIndex        =   13
      Top             =   4680
      Width           =   5055
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label5 
      Caption         =   $"frmProg1.frx":0A92
      Height          =   615
      Left            =   120
      TabIndex        =   12
      Top             =   2640
      Width           =   5055
   End
   Begin VB.Label Label4 
      Caption         =   "7) Close Program 2"
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   5720
      Width           =   5055
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   $"frmProg1.frx":0B60
      Height          =   615
      Left            =   120
      TabIndex        =   9
      Top             =   1610
      Width           =   5085
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "2) The button below will change Program 2's picturebox's picture to the picture that is in this picturebox:"
      Height          =   390
      Left            =   120
      TabIndex        =   8
      Top             =   720
      Width           =   5040
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "1) Type some text here and you will see that Program 2's textbox's text will be always the same as here:"
      Height          =   390
      Left            =   120
      TabIndex        =   5
      Top             =   0
      Width           =   5040
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Sorry about my (bad) English, if it is bad!

'Sorry that controls are so close to each other - I
'consulted that someone may have a smaller screen
'resolution or screen size.

'NBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNNBN
'This source code may not be perfect! So don't swear me
'if you find some mistakes!
'NBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNNBN

'********************************************************
'This tutorial is made by Peeter Puusemp jr.
'                peeter.puusemp@mail.ee
'Don't forget to comment this example on PSC.
'Voting would be nice too. Then I know how people take my
'tutorial.
'********************************************************

'READ ME!
'DDE conversation can be started only by Label, PictureBox
'and TextBox controls. Destinations can be any Label,
'PictureBox and TextBox control, Form and MDIForm object or
'Forms Collection.
'
'If you don't want to use any Label, PictureBox or TextBox
'control on your Form, but want to use DDE conversation,
'add a Label, PictureBox or TextBox control to your form
'and set it's Visible property value to False!

'IMPORTANT 1!
'You have to set the form's, that is getting some
'information in DDE conversation, LinkMode property value
'to 'Source'.
'Also you have to set all destination control's LinkItem
'property values so you can use them in DDE conversation.

'NOTE!
'But in this tutorial you don't need to change anything!
'All comments are meant to help you in case you use DDE
'conversation in your own programs.

'The line below declares an api call that can be used to
'determine if an app is running by its title.
Private Declare Function FindWindow& Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String)
Option Explicit

Private Sub Text1_Change()
    With Text1 '- an object that starts a conversation
'1. To make sure the link isn't active, set LinkMode
'   property value to 0 (=none).

'   NBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBNBN
'   object.LinkMode = 0 disables previous connection.
'   You don't always need to disable a connection. You
'   can use active connection and use a function,
'   described in point 5 below, at once without making
'   a connection again. (If you didn't understand what
'   I meant here then explore this tutorial through and
'   I think that you will understand. I tryed to explain
'   that in section 5 too)

        .LinkMode = 0

'2. Specify the program and the form to which you want
'   to begin a conversation.
'
'   It must look like this:
'   object.LinkTopic = "Destination program's exe
'                       name without an extension|
'                       Destination form's LinkTopic
'                       property value"
'   object - an object that starts a conversation

        .LinkTopic = "Program2|frmProgram2"
        
'3. Specify the object, to which current object will be
'   connected. If you want to connect only to a form then
'   skip this line of code!
'
'   It must look like this:
'   object.LinkItem = "Destination object's LinkItem
'                      property value"
'   object - an object that starts a conversation

        .LinkItem = "Text1"
        
'4. Set the type of link used for a DDEconversation.
'   This code also activates the connection.
'
'   It must look like this:
'   object.LinkMode = number
'       number can be:
'   0 - (Default) None - No DDE interaction
'   1 - Automatic - Destination control is updated each time
'                   the linked data changes
'   2 - Manual - Destination control is updated only when
'                the LinkRequest method is invoked.
'   3 - Notify - A LinkNotify event occurs whenever the
'                linked data changes, but the destination
'                control is updated only when the
'                LinkRequest method is invoked

'   But now the 'number' must be 2

        .LinkMode = 2
        
'5. Now you are connected to the form/control you wanted and
'   you can use some functions to "relate" to the
'   destination form/control.
'
'       These functions are:
'   object.LinkExecute Command As String - This function is
'               available only when the object is connected
'               to a form. It activates the destination
'               form's LinkExecute event with specified
'               command string. So the destination form can
'               perform an operation by the string.
'   object.LinkPoke - Transfers the contents of current
'                     object to the source application.
'   object.LinkRequest - If the object is destination in DDE
'                        conversation, it asks to update
'                        it's contents.
'   object.LinkSend - If the object is destination in DDE
'                     conversation, it sends it's contents
'                     to the object, which started a DDE
'                     conversation with this object.
'
'   object - an object that starts a conversation

        .LinkPoke
        
    End With
    
'NB!
'All other connections are made like this example so I
'put only step numbers to them.
End Sub

Private Sub Form_Load()
    If FindWindow(vbNullString, "Program 2") <> 0 Then
        'Enable all stuff that uses DDE conversation,
        'because Program 2 is already opened:
        Command2.Enabled = True
        Command3.Enabled = True
        Command4.Enabled = True
        Command5.Enabled = True
        Text1.Enabled = True
        Text2.Enabled = True
        Text3.Enabled = True
        
        'Open link between current program's Text2 and
        'Program 2's Text2 with LinkMode 3 (= notify
        'current program's Text2 when something changes
        'in Program 2's Text2. When it happens, current
        'program's Text2's event LinkNotify occurs).
        With Text2
            .LinkMode = 0                       '1.
            .LinkTopic = "Program2|frmProgram2" '2.
            .LinkItem = "Text2"                 '3.
            .LinkMode = 3                       '4.
            '5. misses because Notify mode is active
        End With
    End If
End Sub

Private Sub Text2_LinkNotify()
    'Because a connection is already opened you don't
    'need to establish a new one.
    
    'So send my (text2) contents to ...
    Text2.LinkRequest   '5.
End Sub

Private Sub Form_LinkExecute(CmdStr As String, Cancel As Integer)
    'This event recieves messages from the other program
    'and does a action you want by the string that has
    'sent to this form.
    Select Case CmdStr
        Case "Opened" 'Program 2 sent a message that it
                      'has been opened.
            
            'Enable all stuff that uses DDE conversation,
            'because Program 2 is now opened.
            Command2.Enabled = True
            Command3.Enabled = True
            Command4.Enabled = True
            Command5.Enabled = True
            Text1.Enabled = True
            Text2.Enabled = True
            Text3.Enabled = True
            Text3.Text = ""
            Command7.Enabled = False
            
            'Open link between current program's Text2 and
            'Program 2's Text2 with LinkMode 3 (= notify
            'current program's Text2 when something changes
            'in Program 2's Text2. When it happens, current
            'program's Text2's event LinkNotify occurs).
            With Text2
                .LinkMode = 0                       '1.
                .LinkTopic = "Program2|frmProgram2" '2.
                .LinkItem = "Text2"                 '3.
                .LinkMode = 3                       '4.
                '5. misses because Notify mode is active
            End With
            
        Case "Closed"
            'Disable all stuff that uses DDE conversation,
            'because Program 2 has closed.
            Command2.Enabled = False
            Command3.Enabled = False
            Command4.Enabled = False
            Command5.Enabled = False
            Command6.Enabled = False
            Command7.Enabled = False
            Command8.Enabled = False
            Text1.Enabled = False
            Text2.Enabled = False
            Text3.Enabled = False
    End Select
    Cancel = 0 'Everything went well. If you don't type
               'this line, Program 1 will generate an error!
End Sub

Private Sub Command1_Click()
    End 'Exits the program
End Sub

Private Sub Command2_Click()
    'NB! You can try a .LinkPoke method too, but it didn't
    'work when I tryed it - picture didn't go to the
    'destination picturebox correctly.
    With Picture1 '- an object that starts a conversation
        .LinkMode = 0                           '1.
        .LinkTopic = "Program2|frmProgram2"     '2.
        '3. misses, because the destination is a form
        .LinkMode = 2                           '4.
        .LinkExecute "SendThePicture"           '5.
    End With
End Sub

Private Sub Command3_Click()
    With Picture2 '- an object that starts a conversation
        .LinkMode = 0                           '1.
        .LinkTopic = "Program2|frmProgram2"     '2.
        .LinkItem = "Picture2"                  '3.
        .LinkMode = 1                           '4.
        .LinkExecute "GiveMeAPicture"           '5.
    End With
End Sub

Private Sub Command4_Click()
'   Here is a little tricky thing:
'You want to quit the other program by sending him/her
'LinkExecute "Quit" message. But in this case it doesn't
'matter what control starts the DDE conversation and so you
'can choose what control you want (of course from controls
'with what you can start a DDE conversation).
    
    With Picture1 '- so I choosed the Picture1 object that
                  'starts a conversation
        .LinkMode = 0                           '1.
        .LinkTopic = "Program2|frmProgram2"     '2.
        '3. misses, because the destination is a form
        .LinkMode = 2                           '4.
        .LinkExecute "Quit"                     '5.
    End With
    'Disable all stuff that uses DDE conversation, because
    'Program 2 has closed.
    Command2.Enabled = False
    Command3.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False
    Command6.Enabled = False
    Command7.Enabled = False
    Command8.Enabled = False
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
End Sub

Private Sub Command5_Click()
    'Establish a connection
    With Label6 '- an object that starts a conversation
        .LinkMode = 0                           '1.
        .LinkTopic = "Program2|frmProgram2"     '2.
        .LinkMode = 2                           '4.
    End With
    Command5.Enabled = False
    Command6.Enabled = True
End Sub

Private Sub Command6_Click()
    Label6.LinkMode = 0 'close opened connection
    Command5.Enabled = True
    Command6.Enabled = False
End Sub

Private Sub Label6_LinkClose()
    'LinkClose event occurs when link with the other object
    'has closed. It means that LinkMode got 0.
    
    MsgBox "Label6: the connection has closed!"
End Sub

Private Sub Label6_LinkOpen(Cancel As Integer)
    'LinkOpen event occurs when the object starts a DDE
    'conversation.
    
    MsgBox "Label6: the connection has established!"
End Sub

Private Sub Text3_Change()
    Command7.Enabled = True
End Sub

Private Sub Command7_Click()
    With Text3 '- an object that starts a conversation
        .LinkTopic = "Program2|frmProgram2"     '2.
        .LinkItem = "Text3"                     '3.
        .LinkMode = 2                           '4.
        .LinkPoke                               '5.
    End With
    Command8.Enabled = True
End Sub

Private Sub Command8_Click()
    'Because a connection is already opened you don't
    'need to establish a new one.
    
    With Text3
        'First change Text3's text so the effect can be
        'seen!
        .Text = "New text ..."
        
        'And now send my (text3) contents to ...
        .LinkPoke
    End With
End Sub
