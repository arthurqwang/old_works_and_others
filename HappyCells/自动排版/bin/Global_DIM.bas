Attribute VB_Name = "Global_DIM"

Public Const RowHeight2FontSize = 0.75   '行高度转成字号
Public Const ColWidth2FontSize = 6.1   '列宽度转成字号
Public MY_DOC_PATH As String
Public TOPIC_FONT_NAME1, TOPIC_FONT_NAME2, CLASS_FONT_NAME As String '两种标题的字体名字
Public TOPIC_WHITE_BLACK, USE_CLASS_PIC, TIPS_YES As Integer  '用于印刷时广告格标题（有标题单元格模式），为了印刷清楚，等于1时表示黑白，其它为彩色
Public ISSUE_NUM_CHANGE_CONTROL_days As Integer  '印刷延误天数，runtime.par文件中，列为 mm2ROW_UNIT,要混在mm2POINT附近，用带小数点的数,隐藏为了严重过期用户不能设置出版日期
Public JOKE_IN_INTEREST As Single
Public PUZZLE_IN_INTEREST As Single
Public ELSE_IN_INTEREST As Single

Public mm2POINT As Single        '每厘米等于28.35磅(行高单位),经试验，此值为27.51~27.57,取27.54
Public mm2COLUMN_UNIT As Single      '0.4461538       '每厘米等于3.25 列宽单位
Public COLUMN_UNIT2PIXEL As Single   '6.04 '每个列宽单位等于6.04个图像像素

Public WEB_TITLE_MAX_FONT_SIZE As Integer     '22 '用于WEB，标题字号as singleWEB_TITLE_MAX_FONT_SIZE - 标题长度 / 标题所占横向格数
Public MAX_LEN_PER_CELL As Integer     '60 '写笑话时，每单元格最多字符数，以汉字计算。广告内容不受此限。
Public MODE_2_LEN As Integer    ' 30 ' 汉字为准。当平均单个单元格内容少于这个值时，比较适合显示方式2。客户可以不指定显示模式，此时根据内容多少决定显示方式
'public ITEMS_NUM_PER_ROW as single 4  '每行标准广告单元格写几行个人免费广告
Public PIC_LEFT As Integer    ' 2   '插入图片时，为了让图片不出格，需要缩一点
Public PIC_TOP As Integer    ' 2
Public PIC_RIGHT As Integer    ' 4  '是宽度减去的点数，应该等于PIC_LEFT的2倍
Public PIC_BOTTOM As Integer    ' 4

Public conn  As New ADODB.Connection
Public conn_jokes As New ADODB.Connection
'public cmd As New ADODB.Command
Public rs  As New ADODB.Recordset
Public rs_jokes As New ADODB.Recordset
Public DSN_NAME, SQL_Str, L_s, R_s As String '因为.mdb文件路径是变的，所以改成字符串变量。格式应该与前面的相同，DSN_NAME的值在Userform初始化时给出
Public IS_EXCEL As Boolean '数据库的类型 Access Or Excel

