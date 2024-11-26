VERSION 5.00
Begin VB.Form Form2 
   BackColor       =   &H00BBFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "创建经办人账号"
   ClientHeight    =   1230
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3165
   Icon            =   "crtsls.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   1230
   ScaleWidth      =   3165
   StartUpPosition =   2  '屏幕中心
   Begin VB.TextBox PW2_i 
      Height          =   270
      IMEMode         =   3  'DISABLE
      Left            =   720
      PasswordChar    =   "*"
      TabIndex        =   8
      Top             =   840
      Width           =   1215
   End
   Begin VB.TextBox PW1_i 
      Height          =   270
      IMEMode         =   3  'DISABLE
      Left            =   720
      PasswordChar    =   "*"
      TabIndex        =   7
      Top             =   600
      Width           =   1215
   End
   Begin VB.TextBox ID_i 
      Height          =   270
      Left            =   720
      TabIndex        =   6
      Top             =   360
      Width           =   1215
   End
   Begin VB.TextBox NAME_i 
      Height          =   270
      Left            =   720
      TabIndex        =   5
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton OK_BUTTON 
      Caption         =   "OK"
      Height          =   975
      Left            =   2040
      TabIndex        =   0
      Top             =   120
      Width           =   975
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "重复:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   900
      Width           =   975
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "密码:"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   650
      Width           =   975
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "代码:"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   400
      Width           =   975
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "姓名:"
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   150
      Width           =   975
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Initialize()
  NAME_i.Text = ""
  ID_i.Text = ""
  PW1_i.Text = ""
  PW2_i.Text = ""
  Call Form1.CREATE_SALES_BUTTON_Click
End Sub

Private Sub OK_BUTTON_Click()
Dim nm, id, pw1, pw2 As String
nm = Trim(NAME_i.Text)
id = Trim(ID_i.Text)
pw1 = Trim(PW1_i.Text)
pw2 = Trim(PW2_i.Text)
If nm = "" Or id = "" Or pw1 = "" Or pw2 = "" Then
  MsgBox "错误:各参数都不能省略"
  Exit Sub
End If
If pw1 <> pw2 Or pw1 = "" Or pw2 = "" Then
  MsgBox "错误:密码不一致，也不能为空"
  Exit Sub
End If
If Sales_ID_Exists((id)) = True Then

  MsgBox "错误:经办人代码已存在，请另选代码"
  Exit Sub
  End If
Create_Sales (nm), (id), (pw1)
  NAME_i.Text = ""
  ID_i.Text = ""
  PW1_i.Text = ""
  PW2_i.Text = ""
End Sub

Function Sales_ID_Exists(id As String) As Boolean
On Error GoTo 111
Sales_ID_Exists = False
Dim s_id, temp As String
Dim b, e As Integer
s_id = id
Open DOC_PATH & "\账号管理\sales.par" For Input As #1
Do While Not EOF(1)
  Input #1, temp
  b = InStr(temp, "-") + 1
  e = InStr(temp, ":")
  If id = Mid(temp, b, e - b) Then
    Sales_ID_Exists = True
    Exit Do
  End If
111 Loop
Close #1
End Function

Sub Create_Sales(nm As String, id As String, pw As String)
Dim n, s, p, r As String
n = nm
s = n & id
p = pw
'不能用随机数，因为randomize num 只能执行一次，即只能播种一次，关闭程序在启动以后才起作用
For i = 1 To Len(s)
 r = r & CStr(Abs(CInt(Asc(Mid(s, i, 1)) / 2) + CInt(Asc(Right(id, 1)) * 67)))
Next i
For i = 1 To Len(p)
 r = r & CStr(Abs(CInt(Asc(Mid(p, i, 1)) / 3) + CInt(Asc(Right(id, 1)) * 211)))
Next i

Open DOC_PATH & "\账号管理\sales.par" For Append As #1
Print #1, nm & "-" & id & ":" & r
Close #1
MsgBox "成功:经办人代码建立成功，请记住代码和密码"
End Sub


