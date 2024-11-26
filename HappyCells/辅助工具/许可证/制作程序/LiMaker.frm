VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   3750
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7710
   Icon            =   "LiMaker.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3750
   ScaleWidth      =   7710
   StartUpPosition =   2  '屏幕中心
   Begin VB.CommandButton DELETE_SALES_BUTTON 
      BackColor       =   &H0000FFFF&
      Caption         =   "-"
      Height          =   255
      Left            =   3560
      MaskColor       =   &H00FFFF00&
      Picture         =   "LiMaker.frx":0CCA
      TabIndex        =   20
      Top             =   1800
      Width           =   270
   End
   Begin VB.CommandButton CHANGE_PW_BUTTON 
      Caption         =   "更改密码"
      Height          =   735
      Left            =   2520
      TabIndex        =   19
      Top             =   2880
      Width           =   1335
   End
   Begin VB.CommandButton CREATE_SALES_BUTTON 
      BackColor       =   &H0000FFFF&
      Caption         =   "+"
      Height          =   255
      Left            =   3260
      MaskColor       =   &H00FFFF00&
      Picture         =   "LiMaker.frx":44FD
      TabIndex        =   18
      Top             =   1800
      Width           =   270
   End
   Begin VB.CommandButton END_BUTTON 
      Caption         =   "退出并查看证书"
      Enabled         =   0   'False
      Height          =   735
      Left            =   120
      TabIndex        =   17
      Top             =   2880
      Visible         =   0   'False
      Width           =   3735
   End
   Begin VB.TextBox PASSWORD_i 
      BackColor       =   &H00C0FFC0&
      Height          =   270
      IMEMode         =   3  'DISABLE
      Left            =   2640
      PasswordChar    =   "*"
      TabIndex        =   14
      Top             =   1800
      Width           =   615
   End
   Begin VB.TextBox SALES_i 
      BackColor       =   &H00FFC0FF&
      Height          =   270
      Left            =   1260
      TabIndex        =   13
      Top             =   1800
      Width           =   795
   End
   Begin VB.TextBox DAYS_i 
      BackColor       =   &H00C0E0FF&
      Height          =   270
      Left            =   1260
      TabIndex        =   11
      Text            =   "365"
      Top             =   1520
      Width           =   2595
   End
   Begin VB.TextBox BEGIN_DAY_i 
      BackColor       =   &H00C0FFFF&
      Height          =   270
      Left            =   1080
      TabIndex        =   10
      Top             =   1240
      Width           =   2775
   End
   Begin VB.TextBox COMPUTER_CODE_i 
      BackColor       =   &H00FFFFC0&
      Height          =   270
      Left            =   1080
      TabIndex        =   9
      Text            =   "0000.0000.0000.0000"
      Top             =   955
      Width           =   2775
   End
   Begin VB.TextBox USER_i 
      BackColor       =   &H00FFC0C0&
      Height          =   270
      Left            =   1080
      TabIndex        =   8
      Text            =   "方格临时许可的伙伴"
      Top             =   680
      Width           =   2775
   End
   Begin VB.CommandButton BEGIN_BUTTON 
      Caption         =   "制作许可证"
      Height          =   735
      Left            =   120
      TabIndex        =   1
      Top             =   2880
      Width           =   2295
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   3300
      Left            =   3960
      Picture         =   "LiMaker.frx":7D30
      ScaleHeight     =   3300
      ScaleWidth      =   3600
      TabIndex        =   0
      Top             =   240
      Width           =   3600
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "密码:"
      Height          =   255
      Left            =   2160
      TabIndex        =   16
      Top             =   1845
      Width           =   1575
   End
   Begin VB.Label Label8 
      BackStyle       =   0  'Transparent
      Caption         =   "经办人代码:"
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   1840
      Width           =   1575
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "状态:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   2160
      Width           =   495
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "有效期(天):"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1560
      Width           =   1575
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "启用日期:"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   1280
      Width           =   1575
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "机器代码:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   1000
      Width           =   1575
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "组织名称:"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   720
      Width           =   1575
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "  本程序用于制作开心情报站自动排版系统使用许可证。商业机密，非请勿观！"
      ForeColor       =   &H00FF0000&
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   120
      Width           =   3615
   End
   Begin VB.Label NOTE 
      BackStyle       =   0  'Transparent
      Caption         =   "请如实填写各项数据，否则不能正确生成证书。等待命令..."
      Height          =   735
      Left            =   720
      TabIndex        =   12
      Top             =   2160
      Width           =   3135
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'获得我的文档目录************************************************************************************
Private Declare Function SHGetSpecialFolderLocation Lib "Shell32" (ByVal hwndOwner As Long, ByVal nFolder As Integer, ppidl As Long) As Long
Private Declare Function SHGetPathFromIDList Lib "Shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal szPath As String) As Long
Const MAX_LEN = 200 '字符串最大长度
Const MYDOCUMENTS = &H5& '我的文档
'Option Explicit
Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias _
"GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long

