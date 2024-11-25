/* INSTALL.c 1994 1 19, English version 2.0, */
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
WINDOW *inf;
char dvr[10]="A:*.*";
main()
{
   WINDOW *back1,*back2,*inff,*tit,*titt,*p,*pp;
   FILE *fp;
   int x,y,ii,jj;
   char fn[50];
   int dri,maxdrive;
   char dospath[100],temp[512],doscen1[50],doscen2[50],k;
   struct ffblk ffb;
   x=wherex();y=wherey();
   back1=establish_window(11,5,19,64);
   set_colors(back1,ALL,BLUE,BLUE,DIM);
   display_window(back1);
   back2=establish_window(9,4,19,64);
   set_colors(back2,ALL,YELLOW,YELLOW,DIM);
   display_window(back2);
   maxdrive=setdisk(getdisk());

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
   for(ii=0;ii<10;ii++)
     {
       for(jj=0;jj<3;jj++)
	 if(!biosdisk(2,ii,0,0,1,1,temp))
	    {
              dvr[0]=ii+'A';
	      findfirst(dvr,&ffb,FA_LABEL);
	      if(!strcmp(ffb.ff_name,"WQLASTLI.NE"))
		goto jmp;
	    }
     }
jmp:
   if(ii>=9) exit(1);
   setdisk(ii);
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
  findfirst("c:\\*.*",&ffb,FA_SYSTEM+FA_RDONLY+FA_HIDDEN);
  strcpy(doscen1,ffb.ff_name);
  findnext(&ffb);
  strcpy(doscen2,ffb.ff_name);

  wprintf(inf,"\n   Auto startup anti-virus software,ALWAYSEE ?[Y]\b\b");
  k=getch();
  printf("\x7");
  if(toupper(k)=='N') wprintf(inf,"N\n");
  wprintf(inf,"\n\n   Wait a while,please...");
  maxdrive=setdisk(toupper(dvr[0])-'A');
  set_l();
  check_sec();
  set_title(p,"Installing...");
  display_window(pp);
  display_window(p);
  if((fp=fopen("c:\\autoexec.bat","at"))==NULL)
     wprintf(inf,"Error open AUTOEXEC.BAT.");
  else
     if ((k==13) || (toupper(k)!='N'))
	fputs("c:\\lastline\\strchk1\n",fp);
     else
	fputs("c:\\lastline\\strchk2\n",fp);
  wputchar(p,219);wputchar(p,219);
  fclose(fp);
  wputchar(p,219);
  /*system("exit");*/system("copy mngrboot.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy fatrsave.exe  c:\\lastline>c:\\aaaaaa.aaa"); wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy alwaysee.com  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy strchk1.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy strchk2.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_ARCH);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_ARCH);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_ARCH);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_ARCH);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy c:\\");
  strcat(temp,doscen1);
  strcat(temp," c:\\lastline>c:\\aaaaaa.aaa");
  /*system("exit");*/system(temp);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy c:\\");
  strcat(temp,doscen2);
  strcat(temp," c:\\lastline>c:\\aaaaaa.aaa");
  /*system("exit");*/system(temp);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("copy c:\\command.com c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy ");
  strcat(temp,dospath);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcat(temp,"\\sys.* c:\\lastline>c:\\aaaaaa.aaa");
  /*system("exit");*/
  system(temp);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  /*system("exit");*/system("del c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  delete_window(p);
  delete_window(pp);
  system("prmpt");
  system("mngrboot/b");
  system("fatrsave");
  wprintf(inf,"\n\n   Again...");
  system("fatrsave");
  close_all();
  gotoxy(x,y);
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
    maxdnum=setdisk(getdisk());
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
   char boot[512],part[512];
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
