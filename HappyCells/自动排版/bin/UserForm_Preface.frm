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
   StartUpPosition =   2  '��Ļ����
End
Attribute VB_Name = "UserForm_Preface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'addbar.xls�� fontsize.xla �걣�����룺kxqbzggxzk888daqing
'Version 2008 RN:20080108  2008-1-8:�˰汾��Ҫ�Ķ���
'
'��Ҫ������:
'Visual Basic For Applications
'Microsoft Excel 11.0 Object Library
'Microsoft Access 11.0 Object Library
'Microsoft WMI Scripting V1.2 Library
'OLE Automation
'Micosoft Office 11.0 Object Library
'Micosoft ActiveX Data Objects 2.5 Library  '��������ǰ�棬������ܳ���
'Micosoft ActiveX Data Objects Recordset 2.5 Library  '��������ǰ�棬������ܳ���
'Micosoft DAO 3.6 Object Library
   
     
Const SYSTEM_INFO_NAME = "�������鱨վ���Զ��Ű�ϵͳ - HCAutoEdit V2008"

Dim WithEvents xlapp As Application   'Ϊ�˼�⵽ Excel���¼�
Attribute xlapp.VB_VarHelpID = -1
Dim WithEvents Obj_Active_Workbook As Workbook
Attribute Obj_Active_Workbook.VB_VarHelpID = -1



'****************************************          �Ű濪ʼ                 *************************************************
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
TIPS_NUM = CInt(ReadPar(App.Path & "\tips.par", "����", "="))  '��ʾ���ĸ���
BEGIN_TIP_NUM = CInt(Second(Time)) Mod TIPS_NUM + 1
GLOBAL_PARAS_CONFIG
ReDim ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM_PAGE / 2 + 1)
SET_DSN_NAME ("adsdb")
Get_Total_Ads_Num_Rouphly
Get_Type_Num
If MIX_CLASS = 1 Then AD_TYPENUM = 1 '���࣬��Put_All_Ads()��ҲҪ����

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
xlapp.EnableEvents = True   '������ʹ��ͬһ��Excel���̴�����excel�ļ�����Ϊ���ң��� Sub xlapp_WorkbookOpen()���Զ�����һ��Excel����
xlapp.DisplayAlerts = False   '�ص�excel�ľ�����ʾ

If BACK_RUN = 1 Then
  xlapp.Visible = False  '�������ɼ�
Else
  xlapp.Interactive = False   'ʹ�����ɲ���������˸����İ�
  xlapp.Visible = True  '�����ɼ�
  xlapp.WindowState = xlMaximized
  xlapp.DisplayFullScreen = True 'ȫ��
End If
xlapp.DisplayAlerts = False   '�ص�excel�ľ�����ʾ
xlapp.Caption = SYSTEM_INFO_NAME   '��excel ���ڱ���
DoEvents
APP_BEGUN = True
DoEvents
Dim col_str As String       '��ʱ�б��������ڼ���cell����,Ϊ�˼��ٺ������ô������ӿ��ٶ�,��ǰװ�����
Dim title_color As Integer
START_T = Now()
Randomize Int(ISSUE_NUM)
DoEvents

'����һ���¹�����,�յ�,��������Ŀ����:���ɳ�����в������� VBA �������,��ֻ��һ���xls�ļ�
Workbooks.Add
xlapp.EnableEvents = True   '����excel�����������¼���Ϊ���ڴ�����xls�ļ�ʱ�����Ű��ļ�ռ��һ�����̣��������
Set Obj_Active_Workbook = ActiveWorkbook
sn = Worksheets.Count   'ɾ������sheets
Do While sn > 1
  Sheets(sn).Delete
  sn = sn - 1
Loop
Sheets("Sheet1").Name = "��ҳ"
Sheets("��ҳ").Select
DoEvents
WORKBOOKNAME = ActiveWorkbook.Name
DoEvents
App.TaskVisible = True
DoEvents
UserForm_Preface.SetFocus  '�ñ�form��excel ���棬���Լ�������
DoEvents
PROCESS_PERCENTS = 0
ShowPercents_Status PROCESS_PERCENTS, "��ȡ�Ű����"

cellid = "A1:" + COLSTR(COLNUM) + "1"
'�п���ֱ����
ActiveSheet.Range(cellid).ColumnWidth = COLW
DoEvents
ActiveSheet.Range(cellid).VerticalAlignment = xlCenter
DoEvents

If TRANSP_LINE = 0 Then    '����߿�͸��
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
  Worksheets("����").Activate
  DoEvents
  ActiveSheet.DisplayAutomaticPageBreaks = True
End If

If BACK_COVER_PAGE_NUM > 0 Then
  Put_Back_Cover
  Worksheets("���").Activate
  DoEvents
  ActiveSheet.DisplayAutomaticPageBreaks = True
End If
DoEvents
Worksheets("��ҳ").Activate
ActiveSheet.DisplayAutomaticPageBreaks = True
DoEvents
ShowPercents_Status 97, "���������Ϣ..."
Save_All '����ӡˢ��ȫ���ļ�
ShowPercents_Status 100, "���,�ȴ��ֶ�����..."
End_Show
xlapp.DisplayAlerts = False   '�ص�excel�ľ�����ʾ

GoTo END_SUB:
ErrHandler: ErrProc "�����̴��� - BeginButton_Click"
END_SUB:
'*********************************************************       �Ű浽�˽���         *********************************************
'**********************************************************************************************************************************
End Sub

Sub OPEN_JOKES_DB(Mode As Integer)   'mode=1 ��Ц������
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
'����ȫ�̲�������Ҫ���Ű����
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
    'ISSUE_DAY_AFTER = CInt(ReadPar(fn_temp, "ISSUE_DAY_AFTER", "="))  ������Ӧ�ڳ�ʼ��ʱ����
    'ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) 'ӡˢ����������runtime.par�ļ��У���Ϊ mm2ROW_UNIT,Ҫ����mm2POINT�������ô�С�������
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
    'TIPS_YES = CInt(ReadPar(fn_temp, "TIPS_YES", "="))   Ӧ�ڳ�ʼ��ʱ����
    If TRANSP_LINE = 1 Then
        PIC_LEFT = 0
        PIC_TOP = 0
        PIC_RIGHT = 0
        PIC_BOTTOM = 0
    End If

    
    '************* ���������ļ�,���û�������  ******Ϊ�˱����Ű���Ч,����Ҫ�ڰ���ʼ��֮����,�����ⲿ�ֲ����� ���ڳ�ʼ��ʱ��
    '*************************************************************************************************************************
    PAGE_H_mm = CSng(PAGE_H_mm_i.Value)         '���ĸ߶� ����,��ȫ��ӡˢ����(����ҳüҳ��)��ռ�ݵ�ֽ��߶�
    PAGE_W_mm = CSng(PAGE_W_mm_i.Value)         '���Ŀ�� ����,��ȫ��ӡˢ������ռ�ݵ�ֽ����
    COMPAGESNUM = CSng(COMPAGESNUM_i.Value)     'ÿ��ֽ˫��ӡ���棬ÿ�ڿ�����ܰ����Ǹ���Ŀ��������
    BORDERM = CSng(BORDERM_i.Value)  '�߰׳ߴ�(����ȫ��Excel�еı߾�һ��) ���ף���ֽ���ıߵ�������ߵľ��룬ӡˢ�豸Ҫ��ģ�̫Сӡ����
    TOPM = BORDERM                   '����(Excel�г�Ϊҳüλ��) ���ף�����ʵ��ֽ�Ŷ������¼����׵Ŀհף���ӦBOTTOMM
    BOTTOMM = BORDERM                '�װ�(Excel�г�Ϊҳ��λ��) ���ף�����ʵ��ֽ�ŵ׶����ϼ����׵Ŀհף���ӦHAEDH
    LEFTW = BORDERM                  '���(��Excel����߾���ȫ��ͬ) ���ף�����ʵ��ֽ��������Ҽ����׵Ŀհ�
    RIGHTW = BORDERM                 '�Ұ�(��Excel���ұ߾���ȫ��ͬ) ���ף�����ʵ��ֽ���Ҷ����󼸺��׵Ŀհ�
    HEADH = CSng(HEADH_i.Value)      'ҳü�߶�(��ͬ��Excel�е��ϱ߾࣬��Ϊ������ҳüλ�õ�ֵ) ���ף������Ķ��˵���һ�й�涥�˵ĸ߶ȣ��������趨��ҳü��Ҫ14mm
    FOOTH = CSng(FOOTH_i.Value)      'ҳ�Ÿ߶�(��ͬ��Excel�е��±߾࣬��Ϊ������ҳ��λ�õ�ֵ) ���ף������ĵ׶˵�����й��׶˵ĸ߶ȣ��������趨��ҳ����Ҫ13mm
    '*********************************************
    ROWH = (CSng(ROWH_i.Value) - 0.02) * mm2POINT '��λEXCEL ������Сһ��㣬��ó���
    ROWH1 = ROWH / 4         '�����и߶�,��λEXCEL ��
    If ROWH1 > 400 Then ROWH1 = 400 'excel�������409.5
    ROWH2 = ROWH - ROWH1         '�����и߶�
    If ROWH2 > 400 Then ROWH2 = 400 'excel�������409.5
    COLW = CSng(COLW_i.Value)          'ÿ����Ԫ����,����
    COLW = COLW * mm2COLUMN_UNIT       '�ɺ���ת��excel�е�λ
    MAX_FONT_SIZE = CInt(MAX_FONT_SIZE_i.Value)    '���ݸ��п�ȡ������ֺ�
    MIN_FONT_SIZE = CInt(MIN_FONT_SIZE_i.Value)     '���ݸ��п�ȡ����С�ֺ�
    FONT_SIZE_ADJUST = CInt(FONT_SIZE_ADJUST_i.Value)     '�������ݸ�����������Ӵ󼸺ţ����С����
    PERSONAL_FREE_INFO_ROWS = CInt(PERSONAL_FREE_INFO_ROWS_i.Value)
    PERSONAL_FREE_INFO_COLS = CInt(PERSONAL_FREE_INFO_COLS_i.Value)
    COLNUM = Int(COLNUM_i.Value)    'ÿ��������
    ROWNUM_PAGE = Int(ROWNUM_i.Value) * 2
    TOTAL_INTEREST_PERCENTS = CSng(TOTAL_INTEREST_PERCENTS_i.Value)
    If TOTAL_INTEREST_PERCENTS < 0 Then TOTAL_INTEREST_PERCENTS = 0
    JOKE_PERCENTS = TOTAL_INTEREST_PERCENT * JOKE_IN_INTEREST / 100
    If JOKE_PERCENTS < 0 Then JOKE_PERCENTS = 0
    PUZZLE_PERCENTS = TOTAL_INTEREST_PERCENT * PUZZLE_IN_INTEREST / 100
    If PUZZLE_PERCENTS < 0 Then PUZZLE_PERCENTS = 0
    ELSE_PERCENTS = TOTAL_INTEREST_PERCENT * ELSE_IN_INTEREST / 100
    If ELSE_PERCENTS < 0 Then ELSE_PERCENTS = 0
    'ISSUE_DAY_AFTER = CInt(ISSUE_DAY_AFTER_i.Value)   '�ڳ�ʼ��ʱִ��
    ISSUE_DATE_CHR = ISSUE_DATE_i.Value
    ISSUE_NUM = ISSUE_NUM_i.Value      '1 '�ں�
    TOTAL_ISSUE_NUM = TOTAL_ISSUE_NUM_i.Value  '���ں�
    FRONT_COVER_PAGE_NUM = CInt(FRONT_COVER_PAGE_NUM_i.Value)
    BACK_COVER_PAGE_NUM = CInt(BACK_COVER_PAGE_NUM_i.Value)
    If BACK_COVER_PAGE_NUM < 0 Then BACK_COVER_PAGE_NUM = 0
    IS_EXCEL = False
    If DB_OPTION1_i.Value = False Then IS_EXCEL = True
    INSERTING_COLNUM = 0
    INSERTING_ROWNUM = 0
    FROM_LEFT_TO_RIGHT = 0
    MAX_LEN_PER_CELL = Int(MAX_LEN_PER_CELL * (ROWH * COLW) / (32 * 28 * mm2POINT * mm2COLUMN_UNIT)) 'дЦ��ÿ�������������������ˣ������Ҳ���,ԭ��32*28
    If MAX_LEN_PER_CELL < 40 Then MAX_LEN_PER_CELL = 40     '����̫С����Ϊ̫С�Ļ���������ֻʣ�µ�����ʱ���Ҳ������ʵ�Ц�����ˣ�������Ц����ô�̣�����������ѭ��������Ҳ��1������1����
    '**********************************************************************************************************
    '**********  ���û����������  ****************************************************************************
    BEGIN_ROWNUM_THIS_TYPE = 0
    BEGIN_ROWNUM_THIS_TYPE = 1   'û����Ҫ����1
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
    '����������:��ϵ�绰 �����ֻ��� �����ʺ�
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
ErrHandler: ErrProc "��ȡ�������� - GLOBAL_PARAS_CONFIG"
END_SUB:

