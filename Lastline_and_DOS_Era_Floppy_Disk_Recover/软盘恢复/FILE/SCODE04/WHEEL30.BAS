

DIM zz(366), tt(366), qq(366), nb(20)

 SCREEN 0
 WIDTH 40
10 PRINT "Enter your ";
20 COLOR 4, 0
30 PRINT "password";
40 COLOR 7
50 PRINT " here : ?";
60 COLOR 0

70 INPUT pass$
80 IF pass$ = "68" THEN 140
90 COLOR 30
100 PRINT "Wrong password!"
101 SOUND 300, 10
102 SOUND 1000, 10
103 SOUND 300, 15
110 COLOR 7
111 PRINT "Do you want to exit ?(Prees any kay and ENTER to exit ) "
INPUT vc$
112 IF vc$ <> "" THEN STOP
120 GOTO 10
140 COLOR 21, 7
150 PRINT "Success! Program continue..."
151 PLAY "cdefgabccc>"
160 COLOR 7, 0

PRINT "Input your name:"
INPUT na$
PRINT "Input your birthday:year,month,day"
INPUT A%, b%, c%
PRINT "Input date for you to want:year,month,day"
INPUT aa%, BB%, cc%
PRINT "How long time ? (days)"
INPUT dtime
aaa% = aa% - A%: bbb% = BB% - b%: ccc% = cc% - c%
sum% = aaa% * 365 + aaa% \ 4 + aaa% \ 10 + bbb% * 30 + bbb% \ 2 + ccc%
z% = sum% MOD 21
t% = sum% MOD 33
q% = sum% MOD 28
PRINT "zhili", z%, "tili", t%, "qingxu", q%
D = 2! * 3.1415927# / 21!
e = 2! * 3.14159265# / 33!
f = 2! * 3.14159265# / 28!
SCREEN 1, 0
COLOR 8, 0
PRINT "Red =tili ; Green=zhili ; Orange=qingxu"
PRINT " "
PRINT "   Name       : "; na$
PRINT "   Start date : "; aa%; ","; BB%; ","; cc%
'kxk = 33 / 62
kyk = 33 / 62
yyy = 40
iiii = FIX(dtime / 61) + 1
FOR iii = 1 TO iiii STEP 1
yyyy = yyy * (iii + 1)
dtime1 = 31 * (iii - 1) * 2
dtime2 = 31 * iii * 2
FOR i = dtime1 TO dtime2 STEP 1
zz(i) = -1 * SIN(D * (i + z%)) * 15 * kyk
NEXT i
FOR i = dtime1 TO dtime2 - 1 STEP 1
LINE ((i * 5 + 10) - 310 * (iii - 1), zz(i) * 1.8 + yyyy)-(((i + 1) * 5 + 10) - 310 * (iii - 1), zz(i + 1) * 1.8 + yyyy), 1
NEXT i

FOR j = dtime1 TO dtime2 STEP 1
tt(j) = -SIN(e * (j + t%)) * 15 * kyk
NEXT j
FOR i = dtime1 TO dtime2 - 1 STEP 1
LINE ((i * 5 + 10) - 310 * (iii - 1), tt(i) * 1.8 + yyyy)-(((i + 1) * 5 + 10) - 310 * (iii - 1), tt(i + 1) * 1.8 + yyyy), 2
NEXT i

FOR k = dtime1 TO dtime2 STEP 1
qq(k) = -SIN(f * (k + q%)) * 15 * kyk
NEXT k
FOR i = dtime1 TO dtime2 - 1 STEP 1
LINE ((i * 5 + 10) - 310 * (iii - 1), qq(i) * 1.8 + yyyy)-(((i + 1) * 5 + 10) - 310 * (iii - 1), qq(i + 1) * 1.8 + yyyy), 3
NEXT i

LINE (10, yyyy)-(320, yyyy), 3
DRAW "bl310"
FOR i = 0 TO 61 STEP 1
DRAW "u1 d1 r5"
NEXT i
DRAW "u1"
NEXT iii

