/*MKHIGH.C  CHINESE VERSION 2.0  1993 12 21*/
/*Passed DOS 3.3a,DOS5.0,DOS 6.0 */
/*Passed computer type :GW286,DELL 433DE(486,1000M HD)*/
/*     Noname 286,ANTAI 286,AST 286,AT&T 386,COMPAQ 386/33(25)*/
#include <bios.h>
#include <time.h>
#include <stdlib.h>
main()
 {
   char BPB[512];
   int k;
   printf("Which drive ?[A:]\b\b\b");
kk:
   k=getch();
   if(!((toupper(k)=='A')||(toupper(k)=='B')))
     goto kk;
   printf("%c\n",toupper(k));
   if (absread(toupper(k)-'A',1,0,BPB))
    {
      biosdisk(0,toupper(k)-'A',0,0,0,0,0);
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
   if (abswrite(toupper(k)-'A',1,0,BPB))
    {
      biosdisk(0,toupper(k)-'A',0,0,0,0,0);
      printf("Error.\n");
      exit(1);
    }
   if (abswrite(toupper(k)-'A',1,2000,BPB))
    {
      biosdisk(0,toupper(k)-'A',0,0,0,0,0);
      printf("Error.\n");
      exit(1);
    }
 }