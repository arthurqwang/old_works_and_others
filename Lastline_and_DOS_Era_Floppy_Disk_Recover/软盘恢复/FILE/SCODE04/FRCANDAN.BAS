DECLARE SUB rejian (inke$)
DECLARE SUB hanzi (hzc$, zihao%, jiange%, fangshi%, pingfangshi%)
ON TIMER(1) GOSUB 2001
KEY OFF: TIMER ON
        'CONST dospath$ = "C:\DOS\COMMAND", cdpath$ = "cd\for", driver$ = "e:"
        OPEN "\for\instllfr.dat" FOR INPUT AS #100
        INPUT #100, dospath$, cdpath$, driver$
        CLOSE #100
        DIM arr(1710), brr(1763), crr(680)
        SCREEN 9: COLOR 15, 0
2       CLS
        '*********** biao
                x0 = 530: y0 = 40
                LINE (0 + x0, 0 + y0)-(100 + x0, 50 + y0), 9, B
                LINE (4 + x0, 2 + y0)-(96 + x0, 48 + y0), 2, B
                FOR T = 0 TO 6.283 STEP 6.283 / 12
                CIRCLE (50 + x0, 24 + y0), 32, 10, T, T + .000000001#, .6
                NEXT
                GET (x0, y0)-(x0 + 100, y0 + 50), crr
        LINE (0, 12)-(639, 32), 1, B
        LINE (1, 13)-(638, 31), 2, BF

        '1.bianji
        LOCATE 2, 2
        CALL hanzi("１编辑", 6, 1, 4, 9)
        '2.bianyi
        LOCATE 2, POS(0) + 2
        CALL hanzi("２编译", 6, 1, 4, 9)
        '3.lianjie
        LOCATE 2, POS(0) + 2
        CALL hanzi("３连接", 6, 1, 4, 9)
        '4.yunxing
        LOCATE 2, POS(0) + 2
        CALL hanzi("４运行", 6, 1, 4, 9)
        '5.dayin
        LOCATE 2, POS(0) + 2
        CALL hanzi("５打印", 6, 1, 4, 9)
        '6.zanfan dos
        LOCATE 2, POS(0) + 2
        CALL hanzi("６暂返ＤＯＳ", 6, 1, 4, 9)
        '7.tuichu
        LOCATE 2, POS(0) + 2
        CALL hanzi("７装载", 6, 1, 4, 9)
        '8.shiyongshuoming
        LOCATE 2, POS(0) + 8
        CALL hanzi("８使用说明", 6, 1, 4, 9)
        LINE (0, 36)-(639, 300), 3, B
        LINE (0, 306)-(639, 327), 6, BF
        LOCATE 23, 1
        're jian
        LOCATE 23, 2
        'f1:quanbubianyi
        CALL hanzi("Ｆ１∶全部编译", 5, 1, 4, 9)
        LOCATE 23, POS(0) + 4
        ' f2: bianyilianjieyunxing
        CALL hanzi("Ｆ２∶编译连接运行", 5, 1, 4, 9)
        LOCATE 23, POS(0) + 4
        'f3:zhijieyunxing
        CALL hanzi("Ｆ３∶直接运行", 5, 1, 4, 9)
        LOCATE 23, POS(0) + 4
        'f4:dayiyuanchengxu
        CALL hanzi("Ｆ４∶打印全部源程序", 5, 1, 4, 9)
        GET (0, 12)-(639, 32), arr
        GET (0, 306)-(639, 327), brr
        'huabiao chu
        LOCATE 2, 2
        CALL hanzi("１编辑", 5, 1, 4, 9)
        LOCATE 2, 2
