#include <stdio.h>
#include <dos.h>
#include <string.h>
#include "twindow.h"
#include "keys.h"
#define  BPS 512
#define  DISKRESET biosdisk(0,0x80,0,0,0,0,0)
#define  SECTOR_PER_CLUSTER (((unsigned)BPB[0xd])&0xff)
#define  SECTOR_KEPT       ((((unsigned)BPB[0xe])&0xff)+(((unsigned)BPB[0xf])&0xff)*256)
#define  FAT_NUMBER (((unsigned)BPB[0x10])&0xff)
#define  DIRNUMBER_OF_ROOT ((((unsigned)BPB[0x11])&0xff)+(((unsigned)BPB[0x12])&0xff)*256)
#define  TOTAL_SECTOR      ((((unsigned)BPB[0x13])&0xff)+(((unsigned)BPB[0x14])&0xff)*256)
#define  SECTOR_PER_FAT    ((((unsigned)BPB[0x16])&0xff)+(((unsigned)BPB[0x17])&0xff)*256)
#define  SECTOR_PER_TRACK  ((((unsigned)BPB[0x18])&0xff)+(((unsigned)BPB[0x19])&0xff)*256)
#define  HEAD              ((((unsigned)BPB[0x1a])&0xff)+(((unsigned)BPB[0x1b])&0xff)*256)
#define  SECTOR_HIDDEN     ((((unsigned)BPB[0x1c])&0xff)+(((unsigned)BPB[0x1d])&0xff)*256)
#define  START_SECTOR_NUMBER   SECTOR_KEPT

void save_cluster_chain(unsigned hsecter,unsigned start_cluster,unsigned total_sector,unsigned lgdrive);
void use_16_bit(unsigned start_cluster);
void use_12_bit(unsigned start_cluster);
unsigned get_start_cluster(unsigned total_sector,unsigned lgdrive);
unsigned get_total_sector_of_fr(void);
void get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
unsigned check_lock(int drive);
void infwq(void);
void get_BK(void);
char *findstr(char *str1,char *str2,long num);
WINDOW * tit,*inf,*titt,*inff;
int lgdrive,x,y;
int BKHEAD,BKTRACK;
char BPB[0x20],boot[BPS],fatroot[50000];


main()
 {
   int maxdrive;
   FILE *fp;
   char filenm[15]="";
   unsigned hsector,total_sector,start_cluster,i=0;
   x=wherex();y=wherey();
   if(check_lock(0x80)==0) exit(1);
   titt=establish_window(17,6,4,50);
   set_colors(titt,ALL,3,WHITE,BRIGHT);
   titt->wcolor[BORDER]=0x33;
   set_border(titt,3);
   display_window(titt);
   tit=establish_window(15,5,4,50);
   set_colors(tit,ALL,BLUE,WHITE,BRIGHT);
   tit->wcolor[BORDER]=0x11;
   set_border(tit,3);
   display_window(tit);

   wprintf(tit,"              LASTLINE Version 2.0\n          (C) Copyright ");
   wprintf(tit,"%c%c%c%c%c%c%c%c",87,65,78,71,81,85,65,78);
   wprintf(tit," 1993.");
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
   setverify(1);
   maxdrive=get_disk_num();
   get_BK();
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
   {
   i=0;
   wprintf(inf,"   Saving FAT and ROOT informations for\n     Logical disk ");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"%c: \n",lgdrive+65,15);
   get_BPB(lgdrive);
   total_sector=get_total_sector_of_fr();
   filenm[0]=lgdrive+'c'-2;
   filenm[1]=0;
   strcat(filenm,":\\fat&root.img");
   _chmod(filenm,1,FA_ARCH);
   if((fp=fopen(filenm,"wb"))==NULL)
     {
       wprintf(inf,"   Can not create copy of FAT and ROOT.\n");
       exit(1);
     }
   for(i=0;i<total_sector;i+=10)
      fwrite(fatroot,BPS*10,1,fp);
   fclose(fp);
/*   start_cluster=get_start_c/luster(total_sector,lgdrive);
   hsector=lgdrive+9;
   save_cluster_chain(hsector,start_cluster,total_sector,lgdrive);
  */
   if((fp=fopen(filenm,"r+b"))==NULL)
     {
       wprintf(inf,"   Can not create copy of FAT and ROOT.\n");
       exit(1);
     }
   for (i=0;i<total_sector;i+=10)
     {
       if(absread(lgdrive,10,START_SECTOR_NUMBER+i,fatroot))
	 {
	   DISKRESET;
	   wprintf(inf,"   Error read information of FAT and ROOT.\n");
	   exit(1);
	 }
       fwrite(fatroot,BPS*10,1,fp);
     }
   fclose(fp);
   _chmod(filenm,1,FA_HIDDEN);
   start_cluster=get_start_cluster(total_sector,lgdrive);
   hsector=lgdrive+9;
   save_cluster_chain(hsector,start_cluster,total_sector,lgdrive);
/*   getch();                     */
 }
 wprintf(inf,"   Over.\n");
 close_all();
 gotoxy(x,y);

 }

