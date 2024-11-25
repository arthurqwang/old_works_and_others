/*******************************************************************
  File name:     FATRSAVE.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          8/12/94
  Author:        WangQuan
  Function:      To Backup FAT & ROOT.
  Usage:         X:\ANYPATH>Y:\ANYPATH\FATRSAVE<CR>
		   X:,Y: = A:,B:,C:,D:...
		 BUT C:\LASTLINE\LASTLINE.CFG must be right.
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/


/**************************  HEAD FILES  *********************************/
#include "twingra.h"
#include <stdio.h>
#include <dos.h>
#include <string.h>
#include <io.h>
#include <dir.h>
/*******************  DEFINES  ******************************************/
#define  BPS 512
#define  DISKRESET biosdisk(0,0x80,0,0,0,0,0)
#define  SECTOR_PER_CLUSTER (((unsigned)BPB[0xd])&0xff)
#define  SECTOR_KEPT       ((((unsigned)BPB[0xe])&0xff)+(((unsigned)BPB[0xf])&0xff)*256)
#define  FAT_NUMBER        (((unsigned)BPB[0x10])&0xff)
#define  DIRNUMBER_OF_ROOT ((((unsigned)BPB[0x11])&0xff)+(((unsigned)BPB[0x12])&0xff)*256)
#define  TOTAL_SECTOR      ((((unsigned)BPB[0x13])&0xff)+(((unsigned)BPB[0x14])&0xff)*256)
#define  SECTOR_PER_FAT    ((((unsigned)BPB[0x16])&0xff)+(((unsigned)BPB[0x17])&0xff)*256)
#define  SECTOR_PER_TRACK  ((((unsigned)BPB[0x18])&0xff)+(((unsigned)BPB[0x19])&0xff)*256)
#define  HEAD              ((((unsigned)BPB[0x1a])&0xff)+(((unsigned)BPB[0x1b])&0xff)*256)
#define  SECTOR_HIDDEN     ((((unsigned)BPB[0x1c])&0xff)+(((unsigned)BPB[0x1d])&0xff)*256)
#define  START_SECTOR_NUMBER   SECTOR_KEPT
/******************** DECLARE FUNCTIONS **************************/
void puticon(int lgdrive);
int save_cluster_chain(unsigned hsecter,unsigned start_cluster,unsigned total_sector,unsigned lgdrive);
int use_16_bit(unsigned start_cluster,unsigned lgdrive);
int use_12_bit(unsigned start_cluster,unsigned lgdrive);
unsigned get_start_cluster(unsigned total_sector,unsigned lgdrive);
unsigned get_total_sector_of_fr(void);
int get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
unsigned check_lock(int drive);
void infwq(void);
void get_BK(void);
int absread50(int drive,int num,long start_sector,char *b);
int absread30(int drive,int num,long start_sector,char *b);
int creatfatroot(char *filenm,unsigned total_sector);
int get_MAY_WRITE_TO_H_SEC(void);
void quit(int i);
/**************************** GLOBLE VARIBLE ************************/
char *findstr(char *str1,char *str2,long num);
int lgdrive;
unsigned BKHEAD,BKTRACK,MAY_WRITE_TO_H_SEC;
char end_inf[20],BPB[0x20],boot[BPS],fatroot[25600];
union REGS in,out;
struct SREGS dsbx;
struct fatinfo p;
int (*rdabs)();
WINGRA *inf=NULL,*icon=NULL;
extern int CCLIB,high_of_char;
/*********************** MAIN PROGROM *************************/
main()
 {
   int maxdrive;
   FILE *fp;
   unsigned char filenm[15]="";
   unsigned hsector,total_sector,start_cluster,i=0;
   struct ffblk fblk;
   title("c:\\lastline\\lsth.inf");
   anti_trace();
   icon=open_win(8,10,12,70,1,0);
   if(check_lock(0x80)==0) quit(1);
   MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
/*********************** BEGINNIG SAVE FAT&ROOT FOR DISKS ****************/
   get_BK();
   puthz(icon,"处理逻辑盘",14,1);
   maxdrive=get_disk_num();
   high(95,high_of_char*10+5,190,high_of_char*10+7,3,1);
NXT:
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
   {
   boot[0]=lgdrive+'A';
   boot[1]=0;
   strcat(boot,":\\*.*");
   if(((findfirst(boot,&fblk,0))==-1)&&((findfirst(boot,&fblk,FA_DIREC))==-1))
     continue;
   i=0;
   if(end_inf[lgdrive+2]==1)
     rdabs=absread50;
   else
     rdabs=absread30;
   puticon(lgdrive);
   if(get_BPB(lgdrive)==-1) continue;
   total_sector=get_total_sector_of_fr();
   filenm[0]=lgdrive+'c'-2;
   filenm[1]=0;
   strcat(filenm,":\\fat&root.img");
   if(_chmod(filenm,1,FA_ARCH)==-1)
     if(creatfatroot(filenm,total_sector)==-1) continue;
   if((fp=fopen(filenm,"r+b"))==NULL)
     {
       inf=open_win(14,10,24,70,1,1);
       puthz(inf,"不能备份FAT和ROOT.\n",14,1);
       printf("\x7");
       puthz(inf,"按任意键继续...",15,1);
       getch();
       printf("\x7");
       puthz(inf,"\n",14,1);
       continue;
     }
   for (i=SECTOR_PER_FAT;i<total_sector;i+=50)
     {
       if((*rdabs)(lgdrive,50,(long)(START_SECTOR_NUMBER+i),fatroot))
	 {
	   DISKRESET;
	   inf=open_win(14,10,24,70,1,1);
	   puthz(inf,"读FAT和ROOT错误.\n",14,1);
           printf("\x7");
	   puthz(inf,"按任意键继续...",15,1);
	   getch();
	   printf("\x7");
	   puthz(inf,"\n",14,1);
	   goto NXT;
	 }
       fwrite(fatroot,BPS*50,1,fp);
     }
   fclose(fp);
   _chmod(filenm,1,FA_HIDDEN+FA_RDONLY);
   if((start_cluster=get_start_cluster(total_sector,lgdrive))==0) continue;
   hsector=lgdrive+9;
   if(save_cluster_chain(hsector,start_cluster,total_sector,lgdrive)==-1) continue;
 }
close(CCLIB);
cleardevice();
restorecrtmode();
exit(0);
}
/********************* FUNCTIONS ********************/
int save_cluster_chain(unsigned hsector,unsigned start_cluster,unsigned total_sector,unsigned lgdrive)
  {
    unsigned sector_of_nonDOS,itemnumber_of_fat;
    sector_of_nonDOS=SECTOR_KEPT+total_sector;
    itemnumber_of_fat=(TOTAL_SECTOR-sector_of_nonDOS)/SECTOR_PER_CLUSTER;
    if((itemnumber_of_fat>4080) || (TOTAL_SECTOR==0))
      {
	if(use_16_bit(start_cluster,lgdrive)==-1) return -1;
      }
    else
      {
	if(use_12_bit(start_cluster,lgdrive)==-1) return -1;
      }
    boot[0]='W';boot[1]='W';boot[511]='Q';
    if(MAY_WRITE_TO_H_SEC==1)
    if(biosdisk(3,0x80,0,0,hsector,1,boot))
      {
	   DISKRESET;
	   inf=open_win(14,10,24,70,1,1);
	   puthz(inf,"存贮FAT和ROOT信息错误.\n",14,1);
           printf("\x7");
	   puthz(inf,"按任意键继续...",15,1);
	   getch();
	   puthz(inf,"\n",14,1);
	   printf("\x7");
      }
    if(biosdisk(3,0x80,BKHEAD,BKTRACK,hsector,1,boot))
      {
	   DISKRESET;
	   inf=open_win(14,10,24,70,1,1);
	   puthz(inf,"存贮FAT和ROOT信息错误.\n",14,1);
           printf("\x7");
	   puthz(inf,"按任意键继续...",15,1);
	   getch();
	   puthz(inf,"\n",14,1);
	   printf("\x7");
	   return -1;
      }
    return 1;
  }

