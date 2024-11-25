/*******************************************************************
  File name:     MSS2.C
  Belong to:     MSS 2.0 Chinese version
  Date:          NOV/10/94
  Author:        WangQuan
  Function:      To repare FAT & ROOT.
  Usage:         X:\ANYPATH>Y:MSS2<CR>
		   X: = A:,B:,C...   Y: = A:,B:.
  Where stored:  Floppy disk "MSS 2.0 Chinese version
		 Source files"(MSS 2.0 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/


/****************** head files ************/
#include <stdio.h>
#include <string.h>
#include <dos.h>
#include "twingra.h"
#include <dir.h>
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
int get_BPB(unsigned lgdrive);
unsigned get_disk_num(void);
unsigned get_total_sector_of_fr(void);
void get_BK(void);
int  abswrite50(int drive,int num,long start_sector,char *b);
int  absread50(int drive,int num,long start_sector,char *b);
int  abswrite30(int drive,int num,long start_sector,char *b);
int  absread30(int drive,int num,long start_sector,char *b);
void puticon(int lgdrive);
void quit(int i);
void check_series_No(void);

/*********************** globle varibles **************/
WINGRA *inf,*icon;
unsigned BKHEAD,BKTRACK;
unsigned char chain[BPS],BPB[512],fatroot[40960];
char dvr[10]="A:*.*";
union REGS in,out;
struct SREGS dsbx;
struct fatinfo p;
int (*wrtabs)();
int (*rdabs)();
int olddvr;
extern CCLIB,high_of_char;
/***************** main program **********************/
main(int argc,char *argv[])
 {
   short unsigned maxdrive,lgdrive,key,i=1,andnum,isfail=0;
   unsigned i_total_sector,total_sector,sector_of_nonDOS,end_chain,max_chain;
   long unsigned lgsector;
   unsigned char path_of_HZK[]="\\MSSHZ.LIB";
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   title(path_of_HZK);
   wrt_SN_with_fd();
   icon=open_win(8,10,12,70,7,0);
   inf=open_win(14,10,24,70,7,1);
   puthz(icon,"修复FAT,ROOT",0,7);
   high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
   check_sec();
   check_series_No();
   printf("\x7\x7\x7");
   puthz(inf, "              注意!           注意!\n",1,7);
   puthz(inf,"如果回答 YES ,可能会丢失一些文件,回答 NO 则不修复该盘.\n",1,7);
   get_BK();
   maxdrive=get_disk_num();
   for(lgdrive=2;lgdrive<maxdrive;lgdrive++)
   {
     puticon(lgdrive);
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


     puthz(inf,"是否为 ",0,7);
     chain[0]=lgdrive+65;
     chain[1]=':';
     chain[2]=0;
     puthz(inf,chain,1,7);
     puthz(inf, "盘修复 FAT和 ROOT ?[Y]\b\b",0,7);
kkk: key=get_ch();
     printf("\x7");
     if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
	  goto kkk;
     if(toupper(key)=='N')
       {
	 puthz(inf,"N\n",0,7);
	 puthz(inf,"跳过.\n",0,7);
	 continue;
       }
     else
       puthz(inf,"\n  正在修复...\n",0,7);
       if(    biosdisk(2,0x80,BKHEAD,BKTRACK,lgdrive+9,1,chain)
	   || (chain[0]   != 'W')
	   || (chain[1]   != 'W')
	   || (chain[511] != 'Q')
	 )
	  if(    biosdisk(2,0x80,0,0,lgdrive+9,1,chain)
	      || (chain[0]   != 'W')
	      || (chain[1]   != 'W')
	      || (chain[511] != 'Q')
	    )
	    {
               DISKRESET;
	       puthz(inf,"未找到FAT和ROOT信息.\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       continue;
	    }

       if(get_BPB(lgdrive)==-1) continue;
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
	       puthz(inf,"读FAT 和ROOT错误.\n",0,7);
	       printf("\x7");
	       puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       goto NXT_CLU1;
	     }
	   if((*wrtabs)(lgdrive,SECTOR_PER_CLUSTER,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1),fatroot))
	     {
	       DISKRESET;
	       puthz(inf,"修复遇故障.\n",0,7);
               printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       goto NXT_CLU1;
	     }
NXT_CLU1:
	   i++;
	   i_total_sector -= (SECTOR_PER_CLUSTER);
	  }
	 lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
	 if((*rdabs)(lgdrive,i_total_sector,lgsector,fatroot))
	     {
	       DISKRESET;
	       puthz(inf,"读FAT 和ROOT错误.\n",0,7);
	       printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       goto SECOND_FAT_ROOT;
	     }
	 if((*wrtabs)(lgdrive,i_total_sector,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1),fatroot))
	     {
	       DISKRESET;
	       puthz(inf,"修复遇故障.\n",0,7);
	       printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       goto SECOND_FAT_ROOT;
	     }
