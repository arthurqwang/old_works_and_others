/* INSTALL.c 1994 3 14, English version 2.0, */
/* Passed DOS 3.3a,DOS 5.0,DOS 6.0*/
/* Computer type passed:GW286,COMPAQ 386/33(25),AST 286*/
/*      Antai 286 ,At&t 386,DELL 433DE ,NONAME 286 ,so on*/
/*****************************************************************/
#include <stdio.h>
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
WINDOW *inf;
char dvr[10]="A:*.*";
char boot[512],part[512];
main(int argc,char *argv[])
{
   WINDOW *back1,*back2,*inff,*tit,*titt,*p,*pp;
   FILE *fp;
   int x,y,olddvr;
   char fn[50];
   char dospath[100],temp[512],k;
   struct ffblk ffb;
   olddvr=getdisk();
   x=wherex();y=wherey();
   back1=establish_window(11,5,19,64);
   set_colors(back1,ALL,BLUE,BLUE,DIM);
   display_window(back1);
   back2=establish_window(9,4,19,64);
   set_colors(back2,ALL,YELLOW,YELLOW,DIM);
   display_window(back2);
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
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   dvr[2]=0;
  wprintf(inf,"\n   DOS path is    C:\\DOS , right?[Y]\b\b");
  k=getch();
  printf("\x7");
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      wprintf(inf,"N");
      wprintf(inf,"\n   Enter path including DOS,please :  ");
      scanf("%s",dospath);
      printf("\x7");
    }
  wprintf(inf,"\n   Auto startup anti-virus software,ALWAYSEE ?[Y]\b\b");
  k=getch();
  printf("\x7");
  if(toupper(k)=='N') wprintf(inf,"N\n");
  wprintf(inf,"\n\n   Wait a while,please...");
  set_l();       /*include anti_trace()  */
  check_sec();
  set_title(p,"Installing...");
  display_window(pp);
  display_window(p);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  if((fp=fopen("c:\\aaaaaa.aaa","wt"))==NULL)
     wprintf(inf,"Error open AUTOEXEC.BAT.");
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
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);

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
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);
  /*system("exit");*/system("copy mngrboot.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy fatrsave.exe  c:\\lastline>c:\\aaaaaa.aaa"); wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy alwaysee.com  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy strchk1.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy strchk2.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy ");
  strcat(temp,dospath);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcat(temp,"\\sys.* c:\\lastline\\trans.*>c:\\aaaaaa.aaa");
  /*system("exit");*/
  system(temp);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("del c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  delay(500);
  delete_window(p);
  delete_window(pp);
  system("prmpt");
  system("mngrboot/b");
  system("fatrsave");
  can_trace();
  close_all();
  gotoxy(x,y);
  setdisk(olddvr);
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
    anti_trace();
    for (i=0;i<11;i++)
      {
	vol[i]=~(vol[i]);
	if(vol[i]!=voll[i])
	 {
	   biosdisk(3,0,0,0,1,0xff,vol);
	   wprintf(inf,"\n  Unlawful user or unlocking.\n");
	   exit(1);
	 }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
	biosdisk(0,0x80,0,0,0,0,0);
	wprintf(inf,"\n  Error.\n");
	exit(1);
      }
    mkdir("c:\\lastline");
    _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\lastline\\lastline.cfg","wb+"))==NULL)
       printf("\nError.\n");
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
       wprintf(inf,"\n  Error.\n");
       exit(1);
     }
   if(absread(toupper(dvr[0])-65,1,719/*2000*/,part)) /*High density(1.2M) uses 2000*/
    if(absread(toupper(dvr[0])-65,1,719,part))       /*Low density(360K) uses 719*/
     if(absread(toupper(dvr[0])-65,1,719,part))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       wprintf(inf,"\n  Error.\n");
       exit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-65,0,0,1,0xff,boot+0x101);
     wprintf(inf,"\n  Unlawful user or unlocking.\n");
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