/*******************************************************************
  File name:     INSTALL.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          8/19/94
  Author:        WangQuan
  Function:      To install LASTLINE 2.5 Chinese version.
  Usage:         X:\ANYPATH>Y:install<CR>
		   X: = A:,B:,C:,D:...   Y: = A:,B:.
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/


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
int test_hidden_sec_ok(void);
void get_BK(void);
void quit(int i);
void reboot(void);

unsigned char Protected_Mode;
unsigned BKHEAD,BKTRACK;
WINGRA *inf;
char dvr[20]="A:*.*",boot[512],part[512];
extern int CCLIB,high_of_char;
main(int argc,char *argv[])
{
   WINGRA *p;
   FILE *fp,*sysfp;
   char fn[50];
   int dri,maxdrive,olddvr,key;
   char dospath[100],temp[512],tempp[512],k;
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   dvr[2]=0;
   mkdir("c:\\lastline");
   system("copy lsth.inf c:\\lastline >c:\\lastline\\mngrboot.exe");
   title("c:\\lastline\\lsth.inf");
   inf=open_win(8,10,18,70,1,1);
   check_sec();
   puthz(inf,"  请确认现在的操作系统正常否.\n",14,1);
   puthz(inf,"  确实正常吗?[Y]\b\b",14,1);
k4:
   key=getch();
   printf("\x7");
   if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	   goto k4;
   if(toupper(key)=='N')
	  {
	   puthz(inf,"N\n",14,1);
	   quit(1);
	  }
   puthz(inf,"\n  正在测试...",14,1);
   if(test_hidden_sec_ok())
     {
       puthz(inf,"\n  用高保护方式安装.\n",14,1);
       Protected_Mode = 1;
     }
   else
       Protected_Mode = 0;
   set_l();


  puthz(inf,"  DOS 路径是 C:\\DOS 吗?[Y]",14,1);
  k=getch();
  printf("\x7");
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      puthz(inf,"\b\bN",14,1);
      puthz(inf,"\n  请键入 DOS 路径:   ",14,1);
      scanf("%s",dospath);
      printf("\x7");
    }
  puthz(inf,"\n\n  请稍候...",14,1);
  p=open_win(20,10,25,70,1,1);
  nohigh(96,23*high_of_char,536,24*high_of_char,1,1);
  setcolor(4);
  setfillstyle(1,4);
  bar(104,23*high_of_char+2,528,24*high_of_char-2);
  puthz(p,"                     正在安装...\n",14,1);
  setone();setone();
  if((fp=fopen("c:\\aaaaaa.aaa","wt"))==NULL)
     puthz(inf,"打开文件 AUTOEXEC.BAT 错误.",14,1);
  else
    {
     fputs("@echo off\n",fp);
     fputs("c:\\lastline\\mngrboot/c\n",fp);
     fputs("c:\\lastline\\fatrsave\n",fp);
     fputs("echo on\n",fp);
    }
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
  setone();setone();
  strcpy(temp,"copy ");
  strcat(temp,dospath);
  strcpy(tempp,dospath);
  strcat(tempp,"\\sys.com");
  if((sysfp=fopen(tempp,"rb"))==NULL)
     strcpy(tempp,"\\sys.exe");
  else
     strcpy(tempp,"\\sys.com");
  fclose(sysfp);
  setone();setone();setone();setone();setone();  setone();
  setone();setone();setone();setone();setone();  setone();
  strcat(temp,tempp);
  strcat(temp," c:\\lastline\\trans.lst>c:\\aaaaaa.aaa");
  system(temp);
  setone();setone();setone();
  setone();setone();
  setone();
  /*system("exit");*/system("del c:\\aaaaaa.aaa");
  setone();setone();setone();setone();setone();setone();
  clr_win(inf,1);
  puthz(inf,"\n必要的文件已经拷贝完毕,现在存贮系统信息...",14,1);
  puthz(inf,"\n按任意键继续...",15,1);
  getch();
  puthz(inf,"\n",14,1);
  printf("\x7");
  puthz(inf,"\n请稍候...",14,1);
  system("mngrboot/i");
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
    for (i=0;i<11;i++)
      {
        vol[i]=~(vol[i]);
        if(vol[i]!=voll[i])
         {
           biosdisk(3,0,0,0,1,0xff,vol);
	   puthz(inf,"\n  非法用户或解密或未在软盘上运行.\n",14,1);
	   quit(1);
	 }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
        biosdisk(0,0x80,0,0,0,0,0);
        puthz(inf,"\n  错误.\n",14,1);
	quit(1);
      }

    _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\lastline\\lastline.cfg","wb+"))==NULL)
       {
	 puthz(inf,"\n错误.\n",14,1);
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
       puthz(inf,"\n  错误.\n",14,1);
       quit(1);
     }
   if(absread(toupper(dvr[0])-65,1,2000,part))
    if(absread(toupper(dvr[0])-65,1,2000,part))
     if(absread(toupper(dvr[0])-65,1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n  错误.\n",14,1);
       quit(1);
     }
   if(memcmp(boot,part,512))
    {
/*     biosdisk(3,toupper(dvr[0])-65,0,0,1,0xff,boot+0x101);*/
     puthz(inf,"\n  非法用户或解密或未在软盘上运行.\n",14,1);
     quit(1);
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
 }


int test_hidden_sec_ok(void)
{
  unsigned char hidden_sec[8192],temp[8192];
  unsigned disk_num,begin_sec,total_test_sec_num,i,ik;
  int key;
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
	      puthz(inf,"\n  对不起.\n  硬盘特殊,不能安装.",14,1);
	      quit(0);
	    }
  if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
    if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
      if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	  if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	    {
	      puthz(inf,"\n  对不起.\n  硬盘特殊,不能安装.",14,1);
	      quit(0);
	    }
  for(ik=0;ik<total_test_sec_num*512;ik++)
     if(temp[ik]!='W')
        {
	      puthz(inf,"\n  对不起.\n  硬盘特殊,不能安装.",14,1);
	      quit(0);
	}
  if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	    {
	      puthz(inf,"\n  硬盘特殊,只能用低保护方式安装.",14,1);
	      return 0;
	    }

  if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	    {
              puthz(inf,"\n  硬盘特殊,只能用低保护方式安装.",14,1);
	      return 0;
	    }


  for(i=0;i<512*total_test_sec_num;i++)
    if(hidden_sec[i]!=hidden_sec[0])
      {
	unsigned j,dosbootok=1,fatrootok=1,zeroa[512],zi;
	for (zi=0;zi<512;zi++)
	    zeroa[zi]=0;
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
             puthz(inf,"\n  完毕,未发现异常.",14,1);
	     return 1;
	  }
	else
	  {
              printf("\x7");
	      puthz(inf,"\n  硬盘不完全正常.如用高保护方式安装,可能出故障.",14,1);
	      puthz(inf,"\n  请参见用户手册.",14,1);
	      puthz(inf,"\n  用低保护方式安装吗?[Y]\b\b",14,1);
	      key=getch();
	      printf("\x7");
	      if(toupper(key)!='N')
		{
		 puthz(inf,"\n",14,1);
		 return 0;
		}
	      else
		{
		 puthz(inf,"N",14,1);
		 return 1;
		}
	  }
      }
  puthz(inf,"\n  完毕,未发现异常.",14,1);
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
/*   BKHEAD=(temp[2]&0xff)-1;*/
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
  
  printf("\x7");
  puthz(inf,"\n 按任意键退出...",15,1);
  close(CCLIB);
  getch();
  puthz(inf,"\n",14,1);
  printf("\x7");
  cleardevice();
  restorecrtmode();
  exit(i);
}
void reboot(void)
 {
/*     union REGS in,out;*/
     close(CCLIB);
/*     cleardevice();
     restorecrtmode();
     int86(0x19,&in,&out);*/
     while(1);
 }