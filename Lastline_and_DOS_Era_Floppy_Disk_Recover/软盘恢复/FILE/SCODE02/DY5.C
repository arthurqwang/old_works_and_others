#include <graphics.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <alloc.h>
#include <stdio.h>
#include <dos.h>
#include <process.h>
#include <fcntl.h>
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
void win(int x,int y,int xx,int yy);
int graphdriver;
int graphmode;
int errorcode;
int snumber,tnumber,dcdp,key=1;
int stime=0,sp0=1,etime,ep0;
int CCLIB;
float FILTER,SCL;
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
    dcdp=540/(tnumber+1);
    FILTER=2000/dcdp;
    CCLIB=open("CCLIB.DAT",O_RDONLY|O_BINARY);
    initview();
    border();
    section();
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
   int digiter1,i,j,cpp,ddd,dista_of_line;
   char digstr1[5];
   FILE *fp;
   float sampl[8000],*samp;
   long fs;
   if (stime<0) stime=0;
   if(stime>snumber) stime=snumber-(int)(350.*SCL);
   if(sp0<1) sp0=1;
   if(etime>snumber) etime=snumber;
   if(ep0>tnumber) ep0=tnumber;
   setviewport(10,50,630,440,1);
   setfillstyle(SOLID_FILL,DARKGRAY);
   bar(0,0,620,390);
   setfillstyle(SOLID_FILL,15);
   bar(40,30,580,380);

   itoa(stime,digstr1,10);
   setcolor(7);
   settextjustify(RIGHT_TEXT,CENTER_TEXT);
   outtextxy(40,30,digstr1);
   settextjustify(LEFT_TEXT,CENTER_TEXT);
   outtextxy(583,30,digstr1);
   setcolor(BLUE);
   line(40,30,580,30);
   if(SCL>0&&SCL<=0.05){dista_of_line=1;goto FFFF;}
   if(SCL>0.05&&SCL<=0.1){dista_of_line=5;goto FFFF;}
   if(SCL>0.1&&SCL<=.5){ dista_of_line=10;goto FFFF;}
   if(SCL>.5&&SCL<=1) { dista_of_line=50;goto FFFF;}
   dista_of_line=snumber/1000*100;
   if(dista_of_line<=0) dista_of_line=100;

