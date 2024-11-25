
1 SCREEN 0
2 WIDTH 40
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
170 SHELL "wheel.exe"
180 END

