@echo off
echo ************************************************
echo * THESE FILES MUST EXIST:                      *
ECHO *   1.SOURCE.C                                 *
ECHO *      IT INCLUDES ALL FILES THAT YOU WANT TO  *
ECHO *      CHANGE TO USE SMALL CHINESE LIB,   AND  *
ECHO *      ENDS BY {end}.                          *
ECHO *   2.CCLIB                                    *
ECHO *      IT IS A GB CHINESE LIB.                 * 
ECHO * CAUTIONS:                                    *
ECHO *   YOU SHOULD SAVE YOU SOURCE_FILE SAFELY.    *
ECHO * DURING CHANGING ,THE NEW FILES WILL BE SAVED *
ECHO * IN THE SAME NAMES.                           *
ECHO *                                              *
ECHO *  IF YOU ARE NOT READY,PRESS CTRL-C           *
ECHO ************************************************
PAUSE
findhz
hzsort
mkhzk
chg
echo **********************************************
echo *Have created files:                         *
echo *  Small chinese lib: LSTH.INF .             *
echo *  Dictionary: LSTDIC .                      *
echo *  Text chinese file: LSTHZ .                *
echo *  Source files are saved with the same name.*
echo **********************************************
