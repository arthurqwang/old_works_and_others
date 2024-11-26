VERSION 5.00
Begin VB.Form Form4 
   BackColor       =   &H00DDFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "删除经办人账号"
   ClientHeight    =   855
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3300
   Icon            =   "delsls.frx":0000
   LinkTopic       =   "Form4"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   855
   ScaleWidth      =   3300
   StartUpPosition =   2  '屏幕中心
   Begin VB.CommandButton DEL_SALES_BUTTON 
      Caption         =   "删除"
      Height          =   495
      Left            =   2280
      TabIndex        =   1
      Top             =   180
      Width           =   855
   End
   Begin VB.ComboBox Combo1 
      Height          =   300
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   2055
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "选择经办人:"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2055
   End
End
Attribute VB_Name = "Form4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub DEL_SALES_BUTTON_Click()
Dim nm, id, psw1, psw2, f1, f2, temp, n, s, p, r As String
If Combo1.Text = "" Then Exit Sub

f1 = DOC_PATH & "\账号管理\sales.par"
f2 = f1 & "a"
Open f1 For Input As #1
Open f2 For Output As #2
Do While Not EOF(1)
Input #1, temp
If Left(temp, InStr(temp, ":") - 1) <> Combo1.Text Then Print #2, temp
Loop
Close #1
Close #2
Kill f1
FileCopy f2, f1
Kill f2
Form4.Hide
Form_Load
MsgBox "成功:删除经办人成功"
End Sub

Private Sub Form_Load()
Combo1.Text = ""
Combo1.Clear
Open DOC_PATH & "\账号管理\sales.par" For Input As #1
Do While Not EOF(1)
Input #1, temp
temp = Left(temp, InStr(temp, ":") - 1)
If temp <> "管理员-admin" Then Combo1.AddItem (temp)
Loop
Close #1
End Sub
