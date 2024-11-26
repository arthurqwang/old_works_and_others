VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm_Preface 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "开心情报站-数据库转换程序"
   ClientHeight    =   3690
   ClientLeft      =   30
   ClientTop       =   420
   ClientWidth     =   6870
   Icon            =   "UserForm_Preface3.dsx":0000
   MaxButton       =   0   'False
   OleObjectBlob   =   "UserForm_Preface3.dsx":0CCA
   StartUpPosition =   1  '所有者中心
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
'Microsoft Excel 11.0 Object Library  '这个要尽量在前面
'Microsoft Access 11.0 Object Library
'Microsoft WMI Scripting V1.2 Library
'OLE Automation
'Micosoft Office 11.0 Object Library
'Micosoft ActiveX Data Objects 2.8 Library
'Micosoft ActiveX Data Objects Recordset 2.8 Library
'Micosoft DAO 3.6 Object Library


'获得我的文档目录
   Private Declare Function SHGetSpecialFolderLocation Lib "Shell32" (ByVal hwndOwner As Long, ByVal nFolder As Integer, ppidl As Long) As Long
   Private Declare Function SHGetPathFromIDList Lib "Shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal szPath As String) As Long
   Const MAX_LEN = 200 '字符串最大长度
   Const MYDOCUMENTS = &H5& '我的文档


Const SYSTEM_INFO_NAME = "《开心情报站》自动排版系统 - DBTrans V2008"
Dim MY_DOC_PATH As String
Dim conn As New ADODB.Connection
Dim cmd As New ADODB.Command
Dim Rs As New ADODB.Recordset
Dim DSN_NAME, SORTSTR As String
Dim TB_Name As String
Dim I, J    As Long
Dim MyApp   As Excel.Application
Dim MyBook, DBTransBook  As Excel.Workbook
Dim MySheet As Excel.Worksheet

'========================================================
'Excel对象的使用(将Access中的数据导入到一个新建的Excel文件中)
'========================================================
Private Sub TransDB()
Application.DisplayAlerts = False   '关掉excel的警告提示

Set DBTransBook = ActiveWorkbook

'广告表

Workbooks.Add
Set MyBook = ActiveWorkbook
UserForm_Preface.Repaint

DSN_NAME = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _
MY_DOC_PATH & "\《开心情报站》文档\database\adsdb.mdb;User ID=admin;Password=;Jet OLEDB:Database Password=1"
n = 0
conn.Open DSN_NAME
Set cmd.ActiveConnection = conn
TB_Name = ""
Get_TB_Name
TBN = Split(TB_Name, ",")

Do While TBN(n) <> "{END}"
Select Case TBN(n)
Case "ads_publish"
  SORTSTR = " order by id"
Case "free_ads"
  SORTSTR = " order by id"
Case "p_free_info"
  SORTSTR = " order by p_id"
Case "types"
  SORTSTR = " order by t_id"
Case Else
  SORTSTR = ""
End Select


cmd.CommandText = "select * from " & TBN(n) & SORTSTR
Rs.CursorLocation = adUseClient
Rs.Open cmd
Set MySheet = MyBook.Sheets.Add(after:=MyBook.Sheets(MyBook.Sheets.Count))
MySheet.Name = TBN(n)

J = 1
     For I = 1 To Rs.Fields.Count
             MySheet.Cells(J, I) = Rs.Fields(I - 1).Name
     Next
J = J + 1

Do Until Rs.EOF
     For I = 1 To Rs.Fields.Count
             MySheet.Cells(J, I) = Rs.Fields(I - 1)
     Next
     Rs.MoveNext
     J = J + 1
     UserForm_Preface.Repaint
Loop
Columns("A:Z").Select
Selection.Columns.AutoFit
For I = 1 To Rs.Fields.Count
  If Columns(Chr(64 + I)).ColumnWidth > 50 Then Columns(Chr(64 + I)).ColumnWidth = 50
Next
Columns("A:Z").Select
Selection.Rows.AutoFit
Range("A2").Select
Rs.Close
Set Rs = Nothing
n = n + 1
Loop
conn.Close
Set conn = Nothing

