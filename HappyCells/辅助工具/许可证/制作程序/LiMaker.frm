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
   StartUpPosition =   2  '��Ļ����
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
      Caption         =   "��������"
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
      Caption         =   "�˳����鿴֤��"
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
      Text            =   "������ʱ��ɵĻ��"
      Top             =   680
      Width           =   2775
   End
   Begin VB.CommandButton BEGIN_BUTTON 
      Caption         =   "�������֤"
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
      Caption         =   "����:"
      Height          =   255
      Left            =   2160
      TabIndex        =   16
      Top             =   1845
      Width           =   1575
   End
   Begin VB.Label Label8 
      BackStyle       =   0  'Transparent
      Caption         =   "�����˴���:"
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   1840
      Width           =   1575
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "״̬:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   2160
      Width           =   495
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "��Ч��(��):"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1560
      Width           =   1575
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "��������:"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   1280
      Width           =   1575
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "��������:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   1000
      Width           =   1575
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "��֯����:"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   720
      Width           =   1575
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "  �������������������鱨վ�Զ��Ű�ϵͳʹ�����֤����ҵ���ܣ�������ۣ�"
      ForeColor       =   &H00FF0000&
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   120
      Width           =   3615
   End
   Begin VB.Label NOTE 
      BackStyle       =   0  'Transparent
      Caption         =   "����ʵ��д�������ݣ���������ȷ����֤�顣�ȴ�����..."
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

'����ҵ��ĵ�Ŀ¼************************************************************************************
Private Declare Function SHGetSpecialFolderLocation Lib "Shell32" (ByVal hwndOwner As Long, ByVal nFolder As Integer, ppidl As Long) As Long
Private Declare Function SHGetPathFromIDList Lib "Shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal szPath As String) As Long
Const MAX_LEN = 200 '�ַ�����󳤶�
Const MYDOCUMENTS = &H5& '�ҵ��ĵ�
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
'����ҵ��ĵ�Ŀ¼
   Dim sTmp As String * MAX_LEN  '��Ž���Ĺ̶����ȵ��ַ���
   Dim pidl As Long 'ĳ����Ŀ¼������Ŀ¼�б��е�λ��
    
   '����ҵ��ĵ�Ŀ¼
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
   NOTE.Caption = "����:�������ݶ�����ʡ�ԡ�"
   Form1.Refresh
   Exit Sub
End If

If LCase(Trim(SALES_i.Text)) = "admin" Then
   NOTE.Caption = "����:����Ա�˺�(admin)ֻ�ܴ����������˺ţ���������֤�顣"
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
 NOTE.Caption = "����:�����˴��벻���ڣ������벻ƥ�䣬���������롣"
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

File_DIR = DOC_PATH & "\�ͻ�\" & user & "\" & Computer_Code
Create_Dir (File_DIR)
File_NM = File_DIR & "\licence.txt"
Open File_NM For Output As #10
Print #10, "* �뽫���ļ����ڰ�ȫ�ĵط����棬��֤��������ʱ���ڻָ�"
Print #10, "* �뽫���ļ��������� ���ҵ��ĵ�\�������鱨վ���ĵ�\ʹ�����֤�� �ļ��У�����ԭ�ļ�"
Print #10, "* ����༭�޸Ļ��ƶ����ļ�������������֤������ϵͳ��������"
Print #10, ""
Print #10, ""
Print #10, "****************************************************************************"
Print #10, "*                                                                          *"
Print #10, "*                          �����鱨վ�Զ��Ű�ϵͳ                          *"
Print #10, "*                                ʹ�����֤                                *"
Print #10, "*                                                                          *"
Print #10, "* " & user & ":" & Space(72 - Clen((user))) & "*"
Print #10, "*     ���췽�������޹�˾��Ȩ�㹫˾(��ҵ����ˣ���ͬ)���йغ�ͬ�涨�ķ�Χ *"
Print #10, "* ��ʹ�ÿ����鱨վ�Զ��Ű�ϵͳ���丽��ϵͳ��                               *"
Print #10, "*     ��˾ʹ�ø�ϵͳ����ʾ��������Լ����                                 *"
Print #10, "*        1 ��ϵͳ����Ȩ���ڴ��췽�������޹�˾��                          *"
Print #10, "*        2 �����֤���޹�˾�ڱ�̨�������Լ����������ʹ�ã�              *"
Print #10, "*        3 ��˾���ý���ϵͳ����ʹ�����֤ת����ת�⡢ת�û�ת�ͣ�        *"
Print #10, "*        4 ��˾���ý��л�����������������֯���жԱ�ϵͳ���ƽ⡢���ģ�    *"
Print #10, "*        5 ��˾�����޸Ļ�����������������֯�޸ı����֤��                *"
Print #10, "*        6 ����˾���ڹ�˾��ʹ�����ð汾����ɵ���ʧ������              *"
Print #10, "*     ���˾�ϸ����ع涨�����������ʧ����˾�������Σ�ͬʱ����˾����׷ *"
Print #10, "* ����˾�������ε�Ȩ�����Լ�����һ�кϷ�Ȩ����                           *"
Print #10, "*     ��л��˾��ϵĺ�����                                               *"
Print #10, "*                                                                          *"
Print #10, "*                                        ���췽�������޹�˾              *"
Print #10, "*                                             " & CStr(Date) & Space(29 - Clen(CStr(Date))) & "*"
Print #10, "*                                                                          *"
Print #10, "****************************************************************************"
Print #10, ""
Print #10, "**���֤��Ϣ**"
Print #10, "# ��Ȩ��:���췽�������޹�˾"
Print #10, "# ����Ȩ��:" & user
Print #10, "# ��������:" & Computer_Code
Cal_L_ID
Print #10, "# ����:" & Licence_ID
Print #10, "# ��������:" & FormatDateTime(begin_day, vbShortDate)
Print #10, "# ��Ч��(��):" & days
Print #10, "# �����˴���:" & Sales
Print #10, ""
Print #10, ""
Print #10, "****************************************************************************"
Print #10, "*                                                                          *"
Print #10, "*                      �������ð�����֤���ڵ�����                        *"
Print #10, "*                                                                          *"
Print #10, "*  1 ���ð潫�ڹ���в��롶�����鱨վ����棬����ɾ�����޸ġ�              *"
Print #10, "*  2 ���ð汾�Ű湦��û�����ƣ������ṩ���Ϸ����������������            *"
Print #10, "*  3 ���֤���ڳ���һ���º󣬽���Ϊ���ð棬�������������֤��              *"
Print #10, "*    ����ǰ��������������                                                  *"
Print #10, "*                                                                          *"
Print #10, "****************************************************************************"
Close #10
NOTE.Caption = "������ϡ�֤��洢��:" & vbCrLf & File_NM