SECOND_FAT_ROOT:
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
	       puthz(inf,"读FAT 和ROOT错误.\n",0,7);
	       printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       goto NXT_CLU2;

	     }
	   if((*wrtabs)(lgdrive,SECTOR_PER_CLUSTER,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1)+(long unsigned)SECTOR_PER_FAT,fatroot))
	     {
	       DISKRESET;
	       puthz(inf,"修复遇故障.\n",0,7);
	       printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       goto NXT_CLU2;
	     }
NXT_CLU2:
	   i++;
	   i_total_sector -= (SECTOR_PER_CLUSTER);
	  }
	 lgsector=(long unsigned)(((chain[i*2]&andnum)*256L+(chain[i*2+1]&0xff))-2L)*(long unsigned)SECTOR_PER_CLUSTER + (long unsigned)sector_of_nonDOS;
	 if((*rdabs)(lgdrive,i_total_sector,lgsector,fatroot))
	     {
	       DISKRESET;
	       puthz(inf,"读FAT 和ROOT 错误.\n",0,7);
	       printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       continue;
	     }
	 if((*wrtabs)(lgdrive,i_total_sector,(long unsigned)START_SECTOR_NUMBER+(long unsigned)SECTOR_PER_CLUSTER*(i-1)+(long unsigned)SECTOR_PER_FAT,fatroot))
	     {
	       DISKRESET;
	       puthz(inf,"修复遇故障.\n",0,7);
	       printf("\x7");
               puthz(inf,"按任意键继续...",1,7);
	       get_ch();
	       printf("\x7");
	       puthz(inf,"\n",0,7);
               puthz(inf,"跳过.\n",0,7);
	       continue;
	     }
	 puthz(inf,"完成.\n",0,7);
   }
 puthz(inf,"按任意键退出...",1,7);
 close(CCLIB);
 get_ch();
 printf("\x7");
 cleardevice();
 restorecrtmode();
 setdisk(olddvr);
 }

unsigned get_total_sector_of_fr(void)
 {
   return ((DIRNUMBER_OF_ROOT*32+BPS-1)/BPS+FAT_NUMBER*SECTOR_PER_FAT);
 }

int get_BPB(unsigned lgdrive)
 {
   if((*rdabs)(lgdrive,1,0L,BPB))
     {
       DISKRESET;
       puthz(inf,"读BPB错误.\n",0,7);
       printf("\x7");
       puthz(inf,"按任意键继续...",1,7);
       get_ch();
       printf("\x7");
       puthz(inf,"\n",0,7);
       return -1;
     }
   return 1;
 }
unsigned get_disk_num(void)
 {
   unsigned i=1,num=2;
   if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,chain))
    if(biosdisk(2,0x80,0,0,10,1,chain))
      {
	DISKRESET;
        puthz(inf,"读分区信息错误.\n",0,7);
	puthz(inf,"按任意键继续...",1,7);
	printf("\x7");
	get_ch();
	printf("\x7");
	puthz(inf,"\n",0,7);
	return(9);
      }
    if((chain[0]!='W')||(chain[511]!='Q'))
	{
	 if(biosdisk(2,0x80,0,0,10,1,chain))
          {
           DISKRESET;
	   puthz(inf,"读分区信息错误.\n",0,7);
	   puthz(inf,"按任意键继续...",1,7);
	   printf("\x7");
	   get_ch();
	   printf("\x7");
	   puthz(inf,"\n",0,7);
	   return(9);
	  }
         if((chain[0]!='W')||(chain[511]!='Q'))
	  {
	   infwq();
	   return(9);
	  }
	 else
	  goto WH;
     }
    else
