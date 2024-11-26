VERSION 5.00
Begin VB.Form 创建 
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   2025
   ClientLeft      =   5730
   ClientTop       =   4860
   ClientWidth     =   5325
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
   Icon            =   "create.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   5325
   StartUpPosition =   2  '屏幕中心
   Begin VB.CheckBox Check2 
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
      Height          =   255
      Left            =   960
      TabIndex        =   5
      Top             =   1560
      Width           =   450
   End
   Begin VB.CheckBox Check1 
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
      Left            =   120
      TabIndex        =   4
      Top             =   1560
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2160
      TabIndex        =   1
      Top             =   1440
      Width           =   1695
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
      Height          =   975
      IMEMode         =   4  'DBCS HIRAGANA
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   360
      Width           =   3735
   End
   Begin VB.Image Image2 
      Height          =   330
      Left            =   4050
      Picture         =   "create.frx":058A
      Top             =   1440
      Width           =   1140
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
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   3015
   End
   Begin VB.Image Image1 
      Height          =   900
      Left            =   4140
      Stretch         =   -1  'True
      Top             =   360
      Width           =   900
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Caption         =   "Rel:20000000"
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
      TabIndex        =   3
      Top             =   1200
      Width           =   975
   End
End
Attribute VB_Name = "创建"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'****************************************************************************
'此文件的　exe 文件要拷贝到　Quick Memos\Arthur's Memos (或相应目录)　下
'并改名为　"创建　Memo.exe"
'并设"创建　Memo.exe"文件属性为　只读
'****************************************************************************
   
   
   
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
   
   Dim Dir, td As String '工作目录
   Dim my_doc_path As String
   
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
Function ChgBkClr()
   Dim Vrgb As Long
   Dim r, b, g As Integer
   Randomize
   r = 255 - Int(Rnd * 39 + 1)
   g = 255 - Int(Rnd * 39 + 1)
   b = 255 - Int(Rnd * 39 + 1)
   Open my_doc_path & "\Quick Memos\create\color.txt" For Output As #22
   Print #22, r
   Print #22, g
   Print #22, b
   Close #22
   
   Vrgb = RGB(r, g, b)
   创建.BackColor = Vrgb
   Label1.BackColor = Vrgb
   Label2.BackColor = Vrgb
   Text1.BackColor = Vrgb
   Check1.BackColor = Vrgb
   Check2.BackColor = Vrgb
End Function
Function RstBkClr()
   Dim Vrgb As Long
   Dim r, b, g As Integer
   Randomize
   r = 255
   g = 255
   b = 255
   Open my_doc_path & "\Quick Memos\create\color.txt" For Output As #22
   Print #22, r
   Print #22, g
   Print #22, b
   Close #22
   
   Vrgb = RGB(r, g, b)
   创建.BackColor = Vrgb
   Label1.BackColor = Vrgb
   Label2.BackColor = Vrgb
   Text1.BackColor = Vrgb
   Check1.BackColor = Vrgb
   Check2.BackColor = Vrgb
End Function

Function Set_JiZhong()
    Dim Ji, Zhong As String
    
    Ji = ""
    If Check1.Value = 1 Then Ji = "↑"
    Zhong = ""
    If Check2.Value = 1 Then Zhong = "※"
    
    Text1 = Replace(Text1, "↑", "", 1, 2)
    Text1 = Replace(Text1, "※", "", 1, 2)
    Text1 = Ji + Zhong + Text1

End Function
   
Private Sub Check1_Click()
    Set_JiZhong
End Sub

Private Sub Check2_Click()
    Set_JiZhong
End Sub

Private Sub Command1_Click()
Dim strFileName As String '文件名

Dim PF As String '文件名后缀

Dim lngHandle As Long '句柄
Dim strWrite As String '要写入的文本内容

Dim WK As Variant
WK = Array("", "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT") '空字串为了适应 Weekday函数


   PF = ".mem"

    strFileName = Left(Trim(Left(Text1, InStr(Text1 & Chr(13), Chr(13)) - 1)), 30)
'MsgBox strFileName
    If strFileName = "" Then
      strFileName = "Memo "
      Dim fs As New FileSystemObject
      Dim i As Integer
      i = 1
      Do While fs.FileExists(Dir & strFileName & i & PF)
       i = i + 1
'MsgBox i
      Loop
      strFileName = strFileName & i
    End If
'MsgBox strFileName
    

    strFileName = Dir & strFileName & PF
    
    lngHandle = FreeFile() '取得句柄

 

    '准备要写入的内容

    strWrite = Text1 & Chr(13) & Chr(10) & "[创建时间:" & Date & " " & WK(Weekday(Date)) & " " & FormatDateTime(Time, vbShortTime) & "]"
  
    Open strFileName For Output As lngHandle    '打开文件

    Print #lngHandle, FmtTxt(strWrite)    '写入文本

    Close lngHandle    '关闭文件
    SetAttr strFileName, vbReadOnly
    End
End Sub

Private Sub Form_Click()
ChgBkClr
End Sub

Private Sub Form_DblClick()
RstBkClr
End Sub

Private Sub Form_Load()
'MsgBox Text1.IMEMode
'获得各个目录
   Dim sTmp As String * MAX_LEN '存放结果的固定长度的字符串
   Dim nLength As Long '字符串的实际长度
   Dim pidl As Long '某特殊目录在特殊目录列表中的位置


   
   '*************************获得我的文档目录*********************************
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   my_doc_path = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   
   Dim cfgPath As String
    Open my_doc_path & "\Quick Memos\cfg.txt" For Input As #10
    Line Input #10, cfgPath
    Close #10
    cfgPath = Trim(cfgPath)
    创建.Caption = cfgPath & " - 创建 Memo"
    Dir = my_doc_path & "\Quick Memos\" & cfgPath & "\"
  
   Image1.Picture = LoadPicture(my_doc_path & "\Quick Memos\icons\photo.jpg")
   
   Open my_doc_path & "\Quick Memos\vsn.txt" For Input As #11
    Line Input #11, relvsn
    Close #11
    Label2.Caption = "Rel:" & relvsn
    
   Dim Vrgb As Long
   Dim r, b, g As Integer
   
   Open my_doc_path & "\Quick Memos\create\color.txt" For Input As #21
   Input #21, r
   Input #21, g
   Input #21, b
   Close #21
   Vrgb = RGB(r, g, b)
   创建.BackColor = Vrgb
   Label1.BackColor = Vrgb
   Label2.BackColor = Vrgb
   Text1.BackColor = Vrgb
   Check1.BackColor = Vrgb
   Check2.BackColor = Vrgb
  
    
End Sub


'Private Sub Form_Resize()
'  If 创建.Width >= 5445 And 创建.Height >= 2535 Then
'    Text1.Width = 创建.Width - 1710
'    Text1.Height = 创建.Height - 1560
'    Command1.Top = Text1.Top + Text1.Height + 105
'    Command1.Width = Text1.Width
'    Image1.Left = 创建.Width - 1305
'    Image2.Left = 创建.Width - 1395
'    Label2.Left = 创建.Width - 1445
'  End If
'End Sub

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

Private Sub Label1_Click()
ChgBkClr
End Sub

Private Sub Label1_DblClick()
RstBkClr
End Sub

Private Sub Label2_Click()
ChgBkClr
End Sub

Private Sub Label2_DblClick()
RstBkClr
End Sub
