DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
	CLS
	SCREEN 7: COLOR 6, 0
	LINE (0, 0)-(319, 199), 1, B
	LOCATE 4, 6
	CALL hanzi("»¶Ó­Ê¹ÓÃºº»¯£Æ£Ï£Ò£Ô£Ò£Á£Î»·¾³", 10, 1, 1, 7)
       
	LOCATE 7, 10
	   CALL hanzi("³õ¼¶°æ", 6, 1, 1, 7)
	   LOCATE 7, 18
	   CALL hanzi("£±£¹£¹£²Äê£µÔÂ", 5, 1, 1, 7)
	LOCATE 10, 13
	CALL hanzi("»¶Ó­Ìá³ö±¦¹óÒâ¼û", 6, 1, 3, 7)
	LOCATE 12, 4
	CALL hanzi("ÇëÓëÎïÌ½¹«Ë¾ÑÐ¾¿Ëù£Ö£Ó£ÐÏîÄ¿×éÁªÏµ", 3, 1, 1, 7)
	LOCATE 12, 4
	CALL hanzi("ÇëÓëÎïÌ½¹«Ë¾ÑÐ¾¿Ëù£Ö£Ó£ÐÏîÄ¿×éÁªÏµ", 5, 1, 4, 7)
	LOCATE 4, 6
	CALL hanzi("»¶Ó­Ê¹ÓÃºº»¯£Æ£Ï£Ò£Ô£Ò£Á£Î»·¾³", 8, 1, 3, 7)
111     IF INKEY$ = "" THEN 111
22       SCREEN 7: COLOR 6, 0
	 SCREEN 9
      CLS
	 i = 0: b$ = "": FOR pp = 1 TO 10: a$(pp) = "": NEXT
	SHELL "DIR/W *.FOR"
	LINE (96, 196)-(534, 333), 3, BF
	LINE (100, 200)-(529, 329), 4, B
	LINE (104, 204)-(525, 325), 1, B
	LOCATE 16, 28
	CALL hanzi("×°ÔØÔ´ÎÄ¼þÂð£¿£¨£Ù£¯£Î£©", 6, 1, 4, 9)
	LOCATE 24, 31
	CALL hanzi("×°ÔØÎÄ¼þ²»ÄÜ´óÓÚ£¹£", 3, 1, 1, 9)

3       INK$ = INKEY$
	IF INK$ = "" THEN 3
	IF INK$ = "N" OR INK$ = "n" THEN 100
	OPEN "XIANGYNG.XY" FOR OUTPUT AS #20
1       i = i + 1
	LOCATE 19 + INT((i - 1) / 2), 22 - 20 * ((i MOD 2) - 1)
	PRINT i;
	IF i >= 10 THEN
	CLOSE #20
	GOTO 22
	END IF
	INPUT ":", a$(i)
	IF UCASE$(RIGHT$(a$(i), 4)) = ".FOR" THEN a$(i) = LEFT$(a$(i), (LEN(a$(i)) - 4))
	IF a$(i) = "" THEN 2
	GOTO 1
2       IF i = 1 THEN a$(1) = "NONAME": i = i + 1
	IF (i - 1) > 3 THEN NUM = 3 ELSE NUM = i - 1
	FOR J = 1 TO NUM
	PRINT #20, a$(J)
	NEXT J
	CLOSE #20
	FOR J = 1 TO i - 1
	b$ = b$ + " " + a$(J)
	NEXT J
	b$ = "FTR" + b$
	SCREEN 0
	LOCATE 1, 1, 1
	SHELL b$
	GOTO 22
100     END

