/*******************************************************************
  File name:     SV1.C
  Belong to:     Saviour 3.0 Chinese version
  Date:          FEB/7/96
  Author:        WangQuan
  Function:      To repare BOOT RECORD.It calls BTM.EXE.
  Usage:         X:\ANYPATH>Y:SV1<CR>
		   X: = A:,B:,C:...   Y: = A:,B: .
  Where stored:  Floppy disk "Saviour 3.0 Chinese version
		 Source files"(Saviour 3.0 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2,DOS 6.21
  Computer
       passed:   GW286,COMPAQ 386/33(25),386,486,586,AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/


#include <stdio.h>
#include <dir.h>
#include <process.h>
#include <dos.h>
main(int argc ,char *argv[])
  {
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   execl("BTMNGR","BTMNGR",NULL);
  }

