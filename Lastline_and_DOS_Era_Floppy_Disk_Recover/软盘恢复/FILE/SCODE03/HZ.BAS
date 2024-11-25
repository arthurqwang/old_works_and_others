DECLARE SUB hanzi2 (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
DECLARE SUB box (x!, Y!, xx!, YY!, col!, times!)
DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
       SCREEN 12, 1: ' COLOR 0, 0: KEY OFF
        hzc$ = "西文下显示汉字"
        LOCATE 2, 2
         hanzi hzc$, 2, 3, 1, 9
         LOCATE 4, 1
        INPUT l
        END

SUB box (x, Y, xx, YY, col, times)
FOR i = 0 TO times - 1
LINE (x + i, Y + i)-(xx - i, Y + i), col + 8
LINE (x + i, Y + i)-(x + i, YY - i), col + 8
LINE (x + i, YY - i)-(xx - i, YY - i), 0
LINE (xx - i, YY - i)-(xx - i, Y + i), 0
NEXT
END SUB

SUB fillbox (x, Y, xx, YY, col, times, g, B)
FOR i = 1 TO times
LINE (x + B + 2, Y + B + i * g)-(xx - B - 2, Y + B + i * g), col
NEXT
END SUB

   SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
      IF pingfangshi% = 1 OR pingfangshi% = 2 THEN zihao% = 11
       SELECT CASE zihao%
            CASE 1
              ny = 8: nm = 34: nd = 2: n = 0
            CASE 2
            ny = 8: nm = 34: nd = 2: n = 1
            CASE 3
            ny = 16: nm = 68: nd = 4: n = 0
            CASE 4
            ny = 16: nm = 68: nd = 4: n = 1
            CASE 5
            ny = 16: nm = 68: nd = 4: n = 2
            CASE 6
            ny = 16: nm = 68: nd = 4: n = 3
            CASE 7
            ny = 32: nm = 132: nd = 8: n = 0
            CASE 8
            ny = 32: nm = 132: nd = 8: n = 1
            CASE 9
            ny = 32: nm = 132: nd = 8: n = 2
            CASE 10
            ny = 32: nm = 132: nd = 8: n = 3
            CASE 11
            ny = 16: nm = 34: nd = 1: n = 1
            CASE ELSE
            ny = 16: nm = 68: nd = 4: n = 3
       END SELECT


1        ccfile$ = "hzk16"
        DIM a%(400): a%(0) = 16: a%(1) = ny + 1
        FOR i = 2 TO nm: a%(i) = 0: NEXT i
        OPEN ccfile$ FOR RANDOM AS #1 LEN = 32
        FIELD #1, 32 AS a$
        hzn = INT(LEN(hzc$) / 2)
        FOR ih = 1 TO hzn
        hz$ = MID$(hzc$, (ih - 1) * 2 + 1, 2)
        qw = (ASC(MID$(hz$, 1, 1)) - 160) * 100
        qw = qw + ASC(MID$(hz$, 2, 1)) - 160
        q = INT(qw / 100): w = qw - q * 100
        ld = (q - 1) * 94 + w '- 752
        GET #1, ld
        FOR i = 1 TO 16
       a%((i * nd) + n) = CVI(MID$(a$, 2 * i - 1, 2))
        NEXT i
        SELECT CASE fangshi%
          CASE 1
            PUT (POS(0) * 8 - 8, CSRLIN * 14 - 14), a%, PSET
          CASE 2
            PUT (POS(0) * 8 - 8, CSRLIN * 14 - 14), a%, PRESET
          CASE 3
            PUT (POS(0) * 8 - 8, CSRLIN * 14 - 14), a%, OR
          CASE 4
            PUT (POS(0) * 8 - 8, CSRLIN * 14 - 14), a%, XOR
          CASE ELSE
           PUT (POS(0) * 8 - 8, CSRLIN * 14 - 14), a%, PSET
          END SELECT
       
        LOCATE , POS(0) + 2 * jiange%
        NEXT ih
        CLOSE #1
     END SUB

SUB hanzi2 (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
      IF pingfangshi% = 1 OR pingfangshi% = 2 THEN zihao% = 11
       SELECT CASE zihao%
            CASE 1
              ny = 8: nm = 34: nd = 2: n = 0
            CASE 2
            ny = 8: nm = 34: nd = 2: n = 1
            CASE 3
            ny = 16: nm = 68: nd = 4: n = 0
            CASE 4
            ny = 16: nm = 68: nd = 4: n = 1
            CASE 5
            ny = 16: nm = 68: nd = 4: n = 2
            CASE 6
            ny = 16: nm = 68: nd = 4: n = 3
            CASE 7
            ny = 32: nm = 132: nd = 8: n = 0
            CASE 8
            ny = 32: nm = 132: nd = 8: n = 1
            CASE 9
            ny = 32: nm = 132: nd = 8: n = 2
            CASE 10
            ny = 32: nm = 132: nd = 8: n = 3
            CASE 11
            ny = 16: nm = 34: nd = 1: n = 1
            CASE ELSE
            ny = 16: nm = 68: nd = 4: n = 3
       END SELECT


        ccfile$ = "hzk16"
        DIM a%(400): a%(0) = 16: a%(1) = ny + 1
        FOR i = 2 TO nm: a%(i) = 0: NEXT i
        OPEN ccfile$ FOR RANDOM AS #1 LEN = 32
        FIELD #1, 32 AS a$
        hzn = INT(LEN(hzc$) / 2)
        FOR ih = 1 TO hzn
        hz$ = MID$(hzc$, (ih - 1) * 2 + 1, 2)
        qw = (ASC(MID$(hz$, 1, 1)) - 160) * 100
        qw = qw + ASC(MID$(hz$, 2, 1)) - 160
        q = INT(qw / 100): w = qw - q * 100
        ld = (q - 1) * 94 + w '- 752
        GET #1, ld
        FOR i = 1 TO 16
       a%((i * nd) + n) = CVI(MID$(a$, 2 * i - 1, 2))
        NEXT i
        SELECT CASE fangshi%
          CASE 1
            PUT (POS(0) * 8 - 8, CSRLIN * 16 - 16), a%, PSET
          CASE 2
            PUT (POS(0) * 8 - 8, CSRLIN * 16 - 16), a%, PRESET
          CASE 3
            PUT (POS(0) * 8 - 8, CSRLIN * 16 - 16), a%, OR
          CASE 4
            PUT (POS(0) * 8 - 8, CSRLIN * 16 - 16), a%, XOR
          CASE ELSE
           PUT (POS(0) * 8 - 8, CSRLIN * 16 - 16), a%, PSET
          END SELECT
      
        LOCATE , POS(0) + 2 * jiange%
        NEXT ih
        CLOSE #1
END SUB

SUB init (scrn, exec$)
SCREEN scrn
IF RIGHT$(DATE$, 1) = "4" OR RIGHT$(DATE$, 1) = "5" THEN END
END SUB

SUB printhz (hz$, x, xx, num%)
IF num% >= 7 THEN p = 22 ELSE p = 4
box x + 10, CSRLIN * 16 - 18, xx - 10, CSRLIN * 16 + p, 1, 2
hanzi2 hz$, num%, 1, 4, 9
END SUB

