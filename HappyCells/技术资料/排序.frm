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
   StartUpPosition =   3  '窗口缺省
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

For i = 0 To Screen.FontCount - 1 '系统可用的显示字体数
y(i) = Screen.Fonts(i)
Next i
STRINGSORT y, "DOWN" ' "UP"
For i = 0 To 1000 '系统可用的显示字体数
If y(i) <> "" Then Combo1.AddItem y(i) '加入工具条上的字体名列表框中
Next i
End Sub
Sub STRINGSORT(ByRef a() As String, Optional sort As String = "UP") '字符串排序
 Dim min As Long, max As Long, num As Long, first As Long, last As Long, temp As Long, all As New Collection, steps As Long
 min = LBound(a)
 max = UBound(a)
 all.Add a(min)
 steps = 1
 For num = min + 1 To max
 
 first = 1
 last = all.Count
 If a(num) < all(1) Then all.Add a(num), BEFORE:=1: GoTo nextnum '加到第一项
 If a(num) > all(last) Then all.Add a(num), AFTER:=last: GoTo nextnum '加到最后一项
 
 
 Do While last > first + 1 '利用DO循环减少循环次数
 temp = (last + first) \ 2
 If a(num) > all(temp) Then
 first = temp
 Else
 last = temp
 steps = steps + 1
 End If
 Loop
 all.Add a(num), BEFORE:=last '加到指定的索引
 
nextnum:
 steps = steps + 1
 Next
 For num = min To max
 If sort = "UP" Or sort = "up" Then a(num) = all(num - min + 1): steps = steps + 1 '升序
 If sort = "DOWN" Or sort = "down" Then a(num) = all(max - num + 1): steps = steps + 1 '降序
 Next
 'MsgBox "本数组共经过 " & steps & "步实现" & IIf(sort = "UP" Or sort = "up", "升序", "降序") & "排序！", 64, "INFORMATION"
 Set all = Nothing
 End Sub

