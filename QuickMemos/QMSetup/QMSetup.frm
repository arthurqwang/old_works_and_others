VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Quick Memos V1 安装程序"
   ClientHeight    =   2250
   ClientLeft      =   4155
   ClientTop       =   1425
   ClientWidth     =   5880
   Icon            =   "QMSetup.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2250
   ScaleWidth      =   5880
   Begin VB.CommandButton Command2 
      Caption         =   "完成"
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   1680
      Visible         =   0   'False
      Width           =   5655
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   1680
      Width           =   5655
   End
   Begin VB.TextBox Text1 
      Height          =   270
      Left            =   120
      TabIndex        =   1
      Top             =   1320
      Width           =   4335
   End
   Begin VB.Label Label3 
      BackColor       =   &H00FFFFFF&
      Caption         =   "安装在[我的文档]下 Quick Memos 目录"
      Height          =   255
      Left            =   720
      TabIndex        =   10
      Top             =   840
      Width           =   3735
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFFFFF&
      Caption         =   "[] 桌面调整完毕，现在可正常使用 Quick Memos 了"
      Height          =   255
      Left            =   400
      TabIndex        =   9
      Top             =   2400
      Visible         =   0   'False
      Width           =   4215
   End
   Begin VB.Shape Shape1 
      Height          =   735
      Left            =   120
      Top             =   1560
      Visible         =   0   'False
      Width           =   5415
   End
   Begin VB.Label Label7 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Label7"
      Height          =   255
      Left            =   500
      TabIndex        =   8
      Top             =   1800
      Visible         =   0   'False
      Width           =   4800
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "[] 正在拷贝文件，请等待..."
      Height          =   255
      Left            =   400
      TabIndex        =   7
      Top             =   1090
      Visible         =   0   'False
      Width           =   2415
   End
   Begin VB.Image Image3 
      Height          =   480
      Left            =   600
      Picture         =   "QMSetup.frx":058A
      Top             =   240
      Width           =   450
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "卸载时只要删掉安装目录即可"
      Height          =   255
      Left            =   675
      TabIndex        =   6
      Top             =   480
      Width           =   3495
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "绝对绿色，不修改任何系统参数"
      Height          =   255
      Left            =   720
      TabIndex        =   5
      Top             =   240
      Width           =   3375
   End
   Begin VB.Label Label2 
      BackColor       =   &H00FFFFFF&
      Caption         =   "[] 文件拷贝完毕，请按下面说明调整桌面:"
      Height          =   255
      Left            =   400
      TabIndex        =   4
      Top             =   1350
      Visible         =   0   'False
      Width           =   3500
   End
   Begin VB.Image Image2 
      Height          =   330
      Left            =   4560
      Picture         =   "QMSetup.frx":3ED8
      Top             =   1200
      Width           =   1140
   End
   Begin VB.Image Image1 
      Height          =   900
      Left            =   4680
      Picture         =   "QMSetup.frx":80B1
      Top             =   120
      Width           =   900
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "请指定你自己的 Memos 栏的标题(如:Arthur's Memos):"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   1125
      Width           =   4455
   End
   Begin VB.Label Label9 
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
      Left            =   4680
      TabIndex        =   11
      Top             =   960
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
   '获得各个目录
   Private Declare Function SHGetSpecialFolderLocation Lib "Shell32" (ByVal hwndOwner As Long, ByVal nFolder As Integer, ppidl As Long) As Long
   Private Declare Function SHGetPathFromIDList Lib "Shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal szPath As String) As Long
   Private Declare Function GetWindowsDirectory Lib "Kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
   Private Declare Function GetSystemDirectory Lib "Kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
   Private Declare Function GetTempPath Lib "Kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
   
   Private Declare Sub Sleep Lib "Kernel32" (ByVal dwMilliseconds As Long)
   
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
   
       Dim my_doc_path As String
   
       Option Explicit
     
     Private Const FO_COPY = &H2& 'Copies the files specified
     'in the pFrom member to the
     'location specified in the
     'pTo member.
     
     Private Const FO_DELETE = &H3& 'Deletes the files specified
     'in pFrom (pTo is ignored.)
     
     Private Const FO_MOVE = &H1& 'Moves the files specified
     'in pFrom to the location
     'specified in pTo.
     
     Private Const FO_RENAME = &H4& 'Renames the files
     'specified in pFrom.
     
     Private Const FOF_ALLOWUNDO = &H40& 'Preserve Undo information.
     
     Private Const FOF_CONFIRMMOUSE = &H2& 'Not currently implemented.
     
     Private Const FOF_CREATEPROGRESSDLG = &H0& 'handle to the parent
     'window for the
     'progress dialog box.
     
     Private Const FOF_FILESONLY = &H80& 'Perform the operation
     'on files only if a
     'wildcard file name
     '(*.*) is specified.
     
     Private Const FOF_MULTIDESTFILES = &H1& 'The pTo member
     'specifies multiple
     'destination files (one
     'for each source file)
     'rather than one
     'directory where all
     'source files are
     'to be deposited.
     
     Private Const FOF_NOCONFIRMATION = &H10& 'Respond with Yes to
     'All for any dialog box
     'that is displayed.
     
     Private Const FOF_NOCONFIRMMKDIR = &H200& 'Does not confirm the
     'creation of a new
     'directory if the
     'operation requires one
     'to be created.
     
     Private Const FOF_RENAMEONCOLLISION = &H8& 'Give the file being
     'operated on a new name
     'in a move, copy, or
     'rename operation if a
     'file with the target
     'name already exists.
     
     Private Const FOF_SILENT = &H4& 'Does not display a
     'progress dialog box.
     
     Private Const FOF_SIMPLEPROGRESS = &H100& 'Displays a progress
     'dialog box but does
     'not show the
     'file names.
     
     Private Const FOF_WANTMAPPINGHANDLE = &H20&
     'If FOF_RENAMEONCOLLISION is specified,
     'the hNameMappings member will be filled
     'in if any files were renamed.
     
     ' The SHFILOPSTRUCT is not double-word aligned. If no steps are
     ' taken, the last 3 variables will not be passed correctly. This
     ' has no impact unless the progress title needs to be changed.
     
     Private Type SHFILEOPSTRUCT
     hwnd As Long
     wFunc As Long
     pFrom As String
     pTo As String
     fFlags As Integer
     fAnyOperationsAborted As Long
     hNameMappings As Long
     lpszProgressTitle As String
     End Type
     
     Private Declare Sub CopyMemory Lib "Kernel32" _
     Alias "RtlMoveMemory" _
     (hpvDest As Any, _
     hpvSource As Any, _
     ByVal cbCopy As Long)
     
     Private Declare Function SHFileOperation Lib "Shell32.dll" _
     Alias "SHFileOperationA" _
     (lpFileOp As Any) As Long
     
