VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "ieframe.dll"
Begin VB.Form Form1 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "�Ѻ��Ȳ�֩����"
   ClientHeight    =   8400
   ClientLeft      =   285
   ClientTop       =   3000
   ClientWidth     =   15015
   Icon            =   "SohuPrint2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8400
   ScaleWidth      =   15015
   StartUpPosition =   2  '��Ļ����
   Begin VB.TextBox TXT_GONGJI 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFFF&
      BeginProperty Font 
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   300
      Left            =   14160
      Locked          =   -1  'True
      TabIndex        =   46
      Text            =   "300"
      Top             =   495
      Width           =   615
   End
   Begin VB.CommandButton CMD_SKIP 
      Caption         =   "����"
      Height          =   375
      Left            =   14280
      TabIndex        =   44
      Top             =   60
      Width           =   525
   End
   Begin VB.CommandButton CMD_LIST2 
      Caption         =   "�鿴"
      Height          =   375
      Left            =   6960
      TabIndex        =   27
      Top             =   465
      Width           =   615
   End
   Begin VB.TextBox TXT_MY_MSGBOX 
      BackColor       =   &H00800000&
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   10320
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   41
      Top             =   7680
      Width           =   4335
   End
   Begin VB.TextBox TXT_TURNS 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
      Height          =   300
      Left            =   13245
      TabIndex        =   40
      Text            =   "3"
      Top             =   495
      Width           =   255
   End
   Begin VB.CommandButton CMD_HISTORY 
      Caption         =   "��ʷ"
      Height          =   375
      Left            =   9720
      TabIndex        =   37
      Top             =   60
      Width           =   615
   End
   Begin VB.CommandButton CMD_LIST 
      Caption         =   "�鿴"
      Height          =   375
      Left            =   3240
      TabIndex        =   19
      Top             =   465
      Width           =   615
   End
   Begin VB.CommandButton CMD_ADD 
      Caption         =   "���/����"
      Height          =   375
      Left            =   2280
      TabIndex        =   18
      Top             =   465
      Width           =   975
   End
   Begin VB.TextBox TXT_EXCEPT 
      BackColor       =   &H00E0E0E0&
      Height          =   375
      Left            =   480
      TabIndex        =   16
      Top             =   465
      Width           =   1815
   End
   Begin VB.TextBox TXT_LIST 
      BackColor       =   &H00E0E0E0&
      Height          =   5295
      Left            =   3960
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   20
      Top             =   3000
      Visible         =   0   'False
      Width           =   3975
   End
   Begin VB.CommandButton CMD_TO_0 
      Caption         =   "����"
      Height          =   375
      Left            =   9120
      TabIndex        =   36
      Top             =   60
      Width           =   615
   End
   Begin VB.CommandButton CMD_RUN_SHOW 
      Caption         =   "�鿴���н���"
      Height          =   375
      Left            =   4200
      TabIndex        =   32
      Top             =   60
      Width           =   1335
   End
   Begin VB.TextBox TXT_LIST2 
      BackColor       =   &H00C0FFC0&
      Height          =   5295
      Left            =   4320
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   31
      Top             =   3000
      Visible         =   0   'False
      Width           =   3975
   End
   Begin VB.TextBox TXT_USER 
      BackColor       =   &H00C0FFC0&
      Height          =   375
      Left            =   4440
      TabIndex        =   29
      Text            =   "��ʽ:�û���/����"
      Top             =   465
      Width           =   1575
   End
   Begin VB.CommandButton CMD_ADD2 
      Caption         =   "���/����"
      Height          =   375
      Left            =   6000
      TabIndex        =   28
      Top             =   465
      Width           =   975
   End
   Begin VB.TextBox TXT_MINS 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFC0&
      Height          =   300
      Left            =   10725
      TabIndex        =   26
      Text            =   "120"
      Top             =   495
      Width           =   375
   End
   Begin VB.TextBox TXT_TIMES 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Height          =   300
      Left            =   12120
      TabIndex        =   25
      Text            =   "300"
      Top             =   495
      Width           =   375
   End
   Begin VB.TextBox TXT_URL_SHOW 
      BackColor       =   &H00C0FFFF&
      Height          =   5295
      Left            =   3720
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   22
      Top             =   3000
      Visible         =   0   'False
      Width           =   4935
   End
   Begin VB.CommandButton CMD_URL_SHOW 
      Caption         =   "�鿴URL����"
      Height          =   375
      Left            =   3000
      TabIndex        =   21
      Top             =   60
      Width           =   1215
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   720
      Top             =   5880
   End
   Begin VB.TextBox TXT_STAY 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0FF&
      Height          =   300
      Left            =   8040
      TabIndex        =   14
      Text            =   "1"
      Top             =   495
      Width           =   255
   End
   Begin VB.CommandButton CMD_CONTINUE 
      Caption         =   "����"
      Height          =   375
      Left            =   13680
      TabIndex        =   13
      Top             =   60
      Width           =   525
   End
   Begin VB.CommandButton CMD_PAUSE 
      Caption         =   "��ͣ"
      Height          =   375
      Left            =   13080
      TabIndex        =   12
      Top             =   60
      Width           =   525
   End
   Begin VB.TextBox TXT_DELAY 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0080C0FF&
      Height          =   300
      Left            =   8880
      TabIndex        =   6
      Text            =   "5"
      Top             =   495
      Width           =   255
   End
   Begin VB.TextBox TXT_PAGE_NUM 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Height          =   300
      Left            =   9800
      TabIndex        =   5
      Text            =   "5"
      Top             =   495
      Width           =   255
   End
   Begin VB.TextBox TXT_BEGIN_URL 
      BackColor       =   &H00C0FFFF&
      BeginProperty Font 
         Name            =   "����"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   480
      Locked          =   -1  'True
      TabIndex        =   2
      Text            =   "http://blog.sohu.com/"
      Top             =   60
      Width           =   2535
   End
   Begin VB.CommandButton CMD_STOP 
      Caption         =   "�˳�"
      Height          =   375
      Left            =   12480
      TabIndex        =   1
      Top             =   60
      Width           =   525
   End
   Begin VB.CommandButton CMD_START 
      BackColor       =   &H000080FF&
      Caption         =   "��ʼ"
      Height          =   375
      Left            =   11880
      MaskColor       =   &H00FF0000&
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   525
   End
   Begin VB.TextBox TXT_RUN_SHOW 
      BackColor       =   &H00C0C0FF&
      Height          =   5295
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   33
      Top             =   3000
      Visible         =   0   'False
      Width           =   9135
   End
   Begin SHDocVwCtl.WebBrowser WebBrowser1 
      Height          =   7455
      Left            =   0
      TabIndex        =   43
      Top             =   960
      Width           =   15000
      ExtentX         =   26458
      ExtentY         =   13150
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "http:///"
   End
   Begin VB.CheckBox CHK_NOBODY 
      BackColor       =   &H00FFFFFF&
      Caption         =   "����ֵ��"
      ForeColor       =   &H00000000&
      Height          =   300
      Left            =   10560
      MaskColor       =   &H00FFFFFF&
      TabIndex        =   42
      Top             =   240
      Width           =   1095
   End
   Begin VB.CheckBox CHK_HISTORY 
      BackColor       =   &H00FFFFFF&
      Caption         =   "�ط���ʷ"
      Height          =   300
      Left            =   10560
      TabIndex        =   38
      Top             =   15
      Width           =   1095
   End
   Begin VB.Label Label13 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "����"
      Height          =   255
      Left            =   13800
      TabIndex        =   45
      Top             =   540
      Width           =   855
   End
   Begin VB.Label Label12 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "ѭ��    ��"
      Height          =   255
      Left            =   12840
      TabIndex        =   39
      Top             =   540
      Width           =   1215
   End
   Begin VB.Label Label7 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "�ų�"
      Height          =   375
      Left            =   45
      TabIndex        =   17
      Top             =   540
      Width           =   495
   End
   Begin VB.Label LBL_LEFT_TIME 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      ForeColor       =   &H00FF00FF&
      Height          =   255
      Left            =   6165
      TabIndex        =   35
      Top             =   165
      Width           =   615
   End
   Begin VB.Label Label11 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "��ʱ"
      Height          =   255
      Left            =   5760
      TabIndex        =   34
      Top             =   165
      Width           =   465
   End
   Begin VB.Label Label10 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "�û�"
      Height          =   375
      Left            =   4020
      TabIndex        =   30
      Top             =   540
      Width           =   615
   End
   Begin VB.Label Label9 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "ÿ�˺�    ��"
      Height          =   255
      Left            =   11580
      TabIndex        =   24
      Top             =   540
      Width           =   1695
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "��ʱ:    ����"
      Height          =   255
      Left            =   10320
      TabIndex        =   23
      Top             =   540
      Width           =   1455
   End
   Begin VB.Label Label6 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "פ��   ��"
      Height          =   255
      Left            =   7680
      TabIndex        =   15
      Top             =   540
      Width           =   975
   End
   Begin VB.Label Label5 
      BackColor       =   &H00FFFFFF&
      Caption         =   "����"
      Height          =   255
      Left            =   8040
      TabIndex        =   11
      Top             =   180
      Width           =   375
   End
   Begin VB.Label Label4 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "�ܼ�"
      Height          =   255
      Left            =   6960
      TabIndex        =   10
      Top             =   165
      Width           =   495
   End
   Begin VB.Label Label3 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "��ȡ   ��"
      Height          =   375
      Left            =   9435
      TabIndex        =   9
      Top             =   540
      Width           =   975
   End
   Begin VB.Label Label2 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "����   ��"
      Height          =   375
      Left            =   8520
      TabIndex        =   8
      Top             =   540
      Width           =   1215
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "����"
      Height          =   375
      Left            =   45
      TabIndex        =   7
      Top             =   165
      Width           =   375
   End
   Begin VB.Label LBL_THIS_TIME 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   8460
      TabIndex        =   4
      Top             =   165
      Width           =   375
   End
   Begin VB.Label LBL_TOTAL 
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "1000000"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   7380
      TabIndex        =   3
      Top             =   165
      Width           =   735
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Declare Function GetTickCount Lib "kernel32" () As Long '�����ʱ
Private Declare Function ShellExecute Lib "shell32.dll" Alias _
        "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, _
        ByVal lpFile As String, ByVal lpParameters As String, _
        ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
        Private Const SW_SHOW = 5


