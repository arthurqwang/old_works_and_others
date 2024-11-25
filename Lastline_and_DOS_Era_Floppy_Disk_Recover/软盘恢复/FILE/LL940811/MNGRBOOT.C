/******************************************************************
  File name:     MNGRBOOT.C
  Belong to:     LASTLINE 2.5 Chinese version
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
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Yingwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/


/********************************************************/
#include "twingra.h"
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
int readparttable(int way);
void saveparttable(int drive);
void infwq(void);
unsigned check_lock(int drive);
void get_BK(void);
void check_sec(void);
void reboot(void);
void puticon(int lgdrive);
int get_MAY_WRITE_TO_H_SEC(void);
void quit(int i);

char part[BPS],boot[BPS];
char dvr[10]="A:*.*";
unsigned  BKTRACK,BKHEAD,MAY_WRITE_TO_H_SEC;
extern int high_of_char,CCLIB;
WINGRA *inf,*icon;
void main(int argc,char *argv[])
 {
   short unsigned int drive=0x80,isector,i,key;
   unsigned char path_of_HZK[30];
   if(argc==1)  /* when reparing */
    strcpy(path_of_HZK,"\\lsth.inf");
   else
    strcpy(path_of_HZK,"c:\\lastline\\lsth.inf");
   dvr[0]=toupper(argv[0][0]);
   title(path_of_HZK);
   icon=open_win(8,10,12,70,1,0);
   inf=open_win(14,10,24,70,1,1);
   if((argc==2 && strcmp(strupr(argv[1]),"/C") && strcmp(strupr(argv[1]),"/B")
       && strcmp(strupr(argv[1]),"/I") && strcmp(strupr(argv[1]),"/?"))||(argc>2))
     {
       puthz(icon," 非法格式. ",14,1);
       high(95,high_of_char*10+5,190,high_of_char*10+7,3,1);
       puthz(inf,"    用法:    MNGRBOOT [ [/C] or [/B] or [/?] ]\n",14,1);
       quit(1);
     }
   get_BK();
   if(argc==1)
     {
      int sig=0;
      check_sec();
      MAY_WRITE_TO_H_SEC=0;
      puthz(icon,"修复引导记录",14,1);
      high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
      puticon(0);
      puthz(inf," 是否修复主引导记录?[Y]\b\b",14,1);/*Replace MAIN BOOT RECORD?[Y]\b\b*/
k1:   key=getch();
      printf("\x7");
      if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k1;
      if(toupper(key)!='N')
	{
	  if(loadmainboot(drive)!=-1 && writemainboot(drive)!=-1)
	   {
	    puthz(inf,"\n 修复完毕.\n",14,1);/*Successful.*/
            sig=1;
	   }
	  else
	    puthz(inf," 跳过.\n",14,1);
	}
      else
	{
	puthz(inf,"N\n",14,1);
	puthz(inf," 跳过.\n",14,1);
	}
      if(!loadparttable(drive))
	readparttable(0);
      i=1;isector=8;
      while((THISDISKEXIST)&&(isector>1))
	{
	  puticon(10-isector);
	  puthz(inf," 是否修复 ",14,1);
	  boot[0]=75-isector;
	  boot[1]=':';
	  boot[2]=0;
	  puthz(inf,boot,15,1);
	  puthz(inf," 盘的DOS引导记录?[Y]\b\b",14,1);/*Replace DOS BOOT RECORD for logical disk %c:?[Y]\b\b  盘的DOS引导记录?*/
k2:       key =getch();
	  printf("\x7");
	  if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	     goto k2;
	  if(toupper(key)!='N')
	    {
	      if(loaddosboot(drive,isector)!=-1 && writedosboot(drive,HEAD,SECTOR,TRACK,isector)!=-1)
		{
		 puthz(inf,"\n 修复完毕.\n",14,1);/* Successful.*/
                 sig=1;
		}
	      else
                 puthz(inf," 跳过.\n",14,1);
	    }
	  else
	    {
	    puthz(inf,"N\n",14,1);
            puthz(inf," 跳过.\n",14,1);
	    }
	  isector--;i+=3;
	}
      if(sig==1)
	{
	 puthz(inf,"\n请在A:驱插入LASTLINE盘或引导盘,现在需要热启动.\n",15,1);
	 puthz(inf,"按任意键热启动...",15,1);
	 getch();
	 printf("\x7");
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
       MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
       puthz(icon,"检测引导记录",14,1);
       high(100,high_of_char*10+5,200,high_of_char*10+7,3,1);
       puticon(0);
       if(readmainboot(drive)==-1) goto PDOSBOOT;
       memcpy(tpart,part,BPS);
       if(loadmainboot(drive)==-1) goto PDOSBOOT;
       if(memcmp(tpart,part,BPS))
	 {
	  printf("\x7\x7\x7");
	  puthz(inf,"  主引导记录已被修改!\n",14,1);
	  puthz(inf,"  是否修复?[Y]\b\b",14,1);/*MAIN BOOT RECORD has been changed!*//*Update with original copy? [Y]*/
kkk:      key=getch();
	  printf("\x7");
	  if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	     goto  kkk;
	  if(toupper(key)!='N')
	    {
	      sig=1;
	      if(writemainboot(drive)==-1) goto PDOSBOOT;
	      puthz(inf,"\n  修复完毕.\n",14,1);/*Successful.*/
	    }
	  else
	    puthz(inf,"N\n",14,1);
	 }
       else
	puthz(inf,"主引导记录正常.\n",14,1);/*MAIN BOOT RECORD OK.*/
PDOSBOOT:
       if(!loadparttable(drive))
	 readparttable(0);
       i=1;isector=8;
       puthz(inf,"DOS 引导记录状态:\n   ",15,1);
       while((THISDISKEXIST)&&(isector>1))
	 {
	  puticon(10-isector);
	  if(readdosboot(drive,HEAD,SECTOR,TRACK, isector)==-1) goto CONTI;
	  memcpy(tboot,boot,BPS);
	  if(loaddosboot(drive,isector)==-1) goto CONTI;
	  if(memcmp(tboot,boot,BPS))
	   {
	     printf("\x7\x7\x7");
	     puthz(inf,"\n  逻辑盘 ",14,1);
	     tboot[0]=75-isector;
	     tboot[1]=':';
	     tboot[2]=0;
	     puthz(inf,tboot,14,1);
	     puthz(inf," 已被修改,是否修复?[Y]\b\b",14,1);/*Logical disk %c:     DOS BOOT RECORD has been changed!\n", 75-isector  DOS引导记录已被修改*/
							  /*Update with original copy? [Y]*/
k3:          key=getch();
	     printf("\x7");
	     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	       goto k3;
	     if(toupper(key)!='N')
	       {
		 sig=1;
		 if(writedosboot(drive,HEAD,SECTOR,TRACK, isector)==-1) goto CONTI;
		 puthz(inf,"\n  修复完毕.",14,1);/*修复完毕Successful.*/
	       }
	     else
	       puthz(inf,"N",14,1);
	   }
	  else
	    {
	     tboot[0]=75-isector;
	     tboot[1]=':';
	     tboot[2]=0;
	     puthz(inf,tboot,11,1);
	     puthz(inf,"正常 ",14,1);
	    }          /*逻辑盘 Logical disk %c:     DOS BOOT RECORD OK.\n", 75-isector*/
CONTI:
	   isector--;i+=3;
	 }
       if(sig==1)
	{
	 puthz(inf,"\n  现在,你应重新启动计算机,检查并清除病毒.\n",15,1);
	 puthz(inf,"  按任意键热启动...",15,1);/*Now,you should reboot,then check virus for hard disk.*/
						/*Press any key to reboot...*/
	 getch();
	 printf("\x7");
	 printf("\n");
	 reboot();
	}
     }

   if((!strcmp(strupr(argv[1]),"/B")) || (!strcmp(strupr(argv[1]),"/I")))
     {
       unsigned char bkuptemp[3]="C:";
       if(check_lock(drive)==0) quit(1);
       MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
       puthz(icon,"引导记录信息存贮",14,1);
       high(95,high_of_char*10+5,237,high_of_char*10+7,3,1);
       if(!strcmp(strupr(argv[1]),"/B"))
       {
       puthz(inf,"请确认现在的操作系统正常否.\n",14,1);
       puthz(inf,"确实正常吗?[Y]\b\b",14,1);
k4:    key=getch();
       printf("\x7");
       if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k4;
       if(toupper(key)=='N')
	  {
	   puthz(inf,"N\n",14,1);
	   quit(1);
	  }
       puthz(inf,"Y\n",14,1);
       }
       puthz(inf,"正在存贮...",14,1);
       readmainboot(drive);
       savemainboot(drive);    /*Here need not care about value of return.*/
       i=1;isector=8;
       if (!readparttable(1))
	 {
	   puthz(inf,"\n未找到硬盘分配信息.\n",14,1);
	   quit(1);
	 }
       saveparttable(drive);
       puthz(inf,"\n   主引导记录完成.",14,1);
       while((THISDISKEXIST)&&(isector>1))
	 {
	   readdosboot(drive,HEAD,SECTOR,TRACK,isector);
	   savedosboot(drive,isector);   /*Here need not care about value of return.*/
	   bkuptemp[0]='C'-isector+8;
	   puthz(inf,"\n   ",14,1);
	   puthz(inf,bkuptemp,14,1);
	   puthz(inf,"盘DOS引导记录完成.",14,1);
	   isector--;i+=3;
	 }
       puthz(inf,"\n存贮完毕.",14,1);
       if(!strcmp(strupr(argv[1]),"/B"))
	  quit(0);
       else
	  {
	    printf("\x7");
	    puthz(inf,"\n按任意键继续...",15,1);
	    getch();
	    printf("\x7");
            cleardevice();
	    exit(0);
	  }
     }

   if(!strcmp(argv[1],"/?"))
     {
       if(check_lock(drive)==0) quit(1);
       puthz(icon,"MNGRBOOT, 引导记录管理程序",14,1);
       high(95,high_of_char*10+5,317,high_of_char*10+7,3,1);
       puthz(inf,"用法:\n",15,1);
       puthz(inf," MNGRBOOT    修复引导记录",14,1);
       puthz(inf,"     MNGRBOOT/C  检查引导记录\n",14,1);
       puthz(inf," MNGRBOOT/B  备份引导记录    ",14,1);
       puthz(inf," MNGRBOOT/?  帮助",14,1);
       quit(0);
     }
   close(CCLIB);
   cleardevice();
   restorecrtmode();
   exit(0);
 }
int readmainboot(int drive)
  {
    if(biosdisk(2,drive,0,0,1,1,part))
      {
	DISKRESET;
	puthz(inf,"\n读主引导记录错误\n",14,1);
	puthz(inf,"按任意键继续...",15,1);
	printf("\x7");
	getch();
	puthz(inf,"\n",14,1);
	printf("\x7");
	return -1;
      }
    return 1;
  }

int readdosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(2,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n读DOS 引导记录错误\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
       return -1;
      }
    return 1;
   }


