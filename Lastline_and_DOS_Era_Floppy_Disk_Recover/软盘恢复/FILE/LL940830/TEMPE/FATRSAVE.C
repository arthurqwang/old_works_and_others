/*******************************************************************
  File name:     FATRSAVE.C
  Belong to:     LASTLINE 2.5 English version
  Date:          8/29/94
  Author:        WangQuan
  Function:      To Backup FAT & ROOT.
  Usage:         X:\ANYPATH>Y:\ANYPATH\FATRSAVE<CR>
		   X:,Y: = A:,B:,C:,D:...
		 BUT C:\LASTLINE\LASTLINE.CFG must be right.
  Where stored:  Floppy disk "LASTLINE 2.5 English version
		 Source files"(LASTLINE 2.5 Yingwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

/**************************  HEAD FILES  *********************************/
#include <stdio.h>
#include <dos.h>
#include <string.h>
#include "twindow.h"
#include "keys.h"
#include <dir.h>
/*******************  DEFINES  ******************************************/
#define  BPS 512
#define  DISKRESET biosdisk(0,0x80,0,0,0,0,0)
#define  SECTOR_PER_CLUSTER (((unsigned)BPB[0xd])&0xff)
#define  SECTOR_KEPT       ((((unsigned)BPB[0xe])&0xff)+
			   (((unsigned)BPB[0xf])&0xff)*256)
#define  FAT_NUMBER        (((unsigned)BPB[0x10])&0xff)
#define  DIRNUMBER_OF_ROOT ((((unsigned)BPB[0x11])&0xff)+
			   (((unsigned)BPB[0x12])&0xff)*256)
#define  TOTAL_SECTOR      ((((unsigned)BPB[0x13])&0xff)+
			   (((unsigned)BPB[0x14])&0xff)*256)
#define  SECTOR_PER_FAT    ((((unsigned)BPB[0x16])&0xff)+
			   (((unsigned)BPB[0x17])&0xff)*256)
#define  SECTOR_PER_TRACK  ((((unsigned)BPB[0x18])&0xff)+
			   (((unsigned)BPB[0x19])&0xff)*256)
#define  HEAD              ((((unsigned)BPB[0x1a])&0xff)+
			   (((unsigned)BPB[0x1b])&0xff)*256)
#define  SECTOR_HIDDEN     ((((unsigned)BPB[0x1c])&0xff)+
			   (((unsigned)BPB[0x1d])&0xff)*256)
#define  START_SECTOR_NUMBER   SECTOR_KEPT
/******************** DECLARE FUNCTIONS **************************/
int save_cluster_chain(unsigned hsecter,unsigned start_cluster,
		       unsigned total_sector,unsigned lgdrive);
int use_16_bit(unsigned start_cluster,unsigned lgdrive);
int use_12_bit(unsigned start_cluster,unsigned lgdrive);
unsigned get_start_cluster(unsigned total_sector,unsigned lgdrive);
unsigned get_total_sector_of_fr(void);
int get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
unsigned check_lock(int drive);
void infwq(void);
void get_BK(void);
int  absread50(int drive,int num,long start_sector,char *b);
int  absread30(int drive,int num,long start_sector,char *b);
int creatfatroot(char *filenm,unsigned total_sector);
int get_MAY_WRITE_TO_H_SEC(void);
void quit(int i);
unsigned get_SN_from_hd(void);
/**************************** GLOBLE VARIBLE ************************/
char *findstr(char *str1,char *str2,long num);
WINDOW * tit,*inf,*titt,*inff;
int lgdrive,x,y;
unsigned BKHEAD,BKTRACK,MAY_WRITE_TO_H_SEC;
unsigned char end_inf[20],BPB[0x20],boot[BPS],fatroot[51200];
union REGS in,out;
struct SREGS dsbx;
struct fatinfo p;
int (*rdabs)();

