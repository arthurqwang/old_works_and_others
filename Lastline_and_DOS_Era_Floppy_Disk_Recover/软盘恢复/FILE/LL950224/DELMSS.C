/*******************************************************************
  File name:     DELMSS.C
  Belong to:     MSS 2.0 English & Chinese version
  Date:          NOV/10/94
  Author:        WangQuan
  Function:      To DELETE MSS 2.0 from harddisk.
		 English & Chinese versions use the same DELMSS.
  Usage:         X:\ANYPATH>Y:\ANYPATH\DELMSS<CR>
		   X:,Y: = A:,B:,C:,D:...
  Where stored:  Floppy disk "MSS 2.0 English(or Chinese) version
		 Source files"(MSS 2.0 Ying(Zhong)wenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

#include "twindow.h"
#include "keys.h"
#include <stdio.h>
#include <dir.h>
#include <dos.h>
void getaline(FILE *fp,char *aline);
unsigned get_disk_num(void);
int readparttable(int way);
unsigned get_SN_from_hd(void);
void get_BK(void);

int olddvr;

unsigned BKHEAD,BKTRACK;
unsigned char part[512];
WINDOW *inf;
void main(int argc,char *argv[])
 {
   FILE *aut,*temp,*fp;
   WINDOW *tit,*titt,*inff;
   char k;
   unsigned maxdisk,i,x,y,disk_num,begin_sec,total_del_sec_num;
   unsigned char fatroot[200]="C:\\FATIMAGE.CUR",tempname[100],aline[200];
   unsigned char deltem[8192],disklabel[]="C:";
   x=wherex();y=wherey();
   olddvr=getdisk();
   inff=establish_window(3,1,8,64);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[BORDER]=0x33;
   set_border(inff,3);
   display_window(inff);
   inf=establish_window(1,0,8,64);
   set_colors(inf,ALL,BLUE,WHITE,BRIGHT);
   inf->wcolor[BORDER]=0x11;
   set_border(inf,3);
   display_window(inf);
   wclrprintf(inf,BLUE,YELLOW,BRIGHT,"\n\n                 MSS Version 2.0  SN:%06u\n",get_SN_from_hd());
/*   wprintf(inf,"             (C) Copyright DongLe Computer Corp.\n");
   wprintf(inf,"                Designed & Coded by WANGQUAN");*/
   wclrprintf(inf,BLUE,YELLOW,BRIGHT,"                   DELMSS: Eraser for MSS   \n\n\n");
   printf("\x7");
   wprintf(inf,"              Remove MSS from HARDDISK,Sure?[N]\b\b");
   k=get_ch();
   if(toupper(k)!='Y')
       {
	close_all();
	gotoxy(x,y);
	setdisk(olddvr);
	exit(0);
       }
   wprintf(inf,"Y");
   wcursor(inf,11,5);
   wprintf(inf,"                                                          ");
   wcursor(inf,20,5);
   system("c:>NUL");
   system("cd\\MSS>NUL");
   _chmod("c:\\MSS\\MSS.cfg",1,FA_ARCH);
   fp=fopen("c:\\MSS\\BTMNGR.exe","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("BTMNGR.exe");
   fp=fopen("c:\\MSS\\SAVEFAT.exe","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("SAVEFAT.exe");
   fclose(fp);
   fp=fopen("c:\\MSS\\MSSSYS.EX","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("MSSSYS.EX");
   remove("MSSHZ.LIB");
   fp=fopen("c:\\MSS\\MSS.cfg","wb");
   fwrite(aline,501,1,fp);
   fclose(fp);
   remove("MSS.cfg");
   system("cd\\>NUL");
   rmdir("c:\\MSS");
   rename("AUTOEXEC.BAT","aaaaaa.LL$");
   temp=fopen("aaaaaa.LL$","rt");
   aut=fopen("AUTOEXEC.BAT","wt");
   while(!feof(temp))
    {
      getaline(temp,aline);
      strupr(aline);
      if(!(strstr(aline,"BTMNGR")||strstr(aline,"SAVEFAT")))
	{
	 fputs(aline,aut);
	 fputc('\n',aut);
	}
    }
    fcloseall();
   remove("aaaaaa.LL$");
/*Del hidden sector informations and FATIMAGE.CUR */
  if(!strcmp(strupr(argv[1]),"/S"))
  {
   int read_del_sec_success=1;
   disk_num=get_disk_num()-2;
   begin_sec=9-disk_num;
   total_del_sec_num=disk_num*2+2;
   if(biosdisk(2,0x80,0,0,begin_sec,total_del_sec_num,deltem))
     if(biosdisk(2,0x80,0,0,begin_sec,total_del_sec_num,deltem))
       if(biosdisk(2,0x80,0,0,begin_sec,total_del_sec_num,deltem))
	 if(biosdisk(2,0x80,0,0,begin_sec,total_del_sec_num,deltem))
           if(biosdisk(2,0x80,0,0,begin_sec,total_del_sec_num,deltem))
	     read_del_sec_success=0;

   for(i=0;i<total_del_sec_num;i++)
    if(deltem[i*512+511]=='Q'
	&&(
	     (deltem[i*512+3]  =='W' && deltem[i*512+510]=='W')
	   ||(deltem[i*512]    =='W' && deltem[i*512+1]  =='W')
	   ||(deltem[i*512+510]=='W')
	   ||(deltem[i*512]    =='W')
	  )
      )
      deltem[i*512+511]='D';
   if(read_del_sec_success)
     if(biosdisk(3,0x80,0,0,begin_sec,total_del_sec_num,deltem))
       if(biosdisk(3,0x80,0,0,begin_sec,total_del_sec_num,deltem))
	 if(biosdisk(3,0x80,0,0,begin_sec,total_del_sec_num,deltem))
	   if(biosdisk(3,0x80,0,0,begin_sec,total_del_sec_num,deltem))
	     if(biosdisk(3,0x80,0,0,begin_sec,total_del_sec_num,deltem))
	       ;

   get_BK();
   read_del_sec_success=1;
   if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
     if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
       if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	 if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
           if(biosdisk(2,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	     read_del_sec_success=0;

   for(i=0;i<total_del_sec_num;i++)
    if(deltem[i*512+511]=='Q'
	&&(
	     (deltem[i*512+3]  =='W' && deltem[i*512+510]=='W')
	   ||(deltem[i*512]    =='W' && deltem[i*512+1]  =='W')
	   ||(deltem[i*512+510]=='W')
	   ||(deltem[i*512]    =='W')
	  )
      )
      deltem[i*512+511]='D';
   if(read_del_sec_success)
     if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
       if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	 if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
	   if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
             if(biosdisk(3,0x80,BKHEAD,BKTRACK,begin_sec,total_del_sec_num,deltem))
		;

   for(i=0;i<disk_num;i++)
     {
       disklabel[0]='C'+i;
       fatroot[0]='C'+i;
       system(disklabel);
       system("cd\\");
       _chmod(fatroot,1,FA_ARCH);
       remove("FATIMAGE.CUR");
     }
  }
   wcursor(inf,1,5);
   wprintf(inf,"              Done.   Press any key to exit...");
   get_ch();
   close_all();
   gotoxy(x,y);
   setdisk(olddvr);
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

unsigned get_SN_from_hd(void)
{
  unsigned SN;
  unsigned char part[512];
  get_BK();
  if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,part))
    biosdisk(2,0x80,0,0,10,1,part);
  if(part[0]!='W' || part[511]!='Q')
    biosdisk(2,0x80,0,0,10,1,part);
  SN = part[507]+part[508]*256;
  return SN;
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
/*   BKHEAD=(temp[2]&0xff)-1;*//*Can't pass DongXiangjie's PC.*/
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

