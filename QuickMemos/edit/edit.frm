VERSION 5.00
Begin VB.Form 编辑 
   BackColor       =   &H80000009&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Arthur's Memos - 查看/编辑 Memo"
   ClientHeight    =   3255
   ClientLeft      =   4185
   ClientTop       =   2745
   ClientWidth     =   5310
   FillColor       =   &H80000003&
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   -1  'True
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H008080FF&
   Icon            =   "edit.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3255
   ScaleWidth      =   5310
   Begin VB.CheckBox Check3 
      Caption         =   "重"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   4080
      TabIndex        =   13
      Top             =   2010
      Width           =   735
   End
   Begin VB.CheckBox Check2 
      Caption         =   "急"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4080
      TabIndex        =   12
      Top             =   1730
      Width           =   735
   End
   Begin VB.CommandButton Command5 
      BackColor       =   &H80000005&
      Caption         =   "开始/下一个"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2400
      TabIndex        =   11
      Top             =   2760
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      IMEMode         =   4  'DBCS HIRAGANA
      Left            =   600
      TabIndex        =   10
      Top             =   2760
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CommandButton Command4 
      Caption         =   "打印"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4080
      TabIndex        =   7
      Top             =   2760
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "退出"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   4080
      TabIndex        =   6
      Top             =   1680
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CheckBox Check1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Check1"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   2800
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "删除"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2880
      TabIndex        =   3
      Top             =   2760
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "记事"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4080
      TabIndex        =   1
      Top             =   2280
      Width           =   975
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2295
      IMEMode         =   4  'DBCS HIRAGANA
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   360
      Width           =   3735
   End
   Begin VB.Label Label3 
      BackColor       =   &H80000005&
      Caption         =   "搜索"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   2760
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Image Image2 
      Height          =   330
      Left            =   4000
      Picture         =   "edit.frx":058A
      Top             =   1320
      Width           =   1140
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "删除时记事并归档"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   480
      TabIndex        =   5
      Top             =   2830
      Width           =   3015
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "第一行将显示为标题"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   3015
   End
   Begin VB.Image Image1 
      Height          =   900
      Left            =   4090
      Stretch         =   -1  'True
      Top             =   250
      Width           =   900
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Caption         =   "Label2"
      BeginProperty Font 
         Name            =   "Arial Narrow"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   255
      Left            =   4000
      TabIndex        =   8
      Top             =   1100
      Width           =   975
   End
End
Attribute VB_Name = "编辑"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'************************************************************************************************
'此文件编译会后就放在edit目录下,不需拷贝移动
'************************************************************************************************

   '获得各个目录
   Private Declare Function SHGetSpecialFolderLocation Lib "Shell32" (ByVal hwndOwner As Long, ByVal nFolder As Integer, ppidl As Long) As Long
   Private Declare Function SHGetPathFromIDList Lib "Shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal szPath As String) As Long
   Private Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
   Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
   Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
   Const MAX_LEN = 200 '字符串最大长度
   Const DESKTOP = &H0& '桌面
   Const PROGRAMS = &H2& '程序集
   Const MYDOCUMENTS = &H5& '我的文档
   Const MYFAVORITES = &H6& '收藏夹
   Const STARTUP = &H7& '启动
   Const RECENT = &H8& '最近打开的文件
   Const SENDTO = &H9& '发送
   Const STARTMENU = &HB& '开始菜单
   Const NETHOOD = &H13& '网上邻居
   Const FONTS = &H14& '字体
   Const SHELLNEW = &H15& 'ShellNew
   Const APPDATA = &H1A& 'Application Data
   Const PRINTHOOD = &H1B& 'PrintHood
   Const PAGETMP = &H20& '网页临时文件
   Const COOKIES = &H21& 'Cookies目录
   Const HISTORY = &H22& '历史


Dim strFileName As String '文件名
Dim Dir As String '工作目录
Dim PF As String '文件名后缀
Dim my_doc_path As String

Dim lngHandle As Long '句柄
Dim strWrite As String '要写入的文本内容
Dim WK As Variant
Dim cfgPath As String
Dim SrchStart As Integer






   Function Cut2Part(SrcStr As String, PartLongInEng As Integer) As String