int writemainboot(int drive)
  {
    if(biosdisk(3,drive,0,0,1,1,part))
      {
	DISKRESET;
	puthz(inf,"\n修复主引导记录错误\n",14,1);
	puthz(inf,"按任意键继续...",15,1);
	printf("\x7");
	getch();
        puthz(inf,"\n",14,1);
	printf("\x7");
	return -1;
      }
    return 1;
  }

int writedosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(3,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n修复DOS 引导记录错误\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
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
	puthz(inf,"\n读取主引导记录备份信息错误\n",14,1);
	puthz(inf,"按任意键重试...",15,1);
	printf("\x7");
	getch();
        puthz(inf,"\n",14,1);
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
	      puthz(inf,"\n存贮主引导记录信息错误\n",14,1);
	      puthz(inf,"按任意键继续...",15,1);
	      printf("\x7");
	      getch();
              puthz(inf,"\n",14,1);
	      printf("\x7");
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
	   puthz(inf,"\n存贮主引导记录信息错误.\n",14,1);
	   puthz(inf,"你应该检查并清除病毒,然后在命令行上键入\n",14,1);
	   puthz(inf,"    C:\\LASTLINE\\MNGRBOOT/C\n",14,1);
	   puthz(inf,"\n按任意键继续...",15,1);
	   printf("\x7");
	   getch();
           puthz(inf,"\n",14,1);
	   printf("\x7");
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
       puthz(inf,"\n读取 DOS 引导记录备份信息错误\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
       boot[3]='B';boot[510]='A';boot[511]='D';
      }
    if((boot[3]!='W')||(boot[510]!='W')||(boot[511]!='Q'))
       isfail=1;
    else
       {
	if(biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
	   {
	      DISKRESET;
	      puthz(inf,"\n存贮DOS 引导记录信息错误\n",14,1);
	      puthz(inf,"按任意键继续...",15,1);
	      printf("\x7");
	      getch();
              puthz(inf,"\n",14,1);
	      printf("\x7");
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
	   puthz(inf,"\n存贮DOS 引导记录信息错误.\n",14,1);
	   puthz(inf,"你应该检查并清除病毒,然后在命令行上键入\n",14,1);
	   puthz(inf,"      C:\\LASTLINE\\MNGRBOOT/B  \n",14,1);
	   puthz(inf,"按任意键继续...",15,1);
	   printf("\x7");
	   getch();
           puthz(inf,"\n",14,1);
	   printf("\x7");
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
	puthz(inf,"\n存贮主引导记录信息错误.\n",14,1);
	puthz(inf,"按任意键继续...",15,1);
	printf("\x7");
	getch();
        puthz(inf,"\n",14,1);
	printf("\x7");
      }
    if(biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
      {
	DISKRESET;
	puthz(inf,"\n存贮主引导记录信息错误.\n",14,1);
	puthz(inf,"按任意键继续...",15,1);
	printf("\x7");
	getch();
        puthz(inf,"\n",14,1);
	printf("\x7");
	return -1;
      }
    return 1;
  }
int savedosboot(int drive,int isector)
  {
    boot[3]='W';boot[510]='W';boot[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1)
    if (biosdisk(3,drive,0,0,isector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n存贮DOS 引导记录错误\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
      }
    if(biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n存贮DOS 引导记录错误\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
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
	puthz(inf,"\n存贮硬盘分配信息错误.\n",14,1);
	puthz(inf,"按任意键继续...",15,1);
	printf("\x7");
	getch();
        puthz(inf,"\n",14,1);
	printf("\x7");
      }
    if(biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
      {
	DISKRESET;
	puthz(inf,"\n存贮硬盘分配信息错误.\n",14,1);
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
	puthz(inf,"\n读取硬盘分配信息错误.\n",14,1);
	puthz(inf,"按任意键继续...",15,1);
	printf("\x7");
	getch();
        puthz(inf,"\n",14,1);
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
	      puthz(inf,"\n存贮硬盘分配信息错误.\n",14,1);
	      puthz(inf,"按任意键继续...",15,1);
	      printf("\x7");
	      getch();
              puthz(inf,"\n",14,1);
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
	puthz(inf,"\n读取硬盘分配信息错误.\n",14,1);
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
	    puthz(inf,"\n存贮硬盘分配信息错误.\n",14,1);
	    puthz(inf,"你应该检查并清除病毒,然后在命令行上键入\n",14,1);
	    puthz(inf,"      C:\\LASTLINE\\MNGRBOOT/B\n",14,1);
	    puthz(inf,"按任意键继续...",15,1);
	    printf("\x7");
	    getch();
            puthz(inf,"\n",14,1);
	    printf("\x7");
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
	puthz(inf,"读分区表错误.\n",14,1);
	quit(1);
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
             puthz(inf,"读分区表错误.\n",14,1);
	     quit(1);
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
   printf("\x7\x7\x7",14,1);
   inf=open_win(14,10,24,70,1,1);
   clr_win(inf,1);
   puthz(inf,"\n  修复数据丢失,请立即执行下列命令:\n",14,1);
   puthz(inf,"     C:\\LASTLINE\\MNGRBOOT/B \n",14,1);
   puthz(inf,"然后,检查并清除病毒,再执行上述命令.",14,1);
   puthz(inf,"\n按任意键继续...",15,1);
   getch();
   printf("\x7");
   }
   puthz(inf,"\n",14,1);
 }
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    char end_inf[20];
    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	puthz(inf,"\n非安装使用.",14,1);
	quit(1);
      }
    fread(end_inf,3,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	puthz(inf,"\n错误",14,1);
	quit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	puthz(inf,"\n非法用户或解密或未在软盘上运行.",14,1);
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


void check_sec(void)
 {
   struct ffblk ffb;
   findfirst(dvr,&ffb,FA_LABEL);
   if(strcmp(ffb.ff_name,"WQLASTLI.NE"))
   {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     puthz(inf,"\n非法用户或解密或未在软盘上运行.",14,1);
     quit(1);
    }
   if(absread(toupper(dvr[0])-'A',1,0,boot))
    if(absread(toupper(dvr[0])-'A',1,0,boot))
     if(absread(toupper(dvr[0])-'A',1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       puthz(inf,"\n错误.",14,1);
       quit(1);
     }
   if(absread(toupper(dvr[0])-'A',1,2000,part))
    if(absread(toupper(dvr[0])-'A',1,2000,part))
     if(absread(toupper(dvr[0])-'A',1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       puthz(inf,"\n错误.",14,1);
       quit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     puthz(inf,"\n非法用户或解密或未在软盘上运行.",14,1);
     quit(1);
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
   if(lgdrive!=0)
     {
       a[0]=lgdrive+65;
       outtextxy(x+13,high_of_char*10+5,a);
     }
   else
     outtextxy(x,high_of_char*10+5,"MAIN");
   x+=40;
 }
int get_MAY_WRITE_TO_H_SEC(void)
 {
   FILE *fp;
   unsigned char result;
   if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	puthz(inf,"非安装使用.",14,1);
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
 puthz(inf,"\n 按任意键退出...",15,1);
 close(CCLIB);
 getch();
 printf("\x7");
 cleardevice();
 restorecrtmode();
 exit(i);
}