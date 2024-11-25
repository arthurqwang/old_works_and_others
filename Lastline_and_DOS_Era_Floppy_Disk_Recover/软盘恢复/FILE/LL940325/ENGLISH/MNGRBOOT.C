/* MNGRBOOT.c 1994 3 25, English version 2.0, */
/* Passed DOS 3.3a,DOS 5.0,DOS 6.0*/
/* Computer type passed:GW286,COMPAQ 386/33(25),AST 286*/
/*      Antai 286 ,At&t 386,DELL 433DE ,NONAME 286 ,so on*/
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
void readmainboot(int drive);
void readdosboot(int drive,int head,int sector,int track,int isector);
void writemainboot(int drive);
void writedosboot(int drive,int head,int sector,int track,int isector);
void loadmainboot(int drive);
void loadmainbootagain(int drive);
void loaddosboot(int drive,int isector);
void loaddosbootagain(int drive,int isector);
void savemainboot(int drive);
void savemainbootagain(int drive);
void savedosboot(int drive,int isector);
void savedosbootagain(int drive,int isector);
int loadparttable(int drive);
int loadparttableagain(int drive);
int  readparttable(int way);
void saveparttable(int drive);
void saveparttableagain(int drive);
void infwq(void);
unsigned check_lock(int drive);
void get_BK(void);
void check_sec(void);
int getdosnum(void);
void reboot(void);
void call_at(void);
char part[BPS],boot[BPS];
int  BKTRACK,BKHEAD;
WINDOW *tit,*titt,*inf,*inff;
int x,y;
char dvr[10]="A:*.*";
void main(int argc,char *argv[])
 {
   short unsigned int drive=0x80,isector,i,key;
   dvr[0]=toupper(argv[0][0]);
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
   if((argc==2 && strcmp(strupr(argv[1]),"/C") &&
       strcmp(strupr(argv[1]),"/B") && strcmp(strupr(argv[1]),"/?"))||(argc>2))
     {
       wprintf(inf,"  Invalid format.\n  Usage:    MNGRBOOT [ [/C] or [/B] or [/?] ]\n");
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       getch();
       printf("\x7");
       close_all();
       gotoxy(x,y);
       exit(1);
     }
   call_at();/* include anti_trace */
   get_BK();
   if(argc==1)
     {
      int sig=0;
      check_sec();
      wprintf(inf,"  Replace MAIN BOOT RECORD?[Y]\b\b");
k1:   key=getch();
      printf("\x7");
      if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k1;
      if(toupper(key)!='N')
	{
	  sig=1;
	  loadmainboot(drive);
	  writemainboot(drive);
	  wprintf(inf,"\n  Successful.\n");
	}
      else
	wprintf(inf,"N\n");
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
	      sig=1;
	      loaddosboot(drive,isector);
	      writedosboot(drive,HEAD,SECTOR,TRACK,isector);
	      wprintf(inf,"\n  Successful.\n");
	    }
	  else
	    wprintf(inf,"N\n");
	  isector--;i+=3;
	}
      if(sig==1)
	{
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Now, DO NOT remove the disk in drive A: and reboot...\n");
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to reboot...");
	 getch();
         printf("\x7");
	 close_all();
	 printf("\n");
	 reboot();
	}
      else
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
   }
   if(!strcmp(strupr(argv[1]),"/C"))
     {
       char tpart[BPS],tboot[BPS];
       int sig=0;
       /*if(check_lock(drive)==0) exit(1);*/
       readmainboot(drive);
       memcpy(tpart,part,BPS);
       loadmainboot(drive);
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
	      writemainboot(drive);
	      wprintf(inf,"\n  Successful.\n");
	    }
	  else
	    wprintf(inf,"N\n");
	 }
       else
	wprintf(inf,"  MAIN BOOT RECORD OK.\n");
       if(!loadparttable(drive))
	 readparttable(0);
       i=1;isector=8;
       while((THISDISKEXIST)&&(isector>1))
	 {
	  readdosboot(drive,HEAD,SECTOR,TRACK, isector);
	  memcpy(tboot,boot,BPS);
	  loaddosboot(drive,isector);
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
		 writedosboot(drive,HEAD,SECTOR,TRACK, isector);
		 wprintf(inf,"\n  Successful.\n");
	       }
	     else
	       wprintf(inf,"N\n");
	   }
	  else
	   wprintf(inf,"  Logical disk %c:     DOS BOOT RECORD OK.\n", 75-isector);
	   isector--;i+=3;
	 }
       if(sig==1)
	{
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Now,you should reboot,then check virus for hard disk.\n");
	 wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to reboot...");
	 getch();
         printf("\x7");
	 close_all();
	 printf("\n");
	 reboot();
	}
       else
         wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
     }

   if(!strcmp(strupr(argv[1]),"/B"))
     {
       if(check_lock(drive)==0) exit(1);
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
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	   getch();
	   printf("\x7");
	   close_all();
	   gotoxy(x,y);
	   exit(0);
	  }
       readmainboot(drive);
       savemainboot(drive);
       i=1;isector=8;
       if (!readparttable(1))
	 {
	   wprintf(inf,"  Can't find partition information.\n");
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	   getch();
           printf("\x7");
	   close_all();
	   gotoxy(x,y);
	   exit(1);
	 }
       saveparttable(drive);
       while((THISDISKEXIST)&&(isector>1))
	 {
	   readdosboot(drive,HEAD,SECTOR,TRACK,isector);
	   savedosboot(drive,isector);
	   isector--;i+=3;
	 }
       wprintf(inf,"\n  Successful.\n  Over.\n");
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
     }

   if(!strcmp(argv[1],"/?"))
     {
       if(check_lock(drive)==0) exit(1);
       wprintf(inf,"\n  MNGRBOOT is a manager of BOOT RECORD.\n");
       wprintf(inf,"  Usage:\n");
       wprintf(inf,"     MNGRBOOT     Update BOOT RECORD.\n");
       wprintf(inf,"     MNGRBOOT/C   Compare BOOT RECORD.\n");
       wprintf(inf,"     MNGRBOOT/B   Backup BOOT RECORD.\n");
       wprintf(inf,"     MNGRBOOT/?   Help for MNGRBOOT.\n");
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
     }
   can_trace();
   getch();
   printf("\x7");
   close_all();
   gotoxy(x,y);
   exit(0);
 }
