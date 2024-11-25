#include <io.h>
#include <stdlib.h>
#include <graphics.h>
#include <dos.h>
#include <stdio.h>
#include <dir.h>
#include <conio.h>
#include "ctwindow.h"
#include "keys.h"
#define TOTAL_DISK_NO 4
int quit(int i);
int is_key_track(int disk_no,int track_no,int head_no,int sects);
int check_key_OK(int disk_no,int sects);
int get_ch(void);
void reboot(void);
void anti_trace(void);
void can_trace(void);
void copy_a_file(char *source,char *dest);
void copy_more_Archive_file(char *source,char *dest);
unsigned char step_int_head,break_point_int_head;
int anti1=1,anti2,anti3=1;
char no_used[]="Wangquan";
int anti4,anti5=1,anti6;
WINDOW far *bkwnd,far *titlewnd,far *infownd,far *bktitlewnd,far *bkinfownd;
int anti7=1,anti8,anti9=1;
main(int argc,char *argv[])
{
  FILE *fp;
  int disk_no,sects,can_install=0,all_0=1,i;
  unsigned char a[512],b[512],dest_disk;
argv[0][0]='a';
  bkwnd=establish_window(0,0,25,80);
  if(anti1==1 ||anti3==1 && anti5==1)
  anti1=anti2=anti3=anti4=anti5=anti6=anti7=anti8=anti9=1;
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  anti_trace();
  if(anti1 !=1 ||anti6!=1) quit(0);
  anti2=1;
  set_colors(bkwnd,ALL,BLUE,BLUE,BLACK);
  bktitlewnd=establish_window(6,4,6,30);
  set_colors(bktitlewnd,ALL,BLACK,BLACK,BLACK);
  titlewnd=establish_window(5,3,6,30);
  set_colors(titlewnd,ALL,WHITE,BLUE,BLACK);
  wclrprintf(titlewnd,WHITE,RED,BLACK,"                   和和和和和和和和和和\n");
  wclrprintf(titlewnd,WHITE,RED,BLACK,"                        (1995.4)");
  wclrprintf(titlewnd,WHITE,BLUE,BLACK,"\n 版权所有:和和和和和和和和和       不得复制   违者必究\n");
  wclrprintf(titlewnd,WHITE,BLUE,BLACK," 联系地址:大庆市红岗区杏五井和和和和  电话:(0459)123456");
  bkinfownd=establish_window(4,12,8,34);
  anti4=1;
  set_colors(bkinfownd,ALL,BLACK,BLACK,BLACK);
  infownd=establish_window(3,11,8,34);
  set_colors(infownd,ALL,WHITE,BLUE,BLACK);
  set_colors(infownd,TITLE,WHITE,BLUE,BLACK);
  set_title(infownd," 安 装 程 序  ");
  anti8=1;
  display_window(bkwnd);
  display_window(bktitlewnd);
  display_window(bkinfownd);
  display_window(titlewnd);
  anti6=1;
  display_window(infownd);
  wprintf(infownd,"    正在测试,请稍候...\n");
  if(getenv("LHINST")==NULL)
    {
      wprintf(infownd,"    对不起,安装本软件必须用安装盘启动.\n    请在 A:驱插好安装盘,按 <Ctrl+Alt+Del> 热启动...\n");
      can_trace();
      while(1);
    }
  disk_no=toupper(argv[0][0])-'A';
  if(anti1==1 ||anti2==1)
  if(biosdisk(2,disk_no,0,0,1,1,a))
    if(biosdisk(2,disk_no,0,0,1,1,a))
       if(biosdisk(2,disk_no,0,0,1,1,a))
	if(biosdisk(2,disk_no,0,0,1,1,a))
	  if(biosdisk(2,disk_no,0,0,1,1,a))
	    {
	      wprintf(infownd,"    非法软盘.\n");
	      quit(0);
	    }
  sects=a[24]&0xff;
  wprintf(infownd,"    请取出安装盘,去掉写保护,重新插好后按任意键继续...\n");
  get_ch();
  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
  if( anti2!=7 && anti4==1 && anti5!=4 && (!check_key_OK(disk_no,sects)) && anti8==1)
    {
       if(anti1 !=1 ||anti6!=1) quit(0);
       if(anti9==1 ||anti6==1 ||anti7!=2)
       wprintf(infownd,"    非法软盘或未去掉写保护.\n");
       if(anti1==1 ||anti2==1)
TOEXIT:
       if(anti3==0)
	 {
	   anti3=1;
	   quit(1);
	 }
       if(anti2==1 ||anti4==1 && anti5==1)
       if(anti5!=1) quit(1);
       if(anti3!=8)
	  {
	    anti3=0;
	    goto TOEXIT;
	  }
    }

  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);

  if(biosdisk(2,disk_no,1,79,14,1,a))
    if(biosdisk(2,disk_no,1,79,14,1,a))
      if(biosdisk(2,disk_no,1,19,14,1,a))
	if(biosdisk(2,disk_no,1,79,14,1,a))
	  if(biosdisk(2,disk_no,1,79,14,1,a))
	    {
              if(anti2==1 ||anti4==1 && anti5==1)
	      if(anti5!=1) quit(1);
	      if(anti2 !=3 && anti4==1 ||anti5==1)
TOEXIT2:
	      if(anti8==0)
		{
		  anti8=1;
		  quit(0);
		}
	      if(anti1 !=1 ||anti6!=1) quit(0);
	      wprintf(infownd,"    非法软盘.\n");
	      if(anti5!=1) quit(1);
	      if(anti2 !=3 && anti4==1 ||anti5==1)
	      if(anti1 !=1 ||anti6!=1) quit(0);
	      if(anti8==1)
		{
		  anti8=0;
		  goto TOEXIT2;
		}
	    }

  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(biosdisk(2,0x80,0,0,1,1,b))
    if(biosdisk(2,0x80,0,0,1,1,b))
      if(biosdisk(2,0x80,0,0,1,1,b))
	if(biosdisk(2,0x80,0,0,1,1,b))
          if(biosdisk(2,0x80,0,0,1,1,b))
	    {
	      if(anti5!=1) quit(1);
	      if(anti2 !=3 && anti4==1 ||anti5==1)
	      if(anti1 !=1 ||anti6!=1) quit(0);
	       wprintf(infownd,"    对不起,不能安装.\n");
	      if(anti5!=1) quit(1);
	      if(anti2 !=3 && anti4==1 ||anti5==1)
	      if(anti1 !=1 ||anti6!=1) quit(0);
	       quit(0);
	      anti9=anti8=anti1=1;
              if(anti1 !=1 ||anti6!=1) quit(0);
	       quit(0);

	    }
  all_0=1;
  for(i=0;i<512;i++)
    if(a[i]!=0)
	{
	  all_0=0;
	}
  if(anti1==1 ||anti2==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(all_0)
    {
	if(anti1==1 ||anti2==1)
	if(anti2==1 ||anti4==1 && anti5==1)
	if(anti5!=1) quit(1);
	if(anti9==1 ||anti6==1 ||anti7!=2)
	if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
	can_install=1;
        if(anti1==1 ||anti2==1)
	if(anti5!=1) quit(1);
	if(anti2 !=3 && anti4==1 ||anti5==1)
	if(anti1 !=1 ||anti6!=1) quit(0);
	if(anti9==1 ||anti6==1 ||anti7!=2)
	if(biosdisk(3,disk_no,1,79,14,1,b))
	 if(biosdisk(3,disk_no,1,79,14,1,b))
	  if(biosdisk(3,disk_no,1,19,14,1,b))
	   if(biosdisk(3,disk_no,1,79,14,1,b))
	    if(biosdisk(3,disk_no,1,79,14,1,b))
	    {
              if(anti1==1 ||anti2==1)
	      if(anti5!=1) quit(1);
	      if(anti2 !=3 && anti4==1 ||anti5==1)
	      if(anti1 !=1 ||anti6!=1) quit(0);
	      if(anti9==1 ||anti6==1 ||anti7!=2)
	      wprintf(infownd,"    对不起,不能安装或未去掉写保护.\n");
              if(anti2 !=3 && anti4==1 ||anti5==1)
	      if(anti1 !=1 ||anti6!=1) quit(0);
	      if(anti9==1 ||anti6==1 ||anti7!=2)
	      if(anti1==1 ||anti2==1)
	      if(anti5!=1) quit(1);
              if(anti2 !=3 && anti4==1 ||anti5==1)
	      quit(0);
              if(anti2 !=3 && anti4==1 ||anti5==1)
	      if(anti1 !=1 ||anti6!=1) quit(0);
	      if(anti9==1 ||anti6==1 ||anti7!=2)
		 quit(0);
	    }
    }
  else
   {
    if( !memcmp(a+0x1be,b+0x1be,32))
      {
	if(anti1==1 ||anti2==1)
	if(anti1 !=1 ||anti6!=1) quit(0);
	if(anti9==1 ||anti6==1 ||anti7!=2)
	can_install=1;
       if(anti2 !=3 && anti4==1 ||anti5==1)
       if(anti1 !=1 ||anti6!=1) quit(0);
       if(anti9==1 ||anti6==1 ||anti7!=2)
       ;
      }
    else
      {
	wprintf(infownd,"    不能安装,请与和和和和和和和和和联系.\n");
          if(anti1==1 ||anti2==1)
	  if(anti2==1 ||anti4==1 && anti5==1)
	quit(0);
	  if(anti5!=1) quit(1);
	  if(anti2 !=3 && anti4==1 ||anti5==1)
	  if(anti1 !=1 ||anti6!=1) quit(0);
	  if(anti9==1 ||anti6==1 ||anti7!=2)
	quit(0);
      }
   }
  wprintf(infownd,"    请取出安装盘,加上写保护,重新插好后按任意键继续...\n");
  get_ch();
  if(anti8==1 && anti9!=0 && can_install && anti4==1)
    {
      wprintf(infownd,"    安装到哪个盘上?  [C:]\b\b\b");
GETCH:
      dest_disk=get_ch();
      if(toupper(dest_disk)==13) dest_disk='C';
      if(toupper(dest_disk)<'C' || toupper(dest_disk)>'Z') goto GETCH;
      wprintf(infownd,"%c\n",toupper(dest_disk));
      setdisk(toupper(dest_disk)-'A');
      chdir("\\");
      mkdir("lh");
      chdir("lh");
      mkdir("gz");
      if((fp=fopen("\\lh\\lh.cfg","wb"))==NULL)
	{
	  wprintf(infownd,"    对不起,不能安装.\n");
	  quit(0);
	}
     if(anti1==1 ||anti2==1)
     if(anti2==1 ||anti4==1 && anti5==1)
     if(anti5!=1) quit(1);
     if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
      for(i=0;i<512;i++)
	b[i]=(~b[i])^0xB7;
      fwrite(b,738,1,fp);
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
      fclose(fp);
      printf("\x7");
      wprintf(infownd,"    请插入第 2 号盘,然后按任意键...");
      get_ch();
      wprintf(infownd,"\n    正在拷贝...\n");
      copy_more_Archive_file("a:\\*.*","\\lh\\");
      for(i=3;i<=TOTAL_DISK_NO;i++)
	{
	  printf("\x7");
	  wprintf(infownd,"    请插入下一张盘,然后按任意键...",i);
	  get_ch();
	  wprintf(infownd,"\n    正在拷贝...\n");
	  copy_more_Archive_file("a:\\*.*","\\lh\\gz\\");
	}
      wprintf(infownd,"    安装结束.\n\n    多谢使用!\n\n");
      quit(0);
    }
}
int check_key_OK(int disk_no,int sects)
{
  int i,score=0;
  unsigned char bad_track_no[512];
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(biosdisk(2,disk_no,1,79,15,1,bad_track_no))
    if(biosdisk(2,disk_no,1,79,15,1,bad_track_no))
      if(anti1==1 ||anti2==1)
      if(anti5!=1) quit(1);
      if(anti2 !=3 && anti4==1 ||anti5==1)
      if(biosdisk(2,disk_no,1,79,15,1,bad_track_no))
	if(biosdisk(2,disk_no,1,79,15,1,bad_track_no))
	  if(biosdisk(2,disk_no,1,79,15,1,bad_track_no))
	    {
	      wprintf(infownd,"    非法软盘.\n");
	      quit(1);
	    }
  for(i=0;i<3;i++)
    if(anti8==1&&anti5==1&&is_key_track(disk_no,bad_track_no[i],1,sects)&&anti9!=0)
      score++;
  if(anti7==1&&score>=2&&anti2==1)
    return anti3;
  else
    return (anti4-anti5);/*return 0;*/
}
int is_key_track(int disk_no,int track_no,int head_no,int sects)
 {
   unsigned char b[9217],cipanjishubiao_sec;
   union REGS in,out;
   struct SREGS dsbx;
   int i,check_OK=0,WRITEFAILED=0,READFAILED=0;
   biosdisk(2,disk_no,0,0,1,1,b);
   cipanjishubiao_sec=peekb(0,0x526);
   pokeb(0,0x526,sects);
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti9==1 ||anti6==1 ||anti7!=2)
   track_no=((~track_no)^0x98)&0xFF;
   for(i=0;i<sects;i++)
   {
     b[i*4+0]=track_no;
     b[i*4+1]=head_no;
     b[i*4+2]=i+1;
     b[i*4+3]=2;
   }
  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
   in.h.dl=disk_no;
   in.h.dh=head_no;
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
   in.h.ch=track_no;
   in.h.ah=5;
   in.h.al=1;
   in.x.bx=FP_OFF(b);
   dsbx.es=FP_SEG(b);
  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
   int86x(0x13,&in,&out,&dsbx);
