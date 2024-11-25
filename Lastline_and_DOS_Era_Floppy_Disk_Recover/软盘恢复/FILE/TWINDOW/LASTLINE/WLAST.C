#include <bios.h>
#include <stdio.h>
void write_inf_to_file(void);
main()
  {
    write_inf_to_file();
  }
void write_inf_to_file(void)
 {
   FILE *fp;
   char inf[8192];
   if (biosdisk(2,0x80,0,0,2,16,inf))
     {
       biosdisk(0,0x80,0,0,0,0,0);
       printf("Error read infmation of harddisk.\n");
       exit(1);
     }

   if((fp=fopen("c:\\lastline.inf","rb+"))==NULL)
    {
      printf("Can not open LASTLINE.INF .\n");
      exit(1);
    }
   fseek(fp,1024,SEEK_SET);
   fwrite(inf,8192,1,fp);
   fclose(fp);
 }
