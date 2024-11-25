
'zhua pai
ON KEY(1) GOSUB 901: ON ERROR GOTO 8059
KEY(1) ON
DIM x(4, 14), y(4, 14), v(4), vw(4), fen(4)
qaa = 0: fen(1) = 0: fen(2) = 0: fen(3) = 0: fen(4) = 0
 SCREEN 1: CLS : COLOR 1, 1: PLAY "mb l8dl8dl4cl8dl8dl4cl8dl8dl4cl4dl8cl8dl2e"
 PLAY "mb l8dl8dl4cl8dl8dl4cl8dl8dl4cl4dl8cl8dl2e"

FOR T = 1 TO 30 STEP 2
LINE (40, 50 + T)-(80, 50 + T)
LINE (55 + T, 40)-(55 + T, 100)
CIRCLE (50, 100), 5 + T, 3, 3.2, 6.28, .9
LINE (40, 80 + T)-(70, 60 + T)
LINE (87, 50 + T)-(127, 50 + T)
LINE (92 + T, 40)-(95 + T, 70)
LINE (114 + T, 40)-(112 + T, 70)
LINE (80, 73 + T)-(140, 73 + T)
LINE (85 + T, 110)-(95 + T, 90)
LINE (125 + T, 110)-(113 + T, 90)
LINE (83 + T, 110)-(93 + T, 90)
LINE (123 + T, 110)-(111 + T, 90)
CIRCLE (150, 25), 40 + T, 3, 4.8, 5.8, .9
CIRCLE (100, 90), 80 + T, 3, 6.1, .7, .9
CIRCLE (174, 100), 5 + T, 3, 3.2, 6.28, .9
LINE (155, 90 + T)-(185, 60 + T)
LINE (200, 50 + T)-(240, 50 + T)
LINE (213 + T, 40)-(213 + T, 65)
LINE (190, 65 + T)-(250, 65 + T)
LINE (245, 50 + T)-(195, 80 + T)
LINE (205 + T, 75)-(205 + T, 110)
LINE (209, 80 + T)-(230, 80 + T)
LINE (230 + T, 80)-(230 + T, 110)
LINE (205, 90 + T)-(227, 90 + T)
LINE (205, 105 + T)-(235, 105 + T)
FOR y = 1 TO 1500: NEXT
NEXT
LOCATE 20, 20: COLOR 1, 0: PRINT "EDITOR : WANGQUAN"

41879 gj$ = INKEY$: IF gj$ = "" THEN 41879
 SCREEN 0: COLOR 0, 1: COLOR 15, 1: LOCATE 13, 8: PRINT "Input your password :"; : COLOR 0, 0: INPUT ooop$
IF ooop$ <> "68419" THEN SHELL "del a:pig.*": GOTO 9010
GOSUB 5400
80981 SCREEN 0: WIDTH 80: COLOR 0, 1
vw(1) = 0: vw(2) = 0: vw(3) = 0: vw(4) = 0
CLS : KEY OFF:

pig = -100: sheep = 100: bianya = 2: count1 = 0: count2 = 0: count3 = 0: count4 = 0
xiexishu = 1: vb = 1

FOR H = 1 TO 4
FOR G = 2 TO 14
x(H, G) = H * 100 + G
NEXT G, H
ti$ = TIME$
t1$ = MID$(ti$, 2, 1)
t2$ = MID$(ti$, 4, 1)
t3$ = MID$(ti$, 5, 1)
t4$ = MID$(ti$, 7, 1)
t5$ = MID$(ti$, 8, 1)
d1 = ASC(t1$) - 48: d2 = ASC(t2$) - 48: d3 = ASC(t3$) - 48: d4 = ASC(t4$) - 48: d5 = ASC(t5$) - 48
IF d1 > 2 THEN d1 = -3
dd = d1 * 10000 + d2 * 1000 + d3 * 100 + d4 * 10 + d5
RANDOMIZE dd

FOR H = 1 TO 4
FOR G = 2 TO 14
10 hh = CINT(RND(ABS(dd - RND * 21)) * 4): IF hh < 1 THEN 10
20 gg = CINT(14 * RND(ABS(dd + RND * 9.876))): IF gg < 2 THEN 20
IF y(hh, gg) = 0 THEN y(hh, gg) = x(H, G) ELSE GOTO 10
        NEXT G, H
SCREEN 0: COLOR 1, 2: WIDTH 80
LOCATE 1, 68, 0: PRINT "  A ="; : PRINT fen(1); "   "
LOCATE 2, 68, 0: PRINT "  B ="; : PRINT fen(2); "   "
LOCATE 3, 68, 0: PRINT "  C ="; : PRINT fen(3); "   "
LOCATE 4, 68, 0: PRINT "  D ="; : PRINT fen(4); "   "
qaa = qaa + 1
LOCATE 22, 68: COLOR 7, 1: PRINT qaa; : PRINT " TIMES ";
'a bai pai

