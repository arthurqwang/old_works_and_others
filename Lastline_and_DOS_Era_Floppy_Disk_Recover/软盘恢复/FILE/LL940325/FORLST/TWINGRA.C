#include "twingra.h"
/*#include <graphics.h>
#include "twingra.h"
#include <fcntl.h>
#include <io.h>
#include <stdio.h>
void title(void);
void clr_win(WINGRA *win,int hg);
void high(int x,int y,int xx,int yy,int colo,int times);
void nohigh(int x,int y,int xx,int yy,int colo,int times);
void draw_box(int row,int col,int erow,int ecol,int colo);
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor);
void pputhz(WINGRA *win,unsigned *hz,int color,int bkcolor);
WINGRA * open_win(int row,int col,int erow,int ecol,int color,int hg);*/
int CCLIB,high_of_char;
void high(int x,int y,int xx,int yy,int colo,int times)
  {
   int i;
   setcolor(0);
   for(i=0;i<times;i++)
   {
   line(x+i,yy-i,xx-i,yy-i);
   line(xx-i,y+i,xx-i,yy-i);
   }
   setcolor(colo+8);
   for(i=0;i<times;i++)
   {
    line(x+i,y+i,xx-i,y+i);
    line(x+i,y+i,x+i,yy-i);
   }
  }
void nohigh(int x,int y,int xx,int yy,int colo,int times)
  {
   int i;
   setcolor(colo+8);
   for(i=0;i<times;i++)
   {
   line(x+i,yy-i,xx-i,yy-i);
   line(xx-i,y+i,xx-i,yy-i);
   }
   setcolor(0);
   for(i=0;i<times;i++)
   {
    line(x+i,y+i,xx-i,y+i);
    line(x+i,y+i,x+i,yy-i);
   }
  }
