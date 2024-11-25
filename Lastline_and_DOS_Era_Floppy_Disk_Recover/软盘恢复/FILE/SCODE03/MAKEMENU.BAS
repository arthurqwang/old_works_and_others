        DIM tishi$(30), bianliang$(30), chuzhi$(30)
        chuhang = CSRLIN: chulie = POS(0)
        GOSUB 91870
        IF RIGHT$(file$, 4) <> ".bas" AND RIGHT$(file$, 4) <> ".BAS" THEN file$ = file$ + ".BAS"
        IF LEFT$(tiaoshifou$, 1) = "n" OR LEFT$(tiaoshifou$, 1) = "N" THEN tiaoshifou$ = "no"
        CLS : LOCATE 1, 1: COLOR 23, 4: PRINT "#"; : COLOR 4, 7: PRINT " INPUT ,, IF END. "
        COLOR 0, 3
        FOR i = 1 TO 1000
        INPUT "Input information ,Name of variable,Initial value: ", tishi$(i), bianliang$(i), chuzhi$(i)
        SOUND 2000, 1
        IF tishi$(i) = "" AND bianliang$(i) = "" AND chuzhi$(i) = "" THEN EXIT FOR
        IF LEN(tishi$(i)) > LEN(tishi$(i - 1)) THEN lenn = LEN(tishi$(i))
        NEXT i
        chuhang = CSRLIN: chulie = POS(0)
        IF zlie <> 0 THEN 3214
        IF lenn < 13 THEN lenn = 13
        zlie = lenn + 12
3214    IF zhang <> 0 THEN 3215
        zhang = i + 4
        IF LEFT$(xianshiFUNfou$, 1) = "n" OR LEFT$(xianshiFUNfou$, 1) = "N" THEN zhang = zhang - 3
3215    canshugeshu = i - 1
        OPEN file$ FOR APPEND AS #1
        IF tiaoshifou$ = "no" OR tiaoshifou$ = "NO" THEN PRINT #1, "end"
        PRINT #1, "91870  "; "cishuuhsic=cishuuhsic+1: if cishuuhsic>1 then goto 918706"
        PRINT #1, "yuanhang = CSRLIN: yuanlie = POS(0):";
        PRINT #1, "csrrsccsr="; qihang; ":pooppoop="; qilie; ":lieeillie="; zlie; ":canshugeshu="; canshugeshu; ":hanggnah="; zhang
        PRINT #1, "beijingse="; beijingsee; ":zifuse="; zifusee; ":kuaiqianse="; kuaiqiansee; ":kuaibeise="; kuaibeisee; ":kuangse="; kuangsee; ":jianse="; jiansee
        PRINT #1, "polie10 = pooppoop + lieeillie - 10"
        PRINT #1, "polie9 = pooppoop + lieeillie - 9"
        IF LEFT$(baocunfou$, 1) = "n" OR LEFT$(baocunfou$, 1) = "N" THEN 987
        PRINT #1, "DEF SEG = 0"
        PRINT #1, "IF (PEEK(&H410) AND &H30) = &H30 THEN monomono = 1 ELSE monomono = 0"
        PRINT #1, "bufseg% = &HB000: buflen% = &H1000"
        PRINT #1, "IF monomono = 0 THEN bufseg% = &HB800: buflen% = &H4000"
        PRINT #1, "DEF SEG = bufseg%"
        PRINT #1, "BSAVE " + CHR$(34) + "baocunpm.dat" + CHR$(34) + ", 0, buflen%"