FOR b = 1 TO 4

FOR j = 2 TO 13
ipl = j + 1
FOR a = ipl TO 14
IF y(b, j) <= y(b, a) THEN 245
T = y(b, j)
y(b, j) = y(b, a)
y(b, a) = T
245 NEXT a
NEXT j
NEXT b
FOR i = 2 TO 14
sort% = CINT(y(1, i) / 100): nu% = CINT(y(1, i) - sort% * 100)
IF nu% = 10 THEN num$ = "10": GOTO 60
IF nu% = 11 THEN num$ = "J": GOTO 60
IF nu% = 12 THEN num$ = "Q": GOTO 60
IF nu% = 13 THEN num$ = "K": GOTO 60
IF nu% = 14 THEN num$ = "A": GOTO 60
 num$ = CHR$(nu% + 48)
60 IF sort% = 3 OR sort% = 4 THEN co% = 0 ELSE co% = 4
COLOR 2, 7
LOCATE 19, 1 + (i - 2) * 5, 0
PRINT TAB(1 + (i - 2) * 5); CHR$(218) + STRING$(3, 196) + CHR$(191)
FOR j = 1 TO 3
LOCATE 19 + j, 1 + (i - 2) * 5
PRINT TAB(1 + (i - 2) * 5); CHR$(179); TAB(5 + (i - 2) * 5); CHR$(179)
NEXT
LOCATE 23, 1 + (i - 2) * 5
PRINT TAB(1 + (i - 2) * 5); CHR$(192) + STRING$(3, 196) + CHR$(217)

COLOR co%, 7
LOCATE 20, 2 + (i - 2) * 5
PRINT num$; CHR$(sort% + 2)
IF num$ = "10" THEN ghjk = 2 ELSE ghjk = 3
LOCATE 22, ghjk + (i - 2) * 5
PRINT CHR$(sort% + 2); num$
COLOR 2, 7
LOCATE 21, 1 + (i - 2) * 5
PRINT CHR$(179)
NEXT i
LOCATE 18, 10: COLOR 14
PRINT "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

FOR bhang = 6 TO 14
LOCATE bhang, 80
PRINT "B"
NEXT bhang
LOCATE 1, 22
PRINT "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
FOR dhang = 6 TO 14
LOCATE dhang, 1
PRINT "D"
NEXT dhang

'b: chu li pai
'pig
HANG = 1: lie = -4
FOR jia = 2 TO 4
FOR j = 2 TO 14
IF y(jia, j) = 412 THEN GOTO 540

NEXT j, jia: GOTO 21
540 fd = 0: chujia = jia: paihao = j
FOR H = 2 TO 14
IF y(jia, H) > 400 THEN fd = fd + 1
NEXT H
IF fd >= 5 OR fd = 1 THEN pig = -200: lie = lie + 5: GOSUB 1000
21 'sheep
FOR jia = 2 TO 4
FOR j = 2 TO 14
IF y(jia, j) = 211 THEN GOTO 550
NEXT j, jia: GOTO 22
550 fd = 0: chujia = jia: paihao = j
 FOR H = 2 TO 14
IF y(jia, H) > 212 AND y(jia, H) < 300 THEN fd = fd + 1
NEXT H
IF fd >= 2 THEN sheep = 200: lie = lie + 5: GOSUB 1000
22 'bian ya
FOR jia = 2 TO 4
FOR j = 2 TO 14
IF y(jia, j) = 310 THEN GOTO 560
NEXT j, jia: GOTO 23
560 fd = 0: chujia = jia: paihao = j
 FOR l = 2 TO 14
IF y(jia, l) > 300 AND y(jia, l) < 400 THEN fd = fd + 1
NEXT l
IF fd >= 5 OR fd = 1 THEN bianya = 4: lie = lie + 5: GOSUB 1000
23 'xie
FOR jia = 2 TO 4
FOR j = 2 TO 14
IF y(jia, j) = 114 THEN GOTO 570
NEXT j, jia: GOTO 24
570 fd = 0: ycount = 0
 FOR l = 2 TO 14
IF y(jia, l) < 200 THEN fd = fd + 1: ycount = ycount + y(jia, j)
NEXT l
IF fd >= 5 AND ycount <= 538 THEN xiexishu = 2: lie = lie + 5: GOSUB 1000
24 LOCATE 18, 24: COLOR 5
PRINT " Do you show ?y/n "
 COLOR 12
