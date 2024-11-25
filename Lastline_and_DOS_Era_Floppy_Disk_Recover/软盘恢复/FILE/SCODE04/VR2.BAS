 

        REM "The program is VR2.BAS (it is v0-bat)"
        AU = .4
        CA = .2
        SCREEN 1
        VIEW (31, 36)-(288, 154), , 2
       
        CLS
       
       
        LOCATE 7, 7
        INPUT "Input well name:", N$
        LOCATE 8, 7
        INPUT "Input VR-T file name: ", aa$
        LOCATE 9, 7
        INPUT "Image VR file: ", g$
        LOCATE 10, 7: INPUT "image AV file:", av$
        LOCATE 11, 7
        INPUT "Lprint(y/n): ", dy$

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
        LPRINT "WELL:"; N$

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
        t = i * 20
        bt = v0 * bat * t / 1000
        vr = v0 * SQR((EXP(bt) - 1) / bt)
        PRINT #2, t, vr
        NEXT i
        CLOSE
        RETURN

1600    OPEN "O", #1, av$
        FOR i = 1 TO zz
        av = 2 * (SQR(v0 ^ 2 + v0 * bat * c(i) * y(i) ^ 2) - v0) / (v0 * bat * c(i))
        PRINT #1, c(i) * 1000 / 2, av
        NEXT i
        RETURN

