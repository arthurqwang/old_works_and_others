/*INSTALL.C  CHINESE VERSION 2.0  1994 1 19*/
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
WINGRA *inf;
char dvr[20]="A:*.*";
extern int CCLIB,high_of_char;
main()
{
   WINGRA *p;
   FILE *fp;
   int jj,ii;
   char fn[50];
   int dri,maxdrive;
   char dospath[100],temp[512],doscen1[50],doscen2[50],k;
   struct ffblk ffb;
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
   mkdir("c:\\lastline");
   system("copy \\lastline\\lsth.inf c:\\lastline >c:\\lastline\\mngrboot.exe");
   title();
   inf=open_win(8,10,18,70,1,1);
		/*  wprintf(inf,"\n   DOS path is    C:\\DOS , right?[Y]\b\b");*/
    puthz(inf,"  DOS 路径是 C:\\DOS 吗?[Y]",14,1);
  k=getch();
  printf("\x7");
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      puthz(inf,"\b\bN",14,1);
      puthz(inf,"\n  请键入 DOS 路径:   ",14,1);
		/*Enter path including DOS,please :*/
      scanf("%s",dospath);
      printf("\x7");
    }
  findfirst("c:\\*.*",&ffb,FA_SYSTEM+FA_RDONLY+FA_HIDDEN);
  strcpy(doscen1,ffb.ff_name);
  findnext(&ffb);
  strcpy(doscen2,ffb.ff_name);

  puthz(inf,"\n  是否自动启动抗病毒软件 ALWAYSEE ? [Y]\b\b",14,1);
		/* Auto startup anti-virus software,ALWAYSEE ?[Y]*/
  k=getch();
  printf("\x7");
  if(toupper(k)=='N')
  puthz(inf,"N\n",14,1);
  puthz(inf,"\n\n  请稍候...",14,1);
		/* Wait a while,please...*/
  maxdrive=setdisk(toupper(dvr[0])-'A');
  set_l();
  check_sec();
		/*  set_title(p,"Installing...");*/
		/*正在安装...*/
  p=open_win(20,10,25,70,1,1);
  nohigh(96,23*high_of_char,536,24*high_of_char,1,1);
  setcolor(4);
  setfillstyle(1,4);
  bar(104,23*high_of_char+2,528,24*high_of_char-2);
  puthz(p,"                     正在安装...\n",14,1);
  if((fp=fopen("c:\\autoexec.bat","at"))==NULL)
     puthz(inf,"打开文件 AUTOEXEC.BAT 错误.",14,1);
		/*Error open AUTOEXEC.BAT.*/
  else
     if ((k==13) || (toupper(k)!='N'))
        fputs("c:\\lastline\\strchk1\n",fp);
     else
        fputs("c:\\lastline\\strchk2\n",fp);
  setone();setone();
  fclose(fp);

  setone();
  /*system("exit");*/system("copy mngrboot.exe  c:\\lastline>c:\\aaaaaa.aaa");
  setone();setone();setone();setone();
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
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_ARCH);
  setone();setone();
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_ARCH);
  setone();setone();
  strcpy(temp,"c:\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_ARCH);
  setone();setone();
  strcpy(temp,"c:\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_ARCH);
  setone();
  strcpy(temp,"copy c:\\");
  strcat(temp,doscen1);
  strcat(temp," c:\\lastline>c:\\aaaaaa.aaa");
  /*system("exit");*/system(temp);
  setone();setone();setone();
  strcpy(temp,"copy c:\\");
  strcat(temp,doscen2);
  strcat(temp," c:\\lastline>c:\\aaaaaa.aaa");
  /*system("exit");*/system(temp);
  setone();setone();
  strcpy(temp,"c:\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  setone();
  strcpy(temp,"c:\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen1);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  setone();
  strcpy(temp,"c:\\lastline\\");
  strcat(temp,doscen2);
  _chmod(temp,1,FA_RDONLY+FA_HIDDEN+FA_SYSTEM);
  setone();setone();
  /*system("exit");*/system("copy c:\\command.com c:\\lastline>c:\\aaaaaa.aaa");
  setone();
  strcpy(temp,"copy ");
  strcat(temp,dospath);
  setone();setone();setone();
  strcat(temp,"\\sys.* c:\\lastline>c:\\aaaaaa.aaa");
  /*system("exit");*/
  system(temp);
  setone();setone();setone();
  /*system("exit");*/system("del c:\\aaaaaa.aaa");
  setone();setone();setone();setone();setone();setone();
  clr_win(inf,1);
  puthz(inf,"\n必要的文件已经拷贝完毕,现在开始试验...",14,1);
		/*  wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any key to continue...");*/
  puthz(inf,"\n按任意键继续...",15,1);
  getch();
  printf("\x7");
  system("mngrboot/b");
  system("fatrsave");
  puthz(inf,"\n\n  第二次...",14,1);
	/* Again...*/
  system("fatrsave");
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
           puthz(inf,"\n  非法用户或解密.\n",14,1);
		/*Unlawful user or unlocking.*/
           exit(1);
         }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
        biosdisk(0,0x80,0,0,0,0,0);
        puthz(inf,"\n  错误.\n",14,1);
		/*Error.*/
        exit(1);
      }
    
    _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\lastline\\lastline.cfg","wb+"))==NULL)
       puthz(inf,"\n错误.\n",14,1);
		/*Error.*/
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
       puthz(inf,"\n  错误.\n",14,1);
		/*Error.*/
       exit(1);
     }
   if(absread(toupper(dvr[0])-65,1,2000,part))
    if(absread(toupper(dvr[0])-65,1,2000,part))
     if(absread(toupper(dvr[0])-65,1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n  错误.\n",14,1);
		/*Error.*/
       exit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-65,0,0,1,0xff,boot+0x101);
     puthz(inf,"\n  非法用户或解密.\n",14,1);
		/*Unlawful user or unlocking.*/
     exit(1);
    }
 }
