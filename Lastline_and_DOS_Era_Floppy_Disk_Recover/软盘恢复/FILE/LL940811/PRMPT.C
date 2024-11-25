/*******************************************************************
  File name:     PRMPT.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          8/12/94
  Author:        WangQuan
  Function:      To be used in INSTALL.C LASTLINE 2.5 Chinese version.
		 Becouse of system().
  Usage:         Used in INSTALL.C.
		   system("prmpt");
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

#include "twingra.h"
main()
{
  WINGRA *inf;
  title("c:\\lastline\\lsth.inf");
  inf=open_win(8,10,18,70,1,1);
  puthz(inf,"\n\n\n  现在,请移开A:驱中的盘,需热启动.\n然后,请设置CMOS为先从A:盘引导.",14,1);
  puthz(inf,"\n按任意键热启动...",15,1);
  getch();
  printf("\x7");
}