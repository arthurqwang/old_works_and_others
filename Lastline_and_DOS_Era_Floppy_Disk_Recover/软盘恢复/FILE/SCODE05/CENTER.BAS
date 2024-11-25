DECLARE SUB cai ()
       
3        CLS
        CALL cai
1       INK$ = INKEY$
        IF INK$ = "" THEN 1
        LOCATE 24, 1
        SELECT CASE INK$
         CASE "0"
'         SHELL "edlin FRFIRONE.for"
        OPEN "EDMAINFO.SGN" FOR OUTPUT AS #6
        PRINT #6, " "
        CLOSE #6
        GOTO 2
         CASE "1"
         'SHELL "edlin FRSECTWO.for"
        OPEN "EDSECOFO.SGN" FOR OUTPUT AS #7
        PRINT #7, " "
        CLOSE #7
        GOTO 2

         CASE "2"
         'SHELL "edlin FRTHITHR.for"
        OPEN "EDTHIRFO.SGN" FOR OUTPUT AS #8
        PRINT #8, " "
        CLOSE #8
        GOTO 2

        CASE "3"
        OPEN "COMALLFI.SGN" FOR OUTPUT AS #3
        PRINT #3, " "
        CLOSE #3
        GOTO 2
        CASE "4"
        OPEN "FRMAINFO.SGN" FOR OUTPUT AS #9
        PRINT #9, " "
        CLOSE #9
        GOTO 2
       
        CASE "5"
        OPEN "FRSECOFO.SGN" FOR OUTPUT AS #10
        PRINT #10, " "
        CLOSE #10
        GOTO 2
       
        CASE "6"
        OPEN "FRTHIRFO.SGN" FOR OUTPUT AS #11
        PRINT #11, " "
        CLOSE #11
        GOTO 2
       
        CASE "7"
        OPEN "LKALLOBJ.SGN" FOR OUTPUT AS #1'ZAI .BAT ZHONG ZUO LINK  DE BIAOJI
        PRINT #1, " "
        CLOSE #1
        GOTO 2
        CASE "8"
        OPEN "DERECRUN.SGN" FOR OUTPUT AS #4
        PRINT #4, " "
        CLOSE #4
        GOTO 2

        CASE "9"
        OPEN "COLINRUN.SGN" FOR OUTPUT AS #2
        PRINT #2, " "
        CLOSE #2
        GOTO 2
        CASE "a"
        OPEN "lprmnfor.sgn" FOR OUTPUT AS #12
        PRINT #12, " "
        CLOSE #12
        GOTO 2
        CASE "A"
        OPEN "lprmnfor.sgn" FOR OUTPUT AS #12
        PRINT #12, " "
        CLOSE #12
        GOTO 2
        CASE "b"
        OPEN "lpra2for.sgn" FOR OUTPUT AS #13
        PRINT #13, " "
        CLOSE #13
        GOTO 2
        CASE "B"
        OPEN "lpra2for.sgn" FOR OUTPUT AS #13
        PRINT #13, " "
        CLOSE #13
        GOTO 2
        CASE "c"
        OPEN "lpra3for.sgn" FOR OUTPUT AS #14
        PRINT #14, " "
        CLOSE #14
        GOTO 2
        CASE "C"
        OPEN "lpra3for.sgn" FOR OUTPUT AS #14
        PRINT #14, " "
        CLOSE #14
        GOTO 2
        CASE "E"
        SHELL "HLPFRBAT"
        GOTO 3
        CASE "e"
        SHELL "HLPFRBAT"
        GOTO 3
        CASE "Q"
        LOCATE 23, 1
        PRINT "SURE EXIT?(Y/N)"
97      EXI$ = INKEY$
        IF EXI$ = "" THEN 97
        IF EXI$ = "Y" OR EXI$ = "y" THEN
        OPEN "QUITTBAT.SGN" FOR OUTPUT AS #5
        PRINT #5, " "
        CLOSE #5
        GOTO 2
        END IF
        GOTO 3
        CASE "q"
        LOCATE 23, 1
        PRINT "SURE EXIT?(Y/N)"
98      EXI$ = INKEY$
        IF EXI$ = "" THEN 98
        IF EXI$ = "Y" OR EXI$ = "y" THEN
        OPEN "QUITTBAT.SGN" FOR OUTPUT AS #5
        PRINT #5, " "
        CLOSE #5
        GOTO 2
        END IF
        GOTO 3
        CASE "D"
        SHELL "C:\DOS\COMMAND"
        SHELL "cd\for"
        CASE "d"
        SHELL "C:\DOS\COMMAND"
        SHELL "cd\for"
        CASE ELSE
        PRINT "IUPUT AGAIN!"
        GOTO 3
        END SELECT
        GOTO 3

2       END

SUB cai
LOCATE 7, 1
PRINT "0. edit main.for"
LOCATE 8, 1
PRINT "1. edit a2.for"
LOCATE 9, 1
PRINT "2. edit a3.for"
LOCATE 10, 1
PRINT "3. compile all"
LOCATE 11, 1
PRINT "4. compile main.for"
LOCATE 12, 1
PRINT "5. compile a2.for"
LOCATE 13, 1
PRINT "6. compile a3.for"
LOCATE 14, 1
PRINT "7. link"
LOCATE 15, 1
PRINT "8. run"
LOCATE 16, 1
PRINT "9. compile+link+run"
LOCATE 17, 1
PRINT "A. Lprint main.for"
 LOCATE 18, 1
 PRINT "B. Lprint a2.for"
 LOCATE 19, 1
 PRINT "C. Lprint a3.for"
LOCATE 20, 1
PRINT "D. DOSSHELL"
LOCATE 21, 1
PRINT "E. HELP"
LOCATE 22, 1
PRINT "Q. QUIT"
END SUB

