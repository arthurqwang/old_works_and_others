

/*MNGRBOOT.C  CHINESE VERSION 2.0  1994 3 25*/
/*Passed DOS 3.3a,DOS5.0,DOS 6.0 */
/*Passed computer type :GW286,DELL 433DE(486,1000M HD)*/
/*     Noname 286,ANTAI 286,AST 286,AT&T 386,COMPAQ 386/33(25)*/
/********************************************************/
#include "twingra.h"
#include <fcntl.h>
#include <io.h>
#include <conio.h>
#include <string.h>
#include <bios.h>
#include <dos.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include <dir.h>
#define BPS 512
#define HEAD (int)part[i]&0xff
#define SECTOR (int)part[i+1]&0xff
#define TRACK (int)part[i+2]&0xff
#define THISDISKEXIST (((int)part[i]&0xff)!=0)||(((int)part[i+1]&0xff)!=0)||(((int)part[i+2]&0xff)!=0)
#define DISKRESET biosdisk(0,drive,0,0,0,0,0)
void readmainboot(int drive);
void readdosboot(int drive,int head,int sector,int track,int isector);
void writemainboot(int drive);
void writedosboot(int drive,int head,int sector,int track,int isector);
void loadmainboot(int drive);
void loadmainbootagain(int drive);
void loaddosboot(int drive,int isector);
void loaddosbootagain(int drive,int isector);
void savemainboot(int drive);
void savemainbootagain(int drive);
void savedosboot(int drive,int isector);
void savedosbootagain(int drive,int isector);
int loadparttable(int drive);
int loadparttableagain(int drive);
int  readparttable(int way);
void saveparttable(int drive);
void saveparttableagain(int drive);
void infwq(void);
unsigned check_lock(int drive);
void get_BK(void);
void check_sec(void);
int getdosnum(void);
void reboot(void);
void puticon(int lgdrive);
char part[BPS],boot[BPS];
char dvr[10]="A:*.*";
int  BKTRACK,BKHEAD;
extern int high_of_char,CCILB;
WINGRA *inf,*icon;
void main(int argc,char *argv[])
 {
   short unsigned int drive=0x80,isector,i,key;
   unsigned char path_of_HZK[30];
   if(argc==1)  /* when reparing */
    strcpy(path_of_HZK,"\\lsth.inf");
   else
    strcpy(path_of_HZK,"c:\\lastline\\lsth.inf");
   dvr[0]=toupper(argv[0][0]);
   title(path_of_HZK);
   icon=open_win(8,10,12,70,1,0);
   inf=open_win(14,10,24,70,1,1);
   if((argc==2 && strcmp(strupr(argv[1]),"/C") &&
       strcmp(strupr(argv[1]),"/B") && strcmp(strupr(argv[1]),"/?"))||(argc>2))
     {
       puthz(icon," {0} ",14,1);
       high(95,high_of_char*10+5,190,high_of_char*10+7,3,1);
       puthz(inf,"    {129}:    MNGRBOOT [ [/C] or [/B] or [/?] ]\n",14,1);
       puthz(inf,"{194}...",15,1);
       getch();
       printf("\x7");
       exit(1);
     }
   anti_trace();
   get_BK();
   if(argc==1)
     {
      int sig=0;
      check_sec();
      puthz(icon,"{387}",14,1);
      high(95,high_of_char*10+5,205,high_of_char*10+7,3,1);
      puticon(0);
      puthz(inf," {580}?[Y]\b\b",14,1);/*Replace MAIN BOOT RECORD?[Y]\b\b*/
k1:   key=getch();
      printf("\x7");
      if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
          goto k1;
      if(toupper(key)!='N')
        {
          sig=1;
          loadmainboot(drive);
          writemainboot(drive);
	  puthz(inf,"\n {869}.\n",14,1);/*Successful.*/
        }
      else
        puthz(inf,"N\n",14,1);
      if(!loadparttable(drive))
        readparttable(0);
      i=1;isector=8;
      while((THISDISKEXIST)&&(isector>1))
        {
	  puticon(10-isector);
	  puthz(inf," {998} ",14,1);
	  boot[0]=75-isector;
	  boot[1]=':';
	  boot[2]=0;
	  puthz(inf,boot,15,1);
	  puthz(inf," {1127}DOS{1192}?[Y]\b\b",14,1);/*Replace DOS BOOT RECORD for logical disk %c:?[Y]\b\b  {1127}DOS{1192}?*/
k2:       key =getch();
	  printf("\x7");
          if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
             goto k2;
          if(toupper(key)!='N')
            {
              sig=1;
              loaddosboot(drive,isector);
              writedosboot(drive,HEAD,SECTOR,TRACK,isector);
	      puthz(inf,"\n {869}.\n",14,1);/* Successful.*/
            }
          else
            puthz(inf,"N\n",14,1);
          isector--;i+=3;
        }
      if(sig==1)
        {
	 puthz(inf,"\n{1321}A{1482} LASTLINE {1579},{1612}.\n",15,1);/*Now, DO NOT remove the disk in drive A: and reboot...*/
	 puthz(inf,"{194}...",15,1);
	 getch();
         printf("\x7");
         printf("\n");
         reboot();
        }
      else
	puthz(inf,"{194}...",15,1);
      getch();
      printf("\x7");    /*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
   }
   if(!strcmp(strupr(argv[1]),"/C"))
     {
       char tpart[BPS],tboot[BPS];
       int sig=0;
       puthz(icon,"{1837}",14,1);
       high(100,high_of_char*10+5,200,high_of_char*10+7,3,1);
       puticon(0);
       readmainboot(drive);
       memcpy(tpart,part,BPS);
       loadmainboot(drive);
       if(memcmp(tpart,part,BPS))
         {
          printf("\x7\x7\x7");
	  puthz(inf,"  {2030}!\n",14,1);
	  puthz(inf,"  {998}?[Y]\b\b",14,1);/*MAIN BOOT RECORD has been changed!*//*Update with original copy? [Y]*/
kkk:      key=getch();
	  printf("\x7");
          if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
             goto  kkk;
          if(toupper(key)!='N')
            {
              sig=1;
              writemainboot(drive);
	      puthz(inf,"\n  {869}.\n",14,1);/*Successful.*/
            }
          else
            puthz(inf,"N\n",14,1);
         }
       else
	puthz(inf,"{2319}.\n",14,1);/*MAIN BOOT RECORD OK.*/
       if(!loadparttable(drive))
         readparttable(0);
       i=1;isector=8;
       puthz(inf,"DOS {2544}:\n   ",15,1);
       while((THISDISKEXIST)&&(isector>1))
         {
	  puticon(10-isector);
	  readdosboot(drive,HEAD,SECTOR,TRACK, isector);
          memcpy(tboot,boot,BPS);
          loaddosboot(drive,isector);
          if(memcmp(tboot,boot,BPS))
           {
	     printf("\x7\x7\x7");
	     puthz(inf,"\n  {2737} ",14,1);
	     tboot[0]=75-isector;
	     tboot[1]=':';
	     tboot[2]=0;
	     puthz(inf,tboot,14,1);
	     puthz(inf," {2834},{998}?[Y]\b\b",14,1);/*Logical disk %c:     DOS BOOT RECORD has been changed!\n", 75-isector  DOS{2963}*/
							  /*Update with original copy? [Y]*/
k3:          key=getch();
             printf("\x7");
             if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
               goto k3;
             if(toupper(key)!='N')
               {
                 sig=1;
                 writedosboot(drive,HEAD,SECTOR,TRACK, isector);
		 puthz(inf,"\n  {869}.",14,1);/*{869}Successful.*/
               }
             else
	       puthz(inf,"N",14,1);
           }
	  else
	    {
	     tboot[0]=75-isector;
	     tboot[1]=':';
	     tboot[2]=0;
	     puthz(inf,tboot,11,1);
	     puthz(inf,"{3220} ",14,1);
	    }          /*{2737} Logical disk %c:     DOS BOOT RECORD OK.\n", 75-isector*/
           isector--;i+=3;
         }
       if(sig==1)
        {
	 puthz(inf,"\n  {3285},{3350},{3639}.\n",15,1);
	 puthz(inf,"  {3864}...",15,1);/*Now,you should reboot,then check virus for hard disk.*/
						/*Press any key to reboot...*/
	 getch();
         printf("\x7");
         printf("\n");
         reboot();
        }
/*       else
	 puthz(inf,"\n{194}...",15,1);*//*Press any key to continue...*/
     }

   if(!strcmp(strupr(argv[1]),"/B"))
     {
       if(check_lock(drive)==0) exit(1);
       puthz(icon,"{4089}",14,1);
       high(95,high_of_char*10+5,237,high_of_char*10+7,3,1);
       puthz(inf,"  {4346}.\n",14,1);
       puthz(inf,"  {4763}?[Y]\b\b",14,1);
			 /*BOOT RECORD backup.*/
			 /*Confirm that the operational system is normal,please.*/
			 /*Are you sure?[N]*/
k4:    key=getch();
       printf("\x7");
       if(!((toupper(key)=='N')||(toupper(key)=='Y')||(key==13)))
          goto k4;
       if(toupper(key)=='N')
	  {
	   puthz(inf,"N\n",14,1);
	   puthz(inf,"\n  {194}...",15,1);
				    /*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	   getch();
           printf("\x7");
           exit(0);
	  }
       puthz(inf,"Y\n",14,1);
       readmainboot(drive);
       savemainboot(drive);
       i=1;isector=8;
       if (!readparttable(1))
         {
	   puthz(inf,"\n{4924}\n",14,1);
	   puthz(inf,"{194}...",15,1);
			       /*Can't find partition information.*/
			       /*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	   getch();
           printf("\x7");
           exit(1);
         }
       saveparttable(drive);
       while((THISDISKEXIST)&&(isector>1))
         {
           readdosboot(drive,HEAD,SECTOR,TRACK,isector);
           savedosboot(drive,isector);
           isector--;i+=3;
         }
       puthz(inf,"  {5213}.",14,1);
		/*Successful.\n  Over.*/
       puthz(inf,"\n  {194}...",15,1);
       getch();
       printf("\x7");
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
     }

   if(!strcmp(argv[1],"/?"))
     {
       if(check_lock(drive)==0) exit(1);
       puthz(icon,"MNGRBOOT, {5342}",14,1);
       high(95,high_of_char*10+5,317,high_of_char*10+7,3,1);
		/*MNGRBOOT is a manager of BOOT RECORD.*/
       puthz(inf,"{129}:\n",15,1);
		/*Usage:*/
       puthz(inf," MNGRBOOT    {387}",14,1);
		/*MNGRBOOT     Update BOOT RECORD.*/
       puthz(inf,"     MNGRBOOT/C  {5599}\n",14,1);
		/*MNGRBOOT/C   Compare BOOT RECORD.*/
       puthz(inf," MNGRBOOT/B  {5792}    ",14,1);
		/*MNGRBOOT/B   Backup BOOT RECORD.*/
       puthz(inf," MNGRBOOT/?  {5985}\n",14,1);
		/*MNGRBOOT/?   Help for MNGRBOOT.*/
       puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
       getch();
       printf("\x7");
		/*{194}...*/
     }
   can_trace();
   restorecrtmode();
   exit(0);
 }
