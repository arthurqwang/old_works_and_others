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
   StartUpPosition =   2  '屏幕中心
End
Attribute VB_Name = "UserForm_Preface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'addbar.xls、 fontsize.xla 宏保护密码：kxqbzggxzk888daqing
'Version 2008 RN:20080108 2008-1-8:此版本主要改动：
'商业包装化：
'(1)加使用时间限制 ISSUE_NUM_CHANGE_CONTROL
'(2)LOGO图嵌在程序中，不能通过改图像文件就改软件图标
'(3)加本机使用限制，使用许可证
'(4)全部采用Vb6编程
'
'需要的引用:
'Visual Basic For Applications
'Microsoft Excel 11.0 Object Library    '这个要尽量在前面 publish出问题的原因是试用版本被锁定保护了
'Microsoft Access 11.0 Object Library
'Microsoft WMI Scripting V1.2 Library
'OLE Automation
'Micosoft Office 11.0 Object Library
'Micosoft ActiveX Data Objects 2.5 Library '也尽量往前
'Micosoft ActiveX Data Objects Recordset 2.5 Library
'Micosoft DAO 3.6 Object Library

'********************** 编程笔记 **************************
' 1)单元格换行只要使用 chr(10)，不用再加chr(13)。
' 2)连接数据库要在 "工具/引用/MicroSoft ActiveX Data Objects 2.5 和 MicroSoft DAO 3.6 Objects Library"
'********************* 编程笔记结束 ***********************

   '获得我的文档目录
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


Const SYSTEM_INFO_NAME = "《开心情报站》自动排版系统 - HCWeb V2008"
Const FONT_ADJ = 1  '标题行字体降低
Dim MY_DOC_PATH As String
Dim cellid As String    '单元格标号
Dim ROWNUM, COLNUM As Integer
Dim APP_BEGUN As Boolean
Dim FROM_FILE_NAME As String
Dim TO_FILE_NAME As String
Dim CURRENT_FROM_FILE_NAME, CURRENT_TO_FILE_NAME As String
Dim PRESS_ELSE_BUTTON As Boolean
Dim Dark_Colors(1 To 8, 1 To 3), Bright_Colors(1 To 8, 1 To 3) As Integer



'****************************************        开始                       *************************************************
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
Application.DisplayAlerts = False   '关掉excel的警告提示
Application.Visible = False
DoEvents
Application.Caption = SYSTEM_INFO_NAME   '设excel 窗口标题
DoEvents
'************* 根据配置文件,设置基本参数  ******为了本次排版生效,参数要在按开始键之后设,所以这部分不能在 窗口初始化时设
'*************************************************************************************************************************
FROM_FILE_NAME = FROM_FILE_NAME_i.Value
TO_FILE_NAME = TO_FILE_DIR_i.Value & "\temp_web.xls"
ShowPercents_Status 1, "初始化参数"
ShowPercents_Status 9, "临时保存"
Application.DisplayAlerts = False   '关掉excel的警告提示
DoEvents
Save_Web_Temp
ShowPercents_Status 21, "开始处理"
Application.DisplayAlerts = False   '关掉excel的警告提示
DoEvents
Create_Web_File    '处理并保存web版,存成xls和HTML
'拷贝0.asp到web版目录下
DoEvents
Copy_File_0_asp_To_Web_Dir
'关闭 Excel,不保存
Application.DisplayAlerts = False   '关掉excel的警告提示
BeginButton.Visible = False
StopButton.Visible = False

