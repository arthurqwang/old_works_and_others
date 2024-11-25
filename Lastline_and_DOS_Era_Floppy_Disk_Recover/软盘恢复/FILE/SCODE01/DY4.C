#include <graphics.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <alloc.h>
#include <stdio.h>
#include <dos.h>
#include <process.h>
void *buf;
int Max,May;
struct textsettingstype textinfo;
struct palettetype palette;
struct viewporttype viewport;
void initview(void);
void border();
void section(void);
void mkmn(void);
void high(int ,int,int,int);
void no_high(int ,int,int,int);
void config_menu(void);
void partdisplay(void);
void alldisplay(void);
int graphdriver;
int graphmode;
int errorcode;
int snumber,tnumber,dcdp=25,key=1;
int stime=0,sp0=1,etime,ep0;
float FILTER=80.,SCL;
FILE *fp;

main( )
   {
    FILE *fpp;
    char f[15];
    fpp=fopen("DSS.DAT","rt");
    fgets(f,15,fpp);
    snumber=atoi(f);
    fgets(f,15,fpp);
    tnumber=atoi(f);
    close(fpp);
    SCL=(double)(snumber/350.);
    ep0=tnumber;

    initview();
    border();
    while(1){
    mkmn();
    }
    closegraph();
    }


 void initview()
  {
   graphdriver=DETECT;
   /*if (registerfarbgidriver(EGAVGA_driver_far)<0) exit(1);
   if (registerfarbgifont(triplex_font_far)<0) exit(1);*/
   initgraph(&graphdriver,&graphmode,"");
   errorcode=graphresult();
   if (errorcode!=grOk){
   printf("Graphics System Error:%s\n",grapherrormsg(errorcode));
   exit(1);
   }
   Max=getmaxx();May=getmaxy();
   getpalette(&palette);
   getviewsettings(&viewport);
   gettextsettings(&textinfo);
 }
 void section()
  {
   int digiter1,i,j,cpp;
   char digstr1[5];
   FILE *fp;
   float sampl[8000],*samp;
   long fs;
   if (stime<0) stime=0;
   if(stime>snumber) stime=snumber-(int)(350.*SCL);
   if(sp0<1) sp0=1;
   if(etime>snumber) etime=snumber;
   if(ep0>tnumber) ep0=tnumber;
   digiter1=stime;
   setviewport(10,50,630,440,1);
   setfillstyle(SOLID_FILL,DARKGRAY);
   bar(0,0,620,390);
   setfillstyle(SOLID_FILL,15);
   bar(40,30,580,380);
   for (i=0;i<=350;i+=50)
   {
   itoa(digiter1,digstr1,10);
   setcolor(7);
   settextjustify(RIGHT_TEXT,CENTER_TEXT);
   outtextxy(40,30+i,digstr1);
   settextjustify(LEFT_TEXT,CENTER_TEXT);
   outtextxy(583,30+i,digstr1);
   setcolor(BLUE);
   line(40,30+i,580,30+i);
   digiter1+=(int)(50*SCL);
   }
   setcolor(7);
   settextjustify(CENTER_TEXT,CENTER_TEXT);
   for(i=40;i<580;i+=dcdp*10)
    {
     line(i,25,i,30);
     itoa((i-40)/dcdp+sp0-1,digstr1,10);
     outtextxy(i,15,digstr1);
    }
   setviewport(50,80,590,430,1);
 /*  sampl=malloc(snumber*sizeof(float));*/
   samp=sampl;
   setcolor(0);
   fp=fopen("d.sj" ,"rb");
   for (i=sp0;i<=ep0;i++)
     {cpp=(i-sp0+1)*dcdp;
      fs=((long)i-1)*snumber*4+stime*4;
      if(!fseek(fp,fs,0))
	{
	  for(j=stime;j<=stime+SCL*350;j++)
	    {
             if(!feof(fp))
	     fread(samp+j,1,4,fp);
	    }
	  moveto(cpp,0);
	  if(key==1)
	   for(j=stime;j<=stime+SCL*350&&j<=snumber-1;j++)
	      lineto((int)(cpp+*(samp+j)/FILTER),(int)((j-stime)/SCL));
	  else
	   for(j=stime;j<=stime+SCL*350&&j<=snumber-1;j++)
	     {
	      lineto((int)(cpp+*(samp+j)/FILTER),(int)((j-stime)/SCL));
	      if (*(samp+j)>0)
	       lineto((int)(cpp),(int)((j-stime)/SCL));
	     }
	 }

      }
   fclose(fp);
/*   free(sampl);*/
   setviewport(viewport.left,viewport.top,viewport.right,
	viewport.bottom,viewport.clip);

  }
 void border()
  {

   setviewport(viewport.left,viewport.top,viewport.right,
   viewport.bottom,viewport.clip);
   setcolor(15);
   setfillstyle(11,10);
   bar3d(0,0,Max,May,0,1);
  }

