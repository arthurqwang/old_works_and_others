/*******************************************************************
  File name:     LASTLIN3.C
  Belong to:     LASTLINE 2.5 English version
  Date:          8/12/94
  Author:        WangQuan
  Function:      To repare system kernel.It calls SYS.COM of DOS.
  Usage:         X:\ANYPATH>Y:\ANYPATH\lastlin3<CR>
		   X:,Y: = A:,B:,C:...
  Where stored:  Floppy disk "LASTLINE 2.5 English version
		 Source files"(LASTLINE 2.5 Yingwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

/****************************************************************/
#include <dos.h>
#include <conio.h>
#include "twindow.h"
#include "keys.h"
void reboot(void);
WINDOW *tit,*titt,*inf,*inff;
int x,y;
main()
 {
   int key,di;
   di=getdisk();
   x=wherex();y=wherey();
/*   anti_trace();*/
   titt=establish_window(17,5,5,50);
   set_colors(titt,ALL,3,WHITE,BRIGHT);
   titt->wcolor[BORDER]=0x33;
   set_border(titt,3);
   display_window(titt);
   tit=establish_window(15,4,5,50);
   set_colors(tit,ALL,BLUE,WHITE,BRIGHT);
   tit->wcolor[BORDER]=0x11;
   set_border(tit,3);
   display_window(tit);
   wclrprintf(tit,BLUE,YELLOW,BRIGHT,"              LASTLINE Version 2.5\n");
   wprintf(tit,"      (C) Copyright DongLe Computer Corp. \n");
   wprintf(tit,"          Designed & Coded by ");
   wprintf(tit,"%c%c%c%c%c%c%c%c",87,65,78,71,81,85,65,78);
   inff=establish_window(12,12,12,60);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[0]=0x33;
   set_border(inff,3);
   display_window(inff);
   inf=establish_window(10,11,12,60);
   set_colors(inf,ALL,BLUE,YELLOW,BRIGHT);
   inf->wcolor[0]=0x11;
   set_border(inf,3);
   display_window(inf);
   wprintf(inf,"   Insert DOS-SYSTEM-DISK in drive A:,please.\n");
   wprintf(inf,"   Its version must be equal to HARD-DISK's.\n");
   wprintf(inf,"   (LASTLINE disk may be SYSTEM-DISK of DOS 5.0)\n");
   wprintf(inf,"\n   If the active DOS(being running) is different from\n");
   wprintf(inf,"   HARD-DISK's,You must reboot with the same DOS in \n");
   wprintf(inf,"   drive A:,then run LASTLIN3 again.\n");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n   Reboot?[N]\b\b");
   key=getch();
   printf("\x7");
   if(toupper(key)=='Y')
     {
      wclrprintf(inf,BLUE,WHITE,BRIGHT,"Y");
      reboot();
     }
   wprintf(inf,"\n\n\n   Reparing...");
   system("c:");
   system("cd\\lastline");
   system("ren trans.lst trans.exe>c:\\aaaaaa.aaa");
   setdisk(0);
   system("c:\\lastline\\trans c:>c:\\aaaaaa.aaa");
   system("c:");
   system("cd\\lastline");
   system("ren trans.exe trans.lst>c:\\aaaaaa.aaa");
   system("del c:\\aaaaaa.aaa");
   close_all();
   gotoxy(x,y);
   setdisk(di);
/*   can_trace();     */
   exit(0);
 }

void reboot(void)
 {
     union REGS in,out;
     clrscr();
     int86(0x19,&in,&out);
 }
