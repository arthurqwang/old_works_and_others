#include <stdio.h>
main()
{
  FILE *fp1,*fp2,*fp3;
  char f1[100],f2[100]="source.c";
  int ch1=0,ch2;
  printf("Gether chinese words from source files.\n");
  printf("Chinese file of result is LSTHZ  .\n");
  system("del lsthz");
  fp2=fopen("lsthz","at");
  fp3=fopen(f2,"rt");
  while(!feof(fp3))
  {
  fscanf(fp3,"%s",f1);
  if(!strcmp(f1,"{end}"))
     goto uu;
  printf(f1);
  printf("\n");
  fp1=fopen(f1,"rt");
  while(!feof(fp1))
   {
     if(((ch2=fgetc(fp1)&0xff)>160)&&((ch1&0xff)>160))
      {
	fputc(ch1&0xff,fp2);
	fputc(ch2&0xff,fp2);
	ch2=fgetc(fp1)&0xff;
	if(ch2<=160)
	  fputc('\n',fp2);
      }
     ch1=ch2&0xff;
   }
  fclose(fp1);
  }
uu:  fclose(fp2);
  fclose(fp3);
}