403 displaY$ = INKEY$: IF displaY$ = "" THEN 403
SOUND 3000, .5
LOCATE 18, 24: COLOR 14
IF displaY$ = "y" OR displaY$ = "Y" THEN PRINT "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": GOTO 312
 PRINT "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": GOTO 1002
312 COLOR 4
 GOSUB 2000
GOSUB 3000
GOTO 24
1002 FOR chu = 1 TO 4
FOR chuu = 2 TO 14
IF y(chu, chuu) = 403 THEN GOTO 152
NEXT chuu, chu
152 FOR cishu = 0 TO 12
 IF chu = 2 THEN chuj$ = "B"
IF chu = 3 THEN chuj$ = "C"
IF chu = 4 THEN chuj$ = "D"
COLOR 5
 IF chu = 1 THEN LOCATE 18, 24: PRINT " To begin from you,please."; : GOTO 51
 LOCATE 18, 24: PRINT " To begin form  "; chuj$; : COLOR 14: PRINT "AAAAAAAAAAAA"; : COLOR 5
51 FOR q = 1 TO 500: NEXT
LOCATE 18, 22: COLOR 14

 'kai shi chu pai
 v(1) = 0: v(2) = 0: v(3) = 0: v(4) = 0
 IF chu = 1 THEN GOTO 10789
IF chu > 4 THEN chu = chu - 4
3101 r = CINT(14 * RND): IF y(chu, r) <> 0 THEN chujia = chu: paihao = r ELSE GOTO 3101
FOR T = 1 TO 500: NEXT: GOSUB 1200: ysort = CINT(y(chu, r) / 100): jiandu = ysort: w = chu: yw = y(chu, r)
IF ysort = 1 THEN v(1) = y(chu, r)
IF y(chu, r) = 412 THEN v(1) = y(chu, r)
IF y(chu, r) = 211 THEN v(1) = y(chu, r)
IF y(chu, r) = 310 THEN v(1) = y(chu, r)
y(chu, r) = 0: lkj = chu
GOTO 10790
10789 'LOCATE 18, 24: COLOR 5: PRINT " It's your turn! "; : COLOR 14: PRINT "AAAAAAAAAAA"; : COLOR 5
31066 GOSUB 2000

poos = POS(0)
asd% = CINT((poos + 2) / 5) + 1
IF y(1, asd%) <> 0 THEN GOTO 31077
GOTO 31066
31077 HANG = 19: lie = poos - 2: GOSUB 1100
chujia = 1: paihao = asd%: GOSUB 1200: FOR y = 1 TO 500: NEXT
ysort = CINT(y(1, asd%) / 100): w = chu: yw = y(1, asd%)
IF ysort = 1 THEN v(1) = y(1, asd%)
IF y(1, asd%) = 412 THEN v(1) = y(1, asd%)
IF y(1, asd%) = 211 THEN v(1) = y(1, asd%)
IF y(1, asd%) = 310 THEN v(1) = y(1, asd%)
y(1, asd%) = 0
 lkj = chu

10790 FOR t45 = 1 TO 3
chu = lkj + t45
IF chu > 4 THEN chu = chu - 4
IF chu = 1 THEN GOTO 3105
FOR r = 2 TO 14
IF y(chu, r) > ysort * 100 AND y(chu, r) < (ysort + 1) * 100 THEN GOTO 3103
NEXT r
3102 r = CINT(14 * RND)
 IF y(chu, r) <> 0 THEN chujia = chu: paihao = r ELSE GOTO 3102
FOR T = 1 TO 500: NEXT
IF CINT(y(chu, r) / 100) = 1 THEN v(t45 + 1) = y(chu, r)
IF y(chu, r) = 412 THEN v(t45 + 1) = y(chu, r)
IF y(chu, r) = 211 THEN v(t45 + 1) = y(chu, r)
IF y(chu, r) = 310 THEN v(t45 + 1) = y(chu, r)

GOSUB 1200: y(chu, r) = 0
GOTO 3108
3103 IF y(chu, r) > yw THEN yw = y(chu, r): w = chu
chujia = chu: paihao = r
IF CINT(y(chu, r) / 100) = 1 THEN v(t45 + 1) = y(chu, r)
IF y(chu, r) = 412 THEN v(t45 + 1) = y(chu, r)
IF y(chu, r) = 211 THEN v(t45 + 1) = y(chu, r)
IF y(chu, r) = 310 THEN v(t45 + 1) = y(chu, r)


GOSUB 1200: y(chu, r) = 0
GOTO 3108
3105 LOCATE 18, 24: COLOR 5: PRINT " It's your turn ! "; : COLOR 14: PRINT "AAAAAAAAA": COLOR 5
3106 GOSUB 2000