void readmainboot(int drive)
  {
    if(biosdisk(2,drive,0,0,1,1,part))
      {
        DISKRESET;
	puthz(inf,"\n{6050}\n",14,1);
		/*Error read MAIN BOOT RECORD.*/
	puthz(inf,"{194}...",14,1);

		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	getch();
        printf("\x7");
        exit(1);
      }
  }

void readdosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(2,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n{6307}DOS {6340}\n",14,1);
		/*Error read DOS BOOT RECORD for logical disk %c:.\n",75-isector*/
       puthz(inf,"{194}...",14,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
       getch();
       printf("\x7");
       exit(1);
      }
   }


void writemainboot(int drive)
  {
    if(biosdisk(3,drive,0,0,1,1,part))
      {
        DISKRESET;
	puthz(inf,"\n{6533}\n",14,1);
		/*Error update MAIN BOOT RECORD.*/
	puthz(inf,"{194}...",14,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	getch();
        printf("\x7");
        exit(1);
      }
  }

void writedosboot(int drive,int head,int sector,int track ,int isector)
  {
    if (biosdisk(3,drive,head,track,sector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n{6822}DOS {6340}\n",14,1);
		/*{2737}    Error update DOS BOOT RECORD to logical disk %c:.\n",75-isector*/
       puthz(inf,"{194}...",14,1);
		/*{194}...BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
       getch();
       printf("\x7");
       exit(1);
      }
   }

void loadmainboot(int drive)
  {
    int isfail=0;
    if(biosdisk(2,drive,0,0,9,1,part))
      {
        isfail=1;
        DISKRESET;
	puthz(inf,"\n{6887}\n",14,1);
		/*Error read the copy of MAIN BOOT RECORD.*/
	puthz(inf,"{194}...",14,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to retry...*/
	getch();
        printf("\x7");
        part[510]=0;
        part[511]=0;
      }
    if((part[510]!='W')||(part[511]!='Q'))
       isfail=1;
    else
       {
         if(biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
           {
              DISKRESET;
	      puthz(inf,"\n{7304}\n",14,1);
		/*Error save MAIN BOOT RECORD.*/
	      puthz(inf,"{194}...",14,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	      getch();
              printf("\x7");
            }
         part[510]=0x55;
         part[511]=0xAA;
       }
    if(isfail)
      loadmainbootagain(drive);
  }

void loadmainbootagain(int drive)
  {
    if(biosdisk(2,drive,BKHEAD,BKTRACK,9,1,part))
      {
        DISKRESET;
		  /*      puthz(inf,"  Error read the copy of MAIN BOOT RECORD again.\n",14,1);*/
	infwq();
      }
    if((part[510]!='W')||(part[511]!='Q'))
       infwq();
    else
      {
       if(biosdisk(3,drive,0,0,9,1,part))
         {
           DISKRESET;
	   puthz(inf,"\n{7304}\n",14,1);
	   puthz(inf,"{7657},{7978}\n",14,1);
	   puthz(inf,"    C:\\LASTLINE\\MNGRBOOT/C\n",14,1);
	   puthz(inf,"    C:\\LASTLINE\\FATRSAVE",14,1);
		/*Error save MAIN BOOT RECORD.*/
		/*You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.*/
	   puthz(inf,"\n{194}...",14,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	   getch();
           printf("\x7");
         }
       part[510]=0x55;
       part[511]=0xAA;
      }
  }

void loaddosboot(int drive,int isector)
  {
    int isfail=0;
    if (biosdisk(2,drive,0,0,isector,1,boot))
      {
       isfail=1;
       DISKRESET;
       puthz(inf,"\n{8267} DOS {8332}\n",14,1);
		/*{2737}   Error read the copy of DOS BOOT RECORD from logical disk %c:.\n",75-isector*/
       puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to retry...*/
       getch();
       printf("\x7");
       if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
         boot[3]='I';
       else
         boot[3]='M';
       boot[510]=0x55;boot[511]=0xAA;
      }
    if((boot[3]!='W')||(boot[510]!='W')||(boot[511]!='Q'))
       isfail=1;
    else
       {
        if(biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
           {
              DISKRESET;
	      puthz(inf,"\n{8653}DOS {8718}\n",14,1);
		/*Error save DOS BOOT RECORD.*/
	      puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	      getch();
              printf("\x7");
            }
        if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
          boot[3]='I';
       else
          boot[3]='M';
        boot[510]=0x55;boot[511]=0xAA;
       }
    if(isfail)
       loaddosbootagain(drive,isector);
   }


void loaddosbootagain(int drive,int isector)
  {
    if(biosdisk(2,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
        DISKRESET;
        infwq();
      }
    if((boot[3]!='W')||(boot[510]!='W')||(boot[511]!='Q'))
       infwq();
    else
      {
       if(biosdisk(3,drive,0,0,isector,1,boot))
         {
           DISKRESET;
	   puthz(inf,"\n{8653}DOS {8718}\n",14,1);
	   puthz(inf,"{7657},{7978}\n",14,1);
	   puthz(inf,"      C:\\LASTLINE\\MNGRBOOT/B  \n",14,1);
	   puthz(inf,"      C:\\LASTLINE\\FATRSAVE   \n",14,1);
		/*{2737}   Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector*/
		/*You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.*/
	   puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	   getch();
           printf("\x7");
         }
       if(((toupper(boot[4]))=='B')&&((toupper(boot[5]))=='M'))
          boot[3]='I';
       else
          boot[3]='M';
       boot[510]=0x55;
       boot[511]=0xAA;
      }
  }
void savemainboot(int drive)
  {
    part[510]='W';part[511]='Q';
    if(biosdisk(3,drive,0,0,9,1,part)||biosdisk(3,drive,BKHEAD,BKTRACK,9,1,part))
      {
        DISKRESET;
	puthz(inf,"\n{7304}\n",14,1);
		/*Error save MAIN BOOT RECORD.*/
	puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	getch();
        printf("\x7");
        exit(1);
      }
  }
void savedosboot(int drive,int isector)
  {
    boot[3]='W';boot[510]='W';boot[511]='Q';
    if (biosdisk(3,drive,0,0,isector,1,boot)||biosdisk(3,drive,BKHEAD,BKTRACK,isector,1,boot))
      {
       DISKRESET;
       puthz(inf,"\n{8653}DOS {6340}\n",14,1);
		/*{2737}    Error save DOS BOOT RECORD for logical disk %c:.\n",75-isector*/
       puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
       getch();
       printf("\x7");
       exit(1);
      }
   }


void saveparttable(int drive)
  {
    part[0]='W';part[511]='Q';
    if(biosdisk(3,drive,0,0,10,1,part)||biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
      {
        DISKRESET;
	puthz(inf,"\n{8975}\n",14,1);
		/*Error save partition information.*/
	puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	getch();
        printf("\x7");
        exit(1);
      }
  }

/*void writeparttable(int drive)
  {
    if(biosdisk(3,drive,0,0,10,1,part))
      {
        DISKRESET;
        puthz(inf,"  Error update partition information.\n",14,1);

        puthz(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...",14,1);
	getch();
        printf("\x7");
        exit(1);
      }
  }     */


int loadparttable(int drive)   /*1=successful 0=flaure*/
  {
    int isfail=0;
    if(biosdisk(2,drive,0,0,10,1,part))
      {
        isfail=1;
        DISKRESET;
	puthz(inf,"\n{9296}\n",14,1);
		/*Error read partition information.*/
	puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to retry...*/
	getch();
        printf("\x7");
        part[0]=0;part[511]=0;
      }
    if((part[0]!='W')||(part[511]!='Q'))
        isfail=1;
    else
      {
        if(biosdisk(3,drive,BKHEAD,BKTRACK,10,1,part))
           {
              DISKRESET;
	      puthz(inf,"\n{8975}\n",14,1);
		/*Error save partition information.*/
	      puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	      getch();
              printf("\x7");
            }
        return(1);
      }
    if(isfail)
      return(loadparttableagain(drive));
  }

int loadparttableagain(int drive)   /*1=successful 0=flaure*/
  {
    int back=1;
    if(biosdisk(2,drive,BKHEAD,BKTRACK,10,1,part))
      {
        DISKRESET;
	puthz(inf,"\n{9296}\n",14,1);
		/*Error read partition information again.*/
        back=0;
        part[0]=0;part[511]=0;
      }
    if((part[0]!='W')||(part[511]!='Q'))
        back=0;
    else
      {
        if(biosdisk(3,drive,0,0,10,1,part))
          {
            DISKRESET;
	    puthz(inf,"\n{8975}  \n",14,1);
	    puthz(inf,"{7657},{7978}\n",14,1);
	    puthz(inf,"      C:\\LASTLINE\\MNGRBOOT/B\n",14,1);
	    puthz(inf,"      C:\\LASTLINE\\FATRSAVE\n",14,1);
		/*Error save partition information. */
		/*You should clean viruses for your harddisk,\n  then enter MNGRBOOT/B at command line.*/
	    puthz(inf,"{194}...",15,1);
		/*BLUE,WHITE,BRIGHT,"\n  Press any key to continue...*/
	    getch();
            printf("\x7");
          }
        back=1;
      }
      return(back);
  }

/*int readparttable(int way)  way=1 read&backup ,way=0 only read
  {
    long unsigned i=0x5bf,fl;
    int k,l=1,fd,DOS_NO;
    char nm[20]="c:\\aaaaaa.aaa",cmd[50]="mkimg/partn<"  ;
    FILE *fp;
    if(way)
      {
       _chmod("c:\\partinfm.lst",1,FA_ARCH);
       remove("c:\\partinfm.lst");
       if((fp=fopen(nm,"w"))==NULL)
         {
	   puthz(inf,"\n{9296}\n",14,1);
	   puthz(inf,"{194}...",15,1);
	   getch();
           printf("\x7");
           exit(1);
         }
       fputc('c',fp);fputc(13,fp);
       fclose(fp);
       strcat(cmd,nm);
       strcat(cmd," >");
       strcat(cmd,nm);
       system(cmd);
       system("exit");
       remove(nm);
      }
   if((DOS_NO=getdosnum())<5)
   {
    if((fd=open("c:\\partinfm.lst",O_RDONLY))==-1)
      return(0);
    fl=filelength(fd);
    if ((fp=fopen("c:\\partinfm.lst","rb"))==NULL)
      return (0);
    for(;i<fl;i+=0x200)
      {
       fseek(fp,i,SEEK_SET);
       for(k=0;k<3;k++)
        {
          part[l]=fgetc(fp)&0xff;
          l++;
        }
      }
    part[l]=0;part[l+1]=0;part[l+2]=0;
    _chmod("c:\\partinfm.lst",1,FA_HIDDEN);
    return (1);
  }
  else
   {
    i=0x209;
    if ((fp=fopen("c:\\partinfm.lst","rb"))==NULL)
      return (0);
    for(;i<0x2f9;i+=0x10)
      {
       fseek(fp,i,SEEK_SET);
       for(k=0;k<3;k++)
        {
          part[l]=fgetc(fp)&0xff;
          l++;
        }
      }
    _chmod("c:\\partinfm.lst",1,FA_HIDDEN);
    return (1);
  }
 }
*/
/*int readparttable(int way)
  {
    int l=1,drive=0x80;
    unsigned char temp[20]={0}1,0};
    unsigned char tsec[512];
    while((temp[0]!=0)||(temp[1]!=0)||(temp[2]!=0))
      {
	 if(biosdisk(2,0x80,temp[0],temp[2],temp[1],1,tsec))
	   {
	     DISKRESET;
	     return(0);
	   }
	 part[l]=tsec[0x1BF]&0xff;
	 part[l+1]=tsec[0x1C0]&0xff;
	 part[l+2]=tsec[0x1C1]&0xff;
	 temp[0]=tsec[0x1CF]&0xff;
	 temp[1]=tsec[0x1D0]&0xff;
	 temp[2]=tsec[0x1D1]&0xff;
	 l+=3;
      }
    part[l]=part[l+1]=part[l+2]=0;
    return(1);
 }      */
int readparttable(int way)
  {
    int l=1,drive=0x80,indct=0x1c2;
    unsigned char temp[20],tsec[512];
    if(biosdisk(2,0x80,0,0,1,1,tsec))
      {
	DISKRESET;
	return(0);
      }
    while(indct<=0x1f2)
      {
	if((tsec[indct]==1)||(tsec[indct]==4)||(tsec[indct]==6))
	  {
	    part[l]=tsec[indct-3]&0xff;
	    part[l+1]=tsec[indct-2]&0xff;
	    part[l+2]=tsec[indct-1]&0xff;
	    l+=3;
	    break;
	  }
	else
	  indct += 0x10;
      }
    indct=0x1c2;
    temp[0]=temp[1]=temp[2]=0;
    while(indct<=0x1f2)
      {
	if(tsec[indct]==5)
	  {
	    temp[0]=tsec[indct-3]&0xff;
	    temp[1]=tsec[indct-2]&0xff;
	    temp[2]=tsec[indct-1]&0xff;
	    break;
	  }
	else
	  indct += 0x10;
      }
    while((temp[0]!=0)||(temp[1]!=0)||(temp[2]!=0))
      {
	 if(biosdisk(2,0x80,temp[0],temp[2],temp[1],1,tsec))
	   {
	     DISKRESET;
	     return(0);
	   }
	 part[l]=tsec[0x1BF]&0xff;
	 part[l+1]=tsec[0x1C0]&0xff;
	 part[l+2]=tsec[0x1C1]&0xff;
	 temp[0]=tsec[0x1CF]&0xff;
	 temp[1]=tsec[0x1D0]&0xff;
	 temp[2]=tsec[0x1D1]&0xff;
	 l+=3;
      }
    part[l]=part[l+1]=part[l+2]=0;
    return(1);
 }

void infwq(void)
 {
   printf("\x7\x7\x7",14,1);
	/*   wprintf(inf,"\n     The copy of structure information of hard disk has \n",14,1);
	wprintf(inf,"  been changed!!! Now,you must scan and clearn hard disk\n");
	wprintf(inf,"  for virus,and confirm that your hard disk is normal,then\n");
	wprintf(inf,"  you should backup again. For backup,enter MNGRBOOT/B at\n  command line.\n\n");
	*/
   inf=open_win(14,10,24,70,1,1);
   clr_win(inf,1);
   puthz(inf,"{9617},{9842},{10259}\n",14,1);
   puthz(inf,"{10292}:\n",14,1);
   puthz(inf,"   C:\\LASTLINE\\MNGRBOOT/B \n",14,1);
   puthz(inf,"   C:\\LASTLINE\\FATRSAVE  \n",14,1);
   puthz(inf,"{10709},{3639},{10774}.",14,1);

	/*   wclrprintf(inf,BLUE,WHITE,BRIGHT,"\n  Press any key to continue...");*/
   puthz(inf,"\n{194}...",15,1);
   getch();
   printf("\x7");
   exit(1);
 }
unsigned check_lock(int drive)
  {
    int i;
    FILE *fp;
    char end_inf[20];
    if((fp=fopen("c:\\lastline\\lastline.cfg","rb"))==NULL)
      {
	puthz(inf,"\n{10999}.",14,1);
		/*No installing.*/
        exit(1);
      }
    fread(end_inf,3,1,fp);
    fclose(fp);
    for (i=0;i<3;i++)
       end_inf[i]=~(end_inf[i]);
    if(biosdisk(2,drive,0,0,1,1,boot))
      {
        biosdisk(0,drive,0,0,0,0,0);
	puthz(inf,"\n{11160}",14,1);
        exit(1);
      }
    if((boot[0x1c3]==end_inf[0])&&(boot[0x1c4]==end_inf[1])&&(boot[0x1c5]==end_inf[2]))
      return (1);
    else
      {
	puthz(inf,"\n{11225}",14,1);
		/*Unlawful user or unlocking.*/
	exit(1);
      }
    return(0);
    }
/*void get_BK(void)
 {
   unsigned HD_base_table_adr[4],temp[3];
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-1;
   BKHEAD=(temp[2]&0xff)-1;
   if(BKTRACK > 0x3FF)
     BKTRACK=0x3FF;
  }*/
void get_BK(void)
 {
   unsigned char tttt[512];
   unsigned HD_base_table_adr[4],temp[3],a=0,b=0x400;
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-1;
   BKHEAD=(temp[2]&0xff)-1;
   if(BKTRACK > 0x3FF)
    {
      BKTRACK=0x3FF;
      if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
       {
	BKTRACK=0x200;
	while( (b-a)>1 )
	 {
	   if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
	      b=BKTRACK;
	   else
	   a=BKTRACK;
	   BKTRACK=(a+b)/2;
	 }
       }
    }
}

void check_sec(void)
 {
   struct ffblk ffb;
   findfirst(dvr,&ffb,FA_LABEL);
   if(strcmp(ffb.ff_name,"WQLASTLI.NE"))
   {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     puthz(inf,"\n{11225}",14,1);
     exit(1);
    }
   if(absread(toupper(dvr[0])-'A',1,0,boot))
    if(absread(toupper(dvr[0])-'A',1,0,boot))
     if(absread(toupper(dvr[0])-'A',1,0,boot))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       puthz(inf,"\n{11160}.",14,1);
       exit(1);
     }
   if(absread(toupper(dvr[0])-'A',1,2000,part))
    if(absread(toupper(dvr[0])-'A',1,2000,part))
     if(absread(toupper(dvr[0])-'A',1,2000,part))
     {
       biosdisk(0,toupper(dvr[0])-'A',0,0,0,0,0);
       puthz(inf,"\n{11160}.",14,1);
       exit(1);
     }
   if(memcmp(boot,part,512))
    {
     biosdisk(3,toupper(dvr[0])-'A',0,0,1,0xff,part+0x91);
     puthz(inf,"\n{11225}",14,1);
		/* Unlawful user or unlocking.*/
     exit(1);
    }
 }
int getdosnum(void)
 {
      union REGS in,out;
      in.h.ah=0x30;
      intdos(&in,&out);
      return(out.h.al);
 }
void reboot(void)
 {
     union REGS in,out;
     restorecrtmode();
     system("cls");
     int86(0x19,&in,&out);
 }

void puticon(int lgdrive)/* lgdrive=0,put main boot record icon */
 {
   int i;
   char a[2]="C";
   static int x=220;
   setfillstyle(1,1);
   high(x,high_of_char*8+2,x+30,high_of_char*10,1,1);
   nohigh(x+1,high_of_char*8+3,x+29,high_of_char*10-1,1,1);
   setcolor((lgdrive==0)?15:(16-lgdrive));
   for (i=high_of_char*9+4;i>high_of_char*9-6;i-=2)
   fillellipse(x+15,i,8,4);
   fillellipse(x+15,i+2,4,2);
   setfillstyle(1,15);
   if(lgdrive!=0)
     {
       a[0]=lgdrive+65;
       outtextxy(x+13,high_of_char*10+5,a);
     }
   else
     outtextxy(x,high_of_char*10+5,"MAIN");
   x+=40;
 }