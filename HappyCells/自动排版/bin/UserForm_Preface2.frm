VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm_Preface 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "UserForm1"
   ClientHeight    =   4410
   ClientLeft      =   30
   ClientTop       =   315
   ClientWidth     =   7305
   Icon            =   "UserForm_Preface2.dsx":0000
   MaxButton       =   0   'False
   OleObjectBlob   =   "UserForm_Preface2.dsx":0CCA
   StartUpPosition =   2  '��Ļ����
End
Attribute VB_Name = "UserForm_Preface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'addbar.xls�� fontsize.xla �걣�����룺kxqbzggxzk888daqing
'Version 2008 RN:20080108 2008-1-8:�˰汾��Ҫ�Ķ���
'��ҵ��װ����
'(1)��ʹ��ʱ������ ISSUE_NUM_CHANGE_CONTROL
'(2)LOGOͼǶ�ڳ����У�����ͨ����ͼ���ļ��͸����ͼ��
'(3)�ӱ���ʹ�����ƣ�ʹ�����֤
'(4)ȫ������Vb6���
'
'��Ҫ������:
'Visual Basic For Applications
'Microsoft Excel 11.0 Object Library    '���Ҫ������ǰ�� publish�������ԭ�������ð汾������������
'Microsoft Access 11.0 Object Library
'Microsoft WMI Scripting V1.2 Library
'OLE Automation
'Micosoft Office 11.0 Object Library
'Micosoft ActiveX Data Objects 2.5 Library 'Ҳ������ǰ
'Micosoft ActiveX Data Objects Recordset 2.5 Library
'Micosoft DAO 3.6 Object Library

'********************** ��̱ʼ� **************************
' 1)��Ԫ����ֻҪʹ�� chr(10)�������ټ�chr(13)��
' 2)�������ݿ�Ҫ�� "����/����/MicroSoft ActiveX Data Objects 2.5 �� MicroSoft DAO 3.6 Objects Library"
'********************* ��̱ʼǽ��� ***********************

   '����ҵ��ĵ�Ŀ¼
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


Const SYSTEM_INFO_NAME = "�������鱨վ���Զ��Ű�ϵͳ - HCWeb V2008"
Const FONT_ADJ = 1  '���������彵��
Dim MY_DOC_PATH As String
Dim cellid As String    '��Ԫ����
Dim ROWNUM, COLNUM As Integer
Dim APP_BEGUN As Boolean
Dim FROM_FILE_NAME As String
Dim TO_FILE_NAME As String
Dim CURRENT_FROM_FILE_NAME, CURRENT_TO_FILE_NAME As String
Dim PRESS_ELSE_BUTTON As Boolean
Dim Dark_Colors(1 To 8, 1 To 3), Bright_Colors(1 To 8, 1 To 3) As Integer



'****************************************        ��ʼ                       *************************************************
'*******************************************                       *********************************************************
'******************************************                     *************************************************************
'*****************************************************************************************************************************
'*****************************************************************************************************************************

Private Sub BeginButton_Click()

DoEvents
CurrentButton.Enabled = False
BrowseButton.Enabled = False
BeginButton.Enabled = False
APP_BEGUN = True
'StopButton.Enabled = False
Application.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
Application.Visible = False
DoEvents
Application.Caption = SYSTEM_INFO_NAME   '��excel ���ڱ���
DoEvents
'************* ���������ļ�,���û�������  ******Ϊ�˱����Ű���Ч,����Ҫ�ڰ���ʼ��֮����,�����ⲿ�ֲ����� ���ڳ�ʼ��ʱ��
'*************************************************************************************************************************
FROM_FILE_NAME = FROM_FILE_NAME_i.Value
TO_FILE_NAME = TO_FILE_DIR_i.Value & "\temp_web.xls"
ShowPercents_Status 1, "��ʼ������"
ShowPercents_Status 9, "��ʱ����"
Application.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
DoEvents
Save_Web_Temp
ShowPercents_Status 21, "��ʼ����"
Application.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
DoEvents
Create_Web_File    '��������web��,���xls��HTML
'����0.asp��web��Ŀ¼��
DoEvents
Copy_File_0_asp_To_Web_Dir
'�ر� Excel,������
Application.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
BeginButton.Visible = False
StopButton.Visible = False