int use_16_bit(unsigned start_cluster,unsigned lgdrive)
  {
  long pfat;
  unsigned ii=2,temp;
  unsigned char fname[]="C:\\FAT&ROOT.IMG";
  FILE *fp;
  fname[0]=lgdrive+'A';
  _chmod(fname,1,FA_ARCH);
  if((fp=fopen(fname,"rb"))==NULL)
    {
       inf=open_win(14,10,24,70,1,1);
       puthz(inf,"\n读",14,1);
       puthz(inf,fname,14,1);
       puthz(inf,"错误.\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
       fclose(fp);
       return -1;
    }
  pfat=start_cluster;
  boot[3]=start_cluster&0xff;
  boot[2]=(start_cluster>>8)&0xff;
  while(!((pfat&0xffffL)>=0xfff8L))
   {
    fseek(fp,pfat*2L,SEEK_SET);
    fread(&temp,2,1,fp);
    boot[ii*2+1]=temp&0xff;
    boot[ii*2]=(temp>>8)&0xff;
    pfat=(long)temp;
    ii++;
   }
   fclose(fp);
   _chmod(fname,1,FA_HIDDEN+FA_RDONLY);
   return 1;
  }


int use_12_bit(unsigned start_cluster,unsigned lgdrive)
  {
  long pfat;
  unsigned ii=2,temp;
  float mm;
  unsigned char fname[]="C:\\FAT&ROOT.IMG";
  FILE *fp;
  fname[0]=lgdrive+'A';
  _chmod(fname,1,FA_ARCH);
  if((fp=fopen(fname,"rb"))==NULL)
    {
       inf=open_win(14,10,24,70,1,1);
       puthz(inf,"\n读",14,1);
       puthz(inf,fname,14,1);
       puthz(inf,"错误.\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
       fclose(fp);
       return -1;
    }
  pfat=start_cluster;
  boot[3]=start_cluster&0xff;
  boot[2]=(start_cluster>>8)&0xff;
  while(!((pfat&0xfffL)>=0x0ff8L))
   {
    mm=(float)pfat*1.5;
    fseek(fp,(long unsigned)mm,SEEK_SET);
    fread(&temp,2,1,fp);
    if(mm-(float)((long unsigned)mm)==0.0)
      temp &= 0xfff;
    else
      temp >>= 4;
    boot[ii*2+1]=temp & 0xff;
    boot[ii*2]=(temp>>8) & 0xff;
    pfat=(long)(temp & 0xfff);
    ii++;
   }
   fclose(fp);
   _chmod(fname,1,FA_HIDDEN+FA_RDONLY);
   return 1;
  }

unsigned get_start_cluster(unsigned total_sector,unsigned lgdrive)
  {
    unsigned i=0;
    char *p=0;
    for(i=0;i<total_sector;i+=9)
      {
	if((*rdabs)(lgdrive,10,(long)(SECTOR_PER_FAT*FAT_NUMBER+i),fatroot))
	  {   DISKRESET;
	      inf=open_win(14,10,24,70,1,1);
	      puthz(inf,"读FAT和ROOT错误.\n",14,1);
	      puthz(inf,"按任意键继续...",15,1);
	      printf("\x7");
	      getch();
	      puthz(inf,"\n",14,1);
	      printf("\x7");
	      return 0;
	  }
	if((p=findstr(fatroot,"FAT&ROOTIMG",BPS*10))!=NULL)
	   break;
      }
      if(!p)
	{
	  inf=open_win(14,10,24,70,1,1);
	  puthz(inf,"文件FAT&ROOT.IMG 被破坏.\n",14,1);
	  puthz(inf,"按任意键继续...",15,1);
	  printf("\x7");
	  getch();
	  puthz(inf,"\n",14,1);
	  printf("\x7");
	  return 0;
	}
      return((((unsigned)(*(p+0x1a)))&0xff)+(((unsigned)(*(p+0x1b)))&0xff)*256);
  }

char *findstr(char *str1,char *str2,long num)
 {
   unsigned j=0;
   while(j<num)
      {
	if(!memcmp(str1+j,str2,11))
	  return str1+j;
	j+=32;
      }
    return 0;
    }

unsigned get_total_sector_of_fr(void)
 {
   return ((DIRNUMBER_OF_ROOT*32+BPS-1)/BPS+FAT_NUMBER*SECTOR_PER_FAT);
 }

int get_BPB(unsigned lgdrive)
 {
   if((*rdabs)(lgdrive,1,0L,boot))
     {
       DISKRESET;
       inf=open_win(14,10,24,70,1,1);
       puthz(inf,"读BPB错误.\n",14,1);
       puthz(inf,"按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
       return -1;
     }
     memcpy(BPB,boot,0x20);
     return 1;
 }

unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;

    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	inf=open_win(14,10,24,70,1,1);
	puthz(inf,"非安装使用.\n",14,1);
	quit(1);
      }
    fread(end_inf,20,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	inf=open_win(14,10,24,70,1,1);
	puthz(inf,"错误.\n",14,1);
	quit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	inf=open_win(14,10,24,70,1,1);
	puthz(inf,"非法用户或解密.\n",14,1);
	quit(1);
      }
    return(0);
    }

unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   if(biosdisk(2,0x80,0,0,10,1,boot))
    if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,boot))
      {
	DISKRESET;
        inf=open_win(14,10,24,70,1,1);
	puthz(inf,"读硬盘分区信息错误.\n",14,1);
	puthz(inf,"\n按任意键继续...",15,1);
        printf("\x7");
	getch();
	puthz(inf,"\n",14,1);
	printf("\x7");
	return(9);
      }
