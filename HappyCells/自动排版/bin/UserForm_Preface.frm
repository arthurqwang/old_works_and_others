VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm_Preface 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "UserForm1"
   ClientHeight    =   7350
   ClientLeft      =   30
   ClientTop       =   315
   ClientWidth     =   7875
   Icon            =   "UserForm_Preface.dsx":0000
   MaxButton       =   0   'False
   OleObjectBlob   =   "UserForm_Preface.dsx":0CCA
   StartUpPosition =   2  '屏幕中心
End
Attribute VB_Name = "UserForm_Preface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'addbar.xls、 fontsize.xla 宏保护密码：kxqbzggxzk888daqing
'Version 2008 RN:20080108  2008-1-8:此版本主要改动：
'
'需要的引用:
'Visual Basic For Applications
'Microsoft Excel 11.0 Object Library
'Microsoft Access 11.0 Object Library
'Microsoft WMI Scripting V1.2 Library
'OLE Automation
'Micosoft Office 11.0 Object Library
'Micosoft ActiveX Data Objects 2.5 Library  '尽量排在前面，否则可能出错
'Micosoft ActiveX Data Objects Recordset 2.5 Library  '尽量排在前面，否则可能出错
'Micosoft DAO 3.6 Object Library
   
     
Const SYSTEM_INFO_NAME = "《开心情报站》自动排版系统 - HCAutoEdit V2008"

Dim WithEvents xlapp As Application   '为了检测到 Excel的事件
Attribute xlapp.VB_VarHelpID = -1
Dim WithEvents Obj_Active_Workbook As Workbook
Attribute Obj_Active_Workbook.VB_VarHelpID = -1



'****************************************          排版开始                 *************************************************
'*******************************************                       **********************************************************
'******************************************                     *************************************************************
'****************************************************************************************************************************
'****************************************************************************************************************************

Public Sub BeginButton_Click()

On Error GoTo ErrHandler:

BeginButton.Enabled = False
OTHER_CFG.Enabled = False
LAST_PARAMETER.Enabled = False
RESTORE_PARAMETER.Enabled = False
SAVE_PARAMETER.Enabled = False
EDIT_DB_BUTTON.Enabled = False
Tip_Frame.Visible = True
TIPS_TIME = Timer()
TIPS_NUM = CInt(ReadPar(App.Path & "\tips.par", "总数", "="))  '提示贴的个数
BEGIN_TIP_NUM = CInt(Second(Time)) Mod TIPS_NUM + 1
GLOBAL_PARAS_CONFIG
ReDim ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM_PAGE / 2 + 1)
SET_DSN_NAME ("adsdb")
Get_Total_Ads_Num_Rouphly
Get_Type_Num
If MIX_CLASS = 1 Then AD_TYPENUM = 1 '混类，在Put_All_Ads()中也要处理

If TEST_i.Value = True Then
   Check_Page_Num
   Exit Sub
Else
 If Final_Checked <> True Then
   Final_Check_Page_Num
   Final_Checked = True
   BeginButton_Click
   Exit Sub
 End If
End If

Set xlapp = Application
xlapp.EnableEvents = True   '不允许使用同一个Excel进程打开其他excel文件，因为会乱，和 Sub xlapp_WorkbookOpen()，自动起另一个Excel进程
xlapp.DisplayAlerts = False   '关掉excel的警告提示

If BACK_RUN = 1 Then
  xlapp.Visible = False  '不让它可见
Else
  xlapp.Interactive = False   '使它不可操作，免得人干扰拍板
  xlapp.Visible = True  '让它可见
  xlapp.WindowState = xlMaximized
  xlapp.DisplayFullScreen = True '全屏
End If
xlapp.DisplayAlerts = False   '关掉excel的警告提示
xlapp.Caption = SYSTEM_INFO_NAME   '设excel 窗口标题
DoEvents
APP_BEGUN = True
DoEvents
Dim col_str As String       '临时列变量，用于计算cell号码,为了减少函数调用次数，加快速度,提前装入变量
Dim title_color As Integer
START_T = Now()
Randomize Int(ISSUE_NUM)
DoEvents

'创建一个新工作簿,空的,这样做的目的是:生成出版稿中不包含本 VBA 程序代码,而只是一般的xls文件
Workbooks.Add
xlapp.EnableEvents = True   '允许excel程序检测它的事件，为了在打开其他xls文件时不合排版文件占用一个进程，以免窜排
Set Obj_Active_Workbook = ActiveWorkbook
sn = Worksheets.Count   '删掉多余sheets
Do While sn > 1
  Sheets(sn).Delete
  sn = sn - 1
Loop
Sheets("Sheet1").Name = "内页"
Sheets("内页").Select
DoEvents
WORKBOOKNAME = ActiveWorkbook.Name
DoEvents
App.TaskVisible = True
DoEvents
UserForm_Preface.SetFocus  '让本form在excel 上面，可以见到进度
DoEvents
PROCESS_PERCENTS = 0
ShowPercents_Status PROCESS_PERCENTS, "读取排版参数"

cellid = "A1:" + COLSTR(COLNUM) + "1"
'列宽、垂直居中
ActiveSheet.Range(cellid).ColumnWidth = COLW
DoEvents
ActiveSheet.Range(cellid).VerticalAlignment = xlCenter
DoEvents

If TRANSP_LINE = 0 Then    '如果边框不透明
    Cell_Border_Line_Style = xlDouble
    Cell_Border_Line_Width = xlThick
    If CELL_BORDER_TYPE = 0 Then
      Cell_Border_Line_Style = xlContinuous
      Cell_Border_Line_Width = xlThin
    End If
End If
PROCESS_PERCENTS = 1
Put_Logo_When_No_Front_Cover
WRITING_FIRST_ADS = True
For AD_TYPE = 1 To AD_TYPENUM
  DoEvents
  If Have_Ads_This_Type(CInt(AD_TYPE)) Then
    Put_All_Ads CInt(AD_TYPE)
  Else
    NO_AD_TYPENUM = NO_AD_TYPENUM + 1
  End If
Next AD_TYPE
Put_Personal_Free_Info
Format_Final_Cells

SET_DSN_NAME ("funsdb")
Put_Puzzles
BEGIN_ROWNUM_THIS_TYPE = 1
Put_Jokes
Cut_Page
Set_Head_Foot
If LICENCE_STATUS = 0 Or LICENCE_STATUS = 4 Then Lock_My_Ad
ActiveSheet.Range(COLSTR(COLNUM + 1) + "1").Select
If FRONT_COVER_PAGE_NUM > 0 Then
  Put_Front_Cover
  Worksheets("封面").Activate
  DoEvents
  ActiveSheet.DisplayAutomaticPageBreaks = True
End If

If BACK_COVER_PAGE_NUM > 0 Then
  Put_Back_Cover
  Worksheets("封底").Activate
  DoEvents
  ActiveSheet.DisplayAutomaticPageBreaks = True
End If
DoEvents
Worksheets("内页").Activate
ActiveSheet.DisplayAutomaticPageBreaks = True
DoEvents
ShowPercents_Status 97, "处理存盘信息..."
Save_All '保存印刷版全部文件
ShowPercents_Status 100, "完毕,等待手动调整..."
End_Show
xlapp.DisplayAlerts = False   '关掉excel的警告提示

GoTo END_SUB:
ErrHandler: ErrProc "主过程错误 - BeginButton_Click"
END_SUB:
'*********************************************************       排版到此结束         *********************************************
'**********************************************************************************************************************************
End Sub

Sub OPEN_JOKES_DB(Mode As Integer)   'mode=1 长笑话优先
'Debug.Print "OPEN DB"
    SET_DSN_NAME ("funsdb")
    sql_t = ""
    If Mode = 1 Then sql_t = ",len(j_content) desc"
    conn_jokes.Open DSN_NAME
    SQL_Str = "select * from " & L_s & "jokes" & R_s & " order by j_pri desc" & str_t
    rs_jokes.Open SQL_Str, conn_jokes, 2, 2
 End Sub

Sub CLOSE_JOKES_DB()
    rs_jokes.Close
    conn_jokes.Close
End Sub

Sub GLOBAL_PARAS_CONFIG()
'配置全程参数，主要是排版参数
    On Error GoTo ErrHandler:
    Dim fn_temp As String
    fn_temp = App.Path & "\runtime.par"
    JOKE_IN_INTEREST = CSng(ReadPar(fn_temp, "JOKE_IN_INTEREST", "="))
    If JOKE_IN_INTEREST < 0 Then JOKE_IN_INTEREST = 0
    PUZZLE_IN_INTEREST = CSng(ReadPar(fn_temp, "PUZZLE_IN_INTEREST", "="))
    If PUZZLE_IN_INTEREST < 0 Then PUZZLE_IN_INTEREST = 0
    ELSE_IN_INTEREST = CSng(ReadPar(fn_temp, "ELSE_IN_INTEREST", "="))
    If ELSE_IN_INTEREST < 0 Then ELSE_IN_INTEREST = 0
    mm2POINT = CSng(ReadPar(fn_temp, "mm2POINT", "="))
    mm2COLUMN_UNIT = CSng(ReadPar(fn_temp, "mm2COLUMN_UNIT", "="))
    COLUMN_UNIT2PIXEL = CSng(ReadPar(fn_temp, "COLUMN_UNIT2PIXEL", "="))
    WEB_TITLE_MAX_FONT_SIZE = CInt(ReadPar(fn_temp, "WEB_TITLE_MAX_FONT_SIZE", "="))
    MAX_LEN_PER_CELL = CInt(ReadPar(fn_temp, "MAX_LEN_PER_CELL", "="))
    MODE_2_LEN = CInt(ReadPar(fn_temp, "MODE_2_LEN", "="))
    PIC_LEFT = CInt(ReadPar(fn_temp, "PIC_LEFT", "="))
    PIC_TOP = CInt(ReadPar(fn_temp, "PIC_TOP", "="))
    PIC_RIGHT = CInt(ReadPar(fn_temp, "PIC_RIGHT", "="))
    PIC_BOTTOM = CInt(ReadPar(fn_temp, "PIC_BOTTOM", "="))
    CELL_BORDER_TYPE = CInt(ReadPar(fn_temp, "CELL_BORDER_TYPE", "="))
    'ISSUE_DAY_AFTER = CInt(ReadPar(fn_temp, "ISSUE_DAY_AFTER", "="))  这两个应在初始化时读入
    'ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) '印刷延误天数，runtime.par文件中，列为 mm2ROW_UNIT,要混在mm2POINT附近，用带小数点的数
    TOPIC_WHITE_BLACK = CInt(ReadPar(fn_temp, "TOPIC_WHITE_BLACK", "="))
    TOPIC_FONT_NAME1 = ReadPar(fn_temp, "TOPIC_FONT_NAME1", "=")
    TOPIC_FONT_NAME2 = ReadPar(fn_temp, "TOPIC_FONT_NAME2", "=")
    CLASS_FONT_NAME = ReadPar(fn_temp, "CLASS_FONT_NAME", "=")
    USE_CLASS_PIC = CInt(ReadPar(fn_temp, "USE_CLASS_PIC", "="))
    TRANSP_LINE = CInt(ReadPar(fn_temp, "TRANSP_LINE", "="))
    MIX_CLASS = CInt(ReadPar(fn_temp, "MIX_CLASS", "="))
    BOUND_MIX_CLASS = CInt(ReadPar(fn_temp, "BOUND_MIX_CLASS", "="))
    KEEP_WHOLE_SIZE = CInt(ReadPar(fn_temp, "KEEP_WHOLE_SIZE", "="))
    BACK_RUN = CInt(ReadPar(fn_temp, "BACK_RUN", "="))
    NO_CLASS_TITLE = CInt(ReadPar(fn_temp, "NO_CLASS_TITLE", "="))
    OUTSIDE_CLASS_TITLE = CInt(ReadPar(fn_temp, "OUTSIDE_CLASS_TITLE", "="))
    'TIPS_YES = CInt(ReadPar(fn_temp, "TIPS_YES", "="))   应在初始化时读入
    If TRANSP_LINE = 1 Then
        PIC_LEFT = 0
        PIC_TOP = 0
        PIC_RIGHT = 0
        PIC_BOTTOM = 0
    End If

    
    '************* 根据配置文件,设置基本参数  ******为了本次排版生效,参数要在按开始键之后设,所以这部分不能在 窗口初始化时设
    '*************************************************************************************************************************
    PAGE_H_mm = CSng(PAGE_H_mm_i.Value)         '版心高度 毫米,即全部印刷内容(包括页眉页脚)所占据的纸面高度
    PAGE_W_mm = CSng(PAGE_W_mm_i.Value)         '版心宽度 毫米,即全部印刷内容所占据的纸面宽度
    COMPAGESNUM = CSng(COMPAGESNUM_i.Value)     '每张纸双面印几版，每期刊物的总版数是该数目的整数倍
    BORDERM = CSng(BORDERM_i.Value)  '边白尺寸(不完全与Excel中的边距一样) 毫米，即纸张四边到版心外边的距离，印刷设备要求的，太小印不上
    TOPM = BORDERM                   '顶白(Excel中称为页眉位置) 毫米，即从实际纸张顶端向下几毫米的空白，对应BOTTOMM
    BOTTOMM = BORDERM                '底白(Excel中称为页脚位置) 毫米，即从实际纸张底端向上几毫米的空白，对应HAEDH
    LEFTW = BORDERM                  '左白(与Excel中左边距完全相同) 毫米，即从实际纸张左端向右几毫米的空白
    RIGHTW = BORDERM                 '右白(与Excel中右边距完全相同) 毫米，即从实际纸张右端向左几毫米的空白
    HEADH = CSng(HEADH_i.Value)      '页眉高度(不同于Excel中的上边距，因为不包括页眉位置的值) 毫米，即版心顶端到第一行广告顶端的高度，本程序设定的页眉需要14mm
    FOOTH = CSng(FOOTH_i.Value)      '页脚高度(不同于Excel中的下边距，因为不包括页脚位置的值) 毫米，即版心底端到最底行广告底端的高度，本程序设定的页脚需要13mm
    '*********************************************
    ROWH = (CSng(ROWH_i.Value) - 0.02) * mm2POINT '单位EXCEL 磅，缩小一点点，免得出界
    ROWH1 = ROWH / 4         '标题行高度,单位EXCEL 磅
    If ROWH1 > 400 Then ROWH1 = 400 'excel允许最大409.5
    ROWH2 = ROWH - ROWH1         '内容行高度
    If ROWH2 > 400 Then ROWH2 = 400 'excel允许最大409.5
    COLW = CSng(COLW_i.Value)          '每个单元格宽度,毫米
    COLW = COLW * mm2COLUMN_UNIT       '由毫米转成excel列单位
    MAX_FONT_SIZE = CInt(MAX_FONT_SIZE_i.Value)    '内容格中可取的最大字号
    MIN_FONT_SIZE = CInt(MIN_FONT_SIZE_i.Value)     '内容格中可取的最小字号
    FONT_SIZE_ADJUST = CInt(FONT_SIZE_ADJUST_i.Value)     '所有内容格中字体总体加大几号，或减小几号
    PERSONAL_FREE_INFO_ROWS = CInt(PERSONAL_FREE_INFO_ROWS_i.Value)
    PERSONAL_FREE_INFO_COLS = CInt(PERSONAL_FREE_INFO_COLS_i.Value)
    COLNUM = Int(COLNUM_i.Value)    '每版总列数
    ROWNUM_PAGE = Int(ROWNUM_i.Value) * 2
    TOTAL_INTEREST_PERCENTS = CSng(TOTAL_INTEREST_PERCENTS_i.Value)
    If TOTAL_INTEREST_PERCENTS < 0 Then TOTAL_INTEREST_PERCENTS = 0
    JOKE_PERCENTS = TOTAL_INTEREST_PERCENT * JOKE_IN_INTEREST / 100
    If JOKE_PERCENTS < 0 Then JOKE_PERCENTS = 0
    PUZZLE_PERCENTS = TOTAL_INTEREST_PERCENT * PUZZLE_IN_INTEREST / 100
    If PUZZLE_PERCENTS < 0 Then PUZZLE_PERCENTS = 0
    ELSE_PERCENTS = TOTAL_INTEREST_PERCENT * ELSE_IN_INTEREST / 100
    If ELSE_PERCENTS < 0 Then ELSE_PERCENTS = 0
    'ISSUE_DAY_AFTER = CInt(ISSUE_DAY_AFTER_i.Value)   '在初始化时执行
    ISSUE_DATE_CHR = ISSUE_DATE_i.Value
    ISSUE_NUM = ISSUE_NUM_i.Value      '1 '期号
    TOTAL_ISSUE_NUM = TOTAL_ISSUE_NUM_i.Value  '总期号
    FRONT_COVER_PAGE_NUM = CInt(FRONT_COVER_PAGE_NUM_i.Value)
    BACK_COVER_PAGE_NUM = CInt(BACK_COVER_PAGE_NUM_i.Value)
    If BACK_COVER_PAGE_NUM < 0 Then BACK_COVER_PAGE_NUM = 0
    IS_EXCEL = False
    If DB_OPTION1_i.Value = False Then IS_EXCEL = True
    INSERTING_COLNUM = 0
    INSERTING_ROWNUM = 0
    FROM_LEFT_TO_RIGHT = 0
    MAX_LEN_PER_CELL = Int(MAX_LEN_PER_CELL * (ROWH * COLW) / (32 * 28 * mm2POINT * mm2COLUMN_UNIT)) '写笑话每单个格最多字数，格大了，这个数也变大,原格32*28
    If MAX_LEN_PER_CELL < 40 Then MAX_LEN_PER_CELL = 40     '不能太小，因为太小的话，当版面只剩下单个格时就找不到合适的笑话放了，很少有笑话这么短，结果会造成死循环，谜语也会1个谜语1个答案
    '**********************************************************************************************************
    '**********  配置基本参数完毕  ****************************************************************************
    BEGIN_ROWNUM_THIS_TYPE = 0
    BEGIN_ROWNUM_THIS_TYPE = 1   '没错，需要等于1
    ROWNUM = 0
    END_ROWNUM_THIS_TYPE = 0
    END_ROWNUM_LAST_TYPE = 0
    TOTAL_ADS_CELLS = 0
    TOTAL_ADS_NUM = 0
    TOTAL_ADS_NUM_ROUPH = 0
    TOTAL_ADS_CELLS_THIS_TYPE = 0
    TOTAL_ADS_NUM_THIS_TYPE = 0
    TOTAL_CELLS = 0
    TOTAL_CELLS_TOUCHED = 0
    BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = 0
    INSERTING_COLNUM = 0
    INSERTING_ROWNUM = 0
    INCOME = 0
    PROCESS_PERCENTS = 0
    PIC_NUM = 0
    '********************************************************************************************************
    '读其他参数:联系电话 短信手机号 银行帐号
     Dim tempii As String
     Open App.Path & "\other-cfg.par" For Input As #1
     Input #1, tempii
     COMPANYINFO = Replace(tempii, "^|", Chr(10))
     Input #1, tempii
     HOTLINE = tempii
     Input #1, tempii
     CELLPHONE = tempii
     Input #1, tempii
     YOURLOGOPATH = tempii
     If UCase(YOURLOGOPATH) = "YOURLOGO.JPG" Then YOURLOGOPATH = App.Path & "\" & YOURLOGOPATH
     Input #1, tempii
     BANKCARD = tempii
     Close #1
     DoEvents
     GoTo END_SUB:
ErrHandler: ErrProc "获取参数错误 - GLOBAL_PARAS_CONFIG"
END_SUB:

End Sub


Function Clen(ByVal str As String) As Integer
'计算字串的长度,以英文字母计算,一个汉字算作2个长度,西文不等宽，一个西文按1.3计，所以最后返回的结果不是实际英文字符个数，而是显示宽度，单位是半个汉字
Dim i, L As Integer
Dim W As Single
L = Len(str)
For i = 1 To L
If Mid(str, i, 1) > Chr(127) Then
  W = W + 2
Else
  W = W + 1.3
End If
Next i
Clen = CInt(W)
End Function


Public Sub EDIT_DB_BUTTON_Click()
Dim stop_y_n
stop_y_n = MsgBox("手动编辑容易造成数据库混乱！" & vbCrLf & "开始自动排版之前务必关闭数据库。 " & vbCrLf & "确实要编辑吗？", 1 + 256, "《开心情报站》自动排版系统")
If stop_y_n <> 1 Then Exit Sub

If DB_OPTION1_i.Value = True Then
 ShellExecute 1, "Open", MY_DOC_PATH & "\《开心情报站》文档\database\funsdb.mdb", "", "", 1  'SW_SHOWNORMAL 不好使
 ShellExecute 2, "Open", MY_DOC_PATH & "\《开心情报站》文档\database\adsdb.mdb", "", "", 1
 'Shell "msaccess.exe " & Left(App.Path, InStr(App.Path, "\bin")) & "database\adsdb.mdb", vbNormalFocus  'Windows系统文件可用shell
Else
 ShellExecute 3, "Open", MY_DOC_PATH & "\《开心情报站》文档\database\funsdb.xls", "", "", 1   'SW_SHOWNORMAL
 ShellExecute 4, "Open", MY_DOC_PATH & "\《开心情报站》文档\database\adsdb.xls", "", "", 1   'SW_SHOWNORMAL
End If
k = 5
m = 6
L = CStr(k * m)
End Sub

Public Sub FinishButton_Click()

'关闭excel的警告提示
xlapp.DisplayAlerts = False
'关闭 HCAutoEdit.xls,不保存,不关Excel
'Windows("HCAutoEdit.xls").Activate
'ActiveWorkbook.Close
xlapp.WindowState = xlMaximized
xlapp.Interactive = True   '使它可操作，人手动编辑
xlapp.DisplayFullScreen = False
xlapp.Visible = True
End
End Sub



Private Sub COMPAGESNUM_i_AfterUpdate()
  COMPAGESNUM_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub FONT_SIZE_ADJUST_i_AfterUpdate()
  FONT_SIZE_ADJUST_i.ForeColor = RGB(255, 0, 0)
End Sub
Private Sub FRONT_COVER_PAGE_NUM_CHANGE_i_SpinUp()
 FRONT_COVER_PAGE_NUM_i.Value = CInt(FRONT_COVER_PAGE_NUM_i.Value) + 1
 FRONT_COVER_PAGE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub
