/******************************************************************
  File name:     MNGRBOOT.C
  Belong to:     LASTLINE 2.5 English version
  Date:          8/12/94
  Author:        WangQuan
  Function:      To manager(backup,compare,repare) BOOT RECORD.
  Usage:
		 BACKUP:
		    X:\ANYPATH>Y:\ANYPATH\mngrboot/b<CR>
		 COMPARE:
		    X:\ANYPATH>Y:\ANYPATH\mngrboot/c<CR>
		 REPARE:
		    X:\ANYPATH>Z:mngrboot<CR>
		 HELP:
		    X:\ANYPATH>Y:\ANYPATH\mngrboot/?<CR>

		    X:,Y: = A:,B:,C:,D:...  Z: = A:,B:.
		    BUT C:\LASTLINE\LASTLINE.CFG must be OK.
		    Must in floppy disk when reparing.
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
#include <fcntl.h>
#include <io.h>
#include <conio.h>
#include <string.h>
#include <bios.h>
#include <dos.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include <dir.h>
#include "twindow.h"
#include "keys.h"
#define BPS 512
#define HEAD (int)part[i]&0xff
#define SECTOR (int)part[i+1]&0xff
#define TRACK (int)part[i+2]&0xff
#define THISDISKEXIST (((int)part[i]&0xff)!=0)||(((int)part[i+1]&0xff)!=0)||(((int)part[i+2]&0xff)!=0)
#define DISKRESET biosdisk(0,drive,0,0,0,0,0)
int readmainboot(int drive);
int readdosboot(int drive,int head,int sector,int track,int isector);
int writemainboot(int drive);
int writedosboot(int drive,int head,int sector,int track,int isector);
int loadmainboot(int drive);
int loadmainbootagain(int drive);
int loaddosboot(int drive,int isector);
int loaddosbootagain(int drive,int isector);
int savemainboot(int drive);
int savedosboot(int drive,int isector);
int loadparttable(int drive);
int loadparttableagain(int drive);
int  readparttable(int way);
void saveparttable(int drive);
void infwq(void);
unsigned check_lock(int drive);
void get_BK(void);
void check_sec(void);
void reboot(void);
void call_at(void);
int get_MAY_WRITE_TO_H_SEC(void);
void quit(int i);

char part[BPS],boot[BPS];
unsigned  BKTRACK,BKHEAD,MAY_WRITE_TO_H_SEC;
WINDOW *tit,*titt,*inf,*inff;
int x,y;
char dvr[10]="A:*.*";
void main(int argc,char *argv[])
 {
   short unsigned int drive=0x80,isector,i,key;
   dvr[0]=toupper(argv[0][0]);
   x=wherex();y=wherey();
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
   inff=establish_window(12,12,10,60);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[0]=0x33;
   set_border(inff,3);
   display_window(inff);
   inf=establish_window(10,11,10,60);
   set_colors(inf,ALL,BLUE,YELLOW,BRIGHT);
   inf->wcolor[0]=0x11;
   set_border(inf,3);
   display_window(inf);
   if((argc==2 && strcmp(strupr(argv[1]),"/C") && strcmp(strupr(argv[1]),"/B")
      && strcmp(strupr(argv[1]),"/I") && strcmp(strupr(argv[1]),"/?"))||(argc>2))
     {
       wprintf(inf,"  Invalid format.\n  Usage:    MNGRBOOT [ [/C] or [/B] or [/?] ]\n");
       quit(1);
     }
/*   call_at();*//* include anti_trace */
   get_BK();
   if(argc==1)
     {
      int sig=0;
      check_sec();
      MAY_WRITE_TO_H_SEC=0;
      wprintf(inf,"  Replace MAIN BOOT RECORD?[Y]\b\b");
k1:   key=getch();
      printf("\x7");
      if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k1;
      if(toupper(key)!='N')
	{
	  if(loadmainboot(drive)!=-1 && writemainboot(drive)!=-1)
	    {
	      wprintf(inf,"\n  Over.\n");
	      sig=1;
	    }
	  else
	    wprintf(inf,"  Skipped.\n");
	}
      else
	{
	  wprintf(inf,"N\n");
	  wprintf(inf,"  Skipped.\n");
	}
      if(!loadparttable(drive))
	readparttable(0);
      i=1;isector=8;
      while((THISDISKEXIST)&&(isector>1))
	{
	  wprintf(inf,"  Replace DOS BOOT RECORD for logical disk %c:?[Y]\b\b", 75-isector);
k2:	  key =getch();
          printf("\x7");
	  if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	     goto k2;
          if(toupper(key)!='N')
	    {
	      if(loaddosboot(drive,isector)!= -1 && writedosboot(drive,HEAD,SECTOR,TRACK,isector)!= -1)
		{
		  wprintf(inf,"\n  Over.\n");
		  sig=1;
		}
	      else
		wprintf(inf,"  Skipped.\n");
	    }
	  else
	    {
	      wprintf(inf,"N\n");
	      wprintf(inf,"  Skipped.\n");
	    }
	  isector--;i+=3;
	}
      if(sig==1)
	{
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Now,insert LASTLINE disk or SYSTEM disk into drive A:.\n");
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to reboot...");
	 getch();
         printf("\x7");wprintf(inf,"\n");
	 close_all();
	 printf("\n");
	 reboot();
	}
      else
	 quit(0);
   }
   if(!strcmp(strupr(argv[1]),"/C"))
     {
       char tpart[BPS],tboot[BPS];
       int sig=0;
       /*if(check_lock(drive)==0) quit(1);*/
       MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
       if(readmainboot(drive)==-1) goto PDOSBOOT;
       memcpy(tpart,part,BPS);
       if(loadmainboot(drive)==-1) goto PDOSBOOT;
       if(memcmp(tpart,part,BPS))
	 {
	  printf("\x7\x7\x7");
	  wprintf(inf,"  MAIN BOOT RECORD has been changed!\n");
	  wprintf(inf,"  Update with original copy? [Y]\b\b");
kkk:	  key=getch();
	  printf("\x7");
	  if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	     goto  kkk;
	  if(toupper(key)!='N')
	    {
              sig=1;
	      if(writemainboot(drive)== -1) goto PDOSBOOT;
	      wprintf(inf,"\n  Over.\n");
	    }
	  else
	    wprintf(inf,"N\n");
	 }
       else
       wprintf(inf,"  MAIN BOOT RECORD OK.\n");
PDOSBOOT:
       if(!loadparttable(drive))
	 readparttable(0);
       i=1;isector=8;
       while((THISDISKEXIST)&&(isector>1))
	 {
	  if(readdosboot(drive,HEAD,SECTOR,TRACK, isector)==-1) goto CONTI;
	  memcpy(tboot,boot,BPS);
	  if(loaddosboot(drive,isector)==-1) goto CONTI;
	  if(memcmp(tboot,boot,BPS))
	   {
	     printf("\x7\x7\x7");
	     wprintf(inf,"  Logical disk %c:     DOS BOOT RECORD has been changed!\n", 75-isector);
	     wprintf(inf,"  Update with original copy? [Y]\b\b");
k3:	     key=getch();
             printf("\x7");
	     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	       goto k3;
	     if(toupper(key)!='N')
	       {
                 sig=1;
		 if(writedosboot(drive,HEAD,SECTOR,TRACK, isector)==-1) goto CONTI;
		 wprintf(inf,"\n  Over.\n");
	       }
	     else
	       wprintf(inf,"N\n");
	   }
	  else
	   wprintf(inf,"  Logical disk %c:     DOS BOOT RECORD OK.\n", 75-isector);
CONTI:	   isector--;i+=3;
	 }
       if(sig==1)
	{
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Now,you should reboot,then check virus for hard disk.\n");
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to reboot...");
	 getch();
         printf("\x7");wprintf(inf,"\n");
	 close_all();
	 printf("\n");
	 reboot();
	}
     }

   if((!strcmp(strupr(argv[1]),"/B")) || (!strcmp(strupr(argv[1]),"/I")))
     {
       if(check_lock(drive)==0) quit(1);
       MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
       if(!strcmp(strupr(argv[1]),"/B"))
       {
       wprintf(inf,"\n  BOOT RECORD backup.\n");
       wprintf(inf,"  Confirm that the operational system is normal,please.\n");
       wprintf(inf,"  Are you sure?[Y]\b\b");
k4:    key=getch();
       printf("\x7");
       if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k4;
       if(toupper(key)=='N')
	  {
	   wprintf(inf,"N\n");
	   quit(0);
	  }
       }
       wprintf(inf,"\n  Saving...");
       readmainboot(drive);
       savemainboot(drive);  /*Here need not care about value of return */
       i=1;isector=8;
       if (!readparttable(1))
	 {
	   wprintf(inf,"  Can't find partition information.\n");
	   quit(1);
	 }
       saveparttable(drive);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n    Main Boot OK.");
       while((THISDISKEXIST)&&(isector>1))
	 {
	   readdosboot(drive,HEAD,SECTOR,TRACK,isector);
	   savedosboot(drive,isector); /*Here need not care about value of return */
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n    %c: DOS Boot OK.",'C'-isector+8);
	   isector--;i+=3;
	 }
       wprintf(inf,"\n  Over.\n");
       if(!strcmp(strupr(argv[1]),"/B"))
	 quit(0);
       else
	 {
	 printf("\x7");
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	 getch();
	 printf("\x7");wprintf(inf,"\n");
	 close_all();
	 exit(0);
	 }
     }

   if(!strcmp(argv[1],"/?"))
     {
       if(check_lock(drive)==0) quit(1);
       wprintf(inf,"\n  MNGRBOOT is a manager of BOOT RECORD.\n");
       wprintf(inf,"  Usage:\n");
       wprintf(inf,"     MNGRBOOT     Update BOOT RECORD.\n");
       wprintf(inf,"     MNGRBOOT/C   Compare BOOT RECORD.\n");
       wprintf(inf,"     MNGRBOOT/B   Backup BOOT RECORD.\n");
       wprintf(inf,"     MNGRBOOT/?   Help for MNGRBOOT.\n");
       quit(0);
     }
   close_all();
   gotoxy(x,y);
   exit(i);
 }