/*    anti_trace();*/
    if((boot[0]!='W')||(boot[511]!='Q'))
     {
     if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,boot))
	{
        DISKRESET;
        inf=open_win(14,10,24,70,1,1);
	puthz(inf,"读硬盘分区信息错误.\n",14,1);
	puthz(inf,"\n按任意键继续...",15,1);
        printf("\x7");
	getch();
	puthz(inf,"\n",14,1);
	printf("\x7");
	return(9);
	}
    if((boot[0]!='W')||(boot[511]!='Q'))
	{
	 infwq();
	 return(9);
	}
    else
	goto WH;
     }
    else
WH:
	while(!((boot[i]==0)&&(boot[i+1]==0)&&(boot[i+2]==0)))
	 {
	  i+=3;
	  num++;
	 }
     if(num>9)
       num=9;
     return(num);
   }

void infwq(void)
 {
   static unsigned flag=0;
   if(flag==0)
   {
   flag=1;
   printf("\x7\x7\x7");
   inf=open_win(14,10,24,70,1,1);
   puthz(inf,"  修复数据丢失,请立即执行下列两个命令:\n",14,1);
   puthz(inf,"  C:\\LASTLINE\\MNGRBOOT/B 和 C:\\LASTLINE\\FATRSAVE\n",14,1);
   puthz(inf,"然后,检查并清除病毒,再执行上述命令.",14,1);
   puthz(inf,"\n按任意键继续...",15,1);
   getch();
   printf("\x7");
   }
   puthz(inf,"\n",14,1);
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


int  absread50(int drive,int num,long start_sector,char *b)
 {
     in.h.al=drive;
     in.x.cx=0xffff;
     in.x.bx=FP_OFF(b);
     dsbx.ds=FP_SEG(b);
     b[0]= (start_sector&0xff);
     b[1]= (start_sector>>8)&0xff;
     b[2]= (start_sector>>16)&0xff;
     b[3]= (start_sector>>24)&0xff;
     b[4]= num&0xff;
     b[5]= (num>>8)&0xff;
     b[6]= (in.x.bx)&0xff;
     b[7]= ((in.x.bx)>>8)&0xff;
     b[8]= (dsbx.ds)&0xff;
     b[9]= ((dsbx.ds)>>8)&0xff;
     int86x(0x25,&in,&out,&dsbx);
     if((out.x.cflag)==0)
	return(0);
     else
	return(-1);
 }

int  absread30(int drive,int num,long start_sector,char *b)
 {
     in.h.al=drive;
     in.x.cx=num;
     in.x.dx=(start_sector)&0xffff;
     in.x.bx=FP_OFF(b);
     dsbx.ds=FP_SEG(b);
     int86x(0x25,&in,&out,&dsbx);
     if((out.x.cflag)==0)
	return(0);
     else
	return(-1);
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
int creatfatroot(char *filenm,unsigned total_sector)
 {
   FILE *fp;
   int i;
   if((fp=fopen(filenm,"w+b"))==NULL)
     {
       inf=open_win(14,10,24,70,1,1);
       puthz(inf,"不能备份FAT和ROOT.\n",14,1);
       puthz(inf,"\n按任意键继续...",15,1);
       printf("\x7");
       getch();
       puthz(inf,"\n",14,1);
       printf("\x7");
       return -1;
     }
   for (i=SECTOR_PER_FAT;i<total_sector;i+=50)
       fwrite(fatroot,BPS*50,1,fp);
   fclose(fp);
   return 1;
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
  if(inf==NULL)
    inf=open_win(14,10,24,70,1,1);
  printf("\x7");
  puthz(inf,"\n 按任意键退出...",15,1);
  close(CCLIB);
  getch();
  printf("\x7");
  cleardevice();
  restorecrtmode();
  exit(i);
}