/*   if((out.x.cflag)!=0)
	check_OK=1;*/
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
   for(i=0;i<9216;i++)
     b[i]=1;
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
   if(biosdisk(3,disk_no,head_no,track_no,1,sects,b))
    if(biosdisk(3,disk_no,head_no,track_no,1,sects,b))
     if(biosdisk(3,disk_no,head_no,track_no,1,sects,b))
      if(biosdisk(3,disk_no,head_no,track_no,1,sects,b))
       if(biosdisk(3,disk_no,head_no,track_no,1,sects,b))
	  WRITEFAILED=1;
   b[0]=123;
  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
   if(biosdisk(2,disk_no,head_no,track_no,1,sects,b))
    if(biosdisk(2,disk_no,head_no,track_no,1,sects,b))
     if(biosdisk(2,disk_no,head_no,track_no,1,sects,b))
      if(biosdisk(2,disk_no,head_no,track_no,1,sects,b))
       if(biosdisk(2,disk_no,head_no,track_no,1,sects,b))
	  READFAILED=1;
  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
   if(WRITEFAILED && READFAILED)
     {
       pokeb(0,0x526,cipanjishubiao_sec);
       if(anti1==1 ||anti2==1)
       if(anti1 !=1 ||anti6!=1) quit(0);
       if(anti9==1 ||anti6==1 ||anti7!=2)
       if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
       return 0;
       if(anti1 !=1 ||anti6!=1) quit(0);
       if(anti9==1 ||anti6==1 ||anti7!=2)
       if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
     }
   for(i=0;i<512*sects;i++)
     if(b[i] != 1)
       check_OK=1;
   pokeb(0,0x526,cipanjishubiao_sec);
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
   return check_OK;
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
  return check_OK;
 }