void mkmn()
  {
   struct viewporttype viewportb;
   unsigned sel=1;
   int sell,selll;
   draw_box(10,9,630,31);
   getviewsettings(&viewportb);
   setcolor(RED);
   settextjustify(LEFT_TEXT,TOP_TEXT);
   outtextxy(450,17,"DATA FILE: D.SJ");
   outtextxy(50,17," 1:Display");
   outtextxy(150,17," 2:Config");
   outtextxy(250,17," 3:Exit");
   sell=get_selection(sel);
   switch(sell)
     {
      case 1:
	 selll=display_menu();
	   switch(selll){
	     case 2:
	       partdisplay();
	       section();
	       break;
	     case 1:
	       alldisplay();
	       section() ;
	       break;
	     default:break;
	      }
	 putimage(30,33,buf,0);
	 free(buf);
	 break;
      case 2:
	 config_menu();
	 break;
      case 3:
        closegraph();
	exit(0);
      case -1:
	 stime=stime-(int)(250.*SCL);
	 etime=etime-(int)(250.*SCL);
	 if(stime<0) {stime=0;/*etime=stime+350*SCL;*/}
	 section();
	 break;
      case -2:
	 stime=stime+(int)(250.*SCL);
	 etime=etime+(int)(250.*SCL);
	 if(etime>snumber) {etime=snumber;/*stime=etime-350*SCL;*/}
	 section();
	 break;
      default:
	break;
     }
   }


int get_selection(int sel)
{  int key=1;
   high(50+(sel-1)*100,13,135+(sel-1)*100,27);
   while(key!=283)
    {
      key=bioskey(0);
      no_high(50+(sel-1)*100,13,135+(sel-1)*100,27);
      switch(key)
       {
	 case 19200:
	    sel--;
	    if(sel<1) sel=3;
	    break;
	 case 19712:
	    sel++;
	    if (sel>3)sel=1;
	    break;
	 case 561:
	 case 20273:
	    sel=1;
	   high(50+(sel-1)*100,13,135+(sel-1)*100,27);
	    return 1;
	 case 818:
	 case 20530:
	    sel=2;
	   high(50+(sel-1)*100,13,135+(sel-1)*100,27);
	    return 2;
	 case 1075:
	 case 20787:
	    sel=3;
	    high(50+(sel-1)*100,13,135+(sel-1)*100,27);
	    return 3;
	 case 7181:
	    high(50+(sel-1)*100,13,135+(sel-1)*100,27);
	    return sel;
	 case 18688:
	    return (-1);
	 case 20736:
	    return(-2);
	 default:
	    break;
	}
       high(50+(sel-1)*100,13,135+(sel-1)*100,27);
     }
     return 0;

    }
int display_menu()
{  int x=30,y=33,xx=170,yy=80,key=1,sel=1,n=15;
   unsigned size;
   void *buf;
   size=imagesize(30,33,170,80);
   buf=malloc(size);
   getimage(30,33,170,80,buf);
   draw_box(x,y,xx,yy);
   setcolor(RED);
   outtextxy(40,45,"1:All data");
   outtextxy(40,60,"2:Part of data");
   high(35,42,165,54);
   while(key!=283)
    {
      key=bioskey(0);
      no_high(35,42+(sel-1)*n,165,54+(sel-1)*n);
      switch(key){
	case 18432:
	case 20480:
	 sel=( sel==1?2:1);
	  break;
	case 561:
	case 20273:
	  high(35,42+(sel-1)*n,165,54+(sel-1)*n);
          putimage(30,33,buf,0);
	  free(buf);
	  return (sel);
	case 818:
	case 20530:
	  high(35,42+(sel-1)*n,165,54+(sel-1)*n);
          putimage(30,33,buf,0);
	  free(buf);
	  return(sel);
	case 7181:
	  high(35,42+(sel-1)*n,165,54+(sel-1)*n);
          putimage(30,33,buf,0);
	  free(buf);
	  return (sel);
	default:break;
	}
	high(35,42+(sel-1)*n,165,54+(sel-1)*n);
     }
     putimage(30,33,buf,0);
     free(buf);
     return 0;
}