void readmainboot(int drive)
  {
    if(biosdisk(2,drive,0,0,1,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error read MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
        printf("\x7");
	close_all();
	gotoxy(x,y);
	exit(1);
      }
  }

void readdosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(2,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error read DOS BOOT RECORD for logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       getch();
       printf("\x7");
       close_all();
       gotoxy(x,y);
       exit(1);
      }
   }


void writemainboot(int drive)
  {
    if(biosdisk(3,drive,0,0,1,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error update MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
        printf("\x7");
	close_all();
	gotoxy(x,y);
	exit(1);
      }
  }

void writedosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(3,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error update DOS BOOT RECORD to logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       getch();
       printf("\x7");
       close_all();
       gotoxy(x,y);
       exit(1);
      }
   }

void loadmainboot(int drive)
  {
    int isfail=0;
    if(biosdisk(2,drive,0,0,9,1,part))
      {
	isfail=1;
	DISKRESET;
	wprintf(inf,"  Error read the copy of MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to retry...");
	getch();
        printf("\x7");
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
	      getch();
              printf("\x7");
	    }
	 part[510]=0x55;
	 part[511]=0xAA;
       }
    if(isfail)
      loadmainbootagain(drive);
  }

void loadmainbootagain(int drive)
  {
    if(biosdisk(2,drive,BKHEAD,BKTRACK,9,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error read the copy of MAIN BOOT RECORD again.\n");
	infwq();
      }
    if((part[510]!='W')||(part[511]!='Q'))
       infwq();
    else
      {
       if(biosdisk(3,drive,0,0,9,1,part))
	 {
	   DISKRESET;
	   wprintf(inf,"  Error save MAIN BOOT RECORD.\n");
	   wprintf(inf,"  You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.\n");
           wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	   getch();
           printf("\x7");
	 }
       part[510]=0x55;
       part[511]=0xAA;
      }
  }

void loaddosboot(int drive,int isector)
  {
    int isfail=0;
    if (biosdisk(2,drive,0,0,isector,1,boot))
      {
       isfail=1;
       DISKRESET;
       wprintf(inf,"  Error read the copy of DOS BOOT RECORD from logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to retry...");
       getch();
       printf("\x7");
       if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
	 boot[3]='I';
       else
	 boot[3]='M';
       boot[510]=0x55;boot[511]=0xAA;
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
	      getch();
              printf("\x7");
	    }
        if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
	  boot[3]='I';
       else
	  boot[3]='M';
	boot[510]=0x55;boot[511]=0xAA;
       }
    if(isfail)
       loaddosbootagain(drive,isector);
   }


