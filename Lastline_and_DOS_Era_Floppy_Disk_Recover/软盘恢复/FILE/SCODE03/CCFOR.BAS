DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
	CLS
	SCREEN 7: COLOR 6, 0
	LINE (0, 0)-(319, 199), 1, B
	LOCATE 4, 6
	CALL hanzi("欢迎使用汉化ＦＯＲＴＲＡＮ环境", 10, 1, 1, 7)
       
	LOCATE 7, 10
	   CALL hanzi("初级版", 6, 1, 1, 7)
	   LOCATE 7, 18
	   CALL hanzi("１９９２年５月", 5, 1, 1, 7)
	LOCATE 10, 13
	CALL hanzi("欢迎提出宝贵意见", 6, 1, 3, 7)
	LOCATE 12, 4
	CALL hanzi("请与物探公司研究所ＶＳＰ项目组联系", 3, 1, 1, 7)
	LOCATE 12, 4
	CALL hanzi("请与物探公司研究所ＶＳＰ项目组联系", 5, 1, 4, 7)
	LOCATE 4, 6
	CALL hanzi("欢迎使用汉化ＦＯＲＴＲＡＮ环境", 8, 1, 3, 7)
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
	CALL hanzi("装载源文件吗？（Ｙ／Ｎ）", 6, 1, 4, 9)
	LOCATE 24, 31
	CALL hanzi("装载文件不能大于９�", 3, 1, 1, 9)

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

