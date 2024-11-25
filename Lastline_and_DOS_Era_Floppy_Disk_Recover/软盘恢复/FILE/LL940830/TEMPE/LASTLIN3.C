/*******************************************************************
  File name:     LASTLIN3.C
  Belong to:     LASTLINE 2.5 English version
  Date:          8/29/94
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
void quit(int i);
unsigned get_SN_from_fd(void);
void get_BK(void);
unsigned char dvr[10]="A:*.*";
WINDOW *tit,*titt,*inf,*inff;
int x,y,di;
unsigned BKHEAD,BKTRACK;
main(int argc,char *argv[])
 {
   int key;
   unsigned SN;
   dvr[0]=toupper(argv[0][0]);
   SN=get_SN_from_fd();
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
   wclrprintf(tit,BLUE,YELLOW,BRIGHT,
		    "         LASTLINE Version 2.5  SN:%06u\n",SN);
   wprintf(tit,"   (C) Copyright(1994.9) DongLe Computer Corp. \n");
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
   wprintf(inf,"   Insert DOS system disk in drive A:,please.\n");
   wprintf(inf,"   Its version must be the same as in your hard disk.\n");
   wprintf(inf,"   LASTLINE 2.5 DISK is a DOS 5.0 system disk.\n");
   wprintf(inf,"\n   If the running DOS is different from that in your\n");
   wprintf(inf,"   hard disk, reboot the same DOS version, then run \n");
   wprintf(inf,"   LASTLIN3 again.\n");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n   Reboot?[N]\b\b");
   key=get_ch();
   printf("\x7");
   if(toupper(key)=='Y')
     {
      wclrprintf(inf,BLUE,WHITE,BRIGHT,"Y");
      wclrprintf(inf,BLUE,WHITE,BRIGHT,
		      "\n  Press <Ctrl+Alt+Del> to reboot...");
      reboot();
     }
   wprintf(inf,"\n\n   Repairing...\n   ");
   system("c:");
   system("cd\\lastline");
   system("ren trans.lst trans.exe>c:\\aaaaaa.ll$");
   setdisk(0);
   system("c:\\lastline\\trans c:>c:\\aaaaaa.ll$");
   system("c:");
   system("cd\\lastline");
   system("ren trans.exe trans.lst>c:\\aaaaaa.ll$");
   system("del c:\\aaaaaa.ll$");
   wprintf(inf,"\n   Done.\n");
   quit(1);
 }

void reboot(void)
 {
/*     union REGS in,out;*/
/*     clrscr();*/
/*     int86(0x19,&in,&out);*/
     while(1);
 }
void quit(int i)
{
  printf("\x7");
  wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to quit...");
  get_ch();
  printf("\x7");wprintf(inf,"\n");
  close_all();
  gotoxy(x,y);
  setdisk(di);
/*  restorecrtmode();*/
  exit(i);
}

unsigned get_SN_from_fd(void)
{
  unsigned SN;
  unsigned char part[512];
  if(absread(toupper(dvr[0])-65,1,0,part))
    if(absread(toupper(dvr[0])-65,1,0,part))
     if(absread(toupper(dvr[0])-65,1,0,part))
       ;
  SN = part[0x27]+part[0x28]*256;
  return SN;
}