987     PRINT #1, 91880; "    "; bianliang$(1) + "=";
        IF RIGHT$(bianliang$(1), 1) = "$" THEN PRINT #1, CHR$(34) + chuzhi$(1) + CHR$(34);  ELSE PRINT #1, chuzhi$(1);
        FOR k = 2 TO canshugeshu
        PRINT #1, ":" + bianliang$(k) + "=";
        IF RIGHT$(bianliang$(k), 1) = "$" THEN PRINT #1, CHR$(34) + chuzhi$(k) + CHR$(34);  ELSE PRINT #1, chuzhi$(k);
        NEXT k
        PRINT #1, " "
        PRINT #1, "918706    ";
        PRINT #1, "color 7,0:locate csrrsccsr,pooppoop:color kuangse,beijingse"
        PRINT #1, "print chr$(201)+string$(lieeillie-2,205)+chr$(187)"
        PRINT #1, "for i90761=csrrsccsr+1 to csrrsccsr+hanggnah-1"
        PRINT #1, "locate i90761,pooppoop:print chr$(186)+space$(lieeillie-2)+chr$(186)"
        PRINT #1, "next i90761"
        PRINT #1, "locate csrrsccsr+hanggnah,pooppoop:print chr$(200)+string$(lieeillie-2,205)+chr$(188)"
        PRINT #1, "locate csrrsccsr+1,pooppoop+2:color jianse"
        PRINT #1, "print " + CHR$(34) + "RUN PROGRAM :" + CHR$(34) + ";:locate,polie10:print " + CHR$(34) + " YES" + CHR$(34)
        PRINT #1, "color zifuse"
        FOR i = 1 TO canshugeshu
        PRINT #1, "locate,pooppoop+2"
        IF RIGHT$(bianliang$(i), 1) = "$" THEN
        PRINT #1, "print" + CHR$(34) + tishi$(i) + CHR$(34) + ";:locate,polie9:print " + bianliang$(i)
        ELSE
        PRINT #1, "print" + CHR$(34) + tishi$(i) + CHR$(34) + ";:locate,polie10:print " + bianliang$(i)
        END IF
        NEXT i
        IF LEFT$(xianshiFUNfou$, 1) = "n" OR LEFT$(xianshiFUNfou$, 1) = "N" THEN GOTO 91877
        PRINT #1, "locate,pooppoop+1:color kuangse"
        PRINT #1, "print string$(lieeillie-2,196)"
        PRINT #1, "locate,pooppoop+2:color jianse"
        PRINT #1, "print " + CHR$(34) + "Run<F1> " + CHR$(34) + "; " + CHR$(34) + "Modify<Space>" + CHR$(34)
        PRINT #1, "locate ,pooppoop+2:print" + CHR$(34) + "Cancel<Del> " + CHR$(34) + ";" + CHR$(34) + "End<Esc>" + CHR$(34)
91877   PRINT #1, "locate csrrsccsr+1 ,polie9,1,1,13"
        PRINT #1, "918701  k00912$=inkey$:if k00912$=" + CHR$(34) + CHR$(34) + "then goto 918701  "
        IF LEFT$(fashengfou$, 1) = "y" OR LEFT$(fashengfou$, 1) = "Y" THEN PRINT #1, "sound 2000,1"
        PRINT #1, "if csrlin=csrrsccsr+1 and k00912$=chr$(13) then goto 918702"
        PRINT #1, "if mid$(k00912$,2,1)=chr$(59) then goto 918702"
        PRINT #1, "if k00912$=chr$(27) then goto 918702"
        PRINT #1, "if mid$(k00912$,2,1)=chr$(72) then"
        PRINT #1, "if csrlin>csrrsccsr+1 then"
        PRINT #1, "print chr$(30);"
        PRINT #1, "goto 918701"
        PRINT #1, "end if"
        PRINT #1, "end if"
        PRINT #1, "if mid$(k00912$,2,1)=chr$(80) or (csrlin<>csrrsccsr+1 and k00912$=chr$(13)) then"
        PRINT #1, "if csrlin<csrrsccsr+canshugeshu+1 then"
        PRINT #1, "print chr$(31);"
        PRINT #1, "else locate csrrsccsr +1,polie9"
        PRINT #1, "end if"
        PRINT #1, "goto 918701"
        PRINT #1, "end if"
        PRINT #1, "if mid$(k00912$,2,1)=chr$(83) then goto 91880"
        PRINT #1, "linnill=csrlin"
        PRINT #1, "if linnill<>csrrsccsr+1 then color kuaiqianse,kuaibeise:print" + CHR$(34) + "        " + CHR$(34) + ";:locate linnill,polie9"
        PRINT #1, "select case linnill"
        'PRINT #1, "case  csrrsccsr+2"
        FOR ii = 1 TO canshugeshu
        PRINT #1, "case csrrsccsr+" + STR$(ii + 1)
        PRINT #1, "input" + CHR$(34) + CHR$(34) + "," + bianliang$(ii)
        IF ii = canshugeshu THEN
        PRINT #1, "locate csrrsccsr+1,polie9"
        ELSE
        PRINT #1, "locate csrrsccsr+" + STR$(ii + 2) + ",polie9"
        END IF
        NEXT ii
        PRINT #1, "end select"
        PRINT #1, "goto 918701"
        PRINT #1, "918702";
        IF LEFT$(baocunfou$, 1) = "n" OR LEFT$(baocunfou$, 1) = "N" THEN 988
        PRINT #1, "   bload " + CHR$(34) + "baocunpm.dat" + CHR$(34) + ",0"