void save_cluster_chain(unsigned hsector,unsigned start_cluster,unsigned total_sector,unsigned lgdrive)
  {
    unsigned sector_of_nonDOS,itemnumber_of_fat;
    if(absread(lgdrive,SECTOR_PER_FAT,START_SECTOR_NUMBER,fatroot))
       {
	   DISKRESET;
	   wprintf(inf,"   Error read information of FAT.\n");
	   exit(1);
       }
    sector_of_nonDOS=SECTOR_KEPT+total_sector;
    itemnumber_of_fat=(TOTAL_SECTOR-sector_of_nonDOS)/SECTOR_PER_CLUSTER;
    if(itemnumber_of_fat>4080)
      use_16_bit(start_cluster);
    else
      use_12_bit(start_cluster);
    boot[0]='W';boot[1]='W';boot[511]='Q';
    if((biosdisk(3,0x80,0,0,hsector,1,boot))||(biosdisk(3,0x80,BKHEAD,BKTRACK,hsector,1,boot)))
      {
           DISKRESET;
	   wprintf(inf,"   Error save cluster chain.\n");
	   exit(1);
      }
  }

void use_16_bit(unsigned start_cluster)
  {
   long p,pfat,ptemp1,ptemp2;
   unsigned q,h,ii=2,lgsec;
  ptemp1=ptemp2=pfat=start_cluster;
  boot[3]=ptemp1&0xff;
  boot[2]=(ptemp2>>8)&0xff;
  while(!((pfat&0xffff)>=0x0fff8))
   {
    p=pfat*2;
    q=fatroot[p+1]&0xff;
    h=fatroot[p]&0xff;
    pfat=q*256+h;
    ptemp1=ptemp2=pfat;
    boot[ii*2+1]=ptemp1&0xff;
    boot[ii*2]=(ptemp2>>8)&0xff;

  /*  wprintf(inf,"%x ",pfat);*/
    ii++;
   }
  }


void use_12_bit(unsigned start_cluster)
  {
   long p,pfat,ptemp1,ptemp2;
   unsigned q,h,ii=2,lgsec;
  float mm;
  ptemp1=ptemp2=pfat=start_cluster;
/*wprintf(inf,"%x ",pfat);        */
  boot[3]=ptemp1&0xff;
  boot[2]=(ptemp2>>8)&0xff;
  while(!((pfat&0xfff)>=0x0ff8))
   {
    mm=pfat*1.5;
    p=(long unsigned)mm;
    q=fatroot[p+1]&0xff;
    h=fatroot[p]&0xff;
    pfat=q*256+h;
    if(mm-(float)p==0.0)
      pfat=pfat&0xfff;
    else
      pfat=pfat>>4;
      ptemp1=ptemp2=pfat;
      boot[ii*2+1]=ptemp1&0xff;
      boot[ii*2]=(ptemp2>>8)&0xff;

  /*  wprintf(inf,"%x ",pfat);*/
    ii++;
   }
  }


unsigned get_start_cluster(unsigned total_sector,unsigned lgdrive)
  {
    unsigned i=0;
    char *p=0;
    for(i=0;i<total_sector;i+=9)
      {
	if(absread(lgdrive,10,START_SECTOR_NUMBER+i,fatroot))
	  {   DISKRESET;
	      wprintf(inf,"   Error read information of FAT and ROOT.\n");
	      exit(1);
	  }
	if((p=findstr(fatroot,"FAT&ROOTIMG",BPS*10))!=NULL)
	   break;
      }
      if(!p)
	{
	  wprintf(inf,"   No file FAT&BOOT.IMG.\n");
	  exit(1);
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

void get_BPB(unsigned lgdrive)
 {
   if(absread(lgdrive,1,0,boot))
     {
       DISKRESET;
       wprintf(inf,"   Error read BPB.\n");
       exit(1);
     }
     memcpy(BPB,boot,0x20);
 }
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    char end_inf[20];
    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	printf("No installing.\n");
	exit(1);
      }
    fread(end_inf,3,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	printf("Error.\n");
	exit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	printf("Unlawful user or unlocking.\n");
	exit(1);
      }
    return(0);
    }

unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   if(biosdisk(2,0x80,0,0,10,1,boot))
      {
	DISKRESET;
	wprintf(inf,"  Error read partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
	close_all();
	gotoxy(x,y);
	return(0);
      }
    if((boot[0]!='W')||(boot[511]!='Q'))
	{
	 infwq();
	 return(0);
	}
    else
	while(!((boot[i]==0)&&(boot[i+1]==0)&&(boot[i+2]==0)))
	 {
	  i+=3;
	  num++;
	 }
     return(num);
   }
void infwq(void)
 {
   printf("\x7\x7\x7");
   wprintf(inf,"\n     The copy of structure information of hard disk has \n");
   wprintf(inf,"  been changed!!! Now,you must scan and clearn hard disk\n");
   wprintf(inf,"  for virus,and confirm that your hard disk is normal,then\n");
   wprintf(inf,"  you should backup again. For backup,enter MNGRBOOT/B at\n  command line.\n\n");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
   getch();
   close_all();
   gotoxy(x,y);
   exit(1);
 }

void get_BK(void)
 {
   unsigned HD_base_table_adr[4],temp[3];
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-2;
   BKHEAD=temp[2]&0xff;
  }