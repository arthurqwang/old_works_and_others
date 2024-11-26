VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} OtherCfg 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "��������"
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
    sFilter = "ͼ���ļ� (*.jpg, *.gif, *.bmp)" & Chr(0) & "*.jpg;*.gif;*.bmp" & Chr(0)
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
    OpenFile.lpstrTitle = "�������鱨վ��- ��ѡ��˾�����־ͼ���ļ�"
    DoEvents
    OpenFile.flags = &H4 'OFN_HIDEREADONLY ȥ����ֻ����ʽ�򿪡�
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
   MsgBox "Ȥζ�Բ���ϸ�ֱ���������д����  ", 48, "�������鱨վ���Զ��Ű�ϵͳ"
   Exit Sub
End If
Dim ctemp As String

'д���������ļ� other-cfg.par��runtime.par
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
    Print #11, "PIC_LEFT=1"   '1  �����ԣ���4��ֵ�Ǻ��ʵģ���Ȼ��Ļ��ʾ���������⣬����ӡ�Ǻ��ʵ�
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
    Print #11, "��ʾ�����趨������{{END}}�������ע�ͣ�{{END}}����ʡ�ԣ�������Ϊ�˼����ٶ�"
    Print #11, "***************************************************************************"
    Print #11, "��������˵��"
    Print #11, "JOKE_IN_INTEREST:50    'Ȥζ�Բ��ϱ������ܼ�100%"
    Print #11, "PUZZLE_IN_INTEREST:50"
    Print #11, "ELSE_IN_INTEREST:0"
    Print #11, "mm2POINT:2.754       'ÿ���׵���28.35��(�иߵ�λ),�����飬��ֵΪ27.51~27.57,ȡ27.54"
    Print #11, "mm2ROW_UNIT=20.500731 'ÿ���׵����е�λ����ʵ��ȡ��"
    Print #11, "mm2COLUMN_UNIT:0.4461538       'ÿ���׵���3.25 �п�λ"
    Print #11, "COLUMN_UNIT2PIXEL:6.04 'ÿ���п�λ����6.04��ͼ������"
    Print #11, "WEB_TITLE_MAX_FONT_SIZE:22 '����WEB�������ֺ�:WEB_TITLE_MAX_FONT_SIZE - ���ⳤ�� / ������ռ�������"
    Print #11, "MAX_LEN_PER_CELL:60 'дЦ��ʱ��ÿ��Ԫ������ַ������Ժ��ּ��㡣������ݲ��ܴ��ޡ�"
    Print #11, "MODE_2_LEN:30 ' ����Ϊ׼����ƽ��������Ԫ�������������ֵʱ���Ƚ��ʺ���ʾ��ʽ2���ͻ����Բ�ָ����ʾģʽ����ʱ�������ݶ��پ�����ʾ��ʽ"
    Print #11, "PIC_LEFT:2   '����ͼƬʱ��Ϊ����ͼƬ��������Ҫ��һ��"
    Print #11, "PIC_TOP:2"
    Print #11, "PIC_RIGHT:4   '�ǿ�ȼ�ȥ�ĵ�����Ӧ�õ���PIC_LEFT��2��"
    Print #11, "PIC_BOTTOM:4"
    Print #11, "CELL_BORDER_TYPE:1   '����߿���ʽ��0Ϊ���ߣ�����Ϊ˫��"
    Print #11, "ISSUE_DAY_AFTER:1    'ӡˢ�Ӻ������������Զ���д��������"
    Print #11, "TOPIC_WHITE_BLACK:1 '����ӡˢʱ������⣨�б��ⵥԪ��ģʽ����Ϊ��ӡˢ���������1ʱ��ʾ�ڰף�����Ϊ��ɫ"
    Print #11, "TOPIC_FONT_NAME1:����    '���������������1ģʽ"
    Print #11, "TOPIC_FONT_NAME2:�������� '2ģʽ"
    Print #11, "CLASS_FONT_NAME:��������  '����������ʹ�õ����壬���USE_CLASS_PIC��Ϊ��0�������־ͱ���ס��"
    Print #11, "USE_CLASS_PIC:1  '��������Ƿ�ʹ��ͼ������0���ã�������ʾ��"
    Print #11, "TRANSP_LINE:0  '����߿��Ƿ�͸����͸��������û�У�����1͸�� ������͸��"
    Print #11, "MIX_CLASS:0   '�Ű��Ƿ���࣬�������࣬������һ���ţ�������С�ı�ֽ������1�죬��������"
    Print #11, "BOUND_MIX_CLASS:0  '�����������Խ����ţ�������С�ı�ֽ������1�죬��������"
    Print #11, "KEEP_WHOLE_SIZE:1  '�������ݺ����ʱ������������治�䣬0��ʾ���ǣ�������ʾ��"
    Print #11, "BACK_RUN:1   '�Ű�Excel��̨���У�1��ʾ��̨������ǰ̨"
    Print #11, "NO_CLASS_TITLE:0   '�Ƿ�ȥ��������ǩ��0��ʾ��ӡ(��ȥ��)��������ʾӡ"
    Print #11, "OUTSIDE_CLASS_TITLE:1  '������ǩ����ҳ����࣬������ҳ���Ҳ࣬ŷ��ҳ����࣬0��ʾ���֣�������ʾ����"
    Print #11, "TIPS_YES:1   '���������ͣ��ʾ������0���ã�������ʾ��"
    Close #11
 OtherCfg.Hide
 '�������ڿ��ܸı��ˣ�����Ҫˢ��
 fn_temp = App.Path & "\runtime.par"
 ISSUE_DAY_AFTER = CInt(DELAY_DAYS.Value)
 ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) 'ӡˢ����������runtime.par�ļ��У���Ϊ mm2ROW_UNIT,Ҫ����mm2POINT�������ô�С�������
 If ISSUE_DAY_AFTER > ISSUE_NUM_CHANGE_CONTROL_days Then ISSUE_DAY_AFTER = ISSUE_NUM_CHANGE_CONTROL_days
 Dim issue_date As Date
 issue_date = Date + ISSUE_DAY_AFTER
 Dim WK As Variant
 WK = Array("", "��", "һ", "��", "��", "��", "��", "��") '���ִ�Ϊ����Ӧ Weekday����
 UserForm_Preface.ISSUE_DATE_i.Value = CStr(Year(issue_date)) + "��" + CStr(Month(issue_date)) + "��" + CStr(Day(issue_date)) + "��" + " ����" + CStr(WK(Weekday(issue_date)))
 
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
    fn_temp2 = App.Path & "\helptips.par"  '���ٰ�����ʾ�ļ�
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


