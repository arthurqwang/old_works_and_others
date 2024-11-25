'Calculate v0,bat ,being given 2 data (h,t).
DECLARE FUNCTION f! (v0b!, h1!, t1!, h2!, t2!)
INPUT "file:", as$
FOR i = 1 TO 3
INPUT "H1,T1,H2,T2 (H:(m),T:(ms),H:jizhunmian ,T:shuangcheng)  :", h1, t1, h2, t2
t1 = t1 / 2000: t2 = t2 / 2000
a = -11: b = 10: x = (b + a) / 2
DO UNTIL ABS(a - x) < .000001# AND C < .000001
C = f(x, h1, t1, h2, t2)
IF f(a, h1, t1, h2, t2) * C < 0 THEN
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
PRINT (EXP(t1 * v0 * bat) - 1) / bat, (EXP(t2 * v0 * bat) - 1) / bat
OPEN as$ FOR APPEND AS #1
PRINT #1, h2, v0, bat
CLOSE
NEXT
END

FUNCTION f (v0b, h1, t1, h2, t2)
f = (EXP(v0b * t1) - 1) / (EXP(v0b * t2) - 1) - h1 / h2
END FUNCTION