Private Type OPENFILENAME
lStructSize As Long
hwndOwner As Long
hInstance As Long
lpstrFilter As String
lpstrCustomFilter As String
nMaxCustFilter As Long
nFilterIndex As Long
lpstrFile As String
nMaxFile As Long
lpstrFileTitle As String
nMaxFileTitle As Long
lpstrInitialDir As String
lpstrTitle As String
flags As Long
nFileOffset As Integer
nFileExtension As Integer
lpstrDefExt As String
lCustData As Long
lpfnHook As Long
lpTemplateName As String
End Type
Sub Get_My_Documents_Path()
'获得我的文档目录
   Dim sTmp As String * MAX_LEN  '存放结果的固定长度的字符串
   Dim pidl As Long '某特殊目录在特殊目录列表中的位置
    
   '获得我的文档目录
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   MY_DOC_PATH = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   'MsgBox my_doc_path
End Sub
'*********************************************************************************************************

Private Sub BEGIN_BUTTON_Click()

If Trim(USER_i.Text) = "" Or _
   Trim(COMPUTER_CODE_i.Text) = "" Or _
   Trim(SALES_i.Text) = "" Or _
   Trim(PASSWORD_i.Text) = "" Or _
   Trim(BEGIN_DAY_i.Text) = "" Or _
   Trim(DAYS_i.Text) = "" _
Then
   NOTE.Caption = "错误:所有数据都不能省略。"
   Form1.Refresh
   Exit Sub
End If

If LCase(Trim(SALES_i.Text)) = "admin" Then
   NOTE.Caption = "错误:管理员账号(admin)只能创建经办人账号，不能制作证书。"
   Form1.Refresh
   Exit Sub
End If

user = Trim(USER_i.Text)
Computer_Code = UCase(Trim(COMPUTER_CODE_i.Text))
Sales = Trim(SALES_i.Text)
Password = Trim(PASSWORD_i.Text)
begin_day = Trim(BEGIN_DAY_i.Text)
days = CInt(Trim(DAYS_i.Text))



Do While Check_PW = False
 NOTE.Caption = "错误:经办人代码不存在，或密码不匹配，请重新输入。"
 Form1.Refresh
 Exit Sub
Loop

BEGIN_BUTTON.Enabled = False
BEGIN_BUTTON.Visible = False
CHANGE_PW_BUTTON.Visible = False
CHANGE_PW_BUTTON.Enabled = False
CREATE_SALES_BUTTON.Enabled = False
DELETE_SALES_BUTTON.Enabled = False
END_BUTTON.Enabled = True
END_BUTTON.Visible = True

