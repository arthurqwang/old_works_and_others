VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} OtherCfg 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "其它参数"
   ClientHeight    =   4245
   ClientLeft      =   30
   ClientTop       =   315
   ClientWidth     =   7395
   Icon            =   "OtherCfg.dsx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   OleObjectBlob   =   "OtherCfg.dsx":0CCA
End
Attribute VB_Name = "OtherCfg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim HEADH_T, FOOTH_T As Single
Dim HEADH_CHANGED, FOOTH_CHANGED As Boolean


Public Sub Cancel_Click()
  Unload OtherCfg
End Sub



Private Sub BROWSEBUTTON_Click()
    Dim OpenFile As OPENFILENAME
    Dim lReturn As Long
    Dim sFilter As String
    OpenFile.lStructSize = Len(OpenFile)
    DoEvents
    OpenFile.hwndOwner = UserForm_Preface.hwnd
    DoEvents
    OpenFile.hInstance = App.hInstance
    DoEvents
    sFilter = "图像文件 (*.jpg, *.gif, *.bmp)" & Chr(0) & "*.jpg;*.gif;*.bmp" & Chr(0)
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
    OpenFile.lpstrInitialDir = MY_DOC_PATH
    DoEvents
    OpenFile.lpstrTitle = "《开心情报站》- 请选择公司或刊物标志图像文件"
    DoEvents
    OpenFile.flags = &H4 'OFN_HIDEREADONLY 去掉“只读方式打开”
    DoEvents
    lReturn = GetOpenFileName(OpenFile)
    DoEvents
    If lReturn <> 0 Then
        YourLogoPath_i.Value = Trim(OpenFile.lpstrFile)
    End If
    DoEvents
    OtherCfg.SetFocus
End Sub


Public Sub SAVE_OTHER_Click()
On Error Resume Next
If CSng(JOKE.Text) < 0 Or CSng(PUZZLE.Value) < 0 Or CSng(ELSEM.Value) < 0 _
   Or CSng(JOKE.Value) + CSng(PUZZLE.Value) + CSng(ELSEM.Value) <> 100 Then
   MsgBox "趣味性材料细分比例参数填写错误  ", 48, "《开心情报站》自动排版系统"
   Exit Sub
End If
Dim ctemp As String