Private Sub FRONT_COVER_PAGE_NUM_CHANGE_i_SpinDown()
 If CInt(FRONT_COVER_PAGE_NUM_i.Value) > 0 Then FRONT_COVER_PAGE_NUM_i.Value = CInt(FRONT_COVER_PAGE_NUM_i.Value) - 1
 FRONT_COVER_PAGE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub
Private Sub BACK_COVER_PAGE_NUM_CHANGE_i_SpinUp()
 BACK_COVER_PAGE_NUM_i.Value = CInt(BACK_COVER_PAGE_NUM_i.Value) + 1
 BACK_COVER_PAGE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub
Private Sub BACK_COVER_PAGE_NUM_CHANGE_i_SpinDown()
 If CInt(BACK_COVER_PAGE_NUM_i.Value) > 0 Then BACK_COVER_PAGE_NUM_i.Value = CInt(BACK_COVER_PAGE_NUM_i.Value) - 1
 BACK_COVER_PAGE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub
Private Sub FRONT_COVER_PAGE_NUM_i_AfterUpdate()
  FRONT_COVER_PAGE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub BACK_COVER_PAGE_NUM_i_AfterUpdate()
  BACK_COVER_PAGE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub ISSUE_DATE_CHANGE_i_SpinDown()
 issue_date = issue_date - 1
 Dim WK As Variant
 WK = Array("", "日", "一", "二", "三", "四", "五", "六") '空字串为了适应 Weekday函数
 ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "年" + CStr(Month(issue_date)) + "月" + CStr(Day(issue_date)) + "日" + " 星期" + CStr(WK(Weekday(issue_date)))
 ISSUE_DATE_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub ISSUE_DATE_CHANGE_i_SpinUp()
 issue_date = issue_date + 1
 If issue_date > Date + ISSUE_NUM_CHANGE_CONTROL_days Then issue_date = Date + ISSUE_NUM_CHANGE_CONTROL_days
 Dim WK As Variant
 WK = Array("", "日", "一", "二", "三", "四", "五", "六") '空字串为了适应 Weekday函数
 ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "年" + CStr(Month(issue_date)) + "月" + CStr(Day(issue_date)) + "日" + " 星期" + CStr(WK(Weekday(issue_date)))
 ISSUE_DATE_i.ForeColor = RGB(255, 0, 0)
End Sub


Private Sub ISSUE_DATE_i_AfterUpdate()
  ISSUE_DATE_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub ISSUE_NUM_CHANGE_i_SpinDown()
  If ISSUE_NUM_i.Value > 1 Then
    ISSUE_NUM_i.Value = ISSUE_NUM_i.Value - 1
    TOTAL_ISSUE_NUM_i.Value = TOTAL_ISSUE_NUM_i.Value - 1
    ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
    TOTAL_ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
  End If
End Sub

Public Sub ISSUE_NUM_CHANGE_i_SpinUp()
  ISSUE_NUM_i.Value = ISSUE_NUM_i.Value + 1
  TOTAL_ISSUE_NUM_i.Value = TOTAL_ISSUE_NUM_i.Value + 1
  ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
  TOTAL_ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub


Private Sub ISSUE_NUM_i_AfterUpdate()
  ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub


Private Sub TOTAL_ISSUE_NUM_i_AfterUpdate()
  TOTAL_ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub


Private Sub MAX_FONT_SIZE_i_AfterUpdate()
  MAX_FONT_SIZE_i.ForeColor = RGB(255, 0, 0)
End Sub


Private Sub MIN_FONT_SIZE_i_AfterUpdate()
  MIN_FONT_SIZE_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub PAGE_H_mm_i_AfterUpdate()
  PAGE_H_mm_i.Value = Abs(CInt(PAGE_H_mm_i.Value))
  ROWH_i.Value = Int((CSng(PAGE_H_mm_i.Value) - CSng(HEADH_i.Value) - CSng(FOOTH_i.Value)) / Int(ROWNUM_i.Value) * 100) / 100#
  PAGE_H_mm_i.ForeColor = RGB(255, 0, 0)
  ROWH_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub PAGE_W_mm_i_AfterUpdate()
  PAGE_W_mm_i.Value = Abs(CInt(PAGE_W_mm_i.Value))
  COLW_i.Value = Int(CSng(PAGE_W_mm_i.Value) / Int(COLNUM_i.Value) * 100) / 100#
  PAGE_W_mm_i.ForeColor = RGB(255, 0, 0)
  COLW_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub HEADH_i_AfterUpdate()
  HEADH_i.Value = CInt(HEADH_i.Value)
  If HEADH_i.Value < 0 Then HEADH_i.Value = 0
  ROWH_i.Value = Int((CSng(PAGE_H_mm_i.Value) - CSng(HEADH_i.Value) - CSng(FOOTH_i.Value)) / Int(ROWNUM_i.Value) * 100) / 100#
  HEADH_i.ForeColor = RGB(255, 0, 0)
  ROWH_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub FOOTH_i_AfterUpdate()
  FOOTH_i.Value = CInt(FOOTH_i.Value)
  If FOOTH_i.Value < 0 Then FOOTH_i.Value = 0
  ROWH_i.Value = Int((CSng(PAGE_H_mm_i.Value) - CSng(HEADH_i.Value) - CSng(FOOTH_i.Value)) / Int(ROWNUM_i.Value) * 100) / 100#
  FOOTH_i.ForeColor = RGB(255, 0, 0)
  ROWH_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub PERSONAL_FREE_INFO_COLS_i_AfterUpdate()
  PERSONAL_FREE_INFO_COLS_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub PERSONAL_FREE_INFO_ROWS_i_AfterUpdate()
 PERSONAL_FREE_INFO_ROWS_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub COLNUM_CHANGE_i_SpinUp()
 COLNUM_i.Value = CInt(COLNUM_i.Value) + 1
 COLNUM_i_AfterUpdate
End Sub
Private Sub COLNUM_CHANGE_i_SpinDown()
 If CInt(COLNUM_i.Value) > 1 Then COLNUM_i.Value = CInt(COLNUM_i.Value) - 1
 COLNUM_i_AfterUpdate
End Sub
Private Sub ROWNUM_CHANGE_i_SpinUp()
 ROWNUM_i.Value = CInt(ROWNUM_i.Value) + 1
 ROWNUM_i_AfterUpdate
End Sub
Private Sub ROWNUM_CHANGE_i_SpinDown()
 If CInt(ROWNUM_i.Value) > 1 Then ROWNUM_i.Value = CInt(ROWNUM_i.Value) - 1
 ROWNUM_i_AfterUpdate
End Sub

Public Sub COLNUM_i_AfterUpdate()
  COLNUM_i.Value = CInt(COLNUM_i.Value)
  If COLNUM_i.Value < 1 Then COLNUM_i.Value = 1
  COLW_i.Value = Int(CSng(PAGE_W_mm_i.Value) / Int(COLNUM_i.Value) * 100) / 100#
  COLNUM_i.ForeColor = RGB(255, 0, 0)
  COLW_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub ROWNUM_i_AfterUpdate()
  ROWNUM_i.Value = CInt(ROWNUM_i.Value)
  If ROWNUM_i.Value < 1 Then ROWNUM_i.Value = 1
  ROWH_i.Value = Int((CSng(PAGE_H_mm_i.Value) - CSng(HEADH_i.Value) - CSng(FOOTH_i.Value)) / Int(ROWNUM_i.Value) * 100) / 100#
  ROWNUM_i.ForeColor = RGB(255, 0, 0)
  ROWH_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub COLW_i_AfterUpdate()
  If COLW_i.Value < 0 Then COLW_i.Value = 0
  COLNUM_i.Value = Int(CSng(PAGE_W_mm_i.Value) / CSng(COLW_i.Value))
  COLW_i.Value = Int(CSng(PAGE_W_mm_i.Value) / Int(COLNUM_i.Value) * 100) / 100#
  COLNUM_i.ForeColor = RGB(255, 0, 0)
  COLW_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub ROWH_i_AfterUpdate()
  If ROWH_i.Value < 0 Then ROWH_i.Value = 0
  ROWNUM_i.Value = Int((CSng(PAGE_H_mm_i.Value) - CSng(HEADH_i.Value) - CSng(FOOTH_i.Value)) / CSng(ROWH_i.Value))
  ROWH_i.Value = Int((CSng(PAGE_H_mm_i.Value) - CSng(HEADH_i.Value) - CSng(FOOTH_i.Value)) / Int(ROWNUM_i.Value) * 100) / 100#
  ROWNUM_i.ForeColor = RGB(255, 0, 0)
  ROWH_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub TOTAL_INTEREST_PERCENTS_i_AfterUpdate()
  TOTAL_INTEREST_PERCENTS_i.ForeColor = RGB(255, 0, 0)
End Sub


Public Sub TOTAL_ISSUE_NUM_CHANGE_i_SpinDown()
  If TOTAL_ISSUE_NUM_i.Value > 1 Then
    TOTAL_ISSUE_NUM_i.Value = TOTAL_ISSUE_NUM_i.Value - 1
    TOTAL_ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
  End If
End Sub

Public Sub TOTAL_ISSUE_NUM_CHANGE_i_SpinUp()
  TOTAL_ISSUE_NUM_i.Value = TOTAL_ISSUE_NUM_i.Value + 1
  TOTAL_ISSUE_NUM_i.ForeColor = RGB(255, 0, 0)
End Sub

Private Sub BORDERM_i_AfterUpdate()
  BORDERM_i.ForeColor = RGB(255, 0, 0)
End Sub


Public Sub logo_Click()
 ShellExecute 111, "Open", "http://www.kxqbz.com", "", "", 1 'SW_SHOWNORMAL 不好使
End Sub

Public Sub OTHER_CFG_Click()
'读其他参数:联系电话 短信手机号 银行帐号
 Dim tempii As String
 Open App.Path & "\other-cfg.par" For Input As #1
 Input #1, tempii
 OtherCfg.CompanyInfo_i.Value = Replace(tempii, "^|", vbCrLf)
 Input #1, tempii
 OtherCfg.HotLine_i.Value = tempii
 Input #1, tempii
 OtherCfg.CellPhone_i.Value = tempii
 Input #1, tempii
 OtherCfg.YourLogoPath_i.Value = tempii
 Input #1, tempii
 OtherCfg.BankCard_i.Value = tempii
 Close #1
 OtherCfg.Left = UserForm_Preface.Left + 3200
 OtherCfg.Top = UserForm_Preface.Top + 400
 OtherCfg.Show
 DoEvents
End Sub


Public Sub RESTORE_PARAMETER_Click()
 '读缺省配置文件 dft-cfg.par
 Dim fn_temp As Variant
 fn_temp = App.Path & "\dft-cfg.par"
 PAGE_H_mm_i.Value = ReadPar(fn_temp, "版心高度", "=")
 PAGE_W_mm_i.Value = ReadPar(fn_temp, "版心宽度", "=")
 HEADH_i.Value = ReadPar(fn_temp, "页眉高度", "=")
 FOOTH_i.Value = ReadPar(fn_temp, "页脚高度", "=")
 BORDERM_i.Value = ReadPar(fn_temp, "边白尺寸", "=")
 COMPAGESNUM_i.Value = ReadPar(fn_temp, "联版数目", "=")
 COLNUM_i.Value = CInt(ReadPar(fn_temp, "横向广告格数", "="))
 ROWNUM_i.Value = CInt(ReadPar(fn_temp, "纵向广告格数", "="))
 COLW_i.Value = ReadPar(fn_temp, "每格宽度", "=")
 ROWH_i.Value = ReadPar(fn_temp, "每格高度", "=")
 MAX_FONT_SIZE_i.Value = ReadPar(fn_temp, "最大字号", "=")
 MIN_FONT_SIZE_i.Value = ReadPar(fn_temp, "最小字号", "=")
 FONT_SIZE_ADJUST_i.Value = ReadPar(fn_temp, "字号调整", "=")
 PERSONAL_FREE_INFO_ROWS_i.Value = ReadPar(fn_temp, "免费个人信息所占行数", "=")
 PERSONAL_FREE_INFO_COLS_i.Value = ReadPar(fn_temp, "免费个人信息所占列数", "=")
 TOTAL_INTEREST_PERCENTS_i.Value = ReadPar(fn_temp, "趣味性资料比例", "=")
 FRONT_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "封面版数", "=")
 BACK_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "封底版数", "=")
 OLD_COLNUM = CInt(COLNUM_i.Value)
 OLD_ROWNUM_PAGE = CInt(ROWNUM_i.Value) * 2
 DoEvents
 
 PAGE_H_mm_i.ForeColor = RGB(0, 0, 0)
 PAGE_W_mm_i.ForeColor = RGB(0, 0, 0)
 HEADH_i.ForeColor = RGB(0, 0, 0)
 FOOTH_i.ForeColor = RGB(0, 0, 0)
 BORDERM_i.ForeColor = RGB(0, 0, 0)
 COMPAGESNUM_i.ForeColor = RGB(0, 0, 0)
 COLNUM_i.ForeColor = RGB(0, 0, 0)
 ROWNUM_i.ForeColor = RGB(0, 0, 0)
 COLW_i.ForeColor = RGB(0, 0, 0)
 ROWH_i.ForeColor = RGB(0, 0, 0)
 MAX_FONT_SIZE_i.ForeColor = RGB(0, 0, 0)
 MIN_FONT_SIZE_i.ForeColor = RGB(0, 0, 0)
 FONT_SIZE_ADJUST_i.ForeColor = RGB(0, 0, 0)
 PERSONAL_FREE_INFO_ROWS_i.ForeColor = RGB(0, 0, 0)
 PERSONAL_FREE_INFO_COLS_i.ForeColor = RGB(0, 0, 0)
 TOTAL_INTEREST_PERCENTS_i.ForeColor = RGB(0, 0, 0)
 FRONT_COVER_PAGE_NUM_i.ForeColor = RGB(0, 0, 0)
 BACK_COVER_PAGE_NUM_i.ForeColor = RGB(0, 0, 0)
 DoEvents
End Sub

Public Sub LAST_PARAMETER_Click()
 '读最后配置文件 k-cfg.par  并置为黑色，不同于UserForm_Preface.Initialize ，那里不置黑色，并根据其它参数自动更改了某些值
 Dim fn_temp As Variant
 fn_temp = App.Path & "\k-cfg.par"
 PAGE_H_mm_i.Value = ReadPar(fn_temp, "版心高度", "=")
 PAGE_W_mm_i.Value = ReadPar(fn_temp, "版心宽度", "=")
 HEADH_i.Value = ReadPar(fn_temp, "页眉高度", "=")
 FOOTH_i.Value = ReadPar(fn_temp, "页脚高度", "=")
 BORDERM_i.Value = ReadPar(fn_temp, "边白尺寸", "=")
 COMPAGESNUM_i.Value = ReadPar(fn_temp, "联版数目", "=")
 COLNUM_i.Value = CInt(ReadPar(fn_temp, "横向广告格数", "="))
 ROWNUM_i.Value = CInt(ReadPar(fn_temp, "纵向广告格数", "="))
 COLW_i.Value = ReadPar(fn_temp, "每格宽度", "=")
 ROWH_i.Value = ReadPar(fn_temp, "每格高度", "=")
 MAX_FONT_SIZE_i.Value = ReadPar(fn_temp, "最大字号", "=")
 MIN_FONT_SIZE_i.Value = ReadPar(fn_temp, "最小字号", "=")
 FONT_SIZE_ADJUST_i.Value = ReadPar(fn_temp, "字号调整", "=")
 PERSONAL_FREE_INFO_ROWS_i.Value = ReadPar(fn_temp, "免费个人信息所占行数", "=")
 PERSONAL_FREE_INFO_COLS_i.Value = ReadPar(fn_temp, "免费个人信息所占列数", "=")
 TOTAL_INTEREST_PERCENTS_i.Value = ReadPar(fn_temp, "趣味性资料比例", "=")
 FRONT_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "封面版数", "=")
 BACK_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "封底版数", "=")
 OLD_COLNUM = CInt(COLNUM_i.Value)
 OLD_ROWNUM_PAGE = CInt(ROWNUM_i.Value) * 2
 DoEvents
 
 PAGE_H_mm_i.ForeColor = RGB(0, 0, 0)
 PAGE_W_mm_i.ForeColor = RGB(0, 0, 0)
 HEADH_i.ForeColor = RGB(0, 0, 0)
 FOOTH_i.ForeColor = RGB(0, 0, 0)
 BORDERM_i.ForeColor = RGB(0, 0, 0)
 COMPAGESNUM_i.ForeColor = RGB(0, 0, 0)
 COLNUM_i.ForeColor = RGB(0, 0, 0)
 ROWNUM_i.ForeColor = RGB(0, 0, 0)
 COLW_i.ForeColor = RGB(0, 0, 0)
 ROWH_i.ForeColor = RGB(0, 0, 0)
 MAX_FONT_SIZE_i.ForeColor = RGB(0, 0, 0)
 MIN_FONT_SIZE_i.ForeColor = RGB(0, 0, 0)
 FONT_SIZE_ADJUST_i.ForeColor = RGB(0, 0, 0)
 PERSONAL_FREE_INFO_ROWS_i.ForeColor = RGB(0, 0, 0)
 PERSONAL_FREE_INFO_COLS_i.ForeColor = RGB(0, 0, 0)
 TOTAL_INTEREST_PERCENTS_i.ForeColor = RGB(0, 0, 0)
 FRONT_COVER_PAGE_NUM_i.ForeColor = RGB(0, 0, 0)
 BACK_COVER_PAGE_NUM_i.ForeColor = RGB(0, 0, 0)
 DoEvents
End Sub

Public Sub SAVE_PARAMETER_Click()
'写配置文件 k-cfg.par,不是缺省配置,缺省配置文件为 dft-cfg.par
 Open App.Path & "\k-cfg.par" For Output As #10
 Print #10, "版心高度=" & PAGE_H_mm_i.Value
 Print #10, "版心宽度=" & PAGE_W_mm_i.Value
 Print #10, "页眉高度=" & HEADH_i.Value
 Print #10, "页脚高度=" & FOOTH_i.Value
 Print #10, "边白尺寸=" & BORDERM_i.Value
 Print #10, "联版数目=" & COMPAGESNUM_i.Value
 Print #10, "横向广告格数=" & COLNUM_i.Value
 Print #10, "纵向广告格数=" & ROWNUM_i.Value
 Print #10, "每格宽度=" & COLW_i.Value
 Print #10, "每格高度=" & ROWH_i.Value
 Print #10, "最大字号=" & MAX_FONT_SIZE_i.Value
 Print #10, "最小字号=" & MIN_FONT_SIZE_i.Value
 Print #10, "字号调整=" & FONT_SIZE_ADJUST_i.Value
 Print #10, "免费个人信息所占行数=" & PERSONAL_FREE_INFO_ROWS_i.Value
 Print #10, "免费个人信息所占列数=" & PERSONAL_FREE_INFO_COLS_i.Value
 Print #10, "趣味性资料比例=" & TOTAL_INTEREST_PERCENTS_i.Value
 Print #10, "封面版数=" & FRONT_COVER_PAGE_NUM_i.Value
 Print #10, "封底版数=" & BACK_COVER_PAGE_NUM_i.Value
 Close #10
 DoEvents
End Sub

Public Sub StopButton_Click()
Dim stop_y_n
If APP_BEGUN = True Then
  stop_y_n = MsgBox("退出程序可能造成数据库混乱！" & vbCrLf & "请保存相关数据。 " & vbCrLf & "确实要退出吗？", 1 + 256, "《开心情报站》自动排版系统")
  If stop_y_n = 1 Then
     xlapp.WindowState = xlMaximized
     xlapp.Interactive = True   '使它可操作，人手动编辑
     xlapp.DisplayFullScreen = False
     xlapp.Visible = True
     '关闭 Excel,不保存
     If CLOSE_EXCEL_i.Value = True Then xlapp.Quit
     End
  End If
Else
  '关闭 Excel,不保存
  'xlapp.Quit
  End
End If
End Sub