int readmainboot(int drive)
  {
    if(biosdisk(2,drive,0,0,1,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error read MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	getch();
        printf("\x7");wprintf(inf,"\n");
	return -1;
      }
    return 1;
  }

int readdosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(2,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error read DOS BOOT RECORD for logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       printf("\x7");
       getch();
       printf("\x7");wprintf(inf,"\n");
       return -1;
      }
    return 1;
   }


int writemainboot(int drive)
  {
    if(biosdisk(3,drive,0,0,1,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error update MAIN BOOT RECORD.\n");
        wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	getch();
	printf("\x7");wprintf(inf,"\n");
	return -1;
      }
   return 1;
  }

int writedosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(3,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error update DOS BOOT RECORD to logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       printf("\x7");
       getch();
       printf("\x7");wprintf(inf,"\n");
       return -1;
      }
     return 1;
   }

int loadmainboot(int drive)
  {
    int isfail=0;
    if(biosdisk(2,drive,0,0,9,1,part))
      {
	isfail=1;
	DISKRESET;
	wprintf(inf,"  Error read the copy of MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to retry...");
        printf("\x7");
	getch();
        printf("\x7");wprintf(inf,"\n");
	part[510]=0;
	part[511]=0;
      }
    if((part[510]!='W')||(part[511]!='Q'))
       isfail=1;
    else
       {
	 if(biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
	   {
	      DISKRESET;
	      wprintf(inf,"  Error save MAIN BOOT RECORD.\n");
	      wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
              printf("\x7");
	      getch();
              printf("\x7");wprintf(inf,"\n");
	    }
	 part[510]=0x55;
	 part[511]=0xAA;
	 return 1;
       }
    if(isfail)
      return(loadmainbootagain(drive));
  }

int loadmainbootagain(int drive)
  {
    if(biosdisk(2,drive,BKHEAD,BKTRACK,9,1,part))
      {
	DISKRESET;
	infwq();
	return -1;
      }
    if((part[510]!='W')||(part[511]!='Q'))
       {
       infwq();
       return -1;
       }

    else
      {
      if(MAY_WRITE_TO_H_SEC==1)
       if(biosdisk(3,drive,0,0,9,1,part))
	 {
	   DISKRESET;
	   wprintf(inf,"  Error save MAIN BOOT RECORD.\n");
	   wprintf(inf,"  You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.\n");
           wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
           printf("\x7");
	   getch();
           printf("\x7");wprintf(inf,"\n");
	 }
       part[510]=0x55;
       part[511]=0xAA;
       return 1;
      }
  }

int loaddosboot(int drive,int isector)
  {
    int isfail=0;
    if (biosdisk(2,drive,0,0,isector,1,boot))
      {
       isfail=1;
       DISKRESET;
       wprintf(inf,"  Error read the copy of DOS BOOT RECORD from logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to retry...");
       printf("\x7");
       getch();
       printf("\x7");wprintf(inf,"\n");
       boot[3]='B';boot[510]='A';boot[511]='D';
      }
    if((boot[3]!='W')||(boot[510]!='W')||(boot[511]!='Q'))
       isfail=1;
    else
       {
	if(biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
	   {
	      DISKRESET;
	      wprintf(inf,"  Error save DOS BOOT RECORD.\n");
	      wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
              printf("\x7");
	      getch();
              printf("\x7");wprintf(inf,"\n");
	    }
        if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
	  boot[3]='I';
	else
	  boot[3]='M';
	boot[510]=0x55;boot[511]=0xAA;
	return 1;
       }
    if(isfail)
       return(loaddosbootagain(drive,isector));
   }


int loaddosbootagain(int drive,int isector)
  {
    if(biosdisk(2,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
	DISKRESET;
	infwq();
	return -1;
      }
    if((boot[3]!='W')||(boot[510]!='W')||(boot[511]!='Q'))
       {
	infwq();
	return -1;
       }
    else
      {
      if(MAY_WRITE_TO_H_SEC==1)
       if(biosdisk(3,drive,0,0,isector,1,boot))
	 {
	   DISKRESET;
           wprintf(inf,"  Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector);
	   wprintf(inf,"  You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.\n");
           wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
           printf("\x7");
	   getch();
           printf("\x7");wprintf(inf,"\n");
	 }
       if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
	  boot[3]='I';
       else
	  boot[3]='M';
       boot[510]=0x55;
       boot[511]=0xAA;
       return 1;
      }
  }
int savemainboot(int drive)
  {
    part[510]='W';part[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1)
     if(biosdisk(3,drive,0,0,9,1,part))
        {
	DISKRESET;
	wprintf(inf,"\n  Error save MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	getch();
        printf("\x7");wprintf(inf,"\n");
      }
      if(biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
      {
	DISKRESET;
	wprintf(inf,"\n  Error save MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	getch();
        printf("\x7");wprintf(inf,"\n");
	return -1;
      }
    return 1;
  }
int savedosboot(int drive,int isector)
  {
    boot[3]='W';boot[510]='W';boot[511]='Q';
    if (MAY_WRITE_TO_H_SEC==1)
    if(biosdisk(3,drive,0,0,isector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       printf("\x7");
       getch();
       printf("\x7");wprintf(inf,"\n");
      }
    if(biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       printf("\x7");
       getch();
       printf("\x7");wprintf(inf,"\n");
       return -1;
      }
    return 1;
   }


void saveparttable(int drive)
  {
    part[0]='W';part[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1)
    if(biosdisk(3,drive,0,0,10,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error save partition information.\n");
        wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	getch();
	printf("\x7");wprintf(inf,"\n");
      }
    if(biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error save partition information.\n");
	quit(1);
      }
  }


int loadparttable(int drive)   /*1=successful 0=flaure*/
  {
    int isfail=0;
    if(biosdisk(2,drive,0,0,10,1,part))
      {
	isfail=1;
	DISKRESET;
	wprintf(inf,"  Error read partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to retry...");
        printf("\x7");
	getch();
        printf("\x7");wprintf(inf,"\n");
	part[0]=0;part[511]=0;
      }
    if((part[0]!='W')||(part[511]!='Q'))
	isfail=1;
    else
      {
	if(biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
	   {
	      DISKRESET;
	      wprintf(inf,"  Error save partition information.\n");
	      wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
              printf("\x7");
	      getch();
              printf("\x7");wprintf(inf,"\n");
	    }
	return(1);
      }
    if(isfail)
      return(loadparttableagain(drive));
  }

int loadparttableagain(int drive)   /*1=successful 0=flaure*/
  {
    int back=1;
    if(biosdisk(2,drive,BKHEAD,BKTRACK,10,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error read partition information again.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to continue...");
        printf("\x7");
	getch();
	printf("\x7");wprintf(inf,"\n");
	back=0;
	part[0]=0;part[511]=0;
      }
    if((part[0]!='W')||(part[511]!='Q'))
	back=0;
    else
      {
       if(MAY_WRITE_TO_H_SEC==1)
	if(biosdisk(3,drive,0,0,10,1,part))
	  {
	    DISKRESET;
	    wprintf(inf,"  Error save partition information. \n");
            wprintf(inf,"  You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.\n");
	    wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
            printf("\x7");
	    getch();
            printf("\x7");wprintf(inf,"\n");
	  }
	back=1;
      }
      return(back);
  }

int readparttable(int way)
  {
    int l=1,drive=0x80,indct=0x1c2;
    unsigned char temp[20],tsec[512];
    if(biosdisk(2,0x80,0,0,1,1,tsec))
      {
	DISKRESET;
	wprintf(inf,"\n  Error get parttable.");
	quit(1);
	/*return(0);*/

      }
    while(indct<=0x1f2)
      {
	if((tsec[indct]==1)||(tsec[indct]==4)||(tsec[indct]==6))
	  {
	    part[l]=tsec[indct-3]&0xff;
	    part[l+1]=tsec[indct-2]&0xff;
	    part[l+2]=tsec[indct-1]&0xff;
	    l+=3;
	    break;
	  }
	else
	  indct += 0x10;
      }
    indct=0x1c2;
    temp[0]=temp[1]=temp[2]=0;
    while(indct<=0x1f2)
      {
	if(tsec[indct]==5)
	  {
	    temp[0]=tsec[indct-3]&0xff;
	    temp[1]=tsec[indct-2]&0xff;
	    temp[2]=tsec[indct-1]&0xff;
	    break;
	  }
	else
	  indct += 0x10;
      }
    while((temp[0]!=0)||(temp[1]!=0)||(temp[2]!=0))
      {
	 if(biosdisk(2,0x80,temp[0],temp[2],temp[1],1,tsec))
	   {
	     DISKRESET;
             wprintf(inf,"\n  Error get parttable.");
	     quit(1);

	     /*return(0);*/
	   }
	 part[l]=tsec[0x1BF]&0xff;
	 part[l+1]=tsec[0x1C0]&0xff;
	 part[l+2]=tsec[0x1C1]&0xff;
	 temp[0]=tsec[0x1CF]&0xff;
	 temp[1]=tsec[0x1D0]&0xff;
	 temp[2]=tsec[0x1D1]&0xff;
	 l+=3;
      }
    part[l]=part[l+1]=part[l+2]=0;
    return(1);
 }
void infwq(void)
{
   static unsigned flag=0;
   if(flag==0)
   {
   flag=1;
   printf("\x7\x7\x7");
   wprintf(inf,"\n   Reparing data are losen.Run MNGRBOOT/B in C:\\LASTLINE,");
   wprintf(inf,"\n  after cleaning virus do it again.");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
   getch();
   printf("\x7");
   }
   wprintf(inf,"\n");
 }
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    char end_inf[20];
    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	wprintf(inf,"\n  No installing.\n");
	quit(1);
      }
    fread(end_inf,3,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	wprintf(inf,"\n  Error\n");
	quit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	wprintf(inf,"\n  Unlawful user or unlocking.\n");
	quit(1);
      }
    return(0);
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
/*   BKHEAD=(temp[2]&0xff)-1;*//*Can't pass DongXiangjie's PC.*/
   BKHEAD=0;
   if(BKTRACK > 0x3FF)
    {
      BKTRACK=0x3FF;BKHEAD=0;
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



void check_sec(void)
 {
   struct ffblk ffb;
   findfirst(dvr,&ffb,FA_LABEL);
   if(strcmp(ffb.ff_name,"WQLASTLI.NE"))
   {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     wprintf(inf,"\n  Unlawful user or unlocking or not by floppydisk.\n");
     quit(1);
    }
   if(absread(toupper(dvr[0])-'A',1,0,boot))
    if(absread(toupper(dvr[0])-'A',1,0,boot))
     if(absread(toupper(dvr[0])-'A',1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       quit(1);
     }
   if(absread(toupper(dvr[0])-'A',1,719/*2000*/,part))
    if(absread(toupper(dvr[0])-'A',1,719,part))
     if(absread(toupper(dvr[0])-'A',1,719,part))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       quit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     wprintf(inf,"\n  Unlawful user or unlocking or not by floppydisk.\n");
     quit(1);
    }
 }
void reboot(void)
 {
     union REGS in,out;
     clrscr();
     int86(0x19,&in,&out);
 }
void call_at(void)
 {
/*  anti_trace();*/
 }

int get_MAY_WRITE_TO_H_SEC(void)
 {
   FILE *fp;
   unsigned char result;
   if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	wprintf(inf,"\n  No installing.\n");
	quit(1);
      }
    fseek(fp,500,SEEK_SET);
    fread(&result,1,1,fp);
    fclose(fp);
    return result&0xff;
 }
void quit(int i)
{
  printf("\x7");
  wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to quit...");
  getch();
  printf("\x7");wprintf(inf,"\n");
  close_all();
/*  restorecrtmode();*/
  gotoxy(x,y);
  exit(i);
}