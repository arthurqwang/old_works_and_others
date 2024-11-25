#include <stdio.h>
#include <ctype.h>
char *changetohz(char *num);
char dichz[300][100],dicnum[300][10],ch1=10,ch2=10,num[50];;
int tnum=0;
FILE *fp0,*fp1,*fp2,*fp3;
main()
{
  char *hz,f1[100],coma[100]="";
  int i=1,j=0;
  printf("***************************************************\n");
  printf("* Used to change files using small HZK into ones  *\n");
  printf("* using GB HZK.                                   *\n");
  printf("* It's the inverse operation of CHANGE.BAT        *\n");
  printf("* Following files are needed:                     *\n");
  printf("*    LSTDIC ,the dictionary file                  *\n");
  printf("*    SOURCE.C ,it includes files to be unchanged  *\n");
  printf("*       For example,it can include:               *\n");
  printf("*            mngrboot.c                           *\n");
  printf("*            fatrsave.c                           *\n");
  printf("*            {end}                                *\n");
  printf("*    Must end as {end}                            *\n");
  printf("* The program will save unchanged files with their*\n");
  printf("* old names,so you should copy the old files to a *\n");
  printf("* safe place.                                     *\n");
  printf("*                                                 *\n");
  printf("***************************************************\n");
  printf("\n Continue?[N]\b\b");
  if('Y'!=toupper(getch()))
   {
    exit(0);
    }
  printf("Y\n");
  if((fp0=fopen("source.c","rt"))==NULL)
     {
      printf("No SOURCE.C,the file includes name to be unchanged\n");
      exit(0);
     }
  if((fp2=fopen("lstdic","rt"))==NULL)
     {
      printf("No dictionary file LSTDIC .\n");
      exit(0);
     }

  while(1)
  {
    fscanf(fp2,"%s",dicnum[j]);
    fscanf(fp2,"%s",dichz[j]);
    if(dichz[j][0]==0 || dicnum[j][0]==0)
      break;
    j++;

  }
  printf("\n\nDoing...\n");
  tnum=j;
  fclose(fp2);
  while(1)
  {
   coma[0]=0;
   ch1=ch2=10;
   fscanf(fp0,"%s",f1);
   if(!strcmp(f1,"{end}")) break;
   printf("Unchanging %s ...\n",f1);
   strcat(coma,"copy ");
   strcat(coma,f1);
   strcat(coma," tempfi.fil >aaaaaa.aaa");
   system(coma);
   if((fp1=fopen("tempfi.fil","rt"))==NULL)
     {
       printf("Can not open a tempfile.\n");
       exit(0);
     }
   if((fp3=fopen(f1,"wt"))==NULL)
     {
       printf("Can not open %s.\n",f1);
       exit(0);
     }
  while(ch1!=EOF && ch2!=EOF)
   {
     ch1=fgetc(fp1);
     if(ch1==EOF) break;
     if(ch1!= '{')
       fputc(ch1,fp3);
     else
      {
       ch2=fgetc(fp1);
       if(ch2==EOF) break;
       if(!isdigit(ch2))
	 {
	   fputc(ch1,fp3);
	   fputc(ch2,fp3);
	 }
       else
	 {
	  num[0]=ch2;
	  while(isdigit((ch2=fgetc(fp1))))
	    {
	      num[i]=ch2;
	      i++;
	    }
	  num[i]=0;
	  i=1;
	  hz=changetohz(num);
	  fputs(hz,fp3);
	 }
   }
 }
 fclose(fp1);
 fclose(fp3);
 }
}

char *changetohz(char *num)
 {
  int l=0;
  for(l=0;l<=tnum;l++)
   {
    if(!strcmp(num,dicnum[l]))
      return dichz[l];
   }
  fputc(ch1,fp3);
  fputs(num,fp3);
  fputc(ch2,fp3);
  return 0;
 }