Public Sub UserForm_Initialize()
 On Error GoTo ErrHandler:
 CONTACT_INFO = "   请联系大庆方格广告有限公司 (试用版本也享有技术支持)" & vbCrLf & _
                "        网址:www.kxqbz.com" & vbCrLf & _
                "        电话:0459-5514422 5773694 13644697987     " & vbCrLf & _
                "        QQ:5632147 492533636"
                
 Get_My_Documents_Path  '获得我的文档路径
 
 'ActiveWorkbook.Sheets(1).Name = "开心情报站 广告笑着看" '表单名字,不能超过31字符
 UserForm_Preface.Caption = SYSTEM_INFO_NAME
 'UserForm_Preface.Show

 UserForm_Preface.Height = 5400 '268 excel的尺寸单位和VB不一样
 UserForm_Preface.Width = 7850
 'logo.Picture = LoadPicture(app.Path & "\k-logo1.jpg")
 'percents_up.Picture = LoadPicture(app.Path & "\percents.jpg")

 '读配置文件 k-cfg.par,不是缺省配置,缺省配置文件为 dft-cfg.par
 'Dim temp As Single
 Dim fn_temp, fn_temp2, tempp As Variant
 fn_temp = App.Path & "\k-cfg.par"
 PAGE_H_mm_i.Value = ReadPar(fn_temp, "版心高度", "=")
 PAGE_W_mm_i.Value = ReadPar(fn_temp, "版心宽度", "=")
 HEADH_i.Value = ReadPar(fn_temp, "页眉高度", "=")
 FOOTH_i.Value = ReadPar(fn_temp, "页脚高度", "=")
 BORDERM_i.Value = ReadPar(fn_temp, "边白尺寸", "=")
 COMPAGESNUM_i.Value = ReadPar(fn_temp, "联版数目", "=")
 COLNUM_i.Value = CInt(ReadPar(fn_temp, "横向广告格数", "="))
 ROWNUM_i.Value = CInt(ReadPar(fn_temp, "纵向广告格数", "="))
 COLW_i.Value = ReadPar(fn_temp, "每格宽度", "=")
 ROWH_i.Value = ReadPar(fn_temp, "每格高度", "=")
 MAX_FONT_SIZE_i.Value = ReadPar(fn_temp, "最大字号", "=")
 MIN_FONT_SIZE_i.Value = ReadPar(fn_temp, "最小字号", "=")
 FONT_SIZE_ADJUST_i.Value = ReadPar(fn_temp, "字号调整", "=")
 PERSONAL_FREE_INFO_ROWS_i.Value = ReadPar(fn_temp, "免费个人信息所占行数", "=")
 PERSONAL_FREE_INFO_COLS_i.Value = ReadPar(fn_temp, "免费个人信息所占列数", "=")
 TOTAL_INTEREST_PERCENTS_i.Value = ReadPar(fn_temp, "趣味性资料比例", "=")
 FRONT_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "封面版数", "=")
 BACK_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "封底版数", "=")
 OLD_COLNUM = CInt(COLNUM_i.Value)
 OLD_ROWNUM_PAGE = CInt(ROWNUM_i.Value) * 2


 '读runtime.par '本应在开始键按后读，但这几个这里要用
 fn_temp = App.Path & "\runtime.par"
 ISSUE_DAY_AFTER = CInt(ReadPar(fn_temp, "ISSUE_DAY_AFTER", "="))
 ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) '印刷延误天数，runtime.par文件中，列为 mm2ROW_UNIT,要混在mm2POINT附近，用带小数点的数
 TIPS_YES = CInt(ReadPar(fn_temp, "TIPS_YES", "="))
 If TIPS_YES <> 0 Then
    fn_temp2 = App.Path & "\helptips.par"  '快速帮助提示文件
    BACK_GRD.ControlTipText = ReadPar(fn_temp2, "BACK_GRD", ":")
    EDIT_PARA.ControlTipText = ReadPar(fn_temp2, "EDIT_PARA", ":")
    PAGE_H_mm_i.ControlTipText = ReadPar(fn_temp2, "PAGE_H_mm_i", ":")
    PAGE_W_mm_i.ControlTipText = ReadPar(fn_temp2, "PAGE_W_mm_i", ":")
    HEADH_i.ControlTipText = ReadPar(fn_temp2, "HEADH_i", ":")
    FOOTH_i.ControlTipText = ReadPar(fn_temp2, "FOOTH_i", ":")
    BORDERM_i.ControlTipText = ReadPar(fn_temp2, "BORDERM_i", ":")
    COMPAGESNUM_i.ControlTipText = ReadPar(fn_temp2, "COMPAGESNUM_i", ":")
    COLNUM_i.ControlTipText = ReadPar(fn_temp2, "COLNUM_i", ":")
    ROWNUM_i.ControlTipText = ReadPar(fn_temp2, "ROWNUM_i", ":")
    COLNUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "COLNUM_CHANGE_i", ":")
    ROWNUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "ROWNUM_CHANGE_i", ":")
    COLW_i.ControlTipText = ReadPar(fn_temp2, "COLW_i", ":")
    ROWH_i.ControlTipText = ReadPar(fn_temp2, "ROWH_i", ":")
    MAX_FONT_SIZE_i.ControlTipText = ReadPar(fn_temp2, "MAX_FONT_SIZE_i", ":")
    MIN_FONT_SIZE_i.ControlTipText = ReadPar(fn_temp2, "MIN_FONT_SIZE_i", ":")
    FONT_SIZE_ADJUST_i.ControlTipText = ReadPar(fn_temp2, "FONT_SIZE_ADJUST_i", ":")
    PERSONAL_FREE_INFO_ROWS_i.ControlTipText = ReadPar(fn_temp2, "PERSONAL_FREE_INFO_ROWS_i", ":")
    PERSONAL_FREE_INFO_COLS_i.ControlTipText = ReadPar(fn_temp2, "PERSONAL_FREE_INFO_COLS_i", ":")
    TOTAL_INTEREST_PERCENTS_i.ControlTipText = ReadPar(fn_temp2, "TOTAL_INTEREST_PERCENTS_i", ":")
    logo.ControlTipText = ReadPar(fn_temp2, "logo", ":")
    SAVE_PARAMETER.ControlTipText = ReadPar(fn_temp2, "SAVE_PARAMETER", ":")
    RESTORE_PARAMETER.ControlTipText = ReadPar(fn_temp2, "RESTORE_PARAMETER", ":")
    LAST_PARAMETER.ControlTipText = ReadPar(fn_temp2, "LAST_PARAMETER", ":")
    OTHER_CFG.ControlTipText = ReadPar(fn_temp2, "OTHER_CFG", ":")
    DB_OPTION1_i.ControlTipText = ReadPar(fn_temp2, "DB_OPTION1_i", ":")
    DB_OPTION2_i.ControlTipText = ReadPar(fn_temp2, "DB_OPTION2_i", ":")
    DB_FRAME.ControlTipText = ReadPar(fn_temp2, "DB_FRAME", ":")
    EDIT_DB_BUTTON.ControlTipText = ReadPar(fn_temp2, "EDIT_DB_BUTTON", ":")
    ISSUE_NUM_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_NUM_i", ":")
    ISSUE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_NUM_CHANGE_i", ":")
    TOTAL_ISSUE_NUM_i.ControlTipText = ReadPar(fn_temp2, "TOTAL_ISSUE_NUM_i", ":")
    TOTAL_ISSUE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "TOTAL_ISSUE_NUM_CHANGE_i", ":")
    ISSUE_DATE_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_DATE_i", ":")
    ISSUE_DATE_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_DATE_CHANGE_i", ":")
    FRONT_COVER_PAGE_NUM_i.ControlTipText = ReadPar(fn_temp2, "FRONT_COVER_PAGE_NUM_i", ":")
    FRONT_COVER_PAGE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "FRONT_COVER_PAGE_NUM_CHANGE_i", ":")
    BACK_COVER_PAGE_NUM_i.ControlTipText = ReadPar(fn_temp2, "BACK_COVER_PAGE_NUM_i", ":")
    BACK_COVER_PAGE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "BACK_COVER_PAGE_NUM_CHANGE_i", ":")
    TEST_i.ControlTipText = ReadPar(fn_temp2, "TEST_i", ":")
    CLOSE_EXCEL_i.ControlTipText = ReadPar(fn_temp2, "CLOSE_EXCEL_i", ":")
    BeginButton.ControlTipText = ReadPar(fn_temp2, "BeginButton", ":")
    StopButton.ControlTipText = ReadPar(fn_temp2, "StopButton", ":")
    VERSION_INFO.ControlTipText = ReadPar(fn_temp2, "VERSION_INFO", ":")
    FinishButton.ControlTipText = ReadPar(fn_temp2, "FinishButton", ":")
    REPORT_FRAME.ControlTipText = ReadPar(fn_temp2, "REPORT_FRAME", ":")
 End If
 'Release No.
 fn_temp = App.Path & "\version.par"
 RN.Caption = "RN: " & ReadPar(fn_temp, "RN", ":")
 
 '读期号文件
 Dim tempi As Integer
 Open App.Path & "\issuenum.par" For Input As #10
 Input #10, tempi
 ISSUE_NUM_i.Value = tempi
 Input #10, tempi
 TOTAL_ISSUE_NUM_i.Value = tempi
 Close #10
 
 If ISSUE_DAY_AFTER > ISSUE_NUM_CHANGE_CONTROL_days Then ISSUE_DAY_AFTER = ISSUE_NUM_CHANGE_CONTROL_days
 issue_date = Date + ISSUE_DAY_AFTER
 Dim WK As Variant
 WK = Array("", "日", "一", "二", "三", "四", "五", "六") '空字串为了适应 Weekday函数
 ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "年" + CStr(Month(issue_date)) + "月" + CStr(Day(issue_date)) + "日" + " 星期" + CStr(WK(Weekday(issue_date)))
  
 Define_Color
 Define_Display_Mode_2_Font_Size
 
 APP_BEGUN = False
 Final_Checked = False
 SCANTIMES = 0
 WRITING_FIRST_ADS = True
 
 '处理许可证
 GET_LICENCE
 If LICENCE_STATUS = 0 Or LICENCE_STATUS = 4 Then
   DB_OPTION1_i.Value = False
   DB_OPTION2_i.Value = True
   CLOSE_EXCEL_i.Enabled = False
 End If

 EXCEL_STARTED = True
 SET_BTTNS   '增加字体整体缩放键


GoTo END_SUB:
ErrHandler: ErrProc "初始化错误 - UserForm_Initialize"
END_SUB:
End Sub