1        inke$ = INKEY$
        IF inke$ = "" THEN 1
        SOUND 1000, .5
        SELECT CASE inke$
        CASE "1"
        GOSUB 1001
        CASE "2"
        GOSUB 1002
       CASE "3"
      '"lianjie"
        OPEN "LKALLOBJ.SGN" FOR OUTPUT AS #1'ZAI .BAT ZHONG ZUO LINK  DE BIAOJI
        PRINT #1, " "
        CLOSE #1
        GOTO 2222
       CASE "4"
       GOSUB 1004
        CASE "5"
        GOSUB 1005
        CASE "6"
       ' "return dos"
        SCREEN 0
        SHELL dospath$
        SHELL "cls"
        SHELL driver$
        SHELL cdpath$

                CLS : SCREEN 9
                PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 42
                CALL hanzi("６暂返ＤＯＳ", 5, 1, 4, 9)
        '        CALL hanzi("１编辑", 5, 1, 4, 9)
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 42
        GOTO 1
        CASE "7"
        ' "quit"
        LOCATE 20, 30
        CALL hanzi("重新装载吗？（Ｙ／Ｎ）", 3, 1, 3, 9)
98      EXI$ = INKEY$
        IF EXI$ = "" THEN 98
        IF EXI$ = "Y" OR EXI$ = "y" THEN
        OPEN "QUITTBAT.SGN" FOR OUTPUT AS #5
        PRINT #5, " "
        CLOSE #5
        GOTO 2222
        END IF
        LINE (230, 250)-(400, 285), 0, BF
        LOCATE 2, 56
        GOTO 1

        CASE "8"
        '"shiyong shuoming"
          SHELL "ftrsysm"
                CLS : SCREEN 9
                PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 2
                CALL hanzi("１编辑", 5, 1, 4, 9)
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 2

        GOTO 1
        CASE ELSE
             IF RIGHT$(inke$, 1) = CHR$(77) OR RIGHT$(inke$, 1) = CHR$(80) THEN
                 SELECT CASE POS(0)
                       CASE 2
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 10
                       CALL hanzi("２编译", 5, 1, 4, 9)
                       LOCATE 2, 10
                       CASE 10
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 18
                       CALL hanzi("３连接", 5, 1, 4, 9)
                       LOCATE 2, 18
                       CASE 18
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 26
                       CALL hanzi("４运行", 5, 1, 3, 9)
                       LOCATE 2, 26
                       CASE 26
                       LOCATE 2, 34
                       PUT (0, 12), arr, PSET
                       CALL hanzi("５打印", 5, 1, 3, 9)
                       LOCATE 2, 34
                       CASE 34
                       LOCATE 2, 42
                       PUT (0, 12), arr, PSET
                       CALL hanzi("６暂返ＤＯＳ", 5, 1, 4, 9)
                       LOCATE 2, 42
                       CASE 42
                       LOCATE 2, 56
                       PUT (0, 12), arr, PSET
                       CALL hanzi("７装载", 5, 1, 4, 9)
                       LOCATE 2, 56
                       CASE 56
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 70
                       CALL hanzi("８使用说明", 5, 1, 4, 9)
                       LOCATE 2, 70
                       CASE 70
                       LOCATE 2, 2
                       PUT (0, 12), arr, PSET
                       CALL hanzi("１编辑", 5, 1, 4, 9)
                       LOCATE 2, 2
                END SELECT
              END IF
              IF RIGHT$(inke$, 1) = CHR$(72) OR RIGHT$(inke$, 1) = CHR$(75) THEN
                SELECT CASE POS(0)
                        CASE 2
                        LOCATE 2, 70
                        PUT (0, 12), arr, PSET
                        CALL hanzi("８使用说明", 5, 1, 4, 9)
                       LOCATE 2, 70
                       CASE 10
                       LOCATE 2, 2
                       PUT (0, 12), arr, PSET
                       CALL hanzi("１编辑", 5, 1, 4, 9)
                       LOCATE 2, 2
                       CASE 18
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 10
                       CALL hanzi("２编译", 5, 1, 4, 9)
                       LOCATE 2, 10
                       CASE 26
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 18
                       CALL hanzi("３连接", 5, 1, 4, 9)
                       LOCATE 2, 18
                       CASE 34
                       PUT (0, 12), arr, PSET
                       LOCATE 2, 26
                       CALL hanzi("４运行", 5, 1, 3, 9)
                       LOCATE 2, 26
                       CASE 42
                       LOCATE 2, 34
                       PUT (0, 12), arr, PSET
                       CALL hanzi("５打印", 5, 1, 3, 9)
                       LOCATE 2, 34
                       CASE 56
                       LOCATE 2, 42
                       PUT (0, 12), arr, PSET
                       CALL hanzi("６暂返ＤＯＳ", 5, 1, 4, 9)
                       LOCATE 2, 42
                       CASE 70
                       LOCATE 2, 56
                       PUT (0, 12), arr, PSET
                       CALL hanzi("７装载", 5, 1, 4, 9)
                       LOCATE 2, 56
                END SELECT
              END IF
              IF inke$ = CHR$(13) THEN
                 SELECT CASE POS(0)
                        CASE 2
                        GOSUB 1001
                        CASE 10
                        GOSUB 1002
                        CASE 18
                        ' "lianjie"
                        OPEN "LKALLOBJ.SGN" FOR OUTPUT AS #1'ZAI .BAT ZHONG ZUO LINK  DE BIAOJI
                        PRINT #1, " "
                        CLOSE #1
                        GOTO 2222
                        CASE 26
                        GOSUB 1004
                        CASE 34
                        GOSUB 1005
                        CASE 42
                        ' "zanfan dos"
                        SCREEN 0
                        SHELL dospath$
                        SHELL "cls"
                        SHELL driver$
                        SHELL cdpath$
                        CLS : SCREEN 9
                        PUT (x0, y0), crr, PSET
                        PUT (0, 12), arr, PSET
                        LOCATE 2, 42
                        CALL hanzi("６暂返ＤＯＳ", 5, 1, 4, 9)
                        'CALL hanzi("１编辑", 5, 1, 4, 9)
                        PUT (0, 306), brr, PSET
                        LINE (0, 36)-(639, 300), 3, B
                        LOCATE 2, 42
                GOTO 1


                        CASE 56
                        '"tuichu"
                LOCATE 20, 30
       CALL hanzi("重新装载吗？（Ｙ／Ｎ）", 3, 1, 3, 9)
