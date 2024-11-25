       
        REM "the program is plot1.bas"
        REM "Plot program"
       
         DIM htp(4000), ttp(4000)
       
        kkk = 0

15      GOSUB 91870'    LOCATE 11, 7
        IF yn$ = "n" OR yn$ = "N" THEN

        GOSUB 2700
        BLOAD "baocunpm.dat", 0
            COLOR 7, 0
        LOCATE yuanhang, yuanlie
        END

        END IF
        LOCATE 23, 11: COLOR 17, 7: PRINT " PLOTTING... ": COLOR 7, 0
        IF kkk > 0 THEN GOTO 23
        LOCATE 12, 7
         IF ee = 1 OR ee = 4 THEN
         'CLS
         GOTO 20
         END IF
         'CLS
         GOTO 15

20        GOSUB 28
       
23        GOSUB 2400
        IF kkk > 0 THEN GOTO 25
        GOSUB 105
25      GOSUB 2530
        kkk = kkk + 1
        GOTO 15
28      'LOCATE 6, 7: INPUT "tu name:", b$
        'LOCATE 7, 7: INPUT "date:", z$
30     ' LOCATE 8, 7: INPUT "x-y(1,3)", kl
        IF kl = 1 OR kl = 3 THEN
        GOTO 50
        END IF
        GOTO 30
50      'LOCATE 9, 7: INPUT "bu,cu(1 or 2)", lp
       
        'LOCATE 10, 7: INPUT "x-cang(16):", xx
        'LOCATE 11, 7: INPUT "y-cang(10):", yy
        'CLS
        IF lp = 1 THEN
80     ' LOCATE 6, 7: INPUT "max-x:", maxx
        'LOCATE 7, 7: INPUT "max-y:", maxy
        ELSE
        LOCATE 6, 7:
        'INPUT "x-bili:", bu
        'LOCATE 7, 7: INPUT "y-bili:", cu
        END IF

        'LOCATE 8, 7: INPUT "x0:", xx0
        'LOCATE 9, 7: INPUT "y0:", yy0

85      'LOCATE 10, 7: INPUT "x-biao ji:", m$
        'LOCATE 11, 7: INPUT "y-biao ji:", n$
110     'LOCATE 12, 7: INPUT "please...CR", ee$
        RETURN

105     IF lp = 2 THEN GOTO 130

         B1 = (maxx - xx0) / (10 * xx)
         C1 = (maxy - yy0) / (10 * yy)
         IF B1 = INT(B1) THEN
         bu = B1 * 10
         ELSE
         bu = INT(B1 + 1) * 10
         END IF

         IF C1 = INT(C1) THEN
         cu = C1 * 10
         ELSE
         cu = INT(C1 + 1) * 10
         END IF

130     ON kl GOSUB 1000, 1100, 1200, 1300
          u = ee * 100
          xx = xx * u
          yy = yy * u

         ON kl GOSUB 2000, 2100, 2200, 2300

        LPRINT "^SP1"

200     LPRINT "^PU0,0"
        IF ee = 4 THEN
        LPRINT "^SR 0.5,1.5"
        ELSE
        LPRINT "^SR 0.5,1.5"
        END IF

210     LPRINT "^VS 10"
        LPRINT "^PD"; xx * kx; ","; 0; ","; xx * kx - ee * 23 * kx; ","; ee * 4 * kx
       
        IF kx = 1 THEN
        CLC = -70
        ELSE
        CLC = 85
        END IF
       
        LPRINT "^PU"; xx * kx + CLC * ee * kx; ","; 23 * ee
        LPRINT "^LB"; m$; CHR$(3)
        LPRINT "^PU0,0"
220     LPRINT "^PD"; 0; ","; yy * ky; ","; ee * 4 * ky; ","; yy * ky - ky * ee * 17
        LPRINT "^PU"; ee * 20; ","; yy * ky + ky * ee * 15
        LPRINT "^LB"; n$; CHR$(3)
290     FOR i = 1 TO INT(ABS((xx * kx - ee * 100 * kx) / (ee * 200)))
300     LPRINT "^PU"; 2 * u * i * kx; ","; 0
        LPRINT "^PD"; 2 * u * i * kx; ","; -ky * ee * 10
310     IF ky = 1 THEN KLL = 2.2: GOTO 325
320     KLL = 1
325     KS = 1
330     LPRINT "^PU"; 2 * u * i * kx - KS * ee * 40; ","; -ky * KLL * ee * 25
        LPRINT "^LB"; 2 * bu * i + xx0; CHR$(3)
