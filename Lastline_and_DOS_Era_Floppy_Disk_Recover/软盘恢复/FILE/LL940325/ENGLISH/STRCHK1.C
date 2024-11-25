/*STRCHK1.C  ENGLISH VERSION 2.0  1994 3 14*/
/*Passed DOS 3.3a,DOS5.0,DOS 6.0 */
/*Passed computer type :GW286,DELL 433DE(486,1000M HD)*/
/*     Noname 286,ANTAI 286,AST 286,AT&T 386,COMPAQ 386/33(25)*/
#include <process.h>
#include <stdio.h>
main()
 {
   system("c:\\lastline\\mngrboot/c");
   system("c:\\lastline\\fatrsave");
   /*system("c:\\lastline\\alwaysee");*/
   execl("c:\\lastline\\alwaysee","c:\\lastline\\alwaysee",NULL);
 }