988             EXI$ = INKEY$
                IF EXI$ = "" THEN 988
                IF EXI$ = "Y" OR EXI$ = "y" THEN
                OPEN "QUITTBAT.SGN" FOR OUTPUT AS #5
                PRINT #5, " "
                CLOSE #5
                GOTO 2222
                END IF
                LINE (230, 250)-(400, 285), 0, BF
                LOCATE 2, 56
                GOTO 1
                        CASE 70
                        ' "shiyongshuoming"
                        SHELL "ftrsysm"
                CLS : SCREEN 9
                PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 2
                CALL hanzi("１编辑", 5, 1, 4, 9)
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 2
                GOTO 1
              END SELECT
              END IF
                  IF RIGHT$(inke$, 1) = CHR$(59) OR RIGHT$(inke$, 1) = CHR$(60) OR RIGHT$(inke$, 1) = CHR$(61) OR RIGHT$(inke$, 1) = CHR$(62) THEN
                  CALL rejian(inke$) ' rejian
                  GOTO 2222
                  END IF

          GOTO 1


        END SELECT
2001 T$ = TIME$
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
SOUND 100, .5
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

GOTO 1

2222        END

1001    PUT (0, 12), arr, PSET
        LOCATE 2, 2
        CALL hanzi("１编辑", 5, 1, 4, 9)
        'zuo zi caidan
               'bianji zi caidan
               LINE (5, 39)-(170, 180), 9, B
               LINE (8, 43)-(167, 176), 2, B
               LOCATE 5, 4
               CALL hanzi("１编辑主源程序", 3, 1, 3, 9)
               LOCATE 7, 4
              CALL hanzi("２编辑第二源程序", 6, 1, 4, 9)
               LOCATE 9, 4
              CALL hanzi("３编辑第三源程序", 6, 1, 4, 9)
              LOCATE 5, 4
