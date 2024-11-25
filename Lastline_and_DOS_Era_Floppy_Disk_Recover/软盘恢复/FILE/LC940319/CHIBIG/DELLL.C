#include "twindow.h"
#include "keys.h"
#include <stdio.h>
#include <dir.h>
#include <dos.h>
void getaline(FILE *fp,char *aline);
unsigned get_disk_num(void);
int readparttable(int way);
unsigned char part[512];
WINDOW *inf;
main()
 {
   FILE *aut,*temp,*fp;
   WINDOW *tit,*titt,*inff;
   char k;
   unsigned maxdisk,i;
   unsigned char fatroot[200]="C:\\FAT&ROOT.IMG",tempname[100],aline[200];
   clrscr();
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
   wprintf(inf,"                     LASTLINE Version 2.0\n");
   wprintf(inf,"                 (C) Copyright WANGQUAN 1993.\n");
   wclrprintf(inf,BLUE,YELLOW,BRIGHT,"\n                  DELLL: Eraser for LASTLINE .  \n");
   printf("\x7");
   wprintf(inf,"\n             Remove LASTLINE from HARDDISK,Sure?[N]\b\b");
   k=getch();
   if(toupper(k)!='Y')
       {
	cursor(1,10);
	exit(0);
       }
   wprintf(inf,"Y");
   wcursor(inf,12,5);
   wprintf(inf,"                                                         ");
   wcursor(inf,20,5);
   system("c:>c:\\aaaaaaaa.aaa");
   system("cd\\lastline>c:\\aaaaaaaa.aaa");
   _chmod("c:\\lastline\\lastline.cfg",1,FA_ARCH);
   fp=fopen("c:\\lastline\\mngrboot.exe","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("mngrboot.exe");
   fp=fopen("c:\\lastline\\fatrsave.exe","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("fatrsave.exe");
   fp=fopen("c:\\lastline\\alwaysee.com","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("alwaysee.com");
   remove("strchk1.exe");
   remove("strchk2.exe");
   fp=fopen("c:\\lastline\\trans.com","wb");
   fwrite(aline,40000,1,fp);
   fclose(fp);
   remove("trans.com");
   remove("lsth.inf");
   fp=fopen("c:\\lastline\\lastline.cfg","wb");
   fwrite(aline,501,1,fp);
   fclose(fp);
   remove("lastline.cfg");
   system("cd\\>c:\\aaaaaaaa.aaa");
   remove("aaaaaaaa.aaa");
   rmdir("c:\\lastline");
   maxdisk=get_disk_num();
   for(i=2;i<maxdisk;i++)
    {
     fatroot[0]=i-2+'C';
     _chmod(fatroot,1,FA_ARCH);
     remove(fatroot);
    }
   rename("AUTOEXEC.BAT","aaaaaaaa.aaa");
   temp=fopen("aaaaaaaa.aaa","rt");
   aut=fopen("AUTOEXEC.BAT","wt");
   while(!feof(temp))
    {
      getaline(temp,aline);
      strupr(aline);
      if(!(strstr(aline,"STRCHK1")||strstr(aline,"STRCHK2")||
	 strstr(aline,"MNGRBOOT")||strstr(aline,"FATRSAVE")||
	 strstr(aline,"ALWAYSEE")))
	{
	 fputs(aline,aut);
	 fputc('\n',aut);
	}
    }
    fcloseall();
   remove("aaaaaaaa.aaa");
   wcursor(inf,1,5);
   wprintf(inf,"              Over.   Press any key to exit...");
   getch();
   cursor(1,10);
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
 }