Private Declare Function SetCursorPos Lib "user32" (ByVal X As Long, ByVal Y As Long) As Long '�������������λ��!

Private Declare Sub mouse_event Lib "user32" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long) '��������¼�
Const MOUSEEVENTF_LEFTDOWN = &H2
Const MOUSEEVENTF_LEFTUP = &H4


Private Declare Function ClipCursor Lib "user32" (lpRect As Any) As Long
Private Type RECT
        Left As Long
        Top As Long
        Right As Long
        Bottom As Long
End Type '���ϴ������API����������и��Ƽ��ɡ�
Dim DENG As RECT

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Const SWP_NOMOVE = &H2
Const SWP_NOSIZE = &H1
Const flag = SWP_NOMOVE Or SWP_NOSIZE
Const HWND_TOPMOST = -1
Const HWND_NOTOPMOST = -2

'Private Declare Function SetProcessWorkingSetSize Lib "kernel32" (ByVal hProcess As Long, ByVal dwMinimumWorkingSetSize As Long, ByVal dwMaximumWorkingSetSize As Long) As Long
'Private Declare Function GetCurrentProcess Lib "kernel32" () As Long



Dim StrHtml, URL As String
Dim Links(), Except() As String
Dim User() As String
Dim TOTAL, THIS_TIME, THIS_USER, HISTORY_POINTER As Long
Dim DELAY, STAY, PAGE_NUM, MINS, TIMES, TURNS As Long
Dim HISTORY, NOBODY As Integer
Dim Pause As Boolean
Dim UN, PW, TUP As String
Dim KU, IU, JU As Integer
Dim Login, WHOLE_OVER, Logging As Boolean    'login�Ѿ���¼��ϣ�logging���ڵ�¼�У�Ϊ����webbrowser���ֽ���
Dim BEGIN_TIME, END_TIME As Long
Dim LINKS_POINTER, SAFE_LINE, NUM_OF_LINKS, USER_NUM As Integer
Dim CHECK_REPEAT_URL As String
Dim SON_AUTO_START As Integer









Private Sub CMD_START_Click()