11      ink$ = INKEY$
        IF ink$ = "" THEN 11
        SOUND 200, 2
        SELECT CASE ink$
                CASE "1"
                '"bianji zhu yuanchengxu"
                OPEN "EDMAINFO.SGN" FOR OUTPUT AS #6
                PRINT #6, " "
                CLOSE #6
                GOTO 2222

                CASE "2"
                '"bianji di er"
                OPEN "EDSECOFO.SGN" FOR OUTPUT AS #7
                PRINT #7, " "
                CLOSE #7
                GOTO 2222

                CASE "3"
                '"bianji disan"
                OPEN "EDTHIRFO.SGN" FOR OUTPUT AS #8
                PRINT #8, " "
                CLOSE #8
                GOTO 2222

                CASE CHR$(27)
                CLS
                PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 2
                CALL hanzi("１编辑", 5, 1, 4, 9)
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 2
                GOTO 1
                ''''''' fangxingjian
                CASE ELSE
                  IF RIGHT$(ink$, 1) = CHR$(80) THEN
                   SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 5, 4
                     CALL hanzi("１编辑主源程序", 6, 1, 3, 9)
                     LOCATE 7, 4
                     CALL hanzi("２编辑第二源程序", 3, 1, 4, 9)
                     LOCATE 7, 4
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 7, 4
                     CALL hanzi("２编辑第二源程序", 6, 1, 4, 9)
                     LOCATE 9, 4
                     CALL hanzi("３编辑第三源程序", 3, 1, 4, 9)
                     LOCATE 9, 4
                     CASE 9
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 56)-(POS(0) * 8 + 120, 75), 0, BF
                     LOCATE 9, 4
                     CALL hanzi("３编辑第三源程序", 6, 1, 4, 9)
                     LOCATE 5, 4
                     CALL hanzi("１编辑主源程序", 3, 1, 3, 9)
                     LOCATE 5, 4
                   END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(72) THEN
                    SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 110)-(POS(0) * 8 + 120, 128), 0, BF
                     LOCATE 5, 4
                     CALL hanzi("１编辑主源程序", 6, 1, 3, 9)
                     LOCATE 9, 4
                     CALL hanzi("３编辑第三源程序", 3, 1, 4, 9)
                     LOCATE 9, 4
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 7, 4
                     CALL hanzi("２编辑第二源程序", 6, 1, 4, 9)
                     LOCATE 5, 4
                     CALL hanzi("１编辑主源程序", 3, 1, 3, 9)
                     LOCATE 5, 4
                     CASE 9
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 9, 4
                     CALL hanzi("３编辑第三源程序", 6, 1, 4, 9)
                     LOCATE 7, 4
                     CALL hanzi("２编辑第二源程序", 3, 1, 4, 9)
                     LOCATE 7, 4
                   END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(77) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1002
                     END IF
                   IF RIGHT$(ink$, 1) = CHR$(75) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1005
                     END IF

                   IF ink$ = CHR$(13) THEN
                           SELECT CASE CSRLIN
                                   CASE 5
                                   ' "BIANJI ZHU YUAN CHENGXU"
                                        OPEN "EDMAINFO.SGN" FOR OUTPUT AS #6
                                        PRINT #6, " "
                                        CLOSE #6
                                        GOTO 2222

                                   CASE 7
                                   '"BIANJI DI ER YUAN CHENGXU"
                                        OPEN "EDSECOFO.SGN" FOR OUTPUT AS #7
                                        PRINT #7, " "
                                        CLOSE #7
                                        GOTO 2222

                                   CASE 9
                                   '"BIANJI DI SAN YUAN CHENGXU"
                                        OPEN "EDTHIRFO.SGN" FOR OUTPUT AS #8
                                        PRINT #8, " "
                                        CLOSE #8
                                        GOTO 2222

                            END SELECT
                   END IF
                  IF RIGHT$(ink$, 1) = CHR$(59) OR RIGHT$(ink$, 1) = CHR$(60) OR RIGHT$(ink$, 1) = CHR$(61) OR RIGHT$(ink$, 1) = CHR$(62) THEN
                  CALL rejian(ink$) ' rejian
                  GOTO 2222
                  END IF

                GOTO 11
           END SELECT
           RETURN

1002 PUT (0, 12), arr, PSET
'        'bianyi zi caidan
        LOCATE 2, 10
        CALL hanzi("２编译", 5, 1, 3, 9)

        LINE (75, 39)-(240, 200), 9, B
        LINE (78, 43)-(237, 196), 2, B
        LOCATE 5, 13
       CALL hanzi("１编译全部源程序", 3, 1, 4, 9)

        LOCATE 7, 13
        CALL hanzi("２编译主源程序", 6, 1, 4, 9)
        LOCATE 9, 13
       CALL hanzi("３编译第二源程序", 6, 1, 4, 9)
        LOCATE 11, 13
       CALL hanzi("４编译第三源程序", 6, 1, 4, 9)
       LOCATE 5, 13