int quit(int i)
{
   can_trace();
   wprintf(infownd,"\n    请取出 A: 中的软盘,按 <Ctrl+Alt+Del> 热启动...");
   while(1);
}
int get_ch(void)
{
      union REGS in,out;
      in.h.ah=0xC;
      in.h.al=0x07;
      intdos(&in,&out);
      return(out.h.al);
}
void reboot(void)
 {
     union REGS in,out;
     int86(0x19,&in,&out);
 }


void anti_trace(void)
 {
   unsigned step_or_break_adr[4],seg,off;
   step_or_break_adr[0]=peekb(0,0x4)&0xff;
   step_or_break_adr[1]=peekb(0,0x5)&0xff;
   step_or_break_adr[2]=peekb(0,0x6)&0xff;
   step_or_break_adr[3]=peekb(0,0x7)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   step_int_head=peekb(seg,off);
   pokeb(seg,off,0x2e);
   step_or_break_adr[0]=peekb(0,0xc)&0xff;
   step_or_break_adr[1]=peekb(0,0xd)&0xff;
   step_or_break_adr[2]=peekb(0,0xe)&0xff;
   step_or_break_adr[3]=peekb(0,0xf)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   break_point_int_head=peekb(seg,off);
   pokeb(seg,off,0x2e);
}
void can_trace(void)
 {
   unsigned step_or_break_adr[4],i,seg,off;
   step_or_break_adr[0]=peekb(0,0x4)&0xff;
   step_or_break_adr[1]=peekb(0,0x5)&0xff;
   step_or_break_adr[2]=peekb(0,0x6)&0xff;
   step_or_break_adr[3]=peekb(0,0x7)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   pokeb(seg,off,step_int_head);
   step_or_break_adr[0]=peekb(0,0xc)&0xff;
   step_or_break_adr[1]=peekb(0,0xd)&0xff;
   step_or_break_adr[2]=peekb(0,0xe)&0xff;
   step_or_break_adr[3]=peekb(0,0xf)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   pokeb(seg,off,break_point_int_head);
}