340     NEXT i
350     LPRINT "^PU0,0"
352     IF kx = 1 THEN YL = ee * -155: GOTO 360
355     YL = -ee * 13
360     IF kl = 1 THEN
        XC = 1
        ELSE
        IF kl = 3 THEN
        XC = 0
        END IF
        END IF

        FOR i = 1 TO ABS(INT((yy * ky - ky * ee * 200) / (ee * 200)))

370     LPRINT "^PU"; 0; ","; 2 * i * u * ky
        LPRINT "^PD"; -ee * 10 * kx; ","; 2 * i * u * ky
       
        LPRINT "^PU"; YL * kx + XC * ee * 40; ","; ky * 2 * i * u - ee * 13
380     LPRINT "^LB"; 2 * cu * i + yy0; CHR$(3)
390     NEXT i
         RETURN

1000    kx = 1: ky = 1: RETURN
1100    kx = -1: ky = 1: RETURN
1200    kx = -1: ky = -1: RETURN
1300    kx = 1: ky = -1: RETURN

2000    LPRINT "^IP"; 4 * u; ","; 4 * u; ","; 24 * u; ","; 19 * u
        LPRINT "^SC"; 0; ","; kx * 20 * u; ","; ","; 0; ","; 15 * u * ky
        LPRINT "^DI 1,0"
        RETURN

2100    LPRINT "^IP"; 24 * u; ","; 4 * u; ","; 4 * u; ","; 19 * u
        LPRINT "^SC"; 0; ","; 20 * u * kx; ","; ","; 0; ","; 15 * u * ky
        LPRINT "^DI 1,0"
        RETURN

2200    LPRINT "^IP"; 24 * u; ","; 19 * u; ","; 4 * u; ","; 4 * u
        LPRINT "^SC"; 0; ","; 20 * u * kx; ","; ","; 0; ","; 15 * u * ky
        LPRINT "^DI -1,0"
        RETURN


2300    LPRINT "^IP"; 4 * u; ","; 24 * u; ","; 24 * u; ","; 4 * u
        LPRINT "^SC"; 0; ","; 20 * u * kx; ","; ","; 0; ","; 15 * u * ky
        LPRINT "^DI -1,0"
        RETURN

2400         REM " the program is TC.bas "
             REM " LPOT PROGRAM "
2500      '  CLS
         LOCATE 7, 7
         'INPUT "file name: ", aa$
         LOCATE 8, 7
         'PRINT "1:---  2:+++ "
       
         LOCATE 9, 7
         'INPUT "LINE(1 OR 2) ", xgx
          RETURN

2530     OPEN aa$ FOR INPUT AS #1
         FOR i = 1 TO 10000
          IF EOF(1) THEN GOTO 2540
         INPUT #1, htp(i), ttp(i)
         NEXT i
2540       QQ = i - 1
         CLOSE #1
       
         IF xgx = 1 THEN
         GOSUB 2570
         ELSE
         GOSUB 2560
         END IF
       
        RETURN

2560     LPRINT "^SP1"
         LPRINT "^PU 0,0"
         LPRINT "^VS 10"
         LPRINT "^PU"; kx * u * (htp(1) - xx0) / bu; ","; ky * u * (ttp(1) - yy0) / cu
      
         FOR i = 1 TO QQ
         xj = (htp(i) - xx0) * kx * u / bu
         yj = (ttp(i) - yy0) * ky * u / cu
         LPRINT "^PU"; xj; ","; yj
         LPRINT "^PD"; xj; ","; yj + 5 * ee
         LPRINT "^PD"; xj; ","; yj - 5 * ee
    
         LPRINT "^PU"; xj; ","; yj
         LPRINT "^PD"; xj - 5 * ee; ","; yj
         LPRINT "^PD"; xj + 5 * ee; ","; yj
        
         NEXT i
         LPRINT "^PU"
         RETURN

2570   LPRINT "^PU"; INT(kx * u * (htp(1) - xx0) / bu); ","; INT(ky * u * (ttp(1) - yy0) / cu)
         FOR i = 1 TO QQ
         xj = (htp(i) - xx0) * u * kx / bu
         yj = (ttp(i) - yy0) * ky * u / cu
         LPRINT "^PD"; xj; ","; yj
         NEXT i
         'LPRINT "^PU"; kx * U * HTP(i) / BU; ","; ky * U * TTP(i) / CU + 10
         RETURN
          