void loaddosbootagain(int drive,int isector)
  {
    if(biosdisk(2,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
	DISKRESET;
        wprintf(inf,"  Error read the copy of DOS BOOT RECORD from logical disk %c:.\n",75-isector);
	infwq();
      }
    if((boot[3]!='W')||(boot[510]!='W')||(boot[511]!='Q'))
       infwq();
    else
      {
       if(biosdisk(3,drive,0,0,isector,1,boot))
	 {
	   DISKRESET;
           wprintf(inf,"  Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector);
	   wprintf(inf,"  You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.\n");
           wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	   getch();
           printf("\x7");
	 }
       if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
	  boot[3]='I';
       else
	  boot[3]='M';
       boot[510]=0x55;
       boot[511]=0xAA;
      }
  }
void savemainboot(int drive)
  {
    part[510]='W';part[511]='Q';
    if(biosdisk(3,drive,0,0,9,1,part)||biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
      {
	DISKRESET;
	wprintf(inf,"\n  Error save MAIN BOOT RECORD.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
        printf("\x7");
	close_all();
	gotoxy(x,y);
	exit(1);
      }
  }
void savedosboot(int drive,int isector)
  {
    boot[3]='W';boot[510]='W';boot[511]='Q';
    if (biosdisk(3,drive,0,0,isector,1,boot)||biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
       DISKRESET;
       wprintf(inf,"  Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector);
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
       getch();
       printf("\x7");
       close_all();
       gotoxy(x,y);
       exit(1);
      }
   }


void saveparttable(int drive)
  {
    part[0]='W';part[511]='Q';
    if(biosdisk(3,drive,0,0,10,1,part)||biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error save partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
        printf("\x7");
	close_all();
	gotoxy(x,y);
	exit(1);
      }
  }

/*void writeparttable(int drive)
  {
    if(biosdisk(3,drive,0,0,10,1,part))
      {
	DISKRESET;
	wprintf(inf,"  Error update partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
        printf("\x7");
	close_all();
	gotoxy(x,y);
	exit(1);
      }
  }     */


int loadparttable(int drive)   /*1=successful 0=flaure*/
  {
    int isfail=0;
    if(biosdisk(2,drive,0,0,10,1,part))
      {
	isfail=1;
	DISKRESET;
	wprintf(inf,"  Error read partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to retry...");
	getch();
        printf("\x7");
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
	      getch();
              printf("\x7");
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
	back=0;
	part[0]=0;part[511]=0;
      }
    if((part[0]!='W')||(part[511]!='Q'))
	back=0;
    else
      {
	if(biosdisk(3,drive,0,0,10,1,part))
	  {
	    DISKRESET;
	    wprintf(inf,"  Error save partition information. \n");
            wprintf(inf,"  You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.\n");
	    wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	    getch();
            printf("\x7");
	  }
	back=1;
      }
      return(back);
  }

/* This function was made on 1993 12 21,the last date */
/*int readparttable(int way)   way=1 read&backup ,way=0 only read
  {
    long unsigned i=0x5bf,fl;
    int k,l=1,fd,DOS_NO;
    char nm[20]="c:\\aaaaaa.aaa",cmd[50]="mkimg/partn<"  ;
    FILE *fp;
    if(way)
      {
       _chmod("c:\\partinfm.lst",1,FA_ARCH);
       remove("c:\\partinfm.lst");
       if((fp=fopen(nm,"w"))==NULL)
	 {
	   wprintf(inf,"  Can't open file.\n");
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	   getch();
           printf("\x7");
	   close_all();
	   gotoxy(x,y);
	   exit(1);
	 }
       fputc('c',fp);fputc(13,fp);
       fclose(fp);
       strcat(cmd,nm);
       strcat(cmd," >");
       strcat(cmd,nm);
       system(cmd);
       system("exit");
       remove(nm);
      }
   if((DOS_NO=getdosnum())<5)
   {
    if((fd=open("c:\\partinfm.lst",O_RDONLY))==-1)
      return(0);
    fl=filelength(fd);
    if ((fp=fopen("c:\\partinfm.lst","rb"))==NULL)
      return (0);
    for(;i<fl;i+=0x200)
      {
       fseek(fp,i,SEEK_SET);
       for(k=0;k<3;k++)
	{
	  part[l]=fgetc(fp)&0xff;
	  l++;
	}
      }
    part[l]=0;part[l+1]=0;part[l+2]=0;
    _chmod("c:\\partinfm.lst",1,FA_HIDDEN);
    return (1);
  }
  else
   {
    i=0x209;
    if ((fp=fopen("c:\\partinfm.lst","rb"))==NULL)
      return (0);
    for(;i<0x2f9;i+=0x10)
      {
       fseek(fp,i,SEEK_SET);
       for(k=0;k<3;k++)
	{
	  part[l]=fgetc(fp)&0xff;
	  l++;
	}
      }
    _chmod("c:\\partinfm.lst",1,FA_HIDDEN);
    return (1);
  }
 } */
int readparttable(int way)
  {
    int l=1,drive=0x80,indct=0x1c2;
    unsigned char temp[20],tsec[512];
    if(biosdisk(2,0x80,0,0,1,1,tsec))
      {
	DISKRESET;
	return(0);
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
	     return(0);
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
/*int readparttable(int way)
  {
    int l=1,drive=0x80;
    unsigned char temp[20]={0,1,0};
    unsigned char tsec[512];
    while((temp[0]!=0)||(temp[1]!=0)||(temp[2]!=0))
      {
	 if(biosdisk(2,0x80,temp[0],temp[2],temp[1],1,tsec))
	   {
	     DISKRESET;
	     return(0);
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
 }      */
void infwq(void)
 {
   printf("\x7\x7\x7");
   wprintf(inf,"\n     The copy of structure information of hard disk has \n");
   wprintf(inf,"  been changed!!! Now,you must scan and clearn hard disk\n");
   wprintf(inf,"  for virus,and confirm that your hard disk is normal,then\n");
   wprintf(inf,"  you should backup again. For backup,enter MNGRBOOT/B at\n  command line.\n\n");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
   getch();
   printf("\x7");
   close_all();
   gotoxy(x,y);
   exit(1);
 }
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    char end_inf[20];
    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	close_all();
        gotoxy(x,y);
	wprintf(inf,"\n  No installing.\n");
	exit(1);
      }
    fread(end_inf,3,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	close_all();
	gotoxy(x,y);
	wprintf(inf,"\n  Error\n");
	exit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
        close_all();
        gotoxy(x,y);
	wprintf(inf,"\n  Unlawful user or unlocking.\n");
	exit(1);
      }
    return(0);
    }
/*void get_BK(void)
 {
   unsigned HD_base_table_adr[4],temp[3],tttt[512];
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-1;
   BKHEAD=(temp[2]&0xff)-1;
   if(BKTRACK > 0x3FF)
     BKTRACK=0x3FF;
   while(1)
   {
   if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
      BKTRACK--;
   else
      break;
   }
  }*/
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
   BKHEAD=(temp[2]&0xff)-1;
   if(BKTRACK > 0x3FF)
    {
      BKTRACK=0x3FF;
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
     wprintf(inf,"\n  Unlawful user or unlocking.\n");
     exit(1);
    }
   if(absread(toupper(dvr[0])-'A',1,0,boot))
    if(absread(toupper(dvr[0])-'A',1,0,boot))
     if(absread(toupper(dvr[0])-'A',1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       exit(1);
     }
   if(absread(toupper(dvr[0])-'A',1,719/*2000*/,part))
    if(absread(toupper(dvr[0])-'A',1,719,part))
     if(absread(toupper(dvr[0])-'A',1,719,part))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       exit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     wprintf(inf,"\n  Unlawful user or unlocking.\n");
     exit(1);
    }
 }
int getdosnum(void)
 {
      union REGS in,out;
      in.h.ah=0x30;
      intdos(&in,&out);
      return(out.h.al);
 }
void reboot(void)
 {
     union REGS in,out;
     system("cls");
     int86(0x19,&in,&out);
 }
void call_at(void)
 {
  anti_trace();
 }