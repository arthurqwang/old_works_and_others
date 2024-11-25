DECLARE SUB init (scrn!, exec$)
DECLARE SUB hanzi2 (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
DECLARE SUB printhz (hz$, x!, xx!, num%)
DECLARE SUB fillbox (x!, Y!, xx!, YY!, col!, times!, g!, B!)
DECLARE SUB box (x!, Y!, xx!, YY!, col!, times!)
DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
DIM grph(10000)
init 12, exec$
LINE (0, 0)-(639, 479), 6, B
LINE (160, 0)-(479, 199), 1, BF
LINE (160, 0)-(479, 199), 8, B
box 165, 5, 475, 195, 1, 5
LINE (171, 11)-(469, 189), 3, B
LOCATE 4, 26
box 190, 39, 450, 79, 1, 3
fillbox 190, 39, 450, 79, 6, 17, 2, 2
hanzi "二维观测系统绘制", 8, 2, 4, 9
box 190, 93, 450, 118, 1, 3
box 190, 121, 450, 146, 1, 3
box 190, 149, 450, 174, 1, 3
LOCATE 8, 29
hanzi "版本：１．０", 6, 1, 4, 9
LOCATE 8, 42
hanzi "（１９９３）", 6, 1, 4, 9
LOCATE 10, 26
hanzi "版权所有：大庆物探研究所研究室", 6, 1, 4, 9
LOCATE 12, 26
hanzi "欢迎使用欢迎垂询", 3, 2, 4, 9
GET (160, 0)-(479, 199), grph
LINE (0, 0)-(639, 479), 6, B
FOR jj = 1 TO 100 STEP 10
SOUND jj * 10 + 500, 2
LINE (160, jj)-(479, 30 + jj), 0, BF
PUT (160, jj + 30), grph, PSET
NEXT
SOUND 100, 3
70 A$ = INKEY$: IF A$ = "" THEN 70
LINE (25, 55)-(305, 405), 1, BF
LINE (25, 55)-(305, 405), 8, B
LINE (30, 60)-(300, 400), 1, BF
box 30, 60, 300, 400, 1, 3
90 LOCATE 7, 15: printhz "发炮方式选择:", 30, 300, 7
100 LOCATE 12, 8: printhz "１．拉排列放炮:", 30, 300, 6
110 LOCATE 14, 8: printhz "２．中间放炮:", 30, 300, 6
120 LOCATE 16, 8: printhz "３．推排列放炮:", 30, 300, 6
130 LOCATE 18, 8: printhz "０．退出:", 30, 300, 6
140 LOCATE 21, 8: printhz "请选择：", 30, 300, 3
LOCATE 21, 17: INPUT "", c
150 REM BEEP:PLAY "A":PLAY "B":PLAY "C"
160 c = c - 2: IF c = -2 THEN SYSTEM
170 DIM A$(17)
180 LINE (325, 55)-(615, 405), 1, BF
LINE (325, 55)-(615, 405), 8, B
box 330, 60, 610, 400, 1, 3
LOCATE 7, 55: printhz "输入参数:", 330, 610, 7
190 LOCATE 10, 46: printhz "炮数：", 330, 610, 6: INPUT "", N
200 DIM X00(N), X01(N), X02(N), X03(N), X0(N), X1(N), X2(N), X3(N), AX(N), BX(N), CX(N), DX(N), AY(N), BY(N), CY(N), DY(N), A1X(N), A1Y(N), B1X(N), B1Y(N), C1X(N), C1Y(N), D1X(N)
210 DIM D1Y(N), B11X(N), B11Y(N), T(N), HI(N), WD(N), XU(N), gr(N), FF$(N), FW(N)
220 LOCATE 12, 46: printhz "偏移距（米）：", 330, 610, 6: INPUT "", XL
230 LOCATE 14, 46: printhz "道数：", 330, 610, 6: INPUT "", XN
240 LOCATE 16, 46: printhz "道距（米）：", 330, 610, 6: INPUT "", DDX
250 LOCATE 18, 46: printhz "炮距（米）：", 330, 610, 6: INPUT "", SD
260 LOCATE 20, 46: printhz "首炮桩号（公里）：", 330, 610, 6: INPUT "", X00(1)
270 LOCATE 22, 46: printhz "首道桩号（公里）：", 330, 610, 6: INPUT "", X0Z
LINE (340, 140)-(600, 390), 1, BF
280 LOCATE 12, 46: printhz "线头减道终止炮号：", 330, 610, 6: INPUT "", I1
290 LOCATE 14, 46: printhz "线尾减道起始炮号：", 330, 610, 6: INPUT "", I2
300 LOCATE 16, 46: printhz "大小号发炮方式选择", 330, 610, 6
LOCATE 18, 50: printhz "（大号１，小号０）：", 330, 610, 6: INPUT "", D
310 LOCATE 20, 46: printhz "绘图比例尺：", 330, 610, 6: INPUT "", B
320 IF c <> 0 THEN 350
330 LOCATE 22, 46: printhz "左最大炮检距（米）：", 330, 610, 6: INPUT "", QQ1
340 LOCATE 24, 46: printhz "右最大炮检距（米）：", 330, 610, 6: INPUT "", QQ2
350 IF D = 1 THEN SD = -1 * SD
360 XL = XL / B * 1000
370 DDX = DDX / B * 1000
380 SD = SD / B * 1000
390 IF c = 0 THEN Q1 = QQ1 / 2 / B * 1000: Q2 = QQ2 / 2 / B * 1000: X0(1) = Q1 ELSE Q = (DDX * (XN - 1) + XL) / 2: X0(1) = Q
400 IF D = 1 AND c = 0 THEN AZ = Q1: Q1 = Q2: Q2 = AZ
410 MK = ABS(X00(1) - X0Z) / 2 / B * 1000 * 1000
420 IF c = 1 THEN SS = Q * 4 / 5
430 H = XL / 2: QK1 = Q1: QK2 = Q2: QKQ = Q
440 K = 1
450 FOR J = 1 TO N
460 FW(J) = .1
470 X0(J) = X0(1) + ABS(SD) * (J - 1)
480 X00(J) = X00(1) + SD * (J - 1) / 1000 * B / 1000
490 NEXT J
LINE (95, 115)-(555, 255), 1, BF
LINE (95, 115)-(555, 255), 8, B
box 100, 120, 550, 250, 1, 3
LOCATE 10, 18: printhz "哪个盘存放随机数据文件：", 100, 550, 6: INPUT "", KK$
510 LOCATE 12, 18: printhz "是否重新输入随机数据文件（Ｙ／Ｎ）：", 100, 550, 6: INPUT "", p$
520 IF p$ = "n" OR p$ = "N" THEN 630
530 OPEN KK$ + ":" + "THW.DAT" FOR OUTPUT AS #2
540 LINE (105, 205)-(565, 385), 1, BF
LINE (105, 205)-(565, 385), 8, B
box 110, 210, 560, 380, 1, 3
LOCATE 15, 18: printhz "炮号：", 110, 560, 6: INPUT "", K
550 LOCATE 17, 18: printhz "τ值（毫秒）：", 110, 560, 6: INPUT "", T(K)'t  T(k)=(ms)
560 LOCATE 19, 18: printhz "井口高程（米）：", 110, 560, 6: INPUT "", HI(K)' HI(k)=(m)
570 LOCATE 21, 18: printhz "井深（米）：", 110, 560, 6: INPUT "", WD(K)' WD(k)=(m)
580 IF T(K) = 0 OR HI(K) = 0 THEN CLOSE #2: GOTO 620
590 PRINT #2, K, T(K), HI(K), WD(K)
600 K = K + 1
610 GOTO 540
620 OPEN KK$ + ":" + "kkk.dat" FOR OUTPUT AS #3: PRINT #3, K: CLOSE #3
630 LINE (105, 205)-(565, 385), 1, BF
LINE (105, 205)-(565, 385), 8, B
box 110, 210, 560, 380, 1, 3
LOCATE 15, 18: printhz "是否输入新的地物数据（Ｙ／Ｎ）：", 110, 560, 6: INPUT "", p$
LINE (125, 230)-(575, 395), 1, BF
LINE (125, 230)-(575, 395), 8, B
box 125, 235, 570, 390, 1, 3
640 IF p$ = "n" OR p$ = "N" THEN 720
650 OPEN KK$ + ":" + "pp.dat" FOR OUTPUT AS #6
660 'WIDTH 80: CLS :
LINE (130, 255)-(565, 385), 1, BF
LOCATE 17, 20: printhz "地物线分点炮号：", 125, 570, 6: INPUT "", gr(i)' GR(i)=
670 LOCATE 19, 20: printhz "地物名：", 125, 570, 6: INPUT "", FF$(i)' FF$(i)=
680 IF gr(i) = 0 THEN CLOSE #6: GOTO 710
690 PRINT #6, gr(i), FF$(i): i = i + 1: IG = i
700 GOTO 660
710 OPEN KK$ + ":" + "GG.DAT" FOR OUTPUT AS #8: PRINT #8, IG: CLOSE #8
720 LINE (130, 255)-(565, 385), 1, BF
LOCATE 17, 20: printhz "废炮炮号：", 125, 570, 6: INPUT "", i
730 LOCATE 19, 20: printhz "废炮桩号（公里）：", 125, 570, 6: INPUT "", X02(i)' X02(I)=(km)
740 IF i = 0 THEN GOTO 780
750 X2(i) = X0(1) + ABS(X02(i) - X00(1)) / B * 1000 * 1000
760 X0(i) = X2(i)
770 GOTO 720
780 LINE (130, 255)-(565, 385), 1, BF
LOCATE 17, 20: printhz "空炮炮号：", 125, 570, 6: INPUT "", i
790 LOCATE 19, 20: printhz "空炮桩号（公里）：", 125, 570, 6: INPUT "", X03(i)'X03(I)=(km)
800 IF i = 0 THEN 840
810 X3(i) = X0(1) + ABS(X03(i) - X00(1)) / B * 1000 * 1000
820 X0(i) = X3(i)
830 GOTO 780
840 LINE (130, 255)-(565, 385), 1, BF
LOCATE 17, 20: printhz "变观起始炮号：", 125, 570, 6: INPUT "", IIF' IIF=
850 LOCATE 19, 20: printhz "变观终止炮号：", 125, 570, 6: INPUT "", IIE' IIE=
860 LOCATE 21, 20: printhz "变观方向（１，－１）：", 125, 570, 6: INPUT "", LK' LK=(1,-1)
870 LOCATE 23, 20: printhz "变观系数：", 125, 570, 6: INPUT "", F' F=
880 IF LK = 0 THEN GOTO 970
890 FOR i = IIF TO IIE
900 FW(i) = F
910 X01(i) = X00(i)
920 X1(i) = X0(1) + ABS(X01(i) - X00(1)) / B * 1000 * 1000
930 IF LK = 1 THEN X00(i) = X01(i) - (i - IIF + 1) * SD / 1000 * B / 1000 * F: X0(i) = X0(1) + ABS(X00(i) - X00(1)) / B * 1000 * 1000
940 IF LK = -1 THEN X00(i) = X01(i) + (IIE - i + 1) * SD / 1000 * B / 1000 * F: X0(i) = X0(1) + ABS(X00(i) - X00(1)) / B * 1000 * 1000
950 NEXT i
960 GOTO 840
970 LINE (130, 255)-(565, 385), 1, BF
LOCATE 17, 20: printhz "空段起始炮号：", 125, 570, 6: INPUT "", KFK
980 LOCATE 19, 20: printhz "空段终止炮号：", 125, 570, 6: INPUT "", KEK' KEK=
990 IF KFK = 0 OR KEK = 0 THEN LOCATE 23, 32: printhz "输入数据正确吗？（Ｙ／Ｎ）", 125, 570, 3: INPUT "", B$ ELSE 1010
1000 IF B$ = "N" OR B$ = "n" THEN 180 ELSE GOTO 1060
1010 FOR jj = KFK TO KEK
1020 X00(jj) = 0
1030 X0(jj) = 0
1040 NEXT jj
1050 GOTO 970
1060 IF c <> 0 THEN 1260
1070 FOR i = 1 TO N
1080 IF X0(i) = 0 THEN 1230
1090 IF i > I1 THEN QS1 = 0: GOTO 1130
1100 QS1 = Q1 - MK - ABS(SD) / 2 * (i - 1)
1110 IF X1(i) <> 0 THEN Q1 = (X1(i) - X0(i)) / 2 + Q1 - QS1
1120 IF QK1 - QS1 < H THEN CX(i) = X0(i) + H: CY(i) = H: DX(i) = X0(i) + Q2 - QS2: DY(i) = Q2 - QS2: GOTO 1230
1130 IF I2 > i THEN 1170
1140 QS2 = ABS(SD) / 2 * (i - I2 + 1)
1150 IF X1(i) <> 0 THEN Q2 = (X0(i) - X1(i)) / 2 + Q2 - QS2
1160 IF QK2 - QS2 < H THEN AX(i) = X0(i) - H: AY(i) = H: BX(i) = X0(i) - Q1 + QS1: BY(i) = Q1 - QS1: GOTO 1230
1170 IF X1(i) = 0 THEN AX(i) = X0(i) - H: AY(i) = H: BX(i) = X0(i) - Q1 + QS1: BY(i) = Q1 - QS1: CX(i) = X0(i) + H: CY(i) = H: DX(i) = X0(i) + Q2 - QS2: DY(i) = Q2 - QS2: GOTO 1230
1180 IF X1(i) - H <= X0(i) AND X0(i) <= X1(i) + H THEN A1X(i) = X1(i) - H: A1Y(i) = X0(i) - X1(i) + H: B1X(i) = X1(i) - Q1: B1Y(i) = X0(i) - X1(i) + Q1: C1X(i) = X1(i) + H: C1Y(i) = X1(i) - X0(i) + H: D1X(i) = X1(i) + Q2: D1Y(i) = X1(i) - X0(i) + Q2 _
: GOTO 1230
1190 IF X0(i) <= X1(i) - Q1 THEN A1X(i) = X1(i) - Q1: A1Y(i) = X1(i) - Q1 - X0(i): B1X(i) = X1(i) - H: B1Y(i) = X1(i) - X0(i) - H: C1X(i) = X1(i) + H: C1Y(i) = X1(i) - X0(i) + H: D1X(i) = X1(i) + Q2: D1Y(i) = X1(i) + Q2 - X0(i): GOTO 1230
1200 IF X0(i) >= X1(i) + Q2 THEN A1X(i) = X1(i) - H: A1Y(i) = X0(i) - X1(i) + H: B1X(i) = X1(i) - Q1: B1Y(i) = X0(i) - X1(i) + Q1: C1X(i) = X1(i) + H: C1Y(i) = X0(i) - X1(i) - H: D1X(i) = X1(i) + Q2: D1Y(i) = X0(i) - X1(i) - Q2: GOTO 1230
1210 IF X1(i) - Q1 <= X0(i) AND X0(i) <= X1(i) - H THEN A1X(i) = X0(i): A1Y(i) = 0: B1X(i) = X1(i) - Q1: B1Y(i) = X0(i) - X1(i) + Q1: C1X(i) = X1(i) + H: C1Y(i) = X1(i) + H - X0(i): D1X(i) = X1(i) + Q2: D1Y(i) = X1(i) + Q2 - X0(i): B11X(i) = X1(i) - _
 H: B11Y(i) = X1(i) - H - X0(i): GOTO 1230
1220 IF X1(i) + H <= X0(i) AND X0(i) <= X1(i) + Q2 THEN A1X(i) = X0(i): A1Y(i) = 0: B1X(i) = X1(i) + H: B1Y(i) = X0(i) - X1(i) - H: C1X(i) = X1(i) - H: C1Y(i) = X0(i) - X1(i) + H: D1X(i) = X1(i) - Q1: D1Y(i) = X0(i) - X1(i) + Q1: B11X(i) = X1(i) +  _
Q2: B11Y(i) = X1(i) - X0(i) + Q2
1230 Q1 = QK1: Q2 = QK2
1240 NEXT i
1250 GOTO 1400
1260 FOR i = 1 TO N
1270 IF i > I1 THEN QS1 = 0 ELSE QS1 = Q - MK - ABS(SD) / 2 * (i - 1): IF X1(i) <> 0 THEN Q = (X1(i) - X0(i)) / 2 + Q - QS1
1280 IF I2 <= i THEN QS2 = ABS(SD) / 2 * (i - I2 + 1): IF X1(i) <> 0 THEN Q = (X0(i) - X1(i)) / 2 + Q - QS2
1290 IF X0(i) = 0 THEN 1380
1300 IF X1(i) = 0 THEN IF c = 1 THEN AX(i) = H + X0(i): AY(i) = H: BX(i) = X0(i) + Q - QS2: BY(i) = Q - QS2: GOTO 1380 ELSE AX(i) = X0(i) - H: AY(i) = H: BX(i) = X0(i) - Q + QS1: BY(i) = Q - QS1: GOTO 1380
1310 IF c = -1 THEN GOTO 1350
1320 IF H + X1(i) <= X0(i) AND X0(i) <= X1(i) + Q THEN A1X(i) = X0(i): A1Y(i) = 0: B1X(i) = H + X1(i): B1Y(i) = X0(i) - X1(i) - H: B11X(i) = X1(i) + Q: B11Y(i) = X1(i) - X0(i) + Q: GOTO 1380
1330 IF X0(i) >= X1(i) + Q THEN A1X(i) = X1(i) + Q: A1Y(i) = X0(i) - X1(i) - Q: B1X(i) = X1(i) + H: B1Y(i) = X0(i) - X1(i) - H: GOTO 1380
1340 A1X(i) = X1(i) + H: A1Y(i) = X1(i) + H - X0(i): B1X(i) = X1(i) + Q: B1Y(i) = X1(i) + Q - X0(i): GOTO 1380
1350 IF X1(i) - Q <= X0(i) AND X0(i) <= X1(i) - H THEN A1X(i) = X0(i): A1Y(i) = 0: B1X(i) = X1(i) - Q: B1Y(i) = X0(i) - X1(i) + Q: B11X(i) = X1(i) - H: B11Y(i) = X1(i) - X0(i) - H: GOTO 1380
1360 IF X0(i) <= X1(i) - Q THEN A1X(i) = X1(i) - Q: A1Y(i) = X1(i) - Q - X0(i): B1X(i) = X1(i) - H: B1Y(i) = X1(i) - H - X0(i): GOTO 1380
1370 A1X(i) = X1(i) - H: A1Y(i) = X0(i) - X1(i) + H: B1X(i) = X1(i) - Q: B1Y(i) = X0(i) - X1(i) + Q
1380 Q = QKQ
1390 NEXT i
1400 IF X00(N) = 0 THEN X0(N) = X0(1) + (N - 1) * ABS(SD): X00(N) = X00(1) + (N - 1) * SD / 1000 * B / 1000
1410 IF D = 0 THEN 1530
1420 XQ = DX(N) - X0(N): IF c = 1 THEN XQ = Q ELSE IF c = -1 THEN XQ = X0(1) * (-5) / 6
1430 XMAX = X0(N) + XQ + X0(1)
1440 FOR i = 1 TO N
1450 IF X0(i) = 0 THEN 1520
1460 X0(i) = XMAX - X0(i): IF X1(i) <> 0 THEN X1(i) = XMAX - X1(i)
1470 IF X2(i) <> 0 THEN X2(i) = XMAX - X2(i)
1480 IF X3(i) <> 0 THEN X3(i) = XMAX - X3(i)
1490 AX(i) = XMAX - AX(i): BX(i) = XMAX - BX(i): CX(i) = XMAX - CX(i): DX(i) = XMAX - DX(i)
1500 IF X1(i) <> 0 THEN A1X(i) = XMAX - A1X(i): B1X(i) = XMAX - B1X(i): C1X(i) = XMAX - C1X(i): D1X(i) = XMAX - D1X(i)
1510 IF B11X(i) <> 0 THEN B11X(i) = XMAX - B11X(i)
1520 NEXT i
1530 B$(1) = "H(m)": B$(2) = "WD(m)": B$(3) = "T(ms)": D$ = "scale 1:10000": E$ = "t value scale 1mm=1ms": R$ = "elevation scale 1mm=1m": S$ = "well depth scale 1mm=1m"
1540
LINE (195, 145)-(505, 335), 1, BF
LINE (195, 145)-(505, 335), 8, B
box 200, 150, 500, 330, 1, 3
LOCATE 12, 30: printhz "文件名：", 200, 500, 6: INPUT "", A$: F$ = A$ + ".dxf"
1550 LOCATE 14, 30: printhz "τ值上限（毫秒）：", 200, 500, 6: INPUT "", L1' L1=(ms)
1560 LOCATE 16, 30: printhz "观测系统下面三线所占宽度：", 200, 500, 6: INPUT "", L2' L2=(mm)
1570 LOCATE 18, 30: printhz "井口高程基值：", 200, 500, 6: INPUT "", H0' H0=(m)
1580 OPEN F$ FOR OUTPUT AS #1
1590 PRINT #1, "  0"
1600 PRINT #1, "SECTION"
1610 PRINT #1, "  2"
1620 PRINT #1, "TABLES"
1630 PRINT #1, "  0"
1640 PRINT #1, "TABLE"
1650 PRINT #1, "  2"
1660 PRINT #1, "LTYPE"
1670 PRINT #1, " 70"
1680 PRINT #1, "   3"
1690 PRINT #1, "  0"
1700 PRINT #1, "LTYPE"
1710 PRINT #1, "  2"
1720 PRINT #1, "CONTINUOUS"
1730 PRINT #1, " 70"
1740 PRINT #1, "    64"
1750 PRINT #1, "  3"
1760 PRINT #1, "SOLID LINE"
1770 PRINT #1, " 72"
1780 PRINT #1, "   65"
1790 PRINT #1, " 73"
1800 PRINT #1, "    0"
1810 PRINT #1, " 40"
1820 PRINT #1, "0.0"
1830 PRINT #1, "  0"
1840 PRINT #1, "LTYPE"
1850 PRINT #1, "  2"
1860 PRINT #1, "HIDDEN"
1870 PRINT #1, " 70"
1880 PRINT #1, "    64"
1890 PRINT #1, " 3"
1900 PRINT #1, "- - - -"
1910 PRINT #1, " 72"
1920 PRINT #1, "    65"
1930 PRINT #1, " 73"
1940 PRINT #1, "    4"
1950 PRINT #1, " 40"
1960 PRINT #1, " 20"
1970 PRINT #1, " 49"
1980 PRINT #1, " 5"
1990 PRINT #1, " 49"
2000 PRINT #1, " -5"
2010 PRINT #1, " 49"
2020 PRINT #1, " 5"
2030 PRINT #1, " 49"
2040 PRINT #1, " -5"
2050 PRINT #1, "  0"
2060 PRINT #1, "LTYPE"
2070 PRINT #1, "  2"
2080 PRINT #1, "DASHDOT"
2090 PRINT #1, " 70"
2100 PRINT #1, "   64"
2110 PRINT #1, "  3"
2120 PRINT #1, "_._._."
2130 PRINT #1, " 72"
2140 PRINT #1, "   65"
2150 PRINT #1, " 73"
2160 PRINT #1, "   4"
2170 PRINT #1, " 40"
2180 PRINT #1, " 10"
2190 PRINT #1, " 49"
2200 PRINT #1, " 5"
2210 PRINT #1, " 49"
2220 PRINT #1, " -2.5"
2230 PRINT #1, " 49"
2240 PRINT #1, " 0.0"
2250 PRINT #1, " 49"
2260 PRINT #1, " -2.5"
2270 PRINT #1, "  0"
2280 PRINT #1, "ENDTAB"
2290 PRINT #1, "  0"
2300 PRINT #1, "TABLE"
2310 PRINT #1, "  2"
2320 PRINT #1, "LAYER"
2330 PRINT #1, " 70"
2340 PRINT #1, "     3"
2350 PRINT #1, "  0"
2360 PRINT #1, "LAYER"
2370 PRINT #1, "  2"
2380 PRINT #1, "0"
2390 PRINT #1, " 70"
2400 PRINT #1, "    64"
2410 PRINT #1, " 62"
2420 PRINT #1, "     7"
2430 PRINT #1, " 6"
2440 PRINT #1, "CONTINUOUS"
2450 PRINT #1, "  0"
2460 PRINT #1, "LAYER"
2470 PRINT #1, "  2"
2480 PRINT #1, "1"
2490 PRINT #1, " 70"
2500 PRINT #1, "    64"
2510 PRINT #1, " 62"
2520 PRINT #1, "     3"
2530 PRINT #1, " 6"
2540 PRINT #1, "HIDDEN"
2550 PRINT #1, "  0"
2560 PRINT #1, "LAYER"
2570 PRINT #1, "  2"
2580 PRINT #1, "2"
2590 PRINT #1, " 70"
2600 PRINT #1, "    64"
2610 PRINT #1, " 62"
2620 PRINT #1, "     1"
2630 PRINT #1, " 6"
2640 PRINT #1, "DASHDOT"
2650 PRINT #1, "  0"
2660 PRINT #1, "ENDTAB"
2670 PRINT #1, "  0"
2680 PRINT #1, "ENDSEC"
2690 PRINT #1, "  0"
2700 PRINT #1, "SECTION"
2710 PRINT #1, "  2"
2720 PRINT #1, "ENTITIES"
2730 FOR i = 1 TO N
2740 IF X1(i) <> 0 THEN 3110
2750 PRINT #1, "  0"
2760 PRINT #1, "LINE"
2770 PRINT #1, "  8"
2780 IF X3(i) <> 0 THEN 2790 ELSE IF X2(i) <> 0 THEN 2810 ELSE 2830
2790 PRINT #1, "1"
2800 GOTO 2840
2810 PRINT #1, "2"
2820 GOTO 2840
2830 PRINT #1, "0"
2840 PRINT #1, " 10"
2850 PRINT #1, AX(i) - SS
2860 PRINT #1, " 20"
2870 PRINT #1, AY(i) + L2 + 50
2880 PRINT #1, " 11"
2890 PRINT #1, BX(i) - SS
2900 PRINT #1, " 21"
2910 PRINT #1, BY(i) + L2 + 50
2920 IF c <> 0 THEN 3110
2930 PRINT #1, "  0"
2940 PRINT #1, "LINE"
2950 PRINT #1, "  8"
2960 IF X3(i) <> 0 THEN 2970 ELSE IF X2(i) <> 0 THEN 2990 ELSE 3010
2970 PRINT #1, "1"
2980 GOTO 3020
2990 PRINT #1, "2"
3000 GOTO 3020
3010 PRINT #1, "0"
3020 PRINT #1, " 10"
3030 PRINT #1, CX(i)
3040 PRINT #1, " 20"
3050 PRINT #1, CY(i) + L2 + 50
3060 PRINT #1, " 11"
3070 PRINT #1, DX(i)
3080 PRINT #1, " 21"
3090 PRINT #1, DY(i) + L2 + 50
3100 GOTO 3640
3110 PRINT #1, "  0"
3120 PRINT #1, "LINE"
3130 PRINT #1, "  8"
3140 IF X3(i) <> 0 THEN 3150 ELSE IF X2(i) <> 0 THEN 3170 ELSE 3190
3150 PRINT #1, "1"
3160 GOTO 3200
3170 PRINT #1, "2"
3180 GOTO 3200
3190 PRINT #1, "0"
3200 PRINT #1, " 10"
3210 PRINT #1, A1X(i) - SS
3220 PRINT #1, " 20"
3230 PRINT #1, A1Y(i) + L2 + 50
3240 PRINT #1, " 11"
3250 PRINT #1, B1X(i) - SS
3260 PRINT #1, " 21"
3270 PRINT #1, B1Y(i) + L2 + 50
3280 IF c <> 0 THEN GOTO 3460
3290 PRINT #1, "  0"
3300 PRINT #1, "LINE"
3310 PRINT #1, "  8"
3320 IF X3(i) <> 0 THEN 3330 ELSE IF X2(i) <> 0 THEN 3350 ELSE 3370
3330 PRINT #1, "1"
3340 GOTO 3380
3350 PRINT #1, "2"
3360 GOTO 3380
3370 PRINT #1, "0"
3380 PRINT #1, " 10"
3390 PRINT #1, C1X(i)
3400 PRINT #1, " 20"
3410 PRINT #1, C1Y(i) + L2 + 50
3420 PRINT #1, " 11"
3430 PRINT #1, D1X(i)
3440 PRINT #1, " 21"
3450 PRINT #1, D1Y(i) + L2 + 50
3460 IF B11X(i) = 0 AND B11Y(i) = 0 THEN 3640
3470 PRINT #1, "  0"
3480 PRINT #1, "LINE"
3490 PRINT #1, "  8"
3500 IF X3(i) <> 0 THEN 3510 ELSE IF X2(i) <> 0 THEN 3530 ELSE 3550
3510 PRINT #1, "1"
3520 GOTO 3560
3530 PRINT #1, "2"
3540 GOTO 3560
3550 PRINT #1, "0"
3560 PRINT #1, " 10"
3570 PRINT #1, A1X(i) - SS
3580 PRINT #1, " 20"
3590 PRINT #1, A1Y(i) + L2 + 50
3600 PRINT #1, " 11"
3610 PRINT #1, B11X(i) - SS
3620 PRINT #1, " 21"
3630 PRINT #1, B11Y(i) + L2 + 50
3640 NEXT i
3650 IF D = 1 THEN X0(N) = X0(N) + (N - 1) * ABS(SD): X00(N) = X00(1) + (N - 1) * SD / 1000 * B / 1000
3660 PRINT #1, "  0"
3670 PRINT #1, "LINE"
3680 PRINT #1, "  8"
3690 PRINT #1, "0"
3700 PRINT #1, " 10"
3710 PRINT #1, 0
3720 PRINT #1, " 20"
3730 PRINT #1, L2 + 50
3740 PRINT #1, " 11"
3750 PRINT #1, X0(N) - SS
3760 PRINT #1, " 21"
3770 PRINT #1, L2 + 50
3780 PRINT #1, "  0"
3790 PRINT #1, "LINE"
3800 PRINT #1, "  8"
3810 PRINT #1, "0"
3820 PRINT #1, "  10"
3830 PRINT #1, 0
3840 PRINT #1, " 20"
3850 PRINT #1, 50
3860 PRINT #1, " 11"
3870 PRINT #1, X0(N) - SS
3880 PRINT #1, " 21"
3890 PRINT #1, 50
3900 PRINT #1, "  0"
3910 PRINT #1, "LINE"
3920 PRINT #1, "  8"
3930 PRINT #1, "0"
3940 PRINT #1, "  10"
3950 PRINT #1, 0
3960 PRINT #1, " 20"
3970 PRINT #1, L1 + 50
3980 PRINT #1, " 11"
3990 PRINT #1, X0(N) - SS
4000 PRINT #1, " 21"
4010 PRINT #1, L1 + 50
4020 PRINT #1, "  0"
4030 PRINT #1, "LINE"
4040 PRINT #1, "  8"
4050 PRINT #1, "0"
4060 PRINT #1, "  10"
4070 PRINT #1, 0
4080 PRINT #1, " 20"
4090 PRINT #1, 50
4100 PRINT #1, " 11"
4110 PRINT #1, 0
4120 PRINT #1, " 21"
4130 PRINT #1, 360
4140 FOR i = 1 TO N - 2 STEP 2
4150 MP = (i - 1) / 4 - INT((i - 1) / 4)
4160 IF X0(i) = 0 THEN 4620
4170 PRINT #1, "  0"
4180 PRINT #1, "TEXT"
4190 PRINT #1, "  8"
4200 PRINT #1, "0"
4210 PRINT #1, " 10"
4220 PRINT #1, X0(i) - 2 - SS
4230 PRINT #1, " 20"
4240 PRINT #1, L2 + 40
4250 PRINT #1, " 40"
4260 PRINT #1, 3
4270 PRINT #1, " 41"
4280 PRINT #1, .5
4290 PRINT #1, " 50"
4300 PRINT #1, 0
4310 PRINT #1, " 1"
4320 PRINT #1, i
4330 PRINT #1, "  0"
4340 PRINT #1, "LINE"
4350 PRINT #1, "  8"
4360 PRINT #1, "0"
4370 PRINT #1, " 10"
4380 PRINT #1, X0(i) - SS
4390 PRINT #1, " 20"
4400 PRINT #1, 150
4410 PRINT #1, " 11"
4420 PRINT #1, X0(i) - SS
4430 PRINT #1, " 21"
4440 PRINT #1, 153
4450 IF MP <> 0 THEN 4620
4460 PRINT #1, "  0"
4470 PRINT #1, "TEXT"
4480 PRINT #1, "  8"
4490 PRINT #1, "0"
4500 PRINT #1, " 10"
4510 PRINT #1, X0(i) - 1 - SS
4520 PRINT #1, " 20"
4530 PRINT #1, L2 + 45
4540 PRINT #1, " 40"
4550 PRINT #1, 3
4560 PRINT #1, " 41"
4570 PRINT #1, .5
4580 PRINT #1, " 50"
4590 PRINT #1, 0
4600 PRINT #1, " 1"
4610 PRINT #1, X00(i)
4620 NEXT i
4630 Z11(1) = 95: Z11(2) = L1 + 35: Z11(3) = 3
4640 FOR i = 1 TO 3
4650 PRINT #1, "  0"
4660 PRINT #1, "TEXT"
4670 PRINT #1, "  8"
4680 PRINT #1, "0"
4690 PRINT #1, " 10"
4700 PRINT #1, -15
4710 PRINT #1, " 20"
4720 PRINT #1, Z11(i) + 50
4730 PRINT #1, " 40"
4740 PRINT #1, 3
4750 PRINT #1, " 41"
4760 PRINT #1, .8
4770 PRINT #1, " 50"
4780 PRINT #1, 0
4790 PRINT #1, " 1"
4800 PRINT #1, B$(i)
4810 NEXT i
4820 FOR J = 1 TO 25
4830 PRINT #1, "  0"
4840 PRINT #1, "LINE"
4850 PRINT #1, "  8"
4860 PRINT #1, "0"
4870 PRINT #1, " 10"
4880 PRINT #1, 0
4890 PRINT #1, " 20"
4900 PRINT #1, J * 10 + 50
4910 PRINT #1, " 11"
4920 PRINT #1, 1.5
4930 PRINT #1, " 21"
4940 PRINT #1, J * 10 + 50
4950 NEXT J
4960 MN(1) = -1.5: MN(2) = 1.5: Z(1) = 100: Z(2) = L1 + 40
4970 FOR J = 1 TO 2
4980 FOR i = 1 TO 2
4990 PRINT #1, "  0"
5000 PRINT #1, "LINE"
5010 PRINT #1, "  8"
5020 PRINT #1, "0"
5030 PRINT #1, " 10"
5040 PRINT #1, 0
5050 PRINT #1, " 20"
5060 PRINT #1, Z(J) + 50
5070 PRINT #1, " 11"
5080 PRINT #1, MN(i)
5090 PRINT #1, " 21"
5100 PRINT #1, Z(J) + 47
5110 NEXT i
5120 NEXT J
5130 FOR J = 1 TO 2
5140 PRINT #1, "  0"
5150 PRINT #1, "LINE"
5160 PRINT #1, "  8"
5170 PRINT #1, "0"
5180 PRINT #1, " 10"
5190 PRINT #1, 0
5200 PRINT #1, " 20"
5210 PRINT #1, 50
5220 PRINT #1, " 11"
5230 PRINT #1, MN(J)
5240 PRINT #1, " 21"
5250 PRINT #1, 53
5260 NEXT J
5270 FOR i = 1 TO 2
5280 PRINT #1, "  0"
5290 PRINT #1, "LINE"
5300 PRINT #1, "  8"
5310 PRINT #1, "0"
5320 PRINT #1, " 10"
5330 PRINT #1, X0(N) - SS
5340 PRINT #1, " 20"
5350 PRINT #1, L1 + 50
5360 PRINT #1, " 11"
5370 PRINT #1, X0(N) - 3 - SS
5380 PRINT #1, " 21"
5390 PRINT #1, L1 + MN(i) + 50
5400 NEXT i
5410 OPEN KK$ + ":" + "kkk.dat" FOR INPUT AS #3: INPUT #3, K: CLOSE #3
5420 OPEN KK$ + ":" + "thw.dat" FOR INPUT AS #2
5430 FOR i = 1 TO K - 1
5440 INPUT #2, XU(i), T(i), HI(i), WD(i)
5450 NEXT i
5460 CLOSE #2
5470 FOR i = 1 TO K - 2
5480 IF FW(i) - INT(FW(i)) = 0 THEN 5890
5490 IF X0(i) = 0 OR X0(i + 1) = 0 THEN 5890
5500 IF ABS(X0(i + 1) - X0(i)) > ABS(SD) * 1.5 THEN 5890
5510 IF T(i) = 0 OR T(i + 1) = 0 THEN 5760
5520 PRINT #1, "  0"
5530 PRINT #1, "LINE"
5540 PRINT #1, "  8"
5550 PRINT #1, "0"
5560 PRINT #1, " 10"
5570 PRINT #1, X0(i) - SS
5580 PRINT #1, " 20"
5590 PRINT #1, L1 - T(i) + 50
5600 PRINT #1, " 11"
5610 PRINT #1, X0(i + 1) - SS
5620 PRINT #1, " 21"
5630 PRINT #1, L1 - T(i + 1) + 50
5640 PRINT #1, "  0"
5650 PRINT #1, "LINE"
5660 PRINT #1, "  8"
5670 PRINT #1, "0"
5680 PRINT #1, " 10"
5690 PRINT #1, X0(i) - SS
5700 PRINT #1, " 20"
5710 PRINT #1, L1 + HI(i) - H0 - WD(i) + 50
5720 PRINT #1, " 11"
5730 PRINT #1, X0(i + 1) - SS
5740 PRINT #1, " 21"
5750 PRINT #1, L1 + HI(i + 1) - H0 - WD(i + 1) + 50
5760 IF HI(i) = 0 OR HI(i + 1) = 0 THEN 5890
5770 PRINT #1, "  0"
5780 PRINT #1, "LINE"
5790 PRINT #1, "  8"
5800 PRINT #1, "0"
5810 PRINT #1, " 10"
5820 PRINT #1, X0(i) - SS
5830 PRINT #1, " 20"
5840 PRINT #1, L1 + HI(i) - H0 + 50
5850 PRINT #1, " 11"
5860 PRINT #1, X0(i + 1) - SS
5870 PRINT #1, " 21"
5880 PRINT #1, L1 + HI(i + 1) - H0 + 50
5890 NEXT i
5900 FOR i = 10 TO L1 - 10 STEP 10
5910 PRINT #1, "  0"
5920 PRINT #1, "TEXT"
5930 PRINT #1, "  8"
5940 PRINT #1, "0"
5950 PRINT #1, " 10"
5960 PRINT #1, -8
5970 PRINT #1, " 20"
5980 PRINT #1, L1 - i + 48
5990 PRINT #1, " 40"
6000 PRINT #1, 3
6010 PRINT #1, " 41"
6020 PRINT #1, .5
6030 PRINT #1, " 50"
6040 PRINT #1, 0
6050 PRINT #1, " 1"
6060 PRINT #1, i
6070 NEXT i
6080 FOR i = 10 TO L2 - L1 - 10 STEP 10
6090 PRINT #1, "  0"
6100 PRINT #1, "TEXT"
6110 PRINT #1, "  8"
6120 PRINT #1, "0"
6130 PRINT #1, " 10"
6140 PRINT #1, -8
6150 PRINT #1, " 20"
6160 PRINT #1, L1 + i + 48.5
6170 PRINT #1, " 40"
6180 PRINT #1, 3
6190 PRINT #1, " 41"
6200 PRINT #1, .5
6210 PRINT #1, " 50"
6220 PRINT #1, 0
6230 PRINT #1, " 1"
6240 PRINT #1, H0 + i
6250 NEXT i
6260 A$(1) = "   area   line swath layout draw": A$(2) = "scale:   1:10000"
6270 A$(6) = "begin-end station:": A$(7) = "begin-end shot number:": A$(8) = "shot absented number:": A$(9) = "useless shot number:": A$(10) = "party number:": A$(11) = "date:"
6280 A$(12) = "drawed by:": A$(13) = "checked by:": A$(14) = "remarks:": A$(15) = "shot absented :blue hidden": A$(16) = "useless shot :red dashdot": A$(17) = "(km)"
6290 FOR i = 1 TO 16
6300 PRINT #1, "  0"
6310 PRINT #1, "TEXT"
6320 PRINT #1, "  8"
6330 PRINT #1, "0"
6340 PRINT #1, " 10"
6350 PRINT #1, -80
6360 PRINT #1, " 20"
6370 PRINT #1, 300 - (i - 1) * 15
6380 PRINT #1, " 40"
6390 PRINT #1, 3
6400 PRINT #1, " 41"
6410 PRINT #1, .8
6420 PRINT #1, " 50"
6430 PRINT #1, 0
6440 PRINT #1, " 1"
6450 PRINT #1, A$(i)
6460 NEXT i
6470 KKM = INT(ABS(X00(N) - X00(1)) + Q / 100 - SS)
6480 IF c = -1 AND D = 1 THEN KKM = KKM - 1
6490 FOR i = 1 TO KKM
6500 PRINT #1, "  0"
6510 PRINT #1, "LINE"
6520 PRINT #1, "  8"
6530 PRINT #1, "0"
6540 PRINT #1, " 10"
6550 PRINT #1, 100 * i
6560 PRINT #1, " 20"
6570 PRINT #1, L1 + 50
6580 PRINT #1, " 11"
6590 PRINT #1, 100 * i
6600 PRINT #1, " 21"
6610 PRINT #1, L1 + 52.5
6620 PRINT #1, "  0"
6630 PRINT #1, "TEXT"
6640 PRINT #1, "  8"
6650 PRINT #1, "0"
6660 PRINT #1, " 10"
6670 PRINT #1, 100 * i - 1
6680 PRINT #1, " 20"
6690 PRINT #1, L1 + 57.5
6700 PRINT #1, " 40"
6710 PRINT #1, 3
6720 PRINT #1, " 41"
6730 PRINT #1, .5
6740 PRINT #1, " 50"
6750 PRINT #1, 0
6760 PRINT #1, " 1"
6770 PRINT #1, i
6780 NEXT i
6790 PRINT #1, "  0"
6800 PRINT #1, "TEXT"
6810 PRINT #1, "  8"
6820 PRINT #1, "0"
6830 PRINT #1, " 10"
6840 PRINT #1, X0(N) - SS
6850 PRINT #1, " 20"
6860 PRINT #1, L1 + 47
6870 PRINT #1, " 40"
6880 PRINT #1, 3
6890 PRINT #1, " 41"
6900 PRINT #1, .8
6910 PRINT #1, " 50"
6920 PRINT #1, 0
6930 PRINT #1, " 1"
6940 PRINT #1, A$(17)
6950 PRINT #1, "  0"
6960 PRINT #1, "LINE"
6970 PRINT #1, "  8"
6980 PRINT #1, "0"
6990 PRINT #1, " 10"
7000 PRINT #1, 0
7010 PRINT #1, " 20"
7020 PRINT #1, L2 + 35
7030 PRINT #1, " 11"
7040 PRINT #1, X0(N) - SS
7050 PRINT #1, " 21"
7060 PRINT #1, L2 + 35
7070 OPEN KK$ + ":" + "GG.DAT" FOR INPUT AS #8: INPUT #8, IG: CLOSE #8
7080 OPEN KK$ + ":" + "PP.DAT" FOR INPUT AS #6
7090 FOR i = 0 TO IG - 1
7100 INPUT #6, gr(i), FF$(i)
7110 PRINT #1, "  0"
7120 PRINT #1, "LINE"
7130 PRINT #1, "  8"
7140 PRINT #1, "0"
7150 PRINT #1, " 10"
7160 PRINT #1, X0(gr(i)) - SS
7170 PRINT #1, " 20"
7180 PRINT #1, L2 + 35
7190 PRINT #1, " 11"
7200 PRINT #1, X0(gr(i)) - SS
7210 PRINT #1, " 21"
7220 PRINT #1, L2 + 40
7230 PRINT #1, "  0"
7240 PRINT #1, "TEXT"
7250 PRINT #1, "  8"
7260 PRINT #1, "0"
7270 PRINT #1, " 10"
7280 PRINT #1, X0(gr(i)) + 3 - SS
7290 PRINT #1, " 20"
7300 PRINT #1, L2 + 38
7310 PRINT #1, " 40"
7320 PRINT #1, 3
7330 PRINT #1, " 41"
7340 PRINT #1, .8
7350 PRINT #1, " 50"
7360 PRINT #1, 0
7370 PRINT #1, " 1"
7380 PRINT #1, FF$(i)
7390 NEXT i
7400 CLOSE #6
7410 PRINT #1, "  0"
7420 PRINT #1, "ENDSEC"
7430 PRINT #1, "  0"
7440 PRINT #1, "EOF"
7450 CLOSE #1
7460 BEEP: PLAY "G": PLAY "F": PLAY "E": PLAY "D": 'WIDTH 80: CLS :
LINE (175, 295)-(435, 365), 1, BF
LINE (175, 295)-(435, 365), 8, B
box 180, 300, 430, 360, 1, 3
LOCATE 21, 26: printhz "是否绘另一条线（Ｙ／Ｎ）？", 180, 430, 3: INPUT "", g$
7470 IF g$ = "Y" OR g$ = "y" THEN 2800
7480 SYSTEM
7490 END

