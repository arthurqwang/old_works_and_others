

/*INSTALL.C  CHINESE VERSION 2.0  1994 3 14*/
/*Passed DOS 3.3a,DOS5.0,DOS 6.0 */
/*Passed computer type :GW286,DELL 433DE(486,1000M HD)*/
/*     Noname 286,ANTAI 286,AST 286,AT&T 386,COMPAQ 386/33(25)*/
/***************************************************/
#include <stdio.h>
#include "twingra.h"
#include <string.h>
#include <dir.h>
#include <dos.h>
#include <io.h>
#include <stdlib.h>
#include <process.h>
#include <ctype.h>
void set_l(void);
void setone(void);
void check_sec(void);
unsigned get_disk_num(void);
int readparttable(int way);
WINGRA *inf;
char dvr[20]="A:*.*",boot[512],part[512];
extern int CCLIB,high_of_char;
main(int argc,char *argv[])
{
   WINGRA *p;
   FILE *fp;
   char fn[50];
   int olddvr;
   char dospath[100],temp[512],k;
   struct ffblk ffb;
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   dvr[2]=0;
   mkdir("c:\\lastline");
   system("copy lsth.inf c:\\lastline >c:\\lastline\\mngrboot.exe");
   title("c:\\lastline\\lsth.inf");
   inf=open_win(8,10,18,70,1,1);
		/*  wprintf(inf,"\n   DOS path is    C:\\DOS , right?[Y]\b\b");*/
    puthz(inf,"  DOS {16311} C:\\DOS {16408}?[Y]",14,1);
  k=getch();
  printf("\x7");
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      puthz(inf,"\b\bN",14,1);
      puthz(inf,"\n  {16441} DOS {16538}:   ",14,1);
		/*Enter path including DOS,please :*/
      scanf("%s",dospath);
      printf("\x7");
    }
  puthz(inf,"\n  {16603} ALWAYSEE ? [Y]\b\b",14,1);
		/* Auto startup anti-virus software,ALWAYSEE ?[Y]*/
  k=getch();
  printf("\x7");
  if(toupper(k)=='N')
  puthz(inf,"N\n",14,1);
  puthz(inf,"\n\n  {16956}...",14,1);
		/* Wait a while,please...*/
  set_l();
  check_sec();
		/*  set_title(p,"Installing...");*/
		/*{17053}...*/
  p=open_win(20,10,25,70,1,1);
  nohigh(96,23*high_of_char,536,24*high_of_char,1,1);
  setcolor(4);
  setfillstyle(1,4);
  bar(104,23*high_of_char+2,528,24*high_of_char-2);
  puthz(p,"                     {17053}...\n",14,1);
  setone();setone();
  if((fp=fopen("c:\\aaaaaa.aaa","wt"))==NULL)
     puthz(inf,"{17182} AUTOEXEC.BAT {11160}.",14,1);
  else
    {
     fputs("@echo off\n",fp);
     if ((k==13) || (toupper(k)!='N'))
	fputs("c:\\lastline\\strchk1\n",fp);
     else
	fputs("c:\\lastline\\strchk2\n",fp);
    }
  fputs("echo on\n",fp);
  fclose(fp);
  setone();setone();
  setone();setone();
  if((fp=fopen("C:\\AUTOEXEC.BAT","rt")) != NULL)
    {
      fclose(fp);
      system("ren c:\\autoexec.bat cexeotua.tab");
      system("copy c:\\aaaaaa.aaa+c:\\cexeotua.tab c:\\autoexec.bat>c:\\aaaaaa.aab");
      system("del c:\\cexeotua.tab");
      system("del c:\\aaaaaa.aab");
    }
  else
    {
     system("copy c:\\aaaaaa.aaa c:\\autoexec.bat>c:\\aaaaaa.aab");
     system("del c:\\aaaaaa.aab");
    }
  setone();
  setone();setone();
  setone();
  /*system("exit");*/system("copy mngrboot.exe  c:\\lastline>c:\\aaaaaa.aaa");
  setone();setone();setone();setone();
  setone();setone();
  setone();
  /*system("exit");*/system("copy fatrsave.exe  c:\\lastline>c:\\aaaaaa.aaa"); setone();
  setone();setone();setone();
  setone();setone();setone();
  setone();setone();
  /*system("exit");*/system("copy alwaysee.com  c:\\lastline>c:\\aaaaaa.aaa");
  setone();setone();
  /*system("exit");*/system("copy strchk1.exe  c:\\lastline>c:\\aaaaaa.aaa");
  setone();setone();setone();
  /*system("exit");*/system("copy strchk2.exe  c:\\lastline>c:\\aaaaaa.aaa");
  setone();setone();
  setone();
  setone();setone();setone();
  strcpy(temp,"copy ");
  strcat(temp,dospath);
  setone();setone();setone();
  strcat(temp,"\\sys.* c:\\lastline\\trans.*>c:\\aaaaaa.aaa");
  /*system("exit");*/
  system(temp);
  setone();setone();setone();
  setone();setone();
  setone();
  /*system("exit");*/system("del c:\\aaaaaa.aaa");
  setone();setone();setone();setone();setone();setone();
  clr_win(inf,1);
  puthz(inf,"\n{17311},{17664}...",14,1);
		/*  wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any key to continue...");*/
  puthz(inf,"\n{194}...",15,1);
  getch();
  printf("\x7");
  system("mngrboot/b");
  system("fatrsave");
  can_trace();
  setdisk(olddvr);
  }
void setone(void)
 {
   static int i=112;
   setcolor(3);
   setfillstyle(1,15);
   fillellipse(i,23*high_of_char+8,4,3);
   i+=8;
 }
void set_l(void)
  {
    struct fatinfo p;
    int i,maxdnum;
    FILE *fp;
    char vol[501],voll[12]={ 0xa8,
               0xae,0xb3,0xbe,0xac,0xab,0xb3,0xb6,0xd1,0xb1,0xba,0};
    struct ffblk fff,*pv;
    pv=&fff;
    findfirst("*.*",pv,FA_LABEL);
    strcpy(vol,pv->ff_name);
    anti_trace();
    for (i=0;i<11;i++)
      {
        vol[i]=~(vol[i]);
        if(vol[i]!=voll[i])
         {
           biosdisk(3,0,0,0,1,0xff,vol);
           puthz(inf,"\n  {11225}.\n",14,1);
		/*Unlawful user or unlocking.*/
           exit(1);
         }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
        biosdisk(0,0x80,0,0,0,0,0);
        puthz(inf,"\n  {11160}.\n",14,1);
		/*Error.*/
        exit(1);
      }

    _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\lastline\\lastline.cfg","wb+"))==NULL)
       puthz(inf,"\n{11160}.\n",14,1);
		/*Error.*/
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
       puthz(inf,"\n  {11160}.\n",14,1);
		/*Error.*/
       exit(1);
     }
   if(absread(toupper(dvr[0])-65,1,2000,part))
    if(absread(toupper(dvr[0])-65,1,2000,part))
     if(absread(toupper(dvr[0])-65,1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n  {11160}.\n",14,1);
		/*Error.*/
       exit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-65,0,0,1,0xff,boot+0x101);
     puthz(inf,"\n  {11225}.\n",14,1);
		/*Unlawful user or unlocking.*/
     exit(1);
    }
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
 }