Public Sub ShowPercents_Status(percents As Single, str As String)
  If percents > 100 Then percents = 100
  percents_num.Top = 235 * (1 - percents / 100)
  percents_up.Top = percents_num.Top
  percents_num.Caption = CStr(Int(percents)) + "%"
  Status.Caption = str
  If TEST_i.Value = True Then
    Left_Time.Caption = ""
  Else
    Left_Time.Caption = CStr(1 + Int(3 * TOTAL_ADS_NUM_ROUPH / 100# * (100 - percents) / 100 * (1 + TOTAL_INTEREST_PERCENTS / 100))) + "分钟"
  End If
  'If percents >= 100 Then Left_Time_t.Visible = False
  Show_Tips
  UserForm_Preface.Repaint
  DoEvents
End Sub

Sub End_Show()
UserForm_Preface.SetFocus
Tip_Frame.Visible = False
FinishButton.Visible = True
FinishButton.Default = True
FinishButton.SetFocus
BeginButton.Visible = False
StopButton.Visible = False
TEST_i.Visible = False
CLOSE_EXCEL_i.Visible = False
UserForm_Preface.WindowState = vbNormal
UserForm_Preface.Height = 7755   '388
UserForm_Preface.Repaint

DoEvents
End Sub

Sub Save_All()
'显示排版统计报告
On Error GoTo ErrHandler:
AD_TYPENUM = AD_TYPENUM - NO_AD_TYPENUM
TOTAL_PAGE_NUM_s.Value = TOTAL_PAGE_NUM
TOTAL_ADS_NUM_s.Value = TOTAL_ADS_NUM
TOTAL_ADS_CELLS_s.Value = TOTAL_ADS_CELLS / 2
AD_TYPENUM_s.Value = AD_TYPENUM
INCOME_s.Value = INCOME
If MIX_CLASS = 1 Then INCOME_s.Value = "~" & CStr(TOTAL_ADS_CELLS / 2 * PRICE_THIS_TYPE)
TOTAL_FREE_NUM_s.Value = TOTAL_FREE_NUM
TOTAL_JOKE_NUM_s.Value = TOTAL_JOKE_NUM
TOTAL_PUZZLE_NUM_s.Value = TOTAL_PUZZLE_NUM
TOTAL_ELSE_NUM_s.Value = TOTAL_ELSE_NUM
DoEvents
END_T = Now()
EDIT_TIME_s.Value = CStr(Hour(END_T - START_T)) + ":" + CStr(Minute(END_T - START_T)) + ":" + CStr(Second(END_T - START_T))

Dim report_filename As String
Create_Dir MY_DOC_PATH & "\《开心情报站》文档\排版统计报告"
If TEST_i.Value = True Then
'保存试排稿,名字为试排稿
Create_Dir MY_DOC_PATH & "\《开心情报站》文档\出版稿\试排稿\印刷稿"
save_filename = MY_DOC_PATH & "\《开心情报站》文档\出版稿\试排稿\印刷稿\试排稿-印刷版.xls"
'存试排排版统计报告文件名 为 "试排稿排版统计报告.txt"
report_filename = MY_DOC_PATH & "\《开心情报站》文档\排版统计报告\试排稿排版统计报告.txt"
Else
'保存正式稿
'打开excel的警告提示,以防止覆盖旧出版稿文件
xlapp.DisplayAlerts = True

'保存出版稿,名字为 第XXX期-总YYY期(出版日期),这样做的目的是:生成出版稿中不包含本 VBA 程序代码,而只是一般的xls文件
Create_Dir MY_DOC_PATH & "\《开心情报站》文档\出版稿\" & "第" & ISSUE_NUM & "期-总" & TOTAL_ISSUE_NUM & "期(" & ISSUE_DATE_CHR & ")\印刷稿"
save_filename = MY_DOC_PATH & "\《开心情报站》文档\出版稿\" & "第" & ISSUE_NUM & "期-总" & TOTAL_ISSUE_NUM & "期(" & ISSUE_DATE_CHR & ")\印刷稿\第" & ISSUE_NUM & "期-总" & TOTAL_ISSUE_NUM & "期(" & ISSUE_DATE_CHR & ")-印刷版.xls"
'存排版统计报告，文件名为 "第XX期排版统计报告.txt"
report_filename = MY_DOC_PATH & "\《开心情报站》文档\排版统计报告\第" + CStr(ISSUE_NUM) + "期-总" + CStr(TOTAL_ISSUE_NUM) + "期(" + CStr(ISSUE_DATE_CHR) + ")排版统计报告.txt"


'更新保存下一期期号,要在HCAutoEdit.xls 关闭前进行
 Open App.Path & "\issuenum.par" For Output As #10
 Print #10, ISSUE_NUM + 1
 Print #10, TOTAL_ISSUE_NUM + 1
 Close #10
End If
DoEvents
'保存最后一次排版主要参数
 Open App.Path & "\lastinfo.par" For Output As #10
 Print #10, save_filename
 Close #10
DoEvents
'存排版结果
ActiveWorkbook.SaveAs FileName:=save_filename
DoEvents
'存排办统计报告
 Open report_filename For Output As #10
 Print #10, "************ 排版参数 ************"
 Print #10, "版心尺寸(mm): 高: " + CStr(PAGE_H_mm_i.Value) + "  宽: " + CStr(PAGE_W_mm_i.Value)
 Print #10, "页眉(mm): " + CStr(HEADH_i.Value)
 Print #10, "页脚(mm): " + CStr(FOOTH_i.Value)
 Print #10, "边白(mm): " + CStr(BORDERM_i.Value)
 Print #10, "联版数: " + CStr(COMPAGESNUM_i.Value)
 Print #10, "横向广告格数: " + CStr(COLNUM_i.Value)
 Print #10, "纵向广告格数: " + CStr(ROWNUM_i.Value)
 Print #10, "每格宽度(mm): " + CStr(COLW_i.Value)
 Print #10, "每格高度(mm): " + CStr(ROWH_i.Value)
 Print #10, "允许最大内容字号: " + CStr(MAX_FONT_SIZE_i.Value)
 Print #10, "允许最小内容字号: " + CStr(MIN_FONT_SIZE_i.Value)
 Print #10, "字号总体调整值: " + CStr(FONT_SIZE_ADJUST_i.Value)
 Print #10, "个人免费信息单元格行数: " + CStr(PERSONAL_FREE_INFO_ROWS_i.Value)
 Print #10, "个人免费信息单元格列数: " + CStr(PERSONAL_FREE_INFO_COLS_i.Value)
 Print #10, "趣味性材料百分比(%): " + CStr(TOTAL_INTEREST_PERCENTS_i.Value)

 
 Print #10, "************ 排版统计 ************"
 Print #10, "期号: " + CStr(ISSUE_NUM_i.Value)
 Print #10, "总期号: " + CStr(TOTAL_ISSUE_NUM_i.Value)
 Print #10, "出版日期: " + CStr(ISSUE_DATE_i.Value)
 Print #10, "封面版数: " + CStr(FRONT_COVER_PAGE_NUM_i.Value)
 Print #10, "封底版数: " + CStr(BACK_COVER_PAGE_NUM_i.Value)

 
 Print #10, "版面总数: " + CStr(TOTAL_PAGE_NUM_s.Value)
 Print #10, "广告总数: " + CStr(TOTAL_ADS_NUM_s.Value)
 Print #10, "格位总数: " + CStr(TOTAL_ADS_CELLS_s.Value)
 Print #10, "类别总数: " + CStr(AD_TYPENUM_s.Value)
 Print #10, "预期收入: " + CStr(INCOME_s.Value)

 Print #10, "免费总数: " + CStr(TOTAL_FREE_NUM_s.Value)
 Print #10, "笑话总数: " + CStr(TOTAL_JOKE_NUM_s.Value)
 Print #10, "谜题总数: " + CStr(TOTAL_PUZZLE_NUM_s.Value)
 Print #10, "其它总数: " + CStr(TOTAL_ELSE_NUM_s.Value)
 Print #10, "排版用时: " + CStr(EDIT_TIME_s.Value)
 Print #10,

 Close #10
DoEvents
GoTo END_SUB:
ErrHandler: ErrProc "保存文件错误 - Save_All"
END_SUB:
End Sub



Sub Set_Head_Foot()
    On Error GoTo 7659
    PROCESS_PERCENTS = 85  'PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "设置打印页面..."
    '设置边白 页眉脚
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "调整页面:左白"
    DoEvents
    ActiveSheet.PageSetup.LeftMargin = xlapp.InchesToPoints((LEFTW - 1) / 25.4) '此函数采用英寸,要换算成毫米
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "调整页面:右白"
    DoEvents
    ActiveSheet.PageSetup.RightMargin = xlapp.InchesToPoints((RIGHTW - 1) / 25.4) '稍小一点，以免装不下
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "调整页面:顶白"
    DoEvents
    ActiveSheet.PageSetup.HeaderMargin = xlapp.InchesToPoints(TOPM / 25.4)
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "调整页面:顶白"
    DoEvents
    ActiveSheet.PageSetup.TopMargin = xlapp.InchesToPoints((HEADH + TOPM) / 25.4)
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "调整页面:底白"
    DoEvents
    ActiveSheet.PageSetup.FooterMargin = xlapp.InchesToPoints(BOTTOMM / 25.4)
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "调整页面:底白"
    DoEvents
    ActiveSheet.PageSetup.BottomMargin = xlapp.InchesToPoints((FOOTH + BOTTOMM) / 25.4)
    '页眉页脚
    'PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    'If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    'ShowPercents_Status PROCESS_PERCENTS, "设置页眉/页脚..."
    'DoEvents
    'ActiveSheet.PageSetup.LeftHeaderPicture.FileName = _
    '    App.Path & "\hf_logo.jpg"
    'With ActiveSheet.PageSetup.LeftHeaderPicture
    '    .Height = 40
    '    .Width = 183
    'End With
    'DoEvents
    'ActiveSheet.PageSetup.PrintArea = "$A$1:$" & COLSTR(COLNUM) & "$" & CStr(ROWNUM)
    With ActiveSheet.PageSetup
       If HEADH > 0 Then
        PROCESS_PERCENTS = PROCESS_PERCENTS + 1
        If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
        ShowPercents_Status PROCESS_PERCENTS, "设置页眉..."
        DoEvents
        
        .LeftHeader = "&G"
        .CenterHeader = _
        "&""宋体,常规""&10              爱心提示：所刊信息已经严" & Chr(10) & "              格审查，但仍需您仔细查证" _
          & Chr(10) & "&""宋体,加粗""&10             热线电话:" & HOTLINE   '& " 接收广告:" & CELLPHONE
        .RightHeader = "&""楷体_GB2312,加粗""&10第" & ISSUE_NUM & "期/总" & TOTAL_ISSUE_NUM & "期" & Chr(10) & "第" & "&P" & "版/总" & TOTAL_PAGE_NUM & "版" & Chr(10) & ISSUE_DATE_CHR
        .LeftHeaderPicture.FileName = App.Path & "\hf_logo.jpg"
        .LeftHeaderPicture.Height = 40
        .LeftHeaderPicture.Width = 183
       End If
       
       If FOOTH > 0 Then
        PROCESS_PERCENTS = PROCESS_PERCENTS + 1
        If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
        ShowPercents_Status PROCESS_PERCENTS, "设置页脚..."
        DoEvents
        
        .LeftFooter = ""
        .CenterFooter = _
        "&""宋体,加粗""&10业务受理:&""宋体,常规""持有效证件(1)到开心情报站联络站办理;(2)上网提交;(3)发短信到" & CELLPHONE & ";(4)拨热线电话。每单元格字数<80，图形大小不限。&""宋体,加粗""付费:&""宋体,常规""现金或汇至帐号" & BANKCARD & "或网上付款。" & Chr(10) & _
        "&""宋体,加粗""&8诚招全国各地合作伙伴 统一商标 连锁经营 加盟灵活 在线服务 网络平台 智能排印 电话:0459-5514422 5773694"
        .RightFooter = ""
       End If
       
       DoEvents
        .PrintArea = "$A$1:$" & COLSTR(COLNUM) & "$" & CStr(ROWNUM)
        .PrintTitleRows = ""
        .PrintTitleColumns = ""
        .PrintHeadings = False
        .PrintGridlines = False
        .PrintComments = xlPrintNoComments
        '.PrintQuality = 600
        .CenterHorizontally = True
        .CenterVertically = True
        '.Orientation = xlPortrait
        .Draft = False
        '.PaperSize = xlPaperA4
        .FirstPageNumber = FRONT_COVER_PAGE_NUM + 1
        .Order = xlDownThenOver
        .BlackAndWhite = False
        .Zoom = 100
        .PrintErrors = xlPrintErrorsDisplayed
    End With
    DoEvents
    Exit Sub
7659
    atemp = MsgBox(vbCrLf & "   提示: 您的电脑没有安装打印机或打印机不支持您设定的属性，所以无法进行页面设置      " & vbCrLf & vbCrLf & _
                "   排版仍可继续进行，但将缺少页眉、页脚(含联系信息)等" & vbCrLf & vbCrLf & _
                "   建议安装虚拟打印机，例如 SmartPrinter(逸铭软件产品:www.i-enet.com) 等", 0 + 64, "《开心情报站》自动排版系统")

End Sub



Sub Put_All_Ads(a_type As Integer)
'################################################################################################################################
On Error Resume Next

Dim i_ads, i_fs, t_BEGIN_ROWNUM_THIS_TYPE As Integer
Dim t_NAME_THIS_TYPE, t_TITLE As String
t_OUTSIDE_CLASS_TITLE = OUTSIDE_CLASS_TITLE
FROM_LEFT_TO_RIGHT = 0
Get_Type_Name_And_Price a_type
Get_Total_Cells_Num_Ads_And_Income_This_Type a_type
If TOTAL_ADS_NUM_THIS_TYPE <= 0 Then Exit Sub
If WRITING_FIRST_ADS = True And FRONT_COVER_PAGE_NUM <= 0 Then t_OUTSIDE_CLASS_TITLE = 1
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then   '在写第1类（由广告可写的第1类，数据库中不一定是第1类），插入开心情报站广告，如果是试用版
  TOTAL_ADS_NUM_THIS_TYPE = TOTAL_ADS_NUM_THIS_TYPE + 1                           '这里计算开心情报站广告格数目
  TOTAL_ADS_NUM = TOTAL_ADS_NUM + 1
  TOTAL_ADS_CELLS_THIS_TYPE = TOTAL_ADS_CELLS_THIS_TYPE + 2 * 3 * 2  '横3纵2广告格
  TOTAL_ADS_CELLS = TOTAL_ADS_CELLS + 2 * 3 * 2
End If
BEGIN_ROWNUM_LAST_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_LAST_TYPE = END_ROWNUM_THIS_TYPE
ROWNUM_THIS_TYPE = 2
If TOTAL_INTEREST_PERCENTS > 0 Then ROWNUM_THIS_TYPE = 2 + Int(Int(TOTAL_ADS_CELLS_THIS_TYPE * (1 + TOTAL_INTEREST_PERCENTS / 100)) / COLNUM)   '全部广告总行数，每条广告占2个excel行,TOTAL_ADS_CELLS是乘过2的
If ROWNUM_THIS_TYPE Mod 2 <> 0 Then ROWNUM_THIS_TYPE = ROWNUM_THIS_TYPE + 1
ROWNUM = ROWNUM + ROWNUM_THIS_TYPE
BEGIN_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 1     '上个类型行数累加，第一个类别时此值就是最前面的空行数
t_BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + ROWNUM_THIS_TYPE - 1
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + TOTAL_ADS_CELLS_THIS_TYPE
t_NAME_THIS_TYPE = NAME_THIS_TYPE
If Len(NAME_THIS_TYPE) > 2 Then t_NAME_THIS_TYPE = Left(NAME_THIS_TYPE, 2) & "~"
ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
ShowPercents_Status PROCESS_PERCENTS, "处理广告:" & a_type & "-" & t_NAME_THIS_TYPE + "-调整版面"

DoEvents
For i = BEGIN_ROWNUM_THIS_TYPE To ROWNUM Step 2
   DoEvents
   ActiveSheet.Range("A" + CStr(i)).RowHeight = ROWH1
   ActiveSheet.Range("A" + CStr(i + 1)).RowHeight = ROWH2
Next i
Dim Ctt_i, class_t_nm As String
'给封面的目录填字
     Ctt_i = Ctt_i + " ★" + NAME_THIS_TYPE + ":" + "P" + CStr(Int((BEGIN_ROWNUM_THIS_TYPE - 1) / ROWNUM_PAGE + 1 + FRONT_COVER_PAGE_NUM))
     COVER_CONTENTS = COVER_CONTENTS + " ★" + NAME_THIS_TYPE + ":" + "P" + CStr(Int((BEGIN_ROWNUM_THIS_TYPE - 1) / ROWNUM_PAGE + 1 + FRONT_COVER_PAGE_NUM))
     If Len(Ctt_i) > 70 Then
       COVER_CONTENTS = COVER_CONTENTS & Chr(10)
       Ctt_i = ""
    End If
    COVER_CONTENTS = Trim(COVER_CONTENTS)
DoEvents
'广告类标签
If Not (NO_CLASS_TITLE = 1 Or MIX_CLASS = 1) Then '如果不去掉广告类标签，即要广告类标签的话，或者不是混类的话。为了节省版面，可以去掉类标签
     Dim CLASS_COLNUM, t_Page_Num As Integer   '奇偶页广告类标签是否靠外侧，缺省靠左
     Do
        CLASS_COLNUM = 1
        t_Page_Num = Int((BEGIN_ROWNUM_THIS_TYPE + 1) / ROWNUM_PAGE)
        If (BEGIN_ROWNUM_THIS_TYPE + 1) Mod ROWNUM_PAGE <> 0 Then t_Page_Num = t_Page_Num + 1
        t_Page_Num = t_Page_Num + FRONT_COVER_PAGE_NUM
        If t_OUTSIDE_CLASS_TITLE <> 0 And t_Page_Num Mod 2 <> 0 Then
            CLASS_COLNUM = COLNUM
            FROM_LEFT_TO_RIGHT = 1
        End If
        If Not All_Null(CStr(CLASS_COLNUM) + ":" + CStr(BEGIN_ROWNUM_THIS_TYPE) + ":" + CStr(CLASS_COLNUM) + ":" + CStr(BEGIN_ROWNUM_THIS_TYPE + 1)) Then
          BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + 2
          END_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 2
          ROWNUM = ROWNUM + 2
          ActiveSheet.Range("A" + CStr(BEGIN_ROWNUM_THIS_TYPE)).RowHeight = ROWH1
          ActiveSheet.Range("A" + CStr(BEGIN_ROWNUM_THIS_TYPE + 1)).RowHeight = ROWH2
          ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
        Else
         Exit Do
        End If
     Loop
     ARRAY_FOR_SCAN(CLASS_COLNUM, (BEGIN_ROWNUM_THIS_TYPE + 1) / 2) = 1
     cellid = COLSTR(CLASS_COLNUM) + CStr(BEGIN_ROWNUM_THIS_TYPE) + ":" + COLSTR(CLASS_COLNUM) + CStr(BEGIN_ROWNUM_THIS_TYPE + 1)
     Range(cellid).Merge
     Set_Cell_Border_When_Write (COLSTR(CLASS_COLNUM) + CStr(BEGIN_ROWNUM_THIS_TYPE))
     DoEvents
     ActiveWorkbook.Names.Add Name:="type" + CStr(a_type), RefersToR1C1:="=内页!R" + CStr(BEGIN_ROWNUM_THIS_TYPE) + "C1"
     Range(cellid).Select
     class_t_nm = NAME_THIS_TYPE
     class_t_nm = Replace(class_t_nm, " ", Chr(10))
     class_t_nm = CStr(a_type) & " " & class_t_nm
     i_fs = Calculate_Font_Size(class_t_nm, 1, 1, 0)
     Range(cellid).Value = class_t_nm    '"*"
     Range(cellid).HorizontalAlignment = xlRight
     Range(cellid).WrapText = True
     Range(cellid).Font.Size = i_fs
     Range(cellid).Font.Name = CLASS_FONT_NAME
     Range(cellid).Font.Color = RGB(255, 255, 255)
     Range(cellid).Interior.Color = RGB(127, 0, 0)
     TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + 2
     DoEvents
     If USE_CLASS_PIC <> 0 Then
        ActiveSheet.Pictures.Insert(App.Path & "\class_" & CStr(a_type) & ".jpg").Select
        Selection.ShapeRange.LockAspectRatio = msoFalse
        Selection.ShapeRange.Height = Range(cellid).Height - PIC_BOTTOM  '77  '60
        Selection.ShapeRange.Width = Range(cellid).Width - PIC_RIGHT  '90   '89
        Selection.ShapeRange.IncrementLeft PIC_LEFT
        Selection.ShapeRange.IncrementTop PIC_TOP
        Selection.Locked = False
        PIC_NUM = PIC_NUM + 1
     End If
  DoEvents

End If

If BOUND_MIX_CLASS = 1 Then BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_LAST_TYPE


TP_s = " a_type=" & CStr(a_type) & " and"
TP_t = ""
If MIX_CLASS = 1 Then
  TP_s = ""
  TP_t = ",a_type"
End If
'先写多单元格的广告
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " (a_row>1 or a_col>1) order by a_row desc,a_col desc,a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  PROCESS_PERCENTS = PROCESS_PERCENTS + ((30# - 1) / TOTAL_ADS_NUM_THIS_TYPE / AD_TYPENUM)
  t_TITLE = Trim(rs("a_title") & "")
  If t_TITLE = "" Then t_TITLE = "无标题"
  ShowPercents_Status PROCESS_PERCENTS, "处理广告:" & a_type & "-" & t_NAME_THIS_TYPE + " " + CStr(i_ads) + "/" + CStr(TOTAL_ADS_NUM_THIS_TYPE) & "-" & t_TITLE
  Write_Multi_Cells_Unit "ads\" & rs("a_id"), rs("a_title") & "", rs("a_content") & "", rs("a_col") + 0, rs("a_row") + 0, rs("a_mode") + 0, True  '为了表达式类型自动转换,保证付费广告插入成功
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
'如果是试用版或严重过期（1个月），则插入《开心情报站》广告
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then
  Write_Multi_Cells_Unit "kxqbz_ad", "", "{pic}", 3, 2, 2, True  '保证插入成功
End If
'接着写单个单元格的广告
FROM_LEFT_TO_RIGHT = 1
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " a_row=1 and a_col=1 order by a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
If Not rs.EOF Then rs.MoveFirst
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  PROCESS_PERCENTS = PROCESS_PERCENTS + ((12# - 1) / TOTAL_ADS_NUM_THIS_TYPE / AD_TYPENUM)
  t_TITLE = Trim(rs("a_title") & "")  '把NULL -> ""
  If t_TITLE = "" Then t_TITLE = "无标题"
  ShowPercents_Status PROCESS_PERCENTS, "处理广告:" & a_type & "-" & t_NAME_THIS_TYPE + " " + CStr(i_ads) + "/" + CStr(TOTAL_ADS_NUM_THIS_TYPE) & "-" & t_TITLE
  Write_One_Cell_Unit "ads\" & rs("a_id"), rs("a_title") & "", rs("a_content") & "", rs("a_mode") '为了表达式类型自动转换
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
'TOTAL_CELLS = TOTAL_CELLS + (END_ROWNUM_THIS_TYPE - BEGIN_ROWNUM_THIS_TYPE + 1) * COLNUM
TOTAL_CELLS = END_ROWNUM_THIS_TYPE * COLNUM
BEGIN_ROWNUM_THIS_TYPE = t_BEGIN_ROWNUM_THIS_TYPE
WRITING_FIRST_ADS = False   '设置为不是第一次写一类广告了
End Sub

Sub Put_Personal_Free_Info()
'写个人免费信息,必须紧接着广告之后
On Error Resume Next

If PERSONAL_FREE_INFO_ROWS <= 0 Or PERSONAL_FREE_INFO_COLS <= 0 Then Exit Sub
If END_ROWNUM_THIS_TYPE + 1 > FINAL_ROWNUM Then Exit Sub  '如果赶上版面补齐浪费太多就不排它了
FROM_LEFT_TO_RIGHT = 1
Dim title, Content As String
Dim NUM_IN_DB, t_BEGIN_ROWNUM_THIS_TYPE, T_end_rownum_this_type, T_personal_free_info_rows, T_personal_free_info_cols, T_NO_CLASS_TITLE As Integer '临时记录，反映开始和结束行的变化，变化是因为要保证插入成功，就得加行
T_personal_free_info_rows = PERSONAL_FREE_INFO_ROWS
T_personal_free_info_cols = PERSONAL_FREE_INFO_COLS
title = "个人免费信息(未核实，慎用)"


ITEMS_NUM_PER_ROW = CInt(4 * ROWH / ((6 + 22) * mm2POINT))   '在A4标准时每广告行可写4个免费信息，指个人免费信息每单列(广告格2列)4个，不是版面整行的

Dim Tstr1, Tstr2 As String

conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "p_free_info" & R_s & " order by p_id desc"
rs.Open SQL_Str, conn, 2, 2
DoEvents
'检查免费信息数量够不够，如不够就自动缩小行列数，或者不出了
ROWNUM_THIS_TYPE = 0
Do While Not rs.EOF
  DoEvents
  NUM_IN_DB = NUM_IN_DB + 1
  rs.MoveNext
Loop
If NUM_IN_DB <= 0 Then
  rs.Close
  conn.Close
  Exit Sub
End If
rs.MoveFirst

NUM_IN_DB = NUM_IN_DB + 1
PERSONAL_FREE_INFO_COLS = Int(NUM_IN_DB / ITEMS_NUM_PER_ROW) * 2
If PERSONAL_FREE_INFO_COLS < 2 Then PERSONAL_FREE_INFO_COLS = 2
If PERSONAL_FREE_INFO_COLS > T_personal_free_info_cols Then PERSONAL_FREE_INFO_COLS = T_personal_free_info_cols
If PERSONAL_FREE_INFO_COLS > COLNUM Then PERSONAL_FREE_INFO_COLS = COLNUM
PERSONAL_FREE_INFO_COLS = Int(PERSONAL_FREE_INFO_COLS / 2) * 2

If NUM_IN_DB < ITEMS_NUM_PER_ROW * PERSONAL_FREE_INFO_COLS / 2 Then
  rs.Close
  conn.Close
  Exit Sub    '最后一条是加上的说明，不再库里，但站位置
End If

PERSONAL_FREE_INFO_ROWS = Int(NUM_IN_DB / (ITEMS_NUM_PER_ROW * PERSONAL_FREE_INFO_COLS / 2))
If PERSONAL_FREE_INFO_ROWS > T_personal_free_info_rows Then PERSONAL_FREE_INFO_ROWS = T_personal_free_info_rows
If PERSONAL_FREE_INFO_ROWS > ROWNUM_PAGE Then PERSONAL_FREE_INFO_ROWS = ROWNUM_PAGE  '免费最多1页
ROWNUM_THIS_TYPE = PERSONAL_FREE_INFO_ROWS * 2
BEGIN_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 1     '上个类型行数累加，第一个类别时此值就是最前面的空行数
T_NO_CLASS_TITLE = NO_CLASS_TITLE   '写个人免费信息时相当于无类标题的广告
NO_CLASS_TITLE = 1
END_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + ROWNUM_THIS_TYPE - 1
If END_ROWNUM_THIS_TYPE > FINAL_ROWNUM Then END_ROWNUM_THIS_TYPE = FINAL_ROWNUM
ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE - BEGIN_ROWNUM_THIS_TYPE + 1
ROWNUM = ROWNUM + ROWNUM_THIS_TYPE
PERSONAL_FREE_INFO_ROWS = ROWNUM_THIS_TYPE / 2

TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + ROWNUM_THIS_TYPE * PERSONAL_FREE_INFO_COLS
T_end_rownum_this_type = END_ROWNUM_THIS_TYPE

ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)

PROCESS_PERCENTS = 50  'PROCESS_PERCENTS + 1
ShowPercents_Status PROCESS_PERCENTS, "处理个人免费信息-调整版面"
'ActiveSheet.Range("A" + CStr(BEGIN_ROWNUM_THIS_TYPE) + ":" + colstr( COLNUM) + CStr(END_ROWNUM_THIS_TYPE)).Value = " " '置空白，表示未占用
DoEvents
For i = BEGIN_ROWNUM_THIS_TYPE To END_ROWNUM_THIS_TYPE Step 2
   DoEvents
   ActiveSheet.Range("A" + CStr(i)).RowHeight = ROWH1
   ActiveSheet.Range("A" + CStr(i + 1)).RowHeight = ROWH2
Next i

For iii = 1 To Int(PERSONAL_FREE_INFO_COLS / 2)
Content = ""
KKK = 0
If iii = Int(PERSONAL_FREE_INFO_COLS / 2) Then KKK = 1
For i = 1 To PERSONAL_FREE_INFO_ROWS * ITEMS_NUM_PER_ROW - KKK  '缺省每标准广告行可以写4行免费信息，可能不是4。最后留一条，作说明
  DoEvents
  TOTAL_FREE_NUM = TOTAL_FREE_NUM + 1
  Tstr1 = rs("p_content")
  Tstr2 = rs("p_contact")
  Tstr1 = Trim(Tstr1)
  Tstr2 = Trim(Tstr2)
  Tstr1 = Merge_CRs(Tstr1 & "") '合并多个回车
  Tstr2 = Merge_CRs(Tstr2)  '合并多个回车
  Tstr1 = Cut_CR(Tstr1 & "")     '干掉回车
  Tstr2 = Cut_CR(Tstr2)
  Tstr1 = Left(Tstr1, 25)
  Tstr2 = Left(Tstr2, 25)
  Content = Content & Tstr1 & Chr(10) & Tstr2 & Chr(10)
  rs.MoveNext
Next i
Content = Left(Content, Len(Content) - 1)
If KKK = 1 Then Content = Content & "^|" & "提示：本部分只接收网上提交的信息" & Chr(10) & "电话等其他方式都将被拒绝，请勿扰"
PROCESS_PERCENTS = 51   'PROCESS_PERCENTS + 1
ShowPercents_Status PROCESS_PERCENTS, "处理个人免费信息:" & iii & "/" & Int(PERSONAL_FREE_INFO_COLS / 2)
Write_Multi_Cells_Unit "no__use", title & "", Content, 2, Int(PERSONAL_FREE_INFO_ROWS), 1, True '保证插入成功
Next iii
DoEvents

rs.Close
conn.Close
DoEvents

T_end_rownum_this_type = END_ROWNUM_THIS_TYPE - T_end_rownum_this_type  '结束行加大的数目,END_ROWNUM_THIS_TYPE 经Write_Multi..可能有变化

t_BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + T_end_rownum_this_type
cellid = "A" + CStr(t_BEGIN_ROWNUM_THIS_TYPE) + ":" + COLSTR(Int(PERSONAL_FREE_INFO_COLS / 2) * 2) + CStr(t_BEGIN_ROWNUM_THIS_TYPE)
Range(cellid).Select
Range(cellid).Merge
    With Selection
        .ShrinkToFit = True
    End With
DoEvents
cellid = "A" + CStr(t_BEGIN_ROWNUM_THIS_TYPE)
Range(cellid).Select
Range(cellid).Font.Size = 14
Range(cellid).HorizontalAlignment = xlCenter
Range(cellid).Font.Name = TOPIC_FONT_NAME2
Range(cellid).Font.Color = RGB(255, 255, 255)
Range(cellid).Value = title
Range(cellid).Characters(Start:=7, Length:=800).Font.Name = "楷体_GB2312"
Range(cellid).Characters(Start:=7, Length:=800).Font.Size = 10
DoEvents
For jjjj = 1 To PERSONAL_FREE_INFO_COLS Step 2
cellid = COLSTR(jjjj) + CStr(t_BEGIN_ROWNUM_THIS_TYPE + 1)
Range(cellid).Select
Range(cellid).Font.Size = MIN_FONT_SIZE  'Int(((ROWH1 + ROWH2) * PERSONAL_FREE_INFO_ROWS - ROWH1 - 15) / Num_Of_CR(Range(cellid).Value))
DoEvents
Next jjjj
'去掉个人免费信息栏目中的竖线
'cellid = "A" + CStr(T_begin_rownum_this_type + 1) + ":" + COLSTR(PERSONAL_FREE_INFO_COLS) + CStr(T_begin_rownum_this_type + 1)
'Range(cellid).Select
'    With Selection.Borders(xlInsideVertical)
'        .LineStyle = xlNone
'    End With
'TOTAL_CELLS = TOTAL_CELLS + (END_ROWNUM_THIS_TYPE - BEGIN_ROWNUM_THIS_TYPE + 1) * COLNUM
TOTAL_CELLS = END_ROWNUM_THIS_TYPE * COLNUM
585858
NO_CLASS_TITLE = T_NO_CLASS_TITLE  '写个人免费信息时相当于无类标题的广告，写完还原
End Sub



Sub Put_Puzzles()
'写迷题，多格和单格的一起写，按优先级取出一定个数迷题来写,若插入失败则置之不理，答案必须一起写，题和答案需要题号对应
'Debug.Print "谜语" & BEGIN_ROWNUM_THIS_TYPE & "/" & END_ROWNUM_THIS_TYPE
If PUZZLE_IN_INTEREST <= 0 Then Exit Sub
If END_ROWNUM_THIS_TYPE >= FINAL_ROWNUM Then Exit Sub
On Error Resume Next
FROM_LEFT_TO_RIGHT = 1
BEGIN_ROWNUM_THIS_TYPE = 1   '从头开始
Dim i_puzzle As Integer
Dim Total_Puzzle_Cells As Long
TOTAL_PUZZLE_NUM = Int((TOTAL_CELLS - TOTAL_CELLS_TOUCHED) / 2 * PUZZLE_IN_INTEREST / 100 / 2)
TOTAL_PUZZLE_NUM = Int(TOTAL_PUZZLE_NUM / 2)
Dim SUCCESS_t, Temp_EOF, Mv_Nxt_YES As Boolean
Dim Answers_Group As String
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "puzzles" & R_s & " order by p_pri desc"
rs.Open SQL_Str, conn, 2, 2
DoEvents
i_puzzle = 0
Temp_EOF = False
Mv_Nxt_YES = False
Do While i_puzzle < TOTAL_PUZZLE_NUM
   If rs.EOF Then rs.MoveFirst
   DoEvents
   SUCCESS_t = True

   PROCESS_PERCENTS = PROCESS_PERCENTS + (20# / TOTAL_PUZZLE_NUM)
   ShowPercents_Status PROCESS_PERCENTS, "处理谜题:" + CStr(i_puzzle + 1) + "/" + CStr(TOTAL_PUZZLE_NUM) & "-" & rs("p_title")
  
  If rs("p_col") > 1 Or rs("p_row") > 1 Then
    Write_Multi_Cells_Unit "puzzles\" & rs("p_id") & "", rs("p_id") & "|" & rs("p_title") & "", rs("p_content") & "", rs("p_col") + 0, rs("p_row") + 0, 1, False '不保证多格插入成功
    If PUT_AD_SUCCESS = True Then Total_Puzzle_Cells = Total_Puzzle_Cells + rs("p_col") * rs("p_row") * 2
  Else
    Total_Puzzle_Cells = Total_Puzzle_Cells + 2
    Write_One_Cell_Unit "puzzles\" & rs("p_id") & "", rs("p_id") & "|" & rs("p_title") & "", rs("p_content") & "", 1 '为了表达式类型自动转换
  End If
  SUCCESS_t = SUCCESS_t And PUT_AD_SUCCESS
  If rs("p_answer") = "{pic}" Then
    Write_One_Cell_Unit "puzzles\" & rs("p_id") & "a", rs("p_id") & ":答案" & "", rs("p_answer") & "", 1 '为了表达式类型自动转换
    Total_Puzzle_Cells = Total_Puzzle_Cells + 2
  Else
    Answers_Group = Answers_Group & "[" & rs("p_id") & "]:" & rs("p_answer") & " "
    Temp_EOF = rs.EOF
    If Not Temp_EOF Then
      rs.MoveNext
      Mv_Nxt_YES = True
    End If
    If Clen(Answers_Group & "[" & rs("p_id") & "]:" & rs("p_answer")) > MAX_LEN_PER_CELL * 2 Or Temp_EOF Or i_puzzle = TOTAL_PUZZLE_NUM - 1 Then
      Write_One_Cell_Unit "puzzles\" & rs("p_id") & "a", "答案", Answers_Group, 1
      Total_Puzzle_Cells = Total_Puzzle_Cells + 2
      Answers_Group = ""
    End If
    If Mv_Nxt_YES = True Then
      rs.MovePrevious
      Mv_Nxt_YES = False
    End If
  End If
  SUCCESS_t = SUCCESS_t And PUT_AD_SUCCESS
  '如果插入成功,优先级减1
  If SUCCESS_t = True And TEST_i.Value = False Then conn.Execute ("update " & L_s & "puzzles" & R_s & " set p_pri=p_pri-1 where p_id=" & CStr(rs("p_id")))    '+ "'"
  If SUCCESS_t = True Then i_puzzle = i_puzzle + 1
  If SUCCESS_t = False Then MsgBox "插入失败: 迷题类  ID:" & rs("p_id") & Chr(13) & Chr(10) & "标题: " & rs("p_title")
  rs.MoveNext
Loop
rs.Close
Set rs = Nothing
conn.Close
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + Total_Puzzle_Cells
DoEvents
End Sub

Sub Put_Jokes()
'写笑话，字数超过 MAX_LEN_PER_CELL 的用多个单元格
On Error Resume Next
'Debug.Print "笑话" & BEGIN_ROWNUM_THIS_TYPE & "/" & END_ROWNUM_THIS_TYPE & "/" & ROWNUM
OPEN_JOKES_DB 0

FROM_LEFT_TO_RIGHT = 1
PUT_AD_SUCCESS = True

Dim temp_plus, H_cells As Integer
Dim left_null_cells_num, used_cells_num_by_jokes, touched_cells_num_by_jokes, clen_this_joke As Integer


DoEvents
used_cells_num_by_jokes = 0
touched_cells_num_by_jokes = 0
left_null_cells_num = Int((TOTAL_CELLS - TOTAL_CELLS_TOUCHED) / 2)
Do While True
  If rs_jokes.EOF Then
     CLOSE_JOKES_DB
     OPEN_JOKES_DB 1  '重新打开时长笑话优先,这与直接把游标移到第一个记录是不同的，因为用过的笑话优先级降低了
  End If
  DoEvents
  If used_cells_num_by_jokes >= left_null_cells_num Then
   TOTAL_CELLS_TOUCHED = TOTAL_CELLS
   Exit Sub
  End If

  ShowPercents_Status PROCESS_PERCENTS, "填充笑话:" + CStr(used_cells_num_by_jokes) + "/" + CStr(left_null_cells_num) & "(" & TOTAL_JOKE_NUM & ")-" & rs_jokes("j_title")
  clen_this_joke = Clen(rs_jokes("j_content"))
  temp_plus = 1
  If clen_this_joke / 2 > MAX_LEN_PER_CELL Then
    H_cells = Int(clen_this_joke / 2 / MAX_LEN_PER_CELL) + 1
    If H_cells > COLNUM Then H_cells = COLNUM
    Write_Multi_Cells_Unit rs_jokes("j_id") & "", rs_jokes("j_title") & "", rs_jokes("j_content") & "", H_cells, 1, 1, False '不保证多格插入成功
    touched_cells_num_by_jokes = touched_cells_num_by_jokes + H_cells
    If PUT_AD_SUCCESS = True Then used_cells_num_by_jokes = used_cells_num_by_jokes + H_cells
  Else
    Write_One_Cell_Unit rs_jokes("j_id") & "", rs_jokes("j_title") & "", rs_jokes("j_content") & "", 1
    touched_cells_num_by_jokes = touched_cells_num_by_jokes + 1
    If PUT_AD_SUCCESS = True Then used_cells_num_by_jokes = used_cells_num_by_jokes + 1
  End If
  If PUT_AD_SUCCESS = True Then
    PROCESS_PERCENTS = PROCESS_PERCENTS + (20# / left_null_cells_num / AD_TYPENUM)
    If PROCESS_PERCENTS > 84 Then PROCESS_PERCENTS = 84
    conn_jokes.Execute ("update " & L_s & "jokes" & R_s & " set j_pri=j_pri-1 where j_id=" & CStr(rs_jokes("j_id")))  '如果成功,优先级减1
  Else
    temp_plus = 0
  End If
  TOTAL_JOKE_NUM = TOTAL_JOKE_NUM + temp_plus
  rs_jokes.MoveNext
Loop
DoEvents
TOTAL_CELLS_TOUCHED = TOTAL_CELLS
CLOSE_JOKES_DB
End Sub

Sub Write_Multi_Cells_Unit(id As String, title As String, Content As String, horizontal_cells As Integer, vertical_cells As Integer, display_mode As Integer, must_success As Boolean)
'写一个广告或笑话等，占不同单元格数
'Debug.Print Content
On Error Resume Next
Dim Contact_Info_Start As Integer
Dim content_T As String
Dim begin_row, row_move_down, LOST_TOTAL_CELLS_TOUCHED As Integer
Dim Title_H, Ratio_H_V As Single '标题高度,原来纵横格数比例，使得尽量减小变形
DoEvents
LOST_TOTAL_CELLS_TOUCHED = horizontal_cells * vertical_cells   '减少每页格数会影响全部广告格数计数，这里计算影响的数量

If vertical_cells >= OLD_ROWNUM_PAGE / 2 Then vertical_cells = OLD_ROWNUM_PAGE / 2
If horizontal_cells >= OLD_COLNUM Then horizontal_cells = OLD_COLNUM

If KEEP_WHOLE_SIZE <> 0 And (vertical_cells >= OLD_ROWNUM_PAGE / 2 Or horizontal_cells >= OLD_COLNUM) Then
  horizontal_cells = CInt(CSng(horizontal_cells) * COLNUM / OLD_COLNUM)
  vertical_cells = CInt(CSng(vertical_cells) * ROWNUM_PAGE / OLD_ROWNUM_PAGE)
End If

row_move_down = 2
If vertical_cells * 2 = ROWNUM_PAGE - END_ROWNUM_LAST_TYPE Mod ROWNUM_PAGE Or vertical_cells = 1 Or vertical_cells >= ROWNUM_PAGE / 2 Or NO_CLASS_TITLE = 1 Or MIX_CLASS = 1 Then row_move_down = 0
If vertical_cells > ROWNUM_PAGE / 2 Then vertical_cells = ROWNUM_PAGE / 2
If horizontal_cells > COLNUM Then horizontal_cells = COLNUM
LOST_TOTAL_CELLS_TOUCHED = (LOST_TOTAL_CELLS_TOUCHED - horizontal_cells * vertical_cells) * 2
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED - LOST_TOTAL_CELLS_TOUCHED
title = Cut_CR(title)  '去掉回车
title = Trim(title)

Content = Merge_CRs(Content)  '合并多个回车
Content = Trim(Content)
'Content = Replace(Content, Chr(10) & "^|", "^|")
Contact_Info_Start = InStr(Content, "^|")
Content = Replace(Content, "^|", Chr(10))
If Right(Content, 1) = Chr(10) Then Content = Left(Content, InStrRev(Content, Chr(10)) - 1) '干掉最后的回车
If Left(Content, 1) = Chr(10) Then
  Content = Right(Content, Len(Content) - 1) '干掉最前的回车
  Contact_Info_Start = Contact_Info_Start - 1
End If
DoEvents

If Content = "{pic}" Then title = "" '内容如果是图，就没有标题，有也干掉

Dim row, col, Have_title As Integer
Dim Rows_Num, font_size As Single
Dim begin_col, end_col, step_col As Integer

begin_col = COLNUM
end_col = 1
step_col = -1
If FROM_LEFT_TO_RIGHT = 1 Then
  begin_col = 1
  end_col = COLNUM
  step_col = 1
End If


PUT_AD_SUCCESS = False
If display_mode <> 1 And display_mode <> 2 Then
  display_mode = 1
  If Clen(Content) < MODE_2_LEN * 2 * horizontal_cells * vertical_cells Then display_mode = 2
End If

Have_title = 0
'horizontal_cells=1时，从头开始，>=2时就从可以插入行(已标记)开始，这样可以减少遍历面积，加快速度，特别是插入笑话时
If INSERTING_COLNUM <> horizontal_cells Or INSERTING_ROWNUM <> vertical_cells Then
  INSERTING_COLNUM = horizontal_cells
  INSERTING_ROWNUM = vertical_cells
  BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = BEGIN_ROWNUM_THIS_TYPE
End If
begin_row = BEGIN_ROWNUM_THIS_TYPE + row_move_down
If BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 > begin_row Then begin_row = BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1
For row = begin_row To END_ROWNUM_THIS_TYPE Step 2
 For col = begin_col To end_col Step step_col
   DoEvents
   cellid = CStr(col) + ":" + CStr(row) + ":" + CStr(col + horizontal_cells - 1) + ":" + CStr(row + vertical_cells * 2 - 1)
   clr_index = (col + row + 237) Mod 6 + 1
   If horizontal_cells + col - 1 <= COLNUM And (Int((row - 1) / 2) Mod (ROWNUM_PAGE / 2)) + 1 + vertical_cells - 1 <= ROWNUM_PAGE / 2 And All_Null(cellid) Then
     For iiii = col To col + horizontal_cells - 1
       For jjjj = (row + 1) / 2 To (row + vertical_cells * 2 - 1) / 2
         ARRAY_FOR_SCAN(iiii, jjjj) = 1
       Next jjjj
     Next iiii
     If title <> "" And display_mode = 1 Then '如果广告标题不为空，并且第1种模式显示，则不合并标题行和内容行
     '标题行
     cellid = COLSTR(col) + CStr(row) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row)
     font_size = COLW * mm2POINT / mm2COLUMN_UNIT * 2 / Clen(title) * horizontal_cells - 1 '
     If font_size > ROWH1 Then font_size = ROWH1
     Range(cellid).HorizontalAlignment = xlCenter
     'Range(cellid).ShrinkToFit = True
     Range(cellid).Font.Name = TOPIC_FONT_NAME1
     DoEvents
     Range(cellid).Font.Size = font_size  '14
     Range(cellid).Font.Color = RGB(255, 255, 255)
     DoEvents
     Range(cellid).Merge
     Range(cellid).Value = title
     If TOPIC_WHITE_BLACK = 1 Then
        Range(cellid).Interior.Color = RGB(48 * ((col + row) Mod 3), 48 * ((col + row) Mod 3), 48 * ((col + row) Mod 3))
     Else
        Range(cellid).Interior.Color = RGB(Dark_Colors(clr_index, 1), Dark_Colors(clr_index, 2), Dark_Colors(clr_index, 3))
     End If
     Have_title = 1
     End If
     DoEvents
     '内容,多行
     If title <> "" And display_mode = 2 Then
       content_T = title & Chr(10) & Content
       Contact_Info_Start = Contact_Info_Start + Len(title) + 1
     Else
       content_T = Content
       If vertical_cells > 1 Then content_T = Chr(10) & content_T & Chr(10)
     End If
     cellid = COLSTR(col) + CStr(row + Have_title) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row + vertical_cells * 2 - 1)
     Range(cellid).HorizontalAlignment = xlLeft
     If display_mode = 1 Then Range(cellid).VerticalAlignment = xlJustify
     Range(cellid).WrapText = True
     DoEvents
     Range(cellid).Merge
     Range(cellid).Value = content_T
     Range(cellid).Font.Name = "宋体"
     DoEvents
     If Contact_Info_Start > 0 Then
         Range(cellid).Select
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = TOPIC_FONT_NAME1
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = "Arial Narrow"
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.FontStyle = "加粗"
     End If
     DoEvents
          Title_H = ROWH1 * RowHeight2FontSize
     If title = "" Then Title_H = 0
     font_size = Calculate_Font_Size(Content, horizontal_cells, vertical_cells, Title_H) + FONT_SIZE_ADJUST
     ActiveSheet.Range(cellid).Font.Size = font_size
     DoEvents
     '处理第2种显示模式
     If title <> "" And display_mode = 2 Then
       Dim T_clen As Integer
       T_clen = Int((Clen(title) + 1) / 2)
       If T_clen < 1 Then T_clen = 1
       If T_clen > 10 Then T_clen = 10
       font_size = (DISPLAY_MODE_2_FONT_SIZE(T_clen) * horizontal_cells * COLW / 14.27) + FONT_SIZE_ADJUST
       Max_F = ROWH * vertical_cells * RowHeight2FontSize / 2
       If font_size > Max_F Then font_size = Max_F
   
       With ActiveCell.Characters(Start:=1, Length:=Len(title)).Font
        .Name = TOPIC_FONT_NAME2
        .FontStyle = "常规"
        .Size = CInt(font_size * 0.9)  '为了不出格
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
       End With
       DoEvents
       font_size = Calculate_Font_Size(Content, horizontal_cells, vertical_cells, font_size) + FONT_SIZE_ADJUST
       With ActiveCell.Characters(Start:=Len(title) + 2, Length:=Len(content_T)).Font
        .Size = font_size
       End With
       DoEvents
       Range(cellid).HorizontalAlignment = xlCenter
     End If
     DoEvents
     '处理图像
     If Content = "{pic}" Then
       Range(cellid).Select
       pic_name = MY_DOC_PATH & "\《开心情报站》文档\database\pic\" & id
       If id = "kxqbz_ad" Then pic_name = App.Path & "\kxqbz_ad"
       ActiveSheet.Pictures.Insert(pic_name & ".jpg").Select
       Selection.ShapeRange.LockAspectRatio = msoFalse
       Selection.ShapeRange.ZOrder msoSendToBack
       Selection.ShapeRange.IncrementLeft PIC_LEFT
       Selection.ShapeRange.IncrementTop PIC_TOP
       DoEvents
       Selection.ShapeRange.Height = Range(cellid).Height - PIC_BOTTOM
       Selection.ShapeRange.Width = Range(cellid).Width - PIC_RIGHT '* COLUMN_UNIT2PIXEL
       Selection.Locked = False
       If id = "kxqbz_ad" Then Selection.Locked = True   '锁定开心情报站的广告，试用版时不能编辑它
       PIC_NUM = PIC_NUM + 1
     End If
     PUT_AD_SUCCESS = True
     BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = row
     cellid = COLSTR(col) + CStr(row) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row + vertical_cells * 2 - 1)
     Set_Cell_Border_When_Write (cellid)
     Exit Sub
   End If
 Next col
Next row

'以下代码确保插入成功,当是付费广告时要这样,而如果是免费广告,则不确保成功，确保成功的原因是必要时增加行，在切过页之后不能使用
If must_success = True Then
 Do While PUT_AD_SUCCESS = False
   DoEvents
   ActiveSheet.Range("A" + CStr(END_ROWNUM_THIS_TYPE + 1)).RowHeight = ROWH1
   DoEvents
   ActiveSheet.Range("A" + CStr(END_ROWNUM_THIS_TYPE + 2)).RowHeight = ROWH2

   END_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 2
   ROWNUM = ROWNUM + 2
   ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)

    Have_title = 0
    For row = begin_row To END_ROWNUM_THIS_TYPE Step 2
     For col = begin_col To end_col Step step_col
       DoEvents
       cellid = CStr(col) + ":" + CStr(row) + ":" + CStr(col + horizontal_cells - 1) + ":" + CStr(row + vertical_cells * 2 - 1)
       clr_index = (col + row + 237) Mod 6 + 1
       If horizontal_cells + col - 1 <= COLNUM And (Int((row - 1) / 2) Mod (ROWNUM_PAGE / 2)) + 1 + vertical_cells - 1 <= ROWNUM_PAGE / 2 And All_Null(cellid) Then
        For iiii = col To col + horizontal_cells - 1
            For jjjj = (row + 1) / 2 To (row + vertical_cells * 2 - 1) / 2
               ARRAY_FOR_SCAN(iiii, jjjj) = 1
            Next jjjj
        Next iiii
        'cellid = COLSTR(col) + CStr(row) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row + vertical_cells * 2 - 1)
        'Set_Cell_Border_When_Write (cellid)
        If title <> "" And display_mode = 1 Then '如果广告标题不为空，并且第1种模式显示，则不合并标题行和内容行
         '标题行
         cellid = COLSTR(col) + CStr(row) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row)
         font_size = COLW * mm2POINT / mm2COLUMN_UNIT * 2 / Clen(title) * horizontal_cells - 1
         If font_size > ROWH1 Then font_size = ROWH1
         Range(cellid).HorizontalAlignment = xlCenter
         Range(cellid).Font.Name = TOPIC_FONT_NAME1
         Range(cellid).Font.Size = font_size  '14
         Range(cellid).Font.Color = RGB(255, 255, 255)
         DoEvents
         Range(cellid).Merge
         Range(cellid).Value = title
         If TOPIC_WHITE_BLACK = 1 Then
            Range(cellid).Interior.Color = RGB(48 * ((col + row) Mod 3), 48 * ((col + row) Mod 3), 48 * ((col + row) Mod 3))
         Else
            Range(cellid).Interior.Color = RGB(Dark_Colors(clr_index, 1), Dark_Colors(clr_index, 2), Dark_Colors(clr_index, 3))
         End If
         Have_title = 1
         End If
         DoEvents
         '内容,多行
         If title <> "" And display_mode = 2 Then
           content_T = title & Chr(10) & Content
           Contact_Info_Start = Contact_Info_Start + Len(title) + 1
         Else
           content_T = Content
           If vertical_cells > 1 Then content_T = Chr(10) & content_T & Chr(10)
         End If
         cellid = COLSTR(col) + CStr(row + Have_title) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row + vertical_cells * 2 - 1)
         Range(cellid).HorizontalAlignment = xlLeft
         If display_mode = 1 Then Range(cellid).VerticalAlignment = xlJustify
         Range(cellid).WrapText = True
         Range(cellid).Merge
         DoEvents
         Range(cellid).Value = content_T
         Range(cellid).Font.Name = "宋体"
         If Contact_Info_Start > 0 Then
           Range(cellid).Select
           ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = TOPIC_FONT_NAME1
           ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = "Arial Narrow"
           ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.FontStyle = "加粗"
         End If
         Title_H = ROWH1 * RowHeight2FontSize
         If title = "" Then Title_H = 0
         font_size = Calculate_Font_Size(Content, horizontal_cells, vertical_cells, Title_H) + FONT_SIZE_ADJUST
         ActiveSheet.Range(cellid).Font.Size = font_size
         DoEvents
         '处理第2种显示模式
         If title <> "" And display_mode = 2 Then
           T_clen = Int((Clen(title) + 1) / 2)
           If T_clen < 1 Then T_clen = 1
           If T_clen > 10 Then T_clen = 10
           font_size = (DISPLAY_MODE_2_FONT_SIZE(T_clen) * horizontal_cells * COLW / 14.27) + FONT_SIZE_ADJUST
           Max_F = ROWH * vertical_cells * RowHeight2FontSize / 2
           If font_size > Max_F Then font_size = Max_F

           With ActiveCell.Characters(Start:=1, Length:=Len(title)).Font
            .Name = TOPIC_FONT_NAME2
            .FontStyle = "常规"
            .Size = CInt(font_size * 0.9)  '为了不出格
            .Strikethrough = False
            .Superscript = False
            .Subscript = False
            .OutlineFont = False
            .Shadow = False
            .Underline = xlUnderlineStyleNone
            .ColorIndex = xlAutomatic
           End With
           DoEvents
           font_size = Calculate_Font_Size(Content, horizontal_cells, vertical_cells, font_size) + FONT_SIZE_ADJUST
           With ActiveCell.Characters(Start:=Len(title) + 2, Length:=Len(content_T)).Font
            .Size = font_size
           End With
           DoEvents
           Range(cellid).HorizontalAlignment = xlCenter
         End If
         DoEvents
         '处理图像
         If Content = "{pic}" Then
           Range(cellid).Select
           pic_name = MY_DOC_PATH & "\《开心情报站》文档\database\pic\" & id
           If id = "kxqbz_ad" Then pic_name = App.Path & "\kxqbz_ad"
           ActiveSheet.Pictures.Insert(pic_name & ".jpg").Select
           Selection.ShapeRange.LockAspectRatio = msoFalse
           Selection.ShapeRange.ZOrder msoSendToBack
           Selection.ShapeRange.IncrementLeft PIC_LEFT
           Selection.ShapeRange.IncrementTop PIC_TOP
           DoEvents
           Selection.ShapeRange.Height = Range(cellid).Height - PIC_BOTTOM
           Selection.ShapeRange.Width = Range(cellid).Width - PIC_RIGHT '* COLUMN_UNIT2PIXEL
           Selection.Locked = False
           If id = "kxqbz_ad" Then Selection.Locked = True   '锁定开心情报站的广告，试用版时不能编辑它
           PIC_NUM = PIC_NUM + 1
         End If
         PUT_AD_SUCCESS = True
         BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = row
         cellid = COLSTR(col) + CStr(row) + ":" + COLSTR(col + horizontal_cells - 1) + CStr(row + vertical_cells * 2 - 1)
         Set_Cell_Border_When_Write (cellid)
         Exit Sub
       End If
     Next col
    Next row
    Loop