File_DIR = DOC_PATH & "\客户\" & user & "\" & Computer_Code
Create_Dir (File_DIR)
File_NM = File_DIR & "\licence.txt"
Open File_NM For Output As #10
Print #10, "* 请将此文件放在安全的地方保存，当证书有问题时用于恢复"
Print #10, "* 请将此文件拷贝到： “我的文档\《开心情报站》文档\使用许可证” 文件夹，覆盖原文件"
Print #10, "* 请勿编辑修改或移动本文件，否则将损毁许可证，导致系统不能运行"
Print #10, ""
Print #10, ""
Print #10, "****************************************************************************"
Print #10, "*                                                                          *"
Print #10, "*                          开心情报站自动排版系统                          *"
Print #10, "*                                使用许可证                                *"
Print #10, "*                                                                          *"
Print #10, "* " & user & ":" & Space(72 - Clen((user))) & "*"
Print #10, "*     大庆方格广告有限公司授权你公司(企业或个人，下同)在有关合同规定的范围 *"
Print #10, "* 内使用开心情报站自动排版系统及其附属系统。                               *"
Print #10, "*     贵公司使用该系统即表示接受下述约定：                                 *"
Print #10, "*        1 本系统所有权属于大庆方格广告有限公司；                          *"
Print #10, "*        2 本许可证仅限贵公司在本台计算机在约定的期限内使用；              *"
Print #10, "*        3 贵公司不得将本系统及其使用许可证转卖、转租、转用或转送；        *"
Print #10, "*        4 贵公司不得进行或允许其他个人与组织进行对本系统的破解、更改；    *"
Print #10, "*        5 贵公司不得修改或允许其他个人与组织修改本许可证；                *"
Print #10, "*        6 本公司对于贵公司因使用试用版本而造成的损失不负责。              *"
Print #10, "*     请贵公司严格遵守规定，否则，造成损失本公司不负责任，同时本公司保留追 *"
Print #10, "* 究贵公司法律责任的权利，以及其他一切合法权利。                           *"
Print #10, "*     感谢贵公司真诚的合作！                                               *"
Print #10, "*                                                                          *"
Print #10, "*                                        大庆方格广告有限公司              *"
Print #10, "*                                             " & CStr(Date) & Space(29 - Clen(CStr(Date))) & "*"
Print #10, "*                                                                          *"
Print #10, "****************************************************************************"
Print #10, ""
Print #10, "**许可证信息**"
Print #10, "# 授权方:大庆方格广告有限公司"
Print #10, "# 被授权方:" & user
Print #10, "# 机器代码:" & Computer_Code
Cal_L_ID
Print #10, "# 号码:" & Licence_ID
Print #10, "# 启用日期:" & FormatDateTime(begin_day, vbShortDate)
Print #10, "# 有效期(天):" & days
Print #10, "# 经办人代码:" & Sales
Print #10, ""
Print #10, ""
Print #10, "****************************************************************************"
Print #10, "*                                                                          *"
Print #10, "*                      关于试用版和许可证过期的限制                        *"
Print #10, "*                                                                          *"
Print #10, "*  1 试用版将在广告中插入《开心情报站》广告，不可删除或修改。              *"
Print #10, "*  2 试用版本排版功能没有限制，但不提供网上发布服务和其他服务。            *"
Print #10, "*  3 许可证过期超过一个月后，将视为试用版，需重新申请许可证。              *"
Print #10, "*    请提前办理续用手续。                                                  *"
Print #10, "*                                                                          *"
Print #10, "****************************************************************************"
Close #10
NOTE.Caption = "制作完毕。证书存储在:" & vbCrLf & File_NM

End Sub

Private Sub CHANGE_PW_BUTTON_Click()
Sales = Trim(SALES_i.Text)
Password = Trim(PASSWORD_i.Text)
If Check_PW = True Then
 Form3.Show
Else
 NOTE.Caption = "错误:登录失败，不能更改密码。"
 Form1.Refresh
 Exit Sub
End If
Form3.pw1.Text = ""
Form3.pw2.Text = ""
End Sub

Public Sub CREATE_SALES_BUTTON_Click()
Sales = Trim(SALES_i.Text)
Password = Trim(PASSWORD_i.Text)
If Trim(SALES_i.Text) = "" Or Trim(PASSWORD_i.Text) = "" Then
   NOTE.Caption = "错误:管理员登录失败，不能创建经办人账号。"
   Form1.Refresh
   Exit Sub
End If
If LCase(Trim(Sales)) = "admin" And Check_PW = True Then
 Form2.Show
Else
 NOTE.Caption = "错误:只有管理员(admin)才能创建经办人账号，管理员登录失败。"
 Form1.Refresh
 Exit Sub
End If
End Sub

Private Sub DELETE_SALES_BUTTON_Click()
Form4.Combo1.Text = ""
Sales = Trim(SALES_i.Text)
Password = Trim(PASSWORD_i.Text)
If Trim(SALES_i.Text) = "" Or Trim(PASSWORD_i.Text) = "" Then
   NOTE.Caption = "错误:管理员登录失败，不能删除经办人账号。"
   Form1.Refresh
   Exit Sub
End If
If LCase(Trim(Sales)) = "admin" And Check_PW = True Then
 Form4.Show
Else
 NOTE.Caption = "错误:只有管理员(admin)才能删除经办人账号，管理员登录失败。"
 Form1.Refresh
 Exit Sub
End If
End Sub

Private Sub END_BUTTON_Click()
Shell "Explorer.exe " & File_DIR, vbNormalFocus
End
End Sub

Private Sub Form_Initialize()
SYSTEM_INFO_NAME = "《开心情报站》自动排版系统 - LiMaker V2008"
Form1.Caption = SYSTEM_INFO_NAME
BEGIN_DAY_i = Date
NOTE.Caption = "请如实填写各项数据，否则不能正确生成证书。" & vbCrLf & "等待命令..."
Get_My_Documents_Path
DOC_PATH = MY_DOC_PATH & "\《开心情报站》使用许可证存档"
End Sub