'写其它参数文件 other-cfg.par和runtime.par
    Open App.Path & "\other-cfg.par" For Output As #10
    Print #10, Replace(CompanyInfo_i.Value, vbCrLf, "^|")
    Print #10, HotLine_i.Value
    Print #10, CellPhone_i.Value
    Print #10, YourLogoPath_i.Value
    Print #10, BankCard_i.Value
    Close #10
    Open App.Path & "\runtime.par" For Output As #11
    Print #11, "JOKE_IN_INTEREST=" & JOKE.Value
    Print #11, "PUZZLE_IN_INTEREST=" & PUZZLE.Value
    Print #11, "ELSE_IN_INTEREST=" & ELSEM.Value
    Print #11, "mm2POINT=2.754"
    Print #11, "mm2ROW_UNIT=20.500731"
    Print #11, "mm2COLUMN_UNIT=0.4461538"
    Print #11, "COLUMN_UNIT2PIXEL=6.04"
    Print #11, "WEB_TITLE_MAX_FONT_SIZE=22"
    Print #11, "MAX_LEN_PER_CELL=60"
    Print #11, "MODE_2_LEN=30"
    If DOUBLELINE.Value = True Then
    Print #11, "PIC_LEFT=2"
    Print #11, "PIC_TOP=2"
    Print #11, "PIC_RIGHT=4"
    Print #11, "PIC_BOTTOM=4"
    Print #11, "CELL_BORDER_TYPE=1"
    Else
    Print #11, "PIC_LEFT=1"   '1  经测试，这4个值是合适的，虽然屏幕显示可能有问题，但打印是合适的
    Print #11, "PIC_TOP=1"    '1
    Print #11, "PIC_RIGHT=1"  '2
    Print #11, "PIC_BOTTOM=1" '2
    Print #11, "CELL_BORDER_TYPE=0"
    End If
    Print #11, "ISSUE_DAY_AFTER=" & DELAY_DAYS.Value
    If WHITE_BLACK.Value = True Then
    Print #11, "TOPIC_WHITE_BLACK=1"
    Else
    Print #11, "TOPIC_WHITE_BLACK=0"
    End If
    Print #11, "TOPIC_FONT_NAME1=" & ComboBox2.Text
    Print #11, "TOPIC_FONT_NAME2=" & ComboBox3.Text
    Print #11, "CLASS_FONT_NAME=" & ComboBox1.Text
    If USE_PIC.Value = True Then
    Print #11, "USE_CLASS_PIC=1"
    Else
    Print #11, "USE_CLASS_PIC=0"
    End If
    If TRANSPLINE.Value = True Then
    Print #11, "TRANSP_LINE=1"
    Else
    Print #11, "TRANSP_LINE=0"
    End If
    If MIXCLASS.Value = True Then
    Print #11, "MIX_CLASS=1"
    Else
    Print #11, "MIX_CLASS=0"
    End If
    If BOUNDMIXCLASS.Value = True Then
    Print #11, "BOUND_MIX_CLASS=1"
    Else
    Print #11, "BOUND_MIX_CLASS=0"
    End If
    If KEEPWHOLESIZE.Value = True Then
    Print #11, "KEEP_WHOLE_SIZE=1"
    Else
    Print #11, "KEEP_WHOLE_SIZE=0"
    End If
    If BACKRUN.Value = True Then
    Print #11, "BACK_RUN=1"
    Else
    Print #11, "BACK_RUN=0"
    End If
    If NOCLASSTITLE.Value = True Then
    Print #11, "NO_CLASS_TITLE=1"
    Else
    Print #11, "NO_CLASS_TITLE=0"
    End If
    If OUTSIDECLASSTITLE.Value = True Then
    Print #11, "OUTSIDE_CLASS_TITLE=1"
    Else
    Print #11, "OUTSIDE_CLASS_TITLE=0"
    End If
    If TIPS_Y.Value = True Then
    Print #11, "TIPS_YES=1"
    Else
    Print #11, "TIPS_YES=0"
    End If
    Print #11, "{{END}}"
    Print #11, "表示参数设定结束，{{END}}下面的是注释，{{END}}可以省略，加上是为了检索速度"
    Print #11, "***************************************************************************"
    Print #11, "参数含义说明"
    Print #11, "JOKE_IN_INTEREST:50    '趣味性材料比例，总计100%"
    Print #11, "PUZZLE_IN_INTEREST:50"
    Print #11, "ELSE_IN_INTEREST:0"
    Print #11, "mm2POINT:2.754       '每厘米等于28.35磅(行高单位),经试验，此值为27.51~27.57,取27.54"
    Print #11, "mm2ROW_UNIT=20.500731 '每厘米等于行单位数，实验取得"
    Print #11, "mm2COLUMN_UNIT:0.4461538       '每厘米等于3.25 列宽单位"
    Print #11, "COLUMN_UNIT2PIXEL:6.04 '每个列宽单位等于6.04个图像像素"
    Print #11, "WEB_TITLE_MAX_FONT_SIZE:22 '用于WEB，标题字号:WEB_TITLE_MAX_FONT_SIZE - 标题长度 / 标题所占横向格数"
    Print #11, "MAX_LEN_PER_CELL:60 '写笑话时，每单元格最多字符数，以汉字计算。广告内容不受此限。"
    Print #11, "MODE_2_LEN:30 ' 汉字为准。当平均单个单元格内容少于这个值时，比较适合显示方式2。客户可以不指定显示模式，此时根据内容多少决定显示方式"
    Print #11, "PIC_LEFT:2   '插入图片时，为了让图片不出格，需要缩一点"
    Print #11, "PIC_TOP:2"
    Print #11, "PIC_RIGHT:4   '是宽度减去的点数，应该等于PIC_LEFT的2倍"
    Print #11, "PIC_BOTTOM:4"
    Print #11, "CELL_BORDER_TYPE:1   '广告格边框样式，0为单线，其它为双线"
    Print #11, "ISSUE_DAY_AFTER:1    '印刷延后天数，用于自动填写出版日期"
    Print #11, "TOPIC_WHITE_BLACK:1 '用于印刷时广告格标题（有标题单元格模式），为了印刷清楚，等于1时表示黑白，其它为彩色"
    Print #11, "TOPIC_FONT_NAME1:黑体    '广告格标题字体名，1模式"
    Print #11, "TOPIC_FONT_NAME2:华文琥珀 '2模式"
    Print #11, "CLASS_FONT_NAME:华文琥珀  '广告类别名称使用的字体，如果USE_CLASS_PIC设为非0，则文字就被遮住了"
    Print #11, "USE_CLASS_PIC:1  '广告类别格是否使用图，等于0不用，其他表示用"
    Print #11, "TRANSP_LINE:0  '广告格边框是否透明，透明即等于没有，等于1透明 其它不透明"
    Print #11, "MIX_CLASS:0   '排版是否混类，即不分类，各类广告一起排，适于量小的报纸，等于1混，其它不混"
    Print #11, "BOUND_MIX_CLASS:0  '相邻类广告可以越界混排，适于量小的报纸，等于1混，其它不混"
    Print #11, "KEEP_WHOLE_SIZE:1  '增大广告纵横格数时保持整版广告幅面不变，0表示不是，其它表示是"
    Print #11, "BACK_RUN:1   '排版Excel后台运行，1表示后台，其它前台"
    Print #11, "NO_CLASS_TITLE:0   '是否去掉广告类标签，0表示不印(即去掉)，其它表示印"
    Print #11, "OUTSIDE_CLASS_TITLE:1  '广告类标签置于页面外侧，即奇数页在右侧，欧数页在左侧，0表示不分，其它表示区分"
    Print #11, "TIPS_YES:1   '软件界面悬停提示，等于0不用，其他表示用"
    Close #11
 OtherCfg.Hide
 '出版日期可能改变了，所以要刷新
 fn_temp = App.Path & "\runtime.par"
 ISSUE_DAY_AFTER = CInt(DELAY_DAYS.Value)
 ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) '印刷延误天数，runtime.par文件中，列为 mm2ROW_UNIT,要混在mm2POINT附近，用带小数点的数
 If ISSUE_DAY_AFTER > ISSUE_NUM_CHANGE_CONTROL_days Then ISSUE_DAY_AFTER = ISSUE_NUM_CHANGE_CONTROL_days
 Dim issue_date As Date
 issue_date = Date + ISSUE_DAY_AFTER
 Dim WK As Variant
 WK = Array("", "日", "一", "二", "三", "四", "五", "六") '空字串为了适应 Weekday函数
 UserForm_Preface.ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "年" + CStr(Month(issue_date)) + "月" + CStr(Day(issue_date)) + "日" + " 星期" + CStr(WK(Weekday(issue_date)))
 
 If TIPS_Y.Value = False Then
    UserForm_Preface.BACK_GRD.ControlTipText = ""
    UserForm_Preface.EDIT_PARA.ControlTipText = ""   '(fn_temp2, "EDIT_PARA", ":")
    UserForm_Preface.PAGE_H_mm_i.ControlTipText = ""   '(fn_temp2, "PAGE_H_mm_i", ":")
    UserForm_Preface.PAGE_W_mm_i.ControlTipText = ""   '(fn_temp2, "PAGE_W_mm_i", ":")
    UserForm_Preface.HEADH_i.ControlTipText = ""   '(fn_temp2, "HEADH_i", ":")
    UserForm_Preface.FOOTH_i.ControlTipText = ""   '(fn_temp2, "FOOTH_i", ":")
    UserForm_Preface.BORDERM_i.ControlTipText = ""
    UserForm_Preface.COMPAGESNUM_i.ControlTipText = ""
    UserForm_Preface.COLNUM_i.ControlTipText = ""   'ReadPar(fn_temp2, "COLNUM_i", ":")
    UserForm_Preface.ROWNUM_i.ControlTipText = ""  ' ReadPar(fn_temp2, "ROWNUM_i", ":")
    UserForm_Preface.COLNUM_CHANGE_i.ControlTipText = ""   '(fn_temp2, "FRONT_COVER_PAGE_NUM_CHANGE_i", ":")
    UserForm_Preface.ROWNUM_CHANGE_i.ControlTipText = ""   '(fn_temp2, "FRONT_COVER_PAGE_NUM_CHANGE_i", ":")
    UserForm_Preface.COLW_i.ControlTipText = ""    'ReadPar(fn_temp2, "COLW_i", ":")
    UserForm_Preface.ROWH_i.ControlTipText = ""   'ReadPar(fn_temp2, "ROWH_i", ":")
    UserForm_Preface.MAX_FONT_SIZE_i.ControlTipText = ""   '(fn_temp2, "MAX_FONT_SIZE_i", ":")
    UserForm_Preface.MIN_FONT_SIZE_i.ControlTipText = ""   '(fn_temp2, "MIN_FONT_SIZE_i", ":")
    UserForm_Preface.FONT_SIZE_ADJUST_i.ControlTipText = ""   '(fn_temp2, "FONT_SIZE_ADJUST_i", ":")
    UserForm_Preface.PERSONAL_FREE_INFO_ROWS_i.ControlTipText = ""   '(fn_temp2, "PERSONAL_FREE_INFO_ROWS_i", ":")
    UserForm_Preface.PERSONAL_FREE_INFO_COLS_i.ControlTipText = ""   '(fn_temp2, "PERSONAL_FREE_INFO_ROWS_i", ":")
    UserForm_Preface.TOTAL_INTEREST_PERCENTS_i.ControlTipText = ""   '(fn_temp2, "TOTAL_INTEREST_PERCENTS_i", ":")
    UserForm_Preface.logo.ControlTipText = ""   '(fn_temp2, "logo", ":")
    UserForm_Preface.SAVE_PARAMETER.ControlTipText = ""   '(fn_temp2, "SAVE_PARAMETER", ":")
    UserForm_Preface.RESTORE_PARAMETER.ControlTipText = ""   '(fn_temp2, "RESTORE_PARAMETER", ":")
    UserForm_Preface.LAST_PARAMETER.ControlTipText = ""
    UserForm_Preface.OTHER_CFG.ControlTipText = ""   '(fn_temp2, "OTHER_CFG", ":")
    UserForm_Preface.DB_OPTION1_i.ControlTipText = ""   '(fn_temp2, "DB_OPTION1_i", ":")
    UserForm_Preface.DB_OPTION2_i.ControlTipText = ""   '(fn_temp2, "DB_OPTION2_i", ":")
    UserForm_Preface.DB_FRAME.ControlTipText = ""   '(fn_temp2, "DB_FRAME", ":")
    UserForm_Preface.EDIT_DB_BUTTON.ControlTipText = ""   '(fn_temp2, "EDIT_DB_BUTTON", ":")
    UserForm_Preface.ISSUE_NUM_i.ControlTipText = ""   '(fn_temp2, "ISSUE_NUM_i", ":")
    UserForm_Preface.ISSUE_NUM_CHANGE_i.ControlTipText = ""   '(fn_temp2, "ISSUE_NUM_CHANGE_i", ":")
    UserForm_Preface.TOTAL_ISSUE_NUM_i.ControlTipText = ""   '(fn_temp2, "TOTAL_ISSUE_NUM_i", ":")
    UserForm_Preface.TOTAL_ISSUE_NUM_CHANGE_i.ControlTipText = ""   '(fn_temp2, "TOTAL_ISSUE_NUM_CHANGE_i", ":")
    UserForm_Preface.ISSUE_DATE_i.ControlTipText = ""   '(fn_temp2, "ISSUE_DATE_i", ":")
    UserForm_Preface.ISSUE_DATE_CHANGE_i.ControlTipText = ""   '(fn_temp2, "ISSUE_DATE_CHANGE_i", ":")
    UserForm_Preface.FRONT_COVER_PAGE_NUM_i.ControlTipText = ""   '(fn_temp2, "FRONT_COVER_PAGE_NUM_i", ":")
    UserForm_Preface.FRONT_COVER_PAGE_NUM_CHANGE_i.ControlTipText = ""   '(fn_temp2, "FRONT_COVER_PAGE_NUM_CHANGE_i", ":")
    UserForm_Preface.BACK_COVER_PAGE_NUM_i.ControlTipText = ""   '(fn_temp2, "BACK_COVER_PAGE_NUM_i", ":")
    UserForm_Preface.BACK_COVER_PAGE_NUM_CHANGE_i.ControlTipText = ""   '(fn_temp2, "BACK_COVER_PAGE_NUM_CHANGE_i", ":")
    UserForm_Preface.TEST_i.ControlTipText = ""   '(fn_temp2, "TEST_i", ":")
    UserForm_Preface.CLOSE_EXCEL_i.ControlTipText = ""   '(fn_temp2, "CLOSE_EXCEL_i", ":")
    UserForm_Preface.BeginButton.ControlTipText = ""   '(fn_temp2, "BeginButton", ":")
    UserForm_Preface.StopButton.ControlTipText = ""   '(fn_temp2, "StopButton", ":")
    UserForm_Preface.VERSION_INFO.ControlTipText = ""   '(fn_temp2, "StopButton", ":")
    UserForm_Preface.FinishButton.ControlTipText = ""   '(fn_temp2, "FinishButton", ":")
    UserForm_Preface.REPORT_FRAME.ControlTipText = ""   '(fn_temp2, "REPORT_FRAME", ":")
 Else
    fn_temp2 = App.Path & "\helptips.par"  '快速帮助提示文件
    UserForm_Preface.BACK_GRD.ControlTipText = ReadPar(fn_temp2, "BACK_GRD", ":")
    UserForm_Preface.EDIT_PARA.ControlTipText = ReadPar(fn_temp2, "EDIT_PARA", ":")
    UserForm_Preface.PAGE_H_mm_i.ControlTipText = ReadPar(fn_temp2, "PAGE_H_mm_i", ":")
    UserForm_Preface.PAGE_W_mm_i.ControlTipText = ReadPar(fn_temp2, "PAGE_W_mm_i", ":")
    UserForm_Preface.HEADH_i.ControlTipText = ReadPar(fn_temp2, "HEADH_i", ":")
    UserForm_Preface.FOOTH_i.ControlTipText = ReadPar(fn_temp2, "FOOTH_i", ":")
    UserForm_Preface.BORDERM_i.ControlTipText = ReadPar(fn_temp2, "BORDERM_i", ":")
    UserForm_Preface.COMPAGESNUM_i.ControlTipText = ReadPar(fn_temp2, "COMPAGESNUM_i", ":")
    UserForm_Preface.COLNUM_i.ControlTipText = ReadPar(fn_temp2, "COLNUM_i", ":")
    UserForm_Preface.ROWNUM_i.ControlTipText = ReadPar(fn_temp2, "ROWNUM_i", ":")
    UserForm_Preface.COLNUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "COLNUM_CHANGE_i", ":")
    UserForm_Preface.ROWNUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "ROWNUM_CHANGE_i", ":")
    UserForm_Preface.COLW_i.ControlTipText = ReadPar(fn_temp2, "COLW_i", ":")
    UserForm_Preface.ROWH_i.ControlTipText = ReadPar(fn_temp2, "ROWH_i", ":")
    UserForm_Preface.MAX_FONT_SIZE_i.ControlTipText = ReadPar(fn_temp2, "MAX_FONT_SIZE_i", ":")
    UserForm_Preface.MIN_FONT_SIZE_i.ControlTipText = ReadPar(fn_temp2, "MIN_FONT_SIZE_i", ":")
    UserForm_Preface.FONT_SIZE_ADJUST_i.ControlTipText = ReadPar(fn_temp2, "FONT_SIZE_ADJUST_i", ":")
    UserForm_Preface.PERSONAL_FREE_INFO_ROWS_i.ControlTipText = ReadPar(fn_temp2, "PERSONAL_FREE_INFO_ROWS_i", ":")
    UserForm_Preface.PERSONAL_FREE_INFO_COLS_i.ControlTipText = ReadPar(fn_temp2, "PERSONAL_FREE_INFO_COLS_i", ":")
    UserForm_Preface.TOTAL_INTEREST_PERCENTS_i.ControlTipText = ReadPar(fn_temp2, "TOTAL_INTEREST_PERCENTS_i", ":")
    UserForm_Preface.logo.ControlTipText = ReadPar(fn_temp2, "logo", ":")
    UserForm_Preface.SAVE_PARAMETER.ControlTipText = ReadPar(fn_temp2, "SAVE_PARAMETER", ":")
    UserForm_Preface.RESTORE_PARAMETER.ControlTipText = ReadPar(fn_temp2, "RESTORE_PARAMETER", ":")
    UserForm_Preface.LAST_PARAMETER.ControlTipText = ReadPar(fn_temp2, "LAST_PARAMETER", ":")
    UserForm_Preface.OTHER_CFG.ControlTipText = ReadPar(fn_temp2, "OTHER_CFG", ":")
    UserForm_Preface.DB_OPTION1_i.ControlTipText = ReadPar(fn_temp2, "DB_OPTION1_i", ":")
    UserForm_Preface.DB_OPTION2_i.ControlTipText = ReadPar(fn_temp2, "DB_OPTION2_i", ":")
    UserForm_Preface.DB_FRAME.ControlTipText = ReadPar(fn_temp2, "DB_FRAME", ":")
    UserForm_Preface.EDIT_DB_BUTTON.ControlTipText = ReadPar(fn_temp2, "EDIT_DB_BUTTON", ":")
    UserForm_Preface.ISSUE_NUM_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_NUM_i", ":")
    UserForm_Preface.ISSUE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_NUM_CHANGE_i", ":")
    UserForm_Preface.TOTAL_ISSUE_NUM_i.ControlTipText = ReadPar(fn_temp2, "TOTAL_ISSUE_NUM_i", ":")
    UserForm_Preface.TOTAL_ISSUE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "TOTAL_ISSUE_NUM_CHANGE_i", ":")
    UserForm_Preface.ISSUE_DATE_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_DATE_i", ":")
    UserForm_Preface.ISSUE_DATE_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "ISSUE_DATE_CHANGE_i", ":")
    UserForm_Preface.FRONT_COVER_PAGE_NUM_i.ControlTipText = ReadPar(fn_temp2, "FRONT_COVER_PAGE_NUM_i", ":")
    UserForm_Preface.FRONT_COVER_PAGE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "FRONT_COVER_PAGE_NUM_CHANGE_i", ":")
    UserForm_Preface.BACK_COVER_PAGE_NUM_i.ControlTipText = ReadPar(fn_temp2, "BACK_COVER_PAGE_NUM_i", ":")
    UserForm_Preface.BACK_COVER_PAGE_NUM_CHANGE_i.ControlTipText = ReadPar(fn_temp2, "BACK_COVER_PAGE_NUM_CHANGE_i", ":")
    UserForm_Preface.TEST_i.ControlTipText = ReadPar(fn_temp2, "TEST_i", ":")
    UserForm_Preface.CLOSE_EXCEL_i.ControlTipText = ReadPar(fn_temp2, "CLOSE_EXCEL_i", ":")
    UserForm_Preface.BeginButton.ControlTipText = ReadPar(fn_temp2, "BeginButton", ":")
    UserForm_Preface.StopButton.ControlTipText = ReadPar(fn_temp2, "StopButton", ":")
    UserForm_Preface.VERSION_INFO.ControlTipText = ReadPar(fn_temp2, "VERSION_INFO", ":")
    UserForm_Preface.FinishButton.ControlTipText = ReadPar(fn_temp2, "FinishButton", ":")
    UserForm_Preface.REPORT_FRAME.ControlTipText = ReadPar(fn_temp2, "REPORT_FRAME", ":")
 End If
 UserForm_Preface.Repaint
 If TIPS_Y.Value = 0 Then
  HIDE_TIPS