DRAW "bu80bl310"
 FOR jill = 1 TO iiii STEP 1
 cccc = 63

FOR jilll = 1 TO 2 STEP 1
IF BB% <= 12 THEN GOTO 60987
aa% = aa% + 1
BB% = BB% - 12
60987 IF BB% = 1 OR BB% = 3 OR BB% = 5 OR BB% = 7 OR BB% = 8 OR BB% = 10 OR BB% = 12 THEN GOTO 91
IF BB% = 4 OR BB% = 6 OR BB% = 9 OR BB% = 11 THEN GOTO 92
asd = aa% MOD 4
asf = aa% MOD 10
IF asd = 0 OR asf = 0 THEN GOTO 93
days = 28: GOTO 1000
91 days = 31: GOTO 1000
92 days = 30: GOTO 1000
93 days = 29: GOTO 1000
1000 dy = (days - cc%) + 1

FOR i = 1 TO dy STEP 1
DRAW "br5"
xo = xo + 5
NEXT i
DRAW "c2d2u4"
DRAW "d2"
cccc = cccc - dy
BB% = BB% + 1
IF BB% <= 12 THEN GOTO 90450
BB% = BB% - 12
aa% = aa% + 1
90450 xx = 4: yy = 4:  yo = 40 * (jill + 1) + 6: number = BB%: sav = 0
GOSUB 999
DRAW "bu10"
cc% = 1
  NEXT jilll
  xo = 5
LINE (30, 40 * jill + 40)-(10, 40 * jill + 40)
DRAW "bd40b"
cc% = cccc
NEXT jill
END



999
'SCREEN 1
'PRINT "Color:background,palette"

'INPUT a%, b%
 jiange = 17
'PRINT "xx,yy"
'INPUT xx, yy
'PRINT "xo,yo"
'INPUT xo, yo
'COLOR a%, b%
'PRINT "number"
'INPUT number
'PRINT "sav"
'INPUT sav
'PRINT "jiange"
'INPUT jiange
'CLS :
nhg = ABS(number)
IF sav <= 0 THEN GOTO 107
n = FIX(nhg)
nn = nhg - n
nn = INT(nn * 10 ^ sav + .5) / 10 ^ sav
GOTO 108
107 n = FIX(nhg * 10 ^ sav + .5) / 10 ^ sav
108 FOR i = 10 TO 1 STEP -1
nui = n / 10 ^ (i - 1)

nb(i) = FIX(nui)
n = n - nb(i) * 10 ^ (i - 1)
NEXT i

FOR i = 10 TO 1 STEP -1
IF nb(i) <> 0 THEN GOTO 78
jkl = i
NEXT i
GOTO 79
78 jkl = i
79 kx = xx / 10
ky = yy / 10
k = 0
IF number >= 0 THEN GOTO 8765
LINE (k * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 5 * ky + yo)
k = jiange


8765 FOR j = jkl TO 1 STEP -1
GOSUB 9999
k = k + jiange
NEXT j
IF sav <= 0 GOTO 9876

PSET ((4 + k) * kx + xo, 9 * ky + yo): PSET ((5 + k) * kx + xo, 9 * ky + yo)
PSET ((4 + k) * kx + xo, 10 * ky + yo): PSET ((5 + k) * kx + xo, 10 * ky + yo)

FOR i = 20 TO 21 - sav STEP -1
nuii = nn / 10 ^ (i - 21)
nb(i) = FIX(nuii)
nn = nn - nb(i) * 10 ^ (i - 21)
NEXT i

 FOR j = 20 TO 21 - sav STEP -1
k = k + jiange
GOSUB 9999
NEXT j
9876 RETURN



9999 'writing number subroutine






ON nb(j) + 1 GOTO 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
'1
1 LINE (CINT((5 + k) * kx) + xo, CINT(0 * ky) + yo)-(CINT((5 + k) * kx) + xo, CINT(10 * ky) + yo)
 RETURN