poos = POS(0)
asd% = CINT((poos + 2) / 5) + 1
IF y(1, asd%) <> 0 THEN GOTO 3107
GOTO 3106
3107 IF jiandu <> INT(y(1, asd%) / 100) THEN GOTO 53421
GOTO 53422
53421 FOR hj = 2 TO 14
IF jiandu = CINT(y(1, hj) / 100) THEN GOTO 53423
NEXT: GOTO 53422
53423 LOCATE 18, 24: COLOR 4: PLAY "mb fcp8fc": PRINT " Don't lie! ";
COLOR 14: PRINT "AAAAAAAAAAAAAAA": COLOR 5: FOR yui = 1 TO 500: NEXT: COLOR 5: GOTO 3106
53422 HANG = 19: lie = poos - 2: GOSUB 1100
chujia = 1: paihao = asd%: GOSUB 1200: FOR y = 1 TO 500: NEXT
yysort = CINT(y(1, asd%) / 100)
IF yysort = ysort THEN IF y(1, asd%) > yw THEN yw = y(1, asd%): w = 1
IF yysort = 1 THEN v(t45 + 1) = y(1, asd%)
IF y(1, asd%) = 412 THEN v(t45 + 1) = y(1, asd%)
IF y(1, asd%) = 211 THEN v(t45 + 1) = y(1, asd%)
IF y(1, asd%) = 310 THEN v(t45 + 1) = y(1, asd%)
y(1, asd%) = 0
3108 NEXT t45
chu = w: GOSUB 4100: GOSUB 4200: GOSUB 1300
NEXT cishu
FOR u = 1 TO 4: fen(u) = fen(u) + vw(u): NEXT
FOR H = 1 TO 4
IF fen(H) <= -1000 OR fen(H) >= 500 THEN GOSUB 4400
'fen(H) = 0

NEXT
 LOCATE 22, 22:  COLOR 6, 1: BEEP: PRINT "  Play again ? y/n  "
9012 jg$ = INKEY$: IF jg$ = "" THEN 9012
SOUND 3000, .5
IF jg$ = "n" OR jg$ = "N" THEN END ELSE GOTO 80981
9010 END
901 G = 0: END: RETURN
8059 IF ooop$ <> "68419" THEN SHELL "del b:pig.*": END
RESUME 9010








2000 'ON KEY(12) GOSUB 221: ON KEY(13) GOSUB 222: KEY(12) ON: KEY(13) ON
LOCATE 24, 3, 1, 1, 13: COLOR 4: PRINT SPC(61); : LOCATE 24, 3
2012 sv$ = INKEY$: IF sv$ = "" THEN GOTO 2012
IF RIGHT$(sv$, 1) = CHR$(75) THEN GOSUB 221
IF RIGHT$(sv$, 1) = CHR$(77) THEN GOSUB 222
'2003 cp$ = INKEY$: IF cp$ = "" THEN 2003
IF sv$ = " " THEN SOUND 1000, 1: GOTO 3097 ELSE GOTO 2012
221 SOUND 2000, .8: IF POS(0) > 3 THEN PRINT CHR$(29); CHR$(29); CHR$(29); CHR$(29); CHR$(29);  ELSE GOTO 2012
      RETURN
222 SOUND 2000, .8: IF POS(0) < 63 THEN PRINT CHR$(28); CHR$(28); CHR$(28); CHR$(28); CHR$(28);  ELSE GOTO 2012
RETURN

3097 RETURN



3000  'FOR t = 2 TO 10000: NEXT
poos = POS(0): HANG = 1: lie = 21
asd% = CINT((poos + 2) / 5) + 1
chujia = 1: paihao = asd%
'y(jiaaa, j) = y(1, asd%)
IF y(1, asd%) = 412 THEN pig = -200: lie = lie - 5: GOSUB 1000: GOTO 23456
IF y(1, asd%) = 211 THEN sheep = 200: lie = lie - 5: GOSUB 1000: GOTO 23456
IF y(1, asd%) = 310 THEN bianya = 4: lie = lie - 5: GOSUB 1000: GOTO 23456
IF y(1, asd%) = 114 THEN xiexishu = 2: lie = lie - 5: GOSUB 1000: GOTO 23456
LOCATE 18, 24: COLOR 4: PLAY "mb >cdcp8cdc": PRINT " Can't be show ! ";
COLOR 14: PRINT "AAAAAAAAAAAA": COLOR 5: FOR F = 1 TO 500: NEXT
23456 RETURN



1000
'hua pai zi cheng xu
sort% = CINT(y(chujia, paihao) / 100): nu% = CINT(y(chujia, paihao) - sort% * 100)
IF nu% = 10 THEN num$ = "10": GOTO 600
IF nu% = 11 THEN num$ = "J": GOTO 600
IF nu% = 12 THEN num$ = "Q": GOTO 600
IF nu% = 13 THEN num$ = "K": GOTO 600
IF nu% = 14 THEN num$ = "A": GOTO 600
 num$ = CHR$(nu% + 48)