On Error Resume Next


    Dim i, j As Integer
    
    Show_And_Log_Run_Info "CMD_START_Click:��ʼ"
    
    CMD_START.Enabled = False
   
    Init_Data
    
    If NOBODY <> 0 Then
        Show_And_Log_Run_Info "CMD_START_Click:����ֵ��"
    Else
        Show_And_Log_Run_Info "CMD_START_Click:����ֵ��"
    End If
    
    If HISTORY <> 0 Then
        Show_And_Log_Run_Info "CMD_START_Click:�ط���ʷ"
    Else
        Show_And_Log_Run_Info "CMD_START_Click:��������"
    End If
    
    'Wait_Here_If_Pause_Button
    Show_And_Log_Run_Info "********************* �û� " & CStr(IU + 1) & "/" & CStr(USER_NUM + 1) & " ************************"
    'WebBrowser1.Silent = True
    
    TXT_USER.Text = CStr(IU + 1) & "/" & CStr(USER_NUM + 1) & " " & User(IU)
    User_Login

    For JU = 1 To TIMES
    MyMsgBox " ��:" & CStr(KU) & "  �û�:" & CStr(IU + 1) & "  ��:" & CStr(JU)     '& "  " & CStr(Logging)
        Wait_Here_If_Pause_Button
        WebBrowser1.Silent = True
        
        Send_Message_To_Father -1  '֪ͨ�����̷���һ��URL��ʼ������ʱ�������̽��ݴ��ж���η����Ƿ�û����Ӧ����ͬʱ��¼TOTAL,THIS_TIME,THIS_USER
        
        If HISTORY = 0 Then
            Get_A_URL
            
            TXT_BEGIN_URL.Text = URL
            THIS_TIME = THIS_TIME + 1
            LBL_THIS_TIME.Caption = CStr(THIS_TIME)
            TOTAL = TOTAL + 1
            LBL_TOTAL.Caption = CStr(TOTAL)
            THIS_USER = JU
            Show_And_Log_Run_Info "CMD_START_Click:����: " & CStr(JU) & " " & URL
            
            
            If LINKS_POINTER > SAFE_LINE Then
                Only_Browse_URL
            Else
                Browse_And_Get_Html_Of_URL
                Catch_Links
            End If
        Else
            If Not EOF(83) Then
                Input #83, URL
                HISTORY_POINTER = HISTORY_POINTER + 1
            Else
                Close #83
                Open "history.txt" For Append As #83
                Input #83, URL
                HISTORY_POINTER = 1
            End If
            TXT_BEGIN_URL.Text = URL
            THIS_TIME = THIS_TIME + 1
            LBL_THIS_TIME.Caption = CStr(THIS_TIME)
            TOTAL = TOTAL + 1
            LBL_TOTAL.Caption = CStr(TOTAL)
            THIS_USER = JU
            Show_And_Log_Run_Info "CMD_START_Click:�ط���ʷ: " & CStr(JU) & " " & URL
            Only_Browse_URL
        End If
        
        If NOBODY <> 0 Then Keep_CPU_Run       '����ֵ��ʱ��Ϊ�˱���Ӳ���״̬��ģ��������룬���������
    Next JU
            
    Show_And_Log_Run_Info "CMD_START_Click:���ֱ��û��������:" & CStr(THIS_USER)
    Normal_Stop
End Sub


Private Sub Form_Load()
On Error Resume Next
    Form1.Show
    'SetProcessWorkingSetSize GetCurrentProcess(), -1, -1   '�����ڴ棬����ÿ����һ�������ڴ���ۼӣ����ͷ�
    'SetProcessWorkingSetSize GetCurrentProcess, 50000000, 50000000  '�����������
    WebBrowser1.Silent = True
    WebBrowser1.Navigate "http://blog.sohu.com"
    
    TOTAL = 0
    THIS_TIME = 0
    THIS_USER = 0
    
    Get_Paras_From_Commandline
    Open "loginfo.txt" For Append As #317
    Show_And_Log_Run_Info "Form_Load:���ؽ��̴������Ĳ���: ��:" & CStr(KU) & " �û�:" & CStr(IU + 1) & " �������������:" & CStr(THIS_TIME)
    
    Randomize   '��Ҫ�Ӳ������������ʱ��仯�������
    
    Logging = False
    CMD_CONTINUE.Enabled = False
    CMD_PAUSE.Enabled = False
    
    Get_Config
    Open "history.html" For Append As #7
    
    Show_And_Log_Run_Info "Form_Load:��ȡ���ò������"
    
    LBL_TOTAL.Caption = CStr(TOTAL)
    TXT_STAY.Text = CStr(STAY)
    TXT_DELAY.Text = CStr(DELAY)
    TXT_PAGE_NUM.Text = CStr(PAGE_NUM)
    TXT_MINS.Text = CStr(MINS)
    TXT_TIMES.Text = CStr(TIMES)
    TXT_TURNS.Text = CStr(TURNS)
    CHK_HISTORY.Value = HISTORY
    CHK_NOBODY.Value = NOBODY
    LBL_LEFT_TIME.Caption = TXT_MINS.Text & ":00"
    LBL_THIS_TIME.Caption = CStr(THIS_TIME)
    
    
    Read_Except_file_And_Set_Arry
    Read_User_file_And_Set_Arry
    TXT_GONGJI.Text = CStr(TURNS * (USER_NUM + 1) * TIMES)
    TXT_LIST.Visible = False
    TXT_LIST2.Visible = False
    TXT_URL_SHOW.Visible = False
    TXT_RUN_SHOW.Visible = False
     
    TXT_BEGIN_URL.Locked = True
    Login = False
    
    
    CMD_START.SetFocus
    Show_And_Log_Run_Info "Form_Load:����������"
    
    'If TIMES > 300 Then MsgBox " �Ѻ�����ÿ���˺�ÿ����300��(����)�������޸� [ÿ�˺Ŵ���] "
    If SON_AUTO_START = 1 Then CMD_START_Click
End Sub

