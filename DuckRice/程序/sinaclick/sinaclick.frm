VERSION 5.00
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Form1"
   ClientHeight    =   4485
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   14055
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4485
   ScaleWidth      =   14055
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  '����ȱʡ
   Begin VB.CommandButton Command2 
      Caption         =   "ֹͣ"
      Height          =   255
      Left            =   625
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   0
      Width           =   615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "��ʼ"
      Height          =   255
      Left            =   0
      MaskColor       =   &H0000FFFF&
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Width           =   615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal y As Long) As Long '�������������λ��!

Private Declare Sub mouse_event Lib "user32" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long) '��������¼�
'���������������.ֻ��������,�ſ���ʹ��..
Private Declare Sub Sleep Lib "Kernel32" (ByVal dwMilliseconds As Long)

Const MOUSEEVENTF_LEFTDOWN = &H2
Const MOUSEEVENTF_LEFTUP = &H4


Private Sub Command1_Click()

'���벿��


Do
    Call SetCursorPos(1250, 210) '������ƶ���(10,20)
    mouse_event MOUSEEVENTF_LEFTDOWN Or MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 'ģ�������������!
    Sleep 3000
    DoEvents
Loop
End Sub

Private Sub Command2_Click()
End
End Sub


Private Sub Form_Click()
'ShowCursor (True)
End
End Sub

Private Sub Form_Deactivate()
 Form1.Refresh
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
'ShowCursor (True)
End
End Sub

Private Sub Form_LostFocus()
 Form1.SetFocus
End Sub