988     PRINT #1, "    color 7,0"
        IF LEFT$(baocunfou$, 1) = "n" OR LEFT$(baocunfou$, 1) = "N" THEN PRINT #1, "if yuanhang< hanggnah+3 then yuanhang=hanggnah+3"
        PRINT #1, "locate yuanhang,yuanlie"
        PRINT #1, "if k00912$=chr$(27) then end"
        IF tiaoshifou$ = "no" OR tiaoshifou$ = "NO" THEN 12
        PRINT #1, "'*********************cihang yixia tiaohou shanchu********"
        FOR iii = 1 TO canshugeshu
        PRINT #1, "print " + bianliang$(iii)
        NEXT iii
        PRINT #1, "end"
        PRINT #1, "'*********************cihang yixia tiaohou shanchu********"
12      PRINT #1, "return"
        LOCATE chuhang, chulie
        CLOSE
        END
91870    CSRRSCCSR = 1: pooppoop = 10: hanggnah = 20: lieeillie = 40: canshugeshu = 15
beijingse = 3: zifuse = 1: kuaiqianse = 4: kuaibeise = 7: kuangse = 0: jianse = 4
polie10 = pooppoop + lieeillie - 10
polie9 = pooppoop + lieeillie - 9': DIM a601c45(hanggnah + 4, lieeillie), b601c45(hanggnah + 4, lieeillie)
        DEF SEG = 0
        IF (PEEK(&H410) AND &H30) = &H30 THEN mono = 1 ELSE mono = 0
        bu% = &HB000: b% = &H1000
        IF mono = 0 THEN bu% = &HB800: b% = &H4000
        DEF SEG = bu%
        BSAVE "pic.dat", 0, b%