Sub Init_Data()
    Dim t As String
    STAY = CLng(TXT_STAY.Text * 1000)
    DELAY = CLng(TXT_DELAY.Text * 1000)
    PAGE_NUM = CLng(TXT_PAGE_NUM.Text)
    MINS = CLng(TXT_MINS.Text)
    TIMES = CLng(TXT_TIMES.Text)
    TURNS = CLng(TXT_TURNS.Text)
    HISTORY = CInt(CHK_HISTORY.Value)
    NOBODY = CInt(CHK_NOBODY.Value)
    LBL_LEFT_TIME.Caption = MINS
    

    SAFE_LINE = Int(PAGE_NUM / 6)
    If SAFE_LINE < 3 Then SAFE_LINE = 3
    NUM_OF_LINKS = Int(PAGE_NUM + SAFE_LINE + 10)
    ReDim Links(NUM_OF_LINKS)
    Links(0) = "http://blog.sohu.com"
    Open "nexturl.txt" For Input As #51
    Input #51, t
    Close #51
    t = Trim(t)
    If t <> "" Then Links(0) = t

    LINKS_POINTER = 1    '��Ӽ�links����ʼλ�ã���λ�õ��Ѿ��ǲ����õ�URL
    
    CHECK_REPEAT_URL = " "
    Disable_Paras
    Pause = False
    Timer1.Enabled = True
    CMD_PAUSE.Enabled = True

    Read_Except_file_And_Set_Arry
    Read_User_file_And_Set_Arry
    
    'BEGIN_TIME = GetTickCount()
    END_TIME = BEGIN_TIME + MINS * 60 * 1000
    
    If HISTORY <> 0 Then
        Open "history.txt" For Input As #83
        '����ʷ��¼ָ�����ú�
        Dim ih As Long
        Dim th As String
        For ih = 1 To HISTORY_POINTER - 1
            If EOF(83) Then
                Close #83
                Open "history.txt" For Input As #83
                HISTORY_POINTER = 1
                Exit For
            Else
                Input #83, th
            End If
        Next ih
    Else
        Open "history.txt" For Append As #83
    End If
    
    Show_And_Log_Run_Info "Init_Data:��ʼ�����"
    Show_And_Log_Run_Info "Init_Data:�ƻ�:" & CStr(TURNS) & "��," & CStr(USER_NUM + 1) & "�û�,ÿ�û�" & CStr(TIMES) & "��[�ܼ�" & CStr(TURNS * (USER_NUM + 1) * TIMES) & "��]"
    Show_And_Log_Run_Info "Init_Data:��ʱ" & CStr(MINS) & "����"

End Sub

Sub Init_Data_4_Continue()

    STAY = CLng(TXT_STAY.Text * 1000)
    DELAY = CLng(TXT_DELAY.Text * 1000)
    PAGE_NUM = CLng(TXT_PAGE_NUM.Text)
    MINS = CLng(TXT_MINS.Text)
    TIMES = CLng(TXT_TIMES.Text)
    TURNS = CLng(TXT_TURNS.Text)
    HISTORY = CInt(CHK_HISTORY.Value)
    NOBODY = CInt(CHK_NOBODY.Value)

    'LBL_LEFT_TIME.Caption = MINS
    

    SAFE_LINE = Int(PAGE_NUM / 6)
    If SAFE_LINE < 3 Then SAFE_LINE = 3
    If NUM_OF_LINKS < PAGE_NUM + SAFE_LINE + 10 Then
        NUM_OF_LINKS = Int(PAGE_NUM + SAFE_LINE + 10)
        ReDim Links(NUM_OF_LINKS)
    End If
    Disable_Paras
    Pause = False
    Timer1.Enabled = True
    Read_Except_file_And_Set_Arry
    Read_User_file_And_Set_Arry

    If HISTORY <> 0 Then
        Close #83
        Open "history.txt" For Input As #83
    End If

    Show_And_Log_Run_Info "Init_Data_4_Continue:��;��ʼ�����"
    Show_And_Log_Run_Info "Init_Data_4_Continue:�޸ļƻ�:" & CStr(TURNS) & "��," & CStr(USER_NUM + 1) & "�û�,ÿ�û�" & CStr(TIMES) & "��[�ܼ�" & CStr(TURNS * (USER_NUM + 1) * TIMES) & "��]"
    Show_And_Log_Run_Info "Init_Data_4_Continue:�޸Ķ�ʱ" & CStr(MINS) & "����"

End Sub

Sub Get_Paras_From_Commandline()
    Dim t, t2() As String
    t = Trim(Command())
't = "1 0 0 0 1000000000 0"     '����ʱ���������в����������ܵ���
    If t = "" Then
        MsgBox "�˳����ܶ������У������� SohuPrint.exe  "
        End
    End If
    t2 = Split(t, " ")
    
    KU = CInt(t2(0))    '�ڼ���
    IU = CInt(t2(1))    '�ڼ����û�
    THIS_TIME = CLng(t2(2))  '�����ѷ��ʴ���
    THIS_USER = CLng(t2(3))  '���û��ѷ��ʴ���
    BEGIN_TIME = CLng(t2(4)) '����ʼʱ�̵�ϵͳ������
    SON_AUTO_START = CInt(t2(5))  '�������Ƿ��Զ����������谴 ��ʼ ����
End Sub

Sub Enable_Paras()
    TXT_STAY.Enabled = True
    TXT_DELAY.Enabled = True
    TXT_PAGE_NUM.Enabled = True
    TXT_MINS.Enabled = True
    TXT_TIMES.Enabled = True
    TXT_TURNS.Enabled = True
    CHK_HISTORY.Enabled = True
    CHK_NOBODY.Enabled = True
    CMD_ADD.Enabled = True
    CMD_ADD2.Enabled = True
    CMD_TO_0.Enabled = True
End Sub

Sub Disable_Paras()
    TXT_STAY.Enabled = False
    TXT_DELAY.Enabled = False
    TXT_PAGE_NUM.Enabled = False
    TXT_MINS.Enabled = False
    TXT_TIMES.Enabled = False
    TXT_TURNS.Enabled = False
    CHK_HISTORY.Enabled = False
    CHK_NOBODY.Enabled = False
    CMD_ADD.Enabled = False
    CMD_ADD2.Enabled = False
    CMD_TO_0.Enabled = False
End Sub

Sub Get_A_URL()   '����URLֵ�����ƶ�Links��
    Dim i As Integer
    URL = Links(0)
    If LINKS_POINTER <= 0 Then
        LINKS_POINTER = 0
        URL = "http://blog.sohu.com"
        Exit Sub
    End If
    
    LINKS_POINTER = LINKS_POINTER - 1
    For i = 0 To LINKS_POINTER - 1
        Links(i) = Links(i + 1)
    Next i
    
    Open "nexturl.txt" For Output As #53
    Print #53, Links(0)
    Close #53

    Show_And_Log_Run_Info "Get_A_URL:�õ�URL:" & URL
End Sub


Sub Catch_Links()

