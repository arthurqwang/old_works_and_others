VERSION 5.00
Begin VB.Form Form2 
   BackColor       =   &H00BBFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "�����������˺�"
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
   StartUpPosition =   2  '��Ļ����
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
      Caption         =   "�ظ�:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   900
      Width           =   975
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "����:"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   650
      Width           =   975
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "����:"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   400
      Width           =   975
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "����:"
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
  MsgBox "����:������������ʡ��"
  Exit Sub
End If
If pw1 <> pw2 Or pw1 = "" Or pw2 = "" Then
  MsgBox "����:���벻һ�£�Ҳ����Ϊ��"
  Exit Sub
End If
If Sales_ID_Exists((id)) = True Then

  MsgBox "����:�����˴����Ѵ��ڣ�����ѡ����"
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
Open DOC_PATH & "\�˺Ź���\sales.par" For Input As #1
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
'���������������Ϊrandomize num ֻ��ִ��һ�Σ���ֻ�ܲ���һ�Σ��رճ����������Ժ��������
For i = 1 To Len(s)
 r = r & CStr(Abs(CInt(Asc(Mid(s, i, 1)) / 2) + CInt(Asc(Right(id, 1)) * 67)))
Next i
For i = 1 To Len(p)
 r = r & CStr(Abs(CInt(Asc(Mid(p, i, 1)) / 3) + CInt(Asc(Right(id, 1)) * 211)))
Next i

Open DOC_PATH & "\�˺Ź���\sales.par" For Append As #1
Print #1, nm & "-" & id & ":" & r
Close #1
MsgBox "�ɹ�:�����˴��뽨���ɹ������ס���������"
End Sub