/*********************** MAIN PROGROM *************************/
main()
 {
   int maxdrive;
   FILE *fp;
   char filenm[15]="";
   unsigned hsector,total_sector,start_cluster,i=0;
   struct ffblk fblk;
   x=wherex();y=wherey();
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
   wclrprintf(tit,BLUE,YELLOW,BRIGHT,
	      "         LASTLINE Version 2.5  SN:%06u\n",get_SN_from_hd());
   wprintf(tit,"   (C) Copyright(1994.9) DongLe Computer Corp. \n");
   wprintf(tit,"          Designed & Coded by ");
   wprintf(tit,"%c%c%c%c%c%c%c%c",87,65,78,71,81,85,65,78);
   wprintf(tit," ");
   inff=establish_window(12,12,5,60);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[BORDER]=0x33;
   set_border(inff,3);
   display_window(inff);
   inf=establish_window(10,11,5,60);
   set_colors(inf,ALL,BLUE,YELLOW,BRIGHT);
   inf->wcolor[BORDER]=0x11;
   set_border(inf,3);
   display_window(inf);
   get_BK();
   maxdrive=get_disk_num();/* include anti_trace */
   if(check_lock(0x80)==0) quit(1);
   MAY_WRITE_TO_H_SEC=get_MAY_WRITE_TO_H_SEC();
/*********************** BEGINNIG SAVE FAT&ROOT FOR DISKS ****************/

NXT:
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
   {
   boot[0]=lgdrive+'A';
   boot[1]=0;
   strcat(boot,":\\*.*");
   if(((findfirst(boot,&fblk,0))==-1)&&
      ((findfirst(boot,&fblk,FA_DIREC))==-1))
     continue;
   i=0;
   if(end_inf[lgdrive+2]==1)
     rdabs=absread50;
   else
     rdabs=absread30;
   wprintf(inf,"\n   Processing...\n     Logical disk ");
                                /*Saving FAT and ROOT informations for*/
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"%c: \n",lgdrive+65,15);
   if(get_BPB(lgdrive)==-1) continue;
   total_sector=get_total_sector_of_fr();
   filenm[0]=lgdrive+'c'-2;
   filenm[1]=0;
   strcat(filenm,":\\fat&root.img");
   if(_chmod(filenm,1,FA_ARCH)==-1)
      if(creatfatroot(filenm,total_sector)==-1) continue;
   if((fp=fopen(filenm,"r+b"))==NULL)
     {
       wprintf(inf,"   Can not create copy of FAT and ROOT.\n");
       wclrprintf(inf,BLUE,YELLOW,BRIGHT,"Press any key to continue...");
       printf("\x7");
       get_ch();
       printf("\x7");wprintf(inf,"\n");
       goto NXT;
     }
   for (i=SECTOR_PER_FAT;i<total_sector;i+=50)
     {
       if((*rdabs)(lgdrive,50,(long)(START_SECTOR_NUMBER+i),fatroot))
	 {
	   DISKRESET;
	   wprintf(inf,"   Error read information of FAT and ROOT.\n");
	   wclrprintf(inf,BLUE,YELLOW,BRIGHT,
		      "Press any key to continue...");
	   printf("\x7");
	   get_ch();
           printf("\x7");wprintf(inf,"\n");
	   goto NXT;

	   /*quit(1);*/
	 }
       fwrite(fatroot,BPS*50,1,fp);
     }
   fclose(fp);
   _chmod(filenm,1,FA_HIDDEN+FA_RDONLY);
   if((start_cluster=get_start_cluster(total_sector,lgdrive))==0) continue;
   hsector=lgdrive+9;
   if(save_cluster_chain(hsector,start_cluster,total_sector,lgdrive)==-1)
       continue;
 }
/* can_trace();*/
 close_all();
 gotoxy(x,y);
/* restorecrtmode();*/
}
/********************* FUNCTIONS ********************/
int save_cluster_chain(unsigned hsector,unsigned start_cluster,
		       unsigned total_sector,unsigned lgdrive)
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
	   wprintf(inf,"   Error save cluster chain.\n");
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,
		      "\n   Press any key to continue...");
	   printf("\x7");
	   get_ch();
	   printf("\x7");wprintf(inf,"\n");
      }
    if(biosdisk(3,0x80,BKHEAD,BKTRACK,hsector,1,boot))
      {
           DISKRESET;
	   wprintf(inf,"   Error save cluster chain.\n");
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,
		       "\n   Press any key to continue...");
	   printf("\x7");
	   get_ch();
	   printf("\x7");wprintf(inf,"\n");
	   return -1;
      }
    return 1;
  }