On Error Resume Next

    Dim i, j, k As Integer
    Dim L, p, Q, R As Long
    Dim CUT_TEMP, cut_temp2  As String
    Dim MIN_L As Integer
    Dim T1, t2 As Long
    
    If LINKS_POINTER > SAFE_LINE Then Exit Sub
    
    Wait_Here_If_Pause_Button
    
    Show_And_Log_Run_Info "Catch_Links:��ʼ����Ŀ�격��"
    MIN_L = 6    '���͵�ַ��̫�̿������Ѻ��Ĺ�����ַ��ָ.blogǰ��
    CUT_TEMP = ""
    StrHtml = LCase(StrHtml)
    Show_And_Log_Run_Info "Catch_Links:HTML:" & Left(StrHtml, 10)
    L = Len(StrHtml)
        
    '�Ѱ���http://���ִ�ȫȡ��������С�����ִ��ĳ���
    i = 1
    j = 0
    Do While i < L
        p = InStr(i, StrHtml, "http://")
        If p = 0 Then Exit Do
        CUT_TEMP = CUT_TEMP & Mid(StrHtml, p, 40) & vbCrLf
        i = p + 8
        j = j + 1
        Wait_Here_If_Pause_Button
    Loop
    Set StrHtml = Nothing
    Show_And_Log_Run_Info "Catch_Links:���� http://  " & CStr(j) & "��"
    Show_And_Log_Run_Info "Catch_Links:CUT_TEMP=" & Left(CUT_TEMP, 10)
    
    '�Ѹշ��ʹ���URLȥ��������ظ����������ѭ��
    CUT_TEMP = Replace(CUT_TEMP, URL, "")
    
    'ȥ���ų��Ĳ��͵�ַ����ΪĳЩ��ַ���Ѻ��Լ��õ�
    For i = 0 To UBound(Except) - 1
        CUT_TEMP = Replace(CUT_TEMP, Except(i), "")
        Wait_Here_If_Pause_Button
    Next i
    Show_And_Log_Run_Info "Catch_Links:�ų�URL " & CStr(i + 1) & "��"
    
    j = 0
    T1 = GetTickCount()
    t2 = T1
    Do While InStr(CUT_TEMP, ".blog.sohu.com") > 0 And j <= PAGE_NUM And LINKS_POINTER < NUM_OF_LINKS - 1
        Wait_Here_If_Pause_Button
        t2 = GetTickCount()
        If t2 - T1 > 3000 Then Exit Do
        L = Len(CUT_TEMP)
        Q = 0
        Do While Q = 0
            p = Int(Rnd() * L) + 1
            Q = InStr(p, CUT_TEMP, ".blog.sohu.com")
        Loop
        
        R = 0
        For i = Q To 1 Step -1
            If Mid(CUT_TEMP, i, 7) = "http://" Then
                R = i
                Exit For
            End If
        Next
        
        If Not (R <= 0 Or (Q - R - 7) < MIN_L) Then
            cut_temp2 = Mid(CUT_TEMP, R, Q - R + 1 + 13)
            CUT_TEMP = Replace(CUT_TEMP, cut_temp2, "")
            If Trim(cut_temp2) <> "" And Check_Repeat(cut_temp2) = 0 Then
                j = j + 1
                Links(LINKS_POINTER) = cut_temp2
                LINKS_POINTER = LINKS_POINTER + 1
                Show_And_Log_Run_Info "Catch_Links:��ȡURL:" & cut_temp2
                Show_And_Log_Run_Info "Catch_Links:Links_Pointer=" & CStr(LINKS_POINTER)
            End If
        End If
        
    Loop
    Show_And_Log_Run_Info "Catch_Links:�������Ŀ�격��"
End Sub

Function Check_Repeat(a_url0 As String) As Integer   '����0��ʾ���ظ�
    Dim a_url As String
    a_url = a_url0
    a_url = Replace(a_url, "http://", "")
    a_url = Replace(a_url, ".blog.sohu.com", "")
    CHECK_REPEAT_URL = Right(CHECK_REPEAT_URL, 60000)
    If InStr(CHECK_REPEAT_URL, " " & a_url & " ") = 0 Then
        CHECK_REPEAT_URL = CHECK_REPEAT_URL & a_url & " "
        Check_Repeat = 0
    Else
        Check_Repeat = 1
    End If
End Function


Sub Browse_And_Get_Html_Of_URL()
On Error Resume Next
    Dim Doc, ObjHtml As Object
    Dim T1, t2 As Long
    Dim strT As String
    Dim Try_Times As Integer
    
    Show_And_Log_Run_Info "Browse_And_Get~:��ʼ���ؽڵ�ҳ"
    Try_Times = 0
    
    WHOLE_OVER = False
    StrHtml = ""
    Do While Len(StrHtml) < 10000 And Try_Times < 3
        WebBrowser1.Silent = True
        WebBrowser1.Navigate URL
            T1 = GetTickCount()
            t2 = T1
        While t2 - T1 < DELAY
'        While WHOLE_OVER = False And T2 - T1 < DELAY    '�ж�ʱ������ã������ж��ĵ����ؽ���

           t2 = GetTickCount()
            DoEvents
        Wend
        Try_Times = Try_Times + 1
        
        'If Not WebBrowser1.Busy Then   '��������жϣ�����StrHtml����ץ������
            Set Doc = WebBrowser1.Document
            Set ObjHtml = Doc.body.createtextrange()
            If Not IsNull(ObjHtml) Then
                StrHtml = ObjHtml.htmltext '����õ�HTML
            End If
            Set Doc = Nothing
            Set ObjHtml = Nothing
        'End If
    Loop
    Show_And_Log_Run_Info "Browse_And_Get~:���Դ���:" & Try_Times
    Show_And_Log_Run_Info "Browse_And_Get~:�ڵ�HTML����:" & Len(StrHtml)
    strT = "<A href='" & URL & "'>" & URL & "</A>"
    Print #7, TOTAL, strT, Now, "*" & "<br>"
    If HISTORY = 0 And LCase(URL) <> "http://blog.sohu.com" Then Print #83, URL
    Show_And_Log_Run_Info "Browse_And_Get~:д��ʷ��¼"
    Show_And_Log_Run_Info "Browse_And_Get~:��ɽڵ�ҳ����"
End Sub


Sub Only_Browse_URL()
On Error Resume Next
    Dim T1, t2 As Long
    Dim strT As String
    Show_And_Log_Run_Info "Only_Browse_URL:���" & URL
    WebBrowser1.Silent = True
        T1 = GetTickCount()
        t2 = GetTickCount()
    WebBrowser1.Navigate URL, 2

    While t2 - T1 < STAY  '�ȴ���ҳ�������
        t2 = GetTickCount()
        DoEvents
    Wend
' WebBrowser1.Stop   'ǿ��
'MsgBox CStr(T2 - T1) & " " & CStr(STAY)

    If LCase(URL) <> "http://blog.sohu.com" Then
        strT = "<A href='" & URL & "'>" & URL & "</A>"
        Print #7, TOTAL, strT, Now & "<br>"
        If HISTORY = 0 And LCase(URL) <> "http://blog.sohu.com" Then Print #83, URL
        Show_And_Log_Run_Info "Only_Browse_URL:д��ʷ��¼"
    End If