Public cellid As String    '单元格标号
Public save_filename As String
Public ROWNUM, COLNUM, ROWNUM_PAGE As Integer
Public ROWNUM_THIS_TYPE, BEGIN_ROWNUM_THIS_TYPE, END_ROWNUM_THIS_TYPE, BEGIN_ROWNUM_LAST_TYPE, END_ROWNUM_LAST_TYPE, FINAL_ROWNUM As Integer
Public TOTAL_ADS_CELLS, TOTAL_ADS_NUM, TOTAL_ADS_NUM_ROUPH, TOTAL_ADS_CELLS_THIS_TYPE, TOTAL_ADS_NUM_THIS_TYPE As Long
Public TOTAL_CELLS, TOTAL_CELLS_TOUCHED As Long
Public BEGIN_ROWNUM_FOR_CELL_WIDTH_MORE_THAN_1, INSERTING_COLNUM, INSERTING_ROWNUM As Integer '从那以行开始可以容纳横向大于2格的广告或笑话，为了加快遍历速度
Public NAME_THIS_TYPE As String
Public PRICE_THIS_TYPE As Single
Public ROWH, ROWH1, ROWH2, COLW, PAGE_H_mm, PAGE_W_mm, TOPM, BOTTOMM, HEADH, FOOTH, BORDERM, LEFTW, RIGHTW As Single
Public MAX_FONT_SIZE, MIN_FONT_SIZE, FONT_SIZE_ADJUST, PERSONAL_FREE_INFO_ROWS, PERSONAL_FREE_INFO_COLS As Integer
Public ISSUE_NUM, TOTAL_ISSUE_NUM As Integer '刊物期号
Public TOTAL_PAGE_NUM, FORCED_PAGE_NUM As Integer '总版数
Public TOTAL_JOKE_NUM, TOTAL_FREE_NUM As Integer   '总笑话数,免费个人信息数
Public TOTAL_PUZZLE_NUM As Integer '总谜语数，每个占2格，这里是指谜语个数，不包括谜底数量
Public TOTAL_ELSE_NUM As Integer    '其它材料（小常识）总数
Public issue_date, START_T, END_T As Date
Public ISSUE_DAY_AFTER As Integer   '几天后出版,用于计算出版日期
Public ISSUE_DATE_CHR As String       'ISSUE_DATE 的字符形式
Public AD_TYPE, AD_TYPENUM, NO_AD_TYPENUM As Integer
Public FRONT_COVER_PAGE_NUM, BACK_COVER_PAGE_NUM As Integer
Public INCOME As Single
Public TOTAL_INTEREST_PERCENTS, JOKE_PERCENTS, PUZZLE_PERCENTS, ELSE_PERCENTS  As Single
Public PUT_AD_SUCCESS As Boolean
Public WORKBOOKNAME, COVER_CONTENTS As String '写封面、目录用
Public PROCESS_PERCENTS As Single
Public Dark_Colors(1 To 8, 1 To 3), Bright_Colors(1 To 8, 1 To 3) As Integer
Public DISPLAY_MODE_2_FONT_SIZE(1 To 10) As Integer
Public PIC_NUM As Integer
Public COMPANYINFO, HOTLINE, CELLPHONE, BANKCARD, YOURLOGOPATH As String
'public PRICE_JOB As Integer
Public APP_BEGUN As Boolean
Public ITEMS_NUM_PER_ROW   '每行标准广告单元格写几行个人免费广告
Public LICENCE_STATUS As Integer
Public CELL_BORDER_TYPE As Integer '广告单元格边框，0为单线，其他为双线
Public TRANSP_LINE, MIX_CLASS, BOUND_MIX_CLASS, KEEP_WHOLE_SIZE, BACK_RUN, NO_CLASS_TITLE, OUTSIDE_CLASS_TITLE As Integer
'边框透明，1Y/其它N；混类编排，1Y/其它N；后台排版，1Y/其它N；去掉类标签，0N/其它Y；类标签靠版面外侧，0N/其它Y；使用页眉，0N/其它Y；使用页脚，0N/其它Y
Public TIPS_NUM, BEGIN_TIP_NUM As Integer '提示贴的个数，存在tips.par
Public TIPS_TIME As Long
Public FROM_LEFT_TO_RIGHT As Integer   '插入格时，从左向右扫描，1:左-右，其他右-左
Public CONTACT_INFO As Variant
Public ARRAY_FOR_SCAN() As Byte
Public SCANTIMES, OLD_COLNUM, OLD_ROWNUM_PAGE As Integer
Public Cell_Border_Line_Style, Cell_Border_Line_Width As Integer
Public COMPAGESNUM As Integer    '每张纸双面印几版，每期刊物的总版数是该数目的整数倍，否则浪费纸张材料
Public Final_Checked As Boolean  '按开始键之前的最终检查，主要是确定总版数
Public WRITING_FIRST_ADS As Boolean '第一次写一类广告，因为可能前几类没广告可写，比如本期无招聘类广告，为了设置首页标签位置和开心情报站的广告
Public EXCEL_STARTED As Boolean

'***************************************************************************************************************************
'获得我的文档目录、excel.exe路径等
Public Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias _
            "RegOpenKeyExA" (ByVal hKey As Long, _
            ByVal lpSubKey As String, ByVal ulOptions As Long, _
            ByVal samDesired As Long, phkResult As Long) _
            As Long
Public Declare Function RegQueryValueEx Lib "advapi32.dll" _
            Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal _
            lpValueName As String, ByVal lpReserved As Long, _
            lpType As Long, ByVal lpData As String, lpcbData As Long) _
            As Long
                                                                                                                                                                                                                                                               
