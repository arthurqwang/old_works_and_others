#include <graphics.h>
#include "twingra.h"
#include <fcntl.h>
#include <io.h>
#include <stdio.h>
void title(void);
void clr_win(WINGRA *win,int hg);
void high(int x,int y,int xx,int yy,int colo,int times);
void draw_box(int row,int col,int erow,int ecol,int colo);
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor);
void pputhz(WINGRA *win,unsigned *hz,int color,int bkcolor);
WINGRA * open_win(int row,int col,int erow,int ecol,int color,int hg);
int CCLIB;
main()
 {
   WINGRA *win;
   unsigned  han[100];
   int  graphdrive=DETECT,mode;
   CCLIB=open("cclib.dat",O_RDONLY|O_BINARY);
   initgraph(&graphdrive,&mode,"");
   title();
   getch();
   /*win=open_win(1,1,12,30,1,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);


   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);


   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);
   puthz(win,"²²²²²²²²²²²²²²²\n",15,1);

   getch();

   clr_win(win,1);
   han[0]=2133;
   han[1]=2134;
   han[2]=0;
   pputhz(win,han,15,1);
   getch();*/
}
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
void draw_box(int row,int col,int erow,int ecol,int colo)
   {int dd=2;
   setfillstyle(SOLID_FILL,colo+8);
   bar((col-1)*8,(row-1)*16,ecol*8,erow*16);
   setfillstyle(SOLID_FILL,colo);
   bar((col-1)*8+dd,(row-1)*16+dd,ecol*8-dd,erow*16-dd);
   setcolor(0);
   line((col-1)*8+dd+1,erow*16-dd,ecol*8-dd,erow*16-dd);
   line(ecol*8-dd,(row-1)*16+dd,ecol*8-dd,erow*16-dd);
   line((col-1)*8+dd+1,erow*16-dd+1,ecol*8-dd,erow*16-dd+1);
   line(ecol*8-dd+1,(row-1)*16+dd+1,ecol*8-dd+1,erow*16-dd+1);
   high((col-1)*8+5,(row-1)*16+5,ecol*8-5,erow*16-5,colo,3);
   }
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int f,c1,c2;
	int i1,i2,i3,x,y;
	unsigned char i,j,ch[2],by[32];
	if(win->curline>=(win->erow))
	 {
	  delay(1000);
	  clr_win(win,1);
	 }

	f=0;
	x=((win->curcol)+2)*8;y=((win->curline))*16;
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
			  break;
			default:
			  outtextxy(x,y+6,ch);
			  (win->curcol) ++;
			  x+=8;
			}
		}
	}
}
void pputhz(WINGRA *win,unsigned *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int f,c1,c2,i;
	int i1,i2,i3,x,y;
	unsigned char j,ch[2],by[32];
	if(win->curline>=(win->erow))
	 {
	  delay(1000);
	  clr_win(win,1);
	 }

	f=0;
	x=((win->curcol)+2)*8;y=((win->curline))*16;
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
    win->curline=row+1;
    win->curcol=col+1;
    draw_box(row,col,erow,ecol,color);
    if(hg)
    for (i=row+1;i<erow-1;i+=2)
      high(col*8+8,i*16-4,ecol*8-16,i*16+19,color,1);
    return (win);
  }
void clr_win(WINGRA *win,int hg)
  {
    int i;
    draw_box(win->row,win->col,win->erow,win->ecol,win->color);
    if(hg)
     for(i=(win->row)+1;i<(win->erow)-1;i+=2)
       high((win->col)*8+8,i*16-4,(win->ecol)*8-16,i*16+19,(win->color),1);
    win->curline=(win->row)+1;
  }
void title(void)
  {
    WINGRA *win;
    int a[20]={140,20,145,25,160,25,165,20,165,45,160,50,145,50,140,45,140,20};
    win=open_win(1,15,6,65,1,1);

    puthz(win,"      ×îºó·ÀÏß ",15,1);
    bar(125,15,170,55);
    high(135,15,170,55,1,2);
    setcolor(15);

    setfillstyle(6,14);
    fillpoly(9,a);
        setfillstyle(3,1);
    bar(150,30,155,40);


    puthz(win,"£Ì£Á£Ó£Ô£Ì£É£Î£Å",14,1);
    puthz(win,"  2.0\n",15,1);/*£².£°*/
    puthz(win,"     °æÈ¨ËùÓÐ:  Íõ  È¨         (1993)",15,1);

  }