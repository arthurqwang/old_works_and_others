ON TIMER(1) GOSUB 1001
KEY OFF: TIMER ON
CLS
SCREEN 9: COLOR 15, 0
x0 = 100: y0 = 100
'xh = 50: yh = 12: xm = 25: ym = 12: xs = 25: ys = 12: x1 = 25: x2 = 25: y1 = 12: y2 = 12
'xx1 = 25: xx2 = 25: yy1 = 12: yy2 = 12
LINE (0 + x0, 0 + y0)-(100 + x0, 50 + y0), 9, B
LINE (4 + x0, 2 + y0)-(96 + x0, 48 + y0), 2, B
FOR T = 0 TO 6.283 STEP 6.283 / 12
CIRCLE (50 + x0, 24 + y0), 32, 2, T, T + .000000001#, .6
NEXT
1 IF INKEY$ = "" THEN 1 ELSE END

1001 T$ = TIME$
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
LINE (50 + x0, 24 + y0)-(xs + x0, ys + y0), 0
xs = 50 + 24 * SIN(.104719755# * ts)
ys = 24 - 15 * COS(.104719755# * ts)
LINE (50 + x0, 24 + y0)-(xs + x0, ys + y0), 4
SOUND 5000, .5
IF ts <> 0 THEN GOTO 231
LINE (50 + x0, 24 + y0)-(x2 + x0, y2 + y0), 0
231
x2 = 50 + 22 * SIN(.104719755# * tm)
y2 = 24 - 14 * COS(.104719755# * tm)
LINE (50 + x0, 24 + y0)-(x2 + x0, y2 + y0), 15


IF tmtm = 1 THEN BEEP:  IF tm = 31 THEN tmtm = 0
IF tmtmtm = 1 THEN PLAY "o4  mb t120 l4dp32l4dp32l4gl8al8gl2fl2gl4al8gl8el8dl16el16gl8cl16<al16>cl2d": IF tm = 1 THEN tmtmtm = 0
654 IF th >= 12 THEN th = th - 12
IF ts <> 0 THEN GOTO 232
LINE (50 + x0, 24 + y0)-(xh + x0, yh + y0), 0
232 xh = 50 + 18 * SIN(.523598775# * (th + tm / 60))
yh = 24 - 11 * COS(.523598775# * (th + tm / 60))
LINE (50 + x0, 24 + y0)-(xh + x0, yh + y0), 15
PSET (50 + x0, 24 + y0), 2
CIRCLE (50 + x0, 24 + y0), 2, 2
 RETURN
 END