End Sub



Sub Save_And_See_Html(See As Integer)   'See=1 ʱ��html
    Show_And_Log_Run_Info "Save_And_See_Html:��HTML"
    Open "temphtml.txt" For Output As #111
    Print #111, StrHtml
    Close #111
    If See = 1 Then ShellExecute Me.hwnd, "Open", App.Path & "\temphtml.txt", vbNullString, vbNullString, SW_SHOW
End Sub

Sub Read_Temp_Html()
    Show_And_Log_Run_Info "Read_Temp_Html:����ʱHTML"
    Dim filenum  As Integer
    Dim fileContents  As String
    filenum = FreeFile
    Open "temphtml.txt" For Binary As #filenum
            fileContents = Space(LOF(filenum))
            Get #filenum, , fileContents
    Close #filenum
    StrHtml = fileContents
End Sub

Sub Read_Except_file_And_Set_Arry()
    Dim filenum  As Integer
    Dim fileContents  As String
    Dim ttt As String
    Show_And_Log_Run_Info "Read_Except~:��ȡ�ų��Ĳ���"
    filenum = FreeFile
    Open "except.txt" For Binary As #filenum
            fileContents = Space(LOF(filenum))
            Get #filenum, , fileContents
    Close #filenum
    fileContents = CUT_vbCrLf_and_Space(fileContents)   'user.txt �ļ���Ĳ���д��TXT_LIST���棬����ͱ�����except.txt
    TXT_LIST.Text = fileContents
    
    Open "user.txt" For Input As #123
    Do While Not EOF(123)
      Input #123, ttt
      ttt = Left(ttt, InStr(ttt, "/") - 1)
      fileContents = fileContents & vbCrLf & "http://" & ttt & ".blog.sohu.com"
    Loop
    Close #123
    
    fileContents = CUT_vbCrLf_and_Space(fileContents)
    Except = Split(fileContents, vbCrLf)
    'MsgBox TXT_LIST.Text
End Sub
Sub Read_User_file_And_Set_Arry()
    Dim filenum  As Integer
    Dim fileContents As String
    Dim P0, Pb, Le As Integer
    Show_And_Log_Run_Info "Read_User~:��ȡ�û��˺�����"
    filenum = FreeFile
    Open "user.txt" For Binary As #filenum
            fileContents = Space(LOF(filenum))
            Get #filenum, , fileContents
    Close #filenum
    fileContents = CUT_vbCrLf_and_Space(fileContents)
    TXT_LIST2.Text = fileContents
    User = Split(fileContents, vbCrLf)
    USER_NUM = UBound(User)

End Sub



Private Sub CMD_ADD_Click()
    TXT_EXCEPT.Text = Trim(TXT_EXCEPT.Text)
    Show_And_Log_Run_Info "CMD_ADD_Click:�����ų�����:" & TXT_EXCEPT.Text
    'If TXT_EXCEPT.Text <> "" Then
        TXT_LIST.Text = TXT_LIST.Text & vbCrLf & TXT_EXCEPT.Text
        TXT_LIST.Text = CUT_vbCrLf_and_Space(TXT_LIST.Text)
        Open "except.txt" For Output As #89
        Print #89, TXT_LIST.Text
        Close #89
        Read_Except_file_And_Set_Arry
    'End If
End Sub
Private Sub CMD_ADD2_Click()
    TXT_USER.Text = Trim(TXT_USER.Text)
    Show_And_Log_Run_Info "CMD_ADD_Click:�����û�:" & TXT_USER.Text
    If TXT_USER.Text <> "��ʽ:�û���/����" And TXT_USER.Text <> "" Then
        TXT_LIST2.Text = TXT_LIST2.Text & vbCrLf & TXT_USER.Text
    End If
        TXT_LIST2.Text = CUT_vbCrLf_and_Space(TXT_LIST2.Text)
        Open "user.txt" For Output As #77
        Print #77, TXT_LIST2.Text
        Close #77
        Read_User_file_And_Set_Arry
End Sub

Function CUT_vbCrLf_and_Space(str As String) As String
    Dim t As String
    Dim i, s, e, L As Long
    'Show_And_Log_Run_Info "CUT_vbCrLf_and_Space:ȥ������س���"
    t = str
    t = Replace(t, " ", "")
    t = Trim(t)
    L = Len(t)
    i = 1
    Do While i < L - 1 And Mid(t, i, 2) = vbCrLf '�س�����Ϊ2
        i = i + 2
    Loop
    s = i
    i = L
    Do While i > 2 And Mid(t, i, 2) = vbCrLf
        i = i - 2
    Loop
    e = i
    t = Mid(t, s, e - s + 1)
    Do While InStr(t, vbCrLf & vbCrLf) > 0
        t = Replace(t, vbCrLf & vbCrLf, vbCrLf)
    Loop
    If Right(t, 2) = vbCrLf Then t = Left(t, Len(t) - 2)
    CUT_vbCrLf_and_Space = t
End Function


Private Sub CMD_LIST_Click()
    Show_And_Log_Run_Info "CMD_LIST_Click:�鿴/�����ų��Ĳ���:" & CStr(TXT_LIST.Visible)
    TXT_LIST.Visible = Not TXT_LIST.Visible
    If TXT_LIST.Visible = False Then
        CMD_LIST.Caption = "�鿴"
    Else
         CMD_LIST.Caption = "����"
    End If

End Sub
Private Sub CMD_LIST2_Click()
    Show_And_Log_Run_Info "CMD_LIST2_Click:�鿴/�����û��б�:" & CStr(TXT_LIST2.Visible)
    TXT_LIST2.Visible = Not TXT_LIST2.Visible
    If TXT_LIST2.Visible = False Then
        CMD_LIST2.Caption = "�鿴"
    Else
         CMD_LIST2.Caption = "����"
    End If

End Sub


Private Sub Form_Unload(Cancel As Integer)
    'Normal_Stop
    CMD_STOP_Click
End Sub