void draw_box(int row,int col,int erow,int ecol,int colo)
   {int dd=2;
   setfillstyle(SOLID_FILL,colo+8);
   bar((col-1)*8,(row-1)*high_of_char,ecol*8,erow*high_of_char);
   setfillstyle(SOLID_FILL,colo);
   bar((col-1)*8+dd,(row-1)*high_of_char+dd,ecol*8-dd,erow*high_of_char-dd);
   setcolor(0);
   line((col-1)*8+dd+1,erow*high_of_char-dd,ecol*8-dd,erow*high_of_char-dd);
   line(ecol*8-dd,(row-1)*high_of_char+dd,ecol*8-dd,erow*high_of_char-dd);
   line((col-1)*8+dd+1,erow*high_of_char-dd+1,ecol*8-dd,erow*high_of_char-dd+1);
   line(ecol*8-dd+1,(row-1)*high_of_char+dd+1,ecol*8-dd+1,erow*high_of_char-dd+1);
   high((col-1)*8+5,(row-1)*high_of_char+5,ecol*8-5,erow*high_of_char-5,colo,1);
   nohigh((col-1)*8+7,(row-1)*high_of_char+7,ecol*8-7,erow*high_of_char-7,colo,2);
   }
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int  x,y;
	unsigned char j,ch[2],by[32],i;
	if((win->curline)>=(win->erow))
	 {
	  delay(1000);
	  clr_win(win,1);
	 }

	x=((win->curcol)+2)*8;y=((win->curline)-1)*high_of_char;
	setcolor(color);
	settextstyle(0,HORIZ_DIR,1);
	while((i=*hz)!=0){
		    j=0;
		    if(*hz=='{')
		      {
		       hz++;
		       while((*hz)!='}')
			 {
			   by[j]=*hz;
			   j++;
			   hz++;
			 }
		       by[j]=0;
		       offset=atol(by);
		       x=write_chinese_sentence(win,CCLIB,offset,x,y,color,bkcolor);
		      }
		    else{
			setfillstyle(SOLID_FILL,bkcolor);
			ch[0]=i;ch[1]='\0';
			switch(ch[0])
			{
			case '\b':
			  (win->curcol) --;
                          x=((win->curcol)+2)*8;
			  break;
			case '\n':
			  (win->curline) +=2;
			  (win->curcol)=(win->col)+1;

			  if((win->curline)>=(win->erow))
				 {
				  delay(1000);
				  clr_win(win,1);
				  setcolor(color);
				 }
                          x=((win->curcol)+2)*8;y=((win->curline)-1)*high_of_char;
			  break;
			default:
			  {
                           bar(x,y,x+textwidth("H")-1,y+15);
			   outtextxy(x,y+6,ch);
			   (win->curcol) ++;
			   x+=8;
			   break;
			  }
			}
		}
	hz++;
	}
	gotoxy(win->curcol+4,win->curline);
}
/*void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int f,c1,c2,i;
	int i1,i2,i3,x,y;
	unsigned char j,ch[2],by[32];
	if((win->curline)>=(win->erow))
	 {
	  delay(1000);
	  clr_win(win,1);
	 }

	f=0;
	x=((win->curcol)+2)*8;y=((win->curline)-1)*high_of_char;
	setcolor(color);
	settextstyle(0,HORIZ_DIR,1);
	while((i=*hz++)!=0){
		if(i>0xa0){
			if(f==0){
				c1=i-160;
				f++;
				}
			else   {
				c2=(c1-1)*94+(i-160)-1;
				f=0;
				offset=c2*32L;
				lseek(CCLIB,offset,SEEK_SET);
				read(CCLIB,by,32);
				for(i1=0;i1<16;i1++)
				for(i2=0;i2<2;i2++)
				for(i3=0;i3<8;i3++)
				if((j=(by[(i1*2)+i2]<<i3))>=128)
				putpixel((x+i2*8+i3),(y+i1),color);
				else
				putpixel((x+i2*8+i3),(y+i1),bkcolor);
				x+=16;
				(win->curcol)+=2;
			       }
			  }
		    else{
			setfillstyle(SOLID_FILL,bkcolor);
			ch[0]=i;ch[1]='\0';
			switch(ch[0])
			{
			case '\b':
			  (win->curcol) --;
                          x=((win->curcol)+2)*8;
			  break;
			case '\n':
			  (win->curline) +=2;
			  (win->curcol)=(win->col)+1;

			  if((win->curline)>=(win->erow))
				 {
				  delay(1000);
				  clr_win(win,1);
				  setcolor(color);
				 }
                          x=((win->curcol)+2)*8;y=((win->curline)-1)*high_of_char;
			  break;
			default:
			  {
                           bar(x,y,x+textwidth("H")-1,y+15);
			   outtextxy(x,y+6,ch);
			   (win->curcol) ++;
			   x+=8;
			   break;
			  }
			}
		}
	}
	gotoxy(win->curcol+4,win->curline);
}       */
/*888888888888888888888888888888888888888888888888888888888888888*/
void pputhz(WINGRA *win,unsigned *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int f,c1,c2,i;
	int i1,i2,i3,x,y;
	unsigned char j,ch[2],by[32];
	if(win->curline>=(win->erow)-3)
	 {
	  delay(1000);
	  clr_win(win,1);
	 }

	f=0;
	x=((win->curcol)+2)*8;y=((win->curline))*high_of_char;
	setcolor(color);
	settextstyle(0,HORIZ_DIR,1);
	while((i=*hz++)!=0){
		if(i>=1141)
			    {
				offset=(long)(i-1)*32L;
				lseek(CCLIB,offset,SEEK_SET);
				read(CCLIB,by,32);
				for(i1=0;i1<16;i1++)
				for(i2=0;i2<2;i2++)
				for(i3=0;i3<8;i3++)
				if((j=(by[(i1*2)+i2]<<i3))>=128)
				putpixel((x+i2*8+i3),(y+i1),color);
				else
				putpixel((x+i2*8+i3),(y+i1),bkcolor);
				x+=16;
				(win->curcol)+=2;
			  }
		    else{
			setfillstyle(SOLID_FILL,bkcolor);
			bar(x,y,x+textwidth("H")-1,y+15);
			ch[0]=i;ch[1]='\0';
			switch(ch[0])
			{
			case '\b':
			  (win->curcol) --;
			  break;
			case '\n':
			  (win->curline) +=2;
			  (win->curcol)=(win->col)+1;
                          if(win->curline>=(win->erow)-3)
				 {
				  delay(1000);
				  clr_win(win,1);
				 }

			  break;
			default:
			  outtextxy(x,y+6,ch);
			  (win->curcol) ++;
			  x+=8;
			}
		}
	}
}
WINGRA * open_win(int row,int col,int erow,int ecol,int color,int hg)
  {
    WINGRA *win;
    int i;
    if((win=(WINGRA *)malloc(sizeof(WINGRA)))==NULL)
		return NULL;
    win->row=row;
    win->col=col;
    win->erow=erow;
    win->ecol=ecol;
    win->color=color;
    win->curline=row+2;
    win->curcol=col+1;
    draw_box(row,col,erow,ecol,color);
    if(hg)
    for (i=row+1;i<erow-1;i+=2)
      high(col*8+8,i*high_of_char-4,ecol*8-16,i*high_of_char+19,color,1);
    return (win);
  }
