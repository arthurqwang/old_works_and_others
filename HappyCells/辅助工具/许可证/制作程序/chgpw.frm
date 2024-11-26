VERSION 5.00
Begin VB.Form Form3 
   BackColor       =   &H00FFFFF0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "更改密码"
   ClientHeight    =   765
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3405
   Icon            =   "chgpw.frx":0000
   LinkTopic       =   "Form3"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   294.507
   ScaleMode       =   0  'User
   ScaleWidth      =   2302.74
   StartUpPosition =   2  '屏幕中心
   Begin VB.TextBox pw2 
      Height          =   270
      IMEMode         =   3  'DISABLE
      Left            =   840
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   360
      Width           =   1335
   End
   Begin VB.TextBox pw1 
      Height          =   270
      IMEMode         =   3  'DISABLE
      Left            =   840
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   120
      Width           =   1335
   End
   Begin VB.CommandButton CH_button 
      Caption         =   "OK"
      Height          =   495
      Left            =   2280
      TabIndex        =   0
      Top             =   120
      Width           =   975
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "重复:"
      Height          =   255
      Left            =   163
      TabIndex        =   4
      Top             =   390
      Width           =   855
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "新密码:"
      Height          =   255
      Left            =   163
      TabIndex        =   3
      Top             =   156
      Width           =   735
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CH_button_Click()
Dim nm, id, psw1, psw2, f1, f2, temp, n, s, p, r As String
psw1 = Trim(pw1.Text)
psw2 = Trim(pw2.Text)
If psw1 <> psw2 Or psw1 = "" Or psw2 = "" Then
  MsgBox "错误:密码不一致，也不能为空"
  Exit Sub
End If
f1 = DOC_PATH & "\账号管理\sales.par"
f2 = f1 & "a"
Open f1 For Input As #1
Open f2 For Output As #2
Do While Not EOF(1)
Input #1, temp
If Mid(temp, InStr(temp, "-") + 1, InStr(temp, ":") - InStr(temp, "-") - 1) = Form1.SALES_i.Text Then
    nm = Left(temp, InStr(temp, "-") - 1)
    id = Form1.SALES_i.Text
    
    n = nm
    s = n & id
    p = psw1
    For i = 1 To Len(s)
     r = r & CStr(Abs(CInt(Asc(Mid(s, i, 1)) / 2) + CInt(Asc(Right(id, 1)) * 67)))
    Next i
    For i = 1 To Len(p)
     r = r & CStr(Abs(CInt(Asc(Mid(p, i, 1)) / 3) + CInt(Asc(Right(id, 1)) * 211)))
    Next i
    temp = nm & "-" & id & ":" & r
End If
Print #2, temp
Loop
Close #1
Close #2
Kill f1
FileCopy f2, f1
Kill f2
Form3.Hide
MsgBox "成功:密码更改成功，请记住新密码"
End Sub

Private Sub Form_Load()
pw1.Text = ""
pw2.Text = ""
End Sub
