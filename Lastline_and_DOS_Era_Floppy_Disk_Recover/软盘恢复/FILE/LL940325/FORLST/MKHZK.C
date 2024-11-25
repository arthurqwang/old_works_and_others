/* 1994 2 20. this one can creat a smaller chinese lib . */

#include <stdio.h>
main()
{
  unsigned char a[100],b[32],f1[100]="lsthz",f2[100]="cclib",f3[100]="lsth.inf",f4[100]="lstdic";
  unsigned h,j,q,w,len;
  long unsigned off,nextnum=0;
  FILE *fp1,*fp2,*fp3,*fp4;
  printf("Will creat files :\n");
  printf("Small-chinese-lib name: LSTH.INF\n");
  printf("Dictionary-file name for indexxing small-chinese-lib:LSTDIC\n ");
  printf("Wait a while...\n");
  if((fp1=fopen(f1,"rt"))==NULL)
    printf("Can not open file(s)\n");
  if((fp2=fopen(f2,"rb"))==NULL)
    printf("Can not open file(s)\n");
  if((fp3=fopen(f3,"wb"))==NULL)
    printf("Can not open file(s)\n");
  if((fp4=fopen(f4,"wt"))==NULL)
    printf("Can not open file(s)\n");
  fprintf(fp4,"%16d ",nextnum);
  while(!feof(fp1))
    {
     int i;
     fscanf(fp1,"%s",a);
     len=strlen(a)/2;
     nextnum += len*32+1;
     fprintf(fp4,a);
     fprintf(fp4,"\n");
     fprintf(fp4,"%16ld ",nextnum);

     fwrite(&len,1,1,fp3);
     for (i=0;i<len*2;i+=2)
     {
      q=a[i]-160;
      w=a[i+1]-160;
      h=(q-1)*94+(w-1);
      off=h*32L;
      fseek(fp2,off,SEEK_SET);
      fread(b,32,1,fp2);
      fwrite(b,32,1,fp3);
     }
    }
    fclose(fp1);
    fclose(fp2);
    fclose(fp3);
    fclose(fp4);
}
