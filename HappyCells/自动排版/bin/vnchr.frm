VERSION 5.00
Begin VB.Form vnchr 
   BackColor       =   &H80000009&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "《开心情报站》自动排版系统模块版本协调器"
   ClientHeight    =   615
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2505
   Icon            =   "vnchr.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   615
   ScaleWidth      =   2505
   StartUpPosition =   3  '窗口缺省
   Visible         =   0   'False
End
Attribute VB_Name = "vnchr"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Function ReadPar(ByVal File_NM As String, PAR_NM As String, Symbol As String) As String
 On Error GoTo 2222
 Dim temp As String
 Dim n As Integer
 PAR_NM = Trim(PAR_NM)
 DoEvents
 Open File_NM For Input As #10
 Do While Not EOF(10)
 DoEvents
  Input #10, temp
  temp = Trim(temp)
  If temp = "{{END}}" Then Exit Do
  n = InStr(temp, Symbol)
  If PAR_NM = Left(temp, n - 1) Then
   ReadPar = Trim(Mid(temp, n + 1, Len(temp)))
   Close #10
   Exit Function
  End If
2222
 Loop
 Close #10
 DoEvents
 ReadPar = ""
End Function

Private Sub Form_Initialize()
'读受保护文件的信息,列在 version.par 中,但开心情报站广告图片不写在那个文件中,在此直接处理
'试用版本忽略这项检查
'不能使用随机数，否则各方对不上
 Dim fn_v, mdn_p, files_rele, ref As String
 fn_v = App.Path & "\version.par"
 i = 1
 t_num = 0
 Do
   mdn_p = App.Path & "\" & ReadPar(fn_v, "模块" & i & "代码", ":")
   If mdn_p = App.Path & "\" Then Exit Do
   mdn_p = Left(mdn_p, InStr(mdn_p, "-") - 1)
   t_num = t_num + Abs(Int(FileLen(mdn_p & ".exe") * 0.71337))
   files_rele = files_rele & vbCrLf & mdn_p & ".exe"
 i = i + 1
 Loop
 files_rele = files_rele & vbCrLf & App.Path & "\kxqbz_ad.jpg"
 files_rele = files_rele & vbCrLf & App.Path & "\hcrun.dll"
 files_rele = files_rele & vbCrLf & App.Path & "\version.par"
 
 t_num = t_num + Abs(Int(FileLen(App.Path & "\kxqbz_ad.jpg")) * 0.47609)
 t_num = t_num + Abs(Int(FileLen(App.Path & "\hcrun.dll")))   '此文件没用，是为破解设置的假目标
 t_num2 = t_num
 ad_file_len = t_num
 t_num = ad_file_len
 t_num2 = t_num
 t_num = t_num * 31 + Int(1942753 * (0.10973 + 1))
 t_num = Abs(t_num)
 t_str = CStr(Int(t_num2 / 1103 * (0.37437 + 1))) & CStr(t_num) & "0845645698"
 t_str = Mid(t_str, 1, 10)

Open fn_v For Input As #1
Open fn_v & "a" For Output As #2
Do While Not EOF(1)
 Input #1, ref
 If Left(Trim(ref), 4) = "REF:" Then ref = "REF:" & t_str
 Print #2, ref
Loop
Close #1
Close #2
Kill fn_v
FileCopy fn_v & "a", fn_v
Kill fn_v & "a"
MsgBox "本程序协调各模块版本，不能发给用户。" & vbCrLf & "模块版本协调完毕，请按 [确认] 退出后手动更新下列待打包文件：  " & files_rele, 48, "《开心情报站》自动排版系统模块版本协调器"
End
End Sub
















