/* 1995 3 27 */
#include <bios.h>
#include <stdio.h>
#include <dos.h>
void write_pt(int cyl);
unsigned char sect[1024],boot[512];
int cyls,heads,sects;

main(int argc,char *argv[])
{
  int i,score=0,set_class;
  union REGS r;
  /*char fn_read_from_hd[20],fn_dos_default[20];
  FILE *fp_read_form_hd,*fp_dos_default;
  if((fp_read_from_hd=fopen(fn_read_from_hd,"rb"))==NULL)
    {
      printf("Error save source partition table.\n");
      exit(0);
    }
  if(biosdisk(2,0x80,0,0,1,1,boot))
   if(biosdisk(2,0x80,0,0,1,1,boot))
    if(biosdisk(2,0x80,0,0,1,1,boot))
     {
      printf("Error read source partition table.\n");
      exit(0);
     }
  fwrite(boot,1024,1,fp_read_from_hd);
  fclose(fp_read_from_hd);
  */
  printf("Set searching class:(1,2 or 3) ");
  scanf("%d",&set_class);
  if(set_class<1 || set_class>3)
    {
      printf("Owerflow class range,retry.\n");
      exit(0);
    }
  r.h.ah=8;
  r.h.dl=0x80;
  int86(0x13,&r,&r);
  if(r.h.ah)
   {
     printf("Hard disk not ready.\n");
     exit(0);
   }
  heads=r.h.dh+1;
  cyls=r.h.ch+256*(r.h.cl>>6)+1;
  sects=r.h.cl&0x3f;
  printf("Searching now,wait a while please...\n");
  for(i=1;i<cyls;i++)
    {
      if(kbhit()) exit(0);
      if(biosdisk(2,0x80,1,i,1,2,sect))
	if(biosdisk(2,0x80,1,i,1,2,sect))
	  if(biosdisk(2,0x80,1,i,1,2,sect))
	    {
	      sect[0]=sect[1]=sect[2]=sect[510]=sect[511]=0;
	      sect[512]=sect[513]=sect[514]=0;
	    }
      if( (sect[0]==0xeb && sect[2]==0x90) || (sect[0]==0xe9) ) score++;
      if( sect[510]==0x55 && sect[511]==0xaa ) score++;
      if( sect[512]==0xf8 && sect[513]==0xff && sect[514]==0xff) score++;
      if(score >= set_class)
	{
	  write_pt(i);
	  exit(0);
	}
    }
  write_pt(cyls);
}

void write_pt(int cyl)
{
   char ch;
   union cc {
	      char ch [2];
	      unsigned int i;
	    } c;
   union ll {
	      char ch[5];
	      long i;
	    } l;
   int i;
   unsigned char t1[16],t2[16];
   t1[0]=0x80;
   t1[1]=0x01;
   t1[2]=0x01;
   t1[3]=0x00;
   t1[4]=0x04;
   t1[5]=heads-1;
   c.i=cyl-1;
   t1[7]=c.ch[0];
   t1[6]=c.ch[1]<<6|sects;
   t1[8]=sects;
   t1[9]=0x00;
   t1[10]=0x00;
   t1[11]=0x00;
   l.i=(long)cyl*sects*heads-sects;
   t1[12]=l.ch[0];
   t1[13]=l.ch[1];
   t1[14]=l.ch[2];
   t1[15]=l.ch[3];
   if(cyl<cyls)
   {
   t2[0]=0;
   t2[1]=0;
   c.i=cyl;
   t2[2]=c.ch[1]<<6|1;
   t2[3]=c.ch[0];
   t2[4]=0x05;
   t2[5]=heads-1;
   c.i=cyls-1;
   t2[7]=c.ch[0];
   t2[6]=c.ch[1]<<6|sects;
   l.i=l.i+sects;
   t2[8]=l.ch[0];
   t2[9]=l.ch[1];
   t2[10]=l.ch[2];
   t2[11]=l.ch[3];
   l.i=(long)cyls*sects*heads-l.i;
   t2[12]=l.ch[0];
   t2[13]=l.ch[1];
   t2[14]=l.ch[2];
   t2[15]=l.ch[3];
   }
   else
     for(i=0;i<16;i++)
       t2[i]=0;
   printf("The partition table searched is: \n");
   for(i=0;i<16;i++)
     printf("%02X ",t1[i]);
   printf("\n");
   for (i=0;i<16;i++)
     printf("%02X ",t2[i]);
   printf("\nAre you sure you want to write?[N]\b\b");
   ch=getche();
   if(ch=='Y'||ch=='y')
     {
       if(biosdisk(2,0x80,0,0,1,1,boot))
	if(biosdisk(2,0x80,0,0,1,1,boot))
	 if(biosdisk(2,0x80,0,0,1,1,boot))
	   {
	     printf("Error read from source partition table.\n");
	     exit(0);
	   }
       for(i=0;i<0x10;i++)
	 {
	   boot[0x1be+i]=t1[i];
	   boot[0x1ce+i]=t2[i];
	 }
       boot[510]=0x55;
       boot[511]=0xaa;
       if(biosdisk(3,0x80,0,0,1,1,boot))
	if(biosdisk(3,0x80,0,0,1,1,boot))
	 if(biosdisk(3,0x80,0,0,1,1,boot))
	   {
	     printf("Error update partition table.\n");
	     exit(0);
	   }
       printf("\n\nOK.Reboot to try...");
     }
}