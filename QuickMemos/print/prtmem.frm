VERSION 5.00
Begin VB.Form 打印 
   BackColor       =   &H80000009&
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   5445
   ClientLeft      =   4185
   ClientTop       =   2745
   ClientWidth     =   5085
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
   ForeColor       =   &H000000FF&
   Icon            =   "prtmem.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5445
   ScaleWidth      =   5085
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
      Height          =   3255
      Left            =   3960
      TabIndex        =   4
      Top             =   1920
      Width           =   975
   End
   Begin VB.CheckBox Check1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Check1"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   4920
      Value           =   1  'Checked
      Width           =   255
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
      Height          =   4455
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   360
      Width           =   3735
   End
   Begin VB.Image Image2 
      Height          =   330
      Left            =   3870
      Picture         =   "prtmem.frx":058A
      Top             =   1440
      Width           =   1140
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "仅打印标题和临时事务"
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
      TabIndex        =   3
      Top             =   4965
      Width           =   3015
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "打印内容 (可编辑，改动不被保存)"
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
      TabIndex        =   1
      Top             =   120
      Width           =   3015
   End
   Begin VB.Image Image1 
      Height          =   900
      Left            =   4000
      Stretch         =   -1  'True
      Top             =   360
      Width           =   900
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Caption         =   "Rel:20061106"
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
      Left            =   3900
      TabIndex        =   5
      Top             =   1200
      Width           =   975
   End
End
Attribute VB_Name = "打印"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***************************************************************************************
'编译后 exe 文件拷贝到　Quick Memos\Arthur's Momes(或相关目录)下
'改名为　"打印全部　Memos"
'文件属性设为　只读
'***************************************************************************************
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
Dim Topic, lssw, ttop As String
Dim cfgPath As String
   Dim my_doc_path As String

Option Explicit

 Function GetFileList(ByVal Path As String, ByRef Filename() As String, Optional fExp As String = "*.*") As Boolean
          Dim fName     As String, i       As Long
          If Right$(Path, 1) <> "\" Then Path = Path & "\"
          fName = Dir$(Path & fExp)
          i = 0
          Do While fName <> ""
                  ReDim Preserve Filename(i) As String
                  Filename(i) = fName
                  fName = Dir$
                  i = i + 1
          Loop
          If i <> 0 Then
                  ReDim Preserve Filename(i - 1) As String
                  GetFileList = True
          Else
                  GetFileList = False
          End If
  End Function
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

Function ChgBkClr()
   Dim Vrgb As Long
   Dim r, b, g As Integer
   Randomize
   r = 255 - Int(Rnd * 39 + 1)
   g = 255 - Int(Rnd * 39 + 1)
   b = 255 - Int(Rnd * 39 + 1)
   Open my_doc_path & "\Quick Memos\print\color.txt" For Output As #22
   Print #22, r
   Print #22, g
   Print #22, b
   Close #22
   
   Vrgb = RGB(r, g, b)
   打印.BackColor = Vrgb
   Label1(0).BackColor = Vrgb
   Label1(1).BackColor = Vrgb
   Label2.BackColor = Vrgb
   Text1.BackColor = Vrgb
    End Function
Function RstBkClr()
   Dim Vrgb As Long
   Dim r, b, g As Integer
   Randomize
   r = 255
   g = 255
   b = 255
   Open my_doc_path & "\Quick Memos\print\color.txt" For Output As #22
   Print #22, r
   Print #22, g
   Print #22, b
   Close #22
   
   Vrgb = RGB(r, g, b)
   打印.BackColor = Vrgb
   Label1(0).BackColor = Vrgb
   Label1(1).BackColor = Vrgb
   Label2.BackColor = Vrgb
   Text1.BackColor = Vrgb
    End Function
   




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
Printer.Print Chr(13) & Chr(10) & "----------------------------------"
Dim linshishiwu As String
linshishiwu = lssw
If Check1.Value = 1 Then
Printer.Print Topic
Printer.Print FmtTxt(linshishiwu)
Else
Printer.Print FmtTxt(Text1.Text)
End If
Printer.Print Chr(13) & Chr(10) & "----------------------------------"
End
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

   
   Dim strFileName As String '文件名
   Dim Dir As String '工作目录
   Dim PF As String '文件名后缀

   Dim lngHandle As Long '句柄
   Dim strWrite As String '要写入的文本内容
   Dim relvsn As String 'Release No
   
   '*************************获得我的文档目录*********************************
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   my_doc_path = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   
   Image1.Picture = LoadPicture(my_doc_path & "\Quick Memos\icons\photo.jpg")
 

    Open my_doc_path & "\Quick Memos\cfg.txt" For Input As #10
    Line Input #10, cfgPath
    Close #10
    cfgPath = Trim(cfgPath)
    打印.Caption = cfgPath & " - 打印全部 Memos"
    
    Open my_doc_path & "\Quick Memos\vsn.txt" For Input As #11
    Line Input #11, relvsn
    Close #11
    Label2.Caption = "Rel:" & relvsn
    
   Dim Vrgb As Long
   Dim r, b, g As Integer
   
   Open my_doc_path & "\Quick Memos\print\color.txt" For Input As #21
   Input #21, r
   Input #21, g
   Input #21, b
   Close #21
   Vrgb = RGB(r, g, b)
   
   打印.BackColor = Vrgb
   Label1(0).BackColor = Vrgb
   Label1(1).BackColor = Vrgb
   Label2.BackColor = Vrgb
   Text1.BackColor = Vrgb
    
    Dir = my_doc_path & "\Quick Memos\" & cfgPath & "\"
 '   Dir = my_doc_path & "\Quick Memos\Arthur's Memos\"

    PF = ".mem"
    strFileName = Replace(Command$, """", "")
    'strFileName = Dir & "111.mem"
    'MsgBox strFileName
   


Dim Lstr As String
'MsgBox strFileName & "kkk"
  
Dim i, j    As Long
Dim FN()     As String
Dim Spcs As String


GetFileList Dir, FN, "*" & PF

For i = 0 To UBound(FN)
 If FN(i) <> "已归档 Memos.mem" And FN(i) <> "临时事务.mem" Then
   j = j + 1
   If j < 10 Then
     Spcs = "  "
   Else
     Spcs = " "
   End If
   Open Dir & FN(i) For Input As #1
   Line Input #1, ttop
   Topic = Topic & j & Spcs & ttop & Chr(13) & Chr(10)
   Text1.Text = Text1.Text & ttop & Chr(13) & Chr(10)
   Do While Not EOF(1)
    Line Input #1, Lstr
    Text1.Text = Text1.Text & Lstr & vbCrLf
   Loop
   Text1.Text = Text1.Text & Chr(13) & Chr(10) & "----------------------------------" & Chr(13) & Chr(10)
   Close #1
 End If
Next i
Topic = Topic & "----------------------------------"

Open Dir & "临时事务.mem" For Input As #1

Do While Not EOF(1)
    Line Input #1, Lstr
    lssw = lssw & Lstr & vbCrLf
Loop
Close #1
Text1.Text = FmtTxt(Text1.Text & lssw)

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
