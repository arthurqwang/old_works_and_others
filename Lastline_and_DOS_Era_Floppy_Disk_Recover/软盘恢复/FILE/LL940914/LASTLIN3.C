/*******************************************************************
  File name:     LASTLIN3.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          9/13/94
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
void quit(int i);
void get_BK(void);

union REGS in,out;
WINGRA *inf,*icon;
unsigned char dvr[10]="A:*.*";
unsigned BKHEAD,BKTRACK;
extern high_of_char,CCLIB;
int olddvr;
main(int argc ,char *argv[])
 {
   int key;
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   title("\\lsth.inf");
   wrt_SN_with_fd();
   icon=open_win(8,10,12,70,1,0);
   puthz(icon,"修复系统核心",14,1);
   high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
   puticon(2);
   inf=open_win(14,10,24,70,1,1);
   puthz(inf,"  请在A:盘插入与硬盘版本相同的DOS引导盘(LASTLINE软盘\n",14,1);
   puthz(inf,"可做为 DOS 5.0 的引导盘). 若正在运行的DOS 与硬盘原有\n",14,1);
   puthz(inf,"的不同,则需用相同版本热起动,然后再次运行 LASTLIN3.\n",14,1);
   puthz(inf,"需要热起动吗?[N]\b\b",15,1);
   key=get_ch();
   printf("\x7");
   if(toupper(key)=='Y')
     {
       puthz(inf," \bY\n",15,1);
       puthz(inf,"\n按<Ctrl+Alt+Del>键热启动...",15,1);
       printf("\x7");
       reboot();
     }
   puthz(inf,"\n正在修复...",14,1);
   system("C:");
   system("cd\\lastline");
   system("ren trans.lst trans.exe>NUL");
   setdisk(0);
   system("C:\\lastline\\trans c:>NUL");
   system("C:");
   system("cd\\lastline");
   system("ren trans.exe trans.lst>NUL");
   puthz(inf,"\n完毕.\n",14,1);
   setdisk(olddvr);
   quit(0);
 }
void reboot(void)
 {
/*     union REGS in,out;*/
     close(CCLIB);
/*     cleardevice();
     restorecrtmode();
     int86(0x19,&in,&out);*/
     while(1);
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
void quit(int i)
{
 printf("\x7");
 puthz(inf,"\n 按任意键退出...",15,1);
 close(CCLIB);
 get_ch();
 printf("\x7");
 cleardevice();
 restorecrtmode();
 setdisk(olddvr);
 exit(i);
}

void get_BK(void)
 {
   unsigned char tttt[512];
   unsigned HD_base_table_adr[4],temp[3],a=0,b=0x400;
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-1;
/*   BKHEAD=(temp[2]&0xff)-1;*/
   BKHEAD=0;
   if(BKTRACK > 0x3FF)
    {
      BKTRACK=0x3FF;BKTRACK=0;
      if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
       {
	BKTRACK=0x200;
	while( (b-a)>1 )
	 {
	   if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
	      b=BKTRACK;
	   else
	   a=BKTRACK;
	   BKTRACK=(a+b)/2;
	 }
       }
    }
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