Else
  Show_Tips
End If
End Sub


Sub STRINGSORT(ByRef a() As String, Optional sort As String = "UP") '字符串排序
 Dim min As Long, max As Long, num As Long, first As Long, last As Long, temp As Long, all As New Collection, steps As Long
 min = LBound(a)
 max = UBound(a)
 all.Add a(min)
 steps = 1
 For num = min + 1 To max
 
 first = 1
 last = all.Count
 If a(num) < all(1) Then all.Add a(num), BEFORE:=1: GoTo nextnum '加到第一项
 If a(num) > all(last) Then all.Add a(num), AFTER:=last: GoTo nextnum '加到最后一项
 
 
 Do While last > first + 1 '利用DO循环减少循环次数
 temp = (last + first) \ 2
 If a(num) > all(temp) Then
 first = temp
 Else
 last = temp
 steps = steps + 1
 End If
 Loop
 all.Add a(num), BEFORE:=last '加到指定的索引
 
nextnum:
 steps = steps + 1
 Next
 For num = min To max
 If sort = "UP" Or sort = "up" Then a(num) = all(num - min + 1): steps = steps + 1 '升序
 If sort = "DOWN" Or sort = "down" Then a(num) = all(max - num + 1): steps = steps + 1 '降序
 Next
 'MsgBox "本数组共经过 " & steps & "步实现" & IIf(sort = "UP" Or sort = "up", "升序", "降序") & "排序！", 64, "INFORMATION"
 Set all = Nothing
 End Sub