EndButton.Visible = True
EndButton.Default = True
EndButton.SetFocus
ShowPercents_Status 100, "处理完毕"
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
    sFilter = "开心情报站文件(Excel:*.xls)" & Chr(0) & "*.xls" & Chr(0)
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
    OpenFile.lpstrInitialDir = MY_DOC_PATH & "\《开心情报站》文档\出版稿"
    DoEvents
    OpenFile.lpstrTitle = "《开心情报站》- 请选择印刷版原文件"
    DoEvents
    OpenFile.flags = &H4   'OFN_NOREADONLYRETURN  去掉“以只读方式打开”
    DoEvents
    lReturn = GetOpenFileName(OpenFile)
    DoEvents
    If lReturn <> 0 Then
        temp = Trim(OpenFile.lpstrFile)
        FROM_FILE_NAME_i.Value = temp
        temp = Replace(temp, ".xls", "-web版.xls")
        temp = Left(temp, InStrRev(temp, "\")) & "web稿"
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
  stop_y_n = MsgBox("退出程序将中断Web排版！" & vbCrLf & "本程序和MS Excel 都将关闭，请保存相关文件。  " & vbCrLf & "确实要退出吗？", 1 + 256, "《开心情报站》自动排版系统")
  If stop_y_n = 1 Then
   '关闭 Excel,不保存
   Application.Quit
   End
  End If
Else
  '关闭 Excel,不保存
  Application.Quit
  End
End If
End Sub

Private Sub UserForm_Initialize()
 Get_My_Documents_Path   '获得我的文档目录
 Dim fn_temp As String
 'logo.Picture = LoadPicture(app.Path & "\k-logo2.jpg")
 UserForm_Preface.Caption = SYSTEM_INFO_NAME
 Application.DisplayAlerts = False   '关掉excel的警告提示
 DoEvents
 GET_LICENCE
 DoEvents
 '读最后一次排版信息lastinfo.par,这里保存着印刷版文件全路径名
 Dim temp As String
 Open App.Path & "\lastinfo.par" For Input As #10
 If Not EOF(10) Then  '因为刚装完的lastion.par还没有东西
    Input #10, temp
    temp = Replace(temp, "\自动排版\bin\..\..", "")
    FROM_FILE_NAME_i.Value = temp
    temp = Replace(temp, "\印刷稿\", "\web稿\")
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
'KILL_SELF_WHEN_VITAL_ERROR  '当发生严重错误时，完全退出程序 杀死Excel进程
'On Error GoTo 12345
Dim web_dir As String
'存中间稿，以备后面制作web版
'打开excel的警告提示,以防止覆盖旧出版稿文件
Application.DisplayAlerts = True
'打开印刷版文件
ShowPercents_Status 3, "打开源文件"
DoEvents
Workbooks.Open FROM_FILE_NAME
DoEvents
'创建web稿目录,如果按了 “其它”键选择的源文件，则web稿直接存在源文件相同目录下
'If PRESS_ELSE_BUTTON = False Then
'   web_dir = Left(TO_FILE_NAME, InStr(TO_FILE_NAME, "\web稿\") + 5)
'   Create_Dir web_dir
'End If
Create_Dir TO_FILE_DIR_i.Value
'存排版结果(web临时稿)
ShowPercents_Status 5, "存临时文件"
ActiveWorkbook.SaveAs FileName:=TO_FILE_NAME
DoEvents
WORKBOOKNAME = ActiveWorkbook.Name
UserForm_Preface.Repaint
DoEvents
End Sub

Sub Create_Web_File()
'KILL_SELF_WHEN_VITAL_ERROR  '当发生严重错误时，完全退出程序 杀死Excel进程
DoEvents
Workbooks.Open TO_FILE_NAME
ShowPercents_Status 22, "处理封面"
ShowPercents_Status 25, "处理内页"
Process_inner_pages
ShowPercents_Status 80, "处理封底"
ShowPercents_Status 82, "保存Web版"
ActiveWorkbook.Save
DoEvents
ShowPercents_Status 90, "保存HTML"
Save_HTML
DoEvents
ShowPercents_Status 90, "准备结束"
Application.DisplayAlerts = False   '关掉excel的警告提示
ActiveWorkbook.Close
DoEvents
End Sub

Sub Process_inner_pages()
'处理内页,把标题底色设为彩色的
Worksheets("内页").Activate
'获得使用过的行列数
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
 ShowPercents_Status 25 + CInt(55.01 * i / ROWNUM), "处理单元格:" & i & "/" & ROWNUM
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
'关闭窗口时处理方式等于按退出键
  Cancel = True  '此语句使得 UserForm 不被关闭
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
If Sheet_Exsists("封面") Then
    Sheets("封面").Select
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
        html_path & "1.htm", "封面", prnt_area, xlHtmlStatic, "", "")
        .Publish (True)
        .AutoRepublish = False
    End With
Else
     Open html_path & "1.htm" For Output As #101
     Print #101, ""
     Close #101
End If
    DoEvents
    
If Sheet_Exsists("内页") Then
    Sheets("内页").Select
    '解除试用版sheet口令，否则无法保存为html。虽然试用版不提供HCWeb功能，但考虑到转成加盟用户后应该改可以把原来的转存
    '取消密码后不必再设置了，因为能运行到这里，说明已经是加盟用户了，就不必设了
    s = "hgdasdfsdhgsdf6767327wefd76327ewg763retdwter5632723t326732632tuywtdwtuywte786723672332576tfjk"  '和HCAutoEdit一样的
    ActiveSheet.Unprotect Password:=s '取消保护  如果原来没有密码这样也不会出错

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
        html_path & "2.htm", "内页", prnt_area, xlHtmlStatic, "", "")
        .Publish (True)
        .AutoRepublish = False
    End With
Else
     Open html_path & "2.htm" For Output As #101
     Print #101, ""
     Close #101
End If
    DoEvents
    
If Sheet_Exsists("封底") Then
    Sheets("封底").Select
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
        html_path & "3.htm", "封底", prnt_area, xlHtmlStatic, "", "")
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

