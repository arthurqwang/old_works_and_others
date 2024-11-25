        REM "The program name is qv3c.bas"

        REM " gong neng:use DT data make AV and IV "
        REM " make dttp.de file "

        SCREEN 1
       
        LOCATE 6, 7: INPUT "input file name:", A$
        LOCATE 7, 7: INPUT "h0=", h0
        LOCATE 8, 7: INPUT "v0=", v0
        LOCATE 9, 7: INPUT "dh=", dh
        LOCATE 10, 7: INPUT "jh=", JH
            CLS
        LOCATE 6, 7: INPUT "print h-av file name:", b$
        LOCATE 7, 7: INPUT "print t-av file name:", c$
        LOCATE 8, 7: INPUT "print h-iv file name:", d$
        LOCATE 9, 7: INPUT "print t-iv file name:", e$
        LOCATE 10, 7: INPUT "print h-t file name:", f$
          
           CLS
          
        LOCATE 12, 12: PRINT "good bye"
        n = 0: K = 0: TL = 0: TC = 0
        
        OPEN "i", #1, A$
        OPEN "O", #2, b$
        OPEN "o", #3, c$
        OPEN "o", #4, d$
        OPEN "o", #5, e$
        OPEN "o", #6, f$

        PRINT #2, h0, v0
        PRINT #3, 1000 * h0 / v0, v0
        PRINT #4, h0, v0
        PRINT #5, 1000 * h0 / v0, v0
        PRINT #6, h0, 1000 * h0 / v0

        IF v0 = 0 THEN h0 = 0: t0 = 0: GOTO 220
        t0 = h0 / v0
220 :   IF EOF(1) THEN GOTO 400
        INPUT #1, b
        n = n + 1: K = K + 1: BH = JH / dh
        TT = dh * b * .001 * .001
        TC = TC + TT
        IF K = BH THEN
        K = 0
        TL = TL + TC
        av = INT((h0 + dh * n) / (t0 + TL) * 10 + .5) / 10
        iv = INT(BH * dh * 10 / TC + .5) / 10
        ttt = (t0 + TL) * 1000
        hhh = h0 + dh * n
        PRINT #2, hhh, av
        PRINT #3, ttt, av
        PRINT #4, hhh, iv
        PRINT #5, ttt, iv
        PRINT #6, hhh, ttt

        TC = 0
        END IF
        GOTO 220
400 :   CLOSE
        END

