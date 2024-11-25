#include <stdio.h>
#include <string.h>
#include <dos.h>
#include "twindow.h"
#include "keys.h"
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
void check_sec(void);
void infwq(void);
void get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
unsigned get_total_sector_of_fr(void);
void get_BK(void);
WINDOW *tit,*inf,*titt,*inff;
short unsigned x,y;
int BKHEAD,BKTRACK;
char chain[BPS],BPB[512],fatroot[40960];


main()
 {
   short unsigned maxdrive,lgdrive,key,i=1,andnum,isfail=0;
   unsigned total_sector,sector_of_nonDOS,end_chain,max_chain;
   long unsigned lgsector;
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
   inff=establish_window(12,12,10,60);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[0]=0x33;
   set_border(inff,3);
   display_window(inff);

   inf=establish_window(10,11,10,60);
   set_colors(inf,ALL,BLUE,YELLOW,BRIGHT);
   inf->wcolor[0]=0x11;
   set_border(inf,3);
   display_window(inf);
   printf("\x7\x7\x7");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"             WARNNING !         WARNNING !\n");
   wprintf(inf,"   Some files may be lost when you answer YES.\n");
   get_BK();
   maxdrive=get_disk_num();
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
   {
     i=1;
     if(biosdisk(2,0x80,0,0,lgdrive+9,1,chain))
	 {
	   isfail=1;
	   DISKRESET;
	   wprintf(inf,"   Error search cluster chain.\n");
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any to retry...\n");
	   getch();
	   chain[0]=0;
	 }
     if((chain[0]!='W')||(chain[1]!='W')||(chain[511]!='Q'))
	 isfail=1;
     if(isfail)
	{
	   if(biosdisk(2,0x80,BKHEAD,BKTRACK,lgdrive+9,1,chain))
	     {
	       DISKRESET;
	       wprintf(inf,"   Error search cluster chain again.\n");
	       infwq();

	     }
	   if((chain[0]!='W')||(chain[1]!='W')||(chain[511]!='Q'))
	       infwq();
	   else
	      {
		if(biosdisk(3,0x80,0,0,lgdrive+9,1,chain))
		   {
		     DISKRESET;
		     wprintf(inf,"   Error save information for FAT and ROOT.\n");
		     wprintf(inf,"   You should clean viruses for your harddisk, \n then enter FATRSAVE at command line.\n");
		     wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to continue...\n");
		     getch();
		   }
	      }
	}
     wprintf(inf,"   Update FAT and ROOT for Logical disk %c:,Sure?[Y]\b\b",lgdrive+65,15);
kkk: key=getch();
     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto kkk;
     if(toupper(key)=='N')
       {
	 wprintf(inf,"N\n");
	 continue;
       }
     else

       get_BPB(lgdrive);
       total_sector=get_total_sector_of_fr();
       sector_of_nonDOS=SECTOR_KEPT+total_sector;
       if(((TOTAL_SECTOR-sector_of_nonDOS)/SECTOR_PER_CLUSTER)>4080)
	 {
	   end_chain=0xFFF8;
	   max_chain=0xFFF0;
	   andnum=0xFF;
	 }
       else
	 {
	   end_chain=0xFF8;
	   max_chain=0xFF0;
	   andnum=0xF;
	 }
       while(((chain[i*2]&andnum)*256+(chain[i*2+1]&0xff))<end_chain)
	 {
	   if(((chain[i*2]&andnum)*256+(chain[i*2+1]&0xff))>=max_chain) continue;
	   lgsector=(((chain[i*2]&andnum)*256+(chain[i*2+1]&0xff))-2)*SECTOR_PER_CLUSTER + sector_of_nonDOS;
	   if(absread(lgdrive,SECTOR_PER_CLUSTER,lgsector,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	   if(abswrite(lgdrive,SECTOR_PER_CLUSTER,START_SECTOR_NUMBER+SECTOR_PER_CLUSTER*(i-1),fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	   i++;
	  }
	 wprintf(inf,"\n   Successful.\n");
   }
 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
 getch();
 close_all();
 gotoxy(x,y);
 }

unsigned get_total_sector_of_fr(void)
 {
   return ((DIRNUMBER_OF_ROOT*32+BPS-1)/BPS+FAT_NUMBER*SECTOR_PER_FAT);
 }

void get_BPB(unsigned lgdrive)
 {
   if(absread(lgdrive,1,0,BPB))
     {
       DISKRESET;
       wprintf(inf,"   Error read BPB.\n");
       exit(1);
     }
 }
unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   if(biosdisk(2,0x80,0,0,10,1,chain))
      {
	DISKRESET;
	wprintf(inf,"  Error read partition information.\n");
	wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
	getch();
	close_all();
	gotoxy(x,y);
	return(0);
      }
    if((chain[0]!='W')||(chain[511]!='Q'))
	{
	 infwq();
	 return(0);
	}
    else
	while(!((chain[i]==0)&&(chain[i+1]==0)&&(chain[i+2]==0)))
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
   wprintf(inf,"  you should backup again. For backup,enter  FATRSAVE  at\n  command line.\n\n");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"  Press any key to continue...");
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
   BKTRACK=((temp[1]&0xff)*256)+(temp[0]&0xff)-2;
   BKHEAD=temp[2]&0xff;
  }
void check_sec(void)
 {
   if(absread(0,1,0,BPB))
     {
       DISKRESET;
       printf("Error.\n");
       exit(1);
     }
   if(absread(0,1,2000,chain))
     {
       DISKRESET;
       printf("Error.\n");
       exit(1);
     }
   if(memcmp(BPB,chain,512))
    {
     biosdisk(3,0,0,0,1,0xff,BPB+0x120);
     printf("Unlawful user or unlocking.\n");
     exit(1);
    }
 }

