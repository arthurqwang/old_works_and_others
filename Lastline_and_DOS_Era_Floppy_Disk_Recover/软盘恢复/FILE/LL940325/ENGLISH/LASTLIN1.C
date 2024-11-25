/* LASTLIN1.c 1994 3 14, English version 2.0, */
/* Passed DOS 3.3a,DOS 5.0,DOS 6.0*/
/* Computer type passed:GW286,COMPAQ 386/33(25),AST 286*/
/*      Antai 286 ,At&t 386,DELL 433DE ,NONAME 286 ,so on*/
#include <stdio.h>
#include <dir.h>
#include <process.h>
#include <dos.h>
main(int argc ,char *argv[])
  {
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   execl("mngrboot","mngrboot",NULL);
  }
