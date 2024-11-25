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

void get_cluster_chain(unsigned start_cluster,unsigned total_sector);
void use_16_bit(unsigned start_cluster);
void use_12_bit(unsigned start_cluster);
unsigned get_start_cluster(unsigned total_sector,unsigned lgdrive);
unsigned get_total_sector_of_fr(void);
void get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
void infwq(void);
char *findstr(char *str1,char *str2,long num);
char BPB[0x20],boot[BPS],fil[9216],fatroot[40000];
int lgdrive;

main()
 {
   int maxdrive;
   FILE *fp;
   unsigned total_sector,start_cluster,i=0;
   for(i=0;i<9216;i++)
     fil[i]=0;
   if((fp=fopen("c:\\lastline.inf","wb"))==NULL)
     {
       printf("Can not create LASTLINE.INF\n");
       exit(1);
     }
   fwrite(fil,9216,1,fp);
   fclose(fp);
   get_BPB(2);
   total_sector=get_total_sector_of_fr();
   start_cluster=get_start_cluster(total_sector,2);
   get_cluster_chain(start_cluster,total_sector);
   fil[0]='w';
   fil[1]='q';
   fil[2]='p';
   fil[3]='y';
   fil[4]='w';
   fil[5]='c';
   fil[6]='b';
   fil[7]='f';
   fil[8]='f';
   fil[9]='z';
   fil[10]='q';
   fil[11]='b';
   fil[12]='h';
   fil[13]='q';
   fil[14]='a';
   fil[15]='r';
   fil[16]='e';
   fil[17]='o';
   fil[18]='k';
   fil[19]='!';
   maxdrive=get_disk_num();
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
      {
	get_BPB(lgdrive);
	for(i=0;i<0x20;i++)
	   fil[0x200+(lgdrive-2)*0x20+i]=BPB[i];
      }
   if((fp=fopen("c:\\lastline.inf","rb+"))==NULL)
      {
	printf("Can not open LASTLINE.INF.\n");
	exit(1);
      }
   fwrite(fil,1024,1,fp);
   fclose(fp);
 }

void get_cluster_chain(unsigned start_cluster,unsigned total_sector)
  {
    unsigned sector_of_nonDOS,itemnumber_of_fat,end_num=0xfff8,i;
    if(absread(2,SECTOR_PER_FAT,START_SECTOR_NUMBER,fatroot))
       {
	   DISKRESET;
	   printf("   Error read information of FAT.\n");
	   exit(1);
       }
    sector_of_nonDOS=SECTOR_KEPT+total_sector;
    itemnumber_of_fat=(TOTAL_SECTOR-sector_of_nonDOS)/SECTOR_PER_CLUSTER;
    if(itemnumber_of_fat>4080)
      use_16_bit(start_cluster);
    else
      {
	use_12_bit(start_cluster);
	end_num=0xff8;
      }
    i=0;
    while(((boot[i*2+2]&0xff)*256+(boot[i*2+3]&0xff))<end_num)
       {
	 fil[i*2+0x100]=boot[i*2+2]&0xff;
	 fil[i*2+0x101]=boot[i*2+3]&0xff;
	 i++;
       }
    fil[i*2+0x100]=boot[i*2+2]&0xff;
    fil[i*2+0x101]=boot[i*2+3]&0xff;
	 
    
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

    printf("%x ",pfat);
    ii++;
   }
  }


void use_12_bit(unsigned start_cluster)
  {
   long p,pfat,ptemp1,ptemp2;
   unsigned q,h,ii=2,lgsec;
  float mm;
  ptemp1=ptemp2=pfat=start_cluster;
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

/*    printf("%x ",pfat);*/
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
	      printf("   Error read information of FAT and ROOT.\n");
	      exit(1);
	  }
	if((p=findstr(fatroot,"LASTLINEINF",BPS*10))!=NULL)
	   break;
      }
      if(!p)
	{
	  printf("   No file LASTLINE.INF .\n");
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
       printf("   Error read BPB.\n");
       exit(1);
     }
     memcpy(BPB,boot,0x20);
 }
unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   if(biosdisk(2,0x80,0,0,10,1,boot))
      {
	DISKRESET;
	printf("  Error read partition information.\n");
	printf("\n  Press any key to continue...");
	getch();
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
   printf("\n     The copy of structure information of hard disk has \n");
   printf("  been changed!!! Now,you must scan and clearn hard disk\n");
   printf("  for virus,and confirm that your hard disk is normal,then\n");
   printf("  you should backup again. For backup,enter MNGRBOOT/B at\n  command line.\n\n");
   printf("\n  Press any key to continue...");
   getch();
   exit(1);
 }