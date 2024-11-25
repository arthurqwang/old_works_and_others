/*******************************************************************
  File name:     DELLL.C
  Belong to:     LASTLINE 2.5 English & Chinese version
  Date:          8/12/94
  Author:        WangQuan
  Function:      To DELETE LASTLINE 2.5 from harddisk.
		 English & Chinese versions use the same DELLL.
  Usage:         X:\ANYPATH>Y:\ANYPATH\delll<CR>
		   X:,Y: = A:,B:,C:,D:...
  Where stored:  Floppy disk "LASTLINE 2.5 English(or Chinese) version
		 Source files"(LASTLINE 2.5 Ying(Zhong)wenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

#include "twindow.h"
#include "keys.h"
#include <stdio.h>
#include <dir.h>
#include <dos.h>
void getaline(FILE *fp,char *aline);
unsigned get_disk_num(void);
int readparttable(int way);
unsigned char part[512];
WINDOW *inf;
main()
 {
   FILE *aut,*temp,*fp;
   WINDOW *tit,*titt,*inff;
   char k;
   unsigned maxdisk,i,x,y;
   unsigned char fatroot[200]="C:\\FAT&ROOT.IMG",tempname[100],aline[200];
   x=wherex();y=wherey();
   inff=establish_window(3,1,8,64);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[BORDER]=0x33;
   set_border(inff,3);
   display_window(inff);
   inf=establish_window(1,0,8,64);
   set_colors(inf,ALL,BLUE,WHITE,BRIGHT);
   inf->wcolor[BORDER]=0x11;
   set_border(inf,3);
   display_window(inf);
   wclrprintf(inf,BLUE,YELLOW,BRIGHT,"                     LASTLINE Version 2.5\n");
   wprintf(inf,"             (C) Copyright DongLe Computer Corp.\n");
   wprintf(inf,"                Designed & Coded by WANGQUAN");
   wclrprintf(inf,BLUE,YELLOW,BRIGHT,"\n\n                  DELLL: Eraser for LASTLINE .  \n");
   printf("\x7");
   wprintf(inf,"           Remove LASTLINE from HARDDISK,Sure?[N]\b\b");
   k=getch();
   if(toupper(k)!='Y')
       {
	close_all();
	gotoxy(x,y);
	exit(0);
       }
   wprintf(inf,"Y");
   wcursor(inf,11,5);
   wprintf(inf,"                                                          ");
   wcursor(inf,20,5);
   system("c:>c:\\aaaaaaaa.aaa");
   system("cd\\lastline>c:\\aaaaaaaa.aaa");
   _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
   fp=fopen("c:\\lastline\\mngrboot.exe","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("mngrboot.exe");
   fp=fopen("c:\\lastline\\fatrsave.exe","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("fatrsave.exe");
   fclose(fp);
   fp=fopen("c:\\lastline\\trans.lst","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("trans.lst");
   remove("lsth.inf");
   fp=fopen("c:\\lastline\\lastline.cfg","wb");
   fwrite(aline,501,1,fp);
   fclose(fp);
   remove("lastline.cfg");
   system("cd\\>c:\\aaaaaaaa.aaa");
   remove("aaaaaaaa.aaa");
   rmdir("c:\\lastline");
   rename("AUTOEXEC.BAT","aaaaaaaa.aaa");
   temp=fopen("aaaaaaaa.aaa","rt");
   aut=fopen("AUTOEXEC.BAT","wt");
   while(!feof(temp))
    {
      getaline(temp,aline);
      strupr(aline);
      if(!(strstr(aline,"MNGRBOOT")||strstr(aline,"FATRSAVE")))
	{
	 fputs(aline,aut);
	 fputc('\n',aut);
	}
    }
    fcloseall();
   remove("aaaaaaaa.aaa");
   wcursor(inf,1,5);
   wprintf(inf,"              Over.   Press any key to exit...");
   getch();
   close_all();
   gotoxy(x,y);
 }
void getaline(FILE *fp,char *aline)
{
  int i=0,ch;
  for(i=0;i<10000;i++)
  {
    ch=fgetc(fp);
    if((ch=='\n')||(ch==EOF))
     {
      aline[i]=0;
      return;
     }
    else
     aline[i]=ch;
  }
}