FFFF:
   digiter1=stime/dista_of_line*dista_of_line+dista_of_line;
   ddd=(int)(((float)(digiter1-stime))/SCL)+30;

   while(ddd<380)
   {
   itoa(digiter1,digstr1,10);
   setcolor(7);
   settextjustify(RIGHT_TEXT,CENTER_TEXT);
   outtextxy(40,ddd,digstr1);
   settextjustify(LEFT_TEXT,CENTER_TEXT);
   outtextxy(583,ddd,digstr1);
   setcolor(BLUE);
   line(40,ddd,580,ddd);
   digiter1+=dista_of_line;
   ddd=(int)(((float)(digiter1-stime))/SCL)+30;
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
	  for(j=stime;j<=stime+SCL*350+1;j++)
	    {
             if(!feof(fp))
	     fread(samp+j,1,4,fp);
	    }
	  moveto(cpp,0);
	  if(key==1)
	   for(j=stime;j<=stime+SCL*350+1&&j<=snumber-1;j++)
	      lineto((int)(cpp+*(samp+j)/FILTER),(int)((j-stime)/SCL));
	  else
	   for(j=stime;j<=stime+SCL*350+1&&j<=snumber-1;j++)
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
   draw_box(10,9,630,35);
   getviewsettings(&viewportb);
   setcolor(RED);
   settextjustify(LEFT_TEXT,TOP_TEXT);
   puthzxy("文件名",450,14,CCLIB,RED,CYAN,0);
   outtextxy(500,19,": D.SJ");

   outtextxy(50,19," 1 ");/*Display");*/
   puthzxy("显示方式",70,14,CCLIB,RED,CYAN,0);
   outtextxy(150,19," 2 ");/*Config");*/
   puthzxy("参数配置",170,14,CCLIB,RED,CYAN,0);
   outtextxy(250,19," 3 ");/*Exit");*/
   puthzxy("返回",270,14,CCLIB,RED,CYAN);
   draw_box(10,450,630,475);
   puthzxy("方向键:选择     Ctrl-b:放大     Ctrl-s:缩小    Pgup/Pgdn:翻页",50,454,CCLIB,RED,CYAN,0);
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
	/*	 putimage(30,33,buf,0);
	 free(buf); */
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
{  int key=1,ky,x,y,xx,yy,tp0,ttime;
   int dcdpp=dcdp,ddd=10;
   high(50+(sel-1)*100,12,145+(sel-1)*100,31);
   while(key!=283)
    {
      key=bioskey(0);
      no_high(50+(sel-1)*100,12,145+(sel-1)*100,31);
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
	   high(50+(sel-1)*100,12,145+(sel-1)*100,31);
	    return 1;
	 case 818:
	 case 20530:
	    sel=2;
	   high(50+(sel-1)*100,12,145+(sel-1)*100,31);
	    return 2;
	 case 1075:
	 case 20787:
	    sel=3;
	    high(50+(sel-1)*100,12,145+(sel-1)*100,31);
	    return 3;
	 case 7181:
	    high(50+(sel-1)*100,12,145+(sel-1)*100,31);
	    return sel;
	 case 18688:
	    return (-1);
	 case 20736:
	    return(-2);
	 case 12290:
	     settextjustify(LEFT_TEXT,TOP_TEXT);
	     draw_box(10,450,630,475);
	     puthzxy("Esc/Ctrl-b:关闭      1-9:移动步长      方向键 :移动      回车 :放大 ",50,454,CCLIB,RED,CYAN,0);
	     high(50+(sel-1)*100,12,145+(sel-1)*100,31);
	     win(185,167,455,343);
	     x=185;y=167;xx=455;yy=343;ky=1;
		 while(ky!=283&&ky!=12290&&ky!=7181)
		   {
		     ky=bioskey(0);
		     win(x,y,xx,yy);
		     if((ky-561)%257==0&&ky<=2617&&ky>=561)
			{ dcdpp=((ky-561)/257+1)*dcdp/5;
			  ddd=((ky-561)/257+1)*2;}
		     switch(ky)
		       {
			 case 19200:x-=dcdpp;xx-=dcdpp;
				   if (x<50)x=50;xx=x+270;
				   win(x,y,xx,yy);break;
			 case 19712:x+=dcdpp;xx+=dcdpp;
				   if (xx>590)xx=590;x=xx-270;
				   win(x,y,xx,yy);  break;
			 case 18432:y-=ddd;yy-=ddd;
				   if (y<80)y=80;yy=y+176;
					win(x,y,xx,yy);break;
			 case 20480:y+=ddd,yy+=ddd;
				   if(yy>430) yy=430;y=yy-176;
				   win(x,y,xx,yy);break;
			 case 7181:
				   sp0+=(int)((float)(x-50)/(float)(dcdp)+.5);
				   ep0+=(int)((float)(xx-50)/(float)(dcdp)+.5);
				   stime=stime+(y-80)*SCL+1;etime=stime+176*SCL;
				   SCL=(float)(etime-stime)/350.;
				   dcdp*=2;FILTER/=2;
				   section();
				   break;
			 case 12290:
			 case 283:break;
			 default:win(x,y,xx,yy);break;
			}
		    }
	     settextjustify(LEFT_TEXT,TOP_TEXT);
	     draw_box(10,450,630,475);
	     puthzxy("方向键:选择     Ctrl-b:放大     Ctrl-s:缩小    Pgup/Pgdn:翻页",50,454,CCLIB,RED,CYAN,0);
	     break;
	 case 7955:
	     tp0=(ep0-sp0);
	     sp0-=tp0/2;
	     ep0+=tp0/2;
	     if(sp0<1) sp0=1;
	     if(ep0>tnumber) ep0=tnumber;
	     ttime=etime-stime;
	     stime-=ttime/2;
	     etime+=ttime/2;
	     if(stime<0) stime=0;
	     if(etime>snumber) etime=snumber;
	     SCL*=2.;
	     dcdp/=2;FILTER*=2;
	     section();
	     break;
	 default:
	    break;
	}
       high(50+(sel-1)*100,12,145+(sel-1)*100,31);
     }
     return 0;

    }
int display_menu()
{  int x=30,y=33,xx=170,yy=90,key=1,sel=1,n=25;
   unsigned size;
   void *buf;
   size=imagesize(30,33,170,90);
   buf=malloc(size);
   getimage(30,33,170,90,buf);
   draw_box(x,y,xx,yy);
   setcolor(RED);
   outtextxy(40,45,"1 ");/*:All data");*/
   puthzxy("全屏显示",60,40,CCLIB,RED,CYAN,0);
   outtextxy(40,70,"2 ");/*Part of data");*/
   puthzxy("局部显示",60,65,CCLIB,RED,CYAN,0);
   high(35,37,165,58);
   while(key!=283)
    {
      key=bioskey(0);
      no_high(35,37+(sel-1)*n,165,58+(sel-1)*n);
      switch(key){
	case 18432:
	case 20480:
	 sel=( sel==1?2:1);
	  break;
	case 561:
	case 20273:
	  high(35,37+(sel-1)*n,165,58+(sel-1)*n);
          putimage(30,33,buf,0);
	  free(buf);
	  return (sel);
	case 818:
	case 20530:
	  high(35,37+(sel-1)*n,165,58+(sel-1)*n);
          putimage(30,33,buf,0);
	  free(buf);
	  return(sel);
	case 7181:
	  high(35,37+(sel-1)*n,165,58+(sel-1)*n);
          putimage(30,33,buf,0);
	  free(buf);
	  return (sel);
	default:break;
	}
	high(35,37+(sel-1)*n,165,58+(sel-1)*n);
     }
     putimage(30,33,buf,0);
     free(buf);
     return 0;
}

