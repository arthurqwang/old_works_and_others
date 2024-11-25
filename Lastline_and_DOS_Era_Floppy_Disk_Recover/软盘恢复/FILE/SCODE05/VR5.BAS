

        REM "The program is VR2.BAS (it is v0-bat)"
        cishu = 0
        AU = .4
        CA = .2
        SCREEN 1
        VIEW (21, 36)-(298, 154), , 2
       
267       CLS
            cishu = cishu + 1
            IF cishu <> 1 THEN LOCATE 7, 7: PRINT "Last end time:"; eti * 1000
        LOCATE 8, 7
        INPUT "Input start time(ms):", sti
        sti = sti / 1000
        LOCATE 9, 7
        INPUT "Input end time(ms):", eti
        eti = eti / 1000
        LOCATE 10, 7
        INPUT "Input step length:", stp
        LOCATE 11, 7
        INPUT "Input well name:", n$: IF n$ = "" THEN n$ = nn$ ELSE nn$ = n$
        LOCATE 12, 7
        INPUT "Input VR-T file name: ", aa$: IF aa$ = "" THEN aa$ = aaa$ ELSE aaa$ = aa$
        LOCATE 13, 7
        INPUT "Image VR-T file name: ", g$: IF g$ = "" THEN g$ = gg$ ELSE gg$ = g$
        LOCATE 14, 7: INPUT "Image VA-T file:", av$: IF av$ = "" THEN av$ = avav$ ELSE avav$ = av$
        LOCATE 15, 7
        INPUT "Lprint(y/n): ", dy$: IF dy$ = "" THEN dy$ = dydy$ ELSE dydy$ = dy$
        CLS
        LOCATE 12, 9: PRINT "Please wait a moment..."
        
            IF cishu > 1 THEN 200

        KK = 3000
        DIM y(KK), c(KK), R(20), A(5), B(5), Q(5), aa(KK)

120     OPEN "I", #1, aa$
130     FOR i = 1 TO KK
140     IF EOF(1) THEN 180
'        INPUT #1, yyyy
160     INPUT #1, c(i)
        c(i) = c(i) / 1000
        INPUT #1, y(i)
170     NEXT i
180     CLOSE #1
   
190 zz = i - 1
         dtime = c(zz) - c(zz - 1)
200         IF sti < c(1) THEN startpoint = 1: GOTO 205

            startpoint = CINT((sti - c(1)) / dtime) + 1
       IF cishu = 1 AND sti > 2 * dtime THEN startpoint = startpoint - 1
205   endpoint = CINT((eti - c(1)) / dtime) + 1
         kkst = startpoint - stp
         kket = startpoint
     WHILE kket < endpoint
kkst = kkst + stp
210 kket = kket + stp
IF kket > endpoint - stp THEN kket = endpoint
IF kket > zz THEN kket = zz
'IF kkst > zz THEN END
        GOSUB 500
        IF dy$ = "y" OR dy$ = "Y" THEN
        GOSUB 1000
        END IF
        GOSUB 1500
        GOSUB 1600
        CLS
        IF kket = zz THEN 1023
        WEND
1023   IF kket = zz THEN LOCATE 13, 12: PRINT " Data over."
LOCATE 15, 12
        PRINT "Do again?(y/n)"
220 s$ = INKEY$: IF s$ = "" THEN 220
IF s$ = "n" OR s$ = "N" THEN GOTO 230 ELSE GOTO 267
230 END



500     R = 0
        MN = 100
        AU = .4
        CA = .2

510     FOR s = 1 TO 3
520     B(s) = AU + (-1) ^ (s - 1) * CA * (s - 2)
530     C1 = 0
        C2 = 0
540     FOR i = kkst + 1 TO kket
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

610     FOR i = kkst + 1 TO kket
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
710     qb = B(1) * Q2 + B(2) * Q1 + B(3) * Q3 + .000000001#
720     R = R + 1
730     aa(R) = QA / (2 * qb)
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

        FOR i = kkst + 1 TO kket
        bt = v0 * bat * c(i) + .0000000000000001#
        vrl = INT(v0 * SQR((EXP(bt) - 1) / bt) + .5)
        vj = y(i) - vrl
        vx = INT((vj / y(i)) * 100 * 10) / 10

        LPRINT c(i) * 1000, y(i), vrl, vj, vx
        NEXT i
        RETURN
1500     OPEN g$ FOR APPEND AS #2
        FOR i = kkst * dtime * 50 + 1 TO kket * dtime * 50
        t = i * 20
        bt = v0 * bat * t / 1000
        vr = v0 * SQR((EXP(bt) - 1) / bt)
        PRINT #2, t + (c(1) - dtime) * 1000, vr
        NEXT i
        CLOSE
        RETURN

1600    OPEN av$ FOR APPEND AS #3
        FOR i = kkst + 1 TO kket
        av = 2 * (SQR(v0 ^ 2 + v0 * bat * c(i) * y(i) ^ 2) - v0) / (v0 * bat * c(i))
        PRINT #3, c(i) * 1000 / 2, av
        NEXT i
        RETURN