End Sub


Function Clen(ByVal str As String) As Integer
'�����ִ��ĳ���,��Ӣ����ĸ����,һ����������2������,���Ĳ��ȿ�һ�����İ�1.3�ƣ�������󷵻صĽ������ʵ��Ӣ���ַ�������������ʾ��ȣ���λ�ǰ������
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
stop_y_n = MsgBox("�ֶ��༭����������ݿ���ң�" & vbCrLf & "��ʼ�Զ��Ű�֮ǰ��عر����ݿ⡣ " & vbCrLf & "ȷʵҪ�༭��", 1 + 256, "�������鱨վ���Զ��Ű�ϵͳ")
If stop_y_n <> 1 Then Exit Sub

If DB_OPTION1_i.Value = True Then
 ShellExecute 1, "Open", MY_DOC_PATH & "\�������鱨վ���ĵ�\database\funsdb.mdb", "", "", 1  'SW_SHOWNORMAL ����ʹ
 ShellExecute 2, "Open", MY_DOC_PATH & "\�������鱨վ���ĵ�\database\adsdb.mdb", "", "", 1
 'Shell "msaccess.exe " & Left(App.Path, InStr(App.Path, "\bin")) & "database\adsdb.mdb", vbNormalFocus  'Windowsϵͳ�ļ�����shell
Else
 ShellExecute 3, "Open", MY_DOC_PATH & "\�������鱨վ���ĵ�\database\funsdb.xls", "", "", 1   'SW_SHOWNORMAL
 ShellExecute 4, "Open", MY_DOC_PATH & "\�������鱨վ���ĵ�\database\adsdb.xls", "", "", 1   'SW_SHOWNORMAL
End If
k = 5
m = 6
L = CStr(k * m)
End Sub

Public Sub FinishButton_Click()

'�ر�excel�ľ�����ʾ
xlapp.DisplayAlerts = False
'�ر� HCAutoEdit.xls,������,����Excel
'Windows("HCAutoEdit.xls").Activate
'ActiveWorkbook.Close
xlapp.WindowState = xlMaximized
xlapp.Interactive = True   'ʹ���ɲ��������ֶ��༭
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
 WK = Array("", "��", "һ", "��", "��", "��", "��", "��") '���ִ�Ϊ����Ӧ Weekday����
 ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "��" + CStr(Month(issue_date)) + "��" + CStr(Day(issue_date)) + "��" + " ����" + CStr(WK(Weekday(issue_date)))
 ISSUE_DATE_i.ForeColor = RGB(255, 0, 0)
End Sub

Public Sub ISSUE_DATE_CHANGE_i_SpinUp()
 issue_date = issue_date + 1
 If issue_date > Date + ISSUE_NUM_CHANGE_CONTROL_days Then issue_date = Date + ISSUE_NUM_CHANGE_CONTROL_days
 Dim WK As Variant
 WK = Array("", "��", "һ", "��", "��", "��", "��", "��") '���ִ�Ϊ����Ӧ Weekday����
 ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "��" + CStr(Month(issue_date)) + "��" + CStr(Day(issue_date)) + "��" + " ����" + CStr(WK(Weekday(issue_date)))
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
 ShellExecute 111, "Open", "http://www.kxqbz.com", "", "", 1 'SW_SHOWNORMAL ����ʹ
End Sub

Public Sub OTHER_CFG_Click()
'����������:��ϵ�绰 �����ֻ��� �����ʺ�
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
 '��ȱʡ�����ļ� dft-cfg.par
 Dim fn_temp As Variant
 fn_temp = App.Path & "\dft-cfg.par"
 PAGE_H_mm_i.Value = ReadPar(fn_temp, "���ĸ߶�", "=")
 PAGE_W_mm_i.Value = ReadPar(fn_temp, "���Ŀ��", "=")
 HEADH_i.Value = ReadPar(fn_temp, "ҳü�߶�", "=")
 FOOTH_i.Value = ReadPar(fn_temp, "ҳ�Ÿ߶�", "=")
 BORDERM_i.Value = ReadPar(fn_temp, "�߰׳ߴ�", "=")
 COMPAGESNUM_i.Value = ReadPar(fn_temp, "������Ŀ", "=")
 COLNUM_i.Value = CInt(ReadPar(fn_temp, "���������", "="))
 ROWNUM_i.Value = CInt(ReadPar(fn_temp, "���������", "="))
 COLW_i.Value = ReadPar(fn_temp, "ÿ����", "=")
 ROWH_i.Value = ReadPar(fn_temp, "ÿ��߶�", "=")
 MAX_FONT_SIZE_i.Value = ReadPar(fn_temp, "����ֺ�", "=")
 MIN_FONT_SIZE_i.Value = ReadPar(fn_temp, "��С�ֺ�", "=")
 FONT_SIZE_ADJUST_i.Value = ReadPar(fn_temp, "�ֺŵ���", "=")
 PERSONAL_FREE_INFO_ROWS_i.Value = ReadPar(fn_temp, "��Ѹ�����Ϣ��ռ����", "=")
 PERSONAL_FREE_INFO_COLS_i.Value = ReadPar(fn_temp, "��Ѹ�����Ϣ��ռ����", "=")
 TOTAL_INTEREST_PERCENTS_i.Value = ReadPar(fn_temp, "Ȥζ�����ϱ���", "=")
 FRONT_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "�������", "=")
 BACK_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "��װ���", "=")
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
 '����������ļ� k-cfg.par  ����Ϊ��ɫ����ͬ��UserForm_Preface.Initialize �����ﲻ�ú�ɫ�����������������Զ�������ĳЩֵ
 Dim fn_temp As Variant
 fn_temp = App.Path & "\k-cfg.par"
 PAGE_H_mm_i.Value = ReadPar(fn_temp, "���ĸ߶�", "=")
 PAGE_W_mm_i.Value = ReadPar(fn_temp, "���Ŀ��", "=")
 HEADH_i.Value = ReadPar(fn_temp, "ҳü�߶�", "=")
 FOOTH_i.Value = ReadPar(fn_temp, "ҳ�Ÿ߶�", "=")
 BORDERM_i.Value = ReadPar(fn_temp, "�߰׳ߴ�", "=")
 COMPAGESNUM_i.Value = ReadPar(fn_temp, "������Ŀ", "=")
 COLNUM_i.Value = CInt(ReadPar(fn_temp, "���������", "="))
 ROWNUM_i.Value = CInt(ReadPar(fn_temp, "���������", "="))
 COLW_i.Value = ReadPar(fn_temp, "ÿ����", "=")
 ROWH_i.Value = ReadPar(fn_temp, "ÿ��߶�", "=")
 MAX_FONT_SIZE_i.Value = ReadPar(fn_temp, "����ֺ�", "=")
 MIN_FONT_SIZE_i.Value = ReadPar(fn_temp, "��С�ֺ�", "=")
 FONT_SIZE_ADJUST_i.Value = ReadPar(fn_temp, "�ֺŵ���", "=")
 PERSONAL_FREE_INFO_ROWS_i.Value = ReadPar(fn_temp, "��Ѹ�����Ϣ��ռ����", "=")
 PERSONAL_FREE_INFO_COLS_i.Value = ReadPar(fn_temp, "��Ѹ�����Ϣ��ռ����", "=")
 TOTAL_INTEREST_PERCENTS_i.Value = ReadPar(fn_temp, "Ȥζ�����ϱ���", "=")
 FRONT_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "�������", "=")
 BACK_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "��װ���", "=")
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
'д�����ļ� k-cfg.par,����ȱʡ����,ȱʡ�����ļ�Ϊ dft-cfg.par
 Open App.Path & "\k-cfg.par" For Output As #10
 Print #10, "���ĸ߶�=" & PAGE_H_mm_i.Value
 Print #10, "���Ŀ��=" & PAGE_W_mm_i.Value
 Print #10, "ҳü�߶�=" & HEADH_i.Value
 Print #10, "ҳ�Ÿ߶�=" & FOOTH_i.Value
 Print #10, "�߰׳ߴ�=" & BORDERM_i.Value
 Print #10, "������Ŀ=" & COMPAGESNUM_i.Value
 Print #10, "���������=" & COLNUM_i.Value
 Print #10, "���������=" & ROWNUM_i.Value
 Print #10, "ÿ����=" & COLW_i.Value
 Print #10, "ÿ��߶�=" & ROWH_i.Value
 Print #10, "����ֺ�=" & MAX_FONT_SIZE_i.Value
 Print #10, "��С�ֺ�=" & MIN_FONT_SIZE_i.Value
 Print #10, "�ֺŵ���=" & FONT_SIZE_ADJUST_i.Value
 Print #10, "��Ѹ�����Ϣ��ռ����=" & PERSONAL_FREE_INFO_ROWS_i.Value
 Print #10, "��Ѹ�����Ϣ��ռ����=" & PERSONAL_FREE_INFO_COLS_i.Value
 Print #10, "Ȥζ�����ϱ���=" & TOTAL_INTEREST_PERCENTS_i.Value
 Print #10, "�������=" & FRONT_COVER_PAGE_NUM_i.Value
 Print #10, "��װ���=" & BACK_COVER_PAGE_NUM_i.Value
 Close #10
 DoEvents
End Sub

Public Sub StopButton_Click()
Dim stop_y_n
If APP_BEGUN = True Then
  stop_y_n = MsgBox("�˳��������������ݿ���ң�" & vbCrLf & "�뱣��������ݡ� " & vbCrLf & "ȷʵҪ�˳���", 1 + 256, "�������鱨վ���Զ��Ű�ϵͳ")
  If stop_y_n = 1 Then
     xlapp.WindowState = xlMaximized
     xlapp.Interactive = True   'ʹ���ɲ��������ֶ��༭
     xlapp.DisplayFullScreen = False
     xlapp.Visible = True
     '�ر� Excel,������
     If CLOSE_EXCEL_i.Value = True Then xlapp.Quit
     End
  End If
Else
  '�ر� Excel,������
  'xlapp.Quit
  End
End If
End Sub


Public Sub UserForm_Initialize()
 On Error GoTo ErrHandler:
 CONTACT_INFO = "   ����ϵ���췽�������޹�˾ (���ð汾Ҳ���м���֧��)" & vbCrLf & _
                "        ��ַ:www.kxqbz.com" & vbCrLf & _
                "        �绰:0459-5514422 5773694 13644697987     " & vbCrLf & _
                "        QQ:5632147 492533636"
                
 Get_My_Documents_Path  '����ҵ��ĵ�·��
 
 'ActiveWorkbook.Sheets(1).Name = "�����鱨վ ���Ц�ſ�" '������,���ܳ���31�ַ�
 UserForm_Preface.Caption = SYSTEM_INFO_NAME
 'UserForm_Preface.Show

 UserForm_Preface.Height = 5400 '268 excel�ĳߴ絥λ��VB��һ��
 UserForm_Preface.Width = 7850
 'logo.Picture = LoadPicture(app.Path & "\k-logo1.jpg")
 'percents_up.Picture = LoadPicture(app.Path & "\percents.jpg")

 '�������ļ� k-cfg.par,����ȱʡ����,ȱʡ�����ļ�Ϊ dft-cfg.par
 'Dim temp As Single
 Dim fn_temp, fn_temp2, tempp As Variant
 fn_temp = App.Path & "\k-cfg.par"
 PAGE_H_mm_i.Value = ReadPar(fn_temp, "���ĸ߶�", "=")
 PAGE_W_mm_i.Value = ReadPar(fn_temp, "���Ŀ��", "=")
 HEADH_i.Value = ReadPar(fn_temp, "ҳü�߶�", "=")
 FOOTH_i.Value = ReadPar(fn_temp, "ҳ�Ÿ߶�", "=")
 BORDERM_i.Value = ReadPar(fn_temp, "�߰׳ߴ�", "=")
 COMPAGESNUM_i.Value = ReadPar(fn_temp, "������Ŀ", "=")
 COLNUM_i.Value = CInt(ReadPar(fn_temp, "���������", "="))
 ROWNUM_i.Value = CInt(ReadPar(fn_temp, "���������", "="))
 COLW_i.Value = ReadPar(fn_temp, "ÿ����", "=")
 ROWH_i.Value = ReadPar(fn_temp, "ÿ��߶�", "=")
 MAX_FONT_SIZE_i.Value = ReadPar(fn_temp, "����ֺ�", "=")
 MIN_FONT_SIZE_i.Value = ReadPar(fn_temp, "��С�ֺ�", "=")
 FONT_SIZE_ADJUST_i.Value = ReadPar(fn_temp, "�ֺŵ���", "=")
 PERSONAL_FREE_INFO_ROWS_i.Value = ReadPar(fn_temp, "��Ѹ�����Ϣ��ռ����", "=")
 PERSONAL_FREE_INFO_COLS_i.Value = ReadPar(fn_temp, "��Ѹ�����Ϣ��ռ����", "=")
 TOTAL_INTEREST_PERCENTS_i.Value = ReadPar(fn_temp, "Ȥζ�����ϱ���", "=")
 FRONT_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "�������", "=")
 BACK_COVER_PAGE_NUM_i.Value = ReadPar(fn_temp, "��װ���", "=")
 OLD_COLNUM = CInt(COLNUM_i.Value)
 OLD_ROWNUM_PAGE = CInt(ROWNUM_i.Value) * 2


 '��runtime.par '��Ӧ�ڿ�ʼ������������⼸������Ҫ��
 fn_temp = App.Path & "\runtime.par"
 ISSUE_DAY_AFTER = CInt(ReadPar(fn_temp, "ISSUE_DAY_AFTER", "="))
 ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) 'ӡˢ����������runtime.par�ļ��У���Ϊ mm2ROW_UNIT,Ҫ����mm2POINT�������ô�С�������
 TIPS_YES = CInt(ReadPar(fn_temp, "TIPS_YES", "="))
 If TIPS_YES <> 0 Then
    fn_temp2 = App.Path & "\helptips.par"  '���ٰ�����ʾ�ļ�
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
 
 '���ں��ļ�
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
 WK = Array("", "��", "һ", "��", "��", "��", "��", "��") '���ִ�Ϊ����Ӧ Weekday����
 ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "��" + CStr(Month(issue_date)) + "��" + CStr(Day(issue_date)) + "��" + " ����" + CStr(WK(Weekday(issue_date)))
  
 Define_Color
 Define_Display_Mode_2_Font_Size
 
 APP_BEGUN = False
 Final_Checked = False
 SCANTIMES = 0
 WRITING_FIRST_ADS = True
 
 '�������֤
 GET_LICENCE
 If LICENCE_STATUS = 0 Or LICENCE_STATUS = 4 Then
   DB_OPTION1_i.Value = False
   DB_OPTION2_i.Value = True
   CLOSE_EXCEL_i.Enabled = False
 End If

 EXCEL_STARTED = True
 SET_BTTNS   '���������������ż�


