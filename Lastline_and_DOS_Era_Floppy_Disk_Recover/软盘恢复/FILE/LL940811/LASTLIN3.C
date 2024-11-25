
/*******************************************************************
  File name:     LASTLIN3.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          8/12/94
  Author:        WangQuan
  Function:      To repare system kenel.It calls SYS.COM of DOS.
  Usage:         X:\ANYPATH>Y:\ANYPATH\lastlin3<CR>
		   X:,Y: = A:,B:,C:...
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

/********************************************************/
#include "twingra.h"
#include <dos.h>
void reboot(void);
void puticon(int lgdrive);
union REGS in,out;
WINGRA *inf,*icon;
extern high_of_char,CCLIB;
main(int argc ,char *argv[])
 {
   int key,olddvr;
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   title("\\lsth.inf");
   icon=open_win(8,10,12,70,1,0);
   puthz(icon,"修复系统核心",14,1);
   high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
   puticon(2);
   inf=open_win(14,10,24,70,1,1);
   puthz(inf,"  请在A:盘插入与硬盘版本相同的DOS引导盘(LASTLINE软盘\n",14,1);
   puthz(inf,"可做为 DOS 5.0 的引导盘). 若正在运行的DOS 与硬盘原有\n",14,1);
   puthz(inf,"的不同,则需用相同版本热起动,然后再次运行 LASTLIN3.\n",14,1);
   puthz(inf,"需要热起动吗?[N]\b\b",15,1);
   key=getch();
   printf("\x7");
   if(toupper(key)=='Y')
     {
       puthz(inf," \bY\n",15,1);
       reboot();
     }
   puthz(inf,"\n正在修复...",14,1);
   system("C:");
   system("cd\\lastline");
   system("ren trans.lst trans.exe>c:\\aaaaaa.aaa");
   setdisk(0);
   system("C:\\lastline\\trans c:>c:\\aaaaaa.aaa");
   system("C:");
   system("cd\\lastline");
   system("ren trans.exe trans.lst>c:\\aaaaaa.aaa");
   system("del c:\\aaaaaa.aaa");
   close(CCLIB);
   setdisk(olddvr);
   cleardevice();
   restorecrtmode();
 }
void reboot(void)
 {
     union REGS in,out;
     close(CCLIB);
     cleardevice();
     restorecrtmode();
     int86(0x19,&in,&out);
 }
void puticon(int lgdrive)/* lgdrive=0,put main boot record icon */
 {
   int i;
   char a[2]="C";
   static int x=220;
   setfillstyle(1,1);
   high(x,high_of_char*8+2,x+30,high_of_char*10,1,1);
   nohigh(x+1,high_of_char*8+3,x+29,high_of_char*10-1,1,1);
   setcolor((lgdrive==0)?15:(16-lgdrive));
   for (i=high_of_char*9+4;i>high_of_char*9-6;i-=2)
   fillellipse(x+15,i,8,4);
   fillellipse(x+15,i+2,4,2);
   setfillstyle(1,15);
     outtextxy(x-8,high_of_char*10+5,"SYSTEM");
 }