Public Declare Function RegCloseKey Lib "advapi32.dll" _
            (ByVal hKey As Long) As Long
Public Const REG_SZ             As Long = 1
Public Const KEY_ALL_ACCESS = &H3F
Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Declare Function SHGetSpecialFolderLocation Lib "Shell32" (ByVal hwndOwner As Long, ByVal nFolder As Integer, ppidl As Long) As Long
Public Declare Function SHGetPathFromIDList Lib "Shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal szPath As String) As Long
Public Const MAX_LEN = 200 '我的文档路径字符串最大长度
Public Const MYDOCUMENTS = &H5& '我的文档
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, _
     ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
'***************************************************************************************************************************
     

'****************************************************************************************************************
Public Declare Function GetOpenFileName Lib "comdlg32.dll" Alias _
"GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long

Public Type OPENFILENAME
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
'****************************************************************************************************************

'**************图像宽高像素******************************
  Public Type ImageSize
        Width   As Long
        Height   As Long
  End Type
'********************************************************
'*****************************************************************************************************
'获得excel.exe路径
  Public Function GetExcelPath() As String
                GetExcelPath = GetOfficeAppPath("Excel.Application")
  End Function
'  Public Function GetWordPath() As String
'                GetWordPath = GetOfficeAppPath("Word.Application")
'  End Function
'  Public Function GetAccessPath() As String
'                GetAccessPath = GetOfficeAppPath("Access.Application")
'  End Function
'  Public Function GetOutlookPath() As String
'                GetOutlookPath = GetOfficeAppPath("Outlook.Application")
'  End Function
'  Public Function GetPowerPointPath() As String
'                GetPowerPointPath = GetOfficeAppPath("PowerPoint.Application")
' End Function
'  Public Function GetFrontPagePath() As String
'                GetFrontPagePath = GetOfficeAppPath("FrontPage.Application")
'  End Function
  
  Public Function GetOfficeAppPath(ByVal ProgID As String) _
            As String
  Dim lKey         As Long
  Dim lRet         As Long
  Dim sClassID         As String
  Dim sAns         As String
  Dim lngBuffer         As Long
  Dim lPos         As Long
            'GetClassID
            lRet = RegOpenKeyEx(HKEY_LOCAL_MACHINE, _
                                        "Software\Classes\" & ProgID & "\CLSID", 0&, _
                                            KEY_ALL_ACCESS, lKey)
            If lRet = 0 Then
          
                        lRet = RegQueryValueEx(lKey, "", 0&, REG_SZ, "", lngBuffer)
                        sClassID = Space(lngBuffer)
                        lRet = RegQueryValueEx(lKey, "", 0&, REG_SZ, sClassID, _
                                        lngBuffer)
                        'drop     null-terminator
                        sClassID = Left(sClassID, lngBuffer - 1)
                        RegCloseKey lKey
            End If
                  
                      
            'Get     AppPath
                lRet = RegOpenKeyEx(HKEY_LOCAL_MACHINE, _
                                "Software\Classes\CLSID\" & sClassID & _
                                "\LocalServer32", 0&, KEY_ALL_ACCESS, lKey)
          
        If lRet = 0 Then
                        lRet = RegQueryValueEx(lKey, "", 0&, REG_SZ, "", lngBuffer)
                        sAns = Space(lngBuffer)
                        lRet = RegQueryValueEx(lKey, "", 0&, REG_SZ, sAns, _
                                lngBuffer)
                        sAns = Left(sAns, lngBuffer - 1)
                              
                        RegCloseKey lKey
            End If
                      
                lPos = InStr(sAns, "/")
                                If lPos > 0 Then
                                                sAns = Trim(Left(sAns, lPos - 1))
                                End If
                      
                GetOfficeAppPath = sAns
                      
  End Function
'***************************************************************************************************************



