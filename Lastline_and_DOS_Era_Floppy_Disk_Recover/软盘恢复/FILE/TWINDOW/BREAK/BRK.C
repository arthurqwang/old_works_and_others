#include <stdio.h>
#include "twindow.h"
#include "keys.h"
#include <dos.h>
#define  BPS 512
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
void get_total_and_start_sec(void);
void quicklowformat(void);
int formathd(void);
void ero(char *);
void write_inf(char *c);
int make_mainboot_bad(void);
int make_dosboot_bad(int);
void make_all_bad(void);
int make_root_bad(int s);
int make_fat_bad(int s);
int  absread50(int drive,int num,long start_sector,char *b);
int  absread30(int drive,int num,long start_sector,char *b);
int  abswrite50(int drive,int num,long start_sector,char *b);
int  abswrite30(int drive,int num,long start_sector,char *b);
unsigned check_lock(int drive);
WINDOW *bgwnd;
unsigned char end_inf[20],part[51200];
unsigned  totalsecoffat[10],totalsecofroot[10],disk_num;
long  startsecoffat[10],startsecofroot[10];
union REGS in,out;
struct SREGS dsbx;
struct fatinfo p;
int (*rdabs)();
int (*wrabs)();

main()
{
  WINDOW *upwnd,*ttwnd,*dnwnd,*headend;
  FIELD *fld;
  int num,d[80],s=1;
  unsigned ipart;
  char c[80],*names[]={
		"MainBOOT","DOSBOOT","FAT","ROOT","All","QuickLowformat","Quit",0};
  clrscr();
  ttwnd=establish_window(10,4,3,60);
  set_colors(ttwnd,BORDER,BLUE,BLUE,DIM);
  set_colors(ttwnd,NORMAL,BLUE,WHITE,BRIGHT);
  wprintf(ttwnd,"  BREAK-TOOL OF HARD DISK   (C)Copyright WANGQUAN (1993)");
  display_window(ttwnd);
  dnwnd=establish_window(9,21,2,70);
  set_colors(dnwnd,BORDER,BLACK,BLACK,DIM);
  set_colors(dnwnd,NORMAL,WHITE,BLUE,DIM);
  wprintf(dnwnd," <Esc>-EXIT Arrowkey-MOVE  <CR>&REDCHAR-SELECT F2-MOVE MEMU ");
  display_window(dnwnd);
  bgwnd=establish_window(10,9,13,60);
  set_colors(bgwnd,ALL,BLUE,WHITE,DIM);
  set_colors(bgwnd,TITLE,YELLOW,BLACK,DIM);
  set_title(bgwnd,"  HARDDISK INFORMATIONS BROKEN  ");
  display_window(bgwnd);
  upwnd=establish_window(9,7,2,62);
  num=open_hmenu(upwnd,"",RED,YELLOW,DIM,
		 names,WHITE,BLACK,DIM,"MDFRALQ",WHITE,RED,DIM,
		 2,BLACK,BLACK,DIM,BLUE,YELLOW,DIM,c,d);
  headend=establish_window(20,11,8,40);
  set_colors(headend,NORMAL,WHITE,BLUE,DIM);
  set_colors(headend,BORDER,WHITE,RED,DIM);
  set_border(headend,2);
  display_window(headend);
  printf("\x7");
  wprintf(headend,"\n     This software is used to break\n");
  wprintf(headend,"  harddisk out.You must be careful. \n");
  wprintf(headend,"      If going on,  some or all data\n");
  wprintf(headend,"  on harddisk will be lost,   unless\n");
  wprintf(headend,"  you have installed LASTLINE.");
  wclrprintf(headend,WHITE,BLACK,DIM,"\n            Continue?[N]\b\b");
  if(toupper(get_char())!='Y')
    {
      close_all();
      exit(0);
    }

  wprintf(headend,"Y\n\n\n\n\n\n  Wait a while,please...");
  get_total_and_start_sec();
  for(ipart=0;ipart<51200;ipart++)
    part[ipart]=0;
  delete_window(headend);
ll:while(s!=0&&s!=7)
  {
     WINDOW *wndd;
     int ss=1,ch;
     char temp[100];
kk:  s=get_hselection(upwnd,s,num,names,"MDFRALQ",c,d,BLACK,WHITE,BRIGHT);
     switch(s)
       {
	 case 1:
	 if(make_mainboot_bad())
	 write_inf("\n Main BOOT sector has been covered.\n");
	 break;
         case 2:
	   wndd=establish_window(23,9,12,13);
	   set_colors(wndd,ALL,WHITE,BLACK,DIM);
	   set_colors(wndd,ACCENT,BLACK,WHITE,BRIGHT);
	   wprintf(wndd," C: Disk\n");
	   wprintf(wndd," D: Disk\n");
	   wprintf(wndd," E: Disk\n");
	   wprintf(wndd," F: Disk\n");
	   wprintf(wndd," G: Disk\n");
	   wprintf(wndd," H: Disk\n");
	   wprintf(wndd," I: Disk\n");
	   wprintf(wndd,"-------");
	   wprintf(wndd," Others\n");
	   wprintf(wndd," Return");
	   display_window(wndd);
	   while(ss!=0)
	     {
	      WINDOW *eldisk;
	      char drv[10]="C:";
              char msk25[]="[_:]";
	      ss=get_selection(wndd,ss,"CDEFGHIOR",WHITE,RED,DIM);
	      switch(ss)
	      {
	       case 0:
	       case 9:
		 delete_window(wndd);
		 break;
	       case 8:
		 eldisk=establish_window(20,11,8,40);
		 set_colors(eldisk,NORMAL,WHITE,BLACK,DIM);
		 set_colors(eldisk,BORDER,WHITE,WHITE,DIM);
		 wprintf(eldisk,"\n    Enter the logical disk code:");
		 display_window(eldisk);
		 init_template(eldisk);
		 fld=establish_field(eldisk,15,3,msk25,drv,'A');
		 data_entry(eldisk);
		 delete_window(eldisk);
		 ss=drv[0]-'C'+1;
		 if(ss>=1&&ss<=7)
		 {
		    if(make_dosboot_bad(ss+1))
		    {
		    strcpy(temp,"\n     The BOOT sector on Logical disk\n     C: has been covered.\n");
		    temp[43]=toupper(ss-1+'C');
                    write_inf(temp);
		    }
		 }
		 else
		 {

		    strcpy(temp,"\n   Logical disk  : is not protected.\n   Stop. Nothing done on this disk.\n");
		    temp[17]=toupper(ss-1+'C');
		    ss=8;
                    write_inf(temp);
		 }

		 break;
	       case FWD:
		 s++;
		 if(s>6) s-=6;
		 goto kk;
	       case BS:
		 s--;
		 if(s<1) s=6;
		 goto kk;
	       case 1:
	       case 2:
	       case 3:
	       case 4:
	       case 5:
	       case 6:
	       case 7:
		if(make_dosboot_bad(ss+1))
		{
		strcpy(temp,"\n     The BOOT sector on Logical disk\n     C: has been covered.\n");
		temp[43]=toupper(ss-1+'C');
		write_inf(temp);
		}
		break;

	      }

	     }
	 break;
	 case 3:
	   wndd=establish_window(34,9,12,13);
	   set_colors(wndd,ALL,WHITE,BLACK,DIM);
	   set_colors(wndd,ACCENT,BLACK,WHITE,BRIGHT);
	   wprintf(wndd," C: Disk\n");
	   wprintf(wndd," D: Disk\n");
	   wprintf(wndd," E: Disk\n");
	   wprintf(wndd," F: Disk\n");
	   wprintf(wndd," G: Disk\n");
	   wprintf(wndd," H: Disk\n");
	   wprintf(wndd," I: Disk\n");
	   wprintf(wndd,"-------");
	   wprintf(wndd," Others\n");
	   wprintf(wndd," Return");
	   display_window(wndd);
	   while(ss!=0)
	     {
	      WINDOW *eldisk;
	      char drv[10]="C:";
              char msk25[]="[_:]";
	      ss=get_selection(wndd,ss,"CDEFGHIOR",WHITE,RED,DIM);
	      switch(ss)
	      {
	       case 0:
	       case 9:
		 delete_window(wndd);
		 break;
	       case 8:
		 eldisk=establish_window(20,11,8,40);
		 set_colors(eldisk,NORMAL,WHITE,BLACK,DIM);
		 set_colors(eldisk,BORDER,WHITE,WHITE,DIM);
		 wprintf(eldisk,"\n    Enter the logical disk code:");
		 display_window(eldisk);
		 init_template(eldisk);
		 fld=establish_field(eldisk,15,3,msk25,drv,'A');
		 data_entry(eldisk);
		 delete_window(eldisk);
		 ss=drv[0]-'C'+1;
		 if(ss>=1&&ss<=7)
		 {
		 if(make_fat_bad(ss+1))
		  {
		    strcpy(temp,"\n     The FATs on Logical disk\n     C: has been covered.\n");
		    temp[36]=toupper(ss-1+'C');
                    write_inf(temp);
		  }
		 }
		 else
		 {
                    strcpy(temp,"\n   Logical disk  : is not protected.\n   Stop. Nothing done on this disk.\n");
		    temp[17]=toupper(ss-1+'C');
		    ss=8;
                    write_inf(temp);
		 }

		 break;
	       case FWD:
		 s++;
		 if(s>6) s-=6;
		 goto kk;
	       case BS:
		 s--;
		 if(s<1) s=6;
		 goto kk;
	       case 1:
	       case 2:
	       case 3:
	       case 4:
	       case 5:
	       case 6:
	       case 7:
		if(make_fat_bad(ss+1))
		{
		strcpy(temp,"\n     The FATs on Logical disk\n     C: has been covered.\n");
		temp[36]=toupper(ss-1+'C');
		write_inf(temp);
		}
		break;

	      }

	     }
	 break;
	 case 4:
	   wndd=establish_window(41,9,12,13);
	   set_colors(wndd,ALL,WHITE,BLACK,DIM);
	   set_colors(wndd,ACCENT,BLACK,WHITE,BRIGHT);
	   wprintf(wndd," C: Disk\n");
	   wprintf(wndd," D: Disk\n");
	   wprintf(wndd," E: Disk\n");
	   wprintf(wndd," F: Disk\n");
	   wprintf(wndd," G: Disk\n");
	   wprintf(wndd," H: Disk\n");
	   wprintf(wndd," I: Disk\n");
	   wprintf(wndd,"-------");
	   wprintf(wndd," Others\n");
	   wprintf(wndd," Return");
	   display_window(wndd);
	   while(ss!=0)
	     {
	      WINDOW *eldisk;
	      char drv[10]="C:";
              char msk25[]="[_:]";
	      ss=get_selection(wndd,ss,"CDEFGHIOR",WHITE,RED,DIM);
	      switch(ss)
	      {
	       case 0:
	       case 9:
		 delete_window(wndd);
		 break;
	       case 8:
		 eldisk=establish_window(20,11,8,40);
		 set_colors(eldisk,NORMAL,WHITE,BLACK,DIM);
		 set_colors(eldisk,BORDER,WHITE,WHITE,DIM);
		 wprintf(eldisk,"\n    Enter the logical disk code:");
		 display_window(eldisk);
		 init_template(eldisk);
		 fld=establish_field(eldisk,15,3,msk25,drv,'A');
		 data_entry(eldisk);
		 delete_window(eldisk);
		 ss=drv[0]-'C'+1;
		 if(ss>=1&&ss<=7)
		 {
		    if(make_root_bad(ss+1))
		      {
		       strcpy(temp,"\n     The ROOT on Logical disk\n     C: has been covered.\n");
		       temp[36]=toupper(ss-1+'C');
		       write_inf(temp);
		      }
		 }
		 else
		 {
                    strcpy(temp,"\n   Logical disk  : is not protected.\n   Stop. Nothing done on this disk.\n");
		    temp[17]=toupper(ss-1+'C');
		    ss=8;
                    write_inf(temp);
		 }

		 break;
	       case FWD:
		 s++;
		 if(s>6) s-=6;
		 goto kk;
	       case BS:
		 s--;
		 if(s<1) s=6;
		 goto kk;
	       case 1:
	       case 2:
	       case 3:
	       case 4:
	       case 5:
	       case 6:
	       case 7:
		if(make_root_bad(ss+1))
		  {
		    strcpy(temp,"\n     The ROOT on Logical disk\n     C: has been covered.\n");
		    temp[36]=toupper(ss-1+'C');
		    write_inf(temp);
		  }
	       break;

	      }

	     }
	 break;
	 case 5:
	   wndd=establish_window(20,11,8,40);
	   set_colors(wndd,ALL,WHITE,BLACK,DIM);
	   display_window(wndd);
	   wprintf(wndd,"\n\n      Now,will break all above.\n");
	   wclrprintf(wndd,WHITE,RED,DIM,"            Really?[N]\b\b");
	   ch=get_char();
	   if(toupper(ch)!='Y')
	    {
	     delete_window(wndd);
	     break;
	    }
	   else
	    {
	     delete_window(wndd);
	     make_all_bad();
	    }
	   break;
	 case 6:
	    quicklowformat();
	    break;
       }
  }
  headend=establish_window(20,14,3,40);
  set_colors(headend,NORMAL,WHITE,BLACK,DIM);
  set_colors(headend,BORDER,WHITE,WHITE,DIM);
  display_window(headend);
  printf("\x7");
  wprintf(headend,"\n          Exit to DOS?[N]\b\b");
  if(toupper(get_char())=='Y')
    {
      close_all();
      clrscr();
      exit(0);
    }
  else
  {
     delete_window(headend);
     s=1;
     goto ll;
  }
}

