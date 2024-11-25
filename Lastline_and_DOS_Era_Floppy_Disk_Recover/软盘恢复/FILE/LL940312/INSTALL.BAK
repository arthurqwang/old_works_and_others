/*******************************************************************
  File name:     INSTALL.C
  Belong to:     Saviour 3.0 Chinese version
  Date:          FEB/7/96
  Author:        WangQuan
  Function:      To install Saviour 3.0 Chinese version.
		 It dosn't call LOADLL.EXE.
  Usage:         Execute INSTALL.EXE in a floppy disk.
  Where stored:  Floppy disk "Saviour 3.0 Chinese version
		 Source files"(Saviour 3.0 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2,DOS 6.21
  Computer
       passed:   GW286,COMPAQ 386/33(25),486,586,AST 286
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
#include <alloc.h>
void set_l(void);
void setone(void);
void check_sec(void);
unsigned get_disk_num(void);
int readparttable(int way);
int test_hidden_sec_ok(void);
void get_BK(void);
void quit(int i);
void reboot(void);
void out_beep(void);
void getaline(FILE *fp,char *aline);


unsigned char Protected_Mode;
unsigned BKHEAD,BKTRACK;
WINGRA *inf;
char dvr[20]="A:*.*",boot[512],part[512];
extern int CCLIB,high_of_char;
int olddvr;
main(int argc,char *argv[])
{
   WINGRA *p;
   FILE *fp,*sysfp;
   char fn[50];
   int dri,maxdrive,key,LL_exist_flag=0;
   unsigned char dospath[100],temp[512],tempp[512],temppp[100],tempppp[100],k;
   char pi[2000];
   struct ffblk fff;
   olddvr=getdisk();
/*   if(getenv("MSS")==NULL) {setdisk(olddvr);exit(1);}*/
   LL_exist_flag = (!findfirst("C:\\SV30",&fff,FA_DIREC));
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   dvr[2]=0;
   mkdir("c:\\SV30");
   system("copy MSSHZ.LIB c:\\SV30>NUL");
   title("c:\\SV30\\MSSHZ.LIB");
   wrt_SN_with_fd();
   inf=open_win(8,10,18,70,7,1);
   puthz(inf,"  安装之前请仔细阅读《用户手册》.\n  继续安装吗? [Y]\b\b",0,7);
   if(toupper(get_ch()) == 'N')
    {
     puthz(inf,"N",0,7);
     out_beep();
     puthz(inf,"\n 按任意键退出...",1,7);
     close(CCLIB);
     get_ch();
     puthz(inf,"\n",0,7);
     out_beep();
     cleardevice();
     restorecrtmode();
     if(!LL_exist_flag)
	      {
	       system("c:");
	       system("cd\\SV30");
	       remove("MSSHZ.LIB");
	       system("cd\\");
	       rmdir("SV30");
	      }
     setdisk(olddvr);
     exit(1);
    }
   out_beep();
   check_sec();
   puthz(inf,"\n  请确认现在的操作系统和硬盘正常否.\n",0,7);
   puthz(inf,"  确认正常吗?[Y]\b\b",0,7);