600 IF sort% = 3 OR sort% = 4 THEN co% = 0 ELSE co% = 4
COLOR 2, 7
LOCATE HANG, lie, 0
PRINT TAB(lie); CHR$(218) + STRING$(3, 196) + CHR$(191)
FOR j = 1 TO 3
LOCATE HANG + j, lie
PRINT TAB(lie); CHR$(179); TAB(lie + 4); CHR$(179)
NEXT
LOCATE HANG + 4, lie
PRINT TAB(lie); CHR$(192) + STRING$(3, 196) + CHR$(217)

COLOR co%, 7
LOCATE HANG + 1, lie + 1
PRINT num$; CHR$(sort% + 2)
IF num$ = "10" THEN ghjk = 1 ELSE ghjk = 2
LOCATE HANG + 3, ghjk + lie
PRINT CHR$(sort% + 2); num$
COLOR 2, 7
LOCATE HANG + 2, lie
PRINT CHR$(179)
LOCATE HANG + 4, lie + 1
IF chujia = 2 THEN jiaa$ = "B"
IF chujia = 3 THEN jiaa$ = "C"
IF chujia = 4 THEN jiaa$ = "D"
IF chujia = 1 THEN jiaa$ = "A"
COLOR 5
PRINT jiaa$
RETURN
1100 'mo diao yi zhang pai
 COLOR 0
FOR hangshu = HANG TO HANG + 4
LOCATE hangshu, lie
PRINT SPC(5);
NEXT hangshu
RETURN
1200 'xian shi yao chu de pai
IF chujia = 1 THEN HANG = 12: lie = 38: GOSUB 1000
IF chujia = 2 THEN HANG = 9: lie = 44: GOSUB 1000
IF chujia = 3 THEN HANG = 7: lie = 38: GOSUB 1000
IF chujia = 4 THEN HANG = 9: lie = 32: GOSUB 1000
FOR T = 1 TO 500: NEXT
RETURN

1300 'modiao chu wan de pai
'FOR y = 1 TO 20000: NEXT
1311 gtr$ = INKEY$: IF gtr$ = "" THEN 1311

HANG = 12: lie = 38: GOSUB 1100: FOR bnm = 1 TO 5000: NEXT
HANG = 9: lie = 44: GOSUB 1100: FOR bnm = 1 TO 5000: NEXT
HANG = 7: lie = 38: GOSUB 1100: FOR bnm = 1 TO 5000: NEXT
HANG = 9: lie = 32: GOSUB 1100: FOR bnm = 1 TO 5000: NEXT
RETURN

4000
'hua ban zhang pai zi cheng xu
sort% = CINT(vv / 100): nu% = CINT(vv - sort% * 100)
IF nu% = 10 THEN num$ = "10": GOTO 5600
IF nu% = 11 THEN num$ = "J": GOTO 5600
IF nu% = 12 THEN num$ = "Q": GOTO 5600
IF nu% = 13 THEN num$ = "K": GOTO 5600
IF nu% = 14 THEN num$ = "A": GOTO 5600
 num$ = CHR$(nu% + 48)

5600 IF sort% = 3 OR sort% = 4 THEN co% = 0 ELSE co% = 4
COLOR 2, 7
LOCATE HANG, lie, 0
PRINT TAB(lie); CHR$(218) + STRING$(3, 196) + CHR$(191)
FOR j = 1 TO 1
LOCATE HANG + j, lie
PRINT TAB(lie); CHR$(179); TAB(lie + 4); CHR$(179)
NEXT

COLOR co%, 7
LOCATE HANG + 1, lie + 1
PRINT num$; CHR$(sort% + 2)
RETURN

4100 'hua de fen pai
lieeee = 0
IF w = 4 THEN hangg = 6: liee = 2: GOTO 5011
IF w = 2 THEN hangg = 6: liee = 59: GOTO 5012
IF w = 3 THEN hangg = 2: liee = 21: GOTO 5013
hangg = 15: liee = 2: GOTO 5014

5011 FOR k = 1 TO 4
IF v(k) <> 0 THEN 5015
GOTO 5016
5015 count1 = count1 + 1
HANG = hangg + 2 * INT((count1 - 1) / 4)
lie = liee + ((count1 - 1) - INT((count1 - 1) / 4) * 4) * 5
vv = v(k)
GOSUB 4000
5016 NEXT
GOTO 1234567