Public Sub UserForm_Initialize()
Dim i As Long, J As Long, S1 As String, T As Single
Dim a As Long, B As Long
Dim y(1000) As String

 fn_temp = App.Path & "\runtime.par"
 JOKE_IN_INTEREST = CSng(ReadPar(fn_temp, "JOKE_IN_INTEREST", "="))
 PUZZLE_IN_INTEREST = CSng(ReadPar(fn_temp, "PUZZLE_IN_INTEREST", "="))
 ELSE_IN_INTEREST = CSng(ReadPar(fn_temp, "ELSE_IN_INTEREST", "="))
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
 ISSUE_DAY_AFTER = CInt(ReadPar(fn_temp, "ISSUE_DAY_AFTER", "="))
 ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) '印刷延误天数，runtime.par文件中，列为 mm2ROW_UNIT,要混在mm2POINT附近，用带小数点的数
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
 TIPS_YES = CInt(ReadPar(fn_temp, "TIPS_YES", "="))

If TRANSP_LINE = 1 Then
 PIC_LEFT = 0
 PIC_TOP = 0
 PIC_RIGHT = 0
 PIC_BOTTOM = 0
End If

JOKE.Value = JOKE_IN_INTEREST
PUZZLE.Value = PUZZLE_IN_INTEREST
ELSEM.Value = ELSE_IN_INTEREST
DELAY_DAYS.Value = ISSUE_DAY_AFTER
ComboBox1.Value = CLASS_FONT_NAME
ComboBox2.Value = TOPIC_FONT_NAME1
ComboBox3.Value = TOPIC_FONT_NAME2
WHITE_BLACK.Value = True
If TOPIC_WHITE_BLACK <> 1 Then WHITE_BLACK.Value = False
DOUBLELINE.Value = False
If CELL_BORDER_TYPE <> 0 Then DOUBLELINE.Value = True
USE_PIC.Value = False
If USE_CLASS_PIC <> 0 Then USE_PIC.Value = True
TRANSPLINE.Value = False
If TRANSP_LINE = 1 Then TRANSPLINE.Value = True
MIXCLASS.Value = False
If MIX_CLASS = 1 Then MIXCLASS.Value = True
BOUNDMIXCLASS.Value = False
If BOUND_MIX_CLASS = 1 Then BOUNDMIXCLASS.Value = True
KEEPWHOLESIZE.Value = True
If KEEP_WHOLE_SIZE = 0 Then KEEPWHOLESIZE.Value = False
BACKRUN.Value = True
If BACK_RUN = 0 Then BACKRUN.Value = False
NOCLASSTITLE.Value = False
If NO_CLASS_TITLE = 1 Then NOCLASSTITLE.Value = True
OUTSIDECLASSTITLE.Value = True
If OUTSIDE_CLASS_TITLE = 0 Then OUTSIDECLASSTITLE.Value = False
TIPS_Y.Value = False
If TIPS_YES <> 0 Then TIPS_Y.Value = True