k4:
   key=get_ch();
   out_beep();
   if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	   goto k4;
   if(toupper(key)=='N')
	  {
	   puthz(inf,"N\n",0,7);

	   out_beep();
	   puthz(inf,"\n 按任意键退出...",1,7);
	   close(CCLIB);
	   get_ch();
	   puthz(inf,"\n",0,7);
	   out_beep();
	   cleardevice();
	   restorecrtmode();
           if(!LL_exist_flag)
	      {
	       system("c:");
	       system("cd\\SV30");
	       remove("MSSHZ.LIB");
	       system("cd\\");
	       rmdir("SV30");
	      }
	   setdisk(olddvr);
	   exit(1);
	  }
   if(strcmp(strupr(argv[1]),"/S"))
   {
   puthz(inf,"\n  正在测试...",0,7);
   if(test_hidden_sec_ok())
     {
       puthz(inf,"\n  将用高保护方式安装.\n",0,7);
       Protected_Mode = 1;
     }
   else
       Protected_Mode = 0;
   }
   else
   {
   puthz(inf,"\n  使用特别方式安装. 该方式可能有危险!\n  继续安装吗? [N]\b\b",0,7);
k5:
   key=get_ch();
   out_beep();
   if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	   goto k5;
   if(toupper(key)=='N' || key==13 )
	  {
	   out_beep();
	   puthz(inf,"\n 按任意键退出...",1,7);
	   close(CCLIB);
	   get_ch();
	   puthz(inf,"\n",0,7);
	   out_beep();
	   cleardevice();
	   restorecrtmode();
           if(!LL_exist_flag)
	      {
	       system("c:");
	       system("cd\\SV30");
	       remove("MSSHZ.LIB");
	       system("cd\\");
	       rmdir("SV30");
	      }
	   setdisk(olddvr);
	   exit(1);
	  }
   else
      puthz(inf,"Y\n",0,7);

   Protected_Mode = 2;
   }
   set_l();


  puthz(inf,"  DOS 路径是 C:\\DOS 吗?[Y]",0,7);
  k=get_ch();
  out_beep();
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      puthz(inf,"\b\bN",0,7);
      puthz(inf,"\n  请键入 DOS 路径:   ",0,7);
      setcolor(0);
      setfillstyle(SOLID_FILL,0);
      bar((inf->curcol+2)*8,(inf->curline-1)*high_of_char,
	  (inf->curcol+35)*8,(inf->curline-1)*high_of_char+15);
      while(!strcmp(gets(dospath),NULL))
	 gotoxy(inf->curcol+4,inf->curline);
      out_beep();
    }
  strcpy(temppp,dospath);
  strcat(temppp,"\\sys.com");
  strcpy(tempppp,dospath);
  strcat(tempppp,"\\sys.exe");
  if(((sysfp=fopen(temppp,"rb"))==NULL) && ((sysfp=fopen(tempppp,"rb"))==NULL))
  {
    puthz(inf,"\n  文件未找到,参见用户手册.\n  继续安装吗? [N]\b\b",0,7);
    k=get_ch();
    if(toupper(k) != 'Y')
	{
	   out_beep();
	   puthz(inf,"\n 按任意键退出...",1,7);
	   close(CCLIB);
	   get_ch();
	   puthz(inf,"\n",0,7);
	   out_beep();
	   cleardevice();
	   restorecrtmode();
           if(!LL_exist_flag)
	      {
	       system("c:");
	       system("cd\\SV30");
	       remove("MSSHZ.LIB");
               _chmod("c:\\SV30\\MSS.cfg",1,FA_ARCH);
	       remove("MSS.cfg");
	       system("cd\\");
	       rmdir("SV30");
	      }
	   setdisk(olddvr);
	   exit(1);
	}
    else
      puthz(inf,"Y",0,7);
  }
  fclose(sysfp);

  puthz(inf,"\n\n  请稍候...",0,7);
  p=open_win(20,10,25,70,7,1);
  nohigh(96,23*high_of_char,536,24*high_of_char,7,1);
  setcolor(15);
  setfillstyle(1,15);
  bar(104,23*high_of_char+2,528,24*high_of_char-2);
  puthz(p,"                     正在安装...\n",0,7);
  setone();setone();

/*向AUTOEXEC.BAT 写 BTMNGR/C ,SAVEFAT*/



  if((fp=fopen("c:\\aaaaaa.LL$","wt"))==NULL)
     puthz(inf,"\n  打开文件 AUTOEXEC.BAT 错误.",0,7);
  else
    {
     fputs("@echo off\n",fp);
     fputs("c:\\SV30\\BTMNGR/c\n",fp);
     fputs("c:\\SV30\\SAVEFAT\n",fp);
     fputs("echo on\n",fp);
    }
  setone();setone();
  setone();setone();
  if((sysfp=fopen("C:\\AUTOEXEC.BAT","rt")) != NULL)
    {
       while(!feof(sysfp))
	{
	  getaline(sysfp,pi);
	  strupr(pi);
	  if(!(strstr(pi,"BTMNGR")||strstr(pi,"SAVEFAT")))
	    {
	     fputs(pi,fp);
	     fputc('\n',fp);
	    }
	}
    }
  fcloseall();

  system("copy c:\\aaaaaa.LL$ c:\\autoexec.bat>NUL");
  system("del c:\\aaaaaa.LL$>NUL");