Sub STRINGSORT(ByRef a() As String, Optional sort As String = "UP") '�ַ�������
 Dim min As Long, max As Long, num As Long, first As Long, last As Long, temp As Long, all As New Collection, steps As Long
 min = LBound(a)
 max = UBound(a)
 all.Add a(min)
 steps = 1
 For num = min + 1 To max
 
 first = 1
 last = all.Count
 If a(num) < all(1) Then all.Add a(num), BEFORE:=1: GoTo nextnum '�ӵ���һ��
 If a(num) > all(last) Then all.Add a(num), AFTER:=last: GoTo nextnum '�ӵ����һ��
 
 
 Do While last > first + 1 '����DOѭ������ѭ������
 temp = (last + first) \ 2
 If a(num) > all(temp) Then
 first = temp
 Else
 last = temp
 steps = steps + 1
 End If
 Loop
 all.Add a(num), BEFORE:=last '�ӵ�ָ��������
 
nextnum:
 steps = steps + 1
 Next
 For num = min To max
 If sort = "UP" Or sort = "up" Then a(num) = all(num - min + 1): steps = steps + 1 '����
 If sort = "DOWN" Or sort = "down" Then a(num) = all(max - num + 1): steps = steps + 1 '����
 Next
 'MsgBox "�����鹲���� " & steps & "��ʵ��" & IIf(sort = "UP" Or sort = "up", "����", "����") & "����", 64, "INFORMATION"
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
 ISSUE_NUM_CHANGE_CONTROL_days = CInt(CSng(ReadPar(fn_temp, "mm2ROW_UNIT", "=")) * 1.502114) 'ӡˢ����������runtime.par�ļ��У���Ϊ mm2ROW_UNIT,Ҫ����mm2POINT�������ô�С�������
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


For i = 0 To Screen.FontCount - 1 'ϵͳ���õ���ʾ������
 y(i) = Screen.Fonts(i)