For i = 0 To Screen.FontCount - 1 '系统可用的显示字体数
 y(i) = Screen.Fonts(i)
Next i
STRINGSORT y, "DOWN" ' "UP"
For i = 0 To 1000 '系统可用的显示字体数
If y(i) <> "" Then
  ComboBox1.AddItem y(i) '加入工具条上的字体名列表框中
  ComboBox2.AddItem y(i)
  ComboBox3.AddItem y(i)
End If
Next i
HEADH_T = CSng(UserForm_Preface.HEADH_i.Value)
FOOTH_T = CSng(UserForm_Preface.FOOTH_i.Value)
HEADH_CHANGED = False
FOOTH_CHANGED = False
Show_Tips
End Sub


Function ReadPar(ByVal File_NM As String, PAR_NM As String, Symbol As String) As String
 On Error GoTo 2222
 Dim temp As String
 Dim n As Integer
 PAR_NM = Trim(PAR_NM)
 Open File_NM For Input As #10
 Do While Not EOF(10)
  DoEvents
  Input #10, temp
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


Sub Show_Tips()
fn = App.Path & "\helptips.par"
FREE_AND_FUNS.ControlTipText = ReadPar(fn, "FREE_AND_FUNS", ":") '包括4项，每项各占多少，总数不能超过100%
JOKE.ControlTipText = ReadPar(fn, "JOKE", ":") '这个数不起太大作用，因为即使你设为0，那也得用笑话填充空白版面呀
PUZZLE.ControlTipText = ReadPar(fn, "PUZZLE", ":") '谜语、智力题，可以试文字的，也可是图形的
ELSEM.ControlTipText = ReadPar(fn, "ELSEM", ":") ' 暂时没有
BUSINESS.ControlTipText = ReadPar(fn, "BUSINESS", ":") ' 老大你的生意联系信息
CompanyInfo_i.ControlTipText = ReadPar(fn, "CompanyInfo_i", ":") '
HotLine_i.ControlTipText = ReadPar(fn, "HotLine_i", ":") ' 会印在版面最顶端的页眉里
CellPhone_i.ControlTipText = ReadPar(fn, "CellPhone_i", ":") ' 会印在版面最下面的页脚里
BankCard_i.ControlTipText = ReadPar(fn, "BankCard_i", ":") '账号会印在版面最下面的页脚里，千万别搞错了，进到我账号不退哦，嘿嘿
YourLogoPath_i.ControlTipText = ReadPar(fn, "YourLogoPath_i", ":") '
FONT_SETTING.ControlTipText = ReadPar(fn, "FONT_SETTING", ":") '设置字体，如果没有的话，就用系统缺省的，一般是宋体
ComboBox1.ControlTipText = ReadPar(fn, "ComboBox1", ":") '比如“招聘”类，如果你选了下面的“广告分类使用图片”，这就被遮住了
ComboBox2.ControlTipText = ReadPar(fn, "ComboBox2", ":") '广告标题有两种，这种印在标题格内部，比较小，字体不要太纤细
ComboBox3.ControlTipText = ReadPar(fn, "ComboBox3", ":") '广告标题有两种，这种和内容印在一起，标题会被放大，比较醒目
DELAY_DAYS.ControlTipText = ReadPar(fn, "DELAY_DAYS", ":") '不能排完就印完了吧，你估计要等几天就填几，这个数用来自动计算前面的出版日期
WHITE_BLACK.ControlTipText = ReadPar(fn, "WHITE_BLACK", ":") '内页如果印黑白的，就选上它，印出来清楚。在网上还是彩色的，这个参数不起作用
DOUBLELINE.ControlTipText = ReadPar(fn, "DOUBLELINE", ":") '喜欢边框是双线就选上，问女朋友是不是喜欢单线的？现在流行单眼皮耶
USE_PIC.ControlTipText = ReadPar(fn, "USE_PIC", ":") '可以自己模仿着做图片，然后放到bin目录下就OK，图片文件名例“class_8.jpg”
TRANSPLINE.ControlTipText = ReadPar(fn, "TRANSPLINE", ":") ': 不想要广告格边框的话就选上，透明即等于没有
MIXCLASS.ControlTipText = ReadPar(fn, "MIXCLASS", ":") ':即不分类，各类广告一起排，适于量小的报纸
BOUNDMIXCLASS.ControlTipText = ReadPar(fn, "BOUNDMIXCLASS", ":")
KEEPWHOLESIZE.ControlTipText = ReadPar(fn, "KEEPWHOLESIZE", ":")
BACKRUN.ControlTipText = ReadPar(fn, "BACKRUN", ":") '
NOCLASSTITLE.ControlTipText = ReadPar(fn, "NOCLASSTITLE", ":") ':去掉广告类标签，省点版面，没太大意义。但你非要这么干，谁也管不着！
OUTSIDECLASSTITLE.ControlTipText = ReadPar(fn, "OUTSIDECLASSTITLE", ":")
TIPS_Y.ControlTipText = ReadPar(fn, "TIPS_Y", ":") '如果这些快速悬停提示损害了老大你的人品，那就关了它，烦死了
SAVE_OTHER.ControlTipText = ReadPar(fn, "SAVE_OTHER", ":") '按了此键就生效，后悔你可来不及，呵呵，没事老大，再改回来呗
Cancel.ControlTipText = ReadPar(fn, "Cancel", ":") '白白了，哎呀，还不明白？就是“闪”的意思
OtherCfg.Repaint
End Sub


