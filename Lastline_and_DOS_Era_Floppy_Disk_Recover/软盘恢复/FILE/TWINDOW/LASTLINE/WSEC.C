#include <stdio.h>
#include <dos.h>
main()
 {
   FILE * fp;
   char inf[8192];
   if((fp=fopen("c:\\lastline.inf","rb"))==NULL)
     {
       printf("Can not open LASTLINE.INF .\n");
       exit(1);
     }
   fseek(fp,1024,SEEK_SET);
   fread(inf,8192,1,fp);
   if(biosdisk(3,0x80,0,0,2,16,inf))
     {
       biosdisk(0,0x80,0,0,0,0,0);
       printf("Error save information for harddisk.\n");
       exit(1);
     }
 }