EndButton.Visible = True
EndButton.Default = True
EndButton.SetFocus
ShowPercents_Status 100, "�������"
'Application.Quit
End Sub


Private Sub BrowseButton_Click()
    PRESS_ELSE_BUTTON = True
    Dim OpenFile As OPENFILENAME
    Dim lReturn As Long
    Dim sFilter As String
    OpenFile.lStructSize = Len(OpenFile)
    DoEvents
    OpenFile.hwndOwner = UserForm_Preface.hWnd
    DoEvents
    OpenFile.hInstance = App.hInstance
    DoEvents
    sFilter = "�����鱨վ�ļ�(Excel:*.xls)" & Chr(0) & "*.xls" & Chr(0)
    DoEvents
    OpenFile.lpstrFilter = sFilter
    DoEvents
    OpenFile.nFilterIndex = 1
    DoEvents
    OpenFile.lpstrFile = String(257, 0)
    DoEvents
    OpenFile.nMaxFile = Len(OpenFile.lpstrFile) - 1
    DoEvents
    OpenFile.lpstrFileTitle = OpenFile.lpstrFile
    DoEvents
    OpenFile.nMaxFileTitle = OpenFile.nMaxFile
    DoEvents
    OpenFile.lpstrInitialDir = MY_DOC_PATH & "\�������鱨վ���ĵ�\�����"
    DoEvents
    OpenFile.lpstrTitle = "�������鱨վ��- ��ѡ��ӡˢ��ԭ�ļ�"
    DoEvents
    OpenFile.flags = &H4   'OFN_NOREADONLYRETURN  ȥ������ֻ����ʽ�򿪡�
    DoEvents
    lReturn = GetOpenFileName(OpenFile)
    DoEvents
    If lReturn <> 0 Then
        temp = Trim(OpenFile.lpstrFile)
        FROM_FILE_NAME_i.Value = temp
        temp = Replace(temp, ".xls", "-web��.xls")
        temp = Left(temp, InStrRev(temp, "\")) & "web��"
        TO_FILE_DIR_i.Value = temp
    End If
    DoEvents
End Sub

Private Sub CurrentButton_Click()
  FROM_FILE_NAME_i.Value = CURRENT_FROM_FILE_NAME
  TO_FILE_DIR_i.Value = CURRENT_TO_FILE_NAME
  PRESS_ELSE_BUTTON = False
End Sub

Private Sub EndButton_Click()
  DoEvents
  Shell "Explorer.exe " & TO_FILE_DIR_i.Value, vbNormalFocus
  DoEvents
  Application.Quit
  DoEvents
  End
End Sub

Private Sub StopButton_Click()
Dim stop_y_n
DoEvents
If APP_BEGUN = True Then
  stop_y_n = MsgBox("�˳������ж�Web�Ű棡" & vbCrLf & "�������MS Excel �����رգ��뱣������ļ���  " & vbCrLf & "ȷʵҪ�˳���", 1 + 256, "�������鱨վ���Զ��Ű�ϵͳ")
  If stop_y_n = 1 Then
   '�ر� Excel,������
   Application.Quit
   End
  End If
Else
  '�ر� Excel,������
  Application.Quit
  End
End If
End Sub

Private Sub UserForm_Initialize()
 Get_My_Documents_Path   '����ҵ��ĵ�Ŀ¼
 Dim fn_temp As String
 'logo.Picture = LoadPicture(app.Path & "\k-logo2.jpg")
 UserForm_Preface.Caption = SYSTEM_INFO_NAME
 Application.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
 DoEvents
 GET_LICENCE
 DoEvents
 '�����һ���Ű���Ϣlastinfo.par,���ﱣ����ӡˢ���ļ�ȫ·����
 Dim temp As String
 Open App.Path & "\lastinfo.par" For Input As #10
 If Not EOF(10) Then  '��Ϊ��װ���lastion.par��û�ж���
    Input #10, temp
    temp = Replace(temp, "\�Զ��Ű�\bin\..\..", "")
    FROM_FILE_NAME_i.Value = temp
    temp = Replace(temp, "\ӡˢ��\", "\web��\")
    temp = Left(temp, InStrRev(temp, "\") - 1)
    TO_FILE_DIR_i.Value = temp
 End If
 Close #10
 DoEvents
 CURRENT_FROM_FILE_NAME = FROM_FILE_NAME_i.Value
 CURRENT_TO_FILE_NAME = TO_FILE_DIR_i.Value
 APP_BEGUN = False
 PRESS_ELSE_BUTTON = False
 Define_Color
  'Release No.
 fn_temp = App.Path & "\version.par"
 DoEvents
 RN.Caption = "RN: " & ReadPar(fn_temp, "RN", ":")
 DoEvents
 End Sub


Sub Save_Web_Temp()
'KILL_SELF_WHEN_VITAL_ERROR  '���������ش���ʱ����ȫ�˳����� ɱ��Excel����
'On Error GoTo 12345
Dim web_dir As String
'���м�壬�Ա���������web��
'��excel�ľ�����ʾ,�Է�ֹ���Ǿɳ�����ļ�
Application.DisplayAlerts = True
'��ӡˢ���ļ�
ShowPercents_Status 3, "��Դ�ļ�"
DoEvents
Workbooks.Open FROM_FILE_NAME
DoEvents
'����web��Ŀ¼,������� ����������ѡ���Դ�ļ�����web��ֱ�Ӵ���Դ�ļ���ͬĿ¼��
'If PRESS_ELSE_BUTTON = False Then
'   web_dir = Left(TO_FILE_NAME, InStr(TO_FILE_NAME, "\web��\") + 5)
'   Create_Dir web_dir
'End If
Create_Dir TO_FILE_DIR_i.Value
'���Ű���(web��ʱ��)
ShowPercents_Status 5, "����ʱ�ļ�"
ActiveWorkbook.SaveAs FileName:=TO_FILE_NAME
DoEvents
WORKBOOKNAME = ActiveWorkbook.Name
UserForm_Preface.Repaint
DoEvents
End Sub

Sub Create_Web_File()
'KILL_SELF_WHEN_VITAL_ERROR  '���������ش���ʱ����ȫ�˳����� ɱ��Excel����
DoEvents
Workbooks.Open TO_FILE_NAME
ShowPercents_Status 22, "�������"
ShowPercents_Status 25, "������ҳ"
Process_inner_pages
ShowPercents_Status 80, "������"
ShowPercents_Status 82, "����Web��"
ActiveWorkbook.Save
DoEvents
ShowPercents_Status 90, "����HTML"
Save_HTML
DoEvents
ShowPercents_Status 90, "׼������"
Application.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
ActiveWorkbook.Close
DoEvents
End Sub

Sub Process_inner_pages()
'������ҳ,�ѱ����ɫ��Ϊ��ɫ��
Worksheets("��ҳ").Activate
'���ʹ�ù���������
COLNUM = ActiveSheet.UsedRange.Columns.Count
ROWNUM = ActiveSheet.UsedRange.Rows.Count
cellid = "A:" + Chr(64 + COLNUM)
Columns(cellid).Select
    With Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With

For i = 1 To ROWNUM Step 2
 DoEvents
 ShowPercents_Status 25 + CInt(55.01 * i / ROWNUM), "����Ԫ��:" & i & "/" & ROWNUM
 For j = 1 To COLNUM
  cellid = Chr(64 + j) & i
  cellid2 = Chr(64 + j) & (i + 1)
  clr_index = (i + j) Mod 6 + 1
  If ActiveSheet.Range(cellid2).Value <> "" Then
     ActiveSheet.Range(cellid).Font.Size = ActiveSheet.Range(cellid).Font.Size - FONT_ADJ
     DoEvents
     ActiveSheet.Range(cellid).Interior.Color = RGB(Dark_Colors(clr_index, 1), Dark_Colors(clr_index, 2), Dark_Colors(clr_index, 3))
  End If
 Next j
Next i
DoEvents
End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
'�رմ���ʱ����ʽ���ڰ��˳���
  Cancel = True  '�����ʹ�� UserForm �����ر�
  StopButton_Click
End Sub


Sub Create_Dir(dir As String)
Dim pointer As Integer
Dim crt_dir
Dim dir2 As String
dir2 = dir & "\"
pointer = 0
On Error Resume Next
Do
  DoEvents
  pointer = InStr(pointer + 1, dir2, "\")
  crt_dir = Left(dir2, pointer - 1)
  MkDir crt_dir
Loop While pointer > 0
DoEvents
End Sub

Sub Save_HTML()
'KILL_SELF_WHEN_VITAL_ERROR

Dim html_path, prnt_area As String
html_path = TO_FILE_NAME
html_path = Left(html_path, InStrRev(html_path, "\"))

DoEvents
If Sheet_Exsists("����") Then
    Sheets("����").Select
    DoEvents
    prnt_area = "$A:$" & Chr(64 + ActiveSheet.UsedRange.Columns.Count)
    Columns(prnt_area).Select
    DoEvents
    With ActiveWorkbook.WebOptions
        .RelyOnCSS = True
        .OrganizeInFolder = True
        .UseLongFileNames = False
        .DownloadComponents = False
        .RelyOnVML = True
        .AllowPNG = False
        .ScreenSize = msoScreenSize1024x768
        .PixelsPerInch = 72
        .Encoding = msoEncodingSimplifiedChineseGBK
    End With
    DoEvents
    With Application.DefaultWebOptions
        .SaveHiddenData = False
        .LoadPictures = False
        .UpdateLinksOnSave = False
        .CheckIfOfficeIsHTMLEditor = False
        .AlwaysSaveInDefaultEncoding = False
        .SaveNewWebPagesAsWebArchives = False
    End With
    DoEvents
    With ActiveWorkbook.PublishObjects.Add(xlSourceRange, _
        html_path & "1.htm", "����", prnt_area, xlHtmlStatic, "", "")
        .Publish (True)
        .AutoRepublish = False
    End With
Else
     Open html_path & "1.htm" For Output As #101
     Print #101, ""
     Close #101
End If
    DoEvents
    
If Sheet_Exsists("��ҳ") Then
    Sheets("��ҳ").Select
    '������ð�sheet��������޷�����Ϊhtml����Ȼ���ð治�ṩHCWeb���ܣ������ǵ�ת�ɼ����û���Ӧ�øĿ��԰�ԭ����ת��
    'ȡ������󲻱��������ˣ���Ϊ�����е����˵���Ѿ��Ǽ����û��ˣ��Ͳ�������
    s = "hgdasdfsdhgsdf6767327wefd76327ewg763retdwter5632723t326732632tuywtdwtuywte786723672332576tfjk"  '��HCAutoEditһ����
    ActiveSheet.Unprotect Password:=s 'ȡ������  ���ԭ��û����������Ҳ�������

    DoEvents
    prnt_area = "$A:$" & Chr(64 + COLNUM)
    Columns(prnt_area).Select
    DoEvents
    With ActiveWorkbook.WebOptions
        .RelyOnCSS = True
        .OrganizeInFolder = True
        .UseLongFileNames = False
        .DownloadComponents = False
        .RelyOnVML = True
        .AllowPNG = False
        .ScreenSize = msoScreenSize1024x768
        .PixelsPerInch = 72
        .Encoding = msoEncodingSimplifiedChineseGBK
    End With
    DoEvents
    With Application.DefaultWebOptions
        .SaveHiddenData = False
        .LoadPictures = False
        .UpdateLinksOnSave = False
        .CheckIfOfficeIsHTMLEditor = False
        .AlwaysSaveInDefaultEncoding = False
        .SaveNewWebPagesAsWebArchives = False
    End With
    DoEvents
    With ActiveWorkbook.PublishObjects.Add(xlSourceRange, _
        html_path & "2.htm", "��ҳ", prnt_area, xlHtmlStatic, "", "")
        .Publish (True)
        .AutoRepublish = False
    End With
Else
     Open html_path & "2.htm" For Output As #101
     Print #101, ""
     Close #101
End If
    DoEvents
    
If Sheet_Exsists("���") Then
    Sheets("���").Select
    prnt_area = "$A:$" & Chr(64 + ActiveSheet.UsedRange.Columns.Count)
    Columns(prnt_area).Select
    DoEvents
    With ActiveWorkbook.WebOptions
        .RelyOnCSS = True
        .OrganizeInFolder = True
        .UseLongFileNames = False
        .DownloadComponents = False
        .RelyOnVML = True
        .AllowPNG = False
        .ScreenSize = msoScreenSize1024x768
        .PixelsPerInch = 72
        .Encoding = msoEncodingSimplifiedChineseGBK
    End With
    DoEvents
    With Application.DefaultWebOptions
        .SaveHiddenData = False
        .LoadPictures = False
        .UpdateLinksOnSave = False
        .CheckIfOfficeIsHTMLEditor = False
        .AlwaysSaveInDefaultEncoding = False
        .SaveNewWebPagesAsWebArchives = False
    End With
    DoEvents
    With ActiveWorkbook.PublishObjects.Add(xlSourceRange, _
        html_path & "3.htm", "���", prnt_area, xlHtmlStatic, "", "")
        .Publish (True)
        .AutoRepublish = False
    End With
Else
     Open html_path & "3.htm" For Output As #101
     Print #101, ""
     Close #101
End If
    DoEvents
End Sub

Function Sheet_Exsists(ByVal sheetname As String) As Boolean   '�ж�sheet�Ƿ���ڣ�ʹ�����֣���worksheets("��ҳ")
    Dim SHEETS_NUM As Integer
    SHEETS_NUM = Worksheets.Count
    Sheet_Exsists = False
    For i = 1 To SHEETS_NUM
      If Worksheets(i).Name = sheetname Then
        Sheet_Exsists = True
        Exit Function
      End If
    Next i
End Function


Sub Copy_File_0_asp_To_Web_Dir()  '����0.asp,ͬʱɾ��web���xls�ļ�,��ͬ count.txt
ShowPercents_Status 98, "����0.asp"
DoEvents
Dim from_f, to_f, T_f As String
from_f = App.Path & "\etc\0.asp"
FileCopy from_f, TO_FILE_DIR_i.Value & "\0.asp"

from_f = App.Path & "\etc\count.txt"
FileCopy from_f, TO_FILE_DIR_i.Value & "\count.txt"

DoEvents
Kill TO_FILE_NAME
DoEvents
End Sub

Private Sub ShowPercents_Status(percents As Single, str As String)
  DoEvents
  If percents > 100 Then percents = 100
  percents_right.Left = 114 + 240 * percents / 100
  w = 242 - 240 * percents / 100
  If w < 0 Then w = 0
  percents_right.Width = w
  percents_num.Left = 116 + 240 * percents / 100
  percents_num.Caption = CStr(Int(percents)) + "%"
  Status.Caption = str
  If percents = 100 Then
    percents_right.Visible = False
    percents_num.Visible = False
  End If
  UserForm_Preface.Repaint
  DoEvents
End Sub



Function Cpu_id() As String

   Dim cpuSet As SWbemObjectSet
   Dim cpu As SWbemObject
  
   Set cpuSet = GetObject("winmgmts:{impersonationLevel=impersonate}"). _
                           InstancesOf("Win32_Processor")
   For Each cpu In cpuSet
      DoEvents
      getwmiprocessorid = cpu.processorid
   Next
Cpu_id = UCase(Left(CStr(getwmiprocessorid), 16))
DoEvents
   
End Function

Sub GET_LICENCE()  '****��Sub��HCAutoEdit�еĲ�ͬ��������ȫ����
'LICENCE_STATUS �� VERSION_INFO.captionֵ��0���ð汾��1ע��汾��2ע��汾,�������ڣ���ǰһ���¾��棻
'3֤����ڣ���δ��1���£���ʾһ���������ڣ�4֤����ڣ�����1���£���ʾ��ϵ���񣬲������ð�Դ���5֤����Ч����ʾ����������
 On Error Resume Next
 Dim Licence_ID, l_id, CpuID, user, usert, sales, t_str, t_str2 As String
 Dim t0, t1, t2, t_num, t_num2  As Long
 Dim days, l_str As Integer
 Dim begin_day As Date
 Dim sec1_20, sec21_30, sec31_40, sec41_50 As String '�ֱ��CPU���û������䷢���ں���Ч�� ��Ϣ
 Dim CONTACT_INFO As Variant
 CONTACT_INFO = "   ����ϵ���췽�������޹�˾" & vbCrLf & _
                "        ��ַ:www.kxqbz.com" & vbCrLf & _
                "        �绰:0459-5514422 5773694 13644697987     " & vbCrLf & _
                "        QQ:5632147 492533636"
  
 '��licence.txt
 Open MY_DOC_PATH & "\�������鱨վ���ĵ�\ʹ�����֤\licence.txt" For Input As #1
 'ѭ��������**���֤��Ϣ**��
 Do
   Input #1, tempii
 Loop While tempii <> "**���֤��Ϣ**"
 Input #1, tempii
 Input #1, tempii
 user = Mid(tempii, InStr(tempii, ":") + 1, Len(tempii))
 Input #1, tempii
 Input #1, tempii
 l_id = Mid(tempii, InStr(tempii, ":") + 1, Len(tempii))
 Input #1, tempii
 begin_day = CDate(Mid(tempii, InStr(tempii, ":") + 1, Len(tempii)))
 Input #1, tempii
 days = CInt(Mid(tempii, InStr(tempii, ":") + 1, Len(tempii)))
 Input #1, tempii
 sales = Mid(tempii, InStr(tempii, ":") + 1, Len(tempii))
 Close #1
 usert = user
 
 'CPU
 CpuID = Cpu_id()
'CpuID = "eeffaa223344"
 If user = "������ʱ��ɵĻ��" Then CpuID = "0000000000000000"
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
 
 '�û���
'user = "ghgfrtrtffgfgcgfdgfdh"
user = user & sales
 l_str = Len(user)
 For i = 1 To l_str - 1
  t_num = t_num + Asc(Mid(user, i, 1))
 Next i
 t_num = t_num * 31 + Int(64725694 * (Rnd + 1))
 t_num = Abs(t_num)    '���в��ܺ���һ�кϲ�д����Ϊ�����һ������Ͳ�ִ��Abs()��ֱ��ת��һ���ˣ��Ϳ��ܳ��ָ���
 t_str = CStr(Int(31578 * (Rnd + 1))) & CStr(t_num) & "7546718635768"
 t_str = Mid(t_str, 4, 10)
 sec21_30 = t_str

 '��Ч��
'days = 112
'begin_day = "2007-1-9"
 t_str2 = FormatDateTime(begin_day, vbShortDate)
 l_str = Len(t_str2)
 For i = 1 To l_str - 1
  t_num = t_num + Asc(Mid(t_str2, i, 1)) * Abs(days - 179)
 Next i
 t_num = t_num * 17 + Int(65429532 * (Rnd + 1))
 t_num = Abs(t_num)
 t_str = CStr(Int(days * (Rnd + 1))) & CStr(t_num) & "5448246594489"
 t_str = Mid(t_str, 1, 10)
 sec31_40 = t_str

 '���ܱ����ļ�����Ϣ,���� version.par ��,�������鱨վ���ͼƬ��д���Ǹ��ļ���,�ڴ�ֱ�Ӵ���
 Dim fn_v, mdn_p, ref As String
 Dim FILES_OK As Integer
 fn_v = App.Path & "\version.par"
 i = 1
 t_num = 0
 Do
   mdn_p = App.Path & "\" & ReadPar(fn_v, "ģ��" & i & "����", ":")
   If mdn_p = App.Path & "\" Then Exit Do
   mdn_p = Left(mdn_p, InStr(mdn_p, "-") - 1)
   t_num = t_num + Abs(Int(FileLen(mdn_p & ".exe") * 0.71337))
 i = i + 1
 Loop
 
 t_num = t_num + Abs(Int(FileLen(App.Path & "\kxqbz_ad.jpg")) * 0.47609)
 t_num = t_num + Abs(Int(FileLen(App.Path & "\hcrun.dll")))   '���ļ�û�ã���Ϊ�ƽ����õļ�Ŀ��
 t_num2 = t_num
 t_num = t_num * 31 + Int(1942753 * (0.10973 + 1))
 t_num = Abs(t_num)
 t_str = CStr(Int(t_num2 / 1103 * (0.37437 + 1))) & CStr(t_num) & "0845645698"
 t_str = Mid(t_str, 1, 10)
 sec41_50 = t_str
 ref = ReadPar(fn_v, "REF", ":")
 FILES_OK = 0
 If ref = sec41_50 Then FILES_OK = 1
 
 Licence_ID = sec1_20 & sec21_30 & sec31_40
'MsgBox l_id & vbcrlf & Licence_ID

CONTACT_INFO = CONTACT_INFO & vbCrLf & vbCrLf & "        ���ṩ��������:" & CUT_STR_INTO_n_WITH_DOT((CpuID), 4)

'����������
If l_id = 0 Then
 VERSION_INFO.Caption = "���ð汾"
 LICENCE_STATUS = 0
 atemp = MsgBox(vbCrLf & _
 "��ʾ: ������ HCAutoEdit ���Ű��������ڡ������鱨վ����վ�ϡ�    " & vbCrLf & _
 "�����������ǵĺ�����飬����ʹ�ñ����򡣻�ӭ����ѯ���ǵ�����" & vbCrLf & _
 "��̨֧��ϵͳ���Լ�ȫ��λ������DMҵ���רҵ�����ڴ����ļ��ˣ�  " & vbCrLf & vbCrLf & _
 "   * ͳһ�̱� ������Ӫ        * 5����ѧ����ӡ�����" & vbCrLf & _
 "   * ������� ���߷���        * 5�������ӡˢ�Ű棡" & vbCrLf & _
 "   * ������� ������ӡ        * ����ԭ������������" & vbCrLf & _
 "   * ����ƽ̨ ��Ч����        * �����鱨վ ���Ц�ſ�" & vbCrLf & _
 "   * �°빦�� �ɱ�����        * �����Ϣӡˢͬʱ����" & vbCrLf & vbCrLf & _
 "        ������֧�֣���һ���˾Ϳ��Կ�DM��湫˾��" & vbCrLf & _
 "                  ����ȫ�����غ������" & vbCrLf & _
 "              ���ɣ�������һ�𿪴�DM��ʱ����" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "     �����������й��ļ��������������Excel�ļ������رա�", 0 + 64, "�������鱨վ���Զ��Ű�ϵͳ")
 
 '�ر� Excel,������
  Application.Quit
  End
End If

If Not (l_id = Licence_ID And FILES_OK = 1) Then
 VERSION_INFO.Caption = "֤����Ч"
 LICENCE_STATUS = 5
 atemp = MsgBox(vbCrLf & "   ����: ֤����Ч" & vbCrLf & vbCrLf & "     ����ԭ��:" & vbCrLf & _
 "      (1) ֤���ļ� licence.txt ���޸�" & vbCrLf & _
 "      (2) ��δע��ļ����������" & vbCrLf & _
 "      (3) ��ͼ�ƽ��Ķ�����" & vbCrLf & _
 "      (4) �����Ƿ�ʹ��" & vbCrLf & vbCrLf & CONTACT_INFO & vbCrLf & vbCrLf & _
 "    �����������й��ļ��������������Excel�ļ������رա�   ", 0 + 48, "�������鱨վ���Զ��Ű�ϵͳ")
 '�ر� Excel,������
  Application.Quit
  End
End If

'ִ�е�����l_idһ������Licence_ID�������ܱ������ļ����
If Date > begin_day + days + 31 Then
 VERSION_INFO.Caption = "֤�����"
 LICENCE_STATUS = 4
 atemp = MsgBox(vbCrLf & "   ����: ֤�����ع���" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   ����֤���Ѿ����ܼ���ʹ�á�" & vbCrLf & vbCrLf & CONTACT_INFO & vbCrLf & vbCrLf & _
 "   �����������й��ļ��������������Excel�ļ������رա�   ", 0 + 48, "�������鱨վ���Զ��Ű�ϵͳ")
 '�ر� Excel,������
  Application.Quit
  End
End If

If Date > begin_day + days Then
 VERSION_INFO.Caption = "֤�����"
 LICENCE_STATUS = 3
 atemp = MsgBox(vbCrLf & "   ����: ֤���Ѿ�����" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   �������Գ���ʹ��" & (begin_day + days + 31) - Date & "�죬����������֤������������   ", 0 + 48, "�������鱨վ���Զ��Ű�ϵͳ")
 USER_AUTH.Caption = "��Ȩ" & usert & "ʹ��"
 Exit Sub
End If

If Date > begin_day + days - 31 Then
 VERSION_INFO.Caption = "ע��汾"
 LICENCE_STATUS = 2
 atemp = MsgBox(vbCrLf & "   ��ʾ: ֤�鼴������" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   ֤����Ч�ڻ���" & (begin_day + days) - Date & "�죬�뾡���������������", 0 + 64, "�������鱨վ���Զ��Ű�ϵͳ")
 USER_AUTH.Caption = "��Ȩ" & usert & "ʹ��"
 Exit Sub
End If

'ִ�е����һ����������ע��汾
 VERSION_INFO.Caption = "ע��汾"
 LICENCE_STATUS = 1
 USER_AUTH.Caption = "��Ȩ" & usert & "ʹ��"
End Sub


Function CUT_STR_INTO_n_WITH_DOT(S_str As String, n As Integer) As String
For i = 1 To Len(S_str)
  CUT_STR_INTO_n_WITH_DOT = CUT_STR_INTO_n_WITH_DOT & Mid(S_str, i, 1)
  If i Mod n = 0 And i <> Len(S_str) Then CUT_STR_INTO_n_WITH_DOT = CUT_STR_INTO_n_WITH_DOT & "."
Next i
End Function

Sub Define_Color()
Dark_Colors(1, 1) = 0
Dark_Colors(1, 2) = 0
Dark_Colors(1, 3) = 255

Dark_Colors(2, 1) = 127
Dark_Colors(2, 2) = 255
Dark_Colors(2, 3) = 0

Dark_Colors(3, 1) = 0
Dark_Colors(3, 2) = 196
Dark_Colors(3, 3) = 196

Dark_Colors(4, 1) = 255
Dark_Colors(4, 2) = 0
Dark_Colors(4, 3) = 0

Dark_Colors(5, 1) = 255
Dark_Colors(5, 2) = 0
Dark_Colors(5, 3) = 255

Dark_Colors(6, 1) = 232
Dark_Colors(6, 2) = 160
Dark_Colors(6, 3) = 0

Dark_Colors(7, 1) = 255
Dark_Colors(7, 2) = 255
Dark_Colors(7, 3) = 255

Dark_Colors(8, 1) = 0
Dark_Colors(8, 2) = 0
Dark_Colors(8, 3) = 0

Bright_Colors(1, 1) = 228
Bright_Colors(1, 2) = 228
Bright_Colors(1, 3) = 255
Bright_Colors(2, 1) = 228
Bright_Colors(2, 2) = 255
Bright_Colors(2, 3) = 228
Bright_Colors(3, 1) = 228
Bright_Colors(3, 2) = 255
Bright_Colors(3, 3) = 255
Bright_Colors(4, 1) = 255
Bright_Colors(4, 2) = 196
Bright_Colors(4, 3) = 128
Bright_Colors(5, 1) = 230
Bright_Colors(5, 2) = 128
Bright_Colors(5, 3) = 255
Bright_Colors(6, 1) = 255
Bright_Colors(6, 2) = 255
Bright_Colors(6, 3) = 100
Bright_Colors(7, 1) = 255
Bright_Colors(7, 2) = 255
Bright_Colors(7, 3) = 255
Bright_Colors(8, 1) = 127
Bright_Colors(8, 2) = 127
Bright_Colors(8, 3) = 127

End Sub


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


Sub Set_Range_Border()
'�߿�
    With Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    DoEvents
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = 15
    End With
End Sub

