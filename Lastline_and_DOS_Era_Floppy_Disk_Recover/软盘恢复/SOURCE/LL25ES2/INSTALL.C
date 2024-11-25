/*******************************************************************
  File name:     INSTALL.C
  Belong to:     LASTLINE 2.5 English version
  Date:          NOV/10/94
  Author:        WangQuan
  Function:      To install LASTLINE 2.5 English version.
		 It doesn't call LOADLL.EXE.
  Usage:         To be called by INSTALL.EXE
  Where stored:  Floppy disk "LASTLINE 2.5 English version
		 Source files"(LASTLINE 2.5 Yingwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

#include <stdio.h>
#include <conio.h>
#include "twindow.h"
#include "keys.h"
#include <string.h>
#include <dir.h>
#include <dos.h>
#include <io.h>
#include <stdlib.h>
#include <process.h>
#include <ctype.h>

void set_l(void);
void check_sec(void);
int readparttable(int way);
unsigned get_disk_num(void);
int test_hidden_sec_ok(void);
void get_BK(void);
void reboot(void);
void quit(int i);
void out_beep(void);
void getaline(FILE *fp,char *aline);

unsigned get_SN_from_fd(void);
WINDOW *inf;
char dvr[10]="A:*.*";
char boot[512],part[512];
unsigned char Protected_Mode;
unsigned BKHEAD,BKTRACK,x,y;
int olddvr;
main(int argc,char *argv[])
{
   WINDOW *back1,*back2,*inff,*tit,*titt,*p,*pp;
   FILE *fp,*sysfp;
   int key,LL_exist_flag;
   unsigned SN_from_fd;
   char fn[50],pi[1000];
   char dospath[100],temp[512],tempp[512],temppp[100],tempppp[100],k;
   struct ffblk fff;
   olddvr=getdisk();
/*   if(getenv("LASTLINE")==NULL) exit(1);*/
   LL_exist_flag = (!findfirst("C:\\LASTLINE",&fff,FA_DIREC));

/*   argv[0][0]='A';*/
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   dvr[2]=0;
   x=wherex();y=wherey();
   SN_from_fd=get_SN_from_fd();
   back1=establish_window(11,4,20,64);
   set_colors(back1,ALL,BLUE,BLUE,DIM);
   display_window(back1);
   back2=establish_window(9,3,20,64);
   set_colors(back2,ALL,YELLOW,YELLOW,DIM);
   display_window(back2);
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
   wclrprintf(tit,BLUE,YELLOW,BRIGHT,"         LASTLINE Version 2.5  SN:%06u\n",SN_from_fd);
   wprintf(tit,"   (C) Copyright(1994.9) DongLe Computer Corp. \n");
   wprintf(tit,"          Designed & Coded by ");
   wprintf(tit,"%c%c%c%c%c%c%c%c",87,65,78,71,81,85,65,78);
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
   pp=establish_window(12,19,3,60);
   set_colors(pp,ALL,3,WHITE,BRIGHT);
   pp->wcolor[0]=0x33;
   set_border(pp,3);
   p=establish_window(10,18,3,60);
   set_colors(p,ALL,BLUE,WHITE,BRIGHT);
   set_border(p,3);
   out_beep();
   wprintf(inf,"   Please read User's Manual carefully");
   wprintf(inf,"\n   before installation. Continue ? [Y]\b\b");
   if(toupper(get_ch()) == 'N') {wprintf(inf,"N");out_beep();quit(0);};
   out_beep();
       check_sec();
       wprintf(inf,"\n   Confirm your DOS and hard disk run normally.\n");
       wprintf(inf,"   Are you sure?[Y]\b\b");