End Sub

Private Sub CHANGE_PW_BUTTON_Click()
Sales = Trim(SALES_i.Text)
Password = Trim(PASSWORD_i.Text)
If Check_PW = True Then
 Form3.Show
Else
 NOTE.Caption = "����:��¼ʧ�ܣ����ܸ������롣"
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
   NOTE.Caption = "����:����Ա��¼ʧ�ܣ����ܴ����������˺š�"
   Form1.Refresh
   Exit Sub
End If
If LCase(Trim(Sales)) = "admin" And Check_PW = True Then
 Form2.Show
Else
 NOTE.Caption = "����:ֻ�й���Ա(admin)���ܴ����������˺ţ�����Ա��¼ʧ�ܡ�"
 Form1.Refresh
 Exit Sub
End If
End Sub

Private Sub DELETE_SALES_BUTTON_Click()
Form4.Combo1.Text = ""
Sales = Trim(SALES_i.Text)
Password = Trim(PASSWORD_i.Text)
If Trim(SALES_i.Text) = "" Or Trim(PASSWORD_i.Text) = "" Then
   NOTE.Caption = "����:����Ա��¼ʧ�ܣ�����ɾ���������˺š�"
   Form1.Refresh
   Exit Sub
End If
If LCase(Trim(Sales)) = "admin" And Check_PW = True Then
 Form4.Show
Else
 NOTE.Caption = "����:ֻ�й���Ա(admin)����ɾ���������˺ţ�����Ա��¼ʧ�ܡ�"
 Form1.Refresh
 Exit Sub
End If
End Sub

Private Sub END_BUTTON_Click()
Shell "Explorer.exe " & File_DIR, vbNormalFocus
End
End Sub

Private Sub Form_Initialize()
SYSTEM_INFO_NAME = "�������鱨վ���Զ��Ű�ϵͳ - LiMaker V2008"
Form1.Caption = SYSTEM_INFO_NAME
BEGIN_DAY_i = Date
NOTE.Caption = "����ʵ��д�������ݣ���������ȷ����֤�顣" & vbCrLf & "�ȴ�����..."
Get_My_Documents_Path
DOC_PATH = MY_DOC_PATH & "\�������鱨վ��ʹ�����֤�浵"
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
'�����ִ��ĳ���,��Ӣ����ĸ����,һ����������2������
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

Open DOC_PATH & "\�˺Ź���\sales.par" For Input As #1
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
'���������������Ϊrandomize num ֻ��ִ��һ�Σ���ֻ�ܲ���һ�Σ��رճ����������Ժ��������
For i = 1 To Len(s)
 r = r & CStr(Abs(CInt(Asc(Mid(s, i, 1)) / 2) + CInt(Asc(Right(id, 1)) * 67)))
Next i
For i = 1 To Len(p)
 r = r & CStr(Abs(CInt(Asc(Mid(p, i, 1)) / 3) + CInt(Asc(Right(id, 1)) * 211)))
Next i

Open DOC_PATH & "\�˺Ź���\sales.par" For Input As #1
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
 Dim sec1_20, sec21_30, sec31_40, sec41_50 As String '�ֱ��CPU���û������䷢���ں���Ч�� ��Ϣ
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
 
 '�û����뾭����һ����
 user = user & Sales
 L_Str = Len(user)
 For i = 1 To L_Str - 1
  t_num = t_num + Asc(Mid(user, i, 1))
 Next i
 t_num = t_num * 31 + Int(64725694 * (Rnd + 1))
 t_num = Abs(t_num)    '���в��ܺ���һ�кϲ�д����Ϊ�����һ������Ͳ�ִ��Abs()��ֱ��ת��һ���ˣ��Ϳ��ܳ��ָ���
 t_str = CStr(Int(31578 * (Rnd + 1))) & CStr(t_num) & "7546718635768"
 t_str = Mid(t_str, 4, 10)
 sec21_30 = t_str

 '��Ч��
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


