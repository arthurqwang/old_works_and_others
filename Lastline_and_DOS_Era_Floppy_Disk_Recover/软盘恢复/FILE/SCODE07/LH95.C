#include <stdio.h>
#include <bios.h>
#include <dos.h>
#include <time.h>
#include <stdlib.h>
int check_set_run_times(void);
void stop_by_date(void);
void anti_trace(void);
void can_trace(void);
void proccess_file(void);
void un_proccess_file(void);
int anti1,anti2,anti3,anti4,anti5,anti6,anti7,anti8,anti9;
unsigned char step_int_head,break_point_int_head;
main()
{
   FILE *fp,*fpp;
   int i;
   unsigned char a[512],b[512];
   anti1=anti2=anti3=anti4=1;
   if(biosdisk(2,0x80,0,0,1,1,a))
    if(biosdisk(2,0x80,0,0,1,1,a))
     if(biosdisk(2,0x80,0,0,1,1,a))
       {
	 printf("Can not run.\n");
	 quit(0);
       }
  anti5=anti6=anti7=anti8=anti9=1;
  if((fp=fopen("lh.cfg","rb"))==NULL)
    {
       printf("Can not run.\n");
       quit(0);
    }
  fread(b,512,1,fp);
  fclose(fp);
  if(anti1==1 ||anti2==1)
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  anti_trace();
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
  stop_by_date();
  for(i=0;i<512;i++)
    b[i]=~(b[i]^0xB7);
  if(anti1==1 ||anti2==1)
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if( memcmp(b+0x1be,a+0x1be,32))
    {
      printf("Invalid user.\n");
      if(anti1==1 ||anti2==1)
      if(anti2==1 ||anti4==1 && anti5==1)
      if(anti5!=1) quit(1);
      if((fp=fopen("LHKL.DAT","wt"))==NULL)
	{
	  printf("Error.\n");
	}
      if(anti1==1 ||anti2==1)
      if(anti2==1 ||anti4==1 && anti5==1)
      if(anti5!=1) quit(1);
      fprintf(fp,"NO");
      if(anti2==1 ||anti4==1 && anti5==1)
      fclose(fp);
      quit(0);
    }
  else
    {
  if(anti2==1 ||anti4==1 && anti5==1)
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);

      if((fp=fopen("LHKL.DAT","wt"))==NULL)
	{
	  printf("Error.\n");
	}
  if(anti5!=1) quit(1);
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
  if(anti9==1 ||anti6==1 ||anti7!=2)
      fprintf(fp,"WQOK");
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
      fclose(fp);
  if(anti1 !=1 ||anti6!=1) quit(0);
      can_trace();
      proccess_file();
      system("\\LH\\GZ\\LHM.EXE");
      un_proccess_file();
  if(anti9==1 ||anti6==1 ||anti7!=2)
  if(!(anti2==1 ||anti6==1 ||anti7!=2))  quit(1);
    }
}
int quit(int i)
{
   can_trace();
   exit(i);
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
void proccess_file(void)
{
   FILE *fp;
   int i;
   unsigned char a[512],b[512];
   if((fp=fopen("LH.CFG","rb"))==NULL)
     {
      printf("Reinstall please.\n");
      quit(0);
     }
    fread(a,512,1,fp);
    fclose(fp);
    if((fp=fopen("\\lh\\gz\\LH95.dat","rb+"))==NULL)
      {
      return;
      quit(0);
      }
    fread(b,512,1,fp);
    fseek(fp,0,SEEK_SET);
    for(i=0;i<512;i++)
      b[i]=(b[i]^a[i])&0xff;
    fwrite(b,512,1,fp);
    fclose(fp);
    system("ren \\lh\\gz\\lh95.dat lhm.exe>NUL");
}

void un_proccess_file(void)
{
   FILE *fp;
   int i;
   unsigned char a[512],b[512];
   if((fp=fopen("LH.CFG","rb"))==NULL)
     {
      printf("Reinstall please.\n");
      quit(0);
     }
    fread(a,512,1,fp);
    fclose(fp);
    system("ren \\LH\\GZ\\lhm.exe lh95.dat>NUL");
    if((fp=fopen("\\LH\\GZ\\LH95.dat","rb+"))==NULL)
      {
      printf("Reinstall please.\n");
      quit(0);
      }
    fread(b,512,1,fp);
    fseek(fp,0,SEEK_SET);
    for(i=0;i<512;i++)
      b[i]=(b[i]^a[i])&0xff;
    fwrite(b,512,1,fp);
    fclose(fp);
}
void stop_by_date(void)
{
 struct date dt;
 int i;
 getdate(&dt);
 if(dt.da_year > 1995)
 {
   system("copy lh.cfg lh95.dat>NUL");
   system("del lh95.dat>NUL");
   quit(0);
 }
 if((dt.da_mon&0xff) == 10)
   {
   if(check_set_run_times()==0)
    {
      system("copy lh.cfg lh95.dat>NUL");
      system("del lh95.dat>NUL");
      quit(0);
    }
   }
}
int check_set_run_times(void)
{
   FILE *fp;
   unsigned char a;
   if((fp=fopen("srt.ovl","rb+"))==NULL)
     {
       printf("Error.\n");
       return(0);
     }
   fread(&a,1,1,fp);
   if(a==0) return 0;
   if(a>30) a=30;
   if(a!=0) a--;
   fseek(fp,0,SEEK_SET);
   fwrite(&a,1,1,fp);
   fclose(fp);
   return 1;
}