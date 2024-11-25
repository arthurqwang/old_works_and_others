#include <process.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <io.h>
main()
{
  FILE *fp1,*fp2,*fp3;
  long int p=0,pp=0,ppp=-1;
  int found=0;
  unsigned char f1[100]="temp1111.111",f2[100]="lsthz",f3[100]="",ch,chh;
  system("copy lsthz temp1111.111 >aaaaaaaa.aaa");
  printf("Sort chinese file gethered ,LSTHZ .\n");
  printf("Wait a whlie...");
  fp1=fopen(f1,"rt");
  fp2=fopen(f2,"wt");
  while(p>ppp)
    {
      found=0;
      fseek(fp1,p,SEEK_SET);
      fscanf(fp1,"%s",f1);
      ch=getc(fp1);
      ppp=p;
      p=ftell(fp1)-2;
      rewind(fp1);
      while(pp<p)
       { chh=0;
	 fscanf(fp1,"%s",f2);
	 pp=ftell(fp1);
	 if(!strcmp(f1,f2))
	  {
	    found++;
	    if (found==2)
	      break;
	  }
       }
       if(found<2)
	 {
	   chh++;
	   if(chh==2)
	       {fcloseall();exit(0);}
	   fputs(f1,fp2);
	   fputs("\n",fp2);
	 }
       }
     fcloseall();
    }