91880    file$ = COMMAND$: IF file$ = "" THEN file$ = "A.BAS"
IF RIGHT$(file$, 4) <> ".bas" AND RIGHT$(file$, 4) <> ".BAS" THEN file$ = file$ + ".BAS"
qihang = 1: qilie = 1: zhang = 0: zlie = 0: beijingsee = 3: kuangsee = 0: zifusee = 1: jiansee = 4: kuaibeisee = 7: kuaiqiansee = 4
tiaoshifou$ = "YES": fashengfou$ = "YES": baocunfou$ = "YES": xianshiFUNfou$ = "YES"
COLOR 7, 0: LOCATE CSRRSCCSR, pooppoop: COLOR kuangse, beijingse
PRINT CHR$(201) + STRING$(lieeillie - 2, 205) + CHR$(187)
FOR i90761 = CSRRSCCSR + 1 TO CSRRSCCSR + hanggnah - 1
LOCATE i90761, pooppoop: PRINT CHR$(186) + SPACE$(lieeillie - 2) + CHR$(186)
NEXT i90761
LOCATE CSRRSCCSR + hanggnah, pooppoop: PRINT CHR$(200) + STRING$(lieeillie - 2, 205) + CHR$(188)
LOCATE CSRRSCCSR + 1, pooppoop + 2: COLOR jianse
PRINT "RUN PROGRAM :"; : LOCATE , polie10: PRINT " YES"
COLOR zifuse
LOCATE , pooppoop + 2
PRINT "File appended:"; : LOCATE , polie9: PRINT file$
LOCATE , pooppoop + 2
PRINT "Start row:"; : LOCATE , polie10: PRINT qihang
LOCATE , pooppoop + 2
PRINT "Start column:"; : LOCATE , polie10: PRINT qilie
LOCATE , pooppoop + 2
PRINT "Width at row:"; : LOCATE , polie9: PRINT "Auto"
LOCATE , pooppoop + 2
PRINT "Width at column:"; : LOCATE , polie9: PRINT "Auto"
LOCATE , pooppoop + 2
PRINT "Background color:"; : LOCATE , polie10: PRINT beijingsee
LOCATE , pooppoop + 2
PRINT "Border color:"; : LOCATE , polie10: PRINT kuangsee
LOCATE , pooppoop + 2
PRINT "Input information color:"; : LOCATE , polie10: PRINT zifusee
LOCATE , pooppoop + 2
PRINT "FUN-key color:"; : LOCATE , polie10: PRINT jiansee
LOCATE , pooppoop + 2
PRINT "Modifying back color:"; : LOCATE , polie10: PRINT kuaibeisee
LOCATE , pooppoop + 2
PRINT "Modifying fore color:"; : LOCATE , polie10: PRINT kuaiqianse
LOCATE , pooppoop + 2
PRINT "Want sound?"; : LOCATE , polie9: PRINT fashengfou$
LOCATE , pooppoop + 2
PRINT "Display FUN-key information?"; : LOCATE , polie9: PRINT xianshiFUNfou$
LOCATE , pooppoop + 2
PRINT "Keep screen?"; : LOCATE , polie9: PRINT baocunfou$
LOCATE , pooppoop + 2
PRINT "Will debug?"; : LOCATE , polie9: PRINT tiaoshifou$
LOCATE , pooppoop + 1: COLOR kuangse
PRINT STRING$(lieeillie - 2, 196)
LOCATE , pooppoop + 2: COLOR jianse
PRINT "Run<F1> "; "Modify<Space>"
LOCATE , pooppoop + 2: PRINT "Cancel<Del> "; "End<Esc>"
COLOR , 2
FOR jklpp = hanggnah + 2 TO hanggnah + 3
FOR ijklpp = pooppoop TO lieeillie + pooppoop - 1
LOCATE jklpp, ijklpp: PRINT " ": NEXT: NEXT
COLOR 20: LOCATE hanggnah + 2, pooppoop + 2: PRINT "##"; : COLOR 9: PRINT "SAVE FILE APPENDED AS ASCII"
LOCATE , pooppoop + 2: PRINT "CODE BEFORE RUNNING THE PROGRAM!"
LOCATE CSRRSCCSR + 1, polie9, 1, 1, 13
918701  k00912$ = INKEY$: IF k00912$ = "" THEN GOTO 918701
SOUND 2000, 1
IF CSRLIN = CSRRSCCSR + 1 AND k00912$ = CHR$(13) THEN GOTO 918702
IF MID$(k00912$, 2, 1) = CHR$(59) THEN GOTO 918702
IF k00912$ = CHR$(27) THEN GOTO 918702
IF MID$(k00912$, 2, 1) = CHR$(72) THEN
IF CSRLIN > CSRRSCCSR + 1 THEN
PRINT CHR$(30);
GOTO 918701
END IF
END IF
IF MID$(k00912$, 2, 1) = CHR$(80) OR (CSRLIN <> CSRRSCCSR + 1 AND k00912$ = CHR$(13)) THEN
IF CSRLIN < CSRRSCCSR + canshugeshu + 1 THEN
PRINT CHR$(31);
ELSE LOCATE CSRRSCCSR + 1, polie9
END IF
GOTO 918701
END IF
IF MID$(k00912$, 2, 1) = CHR$(83) THEN GOTO 91880
linnill = CSRLIN
IF linnill <> CSRRSCCSR + 1 THEN COLOR kuaiqianse, kuaibeise: PRINT "        "; : LOCATE linnill, polie9
SELECT CASE linnill
CASE CSRRSCCSR + 2
INPUT "", file$
LOCATE CSRRSCCSR + 3, polie9
CASE CSRRSCCSR + 3
INPUT "", qihang
LOCATE CSRRSCCSR + 4, polie9
CASE CSRRSCCSR + 4
INPUT "", qilie
LOCATE CSRRSCCSR + 5, polie9
CASE CSRRSCCSR + 5
INPUT "", zhang
LOCATE CSRRSCCSR + 6, polie9
CASE CSRRSCCSR + 6
INPUT "", zlie
LOCATE CSRRSCCSR + 7, polie9
CASE CSRRSCCSR + 7
INPUT "", beijingsee
LOCATE CSRRSCCSR + 8, polie9
CASE CSRRSCCSR + 8
INPUT "", kuangsee
LOCATE CSRRSCCSR + 9, polie9
CASE CSRRSCCSR + 9
INPUT "", zifusee
LOCATE CSRRSCCSR + 10, polie9
CASE CSRRSCCSR + 10
INPUT "", jiansee
LOCATE CSRRSCCSR + 11, polie9
CASE CSRRSCCSR + 11
INPUT "", kuaibeisee
LOCATE CSRRSCCSR + 12, polie9
CASE CSRRSCCSR + 12
INPUT "", kuaiqiansee
LOCATE CSRRSCCSR + 13, polie9
CASE CSRRSCCSR + 13
INPUT "", fashengfou$
LOCATE CSRRSCCSR + 14, polie9
CASE CSRRSCCSR + 14
INPUT "", xianshiFUNfou$
LOCATE CSRRSCCSR + 15, polie9
CASE CSRRSCCSR + 15
INPUT "", baocunfou$
LOCATE CSRRSCCSR + 16, polie9
CASE CSRRSCCSR + 16
INPUT "", tiaoshifou$
LOCATE CSRRSCCSR + 1, polie9
END SELECT
GOTO 918701
918702 BLOAD "pic.dat", 0
COLOR 7, 0: LOCATE chuhang, chulie
IF k00912$ = CHR$(27) THEN END
RETURN