MyBook.Sheets("Sheet1").Delete
MyBook.Sheets("Sheet2").Delete
MyBook.Sheets("Sheet3").Delete
MyBook.SaveAs MY_DOC_PATH & "\《开心情报站》文档\database\adsdb.xls"

'趣味材料表
Workbooks.Add
Set MyBook = ActiveWorkbook
UserForm_Preface.Repaint

DSN_NAME = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _
MY_DOC_PATH & "\《开心情报站》文档\database\funsdb.mdb;User ID=admin;Password=;Jet OLEDB:Database Password=1"
n = 0
conn.Open DSN_NAME
Set cmd.ActiveConnection = conn
TB_Name = ""
Get_TB_Name
TBN = Split(TB_Name, ",")

Do While TBN(n) <> "{END}"
Select Case TBN(n)
Case "jokes"
  SORTSTR = " order by j_id"
Case "puzzles"
  SORTSTR = " order by p_id"
Case Else
  SORTSTR = ""
End Select
cmd.CommandText = "select * from " & TBN(n) & SORTSTR
Rs.CursorLocation = adUseClient
Rs.Open cmd
Set MySheet = MyBook.Sheets.Add(after:=MyBook.Sheets(MyBook.Sheets.Count))
MySheet.Name = TBN(n)

J = 1
     For I = 1 To Rs.Fields.Count
             MySheet.Cells(J, I) = Rs.Fields(I - 1).Name
     Next
J = J + 1

Do Until Rs.EOF
     For I = 1 To Rs.Fields.Count
             MySheet.Cells(J, I) = Rs.Fields(I - 1)
     Next
     Rs.MoveNext
     J = J + 1
     UserForm_Preface.Repaint
Loop
Columns("A:Z").Select
Selection.Columns.AutoFit
For I = 1 To Rs.Fields.Count
  If Columns(Chr(64 + I)).ColumnWidth > 50 Then Columns(Chr(64 + I)).ColumnWidth = 50
Next
Columns("A:Z").Select
Selection.Rows.AutoFit
Range("A2").Select
Rs.Close
Set Rs = Nothing
n = n + 1
Loop
conn.Close
Set conn = Nothing

MyBook.Sheets("Sheet1").Delete
MyBook.Sheets("Sheet2").Delete
MyBook.Sheets("Sheet3").Delete
MyBook.SaveAs MY_DOC_PATH & "\《开心情报站》文档\database\funsdb.xls"

'MyApp.Quit
Set MyApp = Nothing
UserForm_Preface.Repaint
End Sub

Private Sub Begin_Button_Click()
 Label4.Caption = "  正在转换，所需时间由数据量决定。一般需要1-2分钟，请等待..."
 Begin_Button.Enabled = False

 UserForm_Preface.Repaint
 TransDB
 Label4.Caption = "  完成。adsdb.xls为广告数据库，funs.xls为趣味材料数据库"
 Begin_Button.Default = False
 Begin_Button.Visible = False
 End_Button.Default = True
 End_Button.Visible = True
 End_Button.Enabled = True
 End_Button.SetFocus
 UserForm_Preface.Repaint
End Sub

Private Sub End_Button_Click()
 Application.DisplayAlerts = False   '关掉excel的警告提示
 Application.Visible = True
 End
End Sub

Private Sub Get_TB_Name()
Dim rstSchema
Set rstSchema = conn.OpenSchema(adSchemaTables)
Do Until rstSchema.EOF
 'out = out & "Table     name:     " & rstSchema!TABLE_NAME & vbCr & "Table     type:     " & rstSchema!TABLE_TYPE & vbCr
 If UCase(rstSchema!TABLE_TYPE) = "TABLE" Then TB_Name = TB_Name & rstSchema!TABLE_NAME & ","
 rstSchema.MoveNext
Loop
rstSchema.Close
TB_Name = TB_Name & "{END}"
End Sub

Private Sub UserForm_Initialize()
 Dim fn_temp As String
 UserForm_Preface.Caption = SYSTEM_INFO_NAME
 Application.Visible = False
 Application.DisplayAlerts = False   '关掉excel的警告提示
  'Release No.
 fn_temp = App.Path & "\version.par"
 DoEvents
 RN.Caption = "RN: " & ReadPar(fn_temp, "RN", ":")
 Get_My_Documents_Path
 DoEvents
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