'文件扩展名关联editmem.exe
     Private Declare Function RegCreateKey Lib "advapi32.dll" _
     Alias "RegCreateKeyA" (ByVal hKey As Long, _
     ByVal lpSubKey As String, phkResult As Long) As Long
     
     Private Declare Function RegSetValue Lib "advapi32.dll" _
     Alias "RegSetValueA" (ByVal hKey As Long, _
     ByVal lpSubKey As String, ByVal dwType As Long, ByVal _
     lpData As String, ByVal cbData As Long) As Long

    ' Return codes from Registration functions.
    Const ERROR_SUCCESS = 0&
    Const ERROR_BADDB = 1&
    Const ERROR_BADKEY = 2&
    Const ERROR_CANTOPEN = 3&
    Const ERROR_CANTREAD = 4&
    Const ERROR_CANTWRITE = 5&
    Const ERROR_OUTOFMEMORY = 6&
    Const ERROR_INVALID_PARAMETER = 7&
    Const ERROR_ACCESS_DENIED = 8&
    
    Private Const HKEY_CLASSES_ROOT = &H80000000
    Private Const MAX_PATH = 260&
    Private Const REG_SZ = 1
     
     


Private Sub Command1_Click()

   Dim strFileName As String '文件名
   Dim pathlen As String
   Dim intro As String
   Dim qm As String

   qm = "\Quick Memos"

   
   Text1.Text = Trim(Text1.Text)
   'MkDir (my_doc_path & "\Quick Memos")
   If Text1.Text = "" Then Text1.Text = "My Memos"
   
   
   
'   Name my_doc_path & "\Quick Memos\Arthur's Memos" As my_doc_path & "\Quick Memos\" & Text1.Text
  
   Label6.Visible = True
   Label1.Visible = False

   Command1.Visible = False
   Text1.Visible = False
   
   Form1.Refresh
Sleep 5000
   