'2
2 LINE (CINT((0 + k) * kx) + xo, CINT(2 * ky) + yo)-(CINT((4 + k) * kx) + xo, CINT(0 * ky) + yo)
LINE (CINT((3 + k) * kx) + xo, CINT(0 * ky) + yo)-(CINT((7 + k) * kx) + xo, CINT(0 * ky) + yo)
LINE (CINT((7 + k) * kx) + xo, CINT(0 * ky) + yo)-(CINT((10 + k) * kx) + xo, CINT(2 * ky) + yo), 3
LINE (CINT((10 + k) * kx) + xo, CINT(2 * ky) + yo)-(CINT((10 + k) * kx) + xo, CINT(4 * ky) + yo), 3
LINE (CINT((10 + k) * kx) + xo, CINT(4 * ky) + yo)-(CINT((0 + k) * kx) + xo, CINT(8 * ky) + yo), 3
LINE (CINT((0 + k) * kx) + xo, CINT(8 * ky) + yo)-(CINT((0 + k) * kx) + xo, 10 * ky + yo), 3
LINE ((0 + k) * kx + xo, 10 * ky + yo)-((9 + k) * kx + xo, 10 * ky + yo), 3
 RETURN
'3
3 LINE ((0 + k) * kx + xo, 2 * ky + yo)-((3 + k) * kx + xo, 0 * ky + yo), 3
LINE ((3 + k) * kx + xo, 0 * ky + yo)-((7 + k) * kx + xo, 0 * ky + yo), 3
LINE ((7 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo), 3
LINE ((10 + k) * kx + xo, 2 * ky + yo)-((10 + k) * kx + xo, 4 * ky + yo), 3
LINE ((10 + k) * kx + xo, 4 * ky + yo)-((4 + k) * kx + xo, 5 * ky + yo), 3
LINE ((5 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 6 * ky + yo), 3
LINE ((10 + k) * kx + xo, 6 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo), 3
LINE ((10 + k) * kx + xo, 8 * ky + yo)-((7 + k) * kx + xo, 10 * ky + yo), 3
LINE ((7 + k) * kx + xo, 10 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo), 3
LINE ((2 + k) * kx + xo, 10 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo), 3
 RETURN
'4
4 LINE ((10 + k) * kx + xo, 7 * ky + yo)-(0 + k * kx + xo, 7 * ky + yo), 3
LINE ((0 + k) * kx + xo, 7 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo), 3
LINE ((8 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo), 3
 RETURN

'5
5 LINE ((0 + k) * kx + xo, 9 * ky + yo)-((3 + k) * kx + xo, 10 * ky + yo)
LINE ((3 + k) * kx + xo, 10 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo): LINE ((8 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo)
LINE ((10 + k) * kx + xo, 8 * ky + yo)-((10 + k) * kx + xo, 5 * ky + yo): LINE ((10 + k) * kx + xo, 5 * ky + yo)-((8 + k) * kx + xo, 4 * ky + yo)
LINE ((8 + k) * kx + xo, 4 * ky + yo)-((3 + k) * kx + xo, 4 * ky + yo): LINE ((3 + k) * kx + xo, 4 * ky + yo)-((0 + k) * kx + xo, 4 * ky + yo)
LINE ((0 + k) * kx + xo, 4 * ky + yo)-((0 + k) * kx + xo, 0 * ky + yo): LINE ((0 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 0 * ky + yo)
 RETURN
'6
6 LINE ((0 + k) * kx + xo, 5 * ky + yo)-((3 + k) * kx + xo, 4 * ky + yo)
LINE ((3 + k) * kx + xo, 4 * ky + yo)-((8 + k) * kx + xo, 4 * ky + yo)
LINE ((8 + k) * kx + xo, 4 * ky + yo)-((10 + k) * kx + xo, 5 * ky + yo): LINE ((10 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo)
LINE ((10 + k) * kx + xo, 8 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo): LINE ((8 + k) * kx + xo, 10 * ky + yo)-((3 + k) * kx + xo, 10 * ky + yo)
LINE ((3 + k) * kx + xo, 10 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo): LINE ((0 + k) * kx + xo, 8 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo)
LINE ((0 + k) * kx + xo, 2 * ky + yo)-((3 + k) * kx + xo, 0 * ky + yo): LINE ((3 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo)
'LINE ((8 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo)
 RETURN
'7
7 LINE ((0 + k) * kx + xo, 2 * ky + yo)-((0 + k) * kx + xo, 0 * ky + yo): LINE ((0 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 0 * ky + yo)
LINE ((10 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo): LINE ((3 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo)
 RETURN
'8
8 LINE ((2 + k) * kx + xo, 5 * ky + yo)-((8 + k) * kx + xo, 5 * ky + yo)
LINE ((8 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 6 * ky + yo)
LINE ((10 + k) * kx + xo, 6 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo): LINE ((10 + k) * kx + xo, 8 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo)
LINE ((8 + k) * kx + xo, 10 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo): LINE ((2 + k) * kx + xo, 10 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo)
LINE ((0 + k) * kx + xo, 8 * ky + yo)-((0 + k) * kx + xo, 6 * ky + yo): LINE ((0 + k) * kx + xo, 6 * ky + yo)-((2 + k) * kx + xo, 5 * ky + yo)
LINE ((2 + k) * kx + xo, 5 * ky + yo)-((0 + k) * kx + xo, 3 * ky + yo): LINE ((0 + k) * kx + xo, 3 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo)
LINE ((0 + k) * kx + xo, 2 * ky + yo)-((2 + k) * kx + xo, 0 * ky + yo)
    LINE ((2 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo): LINE ((8 + k) * kx + xo, 0 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo)
LINE ((10 + k) * kx + xo, 2 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo): LINE ((8 + k) * kx + xo, 5 * ky + yo)-((10 + k) * kx + xo, 3 * ky + yo)
RETURN
'9
' LINE ((0 + k) * kx + xo, 8 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo)
9 LINE ((2 + k) * kx + xo, 10 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo)
LINE ((8 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo): LINE ((10 + k) * kx + xo, 8 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo)
LINE ((10 + k) * kx + xo, 2 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo): LINE ((8 + k) * kx + xo, 0 * ky + yo)-((2 + k) * kx + xo, 0 * ky + yo)
LINE ((2 + k) * kx + xo, 0 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo): LINE ((0 + k) * kx + xo, 2 * ky + yo)-((0 + k) * kx + xo, 4 * ky + yo)
LINE ((0 + k) * kx + xo, 4 * ky + yo)-((2 + k) * kx + xo, 6 * ky + yo): LINE ((2 + k) * kx + xo, 6 * ky + yo)-((8 + k) * kx + xo, 6 * ky + yo)
LINE ((8 + k) * kx + xo, 6 * ky + yo)-((10 + k) * kx + xo, 4 * ky + yo)
 RETURN
'0
0 LINE ((2 + k) * kx + xo, 0 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo)
LINE ((8 + k) * kx + xo, 10 * ky + yo)-((10 + k) * kx + xo, 8 * ky + yo)
LINE ((10 + k) * kx + xo, 8 * ky + yo)-((10 + k) * kx + xo, 2 * ky + yo)
LINE ((10 + k) * kx + xo, 2 * ky + yo)-((8 + k) * kx + xo, 0 * ky + yo): LINE ((8 + k) * kx + xo, 0 * ky + yo)-((2 + k) * kx + xo, 0 * ky + yo)
LINE ((2 + k) * kx + xo, 0 * ky + yo)-((0 + k) * kx + xo, 2 * ky + yo): LINE ((0 + k) * kx + xo, 2 * ky + yo)-((0 + k) * kx + xo, 8 * ky + yo)
LINE ((0 + k) * kx + xo, 8 * ky + yo)-((2 + k) * kx + xo, 10 * ky + yo): LINE ((2 + k) * kx + xo, 10 * ky + yo)-((8 + k) * kx + xo, 10 * ky + yo)
RETURN
   