End If  '若确保插入成功 结束
'程序执行到这里,意味着插入失败,只在不保证成功插入时才会发生,这时不必理会,免费的不成功也无所谓,会自动插入下一条免费的,因此不必提示了
'MsgBox "插入失败: 第" & AD_TYPE & "类[" & NAME_THIS_TYPE & "] 占用单元格: " & horizontal_cells & "x" & vertical_cells & chr(13) & chr(10) & "广告标题: " & title
DoEvents
End Sub
Sub Write_One_Cell_Unit(id As String, title As String, Content As String, display_mode As Integer)
'按顺序写一个单个单元格的 广告或笑话等
On Error Resume Next
Dim Contact_Info_Start As Integer
Dim Title_H As Single '标题高度
DoEvents
title = Cut_CR(title)  '去掉回车
title = Trim(title)
Content = Merge_CRs(Content)  '合并多个回车
Content = Trim(Content)
'Content = Replace(Content, Chr(10) & "^|", "^|")
Contact_Info_Start = InStr(Content, "^|")
Content = Replace(Content, "^|", Chr(10))
If Right(Content, 1) = Chr(10) Then Content = Left(Content, InStrRev(Content, Chr(10)) - 1) '干掉最后的回车
If Left(Content, 1) = Chr(10) Then
  Content = Right(Content, Len(Content) - 1) '干掉最前的回车
  Contact_Info_Start = Contact_Info_Start - 1