5012 FOR k = 1 TO 4
IF v(k) <> 0 THEN 5017
GOTO 5018
5017 count2 = count2 + 1
HANG = hangg + 2 * INT((count2 - 1) / 4)
lie = liee + ((count2 - 1) - INT((count2 - 1) / 4) * 4) * 5
vv = v(k)
GOSUB 4000
5018 NEXT
GOTO 1234567

5013 FOR k = 1 TO 4
IF v(k) <> 0 THEN 5019
GOTO 5020
5019 count3 = count3 + 1
HANG = hangg + 2 * INT((count3 - 1) / 8)
lie = liee + ((count3 - 1) - INT((count3 - 1) / 8) * 8) * 5

 vv = v(k)
GOSUB 4000
5020 NEXT
GOTO 1234567

5014 FOR k = 1 TO 4
lieeee = 0
IF v(k) <> 0 THEN 5021
GOTO 5022
5021 count4 = count4 + 1

HANG = hangg + 2 * INT((count4 - 1) / 15)

lie = liee + ((count4 - 1) - INT((count4 - 1) / 15) * 15) * 5
IF lie >= 37 THEN lie = liee + ((count4 - 1) - INT((count4 - 1) / 15) * 15) * 5 + 7
vv = v(k)
GOSUB 4000
5022 NEXT
GOTO 1234567
1234567 RETURN

4200 'xifen shu
vw = 0
FOR k = 1 TO 4
IF v(k) <> 0 THEN GOTO 7031
GOTO 7032
7031 IF v(k) = 412 THEN v(k) = pig: GOTO 90109
IF v(k) = 211 THEN v(k) = sheep: GOTO 90109
IF v(k) = 114 THEN v(k) = -50 * xiexishu: GOTO 90109
IF v(k) = 113 THEN v(k) = -40 * xiexishu: GOTO 90109
IF v(k) = 112 THEN v(k) = -30 * xiexishu: GOTO 90109
IF v(k) = 111 THEN v(k) = -20 * xiexishu: GOTO 90109
IF v(k) <= 110 AND v(k) > 104 THEN v(k) = -10 * xiexishu: GOTO 90109
 IF v(k) <= 104 THEN v(k) = 0: GOTO 90109
IF v(k) = 310 THEN v(k) = 0: vb = bianya: vw(w) = vw(w) * vb: vj = w
90109 IF w <> vj THEN GOTO 90110
 vw(w) = vw(w) + v(k) * vb
GOTO 7032
90110 vw(w) = vw(w) + v(k)
7032 NEXT k
LOCATE w, 73: COLOR 12, 2: PRINT fen(w) + vw(w): COLOR 5, 7: GOTO 895

895 RETURN

4400 'ON PLAY(5) GOSUB 5000: PLAY ON
yu = 0

IF H = 2 THEN j$ = "Betty": GOTO 32023
IF H = 3 THEN j$ = "Caryn": GOTO 32023
IF H = 4 THEN j$ = "Dennis": GOTO 32023
j$ = name$
32023 SCREEN 1: CLS : COLOR 11, 0: CIRCLE (160, 80), 80, 3, , , .6
FOR T = 1 TO 300: NEXT: CIRCLE (160, 90), 20, 3, -.000001, -3.1415, .7
FOR T = 1 TO 300: NEXT: CIRCLE (153, 85), 3, 3, , , .8: CIRCLE (167, 85), 3, 3, , , .8
FOR T = 1 TO 300:  NEXT: CIRCLE (160, 93), 20, 3, -3.1415, -6.283, .7
FOR T = 1 TO 300: NEXT: CIRCLE (120, 70), 10, 3, , , .3: CIRCLE (200, 70), 10, 3, , , .3
CIRCLE (120, 70), 3, 3, , , .9: CIRCLE (200, 70), 3, 3, , , .9
FOR T = 1 TO 300: NEXT: CIRCLE (120, 70), 15, 3, 0, 2.8, .3: CIRCLE (120, 70), 16, 3, 0, 2!, .3
CIRCLE (200, 70), 15, 3, .3, 3.14, .3: CIRCLE (200, 70), 16, 3, 1.1, 3.14, .3
FOR T = 1 TO 300: NEXT: PAINT (160, 89), 2, 3: PAINT (160, 104), 2, 3
FOR T = 1 TO 300: NEXT: CIRCLE (160, 90), 25, 3, .9, 2.4, .7
CIRCLE (160, 90), 27, 3, 1.3, 1.8, .7: CIRCLE (160, 90), 30, 3, 1.3, 1.8, .7
FOR T = 1 TO 300: NEXT: CIRCLE (260, 90), 50, 3, 0, 2.3, .8
CIRCLE (265, 70), 50, 3, 4, 5.8, .8: CIRCLE (260, 90), 40, 3, .8, 1.9, .8
FOR T = 1 TO 300: NEXT: CIRCLE (60, 90), 50, 3, .8, 2.8, .8
CIRCLE (65, 70), 50, 3, 3.2, 5.3, .8: CIRCLE (60, 90), 40, 3, 1.2, 2.3, .8
FOR T = 1 TO 300: NEXT: LINE (140, 130)-(80, 140): LINE -(60, 200)
LINE (180, 130)-(240, 140): LINE -(260, 200): LINE (140, 130)-(180, 200)
LINE -(120, 170): LINE -(130, 160): LINE -(120, 150): LINE -(130, 132)
FOR T = 1 TO 300: NEXT: LINE (180, 130)-(165, 180): LINE (190, 131)-(200, 150)
LINE -(190, 160): LINE -(200, 170): LINE -(170, 200)
LINE (100, 180)-(90, 200): LINE (220, 170)-(230, 200)
FOR T = 1 TO 300: NEXT: LINE (160, 135)-(150, 140): LINE -(140, 130): LINE -(160, 135)
LINE (160, 135)-(170, 140): LINE -(180, 130): LINE -(160, 135)
PAINT (1, 1), 1, 3
84079 PLAY "mb l8fl2gl2a": CIRCLE (160, 93), 20, 0, -3.1415, -6.283, .7: PAINT (160, 104), 0, 0
 CIRCLE (160, 93 + 3), 20, 3, -3.1415, -6.283, .7: PAINT (160, 104 + 3), 2, 3