Next i
STRINGSORT y, "DOWN" ' "UP"
For i = 0 To 1000 'ϵͳ���õ���ʾ������
If y(i) <> "" Then
  ComboBox1.AddItem y(i) '���빤�����ϵ��������б����
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
FREE_AND_FUNS.ControlTipText = ReadPar(fn, "FREE_AND_FUNS", ":") '����4�ÿ���ռ���٣��������ܳ���100%
JOKE.ControlTipText = ReadPar(fn, "JOKE", ":") '���������̫�����ã���Ϊ��ʹ����Ϊ0����Ҳ����Ц�����հװ���ѽ
PUZZLE.ControlTipText = ReadPar(fn, "PUZZLE", ":") '��������⣬���������ֵģ�Ҳ����ͼ�ε�
ELSEM.ControlTipText = ReadPar(fn, "ELSEM", ":") ' ��ʱû��
BUSINESS.ControlTipText = ReadPar(fn, "BUSINESS", ":") ' �ϴ����������ϵ��Ϣ
CompanyInfo_i.ControlTipText = ReadPar(fn, "CompanyInfo_i", ":") '
HotLine_i.ControlTipText = ReadPar(fn, "HotLine_i", ":") ' ��ӡ�ڰ�����˵�ҳü��
CellPhone_i.ControlTipText = ReadPar(fn, "CellPhone_i", ":") ' ��ӡ�ڰ����������ҳ����
BankCard_i.ControlTipText = ReadPar(fn, "BankCard_i", ":") '�˺Ż�ӡ�ڰ����������ҳ���ǧ������ˣ��������˺Ų���Ŷ���ٺ�
YourLogoPath_i.ControlTipText = ReadPar(fn, "YourLogoPath_i", ":") '
FONT_SETTING.ControlTipText = ReadPar(fn, "FONT_SETTING", ":") '�������壬���û�еĻ�������ϵͳȱʡ�ģ�һ��������
ComboBox1.ControlTipText = ReadPar(fn, "ComboBox1", ":") '���硰��Ƹ���࣬�����ѡ������ġ�������ʹ��ͼƬ������ͱ���ס��
ComboBox2.ControlTipText = ReadPar(fn, "ComboBox2", ":") '�����������֣�����ӡ�ڱ�����ڲ����Ƚ�С�����岻Ҫ̫��ϸ
ComboBox3.ControlTipText = ReadPar(fn, "ComboBox3", ":") '�����������֣����ֺ�����ӡ��һ�𣬱���ᱻ�Ŵ󣬱Ƚ���Ŀ
DELAY_DAYS.ControlTipText = ReadPar(fn, "DELAY_DAYS", ":") '���������ӡ���˰ɣ������Ҫ�ȼ�����������������Զ�����ǰ��ĳ�������
WHITE_BLACK.ControlTipText = ReadPar(fn, "WHITE_BLACK", ":") '��ҳ���ӡ�ڰ׵ģ���ѡ������ӡ��������������ϻ��ǲ�ɫ�ģ����������������
DOUBLELINE.ControlTipText = ReadPar(fn, "DOUBLELINE", ":") 'ϲ���߿���˫�߾�ѡ�ϣ���Ů�����ǲ���ϲ�����ߵģ��������е���ƤҮ
USE_PIC.ControlTipText = ReadPar(fn, "USE_PIC", ":") '�����Լ�ģ������ͼƬ��Ȼ��ŵ�binĿ¼�¾�OK��ͼƬ�ļ�������class_8.jpg��
TRANSPLINE.ControlTipText = ReadPar(fn, "TRANSPLINE", ":") ': ����Ҫ����߿�Ļ���ѡ�ϣ�͸��������û��
MIXCLASS.ControlTipText = ReadPar(fn, "MIXCLASS", ":") ':�������࣬������һ���ţ�������С�ı�ֽ
BOUNDMIXCLASS.ControlTipText = ReadPar(fn, "BOUNDMIXCLASS", ":")
KEEPWHOLESIZE.ControlTipText = ReadPar(fn, "KEEPWHOLESIZE", ":")
BACKRUN.ControlTipText = ReadPar(fn, "BACKRUN", ":") '
NOCLASSTITLE.ControlTipText = ReadPar(fn, "NOCLASSTITLE", ":") ':ȥ��������ǩ��ʡ����棬û̫�����塣�����Ҫ��ô�ɣ�˭Ҳ�ܲ��ţ�
OUTSIDECLASSTITLE.ControlTipText = ReadPar(fn, "OUTSIDECLASSTITLE", ":")
TIPS_Y.ControlTipText = ReadPar(fn, "TIPS_Y", ":") '�����Щ������ͣ��ʾ�����ϴ������Ʒ���Ǿ͹�������������
SAVE_OTHER.ControlTipText = ReadPar(fn, "SAVE_OTHER", ":") '���˴˼�����Ч�����������������Ǻǣ�û���ϴ��ٸĻ�����
Cancel.ControlTipText = ReadPar(fn, "Cancel", ":") '�װ��ˣ���ѽ���������ף����ǡ���������˼
OtherCfg.Repaint
End Sub


