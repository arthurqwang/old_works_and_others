#include <stdio.h>
main()
{
  FILE *fpp,*fp;
  unsigned char a;
  if((fpp=fopen("LHM.EXE","rb"))==NULL)
    {
      printf("Error open LHM.EXE\n");
      exit(0);
    }
  if((fp=fopen("LH95.dat","wb"))==NULL)
    {
      printf("Error open LH95.DAT\n");
      exit(0);
    }

  while(1)
     {
      fread(&a,1,1,fpp);
      if( feof(fpp)!=0) break;
      a=(~a)&0xFF;
      fwrite(&a,1,1,fp);
     }
  fclose(fpp);
  fclose(fp);
}
