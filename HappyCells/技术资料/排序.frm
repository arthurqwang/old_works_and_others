VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  '����ȱʡ
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   960
      TabIndex        =   1
      Top             =   1800
      Width           =   3015
   End
   Begin VB.ComboBox Combo1 
      Height          =   300
      Left            =   720
      TabIndex        =   0
      Text            =   "Combo1"
      Top             =   840
      Width           =   3375
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
MsgBox Combo1.Text
End Sub


Private Sub Form_Load()
Dim i As Long, J As Long, S1 As String, T As Single
Dim a As Long, B As Long
Dim y(1000) As String

For i = 0 To Screen.FontCount - 1 'ϵͳ���õ���ʾ������
y(i) = Screen.Fonts(i)
Next i
STRINGSORT y, "DOWN" ' "UP"
For i = 0 To 1000 'ϵͳ���õ���ʾ������
If y(i) <> "" Then Combo1.AddItem y(i) '���빤�����ϵ��������б����
Next i
End Sub
Sub STRINGSORT(ByRef a() As String, Optional sort As String = "UP") '�ַ�������
 Dim min As Long, max As Long, num As Long, first As Long, last As Long, temp As Long, all As New Collection, steps As Long
 min = LBound(a)
 max = UBound(a)
 all.Add a(min)
 steps = 1
 For num = min + 1 To max
 
 first = 1
 last = all.Count
 If a(num) < all(1) Then all.Add a(num), BEFORE:=1: GoTo nextnum '�ӵ���һ��
 If a(num) > all(last) Then all.Add a(num), AFTER:=last: GoTo nextnum '�ӵ����һ��
 
 
 Do While last > first + 1 '����DOѭ������ѭ������
 temp = (last + first) \ 2
 If a(num) > all(temp) Then
 first = temp
 Else
 last = temp
 steps = steps + 1
 End If
 Loop
 all.Add a(num), BEFORE:=last '�ӵ�ָ��������
 
nextnum:
 steps = steps + 1
 Next
 For num = min To max
 If sort = "UP" Or sort = "up" Then a(num) = all(num - min + 1): steps = steps + 1 '����
 If sort = "DOWN" Or sort = "down" Then a(num) = all(max - num + 1): steps = steps + 1 '����
 Next
 'MsgBox "�����鹲���� " & steps & "��ʵ��" & IIf(sort = "UP" Or sort = "up", "����", "����") & "����", 64, "INFORMATION"
 Set all = Nothing
 End Sub