'把大段字符串用回车切割成小段，使得打印或显示时不超宽,每段长度以英文为准，汉字占2个长度

 Dim SrcLen, i, j As Integer
 Cut2Part = ""
 j = 0
 SrcLen = Len(SrcStr)
 
 For i = 1 To SrcLen
 
    Cut2Part = Cut2Part & Mid(SrcStr, i, 1)
    j = j + 1
    If Mid(SrcStr, i, 1) > Chr(127) Then j = j + 1
    If Mid(SrcStr, i, 1) = Chr(10) Then j = 0
    
    If j >= PartLongInEng Then
    j = 0
    Cut2Part = Cut2Part & Chr(13) & Chr(10)
    End If
 
 Next i
 
End Function
Function CutReturnChar(SrcStr As String) As String
'合并多个回车换行为一个
    CutReturnChar = SrcStr
    Do While InStr(CutReturnChar, Chr(13) & Chr(10) & Chr(13) & Chr(10)) <> 0
     CutReturnChar = Replace(CutReturnChar, Chr(13) & Chr(10) & Chr(13) & Chr(10), Chr(13) & Chr(10))
    Loop
End Function
Function FmtTxt(SrcStr As String) As String
'切小段，处理回车换行
   FmtTxt = CutReturnChar(Cut2Part(SrcStr, 34))
End Function

Function Clen(str As String) As Integer
'计算字串的长度,以英文字母计算,一个汉字算作2个长度
Dim i, l As Integer
l = Len(str)
Clen = 0
For i = 1 To l
Clen = Clen + 1
If Mid(str, i, 1) > Chr(127) Then Clen = Clen + 1
Next i
End Function
Function FindandGo(SrcStr As String, Begin As Integer, FindStr As String) As Integer
'搜索到某字串，并亮显
  Dim l, GoPos As Integer
  Dim tempstr As String
  l = Len(SrcStr)
  GoPos = Begin + InStr(UCase(Mid(SrcStr, Begin + 1, l)), UCase(FindStr)) - 1
  If GoPos = Begin - 1 Then GoPos = InStr(SrcStr, FindStr) - 1
  'If GoPos < 0 Then GoPos = 0
  FindandGo = GoPos
End Function

Function ChgBkClr()
   Dim Vrgb As Long
   Dim r, b, g As Integer
   Randomize
   r = 255 - Int(Rnd * 39 + 1)
   g = 255 - Int(Rnd * 39 + 1)
   b = 255 - Int(Rnd * 39 + 1)
   Open my_doc_path & "\Quick Memos\edit\color.txt" For Output As #22
   Print #22, r
   Print #22, g
   Print #22, b
   Close #22
   
   Vrgb = RGB(r, g, b)
   编辑.BackColor = Vrgb
   Check1.BackColor = Vrgb
   Check2.BackColor = Vrgb
   Check3.BackColor = Vrgb
   Label1(0).BackColor = Vrgb
   Label1(1).BackColor = Vrgb
   Label2.BackColor = Vrgb
   Label3.BackColor = Vrgb
   Text1.BackColor = Vrgb
   Text2.BackColor = Vrgb

End Function
Function RstBkClr()
   Dim Vrgb As Long
   Dim r, b, g As Integer
   Randomize
   r = 255
   g = 255
   b = 255
   Open my_doc_path & "\Quick Memos\edit\color.txt" For Output As #22
   Print #22, r
   Print #22, g
   Print #22, b
   Close #22
   
   Vrgb = RGB(r, g, b)
   编辑.BackColor = Vrgb
   Check1.BackColor = Vrgb
   Check2.BackColor = Vrgb
   Check3.BackColor = Vrgb
   Label1(0).BackColor = Vrgb
   Label1(1).BackColor = Vrgb
   Label2.BackColor = Vrgb
   Label3.BackColor = Vrgb
   Text1.BackColor = Vrgb
   Text2.BackColor = Vrgb
End Function




'修改/记事
Private Sub Command1_Click()

    SetAttr strFileName, vbArchive
    '删除原文件
    If strFileName <> "" Then Kill strFileName
    
    'strFileName = Trim(Left(Text1, InStr(Text1 & Chr(13), Chr(13)) - 1))
    strFileName = Left(Trim(Left(Text1, InStr(Text1 & Chr(13), Chr(13)) - 1)), 30)
    If strFileName = "" Then
      strFileName = "Memo "
      Dim fs As New FileSystemObject
      Dim i As Integer
      i = 1
      Do While fs.FileExists(Dir & strFileName & i & PF)
       i = i + 1
      Loop
      strFileName = strFileName & i
    End If
    
    

    strFileName = Dir & strFileName & PF
    
    lngHandle = FreeFile() '取得句柄

 
    '准备要写入的内容
    strWrite = Text1 & Chr(13) & Chr(10) & "[记事时间:" & Date & " " & WK(Weekday(Date)) & " " & FormatDateTime(Time, vbShortTime) & "]"
    

    Open strFileName For Output As lngHandle    '打开文件

    Print #lngHandle, FmtTxt(strWrite)    '写入文本

    Close lngHandle    '关闭文件
    SetAttr strFileName, vbReadOnly
    End
