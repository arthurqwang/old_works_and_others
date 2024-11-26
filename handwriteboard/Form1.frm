VERSION 5.00
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000009&
   BorderStyle     =   0  'None
   Caption         =   "大庆石油科技馆信息厅留言板"
   ClientHeight    =   9015
   ClientLeft      =   -4230
   ClientTop       =   2955
   ClientWidth     =   17265
   DrawMode        =   3  'Not Merge Pen
   LinkTopic       =   "Form1"
   ScaleHeight     =   9015
   ScaleWidth      =   17265
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox Picture4 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   6255
      Left            =   16080
      ScaleHeight     =   6255
      ScaleWidth      =   855
      TabIndex        =   12
      Top             =   480
      Width           =   855
   End
   Begin VB.PictureBox Picture3 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   6735
      Left            =   120
      ScaleHeight     =   6735
      ScaleWidth      =   735
      TabIndex        =   11
      Top             =   360
      Width           =   735
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   20000
      Left            =   1200
      Top             =   360
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H000000FF&
      Caption         =   "我要留言"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   480
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   7080
      Width           =   2775
   End
   Begin VB.CommandButton Command9 
      BackColor       =   &H000080FF&
      Caption         =   "最后"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1200
      Left            =   15840
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   6960
      Width           =   1815
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H00FFFFFF&
      Caption         =   "细笔"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   21.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4200
      TabIndex        =   8
      Top             =   7680
      Width           =   1500
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "粗笔"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   21.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   4200
      TabIndex        =   7
      Top             =   6960
      Value           =   -1  'True
      Width           =   1500
   End
   Begin VB.CommandButton Command8 
      BackColor       =   &H00C0FFC0&
      Caption         =   "后翻"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1200
      Left            =   13920
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   6960
      Width           =   1815
   End
   Begin VB.CommandButton Command7 
      BackColor       =   &H00C0C0FF&
      Caption         =   "前翻"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1200
      Left            =   11880
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   6960
      Width           =   1815
   End
   Begin VB.Timer Timer1 
      Interval        =   10000
      Left            =   2040
      Top             =   360
   End
   Begin VB.CommandButton Command6 
      BackColor       =   &H00FF80FF&
      Caption         =   "取消"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1200
      Left            =   7440
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   6960
      Width           =   1695
   End
   Begin VB.CommandButton Command5 
      BackColor       =   &H00C0FFC0&
      Caption         =   "保存"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   26.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1200
      Left            =   9240
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   6960
      Width           =   1695
   End
   Begin VB.PictureBox Picture2 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      DrawMode        =   1  'Blackness
      ForeColor       =   &H80000008&
      Height          =   2295
      Left            =   2400
      Picture         =   "Form1.frx":0000
      ScaleHeight     =   2295
      ScaleWidth      =   12015
      TabIndex        =   1
      Top             =   2400
      Width           =   12015
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      DrawStyle       =   1  'Dash
      DrawWidth       =   15
      ForeColor       =   &H80000008&
      Height          =   5775
      Left            =   1920
      ScaleHeight     =   5745
      ScaleWidth      =   11265
      TabIndex        =   0
      Top             =   720
      Width           =   11295
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "现在请您在上面的方框内书写"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   12
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   720
      TabIndex        =   6
      Top             =   8400
      Width           =   3615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'20090918开始
'20090919版本
Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Private Const KEYEVENTF_KEYUP = &H2
Private Declare Function GetTickCount Lib "kernel32" () As Long '毫秒计时
Private Declare Function SetCursor Lib "user32" (ByVal hCursor As Long) As Long

'**************画轴声明*****************************************************************************************************************************
Private Const SRCCOPY = &HCC0020
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, _
                ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, _
                ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
'**************画轴声明结束*****************************************************************************************************************************
                
                
                
Dim KG, KG2, WRITE_STH As Boolean ' 设置开关
Dim r As Integer
Dim g As Integer
Dim b As Integer
Dim now_fn, ldp As Long

Dim h As Boolean
                
                














