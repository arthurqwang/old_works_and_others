/* LASTLIN2.c 1994 1 19, English version 2.0, */
/* Passed DOS 3.3a,DOS 5.0,DOS 6.0*/
/* Computer type passed:GW286,COMPAQ 386/33(25),AST 286*/
/*      Antai 286 ,At&t 386,DELL 433DE ,NONAME 286 ,so on*/

/****************** head files ************/
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include "twindow.h"
#include "keys.h"
/******************* defines **************/
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
/**************declare function ***********************/
void check_sec(void);
void infwq(void);
void get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
unsigned get_total_sector_of_fr(void);
void get_BK(void);
int  abswrite50(int drive,int num,long start_sector,char *b);
int  absread50(int drive,int num,long start_sector,char *b);
int  abswrite30(int drive,int num,long start_sector,char *b);
int  absread30(int drive,int num,long start_sector,char *b);
/*********************** globle varibles **************/
WINDOW *tit,*inf,*titt,*inff;
short unsigned x,y;
unsigned BKHEAD,BKTRACK;
char chain[BPS],BPB[512],fatroot[40960];
union REGS in,out;
struct SREGS dsbx;
struct fatinfo p;
int (*wrtabs)();
int (*rdabs)();

/***************** main program **********************/
main()
 {
   short unsigned maxdrive,lgdrive,key,i=1,andnum,isfail=0;
   unsigned i_total_sector,total_sector,sector_of_nonDOS,end_chain,max_chain;
   long unsigned lgsector;
   
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
   check_sec();
   printf("\x7\x7\x7");
   wclrprintf(inf,BLUE,WHITE,BRIGHT,"             WARNNING !         WARNNING !\n");
   wprintf(inf,"   Perhaps,some files may be lost when you answer YES.\n");
   get_BK();
   maxdrive=get_disk_num();
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
   {
     getfat(lgdrive+1,&p);
     if((((long unsigned)p.fi_sclus)*((unsigned)p.fi_nclus))<=65536L)
	 {
	   wrtabs=abswrite30;
	   rdabs=absread30;
	 }
     else
	 {
	   wrtabs=abswrite50;
	   rdabs=absread50;
	 }

     
     if(biosdisk(2,0x80,0,0,lgdrive+9,1,chain))
	 {
	   isfail=1;
	   DISKRESET;
	   wprintf(inf,"   Error search cluster chain.\n");
	   wclrprintf(inf,BLUE,WHITE,BRIGHT,"   Press any key to retry...\n");
	   getch();
	   printf("\x7");
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
		     printf("\x7");
		   }
	      }
	}
     wprintf(inf,"   Update FAT and ROOT for Logical disk %c:,Sure?[Y]\b\b",lgdrive+65,15);