22      ink$ = INKEY$
        IF ink$ = "" THEN 22
        SOUND 200, 2
        SELECT CASE ink$
                CASE "1"
                '"bianyi quanbu yuanchengxu"
                OPEN "COMALLFI.SGN" FOR OUTPUT AS #3
                PRINT #3, " "
                CLOSE #3
                GOTO 2222

                CASE "2"
                '"bianji zhuyuan for"
                OPEN "FRMAINFO.SGN" FOR OUTPUT AS #9
                PRINT #9, " "
                CLOSE #9
                GOTO 2222

                CASE "3"
                ' "bianji di er for"
                OPEN "FRSECOFO.SGN" FOR OUTPUT AS #10
                PRINT #10, " "
                CLOSE #10
                GOTO 2222

                CASE "4"
                '"bianyi disan for"
                OPEN "FRTHIRFO.SGN" FOR OUTPUT AS #11
                PRINT #11, " "
                CLOSE #11
                GOTO 2222

                CASE CHR$(27)
                CLS
                PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 10
                CALL hanzi("２编译", 5, 1, 3, 9)
                LOCATE 2, 10
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 10
                GOTO 1
                CASE ELSE
                  IF RIGHT$(ink$, 1) = CHR$(80) THEN
                   SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                        LOCATE 5, 13
                       CALL hanzi("１编译全部源程序", 6, 1, 4, 9)
                        LOCATE 7, 13
                        CALL hanzi("２编译主源程序", 3, 1, 4, 9)
                        LOCATE 7, 13
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 7, 13
                     CALL hanzi("２编译主源程序", 6, 1, 4, 9)
                     LOCATE 9, 13
                     CALL hanzi("３编译第二源程序", 3, 1, 4, 9)
                     LOCATE 9, 13
                     CASE 9
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 9, 13
                     CALL hanzi("３编译第二源程序", 6, 1, 4, 9)
                     LOCATE 11, 13
                     CALL hanzi("４编译第三源程序", 3, 1, 4, 9)
                     LOCATE 11, 13
                     CASE 11
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 56)-(POS(0) * 8 + 120, 75), 0, BF
                     LOCATE 11, 13
                     CALL hanzi("４编译第三源程序", 6, 1, 4, 9)
                     LOCATE 5, 13
                     CALL hanzi("１编译全部源程序", 3, 1, 4, 9)
                     LOCATE 5, 13
                   END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(72) THEN
                    SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 138)-(POS(0) * 8 + 120, 156), 0, BF
                     LOCATE 5, 13
                     CALL hanzi("１编译全部源程序", 6, 1, 4, 9)
                     LOCATE 11, 13
                     CALL hanzi("４编译第三源程序", 3, 1, 4, 9)
                     LOCATE 11, 13
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 7, 13
                     CALL hanzi("２编译主源程序", 6, 1, 4, 9)
                     LOCATE 5, 13
                     CALL hanzi("１编译全部源程序", 3, 1, 4, 9)
                     LOCATE 5, 13
                     CASE 9
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 9, 13
                     CALL hanzi("３编译第二源程序", 6, 1, 4, 9)
                     LOCATE 7, 13
                     CALL hanzi("２编译主源程序", 3, 1, 4, 9)
                     LOCATE 7, 13
                     CASE 11
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 11, 13
                     CALL hanzi("４编译第三源程序", 6, 1, 4, 9)
                     LOCATE 9, 13
                     CALL hanzi("３编译第二源程序", 3, 1, 4, 9)
                     LOCATE 9, 13
                   END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(77) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1004
                     END IF
                   IF RIGHT$(ink$, 1) = CHR$(75) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1001
                     END IF


                   IF ink$ = CHR$(13) THEN
                           SELECT CASE CSRLIN
                                   CASE 5
                                   ' "BIANYI QUANBU YUAN CHENGXU"
                                        OPEN "COMALLFI.SGN" FOR OUTPUT AS #3
                                        PRINT #3, " "
                                        CLOSE #3
                                        GOTO 2222

                                   CASE 7
                                   ' "BIANYI ZHU YUAN CHENGXU"
                                        OPEN "FRMAINFO.SGN" FOR OUTPUT AS #9
                                        PRINT #9, " "
                                        CLOSE #9
                                        GOTO 2222

                                   CASE 9
                                   ' "BIANYI DI ER YUAN CHENGXU"
                                        OPEN "FRSECOFO.SGN" FOR OUTPUT AS #10
                                        PRINT #10, " "
                                        CLOSE #10
                                        GOTO 2222

                                   CASE 11
                                   ' "BIANYI DI SAN YUAN CHENGXU"
                                        OPEN "FRTHIRFO.SGN" FOR OUTPUT AS #11
                                        PRINT #11, " "
                                        CLOSE #11
                                        GOTO 2222

                            END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(59) OR RIGHT$(ink$, 1) = CHR$(60) OR RIGHT$(ink$, 1) = CHR$(61) OR RIGHT$(ink$, 1) = CHR$(62) THEN
                  CALL rejian(ink$) ' rejian
                  GOTO 2222
                  END IF

                GOTO 22
           END SELECT
           RETURN

