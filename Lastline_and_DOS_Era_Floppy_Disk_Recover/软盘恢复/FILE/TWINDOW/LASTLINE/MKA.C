#include <bios.h>
#include <time.h>
#include <stdlib.h>
main()
 {
   char BPB[512];
   if (absread(0,1,0,BPB))
    {
      biosdisk(0,0,0,0,0,0,0);
      printf("Error.\n");
      exit(1);
    }
   randomize();
   BPB[0x27]=random(0xff);
   BPB[0x28]=random(0xff);
   BPB[0x29]=random(0xff);
   BPB[0x2a]=random(0xff);

   BPB[0x2b]='W';
   BPB[0x2c]='Q';
   BPB[0x2d]='L';
   BPB[0x2e]='A';
   BPB[0x2f]='S';
   BPB[0x30]='T';
   BPB[0x31]='L';
   BPB[0x32]='I';
   BPB[0x33]='N';
   BPB[0x34]='E';
   if (abswrite(0,1,0,BPB))
    {
      biosdisk(0,0,0,0,0,0,0);
      printf("Error.\n");
      exit(1);
    }
   if (abswrite(0,1,2000,BPB))
    {
      biosdisk(0,0,0,0,0,0,0);
      printf("Error.\n");
      exit(1);
    }
 }