End If

If Content = "{pic}" Then title = "" '内容如果是图，就没有标题，有也干掉

Dim row, col, Have_title As Integer
Dim Rows_Num, font_size As Single
Dim begin_col, end_col, step_col As Integer

begin_col = COLNUM
end_col = 1
step_col = -1
If FROM_LEFT_TO_RIGHT = 1 Then
  begin_col = 1
  end_col = COLNUM
  step_col = 1
End If

begin_row = BEGIN_ROWNUM_THIS_TYPE
PUT_AD_SUCCESS = False
Have_title = 0
If display_mode <> 1 And display_mode <> 2 Then
  display_mode = 1
  If Clen(Content) < MODE_2_LEN * 2 Then display_mode = 2
End If
Do While PUT_AD_SUCCESS = False
 DoEvents
  For row = begin_row To END_ROWNUM_THIS_TYPE Step 2
   For col = begin_col To end_col Step step_col
    cellid = CStr(col) + ":" + CStr(row) + ":" + CStr(col) + ":" + CStr(row + 1)
    clr_index = (col + row + 237) Mod 6 + 1
    If All_Null(cellid) Then
     ARRAY_FOR_SCAN(col, (row + 1) / 2) = 1
     If title <> "" And display_mode = 1 Then '如果广告标题不为空，并且第1种模式显示，则不合并标题行和内容行
        '标题
        cellid = COLSTR(col) + CStr(row)
        font_size = COLW * mm2POINT / mm2COLUMN_UNIT * 2 / Clen(title) - 1
        If font_size > ROWH1 Then font_size = ROWH1
        Range(cellid).HorizontalAlignment = xlCenter
        Range(cellid).Font.Name = TOPIC_FONT_NAME1
        Range(cellid).Font.Size = font_size '14
        Range(cellid).Font.Color = RGB(255, 255, 255)
        DoEvents
        Range(cellid).Value = title
        If TOPIC_WHITE_BLACK = 1 Then
           Range(cellid).Interior.Color = RGB(48 * ((col + row) Mod 3), 48 * ((col + row) Mod 3), 48 * ((col + row) Mod 3))
        Else
           Range(cellid).Interior.Color = RGB(Dark_Colors(clr_index, 1), Dark_Colors(clr_index, 2), Dark_Colors(clr_index, 3))
        End If
        Have_title = 1
     End If
     DoEvents
     '内容
     If title <> "" And display_mode = 2 Then
       Content = title & Chr(10) & Content
       Contact_Info_Start = Contact_Info_Start + Len(title) + 1
     End If
     cellid = COLSTR(col) + CStr(row + Have_title) + ":" + COLSTR(col) + CStr(row + 1)
     Range(cellid).HorizontalAlignment = xlLeft
     Range(cellid).WrapText = True
     Range(cellid).Merge
     DoEvents
     Range(cellid).Value = Content
     Range(cellid).Font.Name = "宋体"
     If Contact_Info_Start > 0 Then
         Range(cellid).Select
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = TOPIC_FONT_NAME1
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = "Arial Narrow"
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.FontStyle = "加粗"
     End If
     Title_H = ROWH1 * RowHeight2FontSize
     If title = "" Then Title_H = 0
     font_size = Calculate_Font_Size(Content, 1, 1, Title_H) + FONT_SIZE_ADJUST
     ActiveSheet.Range(cellid).Font.Size = font_size
     DoEvents
     '处理第2种显示模式
     If title <> "" And display_mode = 2 Then
       Dim T_clen As Integer
       T_clen = Int((Clen(title) + 1) / 2)
       If T_clen < 1 Then T_clen = 1
       If T_clen > 10 Then T_clen = 10
       font_size = DISPLAY_MODE_2_FONT_SIZE(T_clen) * COLW / 14.27
       Max_F = ROWH * RowHeight2FontSize / 2
       If font_size > Max_F Then font_size = Max_F
       With ActiveCell.Characters(Start:=1, Length:=Len(title)).Font
        .Name = TOPIC_FONT_NAME2
        .FontStyle = "常规"
        .Size = font_size - 1 '为了不出格
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
        .ColorIndex = xlAutomatic
       End With
       DoEvents
       font_size = Calculate_Font_Size(Content, 1, 1, font_size) + FONT_SIZE_ADJUST
       With ActiveCell.Characters(Start:=Len(title) + 2, Length:=Len(Content)).Font
        .Size = font_size
       End With
       DoEvents
       Range(cellid).HorizontalAlignment = xlCenter
     End If
     DoEvents
     '处理图像
     If Content = "{pic}" Then
       Range(cellid).Select
       ActiveSheet.Pictures.Insert(MY_DOC_PATH & "\《开心情报站》文档\database\pic\" & id & ".jpg").Select
       Selection.ShapeRange.LockAspectRatio = msoFalse
       Selection.ShapeRange.ZOrder msoSendToBack
       Selection.ShapeRange.IncrementLeft PIC_LEFT
       Selection.ShapeRange.IncrementTop PIC_TOP
       DoEvents
       Selection.ShapeRange.Height = Range(cellid).Height - PIC_BOTTOM
       Selection.ShapeRange.Width = Range(cellid).Width - PIC_RIGHT '* COLUMN_UNIT2PIXEL
       Selection.Locked = False
       PIC_NUM = PIC_NUM + 1
     End If
     cellid = COLSTR(col) + CStr(row) + ":" + COLSTR(col) + CStr(row + 1)
     Set_Cell_Border_When_Write (cellid)
     PUT_AD_SUCCESS = True
     Exit Sub
   End If
  Next col
 Next row
 ActiveSheet.Range("A" + CStr(END_ROWNUM_THIS_TYPE + 1)).RowHeight = ROWH1
 ActiveSheet.Range("A" + CStr(END_ROWNUM_THIS_TYPE + 2)).RowHeight = ROWH2
 begin_row = END_ROWNUM_THIS_TYPE + 1
 END_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 2
 ROWNUM = ROWNUM + 2
 ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
Loop
DoEvents
End Sub

Function Calculate_Font_Size(ByVal Content As String, H_cells As Integer, V_cells As Integer, ByVal Topic_Height As Single) As Single '计算广告格中内容的字号
Dim n, L As Integer  '回车个数，内容长度
Dim H, W, FontSize As Single   '格高度，宽度
'FontSize = (Sqr(N * N + 4 * L / W * H) - N) / (2 * N / W)
'Topic_Height 是标题行高度(以字号为单位)，模式1时等于ROWH1 * RowHeight2FontSize, 模式2时等于标题行字号

n = Num_Of_CR(Content) + 1
L = Clen(Content) / 2
H = ROWH * V_cells * RowHeight2FontSize - Topic_Height
W = COLW * H_cells * ColWidth2FontSize
If L <= 0 Or W <= 0 Then
 Calculate_Font_Size = MIN_FONT_SIZE
 Exit Function
End If
FontSize = (Sqr(n * n + 4 * L / W * H) - n) / (2 * L / W)
If FontSize > MAX_FONT_SIZE Then FontSize = MAX_FONT_SIZE
If FontSize < MIN_FONT_SIZE Then FontSize = MIN_FONT_SIZE
Calculate_Font_Size = FontSize
End Function


Function COLSTR(ByVal column_number As Integer) As String
Dim First_Letter, Second_Letter As String
First_Letter = ""
If column_number > 26 Then
  First_Letter = Chr(Int(column_number / 26) + 64)
End If
Second_Letter = Chr((column_number - 1) Mod 26 + 1 + 64)
COLSTR = First_Letter & Second_Letter
End Function


Function All_Null(cellid As String) As Boolean
  Dim ii() As String
  Dim col_b, col_end, row_b, row_e As Integer
  ii = Split(cellid, ":")
  col_b = CInt(ii(0))
  row_b = (CInt(ii(1)) + 1) / 2
  col_e = CInt(ii(2))
  row_e = CInt(ii(3)) / 2
  All_Null = True
  If col_e > COLNUM Or row_e > END_ROWNUM_THIS_TYPE / 2 Then
    All_Null = False
    Exit Function
  End If
  For iiii = col_b To col_e
   For jjjj = row_b To row_e
     DoEvents
     If ARRAY_FOR_SCAN(iiii, jjjj) = 1 Then
       All_Null = False
       Exit Function
     End If
   Next jjjj
  Next iiii
End Function

Sub Get_Total_Cells_Num_Ads_And_Income_This_Type(a_type As Integer)
'计算每类广告(不包括免费的)占多少个cell(excel原来的单元格),存入TOTAL_ADS_CELLS_THIS_TYPE, 并存该类广告总条数到 TOTAL_ADS_NUM_THIS_TYPE
'同时,累加全部广告总数存入 TOTAL_ADS_NUM 中,累加全部cell数存入TOTAL_ADS_CELLS
'存总收入 INCOME

TP_s = " where a_type=" & CStr(a_type)
If MIX_CLASS = 1 Then TP_s = ""
conn.Open DSN_NAME
SQL_Str = "select a_col,a_row from " & L_s & "ads_publish" & R_s & TP_s
rs.Open SQL_Str, conn, 2, 2
DoEvents
TOTAL_ADS_NUM_THIS_TYPE = 0    'rs.RecordCount 这种open方法不支持
TOTAL_ADS_CELLS_THIS_TYPE = 0
Do While Not rs.EOF
  DoEvents
  TOTAL_ADS_NUM_THIS_TYPE = TOTAL_ADS_NUM_THIS_TYPE + 1
  TOTAL_ADS_CELLS_THIS_TYPE = TOTAL_ADS_CELLS_THIS_TYPE + rs("a_col") * rs("a_row")
  rs.MoveNext
Loop
TOTAL_ADS_CELLS_THIS_TYPE = TOTAL_ADS_CELLS_THIS_TYPE * 2
TOTAL_ADS_CELLS = TOTAL_ADS_CELLS + TOTAL_ADS_CELLS_THIS_TYPE
TOTAL_ADS_NUM = TOTAL_ADS_NUM + TOTAL_ADS_NUM_THIS_TYPE
INCOME = INCOME + TOTAL_ADS_CELLS_THIS_TYPE / 2 * PRICE_THIS_TYPE
If Not rs.EOF Then rs.MoveFirst
rs.Close
conn.Close
DoEvents
End Sub


Sub Get_Type_Name_And_Price(a_type As Integer)
'取广告类别名称，存入NAME_THIS_TYPE,价格存入 PRICE_THIS_TYPE

conn.Open DSN_NAME
If MIX_CLASS = 1 Then
  NAME_THIS_TYPE = "混类"
  SQL_Str = "select t_price from " & L_s & "types" & R_s
  rs.Open SQL_Str, conn, 2, 2
  Do While Not rs.EOF
    DoEvents
    PRICE_THIS_TYPE = PRICE_THIS_TYPE + rs("t_price")
    ijj = ijj + 1
    rs.MoveNext
  Loop
  rs.Close
  conn.Close
  PRICE_THIS_TYPE = Int(PRICE_THIS_TYPE / ijj + 0.5)
  Exit Sub
End If
SQL_Str = "select t_name,t_price from " & L_s & "types" & R_s & " where t_id=" + CStr(a_type)
rs.Open SQL_Str, conn, 2, 2
DoEvents
NAME_THIS_TYPE = rs("t_name")
PRICE_THIS_TYPE = rs("t_price")
rs.Close
conn.Close
DoEvents
End Sub

Sub Get_Type_Num()
'取广告类别总数，存入AD_TYPENUM

conn.Open DSN_NAME
SQL_Str = "select t_name from " & L_s & "types" & R_s & ""
rs.Open SQL_Str, conn, 2, 2
DoEvents
AD_TYPENUM = 0   'rs.RecordCount不支持
Do While Not rs.EOF
  DoEvents
  AD_TYPENUM = AD_TYPENUM + 1
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
End Sub
Sub Get_Total_Ads_Num_Rouphly()
'取广告类别总数，存入TOTAL_ADS_NUM_ROUPH
'On Error Resume Next
conn.Open DSN_NAME
'If Err.Number = -2147467259 Then Resume '可能出错误，可以忽略错误
SQL_Str = "select a_id from " & L_s & "ads_publish" & R_s & ""

rs.Open SQL_Str, conn, 2, 2
'-2147467259 系统不支持的选择排序。微软官方说：这个错误编译后就不存在了
'这个错误参见 sub SET_DSN_NAME()
'另一个错误 不支持的ISAM 错误号相同，应是同一个错误，也可以不理会

DoEvents
TOTAL_ADS_NUM_ROUPH = 0  'rs.RecordCount 不支持
Do While Not rs.EOF
  DoEvents
  TOTAL_ADS_NUM_ROUPH = TOTAL_ADS_NUM_ROUPH + 1
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
End Sub

Sub Format_Final_Cells()
'这个sub要在Put_Jokes前执行，执行完Put_Jokes再Cut_Page.这样大大提高速度，原因不知道。
ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To FINAL_ROWNUM / 2 + 1)
DoEvents
PROCESS_PERCENTS = PROCESS_PERCENTS + 1
For i = END_ROWNUM_THIS_TYPE + 1 To FINAL_ROWNUM Step 2
   ShowPercents_Status PROCESS_PERCENTS, "格式化剩余版面:" & i & "/" & FINAL_ROWNUM
   DoEvents
   ActiveSheet.Range("A" + CStr(i)).RowHeight = ROWH1
   ActiveSheet.Range("A" + CStr(i + 1)).RowHeight = ROWH2
