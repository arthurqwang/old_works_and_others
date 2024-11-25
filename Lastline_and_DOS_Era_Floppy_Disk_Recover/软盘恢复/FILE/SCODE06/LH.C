
#include <stdio.h>
main()
{
  FILE *fp;
  unsigned char s[5];
  if((fp=fopen("LHKL.DAT","rt"))==NULL)
    {
      printf("LH.exe can not run.\n");
      exit(0);
    }
  fscanf(fp,"%s",s);
  fclose(fp);
  system("del LHKL.DAT>NUL");
  if( !memcmp(s,"OK",2))
    printf("Run LH.exe\n");
  else
    printf("LH.exe can not run.\n");
}