Function Sheet_Exsists(ByVal sheetname As String) As Boolean   '判断sheet是否存在，使用名字，如worksheets("内页")
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


Sub Copy_File_0_asp_To_Web_Dir()  '拷贝0.asp,同时删掉web版的xls文件,连同 count.txt
ShowPercents_Status 98, "拷贝0.asp"
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

Sub GET_LICENCE()  '****本Sub与HCAutoEdit中的不同，不可完全覆盖
'LICENCE_STATUS 和 VERSION_INFO.caption值：0试用版本；1注册版本；2注册版本,即将过期，提前一个月警告；
'3证书过期，但未超1个月，提示一个月续用期；4证书过期，超过1个月，提示联系方格，并按试用版对待；5证书无效，提示，结束程序
 On Error Resume Next
 Dim Licence_ID, l_id, CpuID, user, usert, sales, t_str, t_str2 As String
 Dim t0, t1, t2, t_num, t_num2  As Long
 Dim days, l_str As Integer
 Dim begin_day As Date
 Dim sec1_20, sec21_30, sec31_40, sec41_50 As String '分别存CPU、用户名、颁发日期和有效期 信息
 Dim CONTACT_INFO As Variant
 CONTACT_INFO = "   请联系大庆方格广告有限公司" & vbCrLf & _
                "        网址:www.kxqbz.com" & vbCrLf & _
                "        电话:0459-5514422 5773694 13644697987     " & vbCrLf & _
                "        QQ:5632147 492533636"
  
 '读licence.txt
 Open MY_DOC_PATH & "\《开心情报站》文档\使用许可证\licence.txt" For Input As #1
 '循环读到“**许可证信息**”
 Do
   Input #1, tempii
 Loop While tempii <> "**许可证信息**"
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
 If user = "方格临时许可的伙伴" Then CpuID = "0000000000000000"
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
 
 '用户名
'user = "ghgfrtrtffgfgcgfdgfdh"
user = user & sales
 l_str = Len(user)
 For i = 1 To l_str - 1
  t_num = t_num + Asc(Mid(user, i, 1))
 Next i
 t_num = t_num * 31 + Int(64725694 * (Rnd + 1))
 t_num = Abs(t_num)    '此行不能和上一行合并写，因为如果上一行溢出就不执行Abs()而直接转下一行了，就可能出现负数
 t_str = CStr(Int(31578 * (Rnd + 1))) & CStr(t_num) & "7546718635768"
 t_str = Mid(t_str, 4, 10)
 sec21_30 = t_str

 '有效期
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

 '读受保护文件的信息,列在 version.par 中,但开心情报站广告图片不写在那个文件中,在此直接处理
 Dim fn_v, mdn_p, ref As String
 Dim FILES_OK As Integer
 fn_v = App.Path & "\version.par"
 i = 1
 t_num = 0
 Do
   mdn_p = App.Path & "\" & ReadPar(fn_v, "模块" & i & "代码", ":")
   If mdn_p = App.Path & "\" Then Exit Do
   mdn_p = Left(mdn_p, InStr(mdn_p, "-") - 1)
   t_num = t_num + Abs(Int(FileLen(mdn_p & ".exe") * 0.71337))
 i = i + 1
 Loop
 
 t_num = t_num + Abs(Int(FileLen(App.Path & "\kxqbz_ad.jpg")) * 0.47609)
 t_num = t_num + Abs(Int(FileLen(App.Path & "\hcrun.dll")))   '此文件没用，是为破解设置的假目标
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

CONTACT_INFO = CONTACT_INFO & vbCrLf & vbCrLf & "        请提供本机代码:" & CUT_STR_INTO_n_WITH_DOT((CpuID), 4)