Private Sub Timer1_Timer()
'ˢ��URL�б�
    Dim i As Integer
    If TXT_URL_SHOW.Visible = True Then
        TXT_URL_SHOW.Text = ""
        For i = 0 To UBound(Links) - 1
            If i + 1 = LINKS_POINTER Then
                TXT_URL_SHOW.Text = TXT_URL_SHOW.Text & " ->"
            Else
                TXT_URL_SHOW.Text = TXT_URL_SHOW.Text & "   "
            End If
            If i + 1 = SAFE_LINE Then
                TXT_URL_SHOW.Text = TXT_URL_SHOW.Text & "*"
            Else
                TXT_URL_SHOW.Text = TXT_URL_SHOW.Text & " "
            End If

            TXT_URL_SHOW.Text = TXT_URL_SHOW.Text & i + 1 & " " & Links(i) & vbCrLf
        Next i
    End If
'�������ʱ��
    Dim t, T_Last, T_Left, TT, m, s, temp As Long
    Dim ltt1, ltt2 As String
    
    t = GetTickCount()
    If t > END_TIME Then
        Show_And_Log_Run_Info "Timer1_Timer:��ʱ����"
        CMD_STOP_Click
    End If
    T_Last = t - BEGIN_TIME
    TT = MINS * 60 * 1000
    T_Left = TT - T_Last
    temp = Fix(T_Left / 1000)
    m = Fix(temp / 60)
    s = temp Mod 60
    If s >= 60 Then s = 0
    ltt1 = CStr(m)
    ltt2 = CStr(s)
    If s < 10 Then ltt2 = "0" & CStr(s)
    LBL_LEFT_TIME.Caption = ltt1 & ":" & ltt2
    
    
End Sub

 

Private Sub TXT_EXCEPT_DblClick()
        TXT_EXCEPT.Text = Clipboard.GetText
End Sub



Private Sub TXT_TIMES_Change()
    TIMES = CInt(TXT_TIMES.Text)
    TXT_GONGJI.Text = CStr(TURNS * (USER_NUM + 1) * TIMES)
    If TIMES > 300 Then MsgBox " �Ѻ�����ÿ���˺�ÿ����300��(����)�������޸� [ÿ�˺Ŵ���] "
    TXT_TIMES.SetFocus
End Sub

Private Sub TXT_TURNS_Change()
    TURNS = CInt(TXT_TURNS.Text)
    TXT_GONGJI.Text = CStr(TURNS * (USER_NUM + 1) * TIMES)
End Sub

Private Sub TXT_USER_DblClick()
        TXT_USER.Text = Clipboard.GetText
End Sub


Sub Keep_Top()         '�����ö���ֱ�����Ϊֹ
    Show_And_Log_Run_Info "Keep_Top:�����ö�"
    Form1.SetFocus
    SetWindowPos Form1.hwnd, HWND_TOPMOST, 0, 0, 0, 0, flag
    Form1.Show
End Sub

Sub Cancel_Keep_Top()  'ȡ���ö�
    Show_And_Log_Run_Info "Cancel_Keep_Top:ȡ�������ö�"
    SetWindowPos Form1.hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, flag
End Sub

Sub Wait_For_Response(ByVal ms As Long)   '����
    Dim mm As Integer
    Dim T1, t2 As Long
    T1 = GetTickCount()
    t2 = T1
    If ms < 0 Then ms = 0
    While t2 - T1 <= ms
            t2 = GetTickCount()
            DoEvents
    Wend
End Sub




Sub Lock_Mouse(ByVal xd As Long, ByVal yd As Long)    'ֻ�ǲ����ƶ��������Ե��
    Show_And_Log_Run_Info "Lock_Mouse:�������"
    SetCursorPos xd, yd
    DENG.Left = xd
    DENG.Top = yd
    DENG.Right = xd
    DENG.Bottom = yd
    ClipCursor DENG
End Sub

Sub Release_Mouse()
    Show_And_Log_Run_Info "Release_Mouse:ȡ���������"
    ClipCursor ByVal 0&
End Sub




Sub User_Login()
        '��¼�˺�
        Dim X, Y As Long
        Show_And_Log_Run_Info "User_Login:��ʼ��¼�˺�"
        Keep_Top      '�ö�
        Logging = True
        WebBrowser1.SetFocus

        Wait_For_Response 4000
        TUP = Trim(User(IU))
        UN = Left(TUP, InStr(TUP, "/") - 1)
        PW = Replace(TUP, UN & "/", "")
        Show_And_Log_Run_Info "User_Login:UN:" & UN & " " & "PW:" & PW
        
        X = CLng(Form1.Left + Form1.Width * 0.82)
        X = CLng(X / Screen.TwipsPerPixelX)
        Y = CLng(Form1.Top + Form1.Height * 0.62)
        Y = CLng(Y / Screen.TwipsPerPixelY)
        
        Lock_Mouse X, Y
        mouse_event MOUSEEVENTF_LEFTDOWN Or MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 'ģ�������������!
        Lock_Mouse Form1.Left / Screen.TwipsPerPixelX + 300, Form1.Top / Screen.TwipsPerPixelY + 10
        Wait_For_Response 1000  '����   ���б�����  sleep����
        
        SendKeys UN & "@sohu.com{ENTER}", True     ' �û���
        Wait_For_Response 500
        SendKeys PW & "{ENTER}", True
        'Sleep 1000
        Wait_For_Response 1000  '����'
        Release_Mouse
        Cancel_Keep_Top
        Logging = False
        Wait_For_Response 3000  '����'
        
        Login = True
        Show_And_Log_Run_Info "User_Login:��ɵ�¼�˺�"
End Sub




Private Sub WebBrowser1_DocumentComplete(ByVal pDisp As Object, URL As Variant)
    WHOLE_OVER = True
End Sub

Private Sub CMD_TO_0_Click()
    LBL_TOTAL.Caption = 0
    LBL_THIS_TIME.Caption = 0
    Close #7
    Open "history.html" For Output As #7
    Print #7, ""
    Close #7
    Open "history.html" For Append As #7
    
    Close #317
    Open "loginfo.txt" For Output As #317
    Print #317, ""
    Close #317
    Open "loginfo.txt" For Append As #317
    
    Save_Config
    TOTAL = 0
    THIS_TIME = 0
    
End Sub

Private Sub CMD_URL_SHOW_Click()
    Show_And_Log_Run_Info "CMD_URL_SHOW_Click:�鿴/����URL����:" & CStr(TXT_URL_SHOW.Visible)
    TXT_URL_SHOW.Visible = Not TXT_URL_SHOW.Visible
    If TXT_URL_SHOW.Visible = False Then
        CMD_URL_SHOW.Caption = "�鿴URL����"
    Else
         CMD_URL_SHOW.Caption = "����URL����"
    End If

End Sub