k4:    key=get_ch();
       out_beep();
       if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k4;
       if(toupper(key)=='N')
	  {
	   wprintf(inf,"N\n");
	   quit(0);
	  }
   if(strcmp(strupr(argv[1]),"/S"))
   {
   wprintf(inf,"\n   Testing...");
   if(test_hidden_sec_ok())
     {
     wprintf(inf,"\n   Installation will be in High-Protected-Mode.");
     Protected_Mode=1;
     }
   else
     Protected_Mode=0;
   }
   else
   {
      wprintf(inf,"\n   Installation will be in Special-Mode.");
      wprintf(inf,"\n   It may be dangerous!\n   Continue?[N]\b\b");
k5:    key=get_ch();
       out_beep();
       if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto k5;
       if(toupper(key)=='N' || key==13)
	  {
	   quit(0);
	  }
       else
	  wprintf(inf,"Y\n");
      Protected_Mode=2;
   }
   set_l();       /*include anti_trace()  */

  wprintf(inf,"\n   Your DOS path is C:\\DOS , right?[Y]\b\b");
  k=get_ch();
  out_beep();
  if((k==13) ||(toupper(k)=='Y'))
     {
     wprintf(inf,"\n   ");
     strcpy(dospath,"c:\\dos");
     }
  else
    {
      wprintf(inf,"N");
      wprintf(inf,"\n   Enter the path including DOS:  ");
      while(!strcmp(gets(dospath),NULL))
	   wcursor(inf,inf->_cr,inf->_sp+1);
      out_beep();
    }
  strcpy(temppp,dospath);
  strcat(temppp,"\\sys.com");
  strcpy(tempppp,dospath);
  strcat(tempppp,"\\sys.exe");
  if(((sysfp=fopen(temppp,"rb"))==NULL) && ((sysfp=fopen(tempppp,"rb"))==NULL))
  {
    wprintf(inf,"\n   Path not found. See User's Manual.\n");
    wprintf(inf,"   Continue ? [N]\b\b");
    k=get_ch();
    if(toupper(k) != 'Y')
	{
	   out_beep();
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to quit...");
	   get_ch();
	   wprintf(inf,"\n");
	   out_beep();
           if(!LL_exist_flag)
	      {
	       system("c:");
	       system("cd\\lastline");
	       remove("lsth.inf");
               _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
	       remove("lastline.cfg");
	       system("cd\\");
	       rmdir("lastline");
	      }
           close_all();
           gotoxy(x,y);
	   setdisk(olddvr);
	   exit(1);
	}
    else
       wprintf(inf,"Y");
  }
  fclose(sysfp);
  wprintf(inf,"\n\n   Wait a while,please...");
  set_title(p,"Installing...");
  display_window(pp);
  display_window(p);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
/* write MNGRBOOT/C & FATRSAVE into autoexec.bat */

  if((fp=fopen("c:\\aaaaaa.ll$","wt"))==NULL)
     wprintf(inf,"\nError open AUTOEXEC.BAT.");
  else
    {
     fputs("@echo off\n",fp);
     fputs("c:\\lastline\\mngrboot/c\n",fp);
     fputs("c:\\lastline\\fatrsave\n",fp);
     fputs("echo on\n",fp);
    }
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);

  if((sysfp=fopen("C:\\AUTOEXEC.BAT","rt")) != NULL)
    {
       while(!feof(sysfp))
	{
	  getaline(sysfp,pi);
	  strupr(pi);
	  if(!(strstr(pi,"MNGRBOOT")||strstr(pi,"FATRSAVE")))
	    {
	     fputs(pi,fp);
	     fputc('\n',fp);
	    }
	}
    }
  fcloseall();
  system("copy c:\\aaaaaa.ll$ c:\\autoexec.bat>NUL");
  system("del c:\\aaaaaa.ll$>NUL");
