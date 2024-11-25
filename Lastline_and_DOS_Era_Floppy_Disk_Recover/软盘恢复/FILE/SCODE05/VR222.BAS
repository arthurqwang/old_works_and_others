ON TIMER(1) GOSUB 1001
TIMER ON
SCREEN 9
COLOR 5, 8
xh = 25: yh = 12: xm = 25: ym = 12: xs = 25: ys = 12: x1 = 25: x2 = 25: y1 = 12: y2 = 12
xx1 = 25: xx2 = 25: yy1 = 12: yy2 = 12
VIEW (260, 1)-(318, 30), , 2
CLS
PAINT (25, 12), 1
LINE (0, 0)-(50, 25), 3, BF
LINE (2, 1)-(48, 24), 0, B
FOR T = 0 TO 6.283 STEP 6.283 / 12
CIRCLE (25, 12), 16, 0, T, T + .000000001#, .6
NEXT
GOSUB 1002
'367 l = 0
'GOTO 367
        REM "The program is VR2.BAS (it is v0-bat)"
        AU = .4
        CA = .2
        SCREEN 9
        VIEW (31, 36)-(288, 154), , 2
       
        CLS
       
       
        LOCATE 7, 7
        PRINT "Input well name:";
        GOSUB 1098
        n$ = char$
        LOCATE 20, 1: PRINT n$
        LOCATE 8, 7
        PRINT "Input VR-T file name: ";
        GOSUB 1098
        aa$ = char$
        LOCATE 20, 1: PRINT aa$
        LOCATE 9, 7
         PRINT "Image VR file: ";
         GOSUB 1098
         g$ = char$
            LOCATE 20, 1: PRINT g$
        LOCATE 10, 7
        PRINT "image AV file:";
        GOSUB 1098
        av$ = char$
           LOCATE 20, 1: PRINT av$
        LOCATE 11, 7
        PRINT "Lprint(y/n): ";
        GOSUB 1098
        dy$ = char$
               LOCATE 20, 1: PRINT dy$
        CLS
        LOCATE 12, 9: PRINT "Please wait a moment..."
        KK = 3000
        DIM y(KK), c(KK), R(20), A(5), B(5), Q(5), aa(KK)
120     OPEN "I", #1, aa$
130     FOR i = 1 TO KK
140     IF EOF(1) THEN 180
160     INPUT #1, c(i)
        c(i) = c(i) / 1000
        INPUT #1, y(i)
170     NEXT i
180     CLOSE #1
   
190     zz = i - 1
       
        GOSUB 500
        IF dy$ = "y" OR dy$ = "Y" THEN
        GOSUB 1000
        END IF
        GOSUB 1500
        GOSUB 1600
        LOCATE 17, 8: PRINT "Data over."
899        END



500     R = 0
        MN = 100
        AU = .4
        CA = .2

510     FOR S = 1 TO 3
520     B(S) = AU + (-1) ^ (S - 1) * CA * (S - 2)
530     C1 = 0
        C2 = 0
540     FOR i = 1 TO zz
550     IF y(i) = 0 THEN 590
560     BB = B(S) * c(i)
        vr = y(i)
570     A0 = vr * SQR((EXP(BB) - 1) / BB)
        A1 = (EXP(BB) - 1) / BB
580     C1 = C1 + A0
        C2 = C2 + A1

590     NEXT i
600     A(S) = C1 / C2
        Q = 0

610     FOR i = 1 TO zz
620     IF y(i) = 0 THEN 660
630     BB = B(S) * c(i)
640     A4 = (y(i) - A(S) * SQR((EXP(BB) - 1) / BB)) ^ 2
650     Q = Q + A4
660     NEXT i
670     Q(S) = Q
680
        'PRINT "B="; B(S), "Q="; Q(S), "V="; A(S)
690     NEXT S
        Q1 = Q(1) - Q(3)
        Q2 = Q(3) - Q(2)
        Q3 = Q(2) - Q(1)

700     QA = B(1) ^ 2 * Q2 + B(2) ^ 2 * Q1 + B(3) ^ 2 * Q3
710     QB = B(1) * Q2 + B(2) * Q1 + B(3) * Q3
720     R = R + 1
730     aa(R) = QA / (2 * QB)
        AU = aa(R)
740     MM = MN
        MN = Q(2)
750     IF ABS(MM - MN) < 2 GOTO 770
760     GOTO 510
770     QP = Q(2)
        v0 = A(2)
        bat = B(2) / v0
        CLS
785     LOCATE 10, 8
        PRINT "Q="; Q(2)
        LOCATE 11, 8
        PRINT "V0="; v0
        LOCATE 12, 8
        PRINT "BAT="; bat
        
900     RETURN

