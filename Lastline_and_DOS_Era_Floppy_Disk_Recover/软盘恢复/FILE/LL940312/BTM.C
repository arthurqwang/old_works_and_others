/******************************************************************
  File name:     BTM.C
  Belong to:     Saviour 3.0 Chinese version
  Date:          Feb/7/96
  Author:        WangQuan
  Function:      To manager(backup,compare,repare) BOOT RECORD.
  Usage:
		 BACKUP:
		    X:\ANYPATH>Y:\ANYPATH\BTM/b<CR>
		 COMPARE:
		    X:\ANYPATH>Y:\ANYPATH\BTM/c<CR>
		 REPARE:
		    X:\ANYPATH>Z:BTM<CR>
		 HELP:
		    X:\ANYPATH>Y:\ANYPATH\BTM/?<CR>

		    X:,Y: = A:,B:,C:,D:...  Z: = A:,B:.
		    BUT C:\SV30\SVINFO.CFG must be OK.
		    Must in floppy disk when reparing.
  Where stored:  Floppy disk "Saviour 3.0 Chinese version
		 Source files"(Saviour 3.0 zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2,DOS 6.21
  Computer
       passed:   GW286,COMPAQ 386/33(25),486,596,AST 286
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
/*int loadmainbootagain(int drive);*/
int loaddosboot(int drive,int isector);
/*int loaddosbootagain(int drive,int isector);*/
int savemainboot(int drive);
int savedosboot(int drive,int isector);
int loadparttable(int drive);
/*int loadparttableagain(int drive);*/
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
void write_series_No(void);
void check_series_No(void);
unsigned get_disk_num(void);