int use_16_bit(unsigned start_cluster,unsigned lgdrive)
  {
  long pfat;
  unsigned ii=2,temp;
  unsigned char fname[]="C:\\fat&root.img";
  FILE *fp;
  fname[0]=lgdrive+'A';
  _chmod(fname,1,FA_ARCH);
  if((fp=fopen(fname,"rb"))==NULL)
    {
       wprintf(inf,"\n   Error read %c:\\FAT&ROOT.IMG .\n",lgdrive-2+'C');
       wclrprintf(inf,BLUE,WHITE,BRIGHT,
		     "\n   Press any key to continue...");
       printf("\x7");
       get_ch();
       printf("\x7");wprintf(inf,"\n");
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
  unsigned char fname[]="C:\\fat&root.img";
  FILE *fp;
  fname[0]=lgdrive+'A';
  _chmod(fname,1,FA_ARCH);
  if((fp=fopen(fname,"rb"))==NULL)
    {
       wprintf(inf,"\n   Error read %c:\\FAT&ROOT.IMG .\n",lgdrive-2+'C');
       wclrprintf(inf,BLUE,WHITE,BRIGHT,
		   "\n   Press any key to continue...");
       printf("\x7");
       get_ch();
       printf("\x7");wprintf(inf,"\n");
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
	      wprintf(inf,"   Error read information of FAT and ROOT.\n");
	      wclrprintf(inf,BLUE,YELLOW,BRIGHT,
			   "Press any key to continue...");
              printf("\x7");
	      get_ch();
              printf("\x7");wprintf(inf,"\n");
	      return 0;
	      /*quit(1);*/
	  }
	if((p=findstr(fatroot,"FAT&ROOTIMG",BPS*10))!=NULL)
	   break;
      }
      if(!p)
	{
	  wprintf(inf,"   No file FAT&BOOT.IMG.\n");
	  wclrprintf(inf,BLUE,YELLOW,BRIGHT,
		     "Press any key to continue...");
          printf("\x7");
	  get_ch();
          printf("\x7");wprintf(inf,"\n");
	  return 0;
	  /*quit(1);*/
	}
      return((((unsigned)(*(p+0x1a)))&0xff)+(((unsigned)(*(p+0x1b)))&0xff)*
	     256);
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
       wprintf(inf,"   Error read BPB.\n");
       wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any key to continue...");
       printf("\x7");
       get_ch();
       printf("\x7");wprintf(inf,"\n");
       return -1;
      /* quit(1);*/
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
	wprintf(inf,"\n  No installing.\n");
	quit(1);
      }
    fread(end_inf,20,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	wprintf(inf,"\n   Error.\n");
	quit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==
	end_inf[2]))
      return (1);
    else
      {
	wprintf(inf,"\n  Invalid copy or not running in floppy disk.\n");
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
	wprintf(inf,"  Error read partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	get_ch();
	printf("\x7");wprintf(inf,"\n");
	return(9);
      }
/*    anti_trace();*/
    if((boot[0]!='W')||(boot[511]!='Q'))
     {
     if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,boot))
	{
         DISKRESET;
	wprintf(inf,"  Error read partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
        printf("\x7");
	get_ch();
	printf("\x7");wprintf(inf,"\n");
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
   wprintf(inf,"\n    LASTLINE data is lost.Run MNGRBOOT/B and FATRSAVE");
   wprintf(inf,"\n  in your flopyy LASTLINE 2.5 DISK.");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
   get_ch();
   printf("\x7");
   }
   wprintf(inf,"\n");
 }

void get_BK(void)
 {
   unsigned char tttt[512];
   unsigned HD_base_table_adr[4],temp[3],a=0,b=0x400;
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],
		 (HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],
		 (HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],
		 (HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-1;
/*   BKHEAD=(temp[2]&0xff)-1;*/  /* Can't pass DongXiangjie's PC.*/
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

int creatfatroot(char *filenm,unsigned total_sector)
 {
   FILE *fp;
   int i;
   if((fp=fopen(filenm,"w+b"))==NULL)
     {
       wprintf(inf,"\n   Can not create copy of FAT and ROOT.\n");
       wclrprintf(inf,BLUE,YELLOW,BRIGHT,"Press any key to continue...");
       printf("\x7");
       get_ch();
       printf("\x7");wprintf(inf,"\n");
       return -1;
      /* quit(1);*/
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
	wprintf(inf,"\n  No installing.");
	quit(1);
      }
    fseek(fp,500,SEEK_SET);
    fread(&result,1,1,fp);
    fclose(fp);
    return result&0xff;
 }
void quit(int i)
{
  printf("\x7");
  wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to quit...");
  get_ch();
  printf("\x7");wprintf(inf,"\n");
  close_all();
  gotoxy(x,y);
/*  restorecrtmode();*/
  exit(i);
}
unsigned get_SN_from_hd(void)
{
  unsigned SN;
  unsigned char part[512];
  get_BK();
  biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,part);
  SN = part[507]+part[508]*256;
  return SN;
}