1000    LOCATE 9, 8
        LPRINT "WELL:"; n$

        LOCATE 10, 8
        LPRINT "Q="; Q(2)
        LOCATE 11, 8
        LPRINT "V0="; v0
        LOCATE 12, 8
        LPRINT "BAT="; bat
        LPRINT
        LPRINT
        LPRINT " T0", "  VR", "  VR1", "VR-VR1", " Q%"
        LPRINT

        FOR i = 1 TO zz
        bt = v0 * bat * c(i)
        vrl = INT(v0 * SQR((EXP(bt) - 1) / bt) + .5)
        vj = y(i) - vrl
        vx = INT((vj / y(i)) * 100 * 10) / 10

        LPRINT c(i) * 1000, y(i), vrl, vj, vx
        NEXT i
        RETURN
1500     OPEN "o", #2, g$
        FOR i = 4 TO 225
        T = i * 20
        bt = v0 * bat * T / 1000
        vr = v0 * SQR((EXP(bt) - 1) / bt)
        PRINT #2, T, vr
        NEXT i
        CLOSE
        RETURN

1600    OPEN "O", #1, av$
        FOR i = 1 TO zz
        av = 2 * (SQR(v0 ^ 2 + v0 * bat * c(i) * y(i) ^ 2) - v0) / (v0 * bat * c(i))
        PRINT #1, c(i) * 1000 / 2, av
        NEXT i
        RETURN
1098    char$ = ""
908     noo$ = INKEY$: IF noo$ = "" THEN 908
        IF noo$ = CHR$(13) THEN 911
        IF noo$ = CHR$(8) THEN
        char$ = LEFT$(char$, LEN(char$) - 1)
        LOCATE , POS(0) - 1
        PRINT " ";
        LOCATE , POS(0) - 1
        GOTO 908
        ELSE char$ = char$ + noo$
       
        PRINT noo$;
        GOTO 908
        END IF
911    RETURN
1001 GOSUB 1002
1002 VIEW (260, 1)-(318, 30), , 2
 T$ = TIME$
th1$ = MID$(T$, 1, 1)
th2$ = MID$(T$, 2, 1)
tm1$ = MID$(T$, 4, 1)
tm2$ = MID$(T$, 5, 1)
ts1$ = MID$(T$, 7, 1)
ts2$ = MID$(T$, 8, 1)
thh1 = ASC(th1$) - 48
thh2 = ASC(th2$) - 48
tmm1 = ASC(tm1$) - 48
tmm2 = ASC(tm2$) - 48
tss1 = ASC(ts1$) - 48
tss2 = ASC(ts2$) - 48
th = thh1 * 10 + thh2
tm = tmm1 * 10 + tmm2
909 IF tm = 30 THEN tmtm = tmtm + 1
IF tm = 0 THEN tmtmtm = tmtmtm + 1
ts = tss1 * 10 + tss2
LINE (25, 12)-(xs, ys), 3
'xs = (160 + 70 * SIN(.104719755# * ts)) / 8
'ys = (100 - 70 * COS(.104719755# * ts)) / 8
xs = 25 + 12 * SIN(.104719755# * ts)
ys = 12 - 12 * COS(.104719755# * ts) * 20 / 32
LINE (25, 12)-(xs, ys), 2:
SOUND 5000, .5
IF ts <> 0 THEN GOTO 231
LINE (25, 12)-(x2, y2), 3
231
'x2 = (160 + 70 * SIN(.104719755# * tm + .175)) / 8
'y2 = (100 - 70 * COS(.104719755# * tm + .175)) / 8
x2 = 25 + 11 * SIN(.104719755# * tm)
y2 = 12 - 11 * COS(.104719755# * tm) * 20 / 32
LINE (25, 12)-(x2, y2), 0


IF tmtm = 1 THEN BEEP:  IF tm = 31 THEN tmtm = 0
IF tmtmtm = 1 THEN PLAY "o4  mb t120 l4dp32l4dp32l4gl8al8gl2fl2gl4al8gl8el8dl16el16gl8cl16<al16>cl2d": IF tm = 1 THEN tmtmtm = 0
654 IF th >= 12 THEN th = th - 12
IF ts <> 0 THEN GOTO 232

LINE (25, 12)-(xh, yh), 3
232 'xh = (160 + 50 * SIN(.523598775# * th)) / 8
'yh = (100 - 50 * COS(.523598775# * th)) / 8
xh = 25 + 9 * SIN(.523598775# * (th + tm / 60))
yh = 12 - 9 * 20 / 32 * COS(.523598775# * (th + tm / 60))
LINE (25, 12)-(xh, yh), 0
'CIRCLE (160 / 8, 100 / 8), 1, 1
PSET (25, 12), 2
CIRCLE (25, 12), 1, 2
    VIEW (31, 36)-(288, 154), , 2
RETURN
     RETURN