Private Sub Form_Load()
'On Error Resume Next
    Dim Stick_Wd, Stick_Head_Ht As Integer   '占屏幕宽高多少分之一
    Stick_Wd = 20
    Stick_Wd = Screen.Width / Stick_Wd
    Stick_Head_Ht = 11
    Stick_Head_Ht = Screen.Height / Stick_Head_Ht

    Form1.KeyPreview = True
    Command5.Visible = False
    Command6.Visible = False
    KG2 = False
    WRITE_STH = False
    
    With Me
    .Top = 0
    .Left = 0
    .Width = Screen.Width
    .Height = Screen.Width
    End With
    
    With Picture2
    .Top = 0
    '.Width = Screen.Width / 2.5
    '.Height = Screen.Height / 9
    .Left = (Screen.Width - Picture2.Width) / 2 - 400
    End With
    
    With Picture1
    .Top = 100 + Picture2.Height
    .Left = 100 + Stick_Wd
    .Width = Screen.Width - Stick_Wd * 2 - 100 * 2
    .Height = Screen.Height - Picture2.Height - 100 - Stick_Head_Ht - 100
    End With
    
    
    With Picture3    '左画轴
    .Top = Picture1.Top - Stick_Head_Ht
    .Left = 60
    .Width = Stick_Wd
    .Height = Picture1.Height + Stick_Head_Ht * 2
    End With
    
    With Picture4    '右画轴
    .Top = Picture3.Top
    .Left = Screen.Width - Stick_Wd - 60
    .Width = Stick_Wd
    .Height = Picture3.Height
    End With
    
    'DrawStick Picture2, App.Path & "\sxly.bmp"
    DrawStick Picture3, App.Path & "\stick.bmp"
    DrawStick Picture4, App.Path & "\stick2.bmp"
    
    Label1.Visible = False
    
    Command4.Height = Stick_Head_Ht - 100
    Label1.Height = Command4.Height
    Option1.Height = Command4.Height / 2
    Option2.Height = Command4.Height / 2
    Command6.Height = Command4.Height
    Command5.Height = Command4.Height
    Command7.Height = Command4.Height
    Command8.Height = Command4.Height
    Command9.Height = Command4.Height
    
    Command4.Top = Picture1.Top + Picture1.Height + 100
    Label1.Top = Command4.Top
    Option1.Top = Command4.Top
    Option2.Top = Command4.Top + Option1.Height
    Command6.Top = Command4.Top
    Command5.Top = Command4.Top
    Command7.Top = Command4.Top
    Command8.Top = Command4.Top
    Command9.Top = Command4.Top
    
    Command4.Left = Picture3.Left + Picture3.Width + 500
    Label1.Left = Command4.Left
    Option1.Left = Command4.Left + 4000
    Option2.Left = Command4.Left + 4000
    Command6.Left = Command4.Left + 6000
    Command5.Left = Command4.Left + 8000
    Command7.Left = Screen.Width - Picture4.Width - 100 - 2300 - Command9.Width - 100 - Command8.Width - 100
    Command8.Left = Screen.Width - Picture4.Width - 100 - 2300 - Command9.Width - 100
    Command9.Left = Screen.Width - Picture4.Width - 100 - 2300
    
    

    
    Open App.Path & "\now_fn.txt" For Input As #1
    Input #1, now_fn
    Close #1
    ldp = now_fn
    Command9_Click  '显示最新的留言
    'Form1.Show
    'Scroll_Pic
    
End Sub


Private Sub Form_Click()
 Picture1.AutoRedraw = True
 ForeColor = RGB(255, 0, 0)      ' 线条颜色
End Sub





Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    Write_Into
    KG = True
    WRITE_STH = True
    If KG2 = True Then
       Command5.Visible = True
    End If
    Timer2.Enabled = False
    If Option1.Value = True Then
            Picture1.DrawWidth = 15
        Else
            Picture1.DrawWidth = 5
    End If
    Picture1.PSet (x, y)
    SetCursor 65581   '手状鼠标指针
End Sub

Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    
    
    DoEvents
    If KG = True Then
    
    If KG2 = True Then
        If Option1.Value = True Then
            Picture1.DrawWidth = 15
        Else
            Picture1.DrawWidth = 5
        End If
        If h = False Then
            Picture1.PSet (x, y)
            h = True
        End If
        Picture1.Line -(x, y)   'Picture1.PSet (X, Y)   ' 画点
    End If
 End If
 SetCursor 65581   '手状鼠标指针
End Sub

Private Sub Picture1_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    KG = False
    h = False
    Timer2.Enabled = True    '开始计时 一定时间不写就等于按“取消”键
End Sub

Private Sub Write_Into()
    Label1.Visible = True
    'Option1.Visible = True
    'Option2.Visible = True

    h = False
    Timer1.Enabled = False
    Command7.Visible = False
    Command8.Visible = False
    Command9.Visible = False
    KG2 = True
    Command4.Visible = False
    Command6.Visible = True
    If WRITE_STH = False Then   '留言第一笔书写前
        Set Picture1.Picture = Nothing
        Picture1.Cls
        'Option2.Value = True
        now_fn = now_fn + 1
        Open App.Path & "\now_fn.txt" For Output As #1
        Print #1, now_fn
        Close #1
        SavePicture Picture1.Image, App.Path & "\" & CStr(now_fn) & ".bmp"
    End If