/****************************************************************/
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);
  /*system("exit");*/system("copy mngrboot.exe  c:\\lastline>NUL");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);

  /*system("exit");*/system("copy fatrsave.exe  c:\\lastline>NUL");
  wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy ");
  sleep(1);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcat(temp,dospath);
  sleep(1);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wprintf(inf,"\n   ");
  strcpy(tempp,dospath);
  strcat(tempp,"\\sys.com");
  if((sysfp=fopen(tempp,"rb"))==NULL)
     strcpy(tempp,"\\sys.exe");
  else
     strcpy(tempp,"\\sys.com");
  fclose(sysfp);
  strcat(temp,tempp);
  strcat(temp," c:\\lastline\\trans.lst>NUL");
  /*system("exit");*/
  system(temp);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  delay(500);
  delete_window(p);
  delete_window(pp);
  wprintf(inf,"\n   Now,LASTLINE processing...\n");
  wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any key to continue...");
  get_ch();
  out_beep();
  wprintf(inf,"\n   Wait a while,please...");
  system("mngrboot/i");
  }

void set_l(void)
  {
    struct fatinfo p;
    int i,maxdnum;
    FILE *fp;
    char vol[501],voll[12]={0xa8,
	       0xae,0xb3,0xbe,0xac,0xab,0xb3,0xb6,0xd1,0xb1,0xba,0};
    struct ffblk fff,*pv;
    pv=&fff;
    findfirst("*.*",pv,FA_LABEL);
    strcpy(vol,pv->ff_name);
/*    anti_trace();*/
    for (i=0;i<11;i++)
      {
	vol[i]=~(vol[i]);
	if(vol[i]!=voll[i])
	 {
	   biosdisk(3,0,0,0,1,0xff,vol);
	   wprintf(inf,"\n  Invalid copy or not running in floppy disk.\n");
	   quit(1);
	 }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
	biosdisk(0,0x80,0,0,0,0,0);
	wprintf(inf,"\n  Error.\n");
	quit(1);
      }
    mkdir("c:\\lastline");
    _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\lastline\\lastline.cfg","wb+"))==NULL)
       {
	printf("\nError.\n");
	quit(1);
       }
    for (i=0x1c3;i<0x1c6;i++)
      vol[i-0x1c3]=~(vol[i]);
    maxdnum=get_disk_num();
    for(i=2;i<maxdnum;i++)
      {
	getfat(i+1,&p);
	if((((long unsigned)p.fi_sclus)*((unsigned)p.fi_nclus))<=65536L)
	  vol[i+2]=0;
	else
	  vol[i+2]=1;
      }
    vol[500]=Protected_Mode;
    fwrite(vol,501,1,fp);
    fclose(fp);
    _chmod("c:\\lastline\\lastline.cfg",1,FA_RDONLY+FA_HIDDEN);
    }

void check_sec(void)
 {

   if(absread(toupper(dvr[0])-65,1,0,boot))
    if(absread(toupper(dvr[0])-65,1,0,boot))
     if(absread(toupper(dvr[0])-65,1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       quit(1);
     }
   if(absread(toupper(dvr[0])-65,1,719/*2000*/,part)) /*High density(1.2M) uses 2000*/
    if(absread(toupper(dvr[0])-65,1,719,part))       /*Low density(360K) uses 719*/
     if(absread(toupper(dvr[0])-65,1,719,part))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       quit(1);
     }
   if(memcmp(boot,part,512))
    {
/*     biosdisk(3,toupper(dvr[0])-65,0,0,1,0xff,boot+0x101);*/
     wprintf(inf,"\n  Invalid copy or not running in floppy disk.\n");
     quit(1);
    }
 }