GoTo END_SUB:
ErrHandler: ErrProc "��ʼ������ - UserForm_Initialize"
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
    Left_Time.Caption = CStr(1 + Int(3 * TOTAL_ADS_NUM_ROUPH / 100# * (100 - percents) / 100 * (1 + TOTAL_INTEREST_PERCENTS / 100))) + "����"
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
'��ʾ�Ű�ͳ�Ʊ���
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
Create_Dir MY_DOC_PATH & "\�������鱨վ���ĵ�\�Ű�ͳ�Ʊ���"
If TEST_i.Value = True Then
'�������Ÿ�,����Ϊ���Ÿ�
Create_Dir MY_DOC_PATH & "\�������鱨վ���ĵ�\�����\���Ÿ�\ӡˢ��"
save_filename = MY_DOC_PATH & "\�������鱨վ���ĵ�\�����\���Ÿ�\ӡˢ��\���Ÿ�-ӡˢ��.xls"
'�������Ű�ͳ�Ʊ����ļ��� Ϊ "���Ÿ��Ű�ͳ�Ʊ���.txt"
report_filename = MY_DOC_PATH & "\�������鱨վ���ĵ�\�Ű�ͳ�Ʊ���\���Ÿ��Ű�ͳ�Ʊ���.txt"
Else
'������ʽ��
'��excel�ľ�����ʾ,�Է�ֹ���Ǿɳ�����ļ�
xlapp.DisplayAlerts = True

'��������,����Ϊ ��XXX��-��YYY��(��������),��������Ŀ����:���ɳ�����в������� VBA �������,��ֻ��һ���xls�ļ�
Create_Dir MY_DOC_PATH & "\�������鱨վ���ĵ�\�����\" & "��" & ISSUE_NUM & "��-��" & TOTAL_ISSUE_NUM & "��(" & ISSUE_DATE_CHR & ")\ӡˢ��"
save_filename = MY_DOC_PATH & "\�������鱨վ���ĵ�\�����\" & "��" & ISSUE_NUM & "��-��" & TOTAL_ISSUE_NUM & "��(" & ISSUE_DATE_CHR & ")\ӡˢ��\��" & ISSUE_NUM & "��-��" & TOTAL_ISSUE_NUM & "��(" & ISSUE_DATE_CHR & ")-ӡˢ��.xls"
'���Ű�ͳ�Ʊ��棬�ļ���Ϊ "��XX���Ű�ͳ�Ʊ���.txt"
report_filename = MY_DOC_PATH & "\�������鱨վ���ĵ�\�Ű�ͳ�Ʊ���\��" + CStr(ISSUE_NUM) + "��-��" + CStr(TOTAL_ISSUE_NUM) + "��(" + CStr(ISSUE_DATE_CHR) + ")�Ű�ͳ�Ʊ���.txt"


'���±�����һ���ں�,Ҫ��HCAutoEdit.xls �ر�ǰ����
 Open App.Path & "\issuenum.par" For Output As #10
 Print #10, ISSUE_NUM + 1
 Print #10, TOTAL_ISSUE_NUM + 1
 Close #10
End If
DoEvents
'�������һ���Ű���Ҫ����
 Open App.Path & "\lastinfo.par" For Output As #10
 Print #10, save_filename
 Close #10
DoEvents
'���Ű���
ActiveWorkbook.SaveAs FileName:=save_filename
DoEvents
'���Ű�ͳ�Ʊ���
 Open report_filename For Output As #10
 Print #10, "************ �Ű���� ************"
 Print #10, "���ĳߴ�(mm): ��: " + CStr(PAGE_H_mm_i.Value) + "  ��: " + CStr(PAGE_W_mm_i.Value)
 Print #10, "ҳü(mm): " + CStr(HEADH_i.Value)
 Print #10, "ҳ��(mm): " + CStr(FOOTH_i.Value)
 Print #10, "�߰�(mm): " + CStr(BORDERM_i.Value)
 Print #10, "������: " + CStr(COMPAGESNUM_i.Value)
 Print #10, "���������: " + CStr(COLNUM_i.Value)
 Print #10, "���������: " + CStr(ROWNUM_i.Value)
 Print #10, "ÿ����(mm): " + CStr(COLW_i.Value)
 Print #10, "ÿ��߶�(mm): " + CStr(ROWH_i.Value)
 Print #10, "������������ֺ�: " + CStr(MAX_FONT_SIZE_i.Value)
 Print #10, "������С�����ֺ�: " + CStr(MIN_FONT_SIZE_i.Value)
 Print #10, "�ֺ��������ֵ: " + CStr(FONT_SIZE_ADJUST_i.Value)
 Print #10, "���������Ϣ��Ԫ������: " + CStr(PERSONAL_FREE_INFO_ROWS_i.Value)
 Print #10, "���������Ϣ��Ԫ������: " + CStr(PERSONAL_FREE_INFO_COLS_i.Value)
 Print #10, "Ȥζ�Բ��ϰٷֱ�(%): " + CStr(TOTAL_INTEREST_PERCENTS_i.Value)

 
 Print #10, "************ �Ű�ͳ�� ************"
 Print #10, "�ں�: " + CStr(ISSUE_NUM_i.Value)
 Print #10, "���ں�: " + CStr(TOTAL_ISSUE_NUM_i.Value)
 Print #10, "��������: " + CStr(ISSUE_DATE_i.Value)
 Print #10, "�������: " + CStr(FRONT_COVER_PAGE_NUM_i.Value)
 Print #10, "��װ���: " + CStr(BACK_COVER_PAGE_NUM_i.Value)

 
 Print #10, "��������: " + CStr(TOTAL_PAGE_NUM_s.Value)
 Print #10, "�������: " + CStr(TOTAL_ADS_NUM_s.Value)
 Print #10, "��λ����: " + CStr(TOTAL_ADS_CELLS_s.Value)
 Print #10, "�������: " + CStr(AD_TYPENUM_s.Value)
 Print #10, "Ԥ������: " + CStr(INCOME_s.Value)

 Print #10, "�������: " + CStr(TOTAL_FREE_NUM_s.Value)
 Print #10, "Ц������: " + CStr(TOTAL_JOKE_NUM_s.Value)
 Print #10, "��������: " + CStr(TOTAL_PUZZLE_NUM_s.Value)
 Print #10, "��������: " + CStr(TOTAL_ELSE_NUM_s.Value)
 Print #10, "�Ű���ʱ: " + CStr(EDIT_TIME_s.Value)
 Print #10,

 Close #10
DoEvents
GoTo END_SUB:
ErrHandler: ErrProc "�����ļ����� - Save_All"
END_SUB:
End Sub



Sub Set_Head_Foot()
    On Error GoTo 7659
    PROCESS_PERCENTS = 85  'PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "���ô�ӡҳ��..."
    '���ñ߰� ҳü��
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "����ҳ��:���"
    DoEvents
    ActiveSheet.PageSetup.LeftMargin = xlapp.InchesToPoints((LEFTW - 1) / 25.4) '�˺�������Ӣ��,Ҫ����ɺ���
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "����ҳ��:�Ұ�"
    DoEvents
    ActiveSheet.PageSetup.RightMargin = xlapp.InchesToPoints((RIGHTW - 1) / 25.4) '��Сһ�㣬����װ����
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "����ҳ��:����"
    DoEvents
    ActiveSheet.PageSetup.HeaderMargin = xlapp.InchesToPoints(TOPM / 25.4)
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "����ҳ��:����"
    DoEvents
    ActiveSheet.PageSetup.TopMargin = xlapp.InchesToPoints((HEADH + TOPM) / 25.4)
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "����ҳ��:�װ�"
    DoEvents
    ActiveSheet.PageSetup.FooterMargin = xlapp.InchesToPoints(BOTTOMM / 25.4)
    PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    ShowPercents_Status PROCESS_PERCENTS, "����ҳ��:�װ�"
    DoEvents
    ActiveSheet.PageSetup.BottomMargin = xlapp.InchesToPoints((FOOTH + BOTTOMM) / 25.4)
    'ҳüҳ��
    'PROCESS_PERCENTS = PROCESS_PERCENTS + 1
    'If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
    'ShowPercents_Status PROCESS_PERCENTS, "����ҳü/ҳ��..."
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
        ShowPercents_Status PROCESS_PERCENTS, "����ҳü..."
        DoEvents
        
        .LeftHeader = "&G"
        .CenterHeader = _
        "&""����,����""&10              ������ʾ��������Ϣ�Ѿ���" & Chr(10) & "              ����飬����������ϸ��֤" _
          & Chr(10) & "&""����,�Ӵ�""&10             ���ߵ绰:" & HOTLINE   '& " ���չ��:" & CELLPHONE
        .RightHeader = "&""����_GB2312,�Ӵ�""&10��" & ISSUE_NUM & "��/��" & TOTAL_ISSUE_NUM & "��" & Chr(10) & "��" & "&P" & "��/��" & TOTAL_PAGE_NUM & "��" & Chr(10) & ISSUE_DATE_CHR
        .LeftHeaderPicture.FileName = App.Path & "\hf_logo.jpg"
        .LeftHeaderPicture.Height = 40
        .LeftHeaderPicture.Width = 183
       End If
       
       If FOOTH > 0 Then
        PROCESS_PERCENTS = PROCESS_PERCENTS + 1
        If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
        ShowPercents_Status PROCESS_PERCENTS, "����ҳ��..."
        DoEvents
        
        .LeftFooter = ""
        .CenterFooter = _
        "&""����,�Ӵ�""&10ҵ������:&""����,����""����Ч֤��(1)�������鱨վ����վ����;(2)�����ύ;(3)�����ŵ�" & CELLPHONE & ";(4)�����ߵ绰��ÿ��Ԫ������<80��ͼ�δ�С���ޡ�&""����,�Ӵ�""����:&""����,����""�ֽ������ʺ�" & BANKCARD & "�����ϸ��" & Chr(10) & _
        "&""����,�Ӵ�""&8����ȫ�����غ������ ͳһ�̱� ������Ӫ ������� ���߷��� ����ƽ̨ ������ӡ �绰:0459-5514422 5773694"
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
    atemp = MsgBox(vbCrLf & "   ��ʾ: ���ĵ���û�а�װ��ӡ�����ӡ����֧�����趨�����ԣ������޷�����ҳ������      " & vbCrLf & vbCrLf & _
                "   �Ű��Կɼ������У�����ȱ��ҳü��ҳ��(����ϵ��Ϣ)��" & vbCrLf & vbCrLf & _
                "   ���鰲װ�����ӡ�������� SmartPrinter(���������Ʒ:www.i-enet.com) ��", 0 + 64, "�������鱨վ���Զ��Ű�ϵͳ")

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
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then   '��д��1�ࣨ�ɹ���д�ĵ�1�࣬���ݿ��в�һ���ǵ�1�ࣩ�����뿪���鱨վ��棬��������ð�
  TOTAL_ADS_NUM_THIS_TYPE = TOTAL_ADS_NUM_THIS_TYPE + 1                           '������㿪���鱨վ������Ŀ
  TOTAL_ADS_NUM = TOTAL_ADS_NUM + 1
  TOTAL_ADS_CELLS_THIS_TYPE = TOTAL_ADS_CELLS_THIS_TYPE + 2 * 3 * 2  '��3��2����
  TOTAL_ADS_CELLS = TOTAL_ADS_CELLS + 2 * 3 * 2
End If
BEGIN_ROWNUM_LAST_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_LAST_TYPE = END_ROWNUM_THIS_TYPE
ROWNUM_THIS_TYPE = 2
If TOTAL_INTEREST_PERCENTS > 0 Then ROWNUM_THIS_TYPE = 2 + Int(Int(TOTAL_ADS_CELLS_THIS_TYPE * (1 + TOTAL_INTEREST_PERCENTS / 100)) / COLNUM)   'ȫ�������������ÿ�����ռ2��excel��,TOTAL_ADS_CELLS�ǳ˹�2��
If ROWNUM_THIS_TYPE Mod 2 <> 0 Then ROWNUM_THIS_TYPE = ROWNUM_THIS_TYPE + 1
ROWNUM = ROWNUM + ROWNUM_THIS_TYPE
BEGIN_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 1     '�ϸ����������ۼӣ���һ�����ʱ��ֵ������ǰ��Ŀ�����
t_BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + ROWNUM_THIS_TYPE - 1
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + TOTAL_ADS_CELLS_THIS_TYPE
t_NAME_THIS_TYPE = NAME_THIS_TYPE
If Len(NAME_THIS_TYPE) > 2 Then t_NAME_THIS_TYPE = Left(NAME_THIS_TYPE, 2) & "~"
ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
ShowPercents_Status PROCESS_PERCENTS, "������:" & a_type & "-" & t_NAME_THIS_TYPE + "-��������"

DoEvents
For i = BEGIN_ROWNUM_THIS_TYPE To ROWNUM Step 2
   DoEvents
   ActiveSheet.Range("A" + CStr(i)).RowHeight = ROWH1
   ActiveSheet.Range("A" + CStr(i + 1)).RowHeight = ROWH2
Next i
Dim Ctt_i, class_t_nm As String
'�������Ŀ¼����
     Ctt_i = Ctt_i + " ��" + NAME_THIS_TYPE + ":" + "P" + CStr(Int((BEGIN_ROWNUM_THIS_TYPE - 1) / ROWNUM_PAGE + 1 + FRONT_COVER_PAGE_NUM))
     COVER_CONTENTS = COVER_CONTENTS + " ��" + NAME_THIS_TYPE + ":" + "P" + CStr(Int((BEGIN_ROWNUM_THIS_TYPE - 1) / ROWNUM_PAGE + 1 + FRONT_COVER_PAGE_NUM))
     If Len(Ctt_i) > 70 Then
       COVER_CONTENTS = COVER_CONTENTS & Chr(10)
       Ctt_i = ""
    End If
    COVER_CONTENTS = Trim(COVER_CONTENTS)
DoEvents
'������ǩ
If Not (NO_CLASS_TITLE = 1 Or MIX_CLASS = 1) Then '�����ȥ��������ǩ����Ҫ������ǩ�Ļ������߲��ǻ���Ļ���Ϊ�˽�ʡ���棬����ȥ�����ǩ
     Dim CLASS_COLNUM, t_Page_Num As Integer   '��żҳ������ǩ�Ƿ���࣬ȱʡ����
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
     ActiveWorkbook.Names.Add Name:="type" + CStr(a_type), RefersToR1C1:="=��ҳ!R" + CStr(BEGIN_ROWNUM_THIS_TYPE) + "C1"
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
'��д�൥Ԫ��Ĺ��
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " (a_row>1 or a_col>1) order by a_row desc,a_col desc,a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  PROCESS_PERCENTS = PROCESS_PERCENTS + ((30# - 1) / TOTAL_ADS_NUM_THIS_TYPE / AD_TYPENUM)
  t_TITLE = Trim(rs("a_title") & "")
  If t_TITLE = "" Then t_TITLE = "�ޱ���"
  ShowPercents_Status PROCESS_PERCENTS, "������:" & a_type & "-" & t_NAME_THIS_TYPE + " " + CStr(i_ads) + "/" + CStr(TOTAL_ADS_NUM_THIS_TYPE) & "-" & t_TITLE
  Write_Multi_Cells_Unit "ads\" & rs("a_id"), rs("a_title") & "", rs("a_content") & "", rs("a_col") + 0, rs("a_row") + 0, rs("a_mode") + 0, True  'Ϊ�˱��ʽ�����Զ�ת��,��֤���ѹ�����ɹ�
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
'��������ð�����ع��ڣ�1���£�������롶�����鱨վ�����
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then
  Write_Multi_Cells_Unit "kxqbz_ad", "", "{pic}", 3, 2, 2, True  '��֤����ɹ�
End If
'����д������Ԫ��Ĺ��
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
  t_TITLE = Trim(rs("a_title") & "")  '��NULL -> ""
  If t_TITLE = "" Then t_TITLE = "�ޱ���"
  ShowPercents_Status PROCESS_PERCENTS, "������:" & a_type & "-" & t_NAME_THIS_TYPE + " " + CStr(i_ads) + "/" + CStr(TOTAL_ADS_NUM_THIS_TYPE) & "-" & t_TITLE
  Write_One_Cell_Unit "ads\" & rs("a_id"), rs("a_title") & "", rs("a_content") & "", rs("a_mode") 'Ϊ�˱��ʽ�����Զ�ת��
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
'TOTAL_CELLS = TOTAL_CELLS + (END_ROWNUM_THIS_TYPE - BEGIN_ROWNUM_THIS_TYPE + 1) * COLNUM
TOTAL_CELLS = END_ROWNUM_THIS_TYPE * COLNUM
BEGIN_ROWNUM_THIS_TYPE = t_BEGIN_ROWNUM_THIS_TYPE
WRITING_FIRST_ADS = False   '����Ϊ���ǵ�һ��дһ������
End Sub

Sub Put_Personal_Free_Info()
'д���������Ϣ,��������Ź��֮��
On Error Resume Next

If PERSONAL_FREE_INFO_ROWS <= 0 Or PERSONAL_FREE_INFO_COLS <= 0 Then Exit Sub
If END_ROWNUM_THIS_TYPE + 1 > FINAL_ROWNUM Then Exit Sub  '������ϰ��油���˷�̫��Ͳ�������
FROM_LEFT_TO_RIGHT = 1
Dim title, Content As String
Dim NUM_IN_DB, t_BEGIN_ROWNUM_THIS_TYPE, T_end_rownum_this_type, T_personal_free_info_rows, T_personal_free_info_cols, T_NO_CLASS_TITLE As Integer '��ʱ��¼����ӳ��ʼ�ͽ����еı仯���仯����ΪҪ��֤����ɹ����͵ü���
T_personal_free_info_rows = PERSONAL_FREE_INFO_ROWS
T_personal_free_info_cols = PERSONAL_FREE_INFO_COLS
title = "���������Ϣ(δ��ʵ������)"


ITEMS_NUM_PER_ROW = CInt(4 * ROWH / ((6 + 22) * mm2POINT))   '��A4��׼ʱÿ����п�д4�������Ϣ��ָ���������Ϣÿ����(����2��)4�������ǰ������е�

Dim Tstr1, Tstr2 As String

conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "p_free_info" & R_s & " order by p_id desc"
rs.Open SQL_Str, conn, 2, 2
DoEvents
'��������Ϣ�������������粻�����Զ���С�����������߲�����
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
  Exit Sub    '���һ���Ǽ��ϵ�˵�������ٿ����վλ��
End If

PERSONAL_FREE_INFO_ROWS = Int(NUM_IN_DB / (ITEMS_NUM_PER_ROW * PERSONAL_FREE_INFO_COLS / 2))
If PERSONAL_FREE_INFO_ROWS > T_personal_free_info_rows Then PERSONAL_FREE_INFO_ROWS = T_personal_free_info_rows
If PERSONAL_FREE_INFO_ROWS > ROWNUM_PAGE Then PERSONAL_FREE_INFO_ROWS = ROWNUM_PAGE  '������1ҳ
ROWNUM_THIS_TYPE = PERSONAL_FREE_INFO_ROWS * 2
BEGIN_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 1     '�ϸ����������ۼӣ���һ�����ʱ��ֵ������ǰ��Ŀ�����
T_NO_CLASS_TITLE = NO_CLASS_TITLE   'д���������Ϣʱ�൱���������Ĺ��
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
ShowPercents_Status PROCESS_PERCENTS, "������������Ϣ-��������"
'ActiveSheet.Range("A" + CStr(BEGIN_ROWNUM_THIS_TYPE) + ":" + colstr( COLNUM) + CStr(END_ROWNUM_THIS_TYPE)).Value = " " '�ÿհף���ʾδռ��
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
For i = 1 To PERSONAL_FREE_INFO_ROWS * ITEMS_NUM_PER_ROW - KKK  'ȱʡÿ��׼����п���д4�������Ϣ�����ܲ���4�������һ������˵��
  DoEvents
  TOTAL_FREE_NUM = TOTAL_FREE_NUM + 1
  Tstr1 = rs("p_content")
  Tstr2 = rs("p_contact")
  Tstr1 = Trim(Tstr1)
  Tstr2 = Trim(Tstr2)
  Tstr1 = Merge_CRs(Tstr1 & "") '�ϲ�����س�
  Tstr2 = Merge_CRs(Tstr2)  '�ϲ�����س�
  Tstr1 = Cut_CR(Tstr1 & "")     '�ɵ��س�
  Tstr2 = Cut_CR(Tstr2)
  Tstr1 = Left(Tstr1, 25)
  Tstr2 = Left(Tstr2, 25)
  Content = Content & Tstr1 & Chr(10) & Tstr2 & Chr(10)
  rs.MoveNext
Next i
Content = Left(Content, Len(Content) - 1)
If KKK = 1 Then Content = Content & "^|" & "��ʾ��������ֻ���������ύ����Ϣ" & Chr(10) & "�绰��������ʽ�������ܾ���������"
PROCESS_PERCENTS = 51   'PROCESS_PERCENTS + 1
ShowPercents_Status PROCESS_PERCENTS, "������������Ϣ:" & iii & "/" & Int(PERSONAL_FREE_INFO_COLS / 2)
Write_Multi_Cells_Unit "no__use", title & "", Content, 2, Int(PERSONAL_FREE_INFO_ROWS), 1, True '��֤����ɹ�
Next iii
DoEvents

rs.Close
conn.Close
DoEvents

T_end_rownum_this_type = END_ROWNUM_THIS_TYPE - T_end_rownum_this_type  '�����мӴ����Ŀ,END_ROWNUM_THIS_TYPE ��Write_Multi..�����б仯

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
Range(cellid).Characters(Start:=7, Length:=800).Font.Name = "����_GB2312"
Range(cellid).Characters(Start:=7, Length:=800).Font.Size = 10
DoEvents
For jjjj = 1 To PERSONAL_FREE_INFO_COLS Step 2
cellid = COLSTR(jjjj) + CStr(t_BEGIN_ROWNUM_THIS_TYPE + 1)
Range(cellid).Select
Range(cellid).Font.Size = MIN_FONT_SIZE  'Int(((ROWH1 + ROWH2) * PERSONAL_FREE_INFO_ROWS - ROWH1 - 15) / Num_Of_CR(Range(cellid).Value))
DoEvents
Next jjjj
'ȥ�����������Ϣ��Ŀ�е�����
'cellid = "A" + CStr(T_begin_rownum_this_type + 1) + ":" + COLSTR(PERSONAL_FREE_INFO_COLS) + CStr(T_begin_rownum_this_type + 1)
'Range(cellid).Select
'    With Selection.Borders(xlInsideVertical)
'        .LineStyle = xlNone
'    End With
'TOTAL_CELLS = TOTAL_CELLS + (END_ROWNUM_THIS_TYPE - BEGIN_ROWNUM_THIS_TYPE + 1) * COLNUM
TOTAL_CELLS = END_ROWNUM_THIS_TYPE * COLNUM
585858
NO_CLASS_TITLE = T_NO_CLASS_TITLE  'д���������Ϣʱ�൱���������Ĺ�棬д�껹ԭ
End Sub



Sub Put_Puzzles()
'д���⣬���͵����һ��д�������ȼ�ȡ��һ������������д,������ʧ������֮�����𰸱���һ��д����ʹ���Ҫ��Ŷ�Ӧ
'Debug.Print "����" & BEGIN_ROWNUM_THIS_TYPE & "/" & END_ROWNUM_THIS_TYPE
If PUZZLE_IN_INTEREST <= 0 Then Exit Sub
If END_ROWNUM_THIS_TYPE >= FINAL_ROWNUM Then Exit Sub
On Error Resume Next
FROM_LEFT_TO_RIGHT = 1
BEGIN_ROWNUM_THIS_TYPE = 1   '��ͷ��ʼ
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
   ShowPercents_Status PROCESS_PERCENTS, "��������:" + CStr(i_puzzle + 1) + "/" + CStr(TOTAL_PUZZLE_NUM) & "-" & rs("p_title")
  
  If rs("p_col") > 1 Or rs("p_row") > 1 Then
    Write_Multi_Cells_Unit "puzzles\" & rs("p_id") & "", rs("p_id") & "|" & rs("p_title") & "", rs("p_content") & "", rs("p_col") + 0, rs("p_row") + 0, 1, False '����֤������ɹ�
    If PUT_AD_SUCCESS = True Then Total_Puzzle_Cells = Total_Puzzle_Cells + rs("p_col") * rs("p_row") * 2
  Else
    Total_Puzzle_Cells = Total_Puzzle_Cells + 2
    Write_One_Cell_Unit "puzzles\" & rs("p_id") & "", rs("p_id") & "|" & rs("p_title") & "", rs("p_content") & "", 1 'Ϊ�˱��ʽ�����Զ�ת��
  End If
  SUCCESS_t = SUCCESS_t And PUT_AD_SUCCESS
  If rs("p_answer") = "{pic}" Then
    Write_One_Cell_Unit "puzzles\" & rs("p_id") & "a", rs("p_id") & ":��" & "", rs("p_answer") & "", 1 'Ϊ�˱��ʽ�����Զ�ת��
    Total_Puzzle_Cells = Total_Puzzle_Cells + 2
  Else
    Answers_Group = Answers_Group & "[" & rs("p_id") & "]:" & rs("p_answer") & " "
    Temp_EOF = rs.EOF
    If Not Temp_EOF Then
      rs.MoveNext
      Mv_Nxt_YES = True
    End If
    If Clen(Answers_Group & "[" & rs("p_id") & "]:" & rs("p_answer")) > MAX_LEN_PER_CELL * 2 Or Temp_EOF Or i_puzzle = TOTAL_PUZZLE_NUM - 1 Then
      Write_One_Cell_Unit "puzzles\" & rs("p_id") & "a", "��", Answers_Group, 1
      Total_Puzzle_Cells = Total_Puzzle_Cells + 2
      Answers_Group = ""
    End If
    If Mv_Nxt_YES = True Then
      rs.MovePrevious
      Mv_Nxt_YES = False
    End If
  End If
  SUCCESS_t = SUCCESS_t And PUT_AD_SUCCESS
  '�������ɹ�,���ȼ���1
  If SUCCESS_t = True And TEST_i.Value = False Then conn.Execute ("update " & L_s & "puzzles" & R_s & " set p_pri=p_pri-1 where p_id=" & CStr(rs("p_id")))    '+ "'"
  If SUCCESS_t = True Then i_puzzle = i_puzzle + 1
  If SUCCESS_t = False Then MsgBox "����ʧ��: ������  ID:" & rs("p_id") & Chr(13) & Chr(10) & "����: " & rs("p_title")
  rs.MoveNext
Loop
rs.Close
Set rs = Nothing
conn.Close
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + Total_Puzzle_Cells
DoEvents
End Sub

Sub Put_Jokes()
'дЦ������������ MAX_LEN_PER_CELL ���ö����Ԫ��
On Error Resume Next
'Debug.Print "Ц��" & BEGIN_ROWNUM_THIS_TYPE & "/" & END_ROWNUM_THIS_TYPE & "/" & ROWNUM
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
     OPEN_JOKES_DB 1  '���´�ʱ��Ц������,����ֱ�Ӱ��α��Ƶ���һ����¼�ǲ�ͬ�ģ���Ϊ�ù���Ц�����ȼ�������
  End If
  DoEvents
  If used_cells_num_by_jokes >= left_null_cells_num Then
   TOTAL_CELLS_TOUCHED = TOTAL_CELLS
   Exit Sub
  End If

  ShowPercents_Status PROCESS_PERCENTS, "���Ц��:" + CStr(used_cells_num_by_jokes) + "/" + CStr(left_null_cells_num) & "(" & TOTAL_JOKE_NUM & ")-" & rs_jokes("j_title")
  clen_this_joke = Clen(rs_jokes("j_content"))
  temp_plus = 1
  If clen_this_joke / 2 > MAX_LEN_PER_CELL Then
    H_cells = Int(clen_this_joke / 2 / MAX_LEN_PER_CELL) + 1
    If H_cells > COLNUM Then H_cells = COLNUM
    Write_Multi_Cells_Unit rs_jokes("j_id") & "", rs_jokes("j_title") & "", rs_jokes("j_content") & "", H_cells, 1, 1, False '����֤������ɹ�
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
    conn_jokes.Execute ("update " & L_s & "jokes" & R_s & " set j_pri=j_pri-1 where j_id=" & CStr(rs_jokes("j_id")))  '����ɹ�,���ȼ���1
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
'дһ������Ц���ȣ�ռ��ͬ��Ԫ����
'Debug.Print Content
On Error Resume Next
Dim Contact_Info_Start As Integer
Dim content_T As String
Dim begin_row, row_move_down, LOST_TOTAL_CELLS_TOUCHED As Integer
Dim Title_H, Ratio_H_V As Single '����߶�,ԭ���ݺ����������ʹ�þ�����С����
DoEvents
LOST_TOTAL_CELLS_TOUCHED = horizontal_cells * vertical_cells   '����ÿҳ������Ӱ��ȫ���������������������Ӱ�������

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
title = Cut_CR(title)  'ȥ���س�
title = Trim(title)

Content = Merge_CRs(Content)  '�ϲ�����س�
Content = Trim(Content)
'Content = Replace(Content, Chr(10) & "^|", "^|")
Contact_Info_Start = InStr(Content, "^|")
Content = Replace(Content, "^|", Chr(10))
If Right(Content, 1) = Chr(10) Then Content = Left(Content, InStrRev(Content, Chr(10)) - 1) '�ɵ����Ļس�
If Left(Content, 1) = Chr(10) Then
  Content = Right(Content, Len(Content) - 1) '�ɵ���ǰ�Ļس�
  Contact_Info_Start = Contact_Info_Start - 1
End If
DoEvents

If Content = "{pic}" Then title = "" '���������ͼ����û�б��⣬��Ҳ�ɵ�

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
'horizontal_cells=1ʱ����ͷ��ʼ��>=2ʱ�ʹӿ��Բ�����(�ѱ��)��ʼ���������Լ��ٱ���������ӿ��ٶȣ��ر��ǲ���Ц��ʱ
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
     If title <> "" And display_mode = 1 Then '��������ⲻΪ�գ����ҵ�1��ģʽ��ʾ���򲻺ϲ������к�������
     '������
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
     '����,����
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
     Range(cellid).Font.Name = "����"
     DoEvents
     If Contact_Info_Start > 0 Then
         Range(cellid).Select
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = TOPIC_FONT_NAME1
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = "Arial Narrow"
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.FontStyle = "�Ӵ�"
     End If
     DoEvents
          Title_H = ROWH1 * RowHeight2FontSize
     If title = "" Then Title_H = 0
     font_size = Calculate_Font_Size(Content, horizontal_cells, vertical_cells, Title_H) + FONT_SIZE_ADJUST
     ActiveSheet.Range(cellid).Font.Size = font_size
     DoEvents
     '�����2����ʾģʽ
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
        .FontStyle = "����"
        .Size = CInt(font_size * 0.9)  'Ϊ�˲�����
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
     '����ͼ��
     If Content = "{pic}" Then
       Range(cellid).Select
       pic_name = MY_DOC_PATH & "\�������鱨վ���ĵ�\database\pic\" & id
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
       If id = "kxqbz_ad" Then Selection.Locked = True   '���������鱨վ�Ĺ�棬���ð�ʱ���ܱ༭��
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

'���´���ȷ������ɹ�,���Ǹ��ѹ��ʱҪ����,���������ѹ��,��ȷ���ɹ���ȷ���ɹ���ԭ���Ǳ�Ҫʱ�����У����й�ҳ֮����ʹ��
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
        If title <> "" And display_mode = 1 Then '��������ⲻΪ�գ����ҵ�1��ģʽ��ʾ���򲻺ϲ������к�������
         '������
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
         '����,����
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
         Range(cellid).Font.Name = "����"
         If Contact_Info_Start > 0 Then
           Range(cellid).Select
           ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = TOPIC_FONT_NAME1
           ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = "Arial Narrow"
           ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.FontStyle = "�Ӵ�"
         End If
         Title_H = ROWH1 * RowHeight2FontSize
         If title = "" Then Title_H = 0
         font_size = Calculate_Font_Size(Content, horizontal_cells, vertical_cells, Title_H) + FONT_SIZE_ADJUST
         ActiveSheet.Range(cellid).Font.Size = font_size
         DoEvents
         '�����2����ʾģʽ
         If title <> "" And display_mode = 2 Then
           T_clen = Int((Clen(title) + 1) / 2)
           If T_clen < 1 Then T_clen = 1
           If T_clen > 10 Then T_clen = 10
           font_size = (DISPLAY_MODE_2_FONT_SIZE(T_clen) * horizontal_cells * COLW / 14.27) + FONT_SIZE_ADJUST
           Max_F = ROWH * vertical_cells * RowHeight2FontSize / 2
           If font_size > Max_F Then font_size = Max_F

           With ActiveCell.Characters(Start:=1, Length:=Len(title)).Font
            .Name = TOPIC_FONT_NAME2
            .FontStyle = "����"
            .Size = CInt(font_size * 0.9)  'Ϊ�˲�����
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
         '����ͼ��
         If Content = "{pic}" Then
           Range(cellid).Select
           pic_name = MY_DOC_PATH & "\�������鱨վ���ĵ�\database\pic\" & id
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
           If id = "kxqbz_ad" Then Selection.Locked = True   '���������鱨վ�Ĺ�棬���ð�ʱ���ܱ༭��
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
End If  '��ȷ������ɹ� ����
'����ִ�е�����,��ζ�Ų���ʧ��,ֻ�ڲ���֤�ɹ�����ʱ�Żᷢ��,��ʱ�������,��ѵĲ��ɹ�Ҳ����ν,���Զ�������һ����ѵ�,��˲�����ʾ��
'MsgBox "����ʧ��: ��" & AD_TYPE & "��[" & NAME_THIS_TYPE & "] ռ�õ�Ԫ��: " & horizontal_cells & "x" & vertical_cells & chr(13) & chr(10) & "������: " & title
DoEvents
End Sub
Sub Write_One_Cell_Unit(id As String, title As String, Content As String, display_mode As Integer)
'��˳��дһ��������Ԫ��� ����Ц����
On Error Resume Next
Dim Contact_Info_Start As Integer
Dim Title_H As Single '����߶�
DoEvents
title = Cut_CR(title)  'ȥ���س�
title = Trim(title)
Content = Merge_CRs(Content)  '�ϲ�����س�
Content = Trim(Content)
'Content = Replace(Content, Chr(10) & "^|", "^|")
Contact_Info_Start = InStr(Content, "^|")
Content = Replace(Content, "^|", Chr(10))
If Right(Content, 1) = Chr(10) Then Content = Left(Content, InStrRev(Content, Chr(10)) - 1) '�ɵ����Ļس�
If Left(Content, 1) = Chr(10) Then
  Content = Right(Content, Len(Content) - 1) '�ɵ���ǰ�Ļس�
  Contact_Info_Start = Contact_Info_Start - 1
End If

If Content = "{pic}" Then title = "" '���������ͼ����û�б��⣬��Ҳ�ɵ�

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
     If title <> "" And display_mode = 1 Then '��������ⲻΪ�գ����ҵ�1��ģʽ��ʾ���򲻺ϲ������к�������
        '����
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
     '����
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
     Range(cellid).Font.Name = "����"
     If Contact_Info_Start > 0 Then
         Range(cellid).Select
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = TOPIC_FONT_NAME1
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.Name = "Arial Narrow"
         ActiveCell.Characters(Start:=Contact_Info_Start + 1, Length:=800).Font.FontStyle = "�Ӵ�"
     End If
     Title_H = ROWH1 * RowHeight2FontSize
     If title = "" Then Title_H = 0
     font_size = Calculate_Font_Size(Content, 1, 1, Title_H) + FONT_SIZE_ADJUST
     ActiveSheet.Range(cellid).Font.Size = font_size
     DoEvents
     '�����2����ʾģʽ
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
        .FontStyle = "����"
        .Size = font_size - 1 'Ϊ�˲�����
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
     '����ͼ��
     If Content = "{pic}" Then
       Range(cellid).Select
       ActiveSheet.Pictures.Insert(MY_DOC_PATH & "\�������鱨վ���ĵ�\database\pic\" & id & ".jpg").Select
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

Function Calculate_Font_Size(ByVal Content As String, H_cells As Integer, V_cells As Integer, ByVal Topic_Height As Single) As Single '������������ݵ��ֺ�
Dim n, L As Integer  '�س����������ݳ���
Dim H, W, FontSize As Single   '��߶ȣ����
'FontSize = (Sqr(N * N + 4 * L / W * H) - N) / (2 * N / W)
'Topic_Height �Ǳ����и߶�(���ֺ�Ϊ��λ)��ģʽ1ʱ����ROWH1 * RowHeight2FontSize, ģʽ2ʱ���ڱ������ֺ�

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
'����ÿ����(��������ѵ�)ռ���ٸ�cell(excelԭ���ĵ�Ԫ��),����TOTAL_ADS_CELLS_THIS_TYPE, ����������������� TOTAL_ADS_NUM_THIS_TYPE
'ͬʱ,�ۼ�ȫ������������� TOTAL_ADS_NUM ��,�ۼ�ȫ��cell������TOTAL_ADS_CELLS
'�������� INCOME

TP_s = " where a_type=" & CStr(a_type)
If MIX_CLASS = 1 Then TP_s = ""
conn.Open DSN_NAME
SQL_Str = "select a_col,a_row from " & L_s & "ads_publish" & R_s & TP_s
rs.Open SQL_Str, conn, 2, 2
DoEvents
TOTAL_ADS_NUM_THIS_TYPE = 0    'rs.RecordCount ����open������֧��
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
'ȡ���������ƣ�����NAME_THIS_TYPE,�۸���� PRICE_THIS_TYPE

conn.Open DSN_NAME
If MIX_CLASS = 1 Then
  NAME_THIS_TYPE = "����"
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
'ȡ����������������AD_TYPENUM

conn.Open DSN_NAME
SQL_Str = "select t_name from " & L_s & "types" & R_s & ""
rs.Open SQL_Str, conn, 2, 2
DoEvents
AD_TYPENUM = 0   'rs.RecordCount��֧��
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
'ȡ����������������TOTAL_ADS_NUM_ROUPH
'On Error Resume Next
conn.Open DSN_NAME
'If Err.Number = -2147467259 Then Resume '���ܳ����󣬿��Ժ��Դ���
SQL_Str = "select a_id from " & L_s & "ads_publish" & R_s & ""

rs.Open SQL_Str, conn, 2, 2
'-2147467259 ϵͳ��֧�ֵ�ѡ������΢��ٷ�˵�������������Ͳ�������
'�������μ� sub SET_DSN_NAME()
'��һ������ ��֧�ֵ�ISAM �������ͬ��Ӧ��ͬһ������Ҳ���Բ����

DoEvents
TOTAL_ADS_NUM_ROUPH = 0  'rs.RecordCount ��֧��
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
'���subҪ��Put_Jokesǰִ�У�ִ����Put_Jokes��Cut_Page.�����������ٶȣ�ԭ��֪����
ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To FINAL_ROWNUM / 2 + 1)
DoEvents
PROCESS_PERCENTS = PROCESS_PERCENTS + 1
For i = END_ROWNUM_THIS_TYPE + 1 To FINAL_ROWNUM Step 2
   ShowPercents_Status PROCESS_PERCENTS, "��ʽ��ʣ�����:" & i & "/" & FINAL_ROWNUM
   DoEvents
   ActiveSheet.Range("A" + CStr(i)).RowHeight = ROWH1
   ActiveSheet.Range("A" + CStr(i + 1)).RowHeight = ROWH2
Next i
TOTAL_CELLS = (TOTAL_PAGE_NUM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM) * ROWNUM_PAGE * COLNUM
DoEvents
End Sub
Sub Cut_Page()
'�п���ҳ
Dim CUT_POINT  As Long
CUT_POINT = ROWNUM_PAGE + 1
ROWNUM = FINAL_ROWNUM
Do While CUT_POINT < ROWNUM
   DoEvents
   PROCESS_PERCENTS = PROCESS_PERCENTS + (2# * ROWNUM_PAGE / ROWNUM)
   ShowPercents_Status PROCESS_PERCENTS, "��ҳ:" + CStr(Int(CUT_POINT / ROWNUM_PAGE)) + "/" + CStr(TOTAL_PAGE_NUM - PGNM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM)
   ActiveSheet.HPageBreaks.Add BEFORE:=Range("A" + CStr(CUT_POINT))
   DoEvents
   CUT_POINT = CUT_POINT + ROWNUM_PAGE
Loop
End Sub


Sub Set_Cell_Border_When_Write(cellid As String)
'�߿�
If TRANSP_LINE = 0 Then    '����߿�͸��
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
  ShowPercents_Status PROCESS_PERCENTS, "�������..."
  DoEvents
  xlapp.EnableEvents = False
  Workbooks.Open MY_DOC_PATH & "\�������鱨վ���ĵ�\������ģ��\frontcover.xls"
  xlapp.EnableEvents = True   '����excel�����������¼���Ϊ���ڴ�����xls�ļ�ʱ�����Ű��ļ�ռ��һ�����̣��������
  DoEvents
  Workbooks(WORKBOOKNAME).Activate
  DoEvents
  Workbooks("frontcover.xls").Worksheets(1).Copy BEFORE:=ActiveWorkbook.Worksheets("��ҳ")
  DoEvents
  ActiveSheet.DisplayAutomaticPageBreaks = True
  DoEvents
  cid = Find_Cellid_With_Mark("{{KXQBZ_LOGO}}")
  Range(cid).Select  '�����鱨վLOGO
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
  Range(cid).Select  '��˾LOGO
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
  Range(cid).Value = "�ܵ�" + CStr(TOTAL_ISSUE_NUM) + "��" & Chr(10) & ISSUE_DATE_CHR & Chr(10) & "����" + CStr(TOTAL_PAGE_NUM) + "��"
  cid = Find_Cellid_With_Mark("{{INDEX}}")
  Range(cid).Value = COVER_CONTENTS
  cid = Find_Cellid_With_Mark("{{INFO_OF_YOUR_COMPANY}}")
  Range(cid).Value = COMPANYINFO
  cid = Find_Cellid_With_Mark("{{HOT_LINE}}")
  Range(cid).Value = "����:" & HOTLINE
  DoEvents
  Workbooks("frontcover.xls").Close
  DoEvents
  GoTo END_SUB:
ErrHandler: ErrProc "����༭���� - Put_Front_Cover"
END_SUB:
End Sub

Function Find_Cellid_With_Mark(ByVal Mark As String) As String   '�����ִ�Сд
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
    MsgBox "�����ܸĶ���ģ�棬�Ҳ������:" & Mark
    Find_Cellid_With_Mark = ""
End Function


Sub Put_Back_Cover()
  On Error GoTo ErrHandler:
  PROCESS_PERCENTS = PROCESS_PERCENTS + 1  '98%
  If PROCESS_PERCENTS > 95 Then PROCESS_PERCENTS = 95
  ShowPercents_Status PROCESS_PERCENTS, "������..."
  DoEvents
  xlapp.EnableEvents = False
  Workbooks.Open MY_DOC_PATH & "\�������鱨վ���ĵ�\������ģ��\backcover.xls"
  xlapp.EnableEvents = True   '����excel�����������¼���Ϊ���ڴ�����xls�ļ�ʱ�����Ű��ļ�ռ��һ�����̣��������
  DoEvents
  Workbooks(WORKBOOKNAME).Activate
  DoEvents
  Workbooks("backcover.xls").Worksheets(1).Copy AFTER:=ActiveWorkbook.Worksheets("��ҳ")
  DoEvents
  Workbooks("backcover.xls").Close
  DoEvents
  GoTo END_SUB:
ErrHandler: ErrProc "��ױ༭���� - Put_Back_Cover"
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
'�Ժ��֡�1�����ݵ�Ԫ�����
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
'�ϲ�����س�����Ϊһ��
    SrcStr = Replace(SrcStr, Chr(13), "")
    Merge_CRs = SrcStr
    Do While InStr(Merge_CRs, Chr(10) & Chr(10)) <> 0
     DoEvents
     Merge_CRs = Replace(Merge_CRs, Chr(10) & Chr(10), Chr(10))
    Loop
End Function

Function Num_Of_CR(ByVal str As String) As Integer
'����һ���ַ������ж��ٸ�����
  Dim L As Integer
  Num_Of_CR = 0
  L = Len(str)
  For i = 1 To L
   DoEvents
   If Mid(str, i, 1) = Chr(10) Then Num_Of_CR = Num_Of_CR + 1
  Next i
End Function
Function CWidth(ByVal str As String) As Integer
'����һ�����ж�����лس����ַ�����ʾ����ռ���,�Զ��ٸ������ַ���
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
'�رմ���ʱ����ʽ���ڰ��˳���
  Cancel = True  '�����ʹ�� UserForm �����ر�
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
ErrHandler:       ErrProc "��ȡϵͳ��Ϣ���� - Cpu_id"
END_SUB:
End Function

Sub GET_LICENCE()
'LICENCE_STATUS �� VERSION_INFO.CAPTIONֵ��0���ð汾��1ע��汾��2ע��汾,�������ڣ���ǰһ���¾��棻
'3֤����ڣ���δ��1���£���ʾһ���������ڣ�4֤����ڣ�����1���£���ʾ��ϵ���񣬲������ð�Դ���5֤����Ч����ʾ����������
 On Error Resume Next
 Dim Licence_ID, l_id, CpuID, CpuID2, user, usert, sales, t_str, t_str2 As String
 Dim t0, t1, t2, t_num, t_num2 As Long
 Dim days, L_Str As Integer
 Dim begin_day As Date
 Dim sec1_20, sec21_30, sec31_40, sec41_50 As String '�ֱ��CPU���û������䷢���ں���Ч�� ��Ϣ
  
 '��licence.txt
 Open MY_DOC_PATH & "\�������鱨վ���ĵ�\ʹ�����֤\licence.txt" For Input As #1
 'ѭ��������**���֤��Ϣ**��
 Do
   Input #1, tempii
 Loop While tempii <> "**���֤��Ϣ**" And Not EOF(1)
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
 
 '�û����뾭����һ����
'user = "ghgfrtrtffgfgcgfdgfdh"
 user = user & sales
 L_Str = Len(user)
 For i = 1 To L_Str - 1
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
 L_Str = Len(t_str2)
 For i = 1 To L_Str - 1
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

CONTACT_INFO = CONTACT_INFO & vbCrLf & vbCrLf & "        ���ṩ��������:" & CUT_STR_INTO_n_WITH_DOT((CpuID2), 4)
'����������
If l_id = 0 Then
 VERSION_INFO.Caption = "���ð汾"
 LICENCE_STATUS = 0
 atemp = MsgBox(vbCrLf & _
 "��ʾ: ������ʹ�õ������ð棬���ܲ������ƣ����������İ����в���    " & vbCrLf & _
 "�������鱨վ����档�������ȫ��ѣ�������ϵͳ�е����沿�֣���" & vbCrLf & _
 "�����ȫ���Ű����񣬿��Ե���ʹ�á�ͬʱ�������ṩǿ��������̨" & vbCrLf & _
 "֧��ϵͳ���Լ�ȫ��λ������DMҵ���רҵ�����ڴ����ļ��ˣ�" & vbCrLf & vbCrLf & _
 "   * ͳһ�̱� ������Ӫ        * 5����ѧ����ӡ�����" & vbCrLf & _
 "   * ������� ���߷���        * 5�������ӡˢ�Ű棡" & vbCrLf & _
 "   * ������� ������ӡ        * ����ԭ������������" & vbCrLf & _
 "   * ����ƽ̨ ��Ч����        * �����鱨վ ���Ц�ſ�" & vbCrLf & _
 "   * �°빦�� �ɱ�����        * �����Ϣӡˢͬʱ����" & vbCrLf & vbCrLf & _
 "        ������֧�֣���һ���˾Ϳ��Կ�DM��湫˾��" & vbCrLf & _
 "                  ����ȫ�����غ������" & vbCrLf & _
 "              ���ɣ�������һ�𿪴�DM��ʱ����" & vbCrLf & vbCrLf & _
 CONTACT_INFO, 0 + 64, "�������鱨վ���Զ��Ű�ϵͳ")
 
 Exit Sub
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
  xlapp.Quit
  End
End If

'ִ�е�����l_idһ������Licence_ID�������ܱ������ļ����
If Date > begin_day + days + 31 Then
 VERSION_INFO.Caption = "֤�����"
 LICENCE_STATUS = 4
 atemp = MsgBox(vbCrLf & "   ����: ֤�����ع���" & vbCrLf & vbCrLf & _
 CONTACT_INFO & vbCrLf & vbCrLf & _
 "   ����֤���Ѿ����ܼ���ʹ�ã��������ð�Դ���", 0 + 48, "�������鱨վ���Զ��Ű�ϵͳ")
 Exit Sub
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




Sub Lock_My_Ad()
Dim s As String


'ѡ��sheet�����е�Ԫ�񣬽������
    Cells.Select
    Selection.Locked = False
    Selection.FormulaHidden = False
'�ڲ���ͼ��ʱ�Ѿ���һ��ͼ�ν���������������鱨վ��ͼ������������
'����������
'��ΪHCWeb ��Ҫ������ܰ����ð��Ű�������Ϊhtml,���Կ����ʹ������ģ���Ӧ�þ�������excel�����������15λ���������ܴ����ƣ�100λ�϶�û����
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
'����Lock ��������д��¼�ƺ�����һ���������ǲ���ʹ��������VBA��BUG
'ֻ��DrawingObjects:=True,  Scenarios:=True,������ס�����鱨վ��棬���û�Ҳ�����ٲ���򿽱����ͼƬ�ˣ������飬û�취���
End Sub

Sub SET_BTTNS()   '��Excel�������������ֺ�����Ŵ���С������Ϊ�Դ���û������ܣ�ֻ���ֺ���ͬ��
' �༭ k_bar.par �ļ������������
' ��;������������ť�����ͼƬ��
'addbar.xls fontsize.xla �걣�����룺kxqbzggxzk888daqing

'*********���ﲻҪʹ�ó����������ֵ�set xlapp=Application,����
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
'����ҵ��ĵ�Ŀ¼
   Dim sTmp As String * MAX_LEN  '��Ž���Ĺ̶����ȵ��ַ���
   Dim pidl As Long 'ĳ����Ŀ¼������Ŀ¼�б��е�λ��
    
   '����ҵ��ĵ�Ŀ¼
   SHGetSpecialFolderLocation 0, MYDOCUMENTS, pidl
   SHGetPathFromIDList pidl, sTmp
   MY_DOC_PATH = Left(sTmp, InStr(sTmp, Chr(0)) - 1)
   'MsgBox MY_DOC_PATH
End Sub


Sub Show_Tips()
 Dim tt As Integer    '�������
 tt = 10
 T = Timer()
 If T - TIPS_TIME > tt Then
 TIPS_TIME = T
 BEGIN_TIP_NUM = BEGIN_TIP_NUM + 1
 id = BEGIN_TIP_NUM Mod TIPS_NUM + 1
 TIP_TEXT.Caption = "* " & ReadPar(App.Path & "\tips.par", "Tip" & CStr(id), "=")
 If TIP_TEXT.Caption = "" Then TIP_TEXT.Caption = "�����鱨վ ���Ц�ſ� www.kxqbz.com"
 TIP_TEXT.ForeColor = RGB((BEGIN_TIP_NUM Mod 4) * 63, ((BEGIN_TIP_NUM + 1) Mod 4) * 63, ((BEGIN_TIP_NUM + 2) Mod 4) * 63)
 End If
End Sub


Sub Check_Page_Num()

On Error GoTo ErrHandler:

Dim PGNM As Integer
Dim P_G_N_M As Single   'Ҳ�ǰ�����ֻ�Ǵ�С������ʾ�����û�֪���ø���ϸһ��
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
ShowPercents_Status PROCESS_PERCENTS, "��" & SCANTIMES & "�ΰ���ɨ�����"


PGNM = Int(ROWNUM / ROWNUM_PAGE)   '�����ҳ��Ҫ�İ���
P_G_N_M = CInt(CSng(ROWNUM) / CSng(ROWNUM_PAGE) * 100#) / 100#
If ROWNUM Mod ROWNUM_PAGE <> 0 Then PGNM = PGNM + 1  'ֻҪ��һ��㣬�͵��ڶ�һ��
TOTAL_PAGE_NUM = Int(ROWNUM / ROWNUM_PAGE)
If ROWNUM Mod ROWNUM_PAGE <> 0 Then TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + 1  '��ҳ��Ҫ��ҳ�� 'ֻҪ��һ��㣬�͵��ڶ�һ��
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + FRONT_COVER_PAGE_NUM + BACK_COVER_PAGE_NUM  '���Ϸ��桢���
TOTAL_PAGE_NUM_t = Int(TOTAL_PAGE_NUM / COMPAGESNUM)
If TOTAL_PAGE_NUM Mod COMPAGESNUM <> 0 Then TOTAL_PAGE_NUM_t = TOTAL_PAGE_NUM_t + 1
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM_t * COMPAGESNUM
FINAL_ROWNUM = (TOTAL_PAGE_NUM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM) * ROWNUM_PAGE    '  '������ҳʱ�������桢���

FastScan.ADS_NUM.Caption = TOTAL_ADS_NUM
FastScan.PAGES_ADS_NEED.Caption = P_G_N_M
FastScan.TOTAL_PAGES_THIS_ISSUE.Caption = TOTAL_PAGE_NUM
FastScan.SPACE_PAGES.Caption = TOTAL_PAGE_NUM - PGNM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM

FastScan.Left = UserForm_Preface.Left + 3200
FastScan.Top = UserForm_Preface.Top + 400
'MsgBox ROWNUM
FastScan.Show vbModal    'vbMpdal�������ǡ�ģ̬���ڡ�����FastScan���ڹرպ����������ִ�С���ģ̬�Ͳ�������ˡ�
BeginButton.Enabled = True
OTHER_CFG.Enabled = True
LAST_PARAMETER.Enabled = True
RESTORE_PARAMETER.Enabled = True
SAVE_PARAMETER.Enabled = True
EDIT_DB_BUTTON.Enabled = True
OtherCfg.Hide
Tip_Frame.Visible = False

GoTo END_SUB:
ErrHandler: ErrProc "����ɨ����� - Check_Page_Num"
END_SUB:
End Sub

Sub Final_Check_Page_Num()
'��ʹCheck_Page_Num��δִ�й���Ҳִ�б�Subȡ��FINAL_ROWNUM�Ȳ���
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
ShowPercents_Status PROCESS_PERCENTS, "���հ���ɨ��..."

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

PGNM = Int(ROWNUM / ROWNUM_PAGE)   '�����ҳ��Ҫ�İ���
If ROWNUM Mod ROWNUM_PAGE <> 0 Then PGNM = PGNM + 1
TOTAL_PAGE_NUM = Int(ROWNUM / ROWNUM_PAGE)
If ROWNUM Mod ROWNUM_PAGE <> 0 Then TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + 1  '��ҳ��Ҫ��ҳ��
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM + FRONT_COVER_PAGE_NUM + BACK_COVER_PAGE_NUM  '���Ϸ��桢���
TOTAL_PAGE_NUM_t = Int(TOTAL_PAGE_NUM / COMPAGESNUM)
If TOTAL_PAGE_NUM Mod COMPAGESNUM <> 0 Then TOTAL_PAGE_NUM_t = TOTAL_PAGE_NUM_t + 1
TOTAL_PAGE_NUM = TOTAL_PAGE_NUM_t * COMPAGESNUM
FINAL_ROWNUM = (TOTAL_PAGE_NUM - FRONT_COVER_PAGE_NUM - BACK_COVER_PAGE_NUM) * ROWNUM_PAGE    '  '������ҳʱ�������桢���

GoTo END_SUB:
ErrHandler: ErrProc "����ɨ����� - Final_Check_Page_Num"
END_SUB:
End Sub

Sub T_Write_Multi_Cells_Unit(id As String, title As String, Content As String, horizontal_cells As Integer, vertical_cells As Integer, display_mode As Integer, must_success As Boolean)
'дһ������Ц���ȣ�ռ��ͬ��Ԫ����
'Debug.Print "Write" & BEGIN_ROWNUM_THIS_TYPE & "/" & END_ROWNUM_THIS_TYPE & "/" & ROWNUM
Dim begin_row, row_move_down, LOST_TOTAL_CELLS_TOUCHED As Integer
Dim Ratio_H_V As Single  '����߶�,ԭ���ݺ����������ʹ�þ�����С����

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

'���´���ȷ������ɹ�,���Ǹ��ѹ��ʱҪ����,���������ѹ��,��ȷ���ɹ���ȷ���ɹ���ԭ���Ǳ�Ҫʱ�����У����й�ҳ֮����ʹ��
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
End If  '��ȷ������ɹ� ����
'����ִ�е�����,��ζ�Ų���ʧ��,ֻ�ڲ���֤�ɹ�����ʱ�Żᷢ��,��ʱ�������,��ѵĲ��ɹ�Ҳ����ν,���Զ�������һ����ѵ�,��˲�����ʾ��
'MsgBox "����ʧ��: ��" & AD_TYPE & "��[" & NAME_THIS_TYPE & "] ռ�õ�Ԫ��: " & horizontal_cells & "x" & vertical_cells & chr(13) & chr(10) & "������: " & title
DoEvents
End Sub

Sub T_Write_One_Cell_Unit(id As String, title As String, Content As String, display_mode As Integer)
'��˳��дһ��������Ԫ��� ����Ц����
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
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then   '��д��1�ࣨ�ɹ���д�ĵ�1�࣬���ݿ��в�һ���ǵ�1�ࣩ�����뿪���鱨վ��棬��������ð�
  TOTAL_ADS_NUM_THIS_TYPE = TOTAL_ADS_NUM_THIS_TYPE + 1                           '������㿪���鱨վ������Ŀ
  TOTAL_ADS_NUM = TOTAL_ADS_NUM + 1
  TOTAL_ADS_CELLS_THIS_TYPE = TOTAL_ADS_CELLS_THIS_TYPE + 2 * 3 * 2  '��3��2����
  TOTAL_ADS_CELLS = TOTAL_ADS_CELLS + 2 * 3 * 2
End If
BEGIN_ROWNUM_LAST_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_LAST_TYPE = END_ROWNUM_THIS_TYPE
ROWNUM_THIS_TYPE = 2
If TOTAL_INTEREST_PERCENTS > 0 Then ROWNUM_THIS_TYPE = 2 + Int(Int(TOTAL_ADS_CELLS_THIS_TYPE * (1 + TOTAL_INTEREST_PERCENTS / 100)) / COLNUM)   'ȫ�������������ÿ�����ռ2��excel��,TOTAL_ADS_CELLS�ǳ˹�2��
If ROWNUM_THIS_TYPE Mod 2 <> 0 Then ROWNUM_THIS_TYPE = ROWNUM_THIS_TYPE + 1
ROWNUM = ROWNUM + ROWNUM_THIS_TYPE
BEGIN_ROWNUM_THIS_TYPE = END_ROWNUM_THIS_TYPE + 1     '�ϸ����������ۼӣ���һ�����ʱ��ֵ������ǰ��Ŀ�����
t_BEGIN_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE
END_ROWNUM_THIS_TYPE = BEGIN_ROWNUM_THIS_TYPE + ROWNUM_THIS_TYPE - 1
TOTAL_CELLS_TOUCHED = TOTAL_CELLS_TOUCHED + TOTAL_ADS_CELLS_THIS_TYPE
t_NAME_THIS_TYPE = NAME_THIS_TYPE
'If Len(NAME_THIS_TYPE) > 2 Then t_NAME_THIS_TYPE = Left(NAME_THIS_TYPE, 2) & "~"
ReDim Preserve ARRAY_FOR_SCAN(1 To COLNUM, 1 To ROWNUM / 2 + 1)
PROCESS_PERCENTS = PROCESS_PERCENTS + Int(80 / AD_TYPENUM)
ShowPercents_Status PROCESS_PERCENTS, "��" & CStr(SCANTIMES + 1) & "�ΰ���ɨ��:" & a_type & "-" & t_NAME_THIS_TYPE
DoEvents
'������ǩ
If Not (NO_CLASS_TITLE = 1 Or MIX_CLASS = 1) Then '�����ȥ��������ǩ����Ҫ������ǩ�Ļ������߲��ǻ���Ļ���Ϊ�˽�ʡ���棬����ȥ�����ǩ
     Dim CLASS_COLNUM, t_Page_Num As Integer   '��żҳ������ǩ�Ƿ���࣬ȱʡ����
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
'��д�൥Ԫ��Ĺ��
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " (a_row>1 or a_col>1) order by a_row desc,a_col desc,a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  T_Write_Multi_Cells_Unit "", "", CStr(a_type) & ":" & CStr(i_ads), rs("a_col") + 0, rs("a_row") + 0, 1, True  'Ϊ�˱��ʽ�����Զ�ת��,��֤���ѹ�����ɹ�
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
'��������ð�����ع��ڣ�1���£�������롶�����鱨վ�����
If WRITING_FIRST_ADS = True And (LICENCE_STATUS = 0 Or LICENCE_STATUS = 4) Then
  T_Write_Multi_Cells_Unit "", "", "", 3, 2, 2, True  '��֤����ɹ�
End If
'����д������Ԫ��Ĺ��
FROM_LEFT_TO_RIGHT = 1
conn.Open DSN_NAME
SQL_Str = "select * from " & L_s & "ads_publish" & R_s & " where" & TP_s & " a_row=1 and a_col=1 order by a_pri desc" & TP_t
rs.Open SQL_Str, conn, 2, 2
DoEvents
If Not rs.EOF Then rs.MoveFirst
Do While Not rs.EOF
  DoEvents
  i_ads = i_ads + 1
  T_Write_One_Cell_Unit "", "", CStr(a_type) & ":" & CStr(i_ads), 1   'Ϊ�˱��ʽ�����Զ�ת��
  rs.MoveNext
Loop
rs.Close
conn.Close
DoEvents
BEGIN_ROWNUM_THIS_TYPE = t_BEGIN_ROWNUM_THIS_TYPE
WRITING_FIRST_ADS = False   '����Ϊ���ǵ�һ��дһ������
End Sub
Sub T_Put_Logo_When_No_Front_Cover()   '��û�з���ʱ���ڵ�һ���LOGO������
     If FRONT_COVER_PAGE_NUM > 0 Then Exit Sub

     Dim KLOGO_COLNUM, KLOGO_ROWNUM As Integer
     Dim KLOGO_W, KLOGO_H, ImageRatio As Single
     Dim KLOGO_PATH As String
     Dim a As ImageSize
     
     mm2pic_height = 3.525 'ʵ�ʲ���ֵ,ͼ��߶ȣ����Ҳ�ɣ���mm
     'LOGO���ڵ�һ�����Ͻǣ���ô��һ��������ǩ����������Ͻǣ�������żҳ���뿿��߷ţ���һ����ұߣ����ò���ͻ
     'OUTSIDE_CLASS_TITLE = 1
     ShowPercents_Status PROCESS_PERCENTS, "����ͷ:��ʶ/��˾��Ϣ"
     KLOGO_PATH = App.Path & "\k-logo.jpg"
     a = GetImageSize(KLOGO_PATH)
     ImageRatio = a.Height / a.Width
     If PAGE_H_mm > PAGE_W_mm Then     'LOGO���ߴ�
       KLOGO_W = PAGE_W_mm / 2
     Else
       KLOGO_W = PAGE_H_mm / 2
     End If
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT
     KLOGO_COLNUM = CInt(KLOGO_W / COLW)
     KLOGO_W = KLOGO_COLNUM * COLW / mm2COLUMN_UNIT
     
     KLOGO_H = KLOGO_W * ImageRatio
     KLOGO_H = KLOGO_H * mm2POINT   '����LOGO�ߣ�excel ��λ
     KLOGO_H = KLOGO_H * 1.3  '30%��˾��Ϣ�ĸ߶�
     KLOGO_ROWNUM = CInt((KLOGO_H) / ROWH)
     KLOGO_ROWNUM = KLOGO_ROWNUM * 2
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT '����LOGO��excel ��λ ���涼û���ã���׼ȷ
     If KLOGO_COLNUM < 1 Then KLOGO_COLNUM = 1
     If KLOGO_ROWNUM < 1 Then KLOGO_ROWNUM = 2
     '���˿����鱨վLOGOҪռ�ĸ�λȷ����
     col_for_your_logo = CInt(KLOGO_COLNUM / 2.5)  '������2.5�Ϻ�
     If col_for_your_logo < 1 Then col_for_your_logo = 1
     If COLNUM < 2 Then col_for_your_logo = 0
     For i = 1 To KLOGO_COLNUM + col_for_your_logo '���һ�зŹ�˾LOGO���ںŵ�
       For ii = 1 To KLOGO_ROWNUM / 2
         ARRAY_FOR_SCAN(i, ii) = 1
       Next ii
     Next i
     DoEvents
     ROWNUM = KLOGO_ROWNUM
End Sub


Public Sub xlapp_WorkbookOpen(ByVal Wb As Workbook)   'excel���¼�����xls�ļ�����VB����
'���γ����ֹexcelʹ����ͬ���̴򿪵ڶ���xls�ļ��������Ű洮�������ļ��excelȱʡʱ��xls���ļ�����һ������
Dim fn, excelpath As String
fn = Wb.Path & "\" & Wb.Name
Wb.Close
'ShellExecute 1, "Open", fn, "", "", 1  'SW_SHOWNORMAL ����ʹ
excelpath = GetExcelPath()
'��Ҫ��Shell ��ֻ�����������ܱ�֤�ڴ�xls�ļ�������Ű��Ŵ�
Shell excelpath & " /e """ & fn & """", vbNormalNoFocus
End Sub

Public Sub Obj_Active_Workbook_Deactivate()    '�á����塱��Զ������������������ļ���ȥ
  Obj_Active_Workbook.Activate
End Sub

Sub Put_Logo_When_No_Front_Cover()   '��û�з���ʱ���ڵ�һ���LOGO������
     On Error GoTo ErrHandler:
     If FRONT_COVER_PAGE_NUM > 0 Then Exit Sub

     Dim KLOGO_COLNUM, KLOGO_ROWNUM As Integer
     Dim KLOGO_W, KLOGO_H, ImageRatio, font_size As Single
     Dim KLOGO_PATH As String
     Dim a As ImageSize
     
     mm2pic_height = 3.525 'ʵ�ʲ���ֵ,ͼ��߶ȣ����Ҳ�ɣ���mm
     'LOGO���ڵ�һ�����Ͻǣ���ô��һ��������ǩ����������Ͻǣ�������żҳ���뿿��߷ţ���һ����ұߣ����ò���ͻ
     'OUTSIDE_CLASS_TITLE = 1
     ShowPercents_Status PROCESS_PERCENTS, "����ͷ:��ʶ/��˾��Ϣ"
     KLOGO_PATH = App.Path & "\k-logo.jpg"
     a = GetImageSize(KLOGO_PATH)
     ImageRatio = a.Height / a.Width
     If PAGE_H_mm > PAGE_W_mm Then     'LOGO���ߴ�
       KLOGO_W = PAGE_W_mm / 2
     Else
       KLOGO_W = PAGE_H_mm / 2
     End If
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT
     KLOGO_COLNUM = CInt(KLOGO_W / COLW)
     KLOGO_W = KLOGO_COLNUM * COLW / mm2COLUMN_UNIT
     
     KLOGO_H = KLOGO_W * ImageRatio
     KLOGO_H = KLOGO_H * mm2POINT   '����LOGO�ߣ�excel ��λ
     KLOGO_H = KLOGO_H * 1.3  '30%��˾��Ϣ�ĸ߶�
     KLOGO_ROWNUM = CInt((KLOGO_H) / ROWH)
     KLOGO_ROWNUM = KLOGO_ROWNUM * 2
     KLOGO_W = KLOGO_W * mm2COLUMN_UNIT '����LOGO��excel ��λ ���涼û���ã���׼ȷ
     If KLOGO_COLNUM < 1 Then KLOGO_COLNUM = 1
     If KLOGO_ROWNUM < 1 Then KLOGO_ROWNUM = 2
     '���˿����鱨վLOGOҪռ�ĸ�λȷ����
     col_for_your_logo = CInt(KLOGO_COLNUM / 2.5)  '������2.5�Ϻ�
     If col_for_your_logo < 1 Then col_for_your_logo = 1
     If COLNUM < 2 Then col_for_your_logo = 0
     For i = 1 To KLOGO_COLNUM + col_for_your_logo '���һ�зŹ�˾LOGO���ںŵ�
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
    Range(cid).Select  '�����鱨վLOGO
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
  Range(cid).Select  '��д���� ����������ʾ������ʣ�µĵط���ʾ������˾LOGO���������3/5
  Range(cid).Merge
  cid = COLSTR(KLOGO_COLNUM + 1) + "1"
  i_date = ISSUE_DATE_CHR
  i_date = Replace(i_date, " ", Chr(10))
  CC = ISSUE_NUM & Chr(10) & "�ܵ�" + CStr(TOTAL_ISSUE_NUM) + "��" & Chr(10) & i_date & Chr(10) & "����:" & HOTLINE
  i_num_fontsize = COLW * col_for_your_logo * ColWidth2FontSize / Len(ISSUE_NUM) '�ںŵ��ֺ�
  If i_num_fontsize < 2 Then i_num_fontsize = 2
  If i_num_fontsize > ROWH * KLOGO_ROWNUM / 2 * 3 / 5 / 2 * RowHeight2FontSize Then i_num_fontsize = ROWH * KLOGO_ROWNUM / 2 * 3 / 5 / 2 * RowHeight2FontSize
  font_size_t = COLW * col_for_your_logo * ColWidth2FontSize / (CWidth(CC) / 2)
  num_of_cr_content = Num_Of_CR(CC) - 1 + 1 '�ںź���Ļس����㣬�����Ȼس�����1
  font_size = ((ROWH * KLOGO_ROWNUM / 2 * 3 / 5 * RowHeight2FontSize - i_num_fontsize) / (num_of_cr_content)) '���ڡ��绰�ȵ��ֺ�
  If font_size < 2 Then font_size = 2
  Range(cid).Value = CC
  Range(cid).HorizontalAlignment = xlCenter
  Range(cid).VerticalAlignment = xlBottom
  Range(cid).Font.Size = font_size
  Range(cid).Font.Name = "Arial Black"
  Range(cid).Characters(Start:=1, Length:=InStr(CC, Chr(10))).Font.Size = i_num_fontsize
  DoEvents
  a = GetImageSize(YOURLOGOPATH) '������˾LOGO
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
ErrHandler: ErrProc "��ʶ���ô��� - Put_Logo_When_No_Front_Cover"
END_SUB:
End Sub


Sub ErrProc(ByVal info As String)
 atemp = MsgBox(vbCrLf & "   ��ʾ: ϵͳ�������ش���,���ܼ�������" & vbCrLf & _
                         "   ����˵��: " & info & vbCrLf & _
                         "   ����: " & vbCrLf & _
                         "     * ���������ϵͳ Windows 2000/XP �����ϰ汾               " & vbCrLf & _
                         "     * Microsoft Office 2003 �����ϰ汾" & vbCrLf & _
                         "     * ��ȷ��װ��֧���趨������Ĵ�ӡ��" & vbCrLf & _
                         "         ���鰲װ�����ӡ��,�� SmartPrinter" & vbCrLf & _
                         "     * ϵͳ��������" & vbCrLf & _
                         "     * ������������" & vbCrLf & vbCrLf & _
                         "   ����������޷����,������ʱ�Ⱥ����Ĵ�ѯ" & vbCrLf & _
                         CONTACT_INFO, 0 + 48, "�������鱨վ���Զ��Ű�ϵͳ")
 
 StopButton_Click
 If EXCEL_STARTED = True Then xlapp.Quit
 End
End Sub




Sub SET_DSN_NAME(ByVal DBFNM As String)
    DSN_NAME = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _
         MY_DOC_PATH & "\�������鱨վ���ĵ�\database\" & DBFNM & ".mdb;User ID=admin;Password=;Jet OLEDB:Database Password=1"
    L_s = ""
    R_s = ""
'����Ĵ�����Ҫִ�У�����ΪExcel ODBC��bug,������������������㿪ʼ���ͳ��� -2147467259 ��֧������Ĵ���
'΢��ٷ�˵���˴�����Ժ󲻳��֣����Ա���ǰע�ӵ�
                        'conn.Open DSN_NAME
                        'SQL_Str = "select t_id from types"
                        'rs.Open SQL_Str, conn, 2, 2
                        'rs.Close
                        'conn.Close
'�����Excel select�������ַ���255���жϣ�����MS��BUG,�ο� ��http://support.microsoft.com/kb/189897/EN-US/ and  http://support.microsoft.com/kb/318161/en-us
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
        'DSN_NAME = "Driver={Microsoft Excel Driver (*.xls)};DBQ=" & MY_DOC_PATH & "\�������鱨վ���ĵ�\database\adsdb.xls;ReadOnly=False;"  '���������
        DSN_NAME = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & MY_DOC_PATH & "\�������鱨վ���ĵ�\database\" & DBFNM & ".xls" & ";Extended Properties=Excel 8.0"
        L_s = "["
        R_s = "$]"
    End If
End Sub










