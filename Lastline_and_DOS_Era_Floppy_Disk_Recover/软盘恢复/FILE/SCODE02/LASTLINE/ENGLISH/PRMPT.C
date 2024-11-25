/* PRMPT.c 1993 12 21, English version 2.0, */
/* Passed DOS 3.3a,DOS 5.0,DOS 6.0*/
/* Computer type passed:GW286,COMPAQ 386/33(25),AST 286*/
/*      Antai 286 ,At&t 386,DELL 433DE ,NONAME 286 ,so on*/
/************************************************************/
#include <stdio.h>
#include "twindow.h"
#include "keys.h"
#include <string.h>
#include <dir.h>
#include <dos.h>
#include <io.h>
#include <stdlib.h>
#include <process.h>
#include <ctype.h>
main()
{
   WINDOW *inf,*tit,*inff,*titt;
   FILE *fp;
   int x,y;
   char k;
   x=wherex();y=wherey();
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
   inff=establish_window(12,12,5,60);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[0]=0x33;
   set_border(inff,3);
   display_window(inff);
   inf=establish_window(10,11,5,60);
   set_colors(inf,ALL,BLUE,YELLOW,BRIGHT);
   inf->wcolor[0]=0x11;
   set_border(inf,3);
   display_window(inf);
  wprintf(inf,"\n   Necessary files has been copied.\n   Now,beginning backup...\n");
  wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any key to continue...");
  getch();
  close_all();
  gotoxy(x,y);
 }