Private Sub CMD_RUN_SHOW_Click()
    Show_And_Log_Run_Info "CMD_RUN_SHOW_Click:�鿴/�������н���:" & CStr(TXT_RUN_SHOW.Visible)
    TXT_RUN_SHOW.Visible = Not TXT_RUN_SHOW.Visible
    If TXT_RUN_SHOW.Visible = False Then
        CMD_RUN_SHOW.Caption = "�鿴���н���"
    Else
         CMD_RUN_SHOW.Caption = "�������н���"
    End If
    
End Sub

Sub Show_And_Log_Run_Info(Info As String)
    Dim ttt, ttt2 As String
    Dim p As Integer
    ttt = CStr(Time) & ">" & Info
    If Len(TXT_RUN_SHOW.Text) > 60000 Then
        ttt2 = Right(TXT_RUN_SHOW.Text, 60000)
        p = InStr(ttt2, vbCrLf)
        TXT_RUN_SHOW.Text = Right(ttt2, 60000 - (p + 1))
    End If
    TXT_RUN_SHOW.Text = TXT_RUN_SHOW.Text & ttt & vbCrLf
    TXT_RUN_SHOW.SelStart = Len(TXT_RUN_SHOW.Text) + 1
    'TXT_RUN_SHOW.SetFocus
    Print #317, ttt
End Sub


Private Sub CMD_STOP_Click()
    Show_And_Log_Run_Info "CMD_STOP_Click:�˳�"
    Show_And_Log_Run_Info "CMD_STOP_Click:��չ: Ԥ��" & CStr(TURNS * (USER_NUM + 1) * TIMES) & "��  ���" & CStr(THIS_TIME) & "  ��ʷ�ܼ�" & CStr(TOTAL)

    'Print #7, "<a name='TheEnd'></a>"
    Close #7
    Close #83
    Close #317
    Save_Config
    Send_Message_To_Father 2   '���߸�����ҲҪ����
 End
End Sub

Private Sub CMD_SKIP_Click()
    Normal_Stop
End Sub

Private Sub Normal_Stop()
    Show_And_Log_Run_Info "CMD_STOP_Click:�˳�"
    Show_And_Log_Run_Info "CMD_STOP_Click:��չ: Ԥ��" & CStr(TURNS * (USER_NUM + 1) * TIMES) & "��  ���" & CStr(THIS_TIME) & "  ��ʷ�ܼ�" & CStr(TOTAL)

    'Print #7, "<a name='TheEnd'></a>"
    Close #7
    Close #83
    Close #317
    Save_Config
    Send_Message_To_Father 1   '���߸����� �� Ҫ����
 End
End Sub

Private Sub CMD_PAUSE_Click()
    Show_And_Log_Run_Info "CMD_PAUSE_Click:��ͣ"
    Enable_Paras
    CMD_PAUSE.Enabled = False
    CMD_CONTINUE.Enabled = True
    Pause = True
    Timer1.Enabled = False
    Send_Message_To_Father 0
End Sub


Private Sub CMD_CONTINUE_Click()
    Show_And_Log_Run_Info "CMD_CONTINUE_Click:����"
    CMD_CONTINUE.Enabled = False
    CMD_PAUSE.Enabled = True
    Init_Data_4_Continue
End Sub

Sub Send_Message_To_Father(Signal As Integer)
    '�������̷���Ϣ
    '��ʼ����һ��URLʱ��Signal=-1
    '����ʱ����Signal= 0�����ӽ�������������1�����ӽ��̽�����2���ڱ��ӽ����а��� �˳� ��
    Dim TIME_STAMP As Long
    TIME_STAMP = GetTickCount()
    Open App.Path & "\message.txt" For Output As #152
    Print #152, Signal, TOTAL, THIS_TIME, THIS_USER, TIME_STAMP, HISTORY_POINTER
    Close #152
End Sub

Sub Save_Config()
    Open "config.txt" For Output As #1
    Print #1, TXT_STAY.Text, TXT_DELAY.Text, TXT_PAGE_NUM.Text, TXT_MINS.Text, TXT_TIMES.Text, TXT_TURNS.Text, CHK_HISTORY.Value, CHK_NOBODY.Value
    Close #1

End Sub


Sub Get_Config()
    Dim Sig, this_t, this_u, time_st As Long
    Dim i As Integer
    i = 0
    Open App.Path & "\config.txt" For Input As #1
    Input #1, STAY, DELAY, PAGE_NUM, MINS, TIMES, TURNS, HISTORY, NOBODY
    Close #1
    'TOTAL,ֻҪTotal�� HISTORY_POINTER
    Open App.Path & "\message.txt" For Input As #15
        Do While i = 0 And Not EOF(15)
            Input #15, Sig, TOTAL, this_t, this_u, time_st, HISTORY_POINTER
            i = i + 1
        Loop
    Close #15
End Sub


Sub Wait_Here_If_Pause_Button()
    Do While Pause = True    '��ͣʱ
      DoEvents
    Loop
    DoEvents
End Sub



Private Sub WebBrowser1_LostFocus()
    If Logging = True Then WebBrowser1.SetFocus
End Sub

Private Sub WebBrowser1_NavigateError(ByVal pDisp As Object, URL As Variant, Frame As Variant, StatusCode As Variant, Cancel As Boolean)
    WebBrowser1.Stop
End Sub

Sub MyMsgBox(MSGSTR As String)
    TXT_MY_MSGBOX.Visible = True
    TXT_MY_MSGBOX.Text = MSGSTR
End Sub

Sub Keep_CPU_Run()
    Show_And_Log_Run_Info "Keep_CPU_Run:"
    TXT_MY_MSGBOX.Visible = True
    TXT_MY_MSGBOX.Text = ""
    TXT_MY_MSGBOX.SetFocus
    TXT_MY_MSGBOX.Locked = False
    SendKeys " Keep the CPU alive ...", True   'ģ�¼������룬��ֹӲ��˯��
    TXT_MY_MSGBOX.Locked = True
    'TXT_MY_MSGBOX.Visible = False
End Sub


Private Sub Cmd_history_Click()
    ShellExecute Me.hwnd, "Open", "file:///" & App.Path & "\history.html", 0, 0, 0
    Sleep 1000
    SendKeys "^{END}"    '��ҳ�����
End Sub



Private Sub Form_KeyPress(KeyAscii As Integer)
'MsgBox CStr(KeyAscii)
If KeyAscii = 27 Then    'Esc������,���Ű��ͺ�ʹ��
    CMD_STOP_Click
    End
End If
End Sub