unsigned char part[BPS],boot[BPS];
unsigned char dvr[10]="A:*.*";
unsigned  BKTRACK,BKHEAD,MAY_WRITE_TO_H_SEC;
extern int high_of_char,CCLIB;
WINGRA *inf,*icon;
void main(int argc,char *argv[])
 {
   short unsigned int drive=0x80,isector,i,key;
   unsigned char path_of_HZK[30];
   if(argc==1)  /* when reparing */
    strcpy(path_of_HZK,"\\SVH.LIB");
   else
    strcpy(path_of_HZK,"c:\\SV30\\SVH.LIB");
   dvr[0]=toupper(argv[0][0]);
   title(path_of_HZK);
   if(argc==1 || (!strcmp(strupr(argv[1]),"/B")) || (!strcmp(strupr(argv[1]),"/I")))
     wrt_SN_with_fd();
   else
     wrt_SN_with_hd();
   icon=open_win(8,10,12,70,7,0);
   inf=open_win(14,10,24,70,7,1);
   if((argc==2 && strcmp(strupr(argv[1]),"/C") && strcmp(strupr(argv[1]),"/B")
       && strcmp(strupr(argv[1]),"/I") && strcmp(strupr(argv[1]),"/?"))||(argc>2))
     {
       puthz(icon," 非法格式. ",0,7);
       high(95,high_of_char*10+5,190,high_of_char*10+7,3,1);
       puthz(inf,"    用法:    BTM [ [/C] or [/B] or [/?] ]\n",0,7);
       quit(1);
     }
   get_BK();
   if(argc==1)
     {
      int sig=0;
      check_sec();
      check_series_No();
      MAY_WRITE_TO_H_SEC=99; /* MAY_WRITE_TO_H_SEC means reparing  here */
      puthz(icon,"修复引导记录",0,7);
      high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
      puticon(0);
      puthz(inf," 是否修复主引导记录?[Y]\b\b",0,7);/*Replace MAIN BOOT RECORD?[Y]\b\b*/
k1:   key=get_ch();
      printf("\x7");
      if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k1;
      if(toupper(key)!='N')
	{
	  if(loadmainboot(drive)!=-1 && writemainboot(drive)!=-1)
	   {
	    puthz(inf,"\n 修复完毕.\n",0,7);/*Successful.*/
            sig=1;
	   }
	  else
	    puthz(inf," 跳过.\n",0,7);
	}
      else
	{
	puthz(inf,"N\n",0,7);
	puthz(inf," 跳过.\n",0,7);
	}
      if(!loadparttable(drive))
	readparttable(0);
      i=1;isector=8;
      while((THISDISKEXIST)&&(isector>1))
	{
	  puticon(10-isector);
	  puthz(inf," 是否修复 ",0,7);
	  boot[0]=75-isector;
	  boot[1]=':';
	  boot[2]=0;
	  puthz(inf,boot,1,7);
	  puthz(inf," 盘的DOS引导记录?[Y]\b\b",0,7);/*Replace DOS BOOT RECORD for logical disk %c:?[Y]\b\b  盘的DOS引导记录?*/
k2:       key =get_ch();
	  printf("\x7");
	  if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	     goto k2;
	  if(toupper(key)!='N')
	    {
	      if(loaddosboot(drive,isector)!=-1 && writedosboot(drive,HEAD,SECTOR,TRACK,isector)!=-1)
		{
		 puthz(inf,"\n 修复完毕.\n",0,7);/* Successful.*/
                 sig=1;
		}
	      else
                 puthz(inf," 跳过.\n",0,7);
	    }
	  else
	    {
	    puthz(inf,"N\n",0,7);
            puthz(inf," 跳过.\n",0,7);
	    }
	  isector--;i+=3;
	}
      if(sig==1)
	{
	 puthz(inf,"\n请在A:驱插入"大救星"盘或引导盘,现在需要热启动.\n",1,7);
	 puthz(inf,"按<Ctrl+Alt+Del>键热启动...",1,7);
	 printf("\x7");
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
       puthz(icon,"检测引导记录",0,7);
       high(100,high_of_char*10+5,200,high_of_char*10+7,3,1);
       puticon(0);
       if(readmainboot(drive)==-1) goto PDOSBOOT;
       memcpy(tpart,part,BPS);
       if(loadmainboot(drive)==-1) goto PDOSBOOT;
       if(memcmp(tpart,part,BPS))
	 {
	  printf("\x7\x7\x7");
	  puthz(inf,"  主引导记录已被修改!\n",0,7);
	  puthz(inf,"  是否修复?[Y]\b\b",0,7);/*MAIN BOOT RECORD has been changed!*//*Update with original copy? [Y]*/
kkk:      key=get_ch();
	  printf("\x7");
	  if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	     goto  kkk;
	  if(toupper(key)!='N')
	    {
	      sig=1;
	      if(writemainboot(drive)==-1) goto PDOSBOOT;
	      puthz(inf,"\n  修复完毕.\n",0,7);/*Successful.*/
	    }
	  else
	    {
	      puthz(inf,"N\n",0,7);
	      puthz(inf,"  跳过.\n",0,7);
	    }
	 }
       else
	puthz(inf,"主引导记录正常.\n",0,7);/*MAIN BOOT RECORD OK.*/
PDOSBOOT:
       if(!loadparttable(drive))
	 readparttable(0);
       i=1;isector=8;
       puthz(inf,"DOS 引导记录状态:\n   ",1,7);
       while((THISDISKEXIST)&&(isector>1))
	 {
	  puticon(10-isector);
	  if(readdosboot(drive,HEAD,SECTOR,TRACK, isector)==-1) goto CONTI;
	  memcpy(tboot,boot,BPS);
	  if(loaddosboot(drive,isector)==-1) goto CONTI;
	  if(memcmp(tboot,boot,BPS))
	   {
	     printf("\x7\x7\x7");
	     puthz(inf,"\n  逻辑盘 ",0,7);
	     tboot[0]=75-isector;
	     tboot[1]=':';
	     tboot[2]=0;
	     puthz(inf,tboot,0,7);
	     puthz(inf," 已被修改,是否修复?[Y]\b\b",0,7);/*Logical disk %c:     DOS BOOT RECORD has been changed!\n", 75-isector  DOS引导记录已被修改*/
							  /*Update with original copy? [Y]*/
k3:          key=get_ch();
	     printf("\x7");
	     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	       goto k3;
	     if(toupper(key)!='N')
	       {
		 sig=1;
		 if(writedosboot(drive,HEAD,SECTOR,TRACK, isector)==-1) goto CONTI;
		 puthz(inf,"\n  修复完毕.\n  ",0,7);/*修复完毕Successful.*/
	       }
	     else
               {
		 puthz(inf,"N\n",0,7);
		 puthz(inf,"  跳过.\n  ",0,7);
	       }
	   }
	  else
	    {
	     tboot[0]=75-isector;
	     tboot[1]=':';
	     tboot[2]=0;
	     puthz(inf,tboot,11,7);
	     puthz(inf,"正常 ",0,7);
	    }          /*逻辑盘 Logical disk %c:     DOS BOOT RECORD OK.\n", 75-isector*/
CONTI:
	   isector--;i+=3;
	 }
       if(sig==1)
	{
	 puthz(inf,"\n  现在,你应重新启动计算机,检查并清除病毒.\n",1,7);
	 puthz(inf,"  按<Ctrl+Alt+Del>键热启动...",1,7);/*Now,you should reboot,then check virus for hard disk.*/
						/*Press any key to reboot...*/
         printf("\x7");
	 reboot();
	}
     }

   if((!strcmp(strupr(argv[1]),"/B")) || (!strcmp(strupr(argv[1]),"/I")))
     {
       unsigned char bkuptemp[3]="C:",deltem[8192];
       int read_del_sec_success=1,disk_num,begin_sec,total_del_sec_num;
       check_sec();
       if(check_lock(drive)==0) quit(1);
       MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
       puthz(icon,"引导记录信息存贮",0,7);
       high(95,high_of_char*10+5,237,high_of_char*10+7,3,1);
       if(!strcmp(strupr(argv[1]),"/B"))
       {
       puthz(inf,"请确认现在的操作系统正常否.\n",0,7);
       puthz(inf,"确实正常吗?[Y]\b\b",0,7);
k4:    key=get_ch();
       printf("\x7");
       if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k4;
       if(toupper(key)=='N')
	  {
	   puthz(inf,"N\n",0,7);
	   quit(1);
	  }
       puthz(inf,"Y\n",0,7);
       }
       puthz(inf,"正在存贮...",0,7);
       readmainboot(drive);
       savemainboot(drive);    /*Here need not care about value of return.*/
       i=1;isector=8;
       if (!readparttable(1))
	 {
	   puthz(inf,"\n未找到硬盘分配信息.\n",0,7);
	   quit(1);
	 }
       saveparttable(drive);
       puthz(inf,"\n   主引导记录完成.",0,7);
       while((THISDISKEXIST)&&(isector>1))
	 {
	   readdosboot(drive,HEAD,SECTOR,TRACK,isector);
	   savedosboot(drive,isector);   /*Here need not care about value of return.*/
	   bkuptemp[0]='C'-isector+8;
	   puthz(inf,"\n   ",0,7);
	   puthz(inf,bkuptemp,0,7);
	   puthz(inf,"盘DOS引导记录完成.",0,7);
	   isector--;i+=3;
	 }
       write_series_No();

/* MAY_WRITE_TO_H_SEC==2 时,将后隐扇的标记去掉,当修复时只能用前隐扇
   因为修复时总是先载入后隐扇,而 ==2 时不用后隐扇 */
       if(MAY_WRITE_TO_H_SEC==2)
       {
	 disk_num=get_disk_num()-2;
	 begin_sec=9-disk_num;
	 total_del_sec_num=disk_num*2+2;
	 if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	   if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	     if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	       if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
		 if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
		   read_del_sec_success=0;

	 for(i=0;i<total_del_sec_num;i++)
	 if(deltem[i*512+511]=='Q'
	     &&(
		   (deltem[i*512+3]  =='W' && deltem[i*512+510]=='W')
		 ||(deltem[i*512]    =='W' && deltem[i*512+1]  =='W')
		 ||(deltem[i*512+510]=='W')
		 ||(deltem[i*512]    =='W')
	       )
	   )
	      deltem[i*512+511]='D';
	if(read_del_sec_success)
	  if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	    if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	      if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
		if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
		  if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
		     ;
       }
       puthz(inf,"\n存贮完毕.",0,7);
       if(!strcmp(strupr(argv[1]),"/B"))
	  quit(0);
       else
	  {
            puthz(inf,"\n\n\n  现在,请移开A:驱中的盘,需热启动.",0,7);
	    puthz(inf,"\n然后,确保以后的引导顺序总是\"A:,C:\".",0,7);
	    puthz(inf,"\n按<Ctrl+Alt+Del>键热启动...",1,7);
	    printf("\x7");
	    reboot();
	  }
     }

   if(!strcmp(argv[1],"/?"))
     {
       if(check_lock(drive)==0) quit(1);
       puthz(icon,"BTM, 引导记录管理程序",0,7);
       high(95,high_of_char*10+5,317,high_of_char*10+7,3,1);
       puthz(inf,"用法:\n",1,7);
       puthz(inf," BTM    修复引导记录",0,7);
       puthz(inf,"     BTM/C  检查引导记录\n",0,7);
       puthz(inf," BTM/B  备份引导记录    ",0,7);
       puthz(inf," BTM/?  帮助",0,7);
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
	puthz(inf,"\n读主引导记录错误\n",0,7);
	puthz(inf,"按任意键继续...",1,7);
	printf("\x7");
	get_ch();
	puthz(inf,"\n",0,7);
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
       puthz(inf,"\n读DOS 引导记录错误\n",0,7);
       puthz(inf,"按任意键继续...",1,7);
       printf("\x7");
       get_ch();
       puthz(inf,"\n",0,7);
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
	puthz(inf,"\n修复主引导记录错误\n",0,7);
	puthz(inf,"按任意键继续...",1,7);
	printf("\x7");
	get_ch();
        puthz(inf,"\n",0,7);
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
       puthz(inf,"\n修复DOS 引导记录错误\n",0,7);
       puthz(inf,"按任意键继续...",1,7);
       printf("\x7");
       get_ch();
       puthz(inf,"\n",0,7);
       printf("\x7");
       return -1;
      }
    return 1;
   }

int loadmainboot(int drive)
{
   switch(MAY_WRITE_TO_H_SEC)
    {
     case 0:  /*日常处理低保护方式:只从后隐扇区中载入备份*/
	 if(
		biosdisk(2,drive,BKHEAD,BKTRACK,9,1,part)
	     || part[510]!='W'
	     || part[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf," 未找到 MAIN BOOT 信息.\n",0,7);
		return -1;
	     }
	 else
	     {
		part[510]=0x55;
		part[511]=0xAA;
		return 1;
	     }
	 break;
     case 1:  /*日常处理高保护方式:只从后隐扇区中载入备份,若成功,则覆盖前
		隐扇区,若失败,则要求用户运行 BTM/B ,日常不从前隐扇区
		载入备份,因其不可靠.*/

         if(
		biosdisk(2,drive,BKHEAD,BKTRACK,9,1,part)
	     || part[510]!='W'
	     || part[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf," 未找到 MAIN BOOT 信息.\n",0,7);
		return -1;
	     }
	 else
	     {
		if(biosdisk(3,0x80,0,0,9,1,part))
		  {
                      DISKRESET;
		      infwq();
		  }
                part[510]=0x55;
		part[511]=0xAA;
		return 1;
	     }
	 break;
     case 2:  /*日常处理特别方式:只从前隐扇区中载入备份*/
         if(
		biosdisk(2,drive,0,0,9,1,part)
	     || part[510]!='W'
	     || part[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf," 未找到 MAIN BOOT 信息.\n",0,7);
		return -1;
	     }
	 else
	     {
		part[510]=0x55;
		part[511]=0xAA;
		return 1;
	     }
	 break;
     case 99:  /*修复:先从后隐扇区中载入备份,若失败再从前隐扇区载入备份*/
         if(
		biosdisk(2,drive,BKHEAD,BKTRACK,9,1,part)
	     || part[510]!='W'
	     || part[511]!='Q'
	   )
           if(
		   biosdisk(2,drive,0,0,9,1,part)
		|| part[510]!='W'
		|| part[511]!='Q'
	      )
		   {
		     DISKRESET;
		     infwq();
		     puthz(inf," 未找到 MAIN BOOT 信息.\n",0,7);
		     return -1;
		   }
         part[510]=0x55;
	 part[511]=0xAA;
	 return 1;
	 break;
     default:
	 return -1;
	 break;
    }
}


int loaddosboot(int drive,int isector)
{
   unsigned char temp[]=" C: 未找到 DOS BOOT 信息.\n";
   temp[1]='C'+8-isector;
   switch(MAY_WRITE_TO_H_SEC)
    {
     case 0:  /*日常处理低保护方式:只从后隐扇区中载入备份*/
	 if(
		biosdisk(2,drive,BKHEAD,BKTRACK,isector,1,boot)
	     || boot[3]!='W' || boot[510]!='W'
	     || boot[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf,temp,0,7);
		return -1;
	     }
	 else
	     {
		if(((toupper(boot[4]))=='B') && ((toupper(boot[5]))=='M'))
		   boot[3]='I';
		else
		   boot[3]='M';
		boot[510]=0x55;
		boot[511]=0xAA;
		return 1;
	     }
	 break;
     case 1:  /*日常处理高保护方式:只从后隐扇区中载入备份,若成功,则覆盖前
		隐扇区,若失败,则要求用户运行 BTM/B ,日常不从前隐扇区
		载入备份,因其不可靠.*/

         if(
		biosdisk(2,drive,BKHEAD,BKTRACK,isector,1,boot)
	     || boot[3]!='W' || boot[510]!='W'
	     || boot[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
                puthz(inf,temp,0,7);
		return -1;
	     }
	 else
	     {
		if(biosdisk(3,0x80,0,0,isector,1,boot))
		  {
                      DISKRESET;
		      infwq();
		  }
                if(((toupper(boot[4]))=='B') && ((toupper(boot[5]))=='M'))
		   boot[3]='I';
		else
		   boot[3]='M';
                boot[510]=0x55;
		boot[511]=0xAA;
		return 1;
	     }
	 break;
     case 2:  /*日常处理特别方式:只从前隐扇区中载入备份*/
         if(
		biosdisk(2,drive,0,0,isector,1,boot)
	     || boot[3]!='W' || boot[510]!='W'
	     || boot[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
                puthz(inf,temp,0,7);
		return -1;
	     }
	 else
	     {
                if(((toupper(boot[4]))=='B') && ((toupper(boot[5]))=='M'))
		   boot[3]='I';
		else
		   boot[3]='M';
		boot[510]=0x55;
		boot[511]=0xAA;
		return 1;
	     }
	 break;
     case 99:  /*修复:先从后隐扇区中载入备份,若失败再从前隐扇区载入备份*/
         if(
		biosdisk(2,drive,BKHEAD,BKTRACK,isector,1,boot)
	     || boot[3]!='W' || boot[510]!='W'
	     || boot[511]!='Q'
	   )
           if(
		   biosdisk(2,drive,0,0,isector,1,boot)
		|| boot[3]!='W' || boot[510]!='W'
		|| boot[511]!='Q'
	      )
		   {
		     DISKRESET;
		     infwq();
                     puthz(inf,temp,0,7);
		     return -1;
		   }
         if(((toupper(boot[4]))=='B') && ((toupper(boot[5]))=='M'))
	    boot[3]='I';
	 else
	    boot[3]='M';
         boot[510]=0x55;
	 boot[511]=0xAA;
	 return 1;
	 break;
     default:
	 return -1;
	 break;
    }
}

int loadparttable(int drive)  /*1=success 0=flaue*/
{
   switch(MAY_WRITE_TO_H_SEC)
    {
     case 0:  /*日常处理低保护方式:只从后隐扇区中载入备份*/
	 if(
		biosdisk(2,drive,BKHEAD,BKTRACK,10,1,part)
	     || part[0]!='W'
	     || part[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf," 未找到分区信息.\n",0,7);
		return 0;
	     }
	 else
	     {
		return 1;
	     }
	 break;
     case 1:  /*日常处理高保护方式:只从后隐扇区中载入备份,若成功,则覆盖前
		隐扇区,若失败,则要求用户运行 BTM/B ,日常不从前隐扇区
		载入备份,因其不可靠.*/

         if(
		biosdisk(2,drive,BKHEAD,BKTRACK,10,1,part)
	     || part[0]!='W'
	     || part[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf," 未找到分区信息.\n",0,7);
		return 0;
	     }
	 else
	     {
		if(biosdisk(3,0x80,0,0,10,1,part))
		  {
                      DISKRESET;
		      infwq();
		  }
		return 1;
	     }
	 break;
     case 2:  /*日常处理特别方式:只从前隐扇区中载入备份*/
         if(
		biosdisk(2,drive,0,0,10,1,part)
	     || part[0]!='W'
	     || part[511]!='Q'
	   )
	     {
		DISKRESET;
		infwq();
		puthz(inf," 未找到分区信息.\n",0,7);
		return 0;
	     }
	 else
	     {
		return 1;
	     }
	 break;
     case 99:  /*修复:先从后隐扇区中载入备份,若失败再从前隐扇区载入备份*/
         if(
		biosdisk(2,drive,BKHEAD,BKTRACK,10,1,part)
	     || part[0]!='W'
	     || part[511]!='Q'
	   )
           if(
		   biosdisk(2,drive,0,0,10,1,part)
		|| part[0]!='W'
		|| part[511]!='Q'
	      )
		   {
		     DISKRESET;
		     infwq();
		     puthz(inf," 未找到分区信息.\n",0,7);
		     return 0;
		   }
	 return 1;
	 break;
     default:
	 return 0;
	 break;
    }
}


int savemainboot(int drive)
  {
    part[510]='W';part[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==2)
    if(biosdisk(3,drive,0,0,9,1,part))
      {
	DISKRESET;
	puthz(inf,"\n存贮主引导记录信息错误.\n",0,7);
	puthz(inf,"按任意键继续...",1,7);
	printf("\x7");
	get_ch();
        puthz(inf,"\n",0,7);
	printf("\x7");
      }
    if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==0)
    if(biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
      {
	DISKRESET;
	puthz(inf,"\n存贮主引导记录信息错误.\n",0,7);
	puthz(inf,"按任意键继续...",1,7);
	printf("\x7");
	get_ch();
        puthz(inf,"\n",0,7);
	printf("\x7");
	return -1;
      }
    return 1;
  }
int savedosboot(int drive,int isector)
  {
    boot[3]='W';boot[510]='W';boot[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==2)
    if (biosdisk(3,drive,0,0,isector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n存贮DOS 引导记录错误\n",0,7);
       puthz(inf,"按任意键继续...",1,7);
       printf("\x7");
       get_ch();
       puthz(inf,"\n",0,7);
       printf("\x7");
      }
    if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==0)
    if(biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n存贮DOS 引导记录错误\n",0,7);
       puthz(inf,"按任意键继续...",1,7);
       printf("\x7");
       get_ch();
       puthz(inf,"\n",0,7);
       printf("\x7");
       return -1;
      }
    return 1;
  }


void saveparttable(int drive)
  {
    part[0]='W';part[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1  || MAY_WRITE_TO_H_SEC==2)
    if(biosdisk(3,drive,0,0,10,1,part))
      {
	DISKRESET;
	puthz(inf,"\n存贮硬盘分配信息错误.\n",0,7);
	puthz(inf,"按任意键继续...",1,7);
	printf("\x7");
	get_ch();
        puthz(inf,"\n",0,7);
	printf("\x7");
      }
    if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==0)
    if(biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
      {
	DISKRESET;
	puthz(inf,"\n存贮硬盘分配信息错误.\n",0,7);
	quit(1);
      }
  }

int readparttable(int way)
  {
    int l=1,drive=0x80,indct=0x1c2;
    unsigned char temp[20],tsec[512];
    if(biosdisk(2,0x80,0,0,1,1,tsec))
      {
	DISKRESET;
	puthz(inf,"读分区表错误.\n",0,7);
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
             puthz(inf,"读分区表错误.\n",0,7);
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
   printf("\x7\x7\x7",0,7);
   inf=open_win(14,10,24,70,7,1);
   clr_win(inf,1);
   puthz(inf,"   "大救星"数据丢失,请立即执行"大救星"软盘上的命令:\n",0,7);
   puthz(inf,"          BTM/B ",0,7);
   puthz(inf,"\n按任意键继续...",1,7);
   get_ch();
   printf("\x7");
   }
   puthz(inf,"\n",0,7);
 }
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    char end_inf[20];
    if((fp=fopen("c:\\SV30\\SVINFO.cfg","rb"))==NULL)
      {
	puthz(inf,"\n非安装使用.",0,7);
	quit(1);
      }
    fread(end_inf,3,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	puthz(inf,"\n错误",0,7);
	quit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	puthz(inf,"\n非法用户或解密或未在软盘上运行.",0,7);
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
/*     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);*/
     puthz(inf,"\n非法用户或解密或未在软盘上运行.",0,7);
     quit(1);
    }
   if(absread(toupper(dvr[0])-'A',1,0,boot))
    if(absread(toupper(dvr[0])-'A',1,0,boot))
     if(absread(toupper(dvr[0])-'A',1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       puthz(inf,"\n错误.",0,7);
       quit(1);
     }
   if(absread(toupper(dvr[0])-'A',1,2000,part))
    if(absread(toupper(dvr[0])-'A',1,2000,part))
     if(absread(toupper(dvr[0])-'A',1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       puthz(inf,"\n错误.",0,7);
       quit(1);
     }
   if(memcmp(boot,part,512))
    {
/*     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);*/
     puthz(inf,"\n非法用户或解密或未在软盘上运行.",0,7);
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
   setfillstyle(1,7);
   high(x,high_of_char*8+2,x+30,high_of_char*10,7,1);
   nohigh(x+1,high_of_char*8+3,x+29,high_of_char*10-1,7,1);
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
   if((fp=fopen("c:\\SV30\\SVINFO.cfg","rb"))==NULL)
      {
	puthz(inf,"\n非安装使用.",0,7);
	quit(1);
      }
    fseek(fp,500,SEEK_SET);
    fread(&result,1,1,fp);
    fclose(fp);
    result &= 0xff;
    if(!(result==0 || result==1 || result==2))
      {
	 puthz(inf,"\n请重新安装.",0,7);
	 quit(1);
      }
    return result;
 }

void quit(int i)
{

 printf("\x7");
 puthz(inf,"\n 按任意键退出...",1,7);
 close(CCLIB);
 get_ch();
 printf("\x7");
 cleardevice();
 restorecrtmode();
 exit(i);
}

void write_series_No(void)
{
   unsigned char part[512],boot[512];
   if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==0)
   {
    if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,part))
    {
     puthz(inf,"\n设置序列号错误.",0,7);
     quit(1);
    }
   }
   if(MAY_WRITE_TO_H_SEC==2)
   {
    if(biosdisk(2,0x80,0,0,10,1,part))
    {
     puthz(inf,"\n设置序列号错误.",0,7);
     quit(1);
    }
   }
   if(absread(toupper(dvr[0])-65,1,0,boot))
    if(absread(toupper(dvr[0])-65,1,0,boot))
     if(absread(toupper(dvr[0])-65,1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n设置序列号错误.",0,7);
       quit(1);
     }
   part[507]=boot[0x27]&0xFF;
   part[508]=boot[0x28]&0xFF;
   part[509]=boot[0x29]&0xFF;
   part[510]=boot[0x2a]&0xFF;
   if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==2)
    if(biosdisk(3,0x80,0,0,10,1,part))
    {
     puthz(inf,"\n设置序列号错误.",0,7);
     quit(1);
    }
   if(MAY_WRITE_TO_H_SEC==1 || MAY_WRITE_TO_H_SEC==0)
   if(biosdisk(3,0x80,BKHEAD,BKTRACK,10,1,part))
    {
     puthz(inf,"\n设置序列号错误.",0,7);
     quit(1);
    }
}


void check_series_No(void)
{
   unsigned char part[512],boot[512];
   if(absread(toupper(dvr[0])-65,1,0,boot))
    if(absread(toupper(dvr[0])-65,1,0,boot))
     if(absread(toupper(dvr[0])-65,1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n读序列号错误.",0,7);
       quit(1);
     }
   if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,part))
    if(biosdisk(2,0x80,0,0,10,1,part))
    {
     puthz(inf,"\n读序列号错误.",0,7);
     quit(1);
    }
   if(part[0]!='W' || part[511]!='Q')
    {
     if(biosdisk(2,0x80,0,0,10,1,part))
      {
	puthz(inf,"\n读序列号错误.",0,7);
	quit(1);
      }
    }
   if(    part[0]=='W'
       && part[511]=='Q'
       &&
       (  part[507] != boot[0x27]
       || part[508] != boot[0x28]
       || part[509] != boot[0x29]
       || part[510] != boot[0x2a]
       )
     )
     {
       puthz(inf,"\n软件序列号不匹配.",0,7);
       quit(1);
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
}

unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   readparttable(1);
   while(!((part[i]==0)&&(part[i+1]==0)&&(part[i+2]==0)))
	 {
	  i+=3;
	  num++;
	 }
     if(num>9)
       num=9;
     return(num);
   }