Next i
TOTAL_CELLS = (TOTAL_PAGE_NUM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM) * ROWNUM_PAGE * COLNUM
DoEvents
End Sub
Sub Cut_Page()
'切开各页
Dim CUT_POINT  As Long
CUT_POINT = ROWNUM_PAGE + 1
ROWNUM = FINAL_ROWNUM
Do While CUT_POINT < ROWNUM
   DoEvents
   PROCESS_PERCENTS = PROCESS_PERCENTS + (2# * ROWNUM_PAGE / ROWNUM)
   ShowPercents_Status PROCESS_PERCENTS, "分页:" + CStr(Int(CUT_POINT / ROWNUM_PAGE)) + "/" + CStr(TOTAL_PAGE_NUM - PGNM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM)
   ActiveSheet.HPageBreaks.Add BEFORE:=Range("A" + CStr(CUT_POINT))
   DoEvents
   CUT_POINT = CUT_POINT + ROWNUM_PAGE
Loop
End Sub


Sub Set_Cell_Border_When_Write(cellid As String)
'边框
If TRANSP_LINE = 0 Then    '如果边框不透明
    ActiveSheet.Range(cellid).Select
    With Selection.Borders(xlEdgeLeft)
        .LineStyle = Cell_Border_Line_Style
        .Weight = Cell_Border_Line_Width
        .ColorIndex = 1
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = Cell_Border_Line_Style
        .Weight = Cell_Border_Line_Width
        .ColorIndex = 1
    End With
    DoEvents
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = Cell_Border_Line_Style
        .Weight = Cell_Border_Line_Width
        .ColorIndex = 1
    End With
    With Selection.Borders(xlEdgeRight)
        .LineStyle = Cell_Border_Line_Style
        .Weight = Cell_Border_Line_Width
        .ColorIndex = 1
    End With
End If
End Sub


Sub Put_Front_Cover()
  On Error GoTo ErrHandler:
  PROCESS_PERCENTS = PROCESS_PERCENTS + 1
  If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
  ShowPercents_Status PROCESS_PERCENTS, "处理封面..."
  DoEvents
  xlapp.EnableEvents = False
  Workbooks.Open MY_DOC_PATH & "\《开心情报站》文档\封面封底模板\frontcover.xls"
  xlapp.EnableEvents = True   '允许excel程序检测它的事件，为了在打开其他xls文件时不合排版文件占用一个进程，以免窜排
  DoEvents
  Workbooks(WORKBOOKNAME).Activate
  DoEvents
  Workbooks("frontcover.xls").Worksheets(1).Copy BEFORE:=ActiveWorkbook.Worksheets("内页")
  DoEvents
  ActiveSheet.DisplayAutomaticPageBreaks = True
  DoEvents
  cid = Find_Cellid_With_Mark("{{KXQBZ_LOGO}}")
  Range(cid).Select  '开心情报站LOGO
  Range(cid).Value = ""
  ActiveSheet.Pictures.Insert(App.Path & "\k-logo.jpg").Select
  Selection.ShapeRange.LockAspectRatio = msoTrue
  Selection.ShapeRange.ZOrder msoSendToBack
  Selection.ShapeRange.Height = Range(cid).MergeArea.Height
  If Selection.ShapeRange.Width > Range(cid).MergeArea.Width Then Selection.ShapeRange.Width = Range(cid).MergeArea.Width
  Selection.ShapeRange.IncrementLeft 0
  Selection.ShapeRange.IncrementTop Abs(Selection.ShapeRange.Height - Range(cid).MergeArea.Height)
  Selection.ShapeRange.PictureFormat.TransparentBackground = msoTrue
  Selection.ShapeRange.PictureFormat.TransparencyColor = RGB(255, 255, 255)
  Selection.ShapeRange.Fill.Visible = msoFalse
  Selection.Locked = False
  DoEvents
  cid = Find_Cellid_With_Mark("{{YOUR_LOGO}}")
  Range(cid).Select  '贵公司LOGO
  Range(cid).Value = ""
  ActiveSheet.Pictures.Insert(YOURLOGOPATH).Select
  Selection.ShapeRange.LockAspectRatio = msoTrue
  Selection.ShapeRange.ZOrder msoSendToBack
  Selection.ShapeRange.Height = Range(cid).MergeArea.Height - PIC_BOTTOM
  If Selection.ShapeRange.Width > Range(cid).MergeArea.Width - PIC_RIGHT Then Selection.ShapeRange.Width = Range(cid).MergeArea.Width - PIC_RIGHT
  Selection.ShapeRange.IncrementLeft Abs(Selection.ShapeRange.Width - (Range(cid).MergeArea.Width - PIC_RIGHT)) / 2
  Selection.ShapeRange.IncrementTop Abs(Selection.ShapeRange.Height - (Range(cid).MergeArea.Height - PIC_BOTTOM)) / 2
  Selection.ShapeRange.PictureFormat.TransparentBackground = msoTrue
  Selection.ShapeRange.PictureFormat.TransparencyColor = RGB(255, 255, 255)
  Selection.ShapeRange.Fill.Visible = msoFalse
  Selection.Locked = False

  cid = Find_Cellid_With_Mark("{{I_NO}}")
  Range(cid).Value = ISSUE_NUM
  DoEvents
  cid = Find_Cellid_With_Mark("{{DATE}}")
  Range(cid).Value = "总第" + CStr(TOTAL_ISSUE_NUM) + "期" & Chr(10) & ISSUE_DATE_CHR & Chr(10) & "本期" + CStr(TOTAL_PAGE_NUM) + "版"
  cid = Find_Cellid_With_Mark("{{INDEX}}")
  Range(cid).Value = COVER_CONTENTS
  cid = Find_Cellid_With_Mark("{{INFO_OF_YOUR_COMPANY}}")
  Range(cid).Value = COMPANYINFO
  cid = Find_Cellid_With_Mark("{{HOT_LINE}}")
  Range(cid).Value = "热线:" & HOTLINE
  DoEvents
  Workbooks("frontcover.xls").Close
  DoEvents
  GoTo END_SUB:
ErrHandler: ErrProc "封面编辑错误 - Put_Front_Cover"
END_SUB:
End Sub

Function Find_Cellid_With_Mark(ByVal Mark As String) As String   '不区分大小写
  r = ActiveSheet.UsedRange.Rows.Count
  c = ActiveSheet.UsedRange.Columns.Count
  m = UCase(Mark)
  For i = 1 To c
    For ii = 1 To r
      cellid = COLSTR(i) + CStr(ii)
      v = UCase(Range(cellid).Value)
      If InStr(v, m) > 0 Then
        Find_Cellid_With_Mark = cellid
        Exit Function
      End If
    Next ii
    Next i
    MsgBox "您可能改动了模版，找不到标记:" & Mark
    Find_Cellid_With_Mark = ""
End Function


Sub Put_Back_Cover()
  On Error GoTo ErrHandler:
  PROCESS_PERCENTS = PROCESS_PERCENTS + 1  '98%
  If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
  ShowPercents_Status PROCESS_PERCENTS, "处理封底..."
  DoEvents
  xlapp.EnableEvents = False
  Workbooks.Open MY_DOC_PATH & "\《开心情报站》文档\封面封底模板\backcover.xls"
  xlapp.EnableEvents = True   '允许excel程序检测它的事件，为了在打开其他xls文件时不合排版文件占用一个进程，以免窜排
  DoEvents
  Workbooks(WORKBOOKNAME).Activate
  DoEvents
  Workbooks("backcover.xls").Worksheets(1).Copy AFTER:=ActiveWorkbook.Worksheets("内页")
  DoEvents
  Workbooks("backcover.xls").Close
  DoEvents
  GoTo END_SUB:
ErrHandler: ErrProc "封底编辑错误 - Put_Back_Cover"
END_SUB:

End Sub

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

Sub Define_Display_Mode_2_Font_Size()
'以汉字、1个内容单元格计算
DISPLAY_MODE_2_FONT_SIZE(1) = 36
DISPLAY_MODE_2_FONT_SIZE(2) = 36
DISPLAY_MODE_2_FONT_SIZE(3) = 26
DISPLAY_MODE_2_FONT_SIZE(4) = 20
DISPLAY_MODE_2_FONT_SIZE(5) = 16
DISPLAY_MODE_2_FONT_SIZE(6) = 14
DISPLAY_MODE_2_FONT_SIZE(7) = 12
DISPLAY_MODE_2_FONT_SIZE(8) = 10
DISPLAY_MODE_2_FONT_SIZE(9) = 9
DISPLAY_MODE_2_FONT_SIZE(10) = 8
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
End Sub


Function Cut_CR(str As String) As String
  Cut_CR = Replace(str, vbCrLf, "")
  Cut_CR = Replace(Cut_CR, Chr(10), "")
End Function

Function Merge_CRs(SrcStr As String) As String
'合并多个回车换行为一个
    SrcStr = Replace(SrcStr, Chr(13), "")
    Merge_CRs = SrcStr
    Do While InStr(Merge_CRs, Chr(10) & Chr(10)) <> 0
     DoEvents
     Merge_CRs = Replace(Merge_CRs, Chr(10) & Chr(10), Chr(10))
    Loop
End Function

Function Num_Of_CR(ByVal str As String) As Integer
'计算一个字符串中有多少个换行
  Dim L As Integer
  Num_Of_CR = 0
  L = Len(str)
  For i = 1 To L
   DoEvents
   If Mid(str, i, 1) = Chr(10) Then Num_Of_CR = Num_Of_CR + 1
  Next i
End Function
Function CWidth(ByVal str As String) As Integer
'计算一个带有多个换行回车的字符串显示出来占多宽,以多少个西文字符计
  Dim L, m() As String
  L = str
  L = Replace(str, vbCrLf, Chr(10))
  L = L & Chr(10) & "{{[[[[[{end}}}"
  m = Split(L, Chr(10))
  i = 0
  CWidth = 0
  Do While m(i) <> "{{[[[[[{end}}}"
    DoEvents
    n = Clen(m(i))
    If n > CWidth Then CWidth = n
    i = i + 1
  Loop
  
End Function

Function Have_Ads_This_Type(a_type As Integer) As Boolean
    Have_Ads_This_Type = False
    TP_s = " where a_type=" & CStr(a_type)
    If MIX_CLASS = 1 Then TP_s = ""
    conn.Open DSN_NAME
    SQL_Str = "select a_col,a_row from " & L_s & "ads_publish" & R_s & TP_s
    rs.Open SQL_Str, conn, 2, 2
    If Not rs.EOF Then Have_Ads_This_Type = True
    rs.Close
    conn.Close
    DoEvents
End Function

Public Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
'关闭窗口时处理方式等于按退出键
  Cancel = True  '此语句使得 UserForm 不被关闭
  StopButton_Click
End Sub


Function Cpu_id() As String
   On Error GoTo ErrHandler:
   
   Dim cpuSet As SWbemObjectSet
   Dim cpu As SWbemObject
  
   Set cpuSet = GetObject("winmgmts:{impersonationLevel=impersonate}"). _
                           InstancesOf("Win32_Processor")
   For Each cpu In cpuSet
      DoEvents
      getwmiprocessorid = cpu.processorid
   Next
   Cpu_id = UCase(Left(CStr(getwmiprocessorid), 16))
   GoTo END_SUB:
ErrHandler:       ErrProc "获取系统信息错误 - Cpu_id"
END_SUB:
End Function

Sub GET_LICENCE()
'LICENCE_STATUS 和 VERSION_INFO.CAPTION值：0试用版本；1注册版本；2注册版本,即将过期，提前一个月警告；
'3证书过期，但未超1个月，提示一个月续用期；4证书过期，超过1个月，提示联系方格，并按试用版对待；5证书无效，提示，结束程序
 On Error Resume Next
 Dim Licence_ID, l_id, CpuID, CpuID2, user, usert, sales, t_str, t_str2 As String
 Dim t0, t1, t2, t_num, t_num2 As Long
 Dim days, L_Str As Integer
 Dim begin_day As Date
 Dim sec1_20, sec21_30, sec31_40, sec41_50 As String '分别存CPU、用户名、颁发日期和有效期 信息
  
 '读licence.txt
 Open MY_DOC_PATH & "\《开心情报站》文档\使用许可证\licence.txt" For Input As #1
 '循环读到“**许可证信息**”
 Do
   Input #1, tempii
 Loop While tempii <> "**许可证信息**" And Not EOF(1)
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
 CpuID2 = CpuID
 
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
 
 '用户名与经办人一起处理
'user = "ghgfrtrtffgfgcgfdgfdh"
 user = user & sales
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
'days = 112
'begin_day = "2007-1-9"
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

CONTACT_INFO = CONTACT_INFO & vbCrLf & vbCrLf & "        请提供本机代码:" & CUT_STR_INTO_n_WITH_DOT((CpuID2), 4)
'处理各种情况
If l_id = 0 Then
 VERSION_INFO.Caption = "试用版本"
 LICENCE_STATUS = 0
 atemp = MsgBox(vbCrLf & _
 "提示: 您现在使用的是试用版，功能不受限制，但会在您的版面中插入    " & vbCrLf & _
 "《开心情报站》广告。本软件完全免费，是整个系统中的桌面部分，能" & vbCrLf & _
 "够完成全部排版任务，可以单独使用。同时，我们提供强大的网络后台" & vbCrLf & _
 "支持系统，以及全方位的面向DM业务的专业服务，期待您的加盟！" & vbCrLf & vbCrLf & _
 "   * 统一商标 连锁经营        * 5分钟学会排印软件！" & vbCrLf & _
 "   * 加盟灵活 在线服务        * 5分钟完成印刷排版！" & vbCrLf & _
 "   * 软件优秀 智能排印        * 版面原样立即上网！" & vbCrLf & _
 "   * 网络平台 高效快速        * 开心情报站 广告笑着看" & vbCrLf & _
 "   * 事半功倍 成本低廉        * 广告信息印刷同时上网" & vbCrLf & vbCrLf & _
 "        有我们支持，您一个人就可以开DM广告公司！" & vbCrLf & _
 "                  诚招全国各地合作伙伴" & vbCrLf & _
 "              来吧，让我们一起开创DM新时代！" & vbCrLf & vbCrLf & _
 CONTACT_INFO, 0 + 64, "《开心情报站》自动排版系统")
 
 Exit Sub
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
  xlapp.Quit
  End
End If

'执行到这里l_id一定等于Licence_ID，并且受保护的文件完好
If Date > begin_day + days + 31 Then
 VERSION_INFO.Caption = "证书过期"
 LICENCE_STATUS = 4
 atemp = MsgBox(vbCrLf & "   警告: 证书严重过期" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   您的证书已经不能继续使用，将按试用版对待。", 0 + 48, "《开心情报站》自动排版系统")
 Exit Sub
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




Sub Lock_My_Ad()
Dim s As String


'选定sheet中所有单元格，解除锁定
    Cells.Select
    Selection.Locked = False
    Selection.FormulaHidden = False
'在插入图形时已经把一般图形解除锁定，而开心情报站的图形设置了锁定
'保护工作表
'因为HCWeb 需要口令才能把试用版排版结果保存为html,所以口令不能使用随机的，但应该尽量长，excel好像最多允许15位，但程序不受此限制，100位肯定没问题
'    Randomize Timer
'    For i = 1 To 100
'      s = s + Chr(32 + Int(Rnd * 90))
'    Next
    s = "hgdasdfsdhgsdf6767327wefd76327ewg763retdwter5632723t326732632tuywtdwtuywte786723672332576tfjk"
    ActiveSheet.EnableSelection = xlUnlockedCells
    ActiveSheet.Protect DrawingObjects:=True, Contents:=True, Scenarios:=True, _
        AllowFormattingCells:=True, _
        AllowFormattingColumns:=True, AllowFormattingRows:=True, _
        AllowInsertingColumns:=True, AllowInsertingRows:=True, _
        AllowDeletingColumns:=True, AllowDeletingRows:=True, _
        AllowInsertingHyperlinks:=True, _
        Password:=s
'关于Lock 必须这样写，录制宏跟这个一样，但就是不好使，可能是VBA的BUG
'只有DrawingObjects:=True,  Scenarios:=True,才能锁住开心情报站广告，但用户也不能再插入或拷贝别的图片了，经试验，没办法解决
End Sub

Sub SET_BTTNS()   '在Excel工具栏中设置字号整体放大缩小键，因为自带的没这个功能，只能字号相同的
' 编辑 k_bar.par 文件，定义各按键
' 用途：向命令栏按钮中添加图片。
'addbar.xls fontsize.xla 宏保护密码：kxqbzggxzk888daqing

'*********这里不要使用程序其他部分的set xlapp=Application,不行
 On Error Resume Next
 Application.AutomationSecurity = 1 ' msoAutomationSecurityLow
 Application.Visible = False
 Workbooks.Open App.Path & "\addbar.xls"
 Application.Quit

End Sub

Function CUT_STR_INTO_n_WITH_DOT(S_str As String, n As Integer) As String
For i = 1 To Len(S_str)
  CUT_STR_INTO_n_WITH_DOT = CUT_STR_INTO_n_WITH_DOT & Mid(S_str, i, 1)
  If i Mod n = 0 And i <> Len(S_str) Then CUT_STR_INTO_n_WITH_DOT = CUT_STR_INTO_n_WITH_DOT & "."
Next i
End Function


Function ReadPar(ByVal File_NM As String, PAR_NM As String, Symbol As String) As String
 On Error GoTo 2222
 Dim temp As String
 Dim n As Integer
 PAR_NM = Trim(PAR_NM)
 Open File_NM For Input As #10
 Do While Not EOF(10)
  DoEvents
  Line Input #10, temp
  temp = Trim(temp)
  If temp = "" Then GoTo 2222
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
 ReadPar = ""
 DoEvents
End Function

Sub Get_My_Documents_Path()
'获得我的文档目录
   Dim sTmp As String * MAX_LEN  '存放结果的固定长度的字符串
   Dim pidl As Long '某特殊目录在特殊目录列表中的位置
    
   '获得我的文档目录
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   MY_DOC_PATH = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   'MsgBox MY_DOC_PATH
End Sub


Sub Show_Tips()
 Dim tt As Integer    '间隔秒数
 tt = 10
 T = Timer()
 If T - TIPS_TIME > tt Then
 TIPS_TIME = T
 BEGIN_TIP_NUM = BEGIN_TIP_NUM + 1
 id = BEGIN_TIP_NUM Mod TIPS_NUM + 1
 TIP_TEXT.Caption = "* " & ReadPar(App.Path & "\tips.par", "Tip" & CStr(id), "=")
 If TIP_TEXT.Caption = "" Then TIP_TEXT.Caption = "开心情报站 广告笑着看 www.kxqbz.com"
 TIP_TEXT.ForeColor = RGB((BEGIN_TIP_NUM Mod 4) * 63, ((BEGIN_TIP_NUM + 1) Mod 4) * 63, ((BEGIN_TIP_NUM + 2) Mod 4) * 63)
 End If
End Sub


Sub Check_Page_Num()

On Error GoTo ErrHandler:

Dim PGNM As Integer
Dim P_G_N_M As Single   '也是版数，只是带小数点显示，让用户知道得更详细一点
'ReDim ARRAY_FOR_SCAN(1 To COLNUM, 1 To 3)

BEGIN_ROWNUM_THIS_TYPE = 0
ROWNUM = 0
END_ROWNUM_THIS_TYPE = 0
END_ROWNUM_LAST_TYPE = 0
TOTAL_ADS_CELLS = 0
TOTAL_ADS_NUM = 0
TOTAL_ADS_NUM_ROUPH = 0
TOTAL_ADS_CELLS_THIS_TYPE = 0
TOTAL_ADS_NUM_THIS_TYPE = 0
TOTAL_CELLS = 0
TOTAL_CELLS_TOUCHED = 0
BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = 0
INSERTING_COLNUM = 0
INSERTING_ROWNUM = 0
INCOME = 0
PROCESS_PERCENTS = 0
PIC_NUM = 0

T_Put_Logo_When_No_Front_Cover
WRITING_FIRST_ADS = True
For AD_TYPE = 1 To AD_TYPENUM
  DoEvents
  If Have_Ads_This_Type(CInt(AD_TYPE)) Then
    T_Put_All_Ads CInt(AD_TYPE)
  Else
    NO_AD_TYPENUM = NO_AD_TYPENUM + 1
  End If
Next AD_TYPE
SCANTIMES = SCANTIMES + 1
PROCESS_PERCENTS = 100
ShowPercents_Status PROCESS_PERCENTS, "第" & SCANTIMES & "次版面扫描完成"


PGNM = Int(ROWNUM / ROWNUM_PAGE)   '广告内页需要的版数
P_G_N_M = CInt(CSng(ROWNUM) / CSng(ROWNUM_PAGE) * 100#) / 100#
If ROWNUM Mod ROWNUM_PAGE <> 0 Then PGNM = PGNM + 1  '只要多一点点，就等于多一版
TOTAL_PAGE_NUM = Int(ROWNUM / ROWNUM_PAGE)
If ROWNUM Mod ROWNUM_PAGE <> 0 Then TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + 1  '内页需要的页数 '只要多一点点，就等于多一版
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + FRONT_COVER_PAGE_NUM + BACK_COVER_PAGE_NUM  '加上封面、封底
TOTAL_PAGE_NUM_t = Int(TOTAL_PAGE_NUM / COMPAGESNUM)
If TOTAL_PAGE_NUM Mod COMPAGESNUM <> 0 Then TOTAL_PAGE_NUM_t = TOTAL_PAGE_NUM_t + 1
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM_t * COMPAGESNUM
FINAL_ROWNUM = (TOTAL_PAGE_NUM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM) * ROWNUM_PAGE    '  '计算内页时减掉封面、封底

FastScan.ADS_NUM.Caption = TOTAL_ADS_NUM
FastScan.PAGES_ADS_NEED.Caption = P_G_N_M
FastScan.TOTAL_PAGES_THIS_ISSUE.Caption = TOTAL_PAGE_NUM
FastScan.SPACE_PAGES.Caption = TOTAL_PAGE_NUM - PGNM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM

FastScan.Left = UserForm_Preface.Left + 3200
FastScan.Top = UserForm_Preface.Top + 400
'MsgBox ROWNUM
FastScan.Show vbModal    'vbMpdal的作用是“模态窗口”，即FastScan窗口关闭后，下面的语句才执行。非模态就不管这个了。
BeginButton.Enabled = True
OTHER_CFG.Enabled = True
LAST_PARAMETER.Enabled = True
RESTORE_PARAMETER.Enabled = True
SAVE_PARAMETER.Enabled = True
EDIT_DB_BUTTON.Enabled = True
OtherCfg.Hide
Tip_Frame.Visible = False

GoTo END_SUB:
ErrHandler: ErrProc "版面扫描错误 - Check_Page_Num"
END_SUB:
End Sub

Sub Final_Check_Page_Num()
'即使Check_Page_Num从未执行过，也执行本Sub取得FINAL_ROWNUM等参数
On Error GoTo ErrHandler:

Dim PGNM As Integer
'ReDim ARRAY_FOR_SCAN(1 To COLNUM, 1 To 3)

BEGIN_ROWNUM_THIS_TYPE = 0
ROWNUM = 0
END_ROWNUM_THIS_TYPE = 0
END_ROWNUM_LAST_TYPE = 0
TOTAL_ADS_CELLS = 0
TOTAL_ADS_NUM = 0
TOTAL_ADS_NUM_ROUPH = 0
TOTAL_ADS_CELLS_THIS_TYPE = 0
TOTAL_ADS_NUM_THIS_TYPE = 0
TOTAL_CELLS = 0
TOTAL_CELLS_TOUCHED = 0
BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = 0
INSERTING_COLNUM = 0
INSERTING_ROWNUM = 0
INCOME = 0
PROCESS_PERCENTS = 0
PIC_NUM = 0
PROCESS_PERCENTS = PROCESS_PERCENTS + 1
ShowPercents_Status PROCESS_PERCENTS, "最终版面扫描..."

T_Put_Logo_When_No_Front_Cover
WRITING_FIRST_ADS = True
For AD_TYPE = 1 To AD_TYPENUM
  DoEvents
  If Have_Ads_This_Type(CInt(AD_TYPE)) Then
    T_Put_All_Ads CInt(AD_TYPE)
  Else
    NO_AD_TYPENUM = NO_AD_TYPENUM + 1
  End If
Next AD_TYPE

PGNM = Int(ROWNUM / ROWNUM_PAGE)   '广告内页需要的版数
If ROWNUM Mod ROWNUM_PAGE <> 0 Then PGNM = PGNM + 1
TOTAL_PAGE_NUM = Int(ROWNUM / ROWNUM_PAGE)
If ROWNUM Mod ROWNUM_PAGE <> 0 Then TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + 1  '内页需要的页数
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + FRONT_COVER_PAGE_NUM + BACK_COVER_PAGE_NUM  '加上封面、封底
TOTAL_PAGE_NUM_t = Int(TOTAL_PAGE_NUM / COMPAGESNUM)
If TOTAL_PAGE_NUM Mod COMPAGESNUM <> 0 Then TOTAL_PAGE_NUM_t = TOTAL_PAGE_NUM_t + 1
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM_t * COMPAGESNUM
FINAL_ROWNUM = (TOTAL_PAGE_NUM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM) * ROWNUM_PAGE    '  '计算内页时减掉封面、封底

GoTo END_SUB:
ErrHandler: ErrProc "版面扫描错误 - Final_Check_Page_Num"
END_SUB:
End Sub

Sub T_Write_Multi_Cells_Unit(id As String, title As String, Content As String, horizontal_cells As Integer, vertical_cells As Integer, display_mode As Integer, must_success As Boolean)
'写一个广告或笑话等，占不同单元格数
'Debug.Print "Write" & BEGIN_ROWNUM_THIS_TYPE & "/" & END_ROWNUM_THIS_TYPE & "/" & ROWNUM
Dim begin_row, row_move_down, LOST_TOTAL_CELLS_TOUCHED As Integer
Dim Ratio_H_V As Single  '标题高度,原来纵横格数比例，使得尽量减小变形

DoEvents
If vertical_cells >= OLD_ROWNUM_PAGE / 2 Then vertical_cells = OLD_ROWNUM_PAGE / 2
If horizontal_cells >= OLD_COLNUM Then horizontal_cells = OLD_COLNUM

If KEEP_WHOLE_SIZE <> 0 And (vertical_cells >= OLD_ROWNUM_PAGE / 2 Or horizontal_cells >= OLD_COLNUM) Then
  horizontal_cells = CInt(CSng(horizontal_cells) * COLNUM / OLD_COLNUM)
  vertical_cells = CInt(CSng(vertical_cells) * ROWNUM_PAGE / OLD_ROWNUM_PAGE)
End If

row_move_down = 2
If vertical_cells * 2 = ROWNUM_PAGE - END_ROWNUM_LAST_TYPE Mod ROWNUM_PAGE Or vertical_cells = 1 Or vertical_cells >= ROWNUM_PAGE / 2 Or NO_CLASS_TITLE = 1 Or MIX_CLASS = 1 Then row_move_down = 0
If vertical_cells > ROWNUM_PAGE / 2 Then vertical_cells = ROWNUM_PAGE / 2
If horizontal_cells > COLNUM Then horizontal_cells = COLNUM

Dim row, col As Integer
Dim Rows_Num As Single
Dim begin_col, end_col, step_col As Integer

begin_col = COLNUM
end_col = 1
step_col = -1
If FROM_LEFT_TO_RIGHT = 1 Then
  begin_col = 1
  end_col = COLNUM
  step_col = 1
End If

PUT_AD_SUCCESS = False
If INSERTING_COLNUM <> horizontal_cells Or INSERTING_ROWNUM <> vertical_cells Then
  INSERTING_COLNUM = horizontal_cells
  INSERTING_ROWNUM = vertical_cells
  BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = BEGIN_ROWNUM_THIS_TYPE
End If
begin_row = BEGIN_ROWNUM_THIS_TYPE + row_move_down
If BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 > begin_row Then begin_row = BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1
For row = begin_row To END_ROWNUM_THIS_TYPE Step 2
 For col = begin_col To end_col Step step_col
   DoEvents
   cellid = CStr(col) + ":" + CStr(row) + ":" + CStr(col + horizontal_cells - 1) + ":" + CStr(row + vertical_cells * 2 - 1)
   If horizontal_cells + col - 1 <= COLNUM And (Int((row - 1) / 2) Mod (ROWNUM_PAGE / 2)) + 1 + vertical_cells - 1 <= ROWNUM_PAGE / 2 And All_Null(cellid) Then
     For iiii = col To col + horizontal_cells - 1
       For jjjj = (row + 1) / 2 To (row + vertical_cells * 2 - 1) / 2
         ARRAY_FOR_SCAN(iiii, jjjj) = 1
       Next jjjj
     Next iiii
     PUT_AD_SUCCESS = True
     BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = row
     Exit Sub
   End If
 Next col
Next row

'以下代码确保插入成功,当是付费广告时要这样,而如果是免费广告,则不确保成功，确保成功的原因是必要时增加行，在切过页之后不能使用
If must_success = True Then
 Do While PUT_AD_SUCCESS = False
   DoEvents
   END_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 2
   ROWNUM = ROWNUM + 2
   ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
    
   For row = begin_row To END_ROWNUM_THIS_TYPE Step 2
     For col = begin_col To end_col Step step_col
       DoEvents
       cellid = CStr(col) + ":" + CStr(row) + ":" + CStr(col + horizontal_cells - 1) + ":" + CStr(row + vertical_cells * 2 - 1)
       If horizontal_cells + col - 1 <= COLNUM And (Int((row - 1) / 2) Mod (ROWNUM_PAGE / 2)) + 1 + vertical_cells - 1 <= ROWNUM_PAGE / 2 And All_Null(cellid) Then
        For iiii = col To col + horizontal_cells - 1
            For jjjj = (row + 1) / 2 To (row + vertical_cells * 2 - 1) / 2
               ARRAY_FOR_SCAN(iiii, jjjj) = 1
            Next jjjj
        Next iiii
        PUT_AD_SUCCESS = True
        BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1 = row
        Exit Sub
       End If
     Next col
    Next row
    Loop
End If  '若确保插入成功 结束
'程序执行到这里,意味着插入失败,只在不保证成功插入时才会发生,这时不必理会,免费的不成功也无所谓,会自动插入下一条免费的,因此不必提示了
'MsgBox "插入失败: 第" & AD_TYPE & "类[" & NAME_THIS_TYPE & "] 占用单元格: " & horizontal_cells & "x" & vertical_cells & chr(13) & chr(10) & "广告标题: " & title
DoEvents
End Sub

Sub T_Write_One_Cell_Unit(id As String, title As String, Content As String, display_mode As Integer)
'按顺序写一个单个单元格的 广告或笑话等
Dim row, col As Integer
Dim Rows_Num As Single
Dim begin_col, end_col, step_col As Integer

begin_col = COLNUM
end_col = 1
step_col = -1
If FROM_LEFT_TO_RIGHT = 1 Then
  begin_col = 1
  end_col = COLNUM
  step_col = 1
End If

begin_row = BEGIN_ROWNUM_THIS_TYPE
PUT_AD_SUCCESS = False
Do While PUT_AD_SUCCESS = False
   DoEvents
   For row = begin_row To END_ROWNUM_THIS_TYPE Step 2
    For col = begin_col To end_col Step step_col
       cellid = CStr(col) + ":" + CStr(row) + ":" + CStr(col) + ":" + CStr(row + 1)
       If All_Null(cellid) Then
         ARRAY_FOR_SCAN(col, (row + 1) / 2) = 1
         PUT_AD_SUCCESS = True
         Exit Sub
       End If
    Next col
   Next row
 begin_row = END_ROWNUM_THIS_TYPE + 1
 END_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 2
 ROWNUM = ROWNUM + 2
 ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
Loop
DoEvents
End Sub


Sub T_Put_All_Ads(a_type As Integer)
'################################################################################################################################
On Error Resume Next

Dim i_ads, i_fs, t_BEGIN_ROWNUM_THIS_TYPE As Integer
Dim t_NAME_THIS_TYPE, t_TITLE As String
t_OUTSIDE_CLASS_TITLE = OUTSIDE_CLASS_TITLE
FROM_LEFT_TO_RIGHT = 0
Get_Type_Name_And_Price a_type
Get_Total_Cells_Num_Ads_And_Income_This_Type a_type
If TOTAL_ADS_NUM_THIS_TYPE <= 0 Then Exit Sub
If WRITING_FIRST_ADS = True And FRONT_COVER_PAGE_NUM <= 0 Then t_OUTSIDE_CLASS_TITLE = 1
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then   '在写第1类（由广告可写的第1类，数据库中不一定是第1类），插入开心情报站广告，如果是试用版
  TOTAL_ADS_NUM_THIS_TYPE = TOTAL_ADS_NUM_THIS_TYPE + 1                           '这里计算开心情报站广告格数目
  TOTAL_ADS_NUM = TOTAL_ADS_NUM + 1
  TOTAL_ADS_CELLS_THIS_TYPE = TOTAL_ADS_CELLS_THIS_TYPE + 2 * 3 * 2  '横3纵2广告格
  TOTAL_ADS_CELLS = TOTAL_ADS_CELLS + 2 * 3 * 2
End If
BEGIN_ROWNUM_LAST_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_LAST_TYPE = END_ROWNUM_THIS_TYPE
ROWNUM_THIS_TYPE = 2
If TOTAL_INTEREST_PERCENTS > 0 Then ROWNUM_THIS_TYPE = 2 + Int(Int(TOTAL_ADS_CELLS_THIS_TYPE * (1 + TOTAL_INTEREST_PERCENTS / 100)) / COLNUM)   '全部广告总行数，每条广告占2个excel行,TOTAL_ADS_CELLS是乘过2的
If ROWNUM_THIS_TYPE Mod 2 <> 0 Then ROWNUM_THIS_TYPE = ROWNUM_THIS_TYPE + 1
ROWNUM = ROWNUM + ROWNUM_THIS_TYPE
BEGIN_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 1     '上个类型行数累加，第一个类别时此值就是最前面的空行数
t_BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + ROWNUM_THIS_TYPE - 1
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + TOTAL_ADS_CELLS_THIS_TYPE
t_NAME_THIS_TYPE = NAME_THIS_TYPE
'If Len(NAME_THIS_TYPE) > 2 Then t_NAME_THIS_TYPE = Left(NAME_THIS_TYPE, 2) & "~"
ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
PROCESS_PERCENTS = PROCESS_PERCENTS + Int(80 / AD_TYPENUM)
ShowPercents_Status PROCESS_PERCENTS, "第" & CStr(SCANTIMES + 1) & "次版面扫描:" & a_type & "-" & t_NAME_THIS_TYPE
DoEvents
'广告类标签
If Not (NO_CLASS_TITLE = 1 Or MIX_CLASS = 1) Then '如果不去掉广告类标签，即要广告类标签的话，或者不是混类的话。为了节省版面，可以去掉类标签
     Dim CLASS_COLNUM, t_Page_Num As Integer   '奇偶页广告类标签是否靠外侧，缺省靠左
     Do
        CLASS_COLNUM = 1
        t_Page_Num = Int((BEGIN_ROWNUM_THIS_TYPE + 1) / ROWNUM_PAGE)
        If (BEGIN_ROWNUM_THIS_TYPE + 1) Mod ROWNUM_PAGE <> 0 Then t_Page_Num = t_Page_Num + 1
        t_Page_Num = t_Page_Num + FRONT_COVER_PAGE_NUM
        If t_OUTSIDE_CLASS_TITLE <> 0 And t_Page_Num Mod 2 <> 0 Then
            CLASS_COLNUM = COLNUM
            FROM_LEFT_TO_RIGHT = 1
        End If
        If Not All_Null(CStr(CLASS_COLNUM) + ":" + CStr(BEGIN_ROWNUM_THIS_TYPE) + ":" + CStr(CLASS_COLNUM) + ":" + CStr(BEGIN_ROWNUM_THIS_TYPE + 1)) Then
          BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + 2
          END_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 2
          ROWNUM = ROWNUM + 2
          ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
        Else
         Exit Do
        End If
     Loop
     ARRAY_FOR_SCAN(CLASS_COLNUM, (BEGIN_ROWNUM_THIS_TYPE + 1) / 2) = 1
     TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + 2
End If

If BOUND_MIX_CLASS = 1 Then BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_LAST_TYPE


TP_s = " a_type=" & CStr(a_type) & " and"
TP_t = ""
If MIX_CLASS = 1 Then
  TP_s = ""
  TP_t = ",a_type"
End If
'先写多单元格的广告
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " (a_row>1 or a_col>1) order by a_row desc,a_col desc,a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  T_Write_Multi_Cells_Unit "", "", CStr(a_type) & ":" & CStr(i_ads), rs("a_col") + 0, rs("a_row") + 0, 1, True  '为了表达式类型自动转换,保证付费广告插入成功
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
'如果是试用版或严重过期（1个月），则插入《开心情报站》广告
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then
  T_Write_Multi_Cells_Unit "", "", "", 3, 2, 2, True  '保证插入成功
End If
'接着写单个单元格的广告
FROM_LEFT_TO_RIGHT = 1
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " a_row=1 and a_col=1 order by a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
If Not rs.EOF Then rs.MoveFirst
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  T_Write_One_Cell_Unit "", "", CStr(a_type) & ":" & CStr(i_ads), 1   '为了表达式类型自动转换
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
BEGIN_ROWNUM_THIS_TYPE = t_BEGIN_ROWNUM_THIS_TYPE
WRITING_FIRST_ADS = False   '设置为不是第一次写一类广告了
End Sub
Sub T_Put_Logo_When_No_Front_Cover()   '当没有封面时，在第一版放LOGO等内容
     If FRONT_COVER_PAGE_NUM > 0 Then Exit Sub

     Dim KLOGO_COLNUM, KLOGO_ROWNUM As Integer
     Dim KLOGO_W, KLOGO_H, ImageRatio As Single
     Dim KLOGO_PATH As String
     Dim a As ImageSize
     
     mm2pic_height = 3.525 '实际测试值,图像高度（宽度也可）到mm
     'LOGO放在第一版左上角，那么第一类广告的类标签必须放在右上角，所以奇偶页必须靠版边放，第一版放右边，正好不冲突
     'OUTSIDE_CLASS_TITLE = 1
     ShowPercents_Status PROCESS_PERCENTS, "处理刊头:标识/公司信息"
     KLOGO_PATH = App.Path & "\k-logo.jpg"
     a = GetImageSize(KLOGO_PATH)
     ImageRatio = a.Height / a.Width
     If PAGE_H_mm > PAGE_W_mm Then     'LOGO最大尺寸
       KLOGO_W = PAGE_W_mm / 2
     Else
       KLOGO_W = PAGE_H_mm / 2
     End If
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT
     KLOGO_COLNUM = CInt(KLOGO_W / COLW)
     KLOGO_W = KLOGO_COLNUM * COLW / mm2COLUMN_UNIT
     
     KLOGO_H = KLOGO_W * ImageRatio
     KLOGO_H = KLOGO_H * mm2POINT   '最终LOGO高，excel 单位
     KLOGO_H = KLOGO_H * 1.3  '30%贵公司信息的高度
     KLOGO_ROWNUM = CInt((KLOGO_H) / ROWH)
     KLOGO_ROWNUM = KLOGO_ROWNUM * 2
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT '最终LOGO宽，excel 单位 后面都没有用，因不准确
     If KLOGO_COLNUM < 1 Then KLOGO_COLNUM = 1
     If KLOGO_ROWNUM < 1 Then KLOGO_ROWNUM = 2
     '至此开心情报站LOGO要占的格位确定了
     col_for_your_logo = CInt(KLOGO_COLNUM / 2.5)  '经试验2.5较好
     If col_for_your_logo < 1 Then col_for_your_logo = 1
     If COLNUM < 2 Then col_for_your_logo = 0
     For i = 1 To KLOGO_COLNUM + col_for_your_logo '多出一列放贵公司LOGO、期号等
       For ii = 1 To KLOGO_ROWNUM / 2
         ARRAY_FOR_SCAN(i, ii) = 1
       Next ii
     Next i
     DoEvents
     ROWNUM = KLOGO_ROWNUM
End Sub


Public Sub xlapp_WorkbookOpen(ByVal Wb As Workbook)   'excel的事件，打开xls文件，在VB里检测
'本段程序禁止excel使用相同进程打开第二个xls文件，以免排版串到其他文件里。excel缺省时多xls个文件共用一个进程
Dim fn, excelpath As String
fn = Wb.Path & "\" & Wb.Name
Wb.Close
'ShellExecute 1, "Open", fn, "", "", 1  'SW_SHOWNORMAL 不好使
excelpath = GetExcelPath()
'不要改Shell 。只有这样做才能保证在打开xls文件不会和排版排窜
Shell excelpath & " /e """ & fn & """", vbNormalNoFocus
End Sub

Public Sub Obj_Active_Workbook_Deactivate()    '让“贴板”永远都活动，否则会贴到别的文件里去
  Obj_Active_Workbook.Activate
End Sub

Sub Put_Logo_When_No_Front_Cover()   '当没有封面时，在第一版放LOGO等内容
     On Error GoTo ErrHandler:
     If FRONT_COVER_PAGE_NUM > 0 Then Exit Sub

     Dim KLOGO_COLNUM, KLOGO_ROWNUM As Integer
     Dim KLOGO_W, KLOGO_H, ImageRatio, font_size As Single
     Dim KLOGO_PATH As String
     Dim a As ImageSize
     
     mm2pic_height = 3.525 '实际测试值,图像高度（宽度也可）到mm
     'LOGO放在第一版左上角，那么第一类广告的类标签必须放在右上角，所以奇偶页必须靠版边放，第一版放右边，正好不冲突
     'OUTSIDE_CLASS_TITLE = 1
     ShowPercents_Status PROCESS_PERCENTS, "处理刊头:标识/公司信息"
     KLOGO_PATH = App.Path & "\k-logo.jpg"
     a = GetImageSize(KLOGO_PATH)
     ImageRatio = a.Height / a.Width
     If PAGE_H_mm > PAGE_W_mm Then     'LOGO最大尺寸
       KLOGO_W = PAGE_W_mm / 2
     Else
       KLOGO_W = PAGE_H_mm / 2
     End If
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT
     KLOGO_COLNUM = CInt(KLOGO_W / COLW)
     KLOGO_W = KLOGO_COLNUM * COLW / mm2COLUMN_UNIT
     
     KLOGO_H = KLOGO_W * ImageRatio
     KLOGO_H = KLOGO_H * mm2POINT   '最终LOGO高，excel 单位
     KLOGO_H = KLOGO_H * 1.3  '30%贵公司信息的高度
     KLOGO_ROWNUM = CInt((KLOGO_H) / ROWH)
     KLOGO_ROWNUM = KLOGO_ROWNUM * 2
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT '最终LOGO宽，excel 单位 后面都没有用，因不准确
     If KLOGO_COLNUM < 1 Then KLOGO_COLNUM = 1
     If KLOGO_ROWNUM < 1 Then KLOGO_ROWNUM = 2
     '至此开心情报站LOGO要占的格位确定了
     col_for_your_logo = CInt(KLOGO_COLNUM / 2.5)  '经试验2.5较好
     If col_for_your_logo < 1 Then col_for_your_logo = 1
     If COLNUM < 2 Then col_for_your_logo = 0
     For i = 1 To KLOGO_COLNUM + col_for_your_logo '多出一列放贵公司LOGO、期号等
       For ii = 1 To KLOGO_ROWNUM / 2
         ARRAY_FOR_SCAN(i, ii) = 1
       Next ii
     Next i
     DoEvents
     For i = 1 To KLOGO_ROWNUM Step 2
        DoEvents
        ActiveSheet.Range("A" + CStr(i)).RowHeight = ROWH1
        ActiveSheet.Range("A" + CStr(i + 1)).RowHeight = ROWH2
     Next i
     TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + (KLOGO_COLNUM + col_for_your_logo) * KLOGO_ROWNUM
     ROWNUM = KLOGO_ROWNUM
    cid = "A1:" + COLSTR(KLOGO_COLNUM) + CStr(KLOGO_ROWNUM)
    Range(cid).Merge
    cid = "A1"
    Range(cid).Select  '开心情报站LOGO
    font_size_t = Sqr(Range(cid).MergeArea.Height * 0.2 * RowHeight2FontSize * COLW * KLOGO_COLNUM * ColWidth2FontSize / (CWidth(COMPANYINFO) / 2))
    num_of_cr_content = Num_Of_CR(COMPANYINFO)
    Rows_Num = Range(cid).MergeArea.Height * 0.2 * RowHeight2FontSize / font_size_t
    'If Rows_Num > Int(Rows_Num) Then Rows_Num = Rows_Num + 1
    Rows_Num = CInt(Rows_Num)
    font_size = (Range(cid).MergeArea.Height * 0.2 * RowHeight2FontSize / (Rows_Num + num_of_cr_content))
    Range(cid).Font.Size = font_size
    ActiveSheet.Pictures.Insert(KLOGO_PATH).Select
    Selection.ShapeRange.LockAspectRatio = msoTrue
    Selection.ShapeRange.ZOrder msoSendToBack
    Selection.ShapeRange.Height = Range(cid).MergeArea.Height - (num_of_cr_content + 1) * font_size / RowHeight2FontSize
    If Selection.ShapeRange.Width > Range(cid).MergeArea.Width Then Selection.ShapeRange.Width = Range(cid).MergeArea.Width
    Selection.ShapeRange.IncrementLeft 0
    Selection.ShapeRange.IncrementTop 0
    Selection.ShapeRange.PictureFormat.TransparentBackground = msoTrue
    Selection.ShapeRange.PictureFormat.TransparencyColor = RGB(255, 255, 255)
    Selection.ShapeRange.Fill.Visible = msoFalse
    Selection.Locked = False
    Range(cid).Value = COMPANYINFO
    Range(cid).HorizontalAlignment = xlLeft
    Range(cid).VerticalAlignment = xlBottom
    PIC_NUM = PIC_NUM + 1
    DoEvents
    
  If COLNUM < 2 Then Exit Sub
  cid = COLSTR(KLOGO_COLNUM + 1) + "1:" + COLSTR(KLOGO_COLNUM + col_for_your_logo) + CStr(KLOGO_ROWNUM)
  Range(cid).Select  '先写内容 ，并靠下显示，上面剩下的地方显示合作公司LOGO，最多下面3/5
  Range(cid).Merge
  cid = COLSTR(KLOGO_COLNUM + 1) + "1"
  i_date = ISSUE_DATE_CHR
  i_date = Replace(i_date, " ", Chr(10))
  CC = ISSUE_NUM & Chr(10) & "总第" + CStr(TOTAL_ISSUE_NUM) + "期" & Chr(10) & i_date & Chr(10) & "热线:" & HOTLINE
  i_num_fontsize = COLW * col_for_your_logo * ColWidth2FontSize / Len(ISSUE_NUM) '期号的字号
  If i_num_fontsize < 2 Then i_num_fontsize = 2
  If i_num_fontsize > ROWH * KLOGO_ROWNUM / 2 * 3 / 5 / 2 * RowHeight2FontSize Then i_num_fontsize = ROWH * KLOGO_ROWNUM / 2 * 3 / 5 / 2 * RowHeight2FontSize
  font_size_t = COLW * col_for_your_logo * ColWidth2FontSize / (CWidth(CC) / 2)
  num_of_cr_content = Num_Of_CR(CC) - 1 + 1 '期号后面的回车不算，行数比回车数大1
  font_size = ((ROWH * KLOGO_ROWNUM / 2 * 3 / 5 * RowHeight2FontSize - i_num_fontsize) / (num_of_cr_content)) '日期、电话等的字号
  If font_size < 2 Then font_size = 2
  Range(cid).Value = CC
  Range(cid).HorizontalAlignment = xlCenter
  Range(cid).VerticalAlignment = xlBottom
  Range(cid).Font.Size = font_size
  Range(cid).Font.Name = "Arial Black"
  Range(cid).Characters(Start:=1, Length:=InStr(CC, Chr(10))).Font.Size = i_num_fontsize
  DoEvents
  a = GetImageSize(YOURLOGOPATH) '合作公司LOGO
  ImageRatio = a.Height / a.Width
  ActiveSheet.Pictures.Insert(YOURLOGOPATH).Select
  Selection.ShapeRange.LockAspectRatio = msoTrue
  Selection.ShapeRange.ZOrder msoSendToBack
  Selection.ShapeRange.Height = Range(cid).MergeArea.Height * 2 / 5 - PIC_BOTTOM
  If Selection.ShapeRange.Width > Range(cid).MergeArea.Width - PIC_RIGHT Then Selection.ShapeRange.Width = Range(cid).MergeArea.Width - PIC_RIGHT
  Selection.ShapeRange.IncrementLeft Abs(Selection.ShapeRange.Width - (Range(cid).MergeArea.Width)) / 2
  Selection.ShapeRange.IncrementTop 0
  Selection.ShapeRange.PictureFormat.TransparentBackground = msoTrue
  Selection.ShapeRange.PictureFormat.TransparencyColor = RGB(255, 255, 255)
  Selection.ShapeRange.Fill.Visible = msoFalse
  Selection.Locked = False
  GoTo END_SUB:
ErrHandler: ErrProc "标识放置错误 - Put_Logo_When_No_Front_Cover"
END_SUB:
End Sub


Sub ErrProc(ByVal info As String)
 atemp = MsgBox(vbCrLf & "   提示: 系统遇到严重错误,不能继续运行" & vbCrLf & _
                         "   错误说明: " & info & vbCrLf & _
                         "   请检查: " & vbCrLf & _
                         "     * 计算机操作系统 Windows 2000/XP 及以上版本               " & vbCrLf & _
                         "     * Microsoft Office 2003 及以上版本" & vbCrLf & _
                         "     * 正确安装了支持设定版面规格的打印机" & vbCrLf & _
                         "         建议安装虚拟打印机,如 SmartPrinter" & vbCrLf & _
                         "     * 系统参数设置" & vbCrLf & _
                         "     * 其他可能事项" & vbCrLf & vbCrLf & _
                         "   如果问题仍无法解决,我们随时等候您的垂询" & vbCrLf & _
                         CONTACT_INFO, 0 + 48, "《开心情报站》自动排版系统")
 
 StopButton_Click
 If EXCEL_STARTED = True Then xlapp.Quit
 End
End Sub




Sub SET_DSN_NAME(ByVal DBFNM As String)
    DSN_NAME = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _
         MY_DOC_PATH & "\《开心情报站》文档\database\" & DBFNM & ".mdb;User ID=admin;Password=;Jet OLEDB:Database Password=1"
    L_s = ""
    R_s = ""
'下面的代码需要执行，是因为Excel ODBC有bug,否则程序启动后立即点开始键就出现 -2147467259 不支持排序的错误
'微软官方说，此错误便以后不出现，所以编译前注视掉
                        'conn.Open DSN_NAME
                        'SQL_Str = "select t_id from types"
                        'rs.Open SQL_Str, conn, 2, 2
                        'rs.Close
                        'conn.Close
'如果从Excel select出来的字符数255后被切断，这是MS的BUG,参考 ：http://support.microsoft.com/kb/189897/EN-US/ and  http://support.microsoft.com/kb/318161/en-us
'RESOLUTION
'To change the number of rows that the Excel ODBC driver scans to determine what type of data you have in your table, change the setting
'of the TypeGuessRows DWORD value.
'NOTE: The following steps will only work if your source Excel file is saved in the Microsoft Excel Workbook file format. If it is saved
'in the Microsoft Excel 97 & 5.0/95 Workbook file format, the data will always be truncated to 255 characters.
'Warning Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These
'problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify 'the registry at your own risk.
'For information about how to edit the registry, view the "Changing Keys And Values" Help topic in Registry Editor (Regedit.exe) or the
'"Add and Delete Information in the Registry" and "Edit Registry Data" Help topics in Regedt32.exe. Note that you should back up the
'registry before you edit it. If you are running Windows NT, you should also update your Emergency Repair Disk (ERD).
'To change the setting for the TypeGuessRows value, follow these steps: 1. Close any programs that are running.
'2. On the Start menu, click Run. Type regedit and click OK.
'3. In the Registry Editor, expand the following key depending on the version of Excel that you are running:? Excel 97
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Jet\3.5\Engines\Excel
'? Excel 2000 and later versions
'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Jet\4.0\Engines\Excel
'4. Select TypeGuessRows and on the Edit menu click Modify.
'5. In the Edit DWORD Value dialog box, click Decimal under Base. Type a value between 0 and 16, inclusive, for Value data. Click OK and
'quit the Registry Editor.
'NOTE: For performance reasons, setting the TypeGuessRows value to zero (0) is not recommended if your Excel table is very large. When
'this value is set to zero, Microsoft Excel will scan all records in your table to determine the type of data in each column.
    
    If IS_EXCEL Then
        'DSN_NAME = "Driver={Microsoft Excel Driver (*.xls)};DBQ=" & MY_DOC_PATH & "\《开心情报站》文档\database\adsdb.xls;ReadOnly=False;"  '这个有问题
        DSN_NAME = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & MY_DOC_PATH & "\《开心情报站》文档\database\" & DBFNM & ".xls" & ";Extended Properties=Excel 8.0"
        L_s = "["
        R_s = "$]"
    End If
End Sub