1004    PUT (0, 12), arr, PSET
       'yunxing
        LOCATE 2, 26
        CALL hanzi("４运行", 5, 1, 3, 9)

        LINE (205, 39)-(370, 120), 9, B
        LINE (208, 43)-(367, 116), 2, B
        LOCATE 5, 29
       CALL hanzi("１直接运行", 3, 1, 4, 9)

        LOCATE 7, 29
        CALL hanzi("２编译连接运行", 6, 1, 4, 9)
        LOCATE 5, 29
33      ink$ = INKEY$
        IF ink$ = "" THEN 33
        SOUND 200, 2
        SELECT CASE ink$
                CASE "1"
                ' "zhijie yunxing"
                OPEN "DERECRUN.SGN" FOR OUTPUT AS #4
                PRINT #4, " "
                CLOSE #4
                GOTO 2222

                CASE "2"
                ' "bianlian yun"
                OPEN "COLINRUN.SGN" FOR OUTPUT AS #2
                PRINT #2, " "
                CLOSE #2
                GOTO 2222

                CASE CHR$(27)
                CLS
                  PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 26
                CALL hanzi("４运行", 5, 1, 3, 9)
                LOCATE 2, 26
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 26
                GOTO 1
                CASE ELSE
                  IF RIGHT$(ink$, 1) = CHR$(80) OR RIGHT$(ink$, 1) = CHR$(72) THEN
                   SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 5, 29
                     CALL hanzi("１直接运行", 6, 1, 4, 9)
                     LOCATE 7, 29
                     CALL hanzi("２编译连接运行", 3, 1, 4, 9)
                     LOCATE 7, 29
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 56)-(POS(0) * 8 + 120, 72), 0, BF
                     LOCATE 7, 29
                     CALL hanzi("２编译连接运行", 6, 1, 4, 9)
                     LOCATE 5, 29
                     CALL hanzi("１直接运行", 3, 1, 4, 9)
                     LOCATE 5, 29
                  END SELECT
                  END IF
                   IF RIGHT$(ink$, 1) = CHR$(77) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1005
                     END IF
                   IF RIGHT$(ink$, 1) = CHR$(75) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1002
                     END IF
                  
                 
                  IF ink$ = CHR$(13) THEN
                   SELECT CASE CSRLIN
                    CASE 5
                    ' "zhijie run"
                OPEN "DERECRUN.SGN" FOR OUTPUT AS #4
                PRINT #4, " "
                CLOSE #4
                GOTO 2222

                    CASE 7
                    ' "bianyi lianjie run"
                OPEN "COLINRUN.SGN" FOR OUTPUT AS #2
                PRINT #2, " "
                CLOSE #2
                GOTO 2222

                  END SELECT
                  END IF
                  IF RIGHT$(ink$, 1) = CHR$(59) OR RIGHT$(ink$, 1) = CHR$(60) OR RIGHT$(ink$, 1) = CHR$(61) OR RIGHT$(ink$, 1) = CHR$(62) THEN
                  CALL rejian(ink$) ' rejian
                  GOTO 2222
                  END IF

                GOTO 33
           END SELECT
           RETURN