End Sub

Private Sub Command4_Click()
    Label1.Visible = True
    'Option1.Visible = True
    'Option2.Visible = True

    h = False
    Timer1.Enabled = False
    Command7.Visible = False
    Command8.Visible = False
    Command9.Visible = False
    KG2 = True
    Command4.Visible = False
    Command6.Visible = True
    Set Picture1.Picture = Nothing
    Picture1.Cls
    'Option2.Value = True
    now_fn = now_fn + 1
    Open App.Path & "\now_fn.txt" For Output As #1
    Print #1, now_fn
    Close #1
    SavePicture Picture1.Image, App.Path & "\" & CStr(now_fn) & ".bmp"
    WRITE_STH = True
    Timer2.Enabled = True
End Sub

Private Sub Command5_Click()
    ldp = now_fn
    Timer1.Enabled = True
    
    Label1.Visible = False
    Command7.Visible = True
    Command8.Visible = True
    Command9.Visible = True
    Command4.Visible = True
    'Option1.Visible = False
    'Option2.Visible = False

    If WRITE_STH = True Then SavePicture Picture1.Image, App.Path & "\" & CStr(now_fn) & ".bmp"   '背景与绘画一起保存
    Command5.Visible = False
    Command6.Visible = False
    KG2 = False
    WRITE_STH = False
End Sub


Private Sub Command6_Click()
    Timer1.Enabled = True
    Command9_Click
    KG2 = False
    KG = False
    Label1.Visible = False
    Command7.Visible = True
    Command8.Visible = True
    Command9.Visible = True
    'Option1.Visible = False
    'Option2.Visible = False


    
    Command4.Visible = True
    
    Command5.Visible = False
    Command6.Visible = False
    Picture1.Cls
    Kill App.Path & "\" & CStr(now_fn) & ".bmp"
    now_fn = now_fn - 1
    Open App.Path & "\now_fn.txt" For Output As #1
    Print #1, now_fn
    Close #1
    WRITE_STH = False
End Sub