End Sub
'删除/归档
Private Sub Command2_Click()

 
 If Check1.Value = 1 Then
  SetAttr Dir & "已归档 Memos.mem", vbArchive
  Open Dir & "已归档 Memos.mem" For Append As #1
  Print #1, Chr(13) & Chr(10) & "-------------------------------"
  Print #1, FmtTxt(Text1)
  Print #1, "[归档时间:" & Date & " " & WK(Weekday(Date)) & " " & FormatDateTime(Time, vbShortTime) & "]"
  Close #1
  SetAttr Dir & "已归档 Memos.mem", vbReadOnly
 End If
 SetAttr strFileName, vbArchive
 If strFileName <> Dir & "临时事务.mem" Then
   If strFileName <> "" Then Kill strFileName
 Else
   Open strFileName For Output As #3
     Print #3, "临时事务" & Chr(13) & Chr(10) & "[创建时间:" & Date & " " & WK(Weekday(Date)) & " " & FormatDateTime(Time, vbShortTime) & "]"
   Close #3
   SetAttr strFileName, vbReadOnly
 End If
 
 End
End Sub
'退出归档
Private Sub Command3_Click()
End
End Sub
'打印
Private Sub Command4_Click()

Dim cfgPathLen As Integer
Dim cfgtt As String
Dim i, l As Integer

'cfgPath = "jhs发福djk sdklhl就哈抗菌素进口货可见类毒素分厘卡速度"


i = 1
l = Len(cfgPath)
cfgtt = cfgPath

Do While Clen(cfgtt) > 20
cfgtt = Left(cfgPath, l - i)
i = i + 1
Loop
If Clen(cfgPath) > 20 Then cfgtt = cfgtt & "..."
cfgPathLen = Clen(cfgtt)

Printer.Print "**********************************"
'Printer.Print "*        Arthur's Memos          *"
Printer.Print "*" & Space(Int((32 - cfgPathLen) / 2)) & cfgtt & Space(32 - Int((32 - cfgPathLen) / 2) - cfgPathLen) & "*"
Printer.Print "*           " & Date & Space(10 - Len(Date)) & "           *"
Printer.Print "**********************************"
Printer.Print Chr(13) & Chr(10)
Printer.Print FmtTxt(Text1.Text)
End
End Sub

Private Sub Command5_Click()
Dim positemp As Integer
'Text2.Text = "   曹二哥 "
Text2.Text = Trim(Text2.Text)
positemp = FindandGo(Text1.Text, SrchStart, Text2.Text)
If positemp >= 0 Then
  Text1.SelStart = positemp
  Text1.SelLength = Len(Text2.Text)
Else
  Text1.SelStart = 0
  Text1.SelLength = 0
End If
'MsgBox SrchStart
Text1.SetFocus
SrchStart = Text1.SelStart + Text1.SelLength
End Sub

Private Sub Form_Activate()
Text1.SelStart = Len(Text1.Text) + 1
Text1.SetFocus
End Sub

Private Sub Form_Click()
ChgBkClr
End Sub

Private Sub Form_DblClick()
RstBkClr
End Sub

