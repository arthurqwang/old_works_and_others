

/*LASTLIN3.C  CHINESE VERSION 2.0  1994 3 12*/
/*Passed DOS 3.3a,DOS5.0,DOS 6.0 */
/*Passed computer type :GW286,DELL 433DE(486,1000M HD)*/
/*     Noname 286,ANTAI 286,AST 286,AT&T 386,COMPAQ 386/33(25)*/
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
   anti_trace();
   title("\\lsth.inf");
   icon=open_win(8,10,12,70,1,0);
   puthz(icon,"修复系统核心",14,1);
   high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
   puticon(2);
   inf=open_win(14,10,24,70,1,1);
   puthz(inf,"请在 A:盘插入与硬盘版本相同的DOS引导盘(LASTLINE 软盘\n",14,1);
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
   setdisk(0);
   system("c:\\lastline\\trans c:>c:\\aaaaaa.aaa");
   system("del c:\\aaaaaa.aaa");
   setdisk(olddvr);
   restorecrtmode();
   can_trace();
 }
void reboot(void)
 {
     union REGS in,out;
     restorecrtmode();
     system("cls");
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