Sub HIDE_TIPS()
FREE_AND_FUNS.ControlTipText = ""    ' ReadPar(fn, "FREE_AND_FUNS", ":") '����4�ÿ���ռ���٣��������ܳ���100%
JOKE.ControlTipText = ""    ' ReadPar(fn, "JOKE", ":") '���������̫�����ã���Ϊ��ʹ����Ϊ0����Ҳ����Ц�����հװ���ѽ
PUZZLE.ControlTipText = ""    ' ReadPar(fn, "PUZZLE", ":") '��������⣬���������ֵģ�Ҳ����ͼ�ε�
ELSEM.ControlTipText = ""    ' ReadPar(fn, "ELSEM", ":") ' ��ʱû��
BUSINESS.ControlTipText = ""    ' ReadPar(fn, "BUSINESS", ":") ' �ϴ����������ϵ��Ϣ
CompanyInfo_i.ControlTipText = ""
HotLine_i.ControlTipText = ""    ' ReadPar(fn, "HotLine_i", ":") ' ��ӡ�ڰ�����˵�ҳü��
CellPhone_i.ControlTipText = ""    ' ReadPar(fn, "CellPhone_i", ":") ' ��ӡ�ڰ����������ҳ����
BankCard_i.ControlTipText = ""    ' ReadPar(fn, "BankCard_i", ":") '�˺Ż�ӡ�ڰ����������ҳ���ǧ������ˣ��������˺Ų���Ŷ���ٺ�
YourLogoPath_i.ControlTipText = ""    '
FONT_SETTING.ControlTipText = ""    ' ReadPar(fn, "FONT_SETTING", ":") '�������壬���û�еĻ�������ϵͳȱʡ�ģ�һ��������
ComboBox1.ControlTipText = ""    ' ReadPar(fn, "ComboBox1", ":") '���硰��Ƹ���࣬�����ѡ������ġ�������ʹ��ͼƬ������ͱ���ס��
ComboBox2.ControlTipText = ""    ' ReadPar(fn, "ComboBox2", ":") '�����������֣�����ӡ�ڱ�����ڲ����Ƚ�С�����岻Ҫ̫��ϸ
ComboBox3.ControlTipText = ""    ' ReadPar(fn, "ComboBox3", ":") '�����������֣����ֺ�����ӡ��һ�𣬱���ᱻ�Ŵ󣬱Ƚ���Ŀ
DELAY_DAYS.ControlTipText = ""    ' ReadPar(fn, "DELAY_DAYS", ":") '���������ӡ���˰ɣ������Ҫ�ȼ�����������������Զ�����ǰ��ĳ�������
WHITE_BLACK.ControlTipText = ""    ' ReadPar(fn, "WHITE_BLACK", ":") '��ҳ���ӡ�ڰ׵ģ���ѡ������ӡ��������������ϻ��ǲ�ɫ�ģ����������������
DOUBLELINE.ControlTipText = ""    ' ReadPar(fn, "DOUBLELINE", ":") 'ϲ���߿���˫�߾�ѡ�ϣ���Ů�����ǲ���ϲ�����ߵģ��������е���ƤҮ
USE_PIC.ControlTipText = ""    ' ReadPar(fn, "USE_PIC", ":") '�����Լ�ģ������ͼƬ��Ȼ��ŵ�binĿ¼�¾�OK��ͼƬ�ļ�������class_8.jpg��
TRANSPLINE.ControlTipText = ""    ': ����Ҫ����߿�Ļ���ѡ�ϣ�͸��������û��
MIXCLASS.ControlTipText = ""    ':�������࣬������һ���ţ�������С�ı�ֽ
BOUNDMIXCLASS.ControlTipText = ""
KEEPWHOLESIZE.ControlTipText = ""
BACKRUN.ControlTipText = ""    '
NOCLASSTITLE.ControlTipText = ""    ':ȥ��������ǩ��ʡ����棬û̫�����塣�����Ҫ��ô�ɣ�˭Ҳ�ܲ��ţ�
OUTSIDECLASSTITLE.ControlTipText = ""
TIPS_Y.ControlTipText = ""    ' ReadPar(fn, "TIPS_Y", ":") '�����Щ������ͣ��ʾ�����ϴ������Ʒ���Ǿ͹�������������
SAVE_OTHER.ControlTipText = ""    ' ReadPar(fn, "SAVE_OTHER", ":") '���˴˼�����Ч�����������������Ǻǣ�û���ϴ��ٸĻ�����
Cancel.ControlTipText = ""    ' ReadPar(fn, "Cancel", ":") '�װ��ˣ���ѽ���������ף����ǡ���������˼
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