void clr_win(WINGRA *win,int hg)
  {
    int i;
    draw_box(win->row,win->col,win->erow,win->ecol,win->color);
    if(hg)
     for(i=(win->row)+1;i<(win->erow)-1;i+=2)
       high((win->col)*8+8,i*high_of_char-4,(win->ecol)*8-16,i*high_of_char+19,(win->color),1);
    win->curline=(win->row)+2;
  }
void title(void)
  {
    WINGRA *win;
    int graphdrive=DETECT,mode,i;
/*    int graphdrive=EGA,mode=EGAHI,i;*/
    CCLIB=open("c:\\lastline\\lsth.inf",O_RDONLY|O_BINARY);
    if(CCLIB==-1)
       CCLIB=open("a:\\lsth.inf",O_RDONLY|O_BINARY);
    if(registerfarbgidriver(EGAVGA_driver_far)<0) exit(1);
    if(registerfarbgifont(triplex_font_far)<0) exit(1);
    if(registerfarbgifont(small_font_far)<0) exit(1);
    initgraph(&graphdrive,&mode,"");
    if(getgraphmode()==2)
       high_of_char=16;
    else
       high_of_char=14;
    win=open_win(1,15,6,65,1,0);
    puthz(win,"       {20271} ",15,1);
    high(180,high_of_char+9,500,high_of_char*3+5,1,1);
    high(135,high_of_char-1,170,high_of_char*3+7,1,2);
    nohigh(137,high_of_char+1,168,high_of_char*3+5,1,2);
    high(141,high_of_char+4,151,high_of_char*3-3,1,1);
    high(143,high_of_char+6,149,high_of_char*2+7,1,1);
    nohigh(144,high_of_char+7,148,high_of_char*2+6,1,1);
    high(154,high_of_char+4,164,high_of_char*3-3,1,1);
    high(156,high_of_char+6,162,high_of_char*2+7,1,1);
    nohigh(157,high_of_char+7,161,high_of_char*2+6,1,1);
    bar(147,high_of_char+8,158,high_of_char*3-3);
    high(147,high_of_char+8,158,high_of_char*3+1,1,1);
    high(149,high_of_char+10,156,high_of_char*3-5,1,1);
    nohigh(150,high_of_char+11,155,high_of_char*3-6,1,1);
    settextstyle(1,0,2);
    setcolor(0);
    outtextxy(281,high_of_char*2-1,"LASTLINE  2.0");
    setcolor(14);
    outtextxy(278,high_of_char*2-4,"LASTLINE  2.0");
    puthz(win,"\n       {20400}:",15,1);/*  Íõ  È¨         (1993)",15,1);*/
    puthz(win," {20529}   {20562}      (1993)",15,1);
    high(180,high_of_char*4-2,500,high_of_char*5+3,1,1);
    settextstyle(2,0,4);
    outtextxy(135,high_of_char*4," LDSD");
    high(130,high_of_char*4-1,174,high_of_char*5-4,1,1);
    nohigh(131,high_of_char*4,173,high_of_char*5-5,1,1);
    outtextxy(128,high_of_char+4,"T");
    outtextxy(128,high_of_char*2-2,"G");
  }
int write_chinese_sentence(WINGRA *win,int fp,long unsigned off,int x,int y,int fcolor,int bcolor)
{
  unsigned char a[1280];
  unsigned  len,i0,i1,i2,i3;
  lseek(fp,off,SEEK_SET);
  read(fp,a,1);
  len=a[0]&0xff;
  read(fp,a,len*32);
  for (i0=0;i0<len*32;i0+=32)
  for (i1=0;i1<16;i1++)
  for (i2=0;i2<2;i2++)
  for (i3=0;i3<8;i3++)
  if(((a[i1*2+i2+i0]<<i3)&0xff)>=128)
    putpixel(i2*8+i3+i0/2+x,i1+y,fcolor);
  else
    putpixel(i2*8+i3+i0/2+x,i1+y,bcolor);
  (win->curcol) += len*2;
  return (x += len*16);
}
