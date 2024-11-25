DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
        SCREEN 8
        a$ = DATE$
        OPEN "c:\cpav\binglika.rpt" FOR INPUT AS #1
        INPUT #1, b$
        CLOSE #1
        ayue = VAL(LEFT$(a$, 2))
        ari = VAL(MID$(a$, 4, 2))
        anian = VAL(RIGHT$(a$, 4))
        byue = VAL(LEFT$(b$, 2))
        bri = VAL(MID$(b$, 4, 2))
        bnian = VAL(RIGHT$(b$, 4))
        ri = (anian - bnian) * 365 + (ayue - byue) * 30 + ari - bri
        IF ri >= 10 THEN
        SHELL "del c:\cpav\binglika.rpt"
        OPEN "c:\cpav\binglika.rpt" FOR OUTPUT AS #2
        PRINT #2, a$
        CLOSE #2
        CLS
        hzc$ = "Äã±ØÐë¼ì²âÄãµÄÓ²ÅÌª¡"
        LOCATE 7, 18
        hanzi hzc$, 6, 2, 1, 9
123     IF INKEY$ = "" THEN 123
        SHELL "c:"
        SHELL "cd\cpav"
        SHELL "cpav"
        SHELL "cd\"
        END IF
        SCREEN 0
        END

