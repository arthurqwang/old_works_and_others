/*******************************************************************
  File name:     MKHIGH.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          8/19/94
  Author:        WangQuan
  Function:      To make Chinese install disk.
  Usage:         X:\ANYPATH>Y:\ANYPATH\MKHIGH<CR>
		   X:,Y: = A:,B:,C:,D:...
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

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