1005        'bianyi zi caidan
        PUT (0, 12), arr, PSET
        LOCATE 2, 34
        CALL hanzi("５打印", 5, 1, 3, 9)

        LINE (265, 39)-(430, 200), 9, B
        LINE (268, 43)-(427, 196), 2, B
        LOCATE 5, 36
       CALL hanzi("１打印全部源程序", 3, 1, 4, 9)
        LOCATE 7, 36
        CALL hanzi("２打印主源程序", 6, 1, 4, 9)
        LOCATE 9, 36
       CALL hanzi("３打印第二源程序", 6, 1, 4, 9)
        LOCATE 11, 36
       CALL hanzi("４打印第三源程序", 6, 1, 4, 9)
        LOCATE 5, 36

55      ink$ = INKEY$
        IF ink$ = "" THEN 55
        SOUND 200, 2
        SELECT CASE ink$
                CASE "1"
                '"dayin quanbu yuanchengxu"
                OPEN "lpralfor.sgn" FOR OUTPUT AS #15
                PRINT #15, " "
                CLOSE #15
                GOTO 2222

                CASE "2"
                ' "dayin zhuyuan for"
                OPEN "lprmnfor.sgn" FOR OUTPUT AS #12
                PRINT #12, " "
                CLOSE #12
                GOTO 2222

                CASE "3"
                '"dayin di er for"
                OPEN "lpra2for.sgn" FOR OUTPUT AS #13
                PRINT #13, " "
                CLOSE #13
                GOTO 2222

                CASE "4"
                '"dayin disan for"
                OPEN "lpra3for.sgn" FOR OUTPUT AS #14
                PRINT #14, " "
                CLOSE #14
                GOTO 2222

                CASE CHR$(27)
                CLS
                  PUT (x0, y0), crr, PSET
                PUT (0, 12), arr, PSET
                LOCATE 2, 34
                CALL hanzi("５打印", 5, 1, 3, 9)
                PUT (0, 306), brr, PSET
                LINE (0, 36)-(639, 300), 3, B
                LOCATE 2, 34
                GOTO 1
                CASE ELSE
                  IF RIGHT$(ink$, 1) = CHR$(80) THEN
                   SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                        LOCATE 5, 36
                       CALL hanzi("１打印全部源程序", 6, 1, 4, 9)
                        LOCATE 7, 36
                        CALL hanzi("２打印主源程序", 3, 1, 4, 9)
                        LOCATE 7, 36
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 7, 36
                     CALL hanzi("２打印主源程序", 6, 1, 4, 9)
                     LOCATE 9, 36
                     CALL hanzi("３打印第二源程序", 3, 1, 4, 9)
                     LOCATE 9, 36
                     CASE 9
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN + 1) * 14)-(POS(0) * 8 + 120, (CSRLIN + 2) * 14 + 5), 0, BF
                     LOCATE 9, 36
                     CALL hanzi("３打印第二源程序", 6, 1, 4, 9)
                     LOCATE 11, 36
                     CALL hanzi("４打印第三源程序", 3, 1, 4, 9)
                     LOCATE 11, 36
                     CASE 11
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 56)-(POS(0) * 8 + 120, 75), 0, BF
                     LOCATE 11, 36
                     CALL hanzi("４打印第三源程序", 6, 1, 4, 9)
                     LOCATE 5, 36
                     CALL hanzi("１打印全部源程序", 3, 1, 4, 9)
                     LOCATE 5, 36
                   END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(72) THEN
                    SELECT CASE CSRLIN
                    CASE 5
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, 138)-(POS(0) * 8 + 120, 156), 0, BF
                     LOCATE 5, 36
                     CALL hanzi("１打印全部源程序", 6, 1, 4, 9)
                     LOCATE 11, 36
                     CALL hanzi("４打印第三源程序", 3, 1, 4, 9)
                     LOCATE 11, 36
                     CASE 7
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 7, 36
                     CALL hanzi("２打印主源程序", 6, 1, 4, 9)
                     LOCATE 5, 36
                     CALL hanzi("１打印全部源程序", 3, 1, 4, 9)
                     LOCATE 5, 36
                     CASE 9
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 9, 36
                     CALL hanzi("３打印第二源程序", 6, 1, 4, 9)
                     LOCATE 7, 36
                     CALL hanzi("２打印主源程序", 3, 1, 4, 9)
                     LOCATE 7, 36
                     CASE 11
                     LINE (POS(0) * 8 - 7, (CSRLIN - 1) * 14)-(POS(0) * 8 + 120, CSRLIN * 14 + 5), 0, BF
                     LINE (POS(0) * 8 - 7, (CSRLIN - 3) * 14)-(POS(0) * 8 + 120, (CSRLIN - 2) * 14 + 5), 0, BF
                     LOCATE 11, 36
                     CALL hanzi("４打印第三源程序", 6, 1, 4, 9)
                     LOCATE 9, 36
                     CALL hanzi("３打印第二源程序", 3, 1, 4, 9)
                     LOCATE 9, 36
                   END SELECT
                   END IF
                   IF RIGHT$(ink$, 1) = CHR$(77) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1001
                     END IF
                   IF RIGHT$(ink$, 1) = CHR$(75) THEN
                   CLS
                     PUT (x0, y0), crr, PSET
                     LINE (0, 36)-(639, 300), 3, B
                     PUT (0, 306), brr, PSET
                     GOSUB 1004

                     END IF

                   IF ink$ = CHR$(13) THEN
                           SELECT CASE CSRLIN
                                   CASE 5
                                   ' "dayin QUANBU YUAN CHENGXU"
                                        OPEN "lpralfor.sgn" FOR OUTPUT AS #15
                                        PRINT #15, " "
                                        CLOSE #15
                                        GOTO 2222

                                   CASE 7
                                   ' "dayin ZHU YUAN CHENGXU"
                                        OPEN "lprmnfor.sgn" FOR OUTPUT AS #12
                                        PRINT #12, " "
                                        CLOSE #12
                                        GOTO 2222

                                   CASE 9
                                   '"dayin DI ER YUAN CHENGXU"
                                        OPEN "lpra2for.sgn" FOR OUTPUT AS #13
                                        PRINT #13, " "
                                        CLOSE #13
                                        GOTO 2222

                                   CASE 11
                                   '"dayin DI SAN YUAN CHENGXU"
                                        OPEN "lpra3for.sgn" FOR OUTPUT AS #14
                                        PRINT #14, " "
                                        CLOSE #14
                                        GOTO 2222

                            END SELECT
                   END IF
                  IF RIGHT$(ink$, 1) = CHR$(59) OR RIGHT$(ink$, 1) = CHR$(60) OR RIGHT$(ink$, 1) = CHR$(61) OR RIGHT$(ink$, 1) = CHR$(62) THEN
                  CALL rejian(ink$) ' rejian
                  GOTO 2222
                  END IF
                GOTO 55
           END SELECT
           RETURN

          SUB rejian (inke$)
             IF RIGHT$(inke$, 1) = CHR$(59) THEN
             '"quanbu bianyi"
                OPEN "COMALLFI.SGN" FOR OUTPUT AS #3
                PRINT #3, " "
                CLOSE #3
             END IF
             IF RIGHT$(inke$, 1) = CHR$(60) THEN
             ' "bianyi lianjie yunxing"
                OPEN "COLINRUN.SGN" FOR OUTPUT AS #2
                PRINT #2, " "
                CLOSE #2

             END IF
             IF RIGHT$(inke$, 1) = CHR$(61) THEN
             ' "zhijie yunxing"
                OPEN "DERECRUN.SGN" FOR OUTPUT AS #4
                PRINT #4, " "
                CLOSE #4
             END IF
             IF RIGHT$(inke$, 1) = CHR$(62) THEN
             '"dayin quanbu yuan chengxu"
             OPEN "lpralfor.sgn" FOR OUTPUT AS #15
             PRINT #15, " "
             CLOSE #15
             END IF

END SUB

