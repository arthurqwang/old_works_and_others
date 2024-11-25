/*LASTLIN2.C  CHINESE VERSION 2.0  1994 1 19*/
/*Passed DOS 3.3a,DOS5.0,DOS 6.0 */
/*Passed computer type :GW286,DELL 433DE(486,1000M HD)*/
/*     Noname 286,ANTAI 286,AST 286,AT&T 386,COMPAQ 386/33(25)*/
/****************** head files ************/
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include "twingra.h"
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
WINGRA *inf;
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
   title();
   inf=open_win(8,10,24,70,1,1);
   check_sec();
   printf("\x7\x7\x7");
   puthz(inf, "              注意!           注意!\n",15,1);
		/* WARNNING !         WARNNING !*/
   puthz(inf,"如果回答 YES ,可能会丢失一些文件,回答 NO 则不修复该盘.\n",15,1);
		/*   Perhaps,some files may be lost when you answer YES.*/
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


     puthz(inf,"是否为 ",14,1);
     chain[0]=lgdrive+65;
     chain[1]=':';
     chain[2]=0;
     puthz(inf,chain,15,1);
     puthz(inf, "盘修复 FAT和 ROOT ?[Y]\b\b",14,1);
	/*        Update FAT and ROOT for Logical disk %c:,Sure?[Y]\b\b",lgdrive+65,15*/
kkk: key=getch();
     printf("\x7");
     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
          goto kkk;
     if(toupper(key)=='N')
       {
         puthz(inf,"N\n",14,1);
         continue;
       }
     else
       puthz(inf,"\n  正在修复...\n",15,1);
		/*   Reparing...*/
     if(biosdisk(2,0x80,0,0,lgdrive+9,1,chain))
         {
           isfail=1;
           DISKRESET;
           puthz(inf,"未找到FAT和ROOT信息.\n",14,1);
		/*Error search cluster chain.*/
	   puthz(inf,"按任意键重试...\n",15,1);
		/*BLUE,WHITE,BRIGHT,"   Press any to retry...*/

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
               puthz(inf,"重试失败.\n",14,1);
			/*   Error search cluster chain again.*/
               infwq();

             }
           if((chain[0]!='W')||(chain[1]!='W')||(chain[511]!='Q'))
               infwq();
           else
              {
                if(biosdisk(3,0x80,0,0,lgdrive+9,1,chain))
                   {
                     DISKRESET;
                     puthz(inf,"存贮FAT 和ROOT 信息错误.\n",14,1);
				/*   Error save information for FAT and ROOT.*/
		     puthz(inf,"你应该检查并清除病毒,然后运行C:\\LASTLINE\\FATRSAVE.\n",14,1);
				/*  .   You should clean viruses for your harddisk, \n then enter FATRSAVE at command line.*/
		     puthz(inf,"按任意键继续...\n",15,1);
				/*BLUE,WHITE,BRIGHT,"  Press any key to continue...*/
                     getch();
                     printf("\x7");
                   }
              }
        }
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
               puthz(inf,"读FAT 和ROOT错误.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
           if((*wrtabs)(lgdrive,SECTOR_PER_CLUSTER,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1),fatroot))
             {
               DISKRESET;
               puthz(inf,"无法修复.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
           i++;
           i_total_sector -= (SECTOR_PER_CLUSTER);
          }
         lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
         if((*rdabs)(lgdrive,i_total_sector,lgsector,fatroot))
             {
               DISKRESET;
               puthz(inf,"读FAT 和ROOT错误.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
         if((*wrtabs)(lgdrive,i_total_sector,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1),fatroot))
             {
               DISKRESET;
               puthz(inf,"无法修复.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
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
               puthz(inf,"读FAT 和ROOT错误.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
           if((*wrtabs)(lgdrive,SECTOR_PER_CLUSTER,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1)+(long unsigned)SECTOR_PER_FAT,fatroot))
             {
               DISKRESET;
               puthz(inf,"无法修复.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
           i++;
           i_total_sector -= (SECTOR_PER_CLUSTER);
          }
         lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
         if((*rdabs)(lgdrive,i_total_sector,lgsector,fatroot))
             {
               DISKRESET;
               puthz(inf,"读FAT 和ROOT 错误.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
         if((*wrtabs)(lgdrive,i_total_sector,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1)+(long unsigned)SECTOR_PER_FAT,fatroot))
             {
               DISKRESET;
               puthz(inf,"无法修复.\n",14,1);
			/*Error search informations of FAT and ROOT.*/
               exit(1);
             }
	 puthz(inf,"正常完成.\n",14,1);
		/*   Successful.*/
   }
 puthz(inf,"按任意键继续...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
 getch();
 printf("\x7");
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
       puthz(inf,"读BPB错误.\n",14,1);
		/*   Error read BPB.*/
       exit(1);
     }
 }
unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   if(biosdisk(2,0x80,0,0,10,1,chain))
      {
        DISKRESET;
        puthz(inf,"读分区信息错误.\n",14,1);
		/*  Error read partition information.*/
	puthz(inf,"按任意键继续...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
        getch();
        printf("\x7");
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
   clr_win(inf,1);
   puthz(inf,"\n    你的硬盘被严重破坏,如果你的计算机没有瘫痪,请立即执行下列两个命令\n",14,1);
   puthz(inf,"           C:\\LASTLINE\\MNGRBOOT/B\n",14,1);
   puthz(inf,"           C:\\LASTLINE\\FATRSAVE\n",14,1);
   puthz(inf,"然后,你应为硬盘检查并清除病毒,再执行上述命令.\n",14,1);
		/* The copy of structure information of hard disk has */
		/*been changed!!! Now,you must scan and clearn hard disk*/
		/*  you should backup again. For backup,enter  FATRSAVE  at\n  command line.*/
   puthz(inf,"按任意键继续...",15,1);
		/*BLUE,WHITE,BRIGHT,"  Press any key to continue...*/
   getch();
   printf("\x7");
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
       printf("错误.\n",14,1);
		/*Error.*/
       exit(1);
     }
   if(absread(0,1,2000,chain))
    if(absread(0,1,2000,chain))
     if(absread(0,1,2000,chain))
     {
       DISKRESET;
       printf("错误.\n",14,1);
		/*Error.*/
       exit(1);
     }
   if(memcmp(BPB,chain,512))
    {
     biosdisk(3,0,0,0,1,0xff,BPB+0x120);
     printf("非法用户或解密.\n",14,1);
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