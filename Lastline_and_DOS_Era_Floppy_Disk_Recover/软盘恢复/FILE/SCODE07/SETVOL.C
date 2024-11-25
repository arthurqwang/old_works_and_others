#include <stdio.h>
#include <time.h>
#include <dos.h>
main()
{
   unsigned char rtn[2],vol[20],no[4];
   FILE *fp;
   struct date *dt,dtt;
   int floppy_no;
   dt=&dtt;
   if((fp=fopen("diskvol.dat","rt"))==NULL)
     {
       printf("File DISKVOL.DAT not found.\nCreating it...\n");
       if((fp=fopen("diskvol.dat","wt"))==NULL)
	 {
	   printf("Can't creat.\n");
	   exit(0);
	 }
       fprintf(fp,"\n95040700001\nn\n");
       fclose(fp);
     }
   fscanf(fp,"%s%s%s",rtn,vol,no);
   fclose(fp);
   floppy_no=atoi(vol+6)+1;
   if((fp=fopen("diskvol.dat","wt"))==NULL)
     {
       printf("File DISKVOL.DAT not found.\n");
       exit(0);
     }
   fprintf(fp,"\n");
   getdate(dt);
   fprintf(fp,"%2d%02d%02d",dt->da_year-1900,dt->da_mon,dt->da_day);
   fprintf(fp,"%05d\n",floppy_no);
   fprintf(fp,"n\n");
   fclose(fp);
   printf("Current Disk_NO : %2d%02d%02d",dt->da_year-1900,dt->da_mon,dt->da_day);
   printf("%05d\n",floppy_no);
}