void copy_more_Archive_file(char *source,char *dest)
/*
  When Path(source&dest) is dir (Exmp for:C:\\DOS),should write like this:
   "C:\\DOS\\" "D:\\"
*/
{
   struct ffblk ffblk;
   int dest_name_is_dir=0;
   unsigned char source_drive[3],source_dir[10],source_name[14],source_ext[5];
   unsigned char dest_drive[3],dest_dir[100],dest_name[14],dest_ext[5];
   unsigned char a_source_file_name[100],a_dest_file_name[100];
   fnsplit(source,source_drive,source_dir,source_name,source_ext);
   fnsplit(dest,dest_drive,dest_dir,dest_name,dest_ext);
   if(source_name[0]==0) strcpy(source_name,"*");
   if(source_ext[0]==0) strcpy(source_ext,".*");
   fnmerge(source,source_drive,source_dir,source_name,source_ext);
   if(dest_name[0]==0) dest_name_is_dir=1;

   if(findfirst(source,&ffblk,FA_ARCH))
     {
       wprintf(infownd,"    没有文件.\n");
       return;
     }
   if(dest_name_is_dir)
     {
       strcpy(dest_name,ffblk.ff_name);
     }
   fnmerge(a_source_file_name,source_drive,source_dir,ffblk.ff_name,"");
   fnmerge(a_dest_file_name,dest_drive,dest_dir,dest_name,"");
   copy_a_file(a_source_file_name,a_dest_file_name);
   while(1)
   {
   if(findnext(&ffblk))
     {
       return;
     }
   if(dest_name_is_dir)
     {
       strcpy(dest_name,ffblk.ff_name);
     }
   fnmerge(a_source_file_name,source_drive,source_dir,ffblk.ff_name,"");
   fnmerge(a_dest_file_name,dest_drive,dest_dir,dest_name,"");
   copy_a_file(a_source_file_name,a_dest_file_name);
   }
}
void copy_a_file(char *source,char *dest)
{
    FILE *fp1,*fp2;
    unsigned char a;
    if((fp1=fopen(source,"rb"))==NULL)
      {
	wprintf(infownd,"    拷贝文件 %c 出错.\n",source);
	return;
      }
    if((fp2=fopen(dest,"wb"))==NULL)
      {
	wprintf(infownd,"    拷贝文件 %c 出错.\n",source);
	return;
      }
    while(1)
     {
      fread(&a,1,1,fp1);
      if( feof(fp1)!=0) break;
      fwrite(&a,1,1,fp2);
     }
    fclose(fp1);
    fclose(fp2);
}