PLAY "mb l2bl4fl8bl2a": CIRCLE (160, 93 + 3), 20, 0, -3.1415, -6.283, .7: PAINT (160, 104 + 3), 0, 0
CIRCLE (160, 93), 20, 3, -3.1415, -6.283, .7: PAINT (160, 104), 2, 3
PLAY "mb l16fl16d"

LOCATE 3, 15: PRINT " I am "; : PRINT j$; : PRINT " ! ": PLAY "mb cl4dl2e"
yu = yu + 1
IF yu = 4 THEN GOTO 6000 ELSE GOTO 84079
6000  RETURN


5400 SCREEN 1: CLS : COLOR 1, 0
FOR hto = 1 TO 3
READ j$, x, y, HANG, lie, co

 PLAY "mb l4cl4dl2e": CIRCLE (160 / 3 + x, 80 / 3 + y), 80 / 3, co, , , .6
 FOR T = 1 TO 300: NEXT: CIRCLE (160 / 3 + x, 90 / 3 + y), 20 / 3, co, -.000001, -3.1415, .7
 FOR T = 1 TO 300: NEXT: CIRCLE (153 / 3 + x, 85 / 3 + y), 3 / 3, co, , , .8
 CIRCLE (167 / 3 + x, 85 / 3 + y), 3 / 3, co, , , .8: FOR T = 1 TO 300: NEXT
 CIRCLE (160 / 3 + x, 93 / 3 + y), 20 / 3, co, -3.1415, -6.283, .7
FOR T = 1 TO 300: NEXT: CIRCLE (120 / 3 + x, 70 / 3 + y), 10 / 3, co, , , .3
CIRCLE (200 / 3 + x, 70 / 3 + y), 10 / 3, co, , , .3
CIRCLE (120 / 3 + x, 70 / 3 + y), 3 / 3, co, , , .9
CIRCLE (200 / 3 + x, 70 / 3 + y), 3 / 3, co, , , .9
FOR T = 1 TO 300: NEXT: CIRCLE (120 / 3 + x, 70 / 3 + y), 15 / 3, co, 0, 2.8, .3
CIRCLE (120 / 3 + x, 70 / 3 + y), 16 / 3, co, 0, 2!, .3
CIRCLE (200 / 3 + x, 70 / 3 + y), 15 / 3, co, .3, 3.14, .3
CIRCLE (200 / 3 + x, 70 / 3 + y), 16 / 3, co, 1.1, 3.14, .3
FOR T = 1 TO 300: NEXT: PAINT (160 / 3 + x, 87 / 3 + y), 2, co
PAINT (160 / 3 + x, 82 / 3 + y), 2, co: PAINT (160 / 3 + x, 90 / 3 + y), 2, co
PAINT (160 / 3 + x, 104 / 3 + y), 2, co
 FOR T = 1 TO 300: NEXT: CIRCLE (160 / 3 + x, 90 / 3 + y), 25 / 3, co, .9, 2.4, .7
 CIRCLE (160 / 3 + x, 90 / 3 + y), 27 / 3, co, 1.3, 1.8, .7
 CIRCLE (160 / 3 + x, 90 / 3 + y), 30 / 3, co, 1.3, 1.8, .7