/************************************************/
  setone();
  setone();setone();
  setone();
  /*system("exit");*/system("copy BTMNGR.exe  c:\\SV30>NUL");
  setone();setone();setone();setone();
  setone();setone();
  setone();
  /*system("exit");*/system("copy SAVEFAT.exe  c:\\SV30>NUL"); setone();
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
  strcat(temp," c:\\SV30\\MSSSYS.EX>NUL");
  setcolor(3);
  getimage(100,23*high_of_char,300,24*high_of_char,pi);
  system(temp);
  putimage(100,23*high_of_char,pi,0);
  setone();setone();setone();
  setone();setone();
  setone();
  setone();setone();setone();setone();setone();setone();
  clr_win(inf,1);
  puthz(inf,"\nMSS正在处理...",0,7);
  puthz(inf,"\n按任意键继续...",1,7);
  get_ch();
  puthz(inf,"\n",0,7);
  out_beep();
  puthz(inf,"\n请稍候...",0,7);
  system("BTMNGR/i");
  }
void setone(void)
 {
   static int i=112;
   setcolor(3);
   setfillstyle(1,4);
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
	   puthz(inf,"\n  非法用户或解密或未在软盘上运行.\n",0,7);
	   quit(1);
	 }
      }
    if(biosdisk(2,0x80,0,0,1,1,vol))
      {
        biosdisk(0,0x80,0,0,0,0,0);
        puthz(inf,"\n  错误.\n",0,7);
	quit(1);
      }

    _chmod("c:\\SV30\\MSS.cfg",1,FA_ARCH);
    if((fp=fopen("c:\\SV30\\MSS.cfg","wb+"))==NULL)
       {
	 puthz(inf,"\n错误.\n",0,7);
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
    _chmod("c:\\SV30\\MSS.cfg",1,FA_RDONLY+FA_HIDDEN);
    }

void check_sec(void)
 {
   if(absread(toupper(dvr[0])-65,1,0,boot))
    if(absread(toupper(dvr[0])-65,1,0,boot))
     if(absread(toupper(dvr[0])-65,1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n  错误.\n",0,7);
       quit(1);
     }
   if(absread(toupper(dvr[0])-65,1,2000,part))
    if(absread(toupper(dvr[0])-65,1,2000,part))
     if(absread(toupper(dvr[0])-65,1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n  错误.\n",0,7);
       quit(1);
     }
   if(memcmp(boot,part,512))
    {
/*     biosdisk(3,toupper(dvr[0])-65,0,0,1,0xff,boot+0x101);*/
     puthz(inf,"\n  非法用户或解密或未在软盘上运行.\n",0,7);
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
	      puthz(inf,"\n  对不起.\n  硬盘特殊,不能安装.",0,7);
	      quit(0);
	    }
  if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
    if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
      if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	  if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_test_sec_num,temp))
	    {
	      puthz(inf,"\n  对不起.\n  硬盘特殊,不能安装.",0,7);
	      quit(0);
	    }
  for(ik=0;ik<total_test_sec_num*512;ik++)
     if(temp[ik]!='W')
        {
	      puthz(inf,"\n  对不起.\n  硬盘特殊,不能安装.",0,7);
	      quit(0);
	}
  if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(2,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	    {
	      puthz(inf,"\n  硬盘特殊,只能用低保护方式安装.",0,7);
	      return 0;
	    }

  if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
    if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
      if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	  if(biosdisk(3,0x80,0,0,begin_sec,total_test_sec_num,hidden_sec))
	    {
              puthz(inf,"\n  硬盘特殊,只能用低保护方式安装.",0,7);
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
             puthz(inf,"\n  完毕,未发现异常.",0,7);
	     return 1;
	  }
	else
	  {
              out_beep();
	      puthz(inf,"\n  硬盘状态异常.如用高保护方式安装,可能出故障.",0,7);
	      puthz(inf,"\n  请参见用户手册.",0,7);
	      puthz(inf,"\n  用低保护方式安装吗?[Y]\b\b",0,7);
	      key=get_ch();
	      out_beep();
	      if(toupper(key)!='N')
		{
		 puthz(inf,"\n",0,7);
		 return 0;
		}
	      else
		{
		 puthz(inf,"N",0,7);
		 return 1;
		}
	  }
      }
  puthz(inf,"\n  完毕,未发现异常.",0,7);
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
  
  out_beep();
  puthz(inf,"\n 按任意键退出...",1,7);
  close(CCLIB);
  get_ch();
  puthz(inf,"\n",0,7);
  out_beep();
  cleardevice();
  restorecrtmode();
  setdisk(olddvr);
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