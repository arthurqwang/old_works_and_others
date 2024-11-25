'Calculate v0,bat ,being given 2 data (h,t).
DECLARE FUNCTION f! (v0b!, h1!, t1!, h2!, t2!)
INPUT "H1,T1,H2,T2 (H:(m),T:(s))  :", h1, t1, h2, t2
t1 = t1 / 2: t2 = t2 / 2
a = .00001: b = 100: x = (b + a) / 2
DO UNTIL ABS(a - x) < .0000001#
c = f(x, h1, t1, h2, t2)
IF f(a, h1, t1, h2, t2) * c < 0 THEN
b = x
ELSE
a = x
END IF
x = (b + a) / 2
LOOP
bat = (EXP(x * t1) - 1) / h1
v0 = x / bat
PRINT v0, bat
PRINT
PRINT " NOTE: the RESULT is saved in VVBAT."
OPEN "vvbat" FOR OUTPUT AS #1
PRINT #1, h2, v0, bat
CLOSE
END

FUNCTION f (v0b, h1, t1, h2, t2)
f = (EXP(v0b * t1) - 1) / (EXP(v0b * t2) - 1) - h1 / h2
END FUNCTION

