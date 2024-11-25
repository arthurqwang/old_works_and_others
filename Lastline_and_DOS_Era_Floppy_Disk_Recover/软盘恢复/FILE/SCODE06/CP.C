#include <io.h>
#include <stdio.h>
#include <dir.h>
#include <dos.h>
void copy_a_file(char *source,char *dest);
void copy_more_Archive_file(char *source,char *dest);
main(int argc ,char *argv[])
{
  copy_more_Archive_file(argv[1],argv[2]);
}
void copy_more_Archive_file(char *source,char *dest)
/*
  When Path(source&dest) is dir (Exmp for:C:\\DOS),should write like this:
   "C:\\DOS\\" "D:\\"
*/
{
   struct ffblk ffblk;
   int dest_name_is_dir=0;
   unsigned char source_drive[3],source_dir[10],source_name[14],source_ext[5];
   unsigned char dest_drive[3],dest_dir[100],dest_name[14],dest_ext[5];
   unsigned char a_source_file_name[100],a_dest_file_name[100];
   fnsplit(source,source_drive,source_dir,source_name,source_ext);
   fnsplit(dest,dest_drive,dest_dir,dest_name,dest_ext);
   if(source_name[0]==0) strcpy(source_name,"*");
   if(source_ext[0]==0) strcpy(source_ext,".*");
   fnmerge(source,source_drive,source_dir,source_name,source_ext);
   if(dest_name[0]==0) dest_name_is_dir=1;

   if(findfirst(source,&ffblk,FA_ARCH))
     {
       printf("File not found.\n");
       exit(1);
     }
   if(dest_name_is_dir)
     {
       strcpy(dest_name,ffblk.ff_name);
     }
   fnmerge(a_source_file_name,source_drive,source_dir,ffblk.ff_name,"");
   fnmerge(a_dest_file_name,dest_drive,dest_dir,dest_name,"");
   copy_a_file(a_source_file_name,a_dest_file_name);
   while(1)
   {
   if(findnext(&ffblk))
     {
       exit(1);
     }
   if(dest_name_is_dir)
     {
       strcpy(dest_name,ffblk.ff_name);
     }
   fnmerge(a_source_file_name,source_drive,source_dir,ffblk.ff_name,"");
   fnmerge(a_dest_file_name,dest_drive,dest_dir,dest_name,"");
   copy_a_file(a_source_file_name,a_dest_file_name);
   }
}
void copy_a_file(char *source,char *dest)
{
    FILE *fp1,*fp2;
    unsigned char a;
    if((fp1=fopen(source,"rb"))==NULL)
      {
	printf("Error open source file.\n");
	exit(1);
      }
    if((fp2=fopen(dest,"wb"))==NULL)
      {
	printf("Error open dest file.\n");
	exit(1);
      }
    while(1)
     {
      fread(&a,1,1,fp1);
      if( feof(fp1)!=0) break;
      fwrite(&a,1,1,fp2);
     }
    fclose(fp1);
    fclose(fp2);
}