WH:
       while(!((chain[i]==0)&&(chain[i+1]==0)&&(chain[i+2]==0)))
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
   clr_win(inf,1);
   puthz(inf,"   MSS数据丢失,请立即执行MSS软盘上的命令:\n",0,7);
   puthz(inf,"          SAVEFAT\n",0,7);
   puthz(inf,"按任意键继续...",1,7);
   get_ch();
   printf("\x7");
   }
   puthz(inf,"\n",0,7);
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
      BKTRACK=0x3FF;BKTRACK=0;
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

void check_sec(void)
 {
   struct ffblk ffb;
   findfirst(dvr,&ffb,FA_LABEL);
   if(strcmp(ffb.ff_name,"WQLASTLI.NE"))
   {
/*     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,BPB+0x91);*/
     puthz(inf,"非法用户或解密或未在软盘上运行.\n",0,7);
     quit(1);
    }
   if(absread(toupper(dvr[0])-'A',1,0,BPB))
    if(absread(toupper(dvr[0])-'A',1,0,BPB))
     if(absread(toupper(dvr[0])-'A',1,0,BPB))
     {
       DISKRESET;
       puthz(inf,"错误.\n",0,7);
       quit(1);
     }
   if(absread(toupper(dvr[0])-'A',1,2000,chain))
    if(absread(toupper(dvr[0])-'A',1,2000,chain))
     if(absread(toupper(dvr[0])-'A',1,2000,chain))
     {
       DISKRESET;
       puthz(inf,"错误.\n",0,7);
       quit(1);
     }
   if(memcmp(BPB,chain,512))
    {
/*     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,BPB+0x120);*/
     puthz(inf,"非法用户或解密或未在软盘上运行.\n",0,7);
     quit(1);
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

void puticon(int lgdrive)/* lgdrive=0,put main boot record icon */
 {
   int i;
   char a[2]="C";
   static int x=220;
   setfillstyle(1,7);
   high(x,high_of_char*8+2,x+30,high_of_char*10,7,1);
   nohigh(x+1,high_of_char*8+3,x+29,high_of_char*10-1,7,1);
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
void quit(int i)
{

 printf("\x7");
 puthz(inf,"\n 按任意键退出...",1,7);
 close(CCLIB);
 get_ch();
 printf("\x7");
 system("cls");
 restorecrtmode();
 setdisk(olddvr);
 exit(i);
}


void check_series_No(void)
{
   unsigned char part[512],boot[512];
   if(absread(toupper(dvr[0])-65,1,0,boot))
    if(absread(toupper(dvr[0])-65,1,0,boot))
     if(absread(toupper(dvr[0])-65,1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-65,0,0,0,0,0);
       puthz(inf,"\n读序列号错误.",0,7);
       quit(1);
     }
   if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,part))
    if(biosdisk(2,0x80,0,0,10,1,part))
    {
     puthz(inf,"\n读序列号错误.",0,7);
     quit(1);
    }
   if(part[0]!='W' || part[511]!='Q')
    {
     if(biosdisk(2,0x80,0,0,10,1,part))
      {
	puthz(inf,"\n读序列号错误.",0,7);
	quit(1);
      }
    }
   if(    part[0]=='W'
       && part[511]=='Q'
       &&
       (  part[507] != boot[0x27]
       || part[508] != boot[0x28]
       || part[509] != boot[0x29]
       || part[510] != boot[0x2a]
       )
     )
     {
       puthz(inf,"\n软件序列号不匹配.",0,7);
       quit(1);
     }
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