kkk: key=getch();
     printf("\x7");
     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto kkk;
     if(toupper(key)=='N')
       {
	 wprintf(inf,"N\n");
	 continue;
       }
     else
       wprintf(inf,"\n   Reparing...");
       get_BPB(lgdrive);
       total_sector=get_total_sector_of_fr();
       sector_of_nonDOS=SECTOR_KEPT+total_sector;
       if((((TOTAL_SECTOR-sector_of_nonDOS)/SECTOR_PER_CLUSTER)>4080)||(TOTAL_SECTOR==0))
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
       i=1;
       i_total_sector=total_sector-SECTOR_PER_FAT;
       while(((chain[i*2+2]&andnum)*256+(chain[i*2+3]&0xff))<end_chain)
	 {
	   if(i_total_sector <=(SECTOR_PER_CLUSTER)) break;
	   if(((chain[i*2]&andnum)*256+(chain[i*2+1]&0xff))>=max_chain) {i++;continue;}
	   lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
	   if((*rdabs)(lgdrive,SECTOR_PER_CLUSTER,lgsector,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	   if((*wrtabs)(lgdrive,SECTOR_PER_CLUSTER,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1),fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	   i++;
	   i_total_sector -= (SECTOR_PER_CLUSTER);
	  }
	 lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
	 if((*rdabs)(lgdrive,i_total_sector,lgsector,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	 if((*wrtabs)(lgdrive,i_total_sector,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1),fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }

       i=1;
       i_total_sector=total_sector-SECTOR_PER_FAT;
       while(((chain[i*2+2]&andnum)*256+(chain[i*2+3]&0xff))<end_chain)
	 {
	   if(i_total_sector <=(SECTOR_PER_CLUSTER)) break;
	   if(((chain[i*2]&andnum)*256+(chain[i*2+1]&0xff))>=max_chain) {i++;continue;}
	   lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
	   if((*rdabs)(lgdrive,SECTOR_PER_CLUSTER,lgsector,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	   if((*wrtabs)(lgdrive,SECTOR_PER_CLUSTER,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1)+(long unsigned)SECTOR_PER_FAT,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	   i++;
	   i_total_sector -= (SECTOR_PER_CLUSTER);
	  }
	 lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
	 if((*rdabs)(lgdrive,i_total_sector,lgsector,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }
	 if((*wrtabs)(lgdrive,i_total_sector,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1)+(long unsigned)SECTOR_PER_FAT,fatroot))
	     {
	       DISKRESET;
	       wprintf(inf,"\n  Error search informations of FAT and ROOT.\n");
	       exit(1);
	     }


	 wprintf(inf,"\n   Successful.\n");
   }
 wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");
 getch();
 printf("\x7");
 close_all();
 gotoxy(x,y);
 }

unsigned get_total_sector_of_fr(void)
 {
   return ((DIRNUMBER_OF_ROOT*32+BPS-1)/BPS+FAT_NUMBER*SECTOR_PER_FAT);
 }

void get_BPB(unsigned lgdrive)
 {
   if((*rdabs)(lgdrive,1,0L,BPB))
     {
       DISKRESET;
       wprintf(inf,"\n   Error read BPB.\n");
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
        printf("\x7");
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
   printf("\x7");
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
   BKTRACK=((temp[1]&0xff)*256)+(temp[0]&0xff)-1;
   BKHEAD=(temp[2]&0xff)-1;
  }
void check_sec(void)
 {
   if(absread(0,1,0,BPB))
    if(absread(0,1,0,BPB))
     if(absread(0,1,0,BPB))
     {
       DISKRESET;
       wprintf(inf,"\n   Error.\n");
       exit(1);
     }
   if(absread(0,1,719,chain))
    if(absread(0,1,719/*2000*/,chain))
     if(absread(0,1,719,chain))
     {
       DISKRESET;
       wprintf(inf,"\n   Error.\n");
       exit(1);
     }
   if(memcmp(BPB,chain,512))
    {
     biosdisk(3,0,0,0,1,0xff,BPB+0x120);
     wprintf(inf,"\n   Unlawful user or unlocking.\n");
     exit(1);
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


int  abswrite50(int drive,int num,long start_sector,char *b)
 {
     char par[10];
     unsigned offset,seg;
     in.h.al=drive;
     in.x.cx=0xffff;
     in.x.bx=FP_OFF(par);
     dsbx.ds=FP_SEG(par);
     par[0]= (start_sector&0xff);
     par[1]= (start_sector>>8)&0xff;
     par[2]= (start_sector>>16)&0xff;
     par[3]= (start_sector>>24)&0xff;
     par[4]= num&0xff;
     par[5]= (num>>8)&0xff;
     offset=FP_OFF(b);
     par[6]= offset&0xff;
     par[7]= (offset>>8)&0xff;
     seg=FP_SEG(b);
     par[8]= seg&0xff;
     par[9]= (seg>>8)&0xff;
     int86x(0x26,&in,&out,&dsbx);
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
int  abswrite30(int drive,int num,long start_sector,char *b)
 {
     in.h.al=drive;
     in.x.cx=num;
     in.x.dx=(start_sector)&0xffff;
     in.x.bx=FP_OFF(b);
     dsbx.ds=FP_SEG(b);
     int86x(0x26,&in,&out,&dsbx);
     if((out.x.cflag)==0)
	return(0);
     else
	return(-1);
 }