'开始拷贝文件
Dim result As Long
     Dim lenFileop As Long
     Dim foBuf() As Byte
     Dim fileop As SHFILEOPSTRUCT
     
     lenFileop = LenB(fileop) ' double word alignment increase
     ReDim foBuf(1 To lenFileop) ' the size of the structure.
     
     With fileop
     .hwnd = Me.hwnd
     
     .wFunc = FO_COPY
     
     ' The files to copy separated by Nulls and terminated by two
     ' nulls
    
     .pFrom = App.Path & "\Quick Memos"
   '  MsgBox "from: " & .pFrom
     
     .fFlags = FOF_SIMPLEPROGRESS Or FOF_FILESONLY
    
     
     .pTo = my_doc_path & qm & vbNullChar & vbNullChar
 '    MsgBox .pTo
     
     End With
     
     ' Now we need to copy the structure into a byte array
     Call CopyMemory(foBuf(1), fileop, lenFileop)
     
     ' Next we move the last 12 bytes by 2 to byte align the data
     Call CopyMemory(foBuf(19), foBuf(21), 12)
     result = SHFileOperation(foBuf(1))
     
     If result <> 0 Then ' Operation failed
    ' MsgBox Err.LastDllError 'Show the error returned from
     'the API.
     Else
     If fileop.fAnyOperationsAborted <> 0 Then
     MsgBox "Operation Failed"
     End If
     End If
     
   Name my_doc_path & qm & "\Arthur's Memos" As my_doc_path & qm & "\" & Text1.Text
       
'拷贝结束

   Open my_doc_path & qm & "\cfg.txt" For Output As #1
   Print #1, Text1.Text
   Close #1

'关联mem

Dim sKeyName As String 'Holds Key Name in registry.
Dim sKeyValue As String 'Holds Key Value in registry.
Dim ret& 'Holds error status if any from API calls.
Dim lphKey& 'Holds created key handle from RegCreateKey.

'This creates a Root entry called "Quick Memos".
sKeyName = "Quick Memos"
sKeyValue = "Quick Memos"
ret& = RegCreateKey&(HKEY_CLASSES_ROOT, sKeyName, lphKey&)
ret& = RegSetValue&(lphKey&, "", REG_SZ, sKeyValue, 0&)

'This creates a Root entry called .mem associated with "Quick Memos".
sKeyName = ".MEM"
sKeyValue = "Quick Memos"
ret& = RegCreateKey&(HKEY_CLASSES_ROOT, sKeyName, lphKey&)
ret& = RegSetValue&(lphKey&, "", REG_SZ, sKeyValue, 0&)

'This sets the command line for "Quick Memos".
sKeyName = "Quick Memos"
'sKeyValue = "c:\mydir\my.exe %1"
sKeyValue = my_doc_path & qm & "\edit\editmem.exe %1"


ret& = RegCreateKey&(HKEY_CLASSES_ROOT, sKeyName, lphKey&)
ret& = RegSetValue&(lphKey&, "shell\open\command", REG_SZ, _
sKeyValue, MAX_PATH)



   Shape1.Visible = True
   Shape1.Left = 450
   Shape1.Top = 1700
   Shape1.Width = 5000
   Shape1.Height = 2700
     
   
   Command2.Visible = True
   Command2.Top = 5000



   Form1.Height = 6000
   Label2.Visible = True
   Label7.Visible = True
   Label7.Left = 600
   Label7.Height = 5500
   Label8.Visible = True
   Label8.Top = 4600
   
   intro = "1) 左键拖拽任务栏，将其移到桌面左侧，右击任务栏，到      工具栏/新建工具栏，选到" & Chr(13) & Chr(10) & "     " & my_doc_path & qm & "\" & Text1.Text & Chr(13) & Chr(10)
   intro = intro & "2) 将[" & Text1.Text & "]移动到任务栏的顶端" & Chr(13) & Chr(10)
   intro = intro & "3) 右击[" & Text1.Text & "]栏空白处，" & Chr(13) & Chr(10) & "    选上'显示文字'、'显示标题'" & Chr(13) & Chr(10)
   intro = intro & "4) 右击[" & Text1.Text & "]栏空白处，" & Chr(13) & Chr(10) & "    选上/查看/小图标" & Chr(13) & Chr(10)
   intro = intro & "5) 在[" & Text1.Text & "]栏中,将 '创建 Memos' 、" & Chr(13) & Chr(10) & "   '打印全部 Memos'、'临时事务'、和 '已归档 Memos' " & Chr(13) & Chr(10) & "    移到最上面" & Chr(13) & Chr(10)
  
Label7.Caption = intro
      
End Sub

Private Sub Command2_Click()
End
End Sub

Private Sub Form_Load()
'获得各个目录
   Dim sTmp As String * MAX_LEN  '存放结果的固定长度的字符串
   Dim nLength As Long '字符串的实际长度
   Dim pidl As Long '某特殊目录在特殊目录列表中的位置
   Dim relvsn As String
  
   Dim intro As String
   
   '获得我的文档目录
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   my_doc_path = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   'MsgBox my_doc_path

    Open App.Path & "\Quick Memos\vsn.txt" For Input As #11
    Line Input #11, relvsn
    Close #11
    Label9.Caption = "Rel:" & relvsn
   
End Sub