Sub HIDE_TIPS()
FREE_AND_FUNS.ControlTipText = ""    ' ReadPar(fn, "FREE_AND_FUNS", ":") '包括4项，每项各占多少，总数不能超过100%
JOKE.ControlTipText = ""    ' ReadPar(fn, "JOKE", ":") '这个数不起太大作用，因为即使你设为0，那也得用笑话填充空白版面呀
PUZZLE.ControlTipText = ""    ' ReadPar(fn, "PUZZLE", ":") '谜语、智力题，可以试文字的，也可是图形的
ELSEM.ControlTipText = ""    ' ReadPar(fn, "ELSEM", ":") ' 暂时没有
BUSINESS.ControlTipText = ""    ' ReadPar(fn, "BUSINESS", ":") ' 老大你的生意联系信息
CompanyInfo_i.ControlTipText = ""
HotLine_i.ControlTipText = ""    ' ReadPar(fn, "HotLine_i", ":") ' 会印在版面最顶端的页眉里
CellPhone_i.ControlTipText = ""    ' ReadPar(fn, "CellPhone_i", ":") ' 会印在版面最下面的页脚里
BankCard_i.ControlTipText = ""    ' ReadPar(fn, "BankCard_i", ":") '账号会印在版面最下面的页脚里，千万别搞错了，进到我账号不退哦，嘿嘿
YourLogoPath_i.ControlTipText = ""    '
FONT_SETTING.ControlTipText = ""    ' ReadPar(fn, "FONT_SETTING", ":") '设置字体，如果没有的话，就用系统缺省的，一般是宋体
ComboBox1.ControlTipText = ""    ' ReadPar(fn, "ComboBox1", ":") '比如“招聘”类，如果你选了下面的“广告分类使用图片”，这就被遮住了
ComboBox2.ControlTipText = ""    ' ReadPar(fn, "ComboBox2", ":") '广告标题有两种，这种印在标题格内部，比较小，字体不要太纤细
ComboBox3.ControlTipText = ""    ' ReadPar(fn, "ComboBox3", ":") '广告标题有两种，这种和内容印在一起，标题会被放大，比较醒目
DELAY_DAYS.ControlTipText = ""    ' ReadPar(fn, "DELAY_DAYS", ":") '不能排完就印完了吧，你估计要等几天就填几，这个数用来自动计算前面的出版日期
WHITE_BLACK.ControlTipText = ""    ' ReadPar(fn, "WHITE_BLACK", ":") '内页如果印黑白的，就选上它，印出来清楚。在网上还是彩色的，这个参数不起作用
DOUBLELINE.ControlTipText = ""    ' ReadPar(fn, "DOUBLELINE", ":") '喜欢边框是双线就选上，问女朋友是不是喜欢单线的？现在流行单眼皮耶
USE_PIC.ControlTipText = ""    ' ReadPar(fn, "USE_PIC", ":") '可以自己模仿着做图片，然后放到bin目录下就OK，图片文件名例“class_8.jpg”
TRANSPLINE.ControlTipText = ""    ': 不想要广告格边框的话就选上，透明即等于没有
MIXCLASS.ControlTipText = ""    ':即不分类，各类广告一起排，适于量小的报纸
BOUNDMIXCLASS.ControlTipText = ""
KEEPWHOLESIZE.ControlTipText = ""
BACKRUN.ControlTipText = ""    '
NOCLASSTITLE.ControlTipText = ""    ':去掉广告类标签，省点版面，没太大意义。但你非要这么干，谁也管不着！
OUTSIDECLASSTITLE.ControlTipText = ""
TIPS_Y.ControlTipText = ""    ' ReadPar(fn, "TIPS_Y", ":") '如果这些快速悬停提示损害了老大你的人品，那就关了它，烦死了
SAVE_OTHER.ControlTipText = ""    ' ReadPar(fn, "SAVE_OTHER", ":") '按了此键就生效，后悔你可来不及，呵呵，没事老大，再改回来呗
Cancel.ControlTipText = ""    ' ReadPar(fn, "Cancel", ":") '白白了，哎呀，还不明白？就是“闪”的意思
OtherCfg.Repaint
End Sub




Private Sub MIXCLASS_AfterUpdate()
  If MIXCLASS.Value = True Then
    BOUNDMIXCLASS.Value = False
  End If
End Sub
Private Sub BOUNDMIXCLASS_AfterUpdate()
  If BOUNDMIXCLASS.Value = True Then
    MIXCLASS.Value = False
  End If
End Sub















