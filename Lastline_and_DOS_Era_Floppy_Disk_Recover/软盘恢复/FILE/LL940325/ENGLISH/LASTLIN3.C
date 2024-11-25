/* LASTLIN3.c 1994 3 14, English version 2.0, */
/* Passed DOS 3.3a,DOS 5.0,DOS 6.0*/
/* Computer type passed:GW286,COMPAQ 386/33(25),AST 286*/
/*      Antai 286 ,At&t 386,DELL 433DE ,NONAME 286 ,so on*/
/****************************************************************/
#include <dos.h>
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
   anti_trace();
   titt=establish_window(17,6,4,50);
   set_colors(titt,ALL,3,WHITE,BRIGHT);
   titt->wcolor[0]=0x33;
   set_border(titt,3);
   display_window(titt);
   tit=establish_window(15,5,4,50);
   set_colors(tit,ALL,BLUE,WHITE,BRIGHT);
   tit->wcolor[0]=0x11;
   set_border(tit,3);
   display_window(tit);
   wprintf(tit,"              LASTLINE Version 2.0\n          (C) Copyright ");
   wprintf(tit,"%c%c%c%c%c%c%c%c",87,65,78,71,81,85,65,78);
   wprintf(tit," 1993.");
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
   setdisk(0);
   system("c:\\lastline\\trans c:>c:\\aaaaaa.aaa");
   system("del c:\\aaaaaa.aaa");
   close_all();
   gotoxy(x,y);
   setdisk(di);
   can_trace();
   exit(0);
 }

void reboot(void)
 {
     union REGS in,out;
     system("cls");
     int86(0x19,&in,&out);
 }