Sub Create_Dir(dir As String)
Dim pointer As Integer
Dim crt_dir
Dim dir2 As String
dir2 = dir & "\"
pointer = 0
On Error Resume Next
Do
  pointer = InStr(pointer + 1, dir2, "\")
  crt_dir = Left(dir2, pointer - 1)
  MkDir crt_dir
Loop While pointer > 0
End Sub

Function Clen(str As String) As Integer
'计算字串的长度,以英文字母计算,一个汉字算作2个长度
Dim i, l As Integer
l = Len(str)
Clen = l
For i = 1 To l
If Mid(str, i, 1) > Chr(127) Then Clen = Clen + 1
Next i
End Function

Function Check_PW() As Boolean
On Error GoTo 111
Dim n, s, p, r, id, pw, nm As String
Dim b, e As Integer
Check_PW = False
If Sales = "" Or Password = "" Then Exit Function
nm = "no"

Open DOC_PATH & "\账号管理\sales.par" For Input As #1
Do While Not EOF(1)
 Input #1, temp
 temp = Trim(temp)
 b = InStr(temp, "-") + 1
 e = InStr(temp, ":")
 If Mid(temp, b, e - b) = Sales Then
  nm = Left(temp, InStr(temp, "-") - 1)
  Exit Do
 End If
111 Loop
Close #1

id = Sales
pw = Password
n = nm
s = n & id
p = pw
'不能用随机数，因为randomize num 只能执行一次，即只能播种一次，关闭程序在启动以后才起作用
For i = 1 To Len(s)
 r = r & CStr(Abs(CInt(Asc(Mid(s, i, 1)) / 2) + CInt(Asc(Right(id, 1)) * 67)))
Next i
For i = 1 To Len(p)
 r = r & CStr(Abs(CInt(Asc(Mid(p, i, 1)) / 3) + CInt(Asc(Right(id, 1)) * 211)))
Next i

Open DOC_PATH & "\账号管理\sales.par" For Input As #1
Do While Not EOF(1)
Input #1, temp
If temp = nm & "-" & id & ":" & r Then
 Check_PW = True
 Exit Do
End If
Loop
Close #1
End Function

Sub Cal_L_ID()
On Error Resume Next
 Dim l_id, CpuID, t_str, t_str2 As String
 Dim t0, t1, t2, t_num, t_num2, ad_file_len As Long
 Dim L_Str As Integer
 Dim sec1_20, sec21_30, sec31_40, sec41_50 As String '分别存CPU、用户名、颁发日期和有效期 信息
 Dim tempcode() As String
 tempcode = Split(Computer_Code, "-")
 ad_file_len = CLng(tempcode(1)) / 2
 CpuID = Replace(tempcode(0), ".", "")
  
 'CPU
 t1 = Asc(Mid(CpuID, 5, 1))
 t2 = Asc(Mid(CpuID, 11, 1))
 Randomize Int(t1 * t2)
 For i = 1 To 16
   t0 = Asc(Mid(CpuID, i, 1)) Mod 256
   t0 = (t0 + Int(Rnd * 255)) * Int(Rnd * 255)
   t0 = Abs(t0)
   t_str = t_str & CStr(t0)
 Next i
 t_str = Mid(t_str & "0000000000000000000000", 11, 20)
 sec1_20 = t_str
 
 '用户名与经办人一起处理
 user = user & Sales
 L_Str = Len(user)
 For i = 1 To L_Str - 1
  t_num = t_num + Asc(Mid(user, i, 1))
 Next i
 t_num = t_num * 31 + Int(64725694 * (Rnd + 1))
 t_num = Abs(t_num)    '此行不能和上一行合并写，因为如果上一行溢出就不执行Abs()而直接转下一行了，就可能出现负数
 t_str = CStr(Int(31578 * (Rnd + 1))) & CStr(t_num) & "7546718635768"
 t_str = Mid(t_str, 4, 10)
 sec21_30 = t_str

 '有效期
 t_str2 = FormatDateTime(begin_day, vbShortDate)
 L_Str = Len(t_str2)
 For i = 1 To L_Str - 1
  t_num = t_num + Asc(Mid(t_str2, i, 1)) * Abs(days - 179)
 Next i
 t_num = t_num * 17 + Int(65429532 * (Rnd + 1))
 t_num = Abs(t_num)
 t_str = CStr(Int(days * (Rnd + 1))) & CStr(t_num) & "5448246594489"
 t_str = Mid(t_str, 1, 10)
 sec31_40 = t_str
 
 Licence_ID = sec1_20 & sec21_30 & sec31_40
End Sub