unsigned get_disk_num(void)  /* if c: return 3 ,d: 4 */
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
int readparttable(int way)
  {
    int l=1,drive=0x80,indct=0x1c2;
    unsigned char temp[20],tsec[512];
    if(biosdisk(2,0x80,0,0,1,1,tsec))
      {
	biosdisk(0,0x80,0,0,0,0,tsec);
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
	     biosdisk(0,0x80,0,0,0,0,tsec);
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

int test_hidden_sec_ok(void)
{
  unsigned char hidden_sec[8192],temp[8192],value_filled=0;
  unsigned disk_num,begin_sec,total_test_sec_num,i,ik;
  int key;
  biosdisk(2,0x80,0,0,17,1,hidden_sec);
  value_filled=hidden_sec[187]&0xFF;
  disk_num=get_disk_num()-2;
  begin_sec=9-disk_num;
  total_test_sec_num=disk_num*2+2;
  for(ik=0;ik<total_test_sec_num*512;ik++)
     hidden_sec[ik]='W';
  for(ik=0;ik<total_test_sec_num*512;ik++)
     temp[ik]='D';
  get_BK();
  if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,hidden_sec))
	    {
	      wprintf(inf,"\n   Sorry.\n   Can not install becouse of special harddisk.");
	      quit(0);
	    }
  if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
    if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
      if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	  if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	    {
              wprintf(inf,"\n   Special hard disk.\n   Sorry,LASTLINE could not be installed.");
	      quit(0);
	    }
  for(ik=0;ik<total_test_sec_num*512;ik++)
     if(temp[ik]!='W')
        {
	      wprintf(inf,"\n   Special hard disk.\n   Sorry,LASTLINE could not be installed.");
	      quit(0);
	}
  if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	    {
	      wprintf(inf,"\n   Special hard disk.\n   May only be installed in Low-Protected-Mode.");
	      return 0;
	    }

  if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	    {
	      wprintf(inf,"\n   Special hard disk.\n   May only be installed in Low-Protected-Mode.");
	      return 0;
	    }


  for(i=0;i<512*total_test_sec_num;i++)
    if(hidden_sec[i] != value_filled)
      {
	unsigned j,dosbootok=1,fatrootok=1,zi;
	unsigned char zeroa[512];
	for (zi=0;zi<512;zi++)
	    zeroa[zi]=value_filled;
	for(j=0;j<disk_num;j++)
	   {
	     if((hidden_sec[3+512*j]!='W' || hidden_sec[510+512*j]!='W' || hidden_sec[511+512*j]!='Q') && memcmp(hidden_sec+(512*j),zeroa,512))
		 dosbootok=0;
	     if((hidden_sec[512*j+512*(disk_num+2)]!='W' || hidden_sec[1+512*j+512*(disk_num+2)]!='W' || hidden_sec[511+512*j+512*(disk_num+2)]!='Q') && memcmp(hidden_sec+(512*j+512*(disk_num+2)),zeroa,512))
		 fatrootok=0;
	   }
	if(
	      ((hidden_sec[512*disk_num+510]=='W' && hidden_sec[512*disk_num+511]    =='Q') || !memcmp(hidden_sec+(512*disk_num),zeroa,512))
	   && ((hidden_sec[512*(disk_num+1)]=='W' && hidden_sec[512*(disk_num+1)+511]=='Q') || !memcmp(hidden_sec+(512*(disk_num+1)),zeroa,512))
	   && dosbootok==1
	   && fatrootok==1)
	  {
	    wprintf(inf,"  OK.");
	    return 1;
	  }
	else
	  {
	      wprintf(inf,"\n     Abnormal hard disk status.Something may go wrong");
	      wprintf(inf,"\n   if in High-Protected-Mode,see User's Manual.");
	      wprintf(inf,"\n   Will this installation be in Low-Protected-Mode?[Y]\b\b");
	      out_beep();
	      key=get_ch();
	      out_beep();
	      if(toupper(key)!='N')
		return 0;
	      else
		{
		 wprintf(inf,"N");
		 return 1;
		}
	  }
      }
  wprintf(inf,"  OK.");
  return 1;
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
/*   BKHEAD=(temp[2]&0xff)-1;*//*Can not pass Dongxiangjie's PC.*/
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

void quit(int i)
{
  out_beep();
  wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to quit...");
  get_ch();
  out_beep();wprintf(inf,"\n");
  close_all();
/*  restorecrtmode();*/
  gotoxy(x,y);
  setdisk(olddvr);
  exit(i);
}

void reboot(void)
 {
/*     union REGS in,out;*/
/*     clrscr();*/
/*     int86(0x19,&in,&out); */
     while(1);
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
void out_beep(void)  /* to act as  printf("\x7")  */
{
  sound(800);
  delay(10);
  nosound();
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