2700      LPRINT "^LT"
         IF ee = 4 THEN
         LPRINT "^SR 0.7,2.2"
         ELSE
         LPRINT "^SR 0.7,2.0"
         END IF
         
        IF kl = 1 THEN
        cc1 = ee * 100
        cc2 = ee * 20
        ELSE
        cc1 = -ee * 20
        cc2 = -ee * 100
        END IF

         LPRINT "^PU"; INT(kx * xx / 2) - ee * 200; ","; ky * yy + cc1
         LPRINT "^LB"; b$; CHR$(3)
       
         IF ee = 4 THEN
         LPRINT "^SR 0.65,1.7"
         ELSE
         LPRINT "^SR 0.65,1.7"
         END IF

         LPRINT "^PU"; INT(kx * xx / 2) - ee * 500; ","; ky * yy + cc2
         LPRINT "^LB"; "DA QING WU TAN YAN JIU SUO VSP("; z$; ")"; CHR$(3)
         LPRINT "^PU 0,0"
         LPRINT "^SP"
         LPRINT "^PU 0,0"
2900      RETURN
           
91870 cishu = cishu + 1: IF cishu > 1 THEN GOTO 918706
yuanhang = CSRLIN: yuanlie = POS(0): csrrsccsr = 1: pooppoop = 1: lieeillie = 35: canshugeshu = 18: hanggnah = 22
beijingse = 3: zifuse = 1: kuaiqianse = 4: kuaibeise = 7: kuangse = 0: jianse = 4
polie10 = pooppoop + lieeillie - 10
polie9 = pooppoop + lieeillie - 9
DEF SEG = 0
IF (PEEK(&H410) AND &H30) = &H30 THEN monomono = 1 ELSE monomono = 0
bufseg% = &HB000: buflen% = &H1000
IF monomono = 0 THEN bufseg% = &HB800: buflen% = &H4000
DEF SEG = bufseg%
BSAVE "baocunpm.dat", 0, buflen%
91880     yn$ = "YES": ee = 1: b$ = "": z$ = "1992": kl = 1: lp = 2: xx = 16: yy = 10: maxx = 3000: maxy = 4000: bu = 200: cu = 500: xx0 = 0: yy0 = 0: m$ = "T(ms)": n$ = "V(m/s)": aa$ = "AVP": xgx = 1
918706  COLOR 7, 0: LOCATE csrrsccsr, pooppoop: COLOR kuangse, beijingse
PRINT CHR$(201) + STRING$(lieeillie - 2, 205) + CHR$(187)
FOR i90761 = csrrsccsr + 1 TO csrrsccsr + hanggnah - 1
LOCATE i90761, pooppoop: PRINT CHR$(186) + SPACE$(lieeillie - 2) + CHR$(186)
NEXT i90761
LOCATE csrrsccsr + hanggnah, pooppoop: PRINT CHR$(200) + STRING$(lieeillie - 2, 205) + CHR$(188)
LOCATE csrrsccsr + 1, pooppoop + 2: COLOR jianse
PRINT "RUN PROGRAM :"; : LOCATE , polie10: PRINT " YES"
COLOR zifuse
LOCATE , pooppoop + 2
PRINT "Continue?"; : LOCATE , polie9: PRINT yn$
LOCATE , pooppoop + 2
PRINT "Ploter(1 or 4):"; : LOCATE , polie10: PRINT ee
LOCATE , pooppoop + 2
PRINT "Picture name:"; : LOCATE , polie9: PRINT b$
LOCATE , pooppoop + 2
PRINT "Date:"; : LOCATE , polie9: PRINT z$
LOCATE , pooppoop + 2
PRINT "Image location(1 or 3):"; : LOCATE , polie10: PRINT kl
LOCATE , pooppoop + 2
PRINT "Scale select:(1 or 2):"; : LOCATE , polie10: PRINT lp
LOCATE , pooppoop + 2
PRINT "X-Length:"; : LOCATE , polie10: PRINT xx
LOCATE , pooppoop + 2
PRINT "Y-Length:"; : LOCATE , polie10: PRINT yy
LOCATE , pooppoop + 2
PRINT "X-Max-Data:"; : LOCATE , polie10: PRINT maxx
LOCATE , pooppoop + 2
PRINT "Y-Max-Data:"; : LOCATE , polie10: PRINT maxy
LOCATE , pooppoop + 2
PRINT "X-Scale:"; : LOCATE , polie10: PRINT bu
LOCATE , pooppoop + 2
PRINT "Y-Scale:"; : LOCATE , polie10: PRINT cu
LOCATE , pooppoop + 2
PRINT "X-Min-Data:"; : LOCATE , polie10: PRINT xx0
LOCATE , pooppoop + 2
PRINT "Y-Min-Data:"; : LOCATE , polie10: PRINT yy0
LOCATE , pooppoop + 2
PRINT "X-Symbol:"; : LOCATE , polie9: PRINT m$
LOCATE , pooppoop + 2
PRINT "Y-Symbol:"; : LOCATE , polie9: PRINT n$
LOCATE , pooppoop + 2
PRINT "File name:"; : LOCATE , polie9: PRINT aa$
LOCATE , pooppoop + 2
PRINT "Line-Type(1:--- 2:+++):"; : LOCATE , polie10: PRINT xgx
'LOCATE , pooppoop + 1: COLOR kuangse
'PRINT STRING$(lieeillie - 2, 196)
LOCATE , pooppoop + 2: COLOR jianse
PRINT "Run<F1> "; "Modify<Space>"
LOCATE , pooppoop + 2: PRINT "Cancel<Del> "; "End<Esc>"
LOCATE csrrsccsr + 1, polie9, 1, 1, 13
918701  k00912$ = INKEY$: IF k00912$ = "" THEN GOTO 918701
SOUND 2000, 1
IF CSRLIN = csrrsccsr + 1 AND k00912$ = CHR$(13) THEN GOTO 918702
IF MID$(k00912$, 2, 1) = CHR$(59) THEN GOTO 918702
IF k00912$ = CHR$(27) THEN GOTO 918702
IF MID$(k00912$, 2, 1) = CHR$(72) THEN
IF CSRLIN > csrrsccsr + 1 THEN
PRINT CHR$(30);
GOTO 918701
END IF
END IF
IF MID$(k00912$, 2, 1) = CHR$(80) OR (CSRLIN <> csrrsccsr + 1 AND k00912$ = CHR$(13)) THEN
IF CSRLIN < csrrsccsr + canshugeshu + 1 THEN
PRINT CHR$(31);
ELSE LOCATE csrrsccsr + 1, polie9
END IF
GOTO 918701
END IF
IF MID$(k00912$, 2, 1) = CHR$(83) THEN GOTO 91880
linnill = CSRLIN
IF linnill <> csrrsccsr + 1 THEN COLOR kuaiqianse, kuaibeise: PRINT "        "; : LOCATE linnill, polie9
SELECT CASE linnill
CASE csrrsccsr + 2
INPUT "", yn$
LOCATE csrrsccsr + 3, polie9
CASE csrrsccsr + 3
INPUT "", ee
LOCATE csrrsccsr + 4, polie9
CASE csrrsccsr + 4
INPUT "", b$
LOCATE csrrsccsr + 5, polie9
CASE csrrsccsr + 5
INPUT "", z$
LOCATE csrrsccsr + 6, polie9
CASE csrrsccsr + 6
INPUT "", kl
LOCATE csrrsccsr + 7, polie9
CASE csrrsccsr + 7
INPUT "", lp
LOCATE csrrsccsr + 8, polie9
CASE csrrsccsr + 8
INPUT "", xx
LOCATE csrrsccsr + 9, polie9
CASE csrrsccsr + 9
INPUT "", yy
LOCATE csrrsccsr + 10, polie9
CASE csrrsccsr + 10
INPUT "", maxx
LOCATE csrrsccsr + 11, polie9
CASE csrrsccsr + 11
INPUT "", maxy
LOCATE csrrsccsr + 12, polie9
CASE csrrsccsr + 12
INPUT "", bu
LOCATE csrrsccsr + 13, polie9
CASE csrrsccsr + 13
INPUT "", cu
LOCATE csrrsccsr + 14, polie9
CASE csrrsccsr + 14
INPUT "", xx0
LOCATE csrrsccsr + 15, polie9
CASE csrrsccsr + 15
INPUT "", yy0
LOCATE csrrsccsr + 16, polie9
CASE csrrsccsr + 16
INPUT "", m$
LOCATE csrrsccsr + 17, polie9
CASE csrrsccsr + 17
INPUT "", n$
LOCATE csrrsccsr + 18, polie9
CASE csrrsccsr + 18
INPUT "", aa$
LOCATE csrrsccsr + 19, polie9
CASE csrrsccsr + 19
INPUT "", xgx
LOCATE csrrsccsr + 1, polie9
END SELECT
GOTO 918701
918702  IF k00912$ = CHR$(27) THEN
BLOAD "baocunpm.dat", 0
    COLOR 7, 0
LOCATE yuanhang, yuanlie
END
END IF
RETURN