Private Sub Form_Load()
'获得各个目录
   Dim sTmp As String * MAX_LEN '存放结果的固定长度的字符串
   Dim nLength As Long '字符串的实际长度
   Dim pidl As Long '某特殊目录在特殊目录列表中的位置

   
   SrchStart = 0
   WK = Array("", "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT") '空字串为了适应 Weekday函数
   
   '*************************获得我的文档目录*********************************
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   my_doc_path = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
  
   Image1.Picture = LoadPicture(my_doc_path & "\Quick Memos\icons\photo.jpg")
   
    
    Open my_doc_path & "\Quick Memos\cfg.txt" For Input As #10
    Line Input #10, cfgPath
    Close #10
    cfgPath = Trim(cfgPath)
    编辑.Caption = cfgPath & " - 查看/编辑 Memo"
    Dir = my_doc_path & "\Quick Memos\" & cfgPath & "\"
    
    Open my_doc_path & "\Quick Memos\vsn.txt" For Input As #11
    Line Input #11, relvsn
    Close #11
    Label2.Caption = "Rel:" & relvsn
    
    
   Dim Vrgb As Long
   Dim r, b, g As Integer
   
   Open my_doc_path & "\Quick Memos\edit\color.txt" For Input As #21
   Input #21, r
   Input #21, g
   Input #21, b
   Close #21
   Vrgb = RGB(r, g, b)
   
   编辑.BackColor = Vrgb
   Check1.BackColor = Vrgb
   Check2.BackColor = Vrgb
   Check3.BackColor = Vrgb
   Label1(0).BackColor = Vrgb
   Label1(1).BackColor = Vrgb
   Label2.BackColor = Vrgb
   Label3.BackColor = Vrgb
   Text1.BackColor = Vrgb
   Text2.BackColor = Vrgb
    

    PF = ".mem"
    strFileName = Replace(Command$, """", "")
    'strFileName = Dir & "111.mem"
'MsgBox Weekday(Date)
    Check1.Value = 1



Dim Lstr As String

'strFileName = Dir & "已归档 Memos.mem"

If UCase(Right(strFileName, 9)) = "已归档~1.MEM" Or UCase(Right(strFileName, 13)) = "已归档 MEMOS.MEM" Then
  Command2.Visible = False
  Command1.Visible = False
  Command3.Visible = True
  Command3.Height = 2800
  Command3.Top = 2800
  Check1.Visible = False
  Check2.Visible = False
  Check3.Visible = False
  Label1(0).Visible = False
  Label1(1).Visible = False
  Text1.Top = 300
  Text1.Height = 4800
  Text1.Locked = True
  编辑.Height = 6255
  编辑.Caption = "Arthur's Memos - 已归档 Memos"
  Text2.Visible = True
  Command5.Visible = True
  Label3.Visible = True
  Text2.Top = 5260
  Command5.Top = 5240
  Label3.Top = 5300
  
End If

If UCase(strFileName) = UCase(Dir & "临时事务.mem") Then
  Command2.Caption = "清空"
  Label1(1).Caption = "清空时归档"
End If



If strFileName <> "" Then
'Open strFileName For Input As #1

'Do While Not EOF(1)
'    Line Input #1, Lstr
'    Text1.Text = Text1.Text & Lstr & vbCrLf
'Loop

'下面的读文本文件全部内容的方法快得多
Open strFileName For Binary As #1
Text1.Text = Input$(LOF(1), #1)
Close #1
End If


Dim Temp_Text1 As String

Temp_Text1 = Left(Text1.Text, 2)
If InStr(1, Temp_Text1, "↑") = 0 Then
    Check2.Value = 0
Else
    Check2.Value = 1
End If

If InStr(1, Temp_Text1, "※") = 0 Then
    Check3.Value = 0
Else
    Check3.Value = 1
End If


Text1.Text = FmtTxt(Text1.Text)

End Sub


Function Set_JiZhong()
    Dim Ji, Zhong As String
    
    Ji = ""
    If Check2.Value = 1 Then Ji = "↑"
    Zhong = ""
    If Check3.Value = 1 Then Zhong = "※"
    
    Text1 = Replace(Text1, "↑", "", 1, 2)
    Text1 = Replace(Text1, "※", "", 1, 2)
    Text1 = Ji + Zhong + Text1

End Function
   
Private Sub Check2_Click()
    Set_JiZhong
End Sub

Private Sub Check3_Click()
    Set_JiZhong
End Sub



Private Sub Image1_Click()
ChgBkClr
End Sub

Private Sub Image1_DblClick()
RstBkClr
End Sub

Private Sub Image2_Click()
ChgBkClr
End Sub

Private Sub Image2_DblClick()
RstBkClr
End Sub

Private Sub Label1_Click(Index As Integer)
ChgBkClr
End Sub

Private Sub Label1_DblClick(Index As Integer)
RstBkClr
End Sub

Private Sub Label2_Click()
ChgBkClr
End Sub

Private Sub Label2_DblClick()
RstBkClr
End Sub

Private Sub Label3_Click()
ChgBkClr
End Sub

Private Sub Label3_DblClick()
RstBkClr
End Sub