Private Sub Command7_Click()   '前翻
    Timer1.Enabled = False
    Command5.Visible = False
    Command6.Visible = False
    KG2 = False
    ldp = ldp - 1
    If ldp <= 0 Then ldp = now_fn
    Do While Dir(App.Path & "\" & CStr(ldp) & ".bmp", vbNormal) = ""
        DoEvents
        ldp = ldp - 1
        If ldp <= 0 Then ldp = now_fn
    Loop
    Picture1.Picture = LoadPicture(App.Path & "\" & CStr(ldp) & ".bmp")
    Timer1.Enabled = True
End Sub

Private Sub Command8_Click()   '后翻
    Timer1.Enabled = False
    Command5.Visible = False
    Command6.Visible = False
    KG2 = False
    ldp = ldp + 1
    If ldp > now_fn Then ldp = 1
    Do While Dir(App.Path & "\" & CStr(ldp) & ".bmp", vbNormal) = ""
        DoEvents
        ldp = ldp + 1
        If ldp > now_fn Then ldp = 1
    Loop
    Picture1.Picture = LoadPicture(App.Path & "\" & CStr(ldp) & ".bmp")
    Timer1.Enabled = True
End Sub


Private Sub Command9_Click()   '最后
    Timer1.Enabled = False
    Command5.Visible = False
    Command6.Visible = False
    KG2 = False
    ldp = now_fn
    Do While Dir(App.Path & "\" & CStr(ldp) & ".bmp", vbNormal) = ""
        DoEvents
        ldp = ldp - 1
        If ldp <= 0 Then Exit Sub
    Loop
    Picture1.Picture = LoadPicture(App.Path & "\" & CStr(ldp) & ".bmp")
    Timer1.Enabled = True
End Sub

Private Sub Picture1_DblClick()
    Write_Into
End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Command6.Visible = True Then Command6_Click
    End
End Sub

Private Sub Timer1_Timer()
    KG2 = False
    Do While Dir(App.Path & "\" & CStr(ldp) & ".bmp", vbNormal) = ""
        DoEvents
        ldp = ldp - 1
        If ldp <= 0 Then ldp = now_fn
    Loop
    'Scroll_Pic
    Picture1.Picture = LoadPicture(App.Path & "\" & CStr(ldp) & ".bmp")
    ldp = ldp - 1
    If ldp <= 0 Then ldp = now_fn
    
End Sub


Private Sub Timer2_Timer()
    If WRITE_STH = True Then Command6_Click '取消
    Timer2.Enabled = False
    Command9_Click
End Sub


Sub Scroll_Pic()
    Dim t1, t2 As Long
    Picture3.Left = Screen.Width / 2 - Picture3.Width
    Picture4.Left = Screen.Width / 2
    t1 = GetTickCount
    t2 = t1
    For i = 1 To 72
        t1 = GetTickCount
        Do While t2 - t1 < 30
            DoEvents
            t2 = GetTickCount
        Loop
        Picture3.Left = Screen.Width / 2 - Picture3.Width - i * Screen.Width / 160
        Picture4.Left = Screen.Width / 2 + i * Screen.Width / 160
    Next i
End Sub



Sub Flash_Pic()
    Dim t1, t2 As Long
    Picture1.BackColor = RGB(177, 255, 100)
    t1 = GetTickCount
    t2 = t1
    t1 = GetTickCount
    Do While t2 - t1 < 1000
        DoEvents
        t2 = GetTickCount
    Loop
    Picture1.BackColor = RGB(255, 255, 255)
    Picture1.Cls
End Sub










































































'画轴**********************************************************

Public Sub DrawStick(Dst As Object, ByVal FileName As String)
  Dim dstWidth     As Long, dstHeight       As Long
  Dim srcWidth     As Long, srcHeight       As Long
  Dim x     As Long, y       As Long
  Dim pic     As StdPicture
  Dim hDc5     As Long, i       As Long
    
  Set pic = LoadPicture(FileName)         '读取图形档
    
  hDc5 = CreateCompatibleDC(0)       '建立Memory   DC
  i = SelectObject(hDc5, pic.Handle)         '在该memoryDC上放上bitmap图
    
  srcHeight = Dst.ScaleY(pic.Height, vbHimetric, vbPixels)
  srcWidth = Dst.ScaleX(pic.Width, vbHimetric, vbPixels)
    
  dstHeight = Dst.ScaleY(Dst.Height, vbTwips, vbPixels)
  dstWidth = Dst.ScaleX(Dst.Width, vbTwips, vbPixels)
  Call StretchBlt(Dst.hdc, x, y, dstWidth, dstHeight, hDc5, 0, 0, srcWidth, srcHeight, SRCCOPY)
  Call DeleteDC(hDc5)
  End Sub



Public Sub DrawBitMap(Dst As Object, ByVal xRate As Double, _
                ByVal yRate As Double, ByVal FileName As String)
  Dim dstWidth     As Long, dstHeight       As Long
  Dim srcWidth     As Long, srcHeight       As Long
  Dim x     As Long, y       As Long
  Dim pic     As StdPicture
  Dim hDc5     As Long, i       As Long
    
  Set pic = LoadPicture(FileName)         '读取图形档
    
  hDc5 = CreateCompatibleDC(0)       '建立Memory   DC
  i = SelectObject(hDc5, pic.Handle)         '在该memoryDC上放上bitmap图
    
  srcHeight = Dst.ScaleY(pic.Height, vbHimetric, vbPixels)
  srcWidth = Dst.ScaleX(pic.Width, vbHimetric, vbPixels)
    
  dstHeight = CLng(srcHeight * yRate)
  If dstHeight < 0 Then
        y = -1 * dstHeight
  Else
        y = 0
  End If
  dstWidth = CLng(srcWidth * xRate)
  If dstWidth < 0 Then
        x = -1 * dstWidth
  Else
        x = 0
  End If
  Call StretchBlt(Dst.hdc, x, y, dstWidth, dstHeight, hDc5, 0, 0, srcWidth, srcHeight, SRCCOPY)
  Call DeleteDC(hDc5)
  End Sub
    
    
  Public Sub DrawPicture(Dst As Object, ByVal xRate As Double, _
                                ByVal yRate As Double, ByVal FileName As String)
  Dim dstWidth     As Long, dstHeight       As Long
  Dim srcWidth     As Long, srcHeight       As Long
  Dim x     As Long, y       As Long
  Dim pic     As StdPicture
  Dim i     As Long
    
  Set pic = LoadPicture(FileName)         '读取图形档
    
  srcHeight = Dst.ScaleY(pic.Height, vbHimetric, vbPixels)
  srcWidth = Dst.ScaleX(pic.Width, vbHimetric, vbPixels)
    
  dstHeight = CLng(srcHeight * yRate)
  If dstHeight < 0 Then
        y = -1 * dstHeight
  Else
        y = 0
  End If
  dstWidth = CLng(srcWidth * xRate)
  If dstWidth < 0 Then
        x = -1 * dstWidth
  Else
        x = 0
  End If
  Dst.ScaleMode = 3
  Dst.PaintPicture pic, x, y, dstWidth, dstHeight, 0, 0, srcWidth, srcHeight
    
  End Sub
' 画轴结束****************************************************************************************************************************











