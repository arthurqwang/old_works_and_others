#include <bios.h>
#include <stdio.h>

main(int argc,char *argv[])
{
  int i,sectspt,disk_no,j=0;
  unsigned char a[9216],bad_track_no[80];
  if(toupper(argv[1][0]) != 'A' && toupper(argv[1][0]) != 'B' )
    {
       printf("Usage:  MK A: 3 or MK B: 5 \n");
       exit(0);
    }
  if(toupper(argv[2][0]) != '3' && toupper(argv[2][0]) != '5' )
    {
       printf("Usage:  MK A: 3 or MK B: 5 \n");
       exit(0);
    }
  disk_no=toupper(argv[1][0])-'A';
  if(toupper(argv[2][0]) == '3')
     sectspt=18;
  else
     sectspt=15;
  for(i=0;i<80;i++)
  {
    printf("%02d\b\b",i);
    if(biosdisk(2,disk_no,1,i,1,sectspt,a))
      if(biosdisk(2,disk_no,1,i,1,sectspt,a))
	if(biosdisk(2,disk_no,1,i,1,sectspt,a))
	  if(biosdisk(2,disk_no,1,i,1,sectspt,a))
	    if(biosdisk(2,disk_no,1,i,1,sectspt,a))
	     {
	      bad_track_no[j]=(~(i^0x98))&0xFF;
	      j++;
	      continue;
	     }
  }
  printf("\n");
  if(j<3)
    {
      printf("Mark again,then format floppy disk.\n");
      exit(1);
    }
  bad_track_no[1]=bad_track_no[j-1];
  printf("\n");
  for(j=0;j<10;j++)
    printf("%02d ",((~bad_track_no[j]))^0x98)&0xFF;
  printf("\n");
  if(biosdisk(3,toupper(argv[1][0])-'A',1,79,15,1,bad_track_no))
    if(biosdisk(3,toupper(argv[1][0])-'A',1,79,15,1,bad_track_no))
      if(biosdisk(3,toupper(argv[1][0])-'A',1,79,15,1,bad_track_no))
	if(biosdisk(3,toupper(argv[1][0])-'A',1,79,15,1,bad_track_no))
	  if(biosdisk(3,toupper(argv[1][0])-'A',1,79,15,1,bad_track_no))
	    {
	      printf("This floppy disk can not be used.\n");
	      exit(1);
	    }
   for(j=0;j<512;j++)
     a[j]=0;
   if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
     if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
       if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
	 if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
	   if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
             {
	      printf("This floppy disk can not be used.\n");
	      exit(1);
	     }
}
