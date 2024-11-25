/*******************************************************************
  File name:     INSTALL.C
  Belong to:     LASTLINE 2.5 English & Chinese version
  Date:          9/13/94
  Author:        WangQuan
  Function:      To install LASTLINE 2.5 Chinese version.
  Usage:         X:\ANYPATH>Y:install<CR>
		   X: = A:,B:,C:...  Y: = A:,B: .
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Yingwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/
#include <stdlib.h>
#include <stdio.h>
main(int argc,char *argv[])
{
   unsigned char V_env[]="KEY=A",V_exe[]="A:LOADLL>NUL";
   int olddvr;
   olddvr=getdisk();
   V_env[4] = V_exe[0] = toupper(argv[0][0]);
   putenv(V_env);
   putenv("LASTLINE=ON");
   setdisk(toupper(argv[0][0])-'A');
   system(V_exe);
   setdisk(olddvr);
}