void config_menu(void)
 {
    int i;
    char *p[]=
       {
	"Sample number:",
	"Trace number:",
	"Start depth:",
	"End depth:",
	"Start trace:",
	"End trace:",
	"X scale:",
	"Y scale:",
	"Distance of traces:",
	"Display mode:",0};
    char *pp="          ";
   unsigned size;
   void *buf;
   size=imagesize(110,33,340,200);
   buf=malloc(size);
   getimage(110,33,340,200,buf);

    draw_box(110,33,340,200);

    for(i=0;i<10;i++)
     {
       high(120,41+i*15,330,53+i*15);
       setcolor(RED);
       outtextxy(130,44+i*15,p[i]);
     }
     itoa(snumber,pp,10);
     outtextxy(290,44,pp);
     itoa(tnumber,pp,10);
     outtextxy(290,59,pp);
     itoa(stime,pp,10);
     outtextxy(290,74,pp);
     itoa(etime,pp,10);
     outtextxy(290,89,pp);
     itoa(sp0,pp,10);
     outtextxy(290,104,pp);
     itoa(ep0,pp,10);
     outtextxy(290,119, pp);
     itoa(FILTER,pp,10);
     outtextxy(290,134,pp);
     itoa(SCL,pp,10);
     outtextxy(290,149,pp);
     itoa(dcdp,pp,10);
     outtextxy(290,164,pp);
     if (key==1) pp="WAVE";
     else pp="AREA";
     outtextxy(290,179,pp);
     getch();
     putimage(110,33,buf,0);
     free(buf);
 }

void high(int x,int y,int xx,int yy)
  {
   setcolor(DARKGRAY);
   line(x,yy,xx,yy);
   line(x+1,yy-1,xx-1,yy-1);
   line(xx,y,xx,yy);
   line(xx-1,y+1,xx-1,yy-1);
   setcolor(LIGHTCYAN);
   line(x,y,xx,y);
   line(x+1,y+1,xx-1,y+1);
   line(x,y,x,yy);
   line(x+1,y+1,x+1,yy-1);
   }
void no_high(int x,int y,int xx,int yy)
  {
   setcolor(CYAN);
   line(x,yy,xx,yy);
   line(x+1,yy-1,xx-1,yy-1);
   line(xx,y,xx,yy);
   line(xx-1,y+1,xx-1,yy-1);
   line(x,y,xx,y);
   line(x+1,y+1,xx-1,y+1);
   line(x,y,x,yy);
   line(x+1,y+1,x+1,yy-1);
   }

draw_box(int x,int y,int xx,int yy)
   {int dd=2;
   setfillstyle(SOLID_FILL,LIGHTCYAN);
   bar(x,y,xx,yy);
   setfillstyle(SOLID_FILL,CYAN);
   bar(x+dd,y+dd,xx-dd,yy-dd);
   setcolor(BLACK);
   line(x+dd+1,yy-dd,xx-dd,yy-dd);
   line(xx-dd,y+dd,xx-dd,yy-dd);
   line(x+dd+1,yy-dd+1,xx-dd,yy-dd+1);
   line(xx-dd+1,y+dd+1,xx-dd+1,yy-dd+1);

   }
void partdisplay(void)
{
  char *h="          ",out[10];
  int i,nn,mm;
  draw_box(90,60,310,280);
  for(i=0;i<8;i++)
    {
     high(100,75+i*20,300,90+i*20);
    }
  high(146,236,245,259);
  setcolor(RED);
  outtextxy(110,80,"Start depth:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%d",&stime);
  itoa(stime,h,10);
  outtextxy(260,80,h);

  outtextxy(110,100,"End depth:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%d",&etime);
  itoa(etime,h,10);
  outtextxy(260,100,h);

  outtextxy(110,120,"Start trace:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%d",&sp0);
  itoa(sp0,h,10);
  outtextxy(260,120,h);

  outtextxy(110,140,"End trace:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%d",&ep0);
  itoa(ep0,h,10);
  outtextxy(260,140,h);

  outtextxy(110,160,"X scale:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%f",&FILTER);
  /*itoa(FILTER,h,10);*/
  gcvt(FILTER,5,h);
  outtextxy(260,160,h);

  outtextxy(110,180,"Y scale:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%f",&SCL);
 /* itoa(SCL,h,10);*/
  gcvt(SCL,5,h);
  outtextxy(260,180,h);

  outtextxy(110,200,"Distance of traces:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%d",&dcdp);
  itoa(dcdp,h,10);
  outtextxy(260,200,h);

  outtextxy(110,220,"Display mode:");
  gotoxy(20,16);printf("%s","           ");gotoxy(20,16);
  scanf("%d",&key);
  itoa(key,h,10);
  outtextxy(260,220,h);
}
void alldisplay(void)
{
    stime=0;
    SCL=(float)(snumber/350.);
    etime=snumber;
 }
