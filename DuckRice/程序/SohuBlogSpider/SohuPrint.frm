VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   795
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   1770
   Icon            =   "SohuPrint.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   795
   ScaleWidth      =   1770
   StartUpPosition =   3  '窗口缺省
   Visible         =   0   'False
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function GetTickCount Lib "kernel32" () As Long '毫秒计时
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)


'Form1.Visible = False
Dim SON_STATUS, USER, USER_NUM, TURN, TURNS As Integer
Dim TOTAL, THIS_TIME, THIS_USER, HISTORY_POINTER As Long
Dim TIME_STAMP, Time_Temp, BEGIN_TIME As Long
Dim SON_AUTO_START As Integer


Private Sub Form_Load()
    'On Error Resume Next
    
    Get_Total_And_History_Pointer
    Open "loginfo.txt" For Append As #317
    Print #317, ""
    Print #317, ""
    Print #317, "[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]"
    Print #317, "                    " & CStr(Now)
    Print #317, "[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]"
    Print #317, "#####################  已访问总数 = " & TOTAL & "   ######################"
    Print #317, "父进程(主控进程): 启动"
    Close #317
    
    
    THIS_TIME = 0
    THIS_USER = 0
    BEGIN_TIME = GetTickCount()
    TURN = 0
    
    Send_Message_To_Father 1
    SON_AUTO_START = 0    '只有在初次启动时，需要在子进程上按 【开始】 键，以后都自动。0：需要按 【开始】键
    
    Do   '轮
        DoEvents
        
        Get_Turns
        TURN = TURN + 1
        If TURN > TURNS Then End
        Log_Run_Info ("=================   父进程: 第" & CStr(TURN) & "轮 开始   =====================")
        USER = 0
        
        Do   '用户
            DoEvents
            Get_User_Num
            If USER > USER_NUM Then Exit Do
            
            Sleep 1000
            Read_Message
            
            Select Case SON_STATUS
                Case 0
                   '子进程刚刚启动，主控程序什么都不做，结束 select，继续循环，等待子进程消息
                    
                Case 1
                    '子进程正常完成任务，并结束了。主控程序下一次启动子进程
                    Log_Run_Info ("父进程: 第" & CStr(TURN) & "轮 第" & CStr(USER + 1) & "用户 开始")
                    Send_Message_To_Father 0
                    Shell App.Path & "\SohuPrint2.exe " & CStr(TURN) & " " & CStr(USER) & " " & CStr(THIS_TIME) & " " & CStr(THIS_USER) & " " & CStr(BEGIN_TIME) & " " & CStr(SON_AUTO_START), vbNormalFocus
                    SON_AUTO_START = 1
                    Sleep 1000
                    'MsgBox CStr(i)
                    USER = USER + 1
                    
                Case 2
                    '子进程中按下了退出键或关窗口键，表示主控程序也该结束。
                    End
                
                Case -1
                    '子进程访问了一个URL。现在检查是否没有响应了，若是主控进程要杀掉它，并从断点处恢复，如不是则结束 select，继续循环，等待子进程消息
                    '注意USER变量，恢复时要-1
                    Time_Temp = GetTickCount()
                    If Time_Temp - TIME_STAMP > 60000 Then
                        Log_Run_Info ("父进程: 子进程访问一个URL后没有响应，被杀死")
                        Shell "ntsd -c q -pn SohuPrint2.exe cmd.exe", vbHide
                        Sleep 2000
                        Log_Run_Info ("父进程: 子进程被重新启动")
                        Log_Run_Info ("父进程: 断点恢复——第" & CStr(TURN) & "轮 第" & CStr(USER) & "用户 本次第" & CStr(THIS_TIME) & "次 本用户第" & CStr(THIS_USER) & "次")
                        HISTORY_POINTER = HISTORY_POINTER + 1  '免得下次重访历史时在一个URL处停住，死循环
                        Send_Message_To_Father 0
                        SON_AUTO_START = 1
                        Shell App.Path & "\SohuPrint2.exe " & CStr(TURN) & " " & CStr(USER) & " " & CStr(THIS_TIME) & " " & CStr(THIS_USER) & " " & CStr(BEGIN_TIME) & " " & CStr(SON_AUTO_START), vbNormalFocus
                        Sleep 1000
                    End If
                    
                Case Else
                    '子进程状态未知，主控程序什么都不做，结束 select，继续循环，等待子进程消息
            
            End Select
     
        Loop
        Log_Run_Info ("父进程: 第" & CStr(TURN) & "轮 结束")
    Loop
    Log_Run_Info "父进程: 在预定时间内全部完成"
End Sub
    

Sub Send_Message_To_Father(Signal As Integer)
    '给父进程发消息
    '开始访问一个URL时，Signal=-1
    '结束时——Signal= 0：本子进程正在启动，1：本子进程结束，2：在本子进程中按了 退出 键
    Dim TIME_STAMP As Long
    TIME_STAMP = GetTickCount()
    Open App.Path & "\message.txt" For Output As #152
    Print #152, Signal, TOTAL, THIS_TIME, THIS_USER, TIME_STAMP, HISTORY_POINTER
    Close #152
End Sub


Sub Read_Message()
    Dim i As Integer
    i = 0
    Open App.Path & "\message.txt" For Input As #1
        Do While i = 0 And Not EOF(1)
            Input #1, SON_STATUS, TOTAL, THIS_TIME, THIS_USER, TIME_STAMP, HISTORY_POINTER
            i = i + 1
            Sleep 10
        Loop
    Close #1

End Sub

Sub Get_Total_And_History_Pointer()
    Dim Sig, this_t, this_u, time_st, history_p As Long
    Dim i As Integer
    i = 0
    Open App.Path & "\message.txt" For Input As #15
        Do While i = 0 And Not EOF(15)
            Input #15, Sig, TOTAL, this_t, this_u, time_st, HISTORY_POINTER
            i = i + 1
            Sleep 10
        Loop
    Close #15
End Sub


Sub Get_Turns()
    Dim st, de, pa, mi, ti, hi, no As Long
    Open App.Path & "\config.txt" For Input As #1
    Input #1, st, de, pa, mi, ti, TURNS, hi, no
    Close #1
End Sub

Sub Get_User_Num()
    Dim filenum  As Integer
    Dim fileContents As String
    Dim users() As String
    
    filenum = FreeFile
    Open "user.txt" For Binary As #filenum
            fileContents = Space(LOF(filenum))
            Get #filenum, , fileContents
    Close #filenum
    fileContents = CUT_vbCrLf_and_Space(fileContents)
    users = Split(fileContents, vbCrLf)
    USER_NUM = UBound(users)

End Sub




Function CUT_vbCrLf_and_Space(str As String) As String
    Dim t As String
    Dim i, s, e, L As Long
    'Show_And_Log_Run_Info "CUT_vbCrLf_and_Space:去掉多余回车符"
    t = str
    t = Replace(t, " ", "")
    t = Trim(t)
    L = Len(t)
    i = 1
    Do While i < L - 1 And Mid(t, i, 2) = vbCrLf '回车长度为2
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

Sub Log_Run_Info(Info As String)   '与子进程异
    Dim ttt As String
    ttt = CStr(Time) & ">" & Info
    Open "loginfo.txt" For Append As #317
    Print #317, ttt
    Close #317
End Sub
