#include <bios.h>
#include <stdio.h>

main(int argc,char *argv[])
{
  int j;
  unsigned char a[9216];
   printf("Remove writed ptotect of floppy disk.\n");
   printf("Press any to continue...\n");
   getch();
   for(j=0;j<512;j++)
     a[j]=0;
   if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
     if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
       if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
	 if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
	   if(biosdisk(3,toupper(argv[1][0])-'A',1,79,14,1,a))
             {
	      printf("This floppy disk can not be used,or write protect floppy disk.\n");
	      exit(1);
	     }
   printf("OK.\n");
}
