#include <fcntl.h>
#include <stdio.h>
#include <io.h>
main()
{
  FILE *fp1,*fp2,*fp3,*fp0;
  char f0[100]="source.c",f1[100]="temp1111.111",f2[100],f3[100]="lstdic",fff[100]="";
  int ch1=1990,ch2,j,fptem,isre=0;
  long unsigned ind=0,ind2=0,len;
  printf(" Change source file(s) with real HZK into ones \nwith small HZ lib made by yourself.\n");
  fp0=fopen(f0,"rt");
  while(!feof(fp0))
  {
  printf("\n");
  ch1=10;isre=0;
  ind=0;ind2=0;
  fff[0]=0;
  strcpy(f1,"temp1111.111");
  strcpy(f3,"lstdic");
  fscanf(fp0,"%s",f2);
  if(!strcmp(f2,"{end}"))
     goto kkk;
  printf("\n%s\n",f2);
  strcat(fff,"copy ");
  strcat(fff,f2);
  strcat(fff," temp1111.111>aaaaaaaa.aaa");
  system(fff);
  fp1=fopen(f1,"rt");
  fp2=fopen(f2,"wt");
  fp3=fopen(f3,"rt");
  fptem=open(f1,O_RDONLY|O_TEXT);
  len=filelength(fptem);
  close(fptem);
  printf("       of %ld bytes.\r",len);
k:while(ch1!=EOF)
   {
     if((ind-ind2)==100)
       {
	printf("%ld\r",ind);
	ind2=ind;
       }
     ind++;
     ch2=ch1;
     ch1=fgetc(fp1);
     if((ch2<=160))
       fputc(ch2,fp2);
     else
      {
       j=0;
       while((ch2)>160)
	  {
	    f1[j]=ch2;
	    j++;
	    ch2=ch1;
	    ch1=fgetc(fp1);
	  }
       f1[j]=0;
       while(1)
	 {
	   if(feof(fp3))
	     {
	       rewind(fp3);
	       isre++;
	       if(isre>1)
		 {
		   printf("%d",ind);
		   printf("\n  Chinese string %s not found.\n",f1);
		   printf("       of %ld bytes.\r",len);
		   goto k;
		 }
	     }
	   fscanf(fp3,"%s",f2);
	   fscanf(fp3,"%s",f3);
	   if(!strcmp(f1,f3))
	     {
	      isre=0;
	      fputc('{',fp2);
	      fprintf(fp2,f2);
	      fputc('}',fp2);
	      fputc(ch2,fp2);
	      break;
	     }
	 }

   }
  }
kk:
  fclose(fp1);
  fclose(fp2);
}
kkk:  fclose(fp3);
  printf("\n");
}