void write_inf(char *c)
{
  WINDOW *inf;
  inf=establish_window(20,11,8,40);
  set_colors(inf,NORMAL,WHITE,BLACK,DIM);
  set_colors(inf,BORDER,WHITE,WHITE,DIM);
  wprintf(inf,c);
  wclrprintf(inf,WHITE,RED,DIM,"\n     Press any key to continue...");
  display_window(inf);
  get_char();
  delete_window(inf);
}
int make_mainboot_bad(void)
{
 if((biosdisk(3,0x80,0,0,1,1,part)))
   {ero("covering MAINBOOT");return 0;}
 else
   {
    wprintfr(bgwnd,"MAIN BOOT,     ");
    return 1;
   }
}
int make_dosboot_bad(int s)
{
 char where[100]="covering  : DOSBOOT";
 where[9]=s-2+'C';
 if(end_inf[s+2]==1)
       wrabs=abswrite50;
 else
       wrabs=abswrite30;
 if(((*wrabs)(s,1,0L,part)))
   {ero(where);return 0;}
 else
  {
   wprintfr(bgwnd,"%c: DOS BOOT,   ",s-2+'C');
   return 1;
  }
}
int make_fat_bad(int s)
{
  char where[100]="covering  : FAT";
  where[9]=s-2+'C';
  if(end_inf[s+2]==1)
       wrabs=abswrite50;
 else
       wrabs=abswrite30;
  if(((*wrabs)(s,totalsecoffat[s]>128?128:totalsecoffat[s],startsecoffat[s],part)))
    {ero(where);return 0;}
  else
   {
     wprintfr(bgwnd,"%c: FAT,        ",s-2+'C');
     return 1;
   }
}
int make_root_bad(int s)
{
  char where[100]="covering  : ROOT";
  where[9]=s-2+'C';
  if(end_inf[s+2]==1)
       wrabs=abswrite50;
 else
       wrabs=abswrite30;
  if(((*wrabs)(s,totalsecofroot[s],startsecofroot[s],part)))
    {ero(where);return 0;}
  else
   {
     wprintfr(bgwnd,"%c: ROOT,       ",s-2+'C');
     return 1;
   }
}
void make_all_bad(void)
{
  int i;
  WINDOW *eldisk,*floppydisk;
  FIELD *fld;
  char drv[10]="C:";
  char msk25[]="[_:]";
  drv[0]=disk_num-2+'C';
  {
		 eldisk=establish_window(20,11,8,40);
		 set_colors(eldisk,NORMAL,WHITE,BLACK,DIM);
		 set_colors(eldisk,BORDER,WHITE,WHITE,DIM);
		 wprintf(eldisk,"\n Enter the biggest logical disk code:");
		 display_window(eldisk);
		 init_template(eldisk);
		 fld=establish_field(eldisk,15,3,msk25,drv,'A');
		 data_entry(eldisk);
		 delete_window(eldisk);
  }/* To fet disk_num */
  disk_num=drv[0]-'C'+2;
  if(disk_num<2)
  {
		 floppydisk=establish_window(20,11,8,40);
		 set_colors(floppydisk,NORMAL,WHITE,BLACK,DIM);
		 set_colors(floppydisk,BORDER,WHITE,WHITE,DIM);
		 wprintf(floppydisk,"\n     Can't recover floppy disk.\n");
		 wclrprintf(floppydisk,WHITE,RED,DIM,"\n     Press any key to continue...");
		 display_window(floppydisk);
		 get_char();
		 delete_window(floppydisk);
		 return;

  }
  wclrprintf(bgwnd,BLUE,RED,DIM,"\nALL BEGIN\n");
  make_mainboot_bad();
  for(i=2;i<=disk_num;i++)
    {
      make_dosboot_bad(i);
      make_fat_bad(i);
      make_root_bad(i);
    }
    wclrprintf(bgwnd,BLUE,RED,DIM,"\nALL END\n");
}
void quicklowformat(void)
{
 WINDOW *quick;
 int ch;
 quick=establish_window(20,11,8,40);
 set_colors(quick,NORMAL,WHITE,BLACK,DIM);
 set_colors(quick,BORDER,WHITE,WHITE,DIM);
 display_window(quick);
 wprintf(quick,"\n  LOW-FORMAT harddisk?[N]\b\b");
 printf("\x7\x7");
 ch=get_char();
 if(toupper(ch)=='Y')
 {
   wclrprintf(quick,WHITE,RED,DIM,"Y\n  Really?[N]\b\b");
   ch=get_char();
   if(toupper(ch)=='Y')
    {
      wprintf(quick,"Y\n  Formatting...");
      if(formathd())
      {
	wprintf(quick,"\n  Over.");
        wclrprintf(bgwnd,BLUE,RED,DIM,"\nQuickLOWformat\n");
	wclrprintf(quick,WHITE,RED,DIM,"\n  Press any key to continue...");
	get_char();
      }
      delete_window(quick);
    }
   else
    goto qq;
 }
 else
 {
qq:wprintf(quick,"\n  Stop. Not formatted.\n");
   wclrprintf(quick,WHITE,RED,DIM,"\n  Press any key to continue...");
   get_char();
   delete_window(quick);
 }
}
int formathd(void)
{
 delay(4000);
 if(biosdisk(3,0x80,0,0,1,40,part))
   {
    ero("LOW-formatting \n  harddisk");
    return 0;
   }
 return 1;
}
void ero(char *where)
{
  WINDOW *inf;
  inf=establish_window(20,11,8,40);
  set_colors(inf,NORMAL,WHITE,BLACK,DIM);
  set_colors(inf,BORDER,WHITE,WHITE,DIM);
  wprintf(inf,"\n\n  Failure,when  ");
  wprintf(inf,where);
  wprintf(inf,".\n");
  display_window(inf);
  wclrprintf(inf,WHITE,RED,DIM,"\n     Press any key to continue...");
  get_char();
  delete_window(inf);
}
void get_total_and_start_sec(void)
 {
   unsigned char  BPB[512];
   char where[100]="reading  : BPB";
   int i;
   if(check_lock(0x80)==0) exit(1);

   for(i=2;i<100;i++)
   {
     if(end_inf[i+2]==1)
      {
       rdabs=absread50;
       wrabs=abswrite50;
      }
     else
      {
       rdabs=absread30;
       wrabs=abswrite30;
      }
     if((*rdabs)(i,1,0L,BPB))
      {
       totalsecoffat[i]=totalsecofroot[i]=0;
       startsecoffat[i]=startsecofroot[i]=0L;
       disk_num=i-1;
       if(disk_num>8)
	 disk_num=8;
       return;
      }
     else
      {
       totalsecoffat[i]=(FAT_NUMBER)*(SECTOR_PER_FAT);
       startsecoffat[i]=(long)(START_SECTOR_NUMBER);
       totalsecofroot[i]=(unsigned)(((DIRNUMBER_OF_ROOT)*32+511)/512);
       startsecofroot[i]=(long)(totalsecoffat[i]+startsecoffat[i]);
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
int  abswrite50(int drive,int num,long start_sector,char *b)
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
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    unsigned char boot[512];
    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	ero("openning LASTLINE.CFG.\n  You have not installed LASTLINE.\n");
	exit(1);
      }
    fread(end_inf,20,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
	biosdisk(0,drive,0,0,0,0,0);
	ero("reading MAINBOOT.");
	exit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	ero("checking LASTLINE.\n  Not installed LASTLINE.");
	exit(1);
      }
    return(0);
    }