void config_menu(void)
 {
    int i,k;
    char *p[]=
       {
     	"样点总数",
	"总道数",
     	"起始深度",
      	"终止深度",
      	"起始道号",
      	"终止道号",
      	"横向比例",
       "纵向比例",
      	"道间距",
       "显示模式",0};
    char *pp="          ";
   unsigned size;
   void *buf;
   size=imagesize(110,33,340,300);
   buf=malloc(size);
   getimage(110,33,340,300,buf);

    draw_box(110,33,340,300);

    for(i=0;i<10;i++)
     {
       high(120,41+i*25,330,61+i*25);
       /*setcolor(RED);
       outtextxy(130,44+i*15,p[i]);*/
       puthzxy(p[i],135,44+i*25,CCLIB,RED,CYAN,0);
     }
     itoa(snumber,pp,10);
     outtextxy(280,49,pp);
     itoa(tnumber,pp,10);
     outtextxy(280,74,pp);
     itoa(stime,pp,10);
     outtextxy(280,99,pp);
     itoa(etime,pp,10);
     outtextxy(280,124,pp);
     itoa(sp0,pp,10);
     outtextxy(280,149,pp);
     itoa(ep0,pp,10);
     outtextxy(280,174, pp);
     itoa(FILTER,pp,10);
     outtextxy(280,199,pp);
     itoa(SCL,pp,10);
     outtextxy(280,224,pp);
     itoa(dcdp,pp,10);
     outtextxy(280,249,pp);
     if (key==1) pp="波形";
     else pp="面积";
/*     outtextxy(280,274,pp);*/
     puthzxy(pp,280,269,CCLIB,RED,CYAN,0);
     k=bioskey(0);
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
  draw_box(90,60,310,350);
  for(i=0;i<7;i++)
    {
     high(100,75+i*25,300,95+i*25);
    }
  high(146,284,245,306);
  setcolor(RED);
  /*outtextxy(110,80,"Start depth:");*/
  puthzxy("起始深度",120,77,CCLIB,RED,CYAN,0);
  gotoxy(20,19);
  printf("%s","           ");
  gotoxy(20,19);
  scanf("%d",&stime);
  itoa(stime,h,10);
  outtextxy(260,82,h);

  /*outtextxy(110,100,"End depth:");*/
  puthzxy("终止深度",120,102,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%d",&etime);
  itoa(etime,h,10);
  outtextxy(260,107,h);

/*  outtextxy(110,120,"Start trace:");  */
  puthzxy("起始道号",120,127,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%d",&sp0);
  itoa(sp0,h,10);
  outtextxy(260,132,h);

  /*outtextxy(110,140,"End trace:");*/
  puthzxy("终止道号",120,152,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%d",&ep0);
  itoa(ep0,h,10);
  outtextxy(260,157,h);

/*  outtextxy(110,190,"X scale:");    */
  puthzxy("横向比例",120,177,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%f",&FILTER);
  /*itoa(FILTER,h,10);*/
  gcvt(FILTER,5,h);
  outtextxy(260,182,h);

/*  outtextxy(110,180,"Y scale:");
  puthzxy("纵向比例",120,202,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%f",&SCL);
 itoa(SCL,h,10);
  gcvt(SCL,5,h);
  outtextxy(260,207,h);*/
  SCL=(float)(etime-stime)/350.;
/*  outtextxy(110,200,"Distance of traces:");*/
  puthzxy("道间距",120,202,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%d",&dcdp);
  itoa(dcdp,h,10);
  outtextxy(260,207,h);

/*  outtextxy(110,220,"Display mode:");*/
  puthzxy("显示模式 (1波形/2面积)",120,227,CCLIB,RED,CYAN,0);
  gotoxy(20,19);printf("%s","           ");gotoxy(20,19);
  scanf("%d",&key);
  itoa(key,h,10);
  outtextxy(260,234,h);
}
void alldisplay(void)
{
    sp0=1;
    ep0=tnumber;
    stime=0;
    SCL=(float)(snumber/350.);
    etime=snumber;
    dcdp=540/(tnumber+1);
    FILTER=2000/dcdp;
 }
void win(int x,int y,int xx,int yy)
  {
    setlinestyle(SOLID_LINE,0,THICK_WIDTH);
    setwritemode(1);
    setcolor(LIGHTGREEN);
    moveto(x,y);
    lineto(xx,y);
    lineto(xx,yy);
    lineto(x,yy);
    lineto(x,y);
    setlinestyle(SOLID_LINE,0,NORM_WIDTH);
    setwritemode(0);
   }
