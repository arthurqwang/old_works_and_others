VERSION 5.00
Begin VB.Form 编辑 
   BackColor       =   &H80000009&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Arthur's Memos - 编辑 Memo"
   ClientHeight    =   2025
   ClientLeft      =   720
   ClientTop       =   2325
   ClientWidth     =   4455
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
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   4455
   StartUpPosition =   2  '屏幕中心
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
      Left            =   120
      TabIndex        =   1
      Top             =   1440
      Width           =   3135
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
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   360
      Width           =   3135
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "AW 2006"
      Height          =   255
      Left            =   3360
      TabIndex        =   4
      Top             =   1560
      Width           =   855
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "Copyright"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3360
      TabIndex        =   3
      Top             =   1320
      Width           =   855
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
      Left            =   3300
      Picture         =   "create.frx":0000
      Stretch         =   -1  'True
      Top             =   360
      Width           =   975
   End
End
Attribute VB_Name = "编辑"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim strFileName As String '文件名
Dim Dir, td As String '工作目录
Dim PF As String '文件名后缀

Dim lngHandle As Long '句柄
Dim strWrite As String '要写入的文本内容

    Dir = "d:\My Documents\Arthur's Memos\"
    PF = ".mem"

    strFileName = Trim(Left(Text1, InStr(Text1 & Chr(13), Chr(13)) - 1))
    If strFileName = "" Then
      strFileName = "Memo "
      Dim fs As New FileSystemObject
      Dim i As Integer
      i = 1
      Do While fs.FileExists(strFileName & i & PF)
       i = i + 1

      Loop
      strFileName = strFileName & i
    End If
    
    

    strFileName = Dir & strFileName & PF
    
    lngHandle = FreeFile() '取得句柄

    

    '准备要写入的内容

    strWrite = Text1 & Chr(13) & Chr(10) & "创建时间:" & Date

    

    Open strFileName For Output As lngHandle    '打开文件

    Print #lngHandle, strWrite    '写入文本

    Close lngHandle    '关闭文件
    End
End Sub