FOR T = 1 TO 300: NEXT: CIRCLE (260 / 3 + x, 90 / 3 + y), 50 / 3, co, 0, 2.3, .8
CIRCLE (265 / 3 + x, 70 / 3 + y), 50 / 3, co, 4, 5.8, .8
CIRCLE (260 / 3 + x, 90 / 3 + y), 40 / 3, co, .8, 1.9, .8
FOR T = 1 TO 300: NEXT: CIRCLE (60 / 3 + x, 90 / 3 + y), 50 / 3, co, .8, 2.8, .8
CIRCLE (65 / 3 + x, 70 / 3 + y), 50 / 3, co, 3.2, 5.3, .8
CIRCLE (60 / 3 + x, 90 / 3 + y), 40 / 3, co, 1.2, 2.3, .8
FOR T = 1 TO 300: NEXT: LINE (140 / 3 + x, 130 / 3 + y)-(80 / 3 + x, 140 / 3 + y), co
LINE -(60 / 3 + x, 200 / 3 + y), co: LINE (180 / 3 + x, 130 / 3 + y)-(240 / 3 + x, 140 / 3 + y), co
LINE -(260 / 3 + x, 200 / 3 + y), co: LINE (140 / 3 + x, 130 / 3 + y)-(180 / 3 + x, 200 / 3 + y), co
LINE -(120 / 3 + x, 170 / 3 + y), co: LINE -(130 / 3 + x, 160 / 3 + y), co
LINE -(120 / 3 + x, 150 / 3 + y), co: LINE -(130 / 3 + x, 132 / 3 + y), co
FOR T = 1 TO 300: NEXT: LINE (180 / 3 + x, 130 / 3 + y)-(165 / 3 + x, 180 / 3 + y), co
LINE (190 / 3 + x, 131 / 3 + y)-(200 / 3 + x, 150 / 3 + y), co
LINE -(190 / 3 + x, 160 / 3 + y), co
LINE -(200 / 3 + x, 170 / 3 + y), co: LINE -(170 / 3 + x, 200 / 3 + y), co
LINE (100 / 3 + x, 180 / 3 + y)-(90 / 3 + x, 200 / 3 + y), co
LINE (220 / 3 + x, 170 / 3 + y)-(230 / 3 + x, 200 / 3 + y), co
FOR T = 1 TO 300: NEXT: LINE (160 / 3 + x, 135 / 3 + y)-(150 / 3 + x, 140 / 3 + y), co
LINE -(140 / 3 + x, 130 / 3 + y), co: LINE -(160 / 3 + x, 135 / 3 + y), co
LINE (160 / 3 + x, 135 / 3 + y)-(170 / 3 + x, 140 / 3 + y), co
LINE -(180 / 3 + x, 130 / 3 + y), co: LINE -(160 / 3 + x, 135 / 3 + y), co
'PAINT (1 / 3 + x, 1 / 3 + y), 1, 3
 CIRCLE (160 / 3 + x, 93 / 3 + y), 20 / 3, 0, -3.1415, -6.283, .7
 PAINT (160 / 3 + x, 104 / 3 + y), 0, 0
 CIRCLE (160 / 3 + x, 96 / 3 + y), 20 / 3, co, -3.1415, -6.283, .7
 PAINT (160 / 3 + x, 107 / 3 + y), 2, co

CIRCLE (160 / 3 + x, 96 / 3 + y), 20 / 3, 0, -3.1415, -6.283, .7
PAINT (160 / 3 + x, 107 / 3 + y), 0, 0
CIRCLE (160 / 3 + x, 93 / 3 + y), 20 / 3, co, -3.1415, -6.283, .7
PAINT (160 / 3 + x, 104 / 3 + y), 2, co

LOCATE HANG, lie: PRINT " I am "; : PRINT j$; : PRINT " ! ": 'PLAY "mb cl4dl2e"
FOR T = 1 TO 5000: NEXT
NEXT
LOCATE 10, 15: PRINT "  Who are you ?  "
LOCATE 24, 12: INPUT "I am "; name$
FOR y = 1 TO 5000: NEXT
FOR y = 1 TO 20: LOCATE 12, 10: PRINT "  W E L L C O M E !  ": FOR T = 1 TO 100: NEXT T
                LOCATE 12, 10: PRINT "                    "
                FOR T = 1 TO 100: NEXT T
NEXT
 LOCATE 12, 10: PRINT "  W E L C O M E !  "

LOCATE 14, 13: PRINT "  Let's begin !  ": FOR u = 1 TO 8000: NEXT u
DATA "Betty",220,80,19,26,1,"Caryn",120,0,1,15,2,"Dennis",00,80,19,2 ,3
RETURN