'********************************获得图像文件高度宽度，像素数**********************************************************
  Public Function GetImageSize(sFileName As String) As ImageSize
        On Error Resume Next
        Dim bTemp(3)     As Byte, lPos       As Long, lFlen       As Long
        Open sFileName For Binary As #1
                lFlen = LOF(1)
                Get #1, 1, bTemp()
                'PNG   文件   或   BMP   文件
                If bTemp(0) = &H89 And bTemp(1) = &H50 And bTemp(2) = &H4E And bTemp(3) = &H47 Or bTemp(0) = &H42 And bTemp(1) = &H4D Then
                ''Debug.Print "\PNG   OR   BMP\"
                        Get #1, 19, bTemp
                        GetImageSize.Width = byte2long(bTemp(0), bTemp(1))
                        Get #1, 23, bTemp
                        GetImageSize.Height = byte2long(bTemp(0), bTemp(1))
                End If
                  
                'JPG   文件
                If bTemp(0) = &HFF And bTemp(1) = &HD8 And bTemp(2) = &HFF Then
                        ''Debug.Print "\JPEG\"
                        lPos = 4
                        Do
                                Do
                                        Get #1, lPos, bTemp
                                        lPos = lPos + 1
                                Loop Until (bTemp(0) = &HFF And bTemp(1) <> &HFF) Or lPos > lFlen
                          
                                Get #1, lPos, bTemp
                                          
                                If bTemp(0) >= &HC0 And bTemp(0) <= &HC3 Then
                                        Get #1, lPos + 4, bTemp
                                        Exit Do
                                Else
                                        lPos = lPos + (byte2long(bTemp(2), bTemp(1))) + 1
                                End If
                        Loop While lPos < lFlen
                        GetImageSize.Width = byte2long(bTemp(3), bTemp(2))
                        GetImageSize.Height = byte2long(bTemp(1), bTemp(0))
                End If
    
                'GIF   file
                If bTemp(0) = &H47 And bTemp(1) = &H49 And bTemp(2) = &H46 And bTemp(3) = &H38 Then
                        ''Debug.Print "\GIF\"
                        Get #1, 7, bTemp
                        GetImageSize.Width = byte2long(bTemp(0), bTemp(1))
                        GetImageSize.Height = byte2long(bTemp(2), bTemp(3))
                End If
                          
                'PSD   文件
                If bTemp(0) = &H38 And bTemp(1) = &H42 And bTemp(2) = &H50 And bTemp(3) = &H53 Then
                        ''Debug.Print "\PSD\"
                        Get #1, 17, bTemp
                        GetImageSize.Width = byte2long(bTemp(1), bTemp(0))
                        Get #1, 21, bTemp
                        GetImageSize.Height = byte2long(bTemp(1), bTemp(0))
                End If
                  
                'TIF   文件1
                If bTemp(0) = &H4D And bTemp(1) = &H4D And bTemp(2) = &H0 And bTemp(3) = &H2A Then
                        ''Debug.Print "\TIF1\"
                        Get #1, 31, bTemp
                        GetImageSize.Width = byte2long(bTemp(1), bTemp(0))
                        Get #1, 43, bTemp
                        GetImageSize.Height = byte2long(bTemp(1), bTemp(0))
                End If
                  
                If bTemp(0) = &H49 And bTemp(1) = &H49 And bTemp(2) = &H2A And bTemp(3) = &H0 Then
                        Get #1, 5, bTemp
                        If bTemp(0) = &H8 And bTemp(1) = &H0 And bTemp(2) = &H0 And bTemp(3) = &H0 Then
                                'TIF   文件2-1
                                ''Debug.Print "\TIF2-1\"
                                Get #1, 31, bTemp
                                GetImageSize.Width = byte2long(bTemp(0), bTemp(1))
                                Get #1, 43, bTemp
                                GetImageSize.Height = byte2long(bTemp(0), bTemp(1))
                        Else
                                'TIF   文件2-2
                                ''Debug.Print "\TIF2-2\"
                                lPos = byte2long(bTemp(0), bTemp(1)) + byte2long(bTemp(2), bTemp(3)) * 65536 + 11
                                Get #1, lPos, bTemp
                                GetImageSize.Width = byte2long(bTemp(0), bTemp(1))
                                Get #1, lPos + 12, bTemp
                                GetImageSize.Height = byte2long(bTemp(0), bTemp(1))
                        End If
                End If
    
        Close #1
  End Function
  
  Public Function byte2long(ByVal lsb As Long, ByVal msb As Long) As Long                         '双字节低位在前位高在后转成十进制的函数
        byte2long = lsb + (msb * 256)
  End Function

'***********************************************************************************************************************************8
