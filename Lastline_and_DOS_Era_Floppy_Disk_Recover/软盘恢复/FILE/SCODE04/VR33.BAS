ON TIMER(1) GOSUB 1001
TIMER ON
SCREEN 1

xh = 160: yh = 100: xm = 160: ym = 100: xs = 160: ys = 100: x1 = 160: x2 = 160: y1 = 100: y2 = 100
xx1 = 160: xx2 = 160: yy1 = 100: yy2 = 100
COLOR 1, 1
VIEW (280, 1)-(318, 25), , 2
'LINE (282, 2)-(317, 24), 3
'COLOR 0, 1
FOR T = 0 TO 6.283 STEP 6.283 / 12
CIRCLE (20, 12), 16, , T, T + .000000001#, .6
NEXT
'359 h = 0
'GOTO 359
' END

 

        REM "The program is VR2.BAS (it is v0-bat)"
        cishu = 0
        AU = .4
        CA = .2
        SCREEN 1
        VIEW (21, 36)-(298, 154), , 2
       
267       CLS
            cishu = cishu + 1
          IF cishu <> 1 THEN LOCATE 8, 7: PRINT "Last end time:"; eti * 1000
       
        LOCATE 9, 7
        INPUT "Start time (ms):", sti
67      LOCATE 10, 7
        INPUT "End time(ms):", eti
        IF eti < sti THEN
        LOCATE 17, 7
        PRINT "Input end time AGAIN!"
        PLAY "mf l1c"
        GOTO 67
        END IF
        sti = sti / 1000: eti = eti / 1000
        LOCATE 11, 7
        INPUT "Input well name:", n$: IF n$ = "" THEN n$ = nn$ ELSE nn$ = n$
        LOCATE 12, 7
        INPUT "Vr-T file name: ", aa$: IF aa$ = "" THEN aa$ = aaa$ ELSE aaa$ = aa$
        LOCATE 13, 7
        INPUT "Image VR file: ", g$: IF g$ = "" THEN g$ = gg$ ELSE gg$ = g$
        LOCATE 14, 7: INPUT "Image AV file:", av$: IF av$ = "" THEN av$ = avav$ ELSE avav$ = av$
        LOCATE 15, 7
        INPUT "Lprint(y/n): ", dy$: IF dy$ = "" THEN dy$ = dydy$ ELSE dydy$ = dy$
            
            IF cishu > 1 THEN 200
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
200  dtime = c(i - 1) - c(i - 2)
IF sti < dtime THEN sti = dtime
IF cishu = 1 THEN kkst = CINT(sti / dtime): GOTO 210
kkst = CINT(sti / dtime) + 1
210 kket = CINT(eti / dtime)
IF kket > zz THEN kket = zz
        GOSUB 500
        IF dy$ = "y" OR dy$ = "Y" THEN
        GOSUB 1000
        END IF
        GOSUB 1500
        GOSUB 1600
        CLS
        LOCATE 10, 12
        IF kket = zz THEN PRINT "Data over."
        LOCATE 13, 12
        PRINT "Do again?(y/n)"
220 s$ = INKEY$: IF s$ = "" THEN 220
IF s$ = "n" OR s$ = "N" THEN 230
GOTO 267
230 END



500     R = 0
        MN = 100
        AU = .4
        CA = .2

510     FOR s = 1 TO 3
520     B(s) = AU + (-1) ^ (s - 1) * CA * (s - 2)
530     C1 = 0
        C2 = 0
540     FOR i = kkst TO kket
550     IF y(i) = 0 THEN GOTO 590
560     BB = B(s) * c(i)
        vr = y(i)
570     A0 = vr * SQR((EXP(BB) - 1) / BB)
        A1 = (EXP(BB) - 1) / BB
580     C1 = C1 + A0
        C2 = C2 + A1

590     NEXT i
2600     A(s) = C1 / C2
        Q = 0

610     FOR i = kkst TO kket
620     IF y(i) = 0 THEN 660
630     BB = B(s) * c(i)
640     A4 = (y(i) - A(s) * SQR((EXP(BB) - 1) / BB)) ^ 2
650     Q = Q + A4
660     NEXT i
670     Q(s) = Q
680
        'PRINT "B="; B(S), "Q="; Q(S), "V="; A(S)
690     NEXT s
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

        FOR i = kkst TO kket
        bt = v0 * bat * c(i) + .0000000000000001#
        vrl = INT(v0 * SQR((EXP(bt) - 1) / bt) + .5)
        vj = y(i) - vrl
        vx = INT((vj / y(i)) * 100 * 10) / 10

        LPRINT c(i) * 1000, y(i), vrl, vj, vx
        NEXT i
        RETURN
1500     OPEN g$ FOR APPEND AS #2
        WHILE iiii <= CINT(kket * dtime * 50)
        iiii = iiii + 1
        T = iiii * 20
        bt = v0 * bat * T / 1000
        vr = v0 * SQR((EXP(bt) - 1) / bt)
        PRINT #2, T + (c(1) - dtime) * 1000, vr
        WEND
        CLOSE
        RETURN

1600    OPEN av$ FOR APPEND AS #3
        FOR i = kkst + 1 TO kket
        av = 2 * (SQR(v0 ^ 2 + v0 * bat * c(i) * y(i) ^ 2) - v0) / (v0 * bat * c(i))
        PRINT #3, c(i) * 1000 / 2, av
        NEXT i
        RETURN

1001 VIEW (280, 1)-(318, 25), , 2
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
LINE (160 / 8, 100 / 8)-(xs, ys), 0
xs = (160 + 70 * SIN(.104719755# * ts)) / 8
ys = (100 - 70 * COS(.104719755# * ts)) / 8
LINE (160 / 8, 100 / 8)-(xs, ys), 2: ' SOUND 5000, .5
IF ts <> 0 THEN GOTO 231
LINE (160 / 8, 100 / 8)-(x2, y2), 0
231
x2 = (160 + 70 * SIN(.104719755# * tm + .175)) / 8
y2 = (100 - 70 * COS(.104719755# * tm + .175)) / 8
LINE (160 / 8, 100 / 8)-(x2, y2), 1


IF tmtm = 1 THEN BEEP:  IF tm = 31 THEN tmtm = 0
IF tmtmtm = 1 THEN PLAY "o4  mb t120 l4dp32l4dp32l4gl8al8gl2fl2gl4al8gl8el8dl16el16gl8cl16<al16>cl2d": IF tm = 1 THEN tmtmtm = 0
654 IF th >= 12 THEN th = th - 12
IF tm <> 0 THEN GOTO 232

LINE (160 / 8, 100 / 8)-(xh, yh), 0
232 xh = (160 + 50 * SIN(.523598775# * th)) / 8
yh = (100 - 50 * COS(.523598775# * th)) / 8
LINE (160 / 8, 100 / 8)-(xh, yh)
'CIRCLE (160 / 8, 100 / 8), 1, 1
    VIEW (21, 36)-(298, 154), , 2
RETURN

