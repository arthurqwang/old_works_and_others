VERSION 5.00
Begin VB.Form vnchr 
   BackColor       =   &H80000009&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "�������鱨վ���Զ��Ű�ϵͳģ��汾Э����"
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
   StartUpPosition =   3  '����ȱʡ
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
'���ܱ����ļ�����Ϣ,���� version.par ��,�������鱨վ���ͼƬ��д���Ǹ��ļ���,�ڴ�ֱ�Ӵ���
'���ð汾����������
'����ʹ�����������������Բ���
 Dim fn_v, mdn_p, files_rele, ref As String
 fn_v = App.Path & "\version.par"
 i = 1
 t_num = 0
 Do
   mdn_p = App.Path & "\" & ReadPar(fn_v, "ģ��" & i & "����", ":")
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
 t_num = t_num + Abs(Int(FileLen(App.Path & "\hcrun.dll")))   '���ļ�û�ã���Ϊ�ƽ����õļ�Ŀ��
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
MsgBox "������Э����ģ��汾�����ܷ����û���" & vbCrLf & "ģ��汾Э����ϣ��밴 [ȷ��] �˳����ֶ��������д�����ļ���  " & files_rele, 48, "�������鱨վ���Զ��Ű�ϵͳģ��汾Э����"
End
End Sub
