'处理各种情况
If l_id = 0 Then
 VERSION_INFO.Caption = "试用版本"
 LICENCE_STATUS = 0
 atemp = MsgBox(vbCrLf & _
 "提示: 本程序将 HCAutoEdit 的排版结果发布在《开心情报站》网站上。    " & vbCrLf & _
 "但您不是我们的合作伙伴，不能使用本程序。欢迎您咨询我们的网络" & vbCrLf & _
 "后台支持系统，以及全方位的面向DM业务的专业服务，期待您的加盟！  " & vbCrLf & vbCrLf & _
 "   * 统一商标 连锁经营        * 5分钟学会排印软件！" & vbCrLf & _
 "   * 加盟灵活 在线服务        * 5分钟完成印刷排版！" & vbCrLf & _
 "   * 软件优秀 智能排印        * 版面原样立即上网！" & vbCrLf & _
 "   * 网络平台 高效快速        * 开心情报站 广告笑着看" & vbCrLf & _
 "   * 事半功倍 成本低廉        * 广告信息印刷同时上网" & vbCrLf & vbCrLf & _
 "        有我们支持，您一个人就可以开DM广告公司！" & vbCrLf & _
 "                  诚招全国各地合作伙伴" & vbCrLf & _
 "              来吧，让我们一起开创DM新时代！" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "     请立即保存有关文件，本程序和所有Excel文件都将关闭。", 0 + 64, "《开心情报站》自动排版系统")
 
 '关闭 Excel,不保存
  Application.Quit
  End
End If

If Not (l_id = Licence_ID And FILES_OK = 1) Then
 VERSION_INFO.Caption = "证书无效"
 LICENCE_STATUS = 5
 atemp = MsgBox(vbCrLf & "   警告: 证书无效" & vbCrLf & vbCrLf & "     可能原因:" & vbCrLf & _
 "      (1) 证书文件 licence.txt 被修改" & vbCrLf & _
 "      (2) 在未注册的计算机上运行" & vbCrLf & _
 "      (3) 试图破解或改动程序" & vbCrLf & _
 "      (4) 其他非法使用" & vbCrLf & vbCrLf & CONTACT_INFO & vbCrLf & vbCrLf & _
 "    请立即保存有关文件，本程序和所有Excel文件都将关闭。   ", 0 + 48, "《开心情报站》自动排版系统")
 '关闭 Excel,不保存
  Application.Quit
  End
End If

'执行到这里l_id一定等于Licence_ID，并且受保护的文件完好
If Date > begin_day + days + 31 Then
 VERSION_INFO.Caption = "证书过期"
 LICENCE_STATUS = 4
 atemp = MsgBox(vbCrLf & "   警告: 证书严重过期" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   您的证书已经不能继续使用。" & vbCrLf & vbCrLf & CONTACT_INFO & vbCrLf & vbCrLf & _
 "   请立即保存有关文件，本程序和所有Excel文件都将关闭。   ", 0 + 48, "《开心情报站》自动排版系统")
 '关闭 Excel,不保存
  Application.Quit
  End
End If

If Date > begin_day + days Then
 VERSION_INFO.Caption = "证书过期"
 LICENCE_STATUS = 3
 atemp = MsgBox(vbCrLf & "   警告: 证书已经过期" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   您还可以超期使用" & (begin_day + days + 31) - Date & "天，请立即办理证书续用手续。   ", 0 + 48, "《开心情报站》自动排版系统")
 USER_AUTH.Caption = "授权" & usert & "使用"
 Exit Sub
End If

If Date > begin_day + days - 31 Then
 VERSION_INFO.Caption = "注册版本"
 LICENCE_STATUS = 2
 atemp = MsgBox(vbCrLf & "   提示: 证书即将过期" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   证书有效期还有" & (begin_day + days) - Date & "天，请尽快办理续用手续。", 0 + 64, "《开心情报站》自动排版系统")
 USER_AUTH.Caption = "授权" & usert & "使用"
 Exit Sub
End If

'执行到这里，一定是正常的注册版本
 VERSION_INFO.Caption = "注册版本"
 LICENCE_STATUS = 1
 USER_AUTH.Caption = "授权" & usert & "使用"
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
'获得我的文档目录
   Dim sTmp As String * MAX_LEN  '存放结果的固定长度的字符串
   Dim pidl As Long '某特殊目录在特殊目录列表中的位置
    
   '获得我的文档目录
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   MY_DOC_PATH = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   'MsgBox my_doc_path
End Sub


Sub Set_Range_Border()
'边框
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

