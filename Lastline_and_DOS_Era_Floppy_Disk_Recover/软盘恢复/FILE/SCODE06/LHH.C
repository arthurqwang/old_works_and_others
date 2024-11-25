#include <stdio.h>
#include <bios.h>
void anti_trace(void);
void can_trace(void);
int anti1,anti2,anti3,anti4,anti5,anti6,anti7,anti8,anti9;
unsigned char step_int_head,break_point_int_head;
main()
{
   FILE *fp;
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
      fprintf(fp,"OK");
  if(anti2 !=3 && anti4==1 ||anti5==1)
  if(anti1 !=1 ||anti6!=1) quit(0);
      fclose(fp);
  if(anti1 !=1 ||anti6!=1) quit(0);
      can_trace();
      execl("LH","LH",NULL);
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
}