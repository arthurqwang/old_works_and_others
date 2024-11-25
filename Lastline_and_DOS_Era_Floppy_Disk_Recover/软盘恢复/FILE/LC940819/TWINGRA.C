
/*******************************************************************
  File name:     TWINGRA.C
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          8/19/94
  Author:        WangQuan
  Function:      To be graphics windows functions & print chinese.
  Usage:         Used in .PRJ files.
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/



#include "twingra.h"

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
/*This puthz() uses small HZK*/
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int  x,y,ii;
	unsigned char j,ch[2],by[32],i;
        unsigned char tmp123[10240];
	unsigned char far *tmp124=tmp123;
	if((win->curline)>=(win->erow))
	 {
          for(ii=(win->row)+3;ii<(win->erow)-1;ii+=2)
	   {
	    getimage((win->col)*8+8,ii*high_of_char-4,(win->ecol)*8-16,ii*high_of_char+19,tmp124);
	    putimage((win->col)*8+8,(ii-2)*high_of_char-4,tmp124,0);
	   }
	  setcolor(bkcolor);
	  bar((win->col)*8+10,(ii-2)*high_of_char-2,(win->ecol)*8-18,(ii-2)*high_of_char+16);
	  win->curline=win->erow- win->detarow;
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
				  for(ii=(win->row)+3;ii<(win->erow)-1;ii+=2)
				    {
				      getimage((win->col)*8+8,ii*high_of_char-4,(win->ecol)*8-16,ii*high_of_char+19,tmp124);
				      putimage((win->col)*8+8,(ii-2)*high_of_char-4,tmp124,0);
				    }
				  setcolor(bkcolor);
				  bar((win->col)*8+10,(ii-2)*high_of_char-2,(win->ecol)*8-18,(ii-2)*high_of_char+16);
				  win->curline=win->erow- win->detarow;
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
/*This puthz() uses GB HZK*/
/*void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
   {
	long offset;
	unsigned int f,c1,c2,i;
	int i1,i2,i3,x,y;
	unsigned char j,ch[2],by[32],ii;
        unsigned char tmp123[10240];
	unsigned char far *tmp124=tmp123;
	if((win->curline)>=(win->erow))
	 {
          for(ii=(win->row)+3;ii<(win->erow)-1;ii+=2)
	   {
	    getimage((win->col)*8+8,ii*high_of_char-4,(win->ecol)*8-16,ii*high_of_char+19,tmp124);
	    putimage((win->col)*8+8,(ii-2)*high_of_char-4,tmp124,0);
	   }
	  setcolor(bkcolor);
	  bar((win->col)*8+10,(ii-2)*high_of_char-2,(win->ecol)*8-18,(ii-2)*high_of_char+16);
	  win->curline=win->erow- win->detarow;
	}
	x=((win->curcol)+2)*8;y=((win->curline)-1)*high_of_char;
	f=0;
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
				  for(ii=(win->row)+3;ii<(win->erow)-1;ii+=2)
				    {
				      getimage((win->col)*8+8,ii*high_of_char-4,(win->ecol)*8-16,ii*high_of_char+19,tmp124);
				      putimage((win->col)*8+8,(ii-2)*high_of_char-4,tmp124,0);
				    }
				  setcolor(bkcolor);
				  bar((win->col)*8+10,(ii-2)*high_of_char-2,(win->ecol)*8-18,(ii-2)*high_of_char+16);
				  win->curline=win->erow- win->detarow;
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
}*/

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
    if(((win->erow - win->row)%2)==1)
      win->detarow=1;
    else
      win->detarow=2;
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
void title(char *path_of_HZK)
  {
    WINGRA *win;
    int graphdrive=DETECT,mode,i,j;
/*    int graphdrive=EGA,mode=EGAHI,i,j;*/
    short dlboy1[]={   141,50,137,46,135,46,135,44,137,42,137,36,139,32,141,30,143,28,147,24,151,22,153,20,155,20,155,16,
    157,20,161,24,167,30,171,36,173,42,173,44,177,46,177,50,173,50,169,52,163,54,163,58,173,58,173,60,179,60,179,58,
    167,54,157,54,147,52,151,50,149,48,151,46,149,46,141,50,139,54,141,56,149,52,137,60,143,66,135,62,133,60,131,60,129,62,131,64,141,68,143,70,145,72,151,74,155,74,161,72,
    167,68,167,66,171,64,167,58,171,64,163,68,165,70,163,68,155,70,149,70,147,64,143,66,143,70,0,0};

    if((CCLIB=open(path_of_HZK,O_RDONLY|O_BINARY))==-1)
       {
       printf("Can't find file LSTH.INF.\n");
       exit(0);
       }
    if(registerfarbgidriver(EGAVGA_driver_far)<0) exit(1);
    if(registerfarbgifont(triplex_font_far)<0) exit(1);
    if(registerfarbgifont(small_font_far)<0) exit(1);
    initgraph(&graphdrive,&mode,"");
    if(getgraphmode()==2)
       high_of_char=16;
    else
       high_of_char=14;
    win=open_win(1,15,6,65,1,0);
    puthz(win,"         最 后 防 线 ",15,1);  /*不 倒 翁最后防线*/
    high(180,high_of_char+9,500,high_of_char*3+5,1,1);
    settextstyle(1,0,2);
    setcolor(0);
    outtextxy(320,high_of_char*2-1,"LASTLINE 2.5");
    setcolor(14);
    outtextxy(317,high_of_char*2-4,"LASTLINE 2.5");
    puthz(win,"\n      版权:",14,1);
    puthz(win,"东乐电脑技术开发公司  ",15,1);
    puthz(win,"开发:",14,1);
    puthz(win,"王 权",15,1);
    high(180,high_of_char*4-2,500,high_of_char*5+3,1,1);
/************** DLBOY *****************************/
    high(123,12,177,75,1,2);
    setlinestyle(SOLID_LINE,0,THICK_WIDTH);
    for(j=0;j<2;j++)
    {
    setcolor(j*14);
    moveto(141-5*j,50-2*j);
  i=0;
  while(dlboy1[i]!=0)
    {
      lineto(dlboy1[i]-5*j,dlboy1[i+1]-2*j);
      i+=2;
    }
  moveto(153-5*j,46-2*j);
  lineto(157-5*j,48-2*j);
  lineto(159-5*j,46-2*j);
  lineto(153-5*j,46-2*j);
  moveto(145-5*j,44-2*j);
  lineto(145-5*j,44-2*j);
  lineto(147-5*j,42-2*j);
  lineto(149-5*j,42-2*j);
  lineto(149-5*j,44-2*j);
  lineto(145-5*j,44-2*j);
  moveto(163-5*j,42-2*j);
  lineto(163-5*j,42-2*j);
  lineto(163-5*j,44-2*j);
  lineto(167-5*j,44-2*j);
  lineto(163-5*j,42-2*j);
  }
  setlinestyle(SOLID_LINE,0,1);
  settextstyle(2,0,3);
  setcolor(9);
  outtextxy(165,17,"D");outtextxy(170,17,"L");
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
void anti_trace(void)
 {
   unsigned step_or_break_adr[4],seg,off;
   step_or_break_adr[0]=peekb(0,0x4)&0xff;
   step_or_break_adr[1]=peekb(0,0x5)&0xff;
   step_or_break_adr[2]=peekb(0,0x6)&0xff;
   step_or_break_adr[3]=peekb(0,0x7)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   pokeb(seg,off,0x2e);
   step_or_break_adr[0]=peekb(0,0xc)&0xff;
   step_or_break_adr[1]=peekb(0,0xd)&0xff;
   step_or_break_adr[2]=peekb(0,0xe)&0xff;
   step_or_break_adr[3]=peekb(0,0xf)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   pokeb(seg,off,0x2e);
}
void can_trace(void)
 {
   unsigned step_or_break_adr[4],i,seg,off;
   step_or_break_adr[0]=peekb(0,0x4)&0xff;
   step_or_break_adr[1]=peekb(0,0x5)&0xff;
   step_or_break_adr[2]=peekb(0,0x6)&0xff;
   step_or_break_adr[3]=peekb(0,0x7)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   pokeb(seg,off,0x55);
   step_or_break_adr[0]=peekb(0,0xc)&0xff;
   step_or_break_adr[1]=peekb(0,0xd)&0xff;
   step_or_break_adr[2]=peekb(0,0xe)&0xff;
   step_or_break_adr[3]=peekb(0,0xf)&0xff;
   seg=((step_or_break_adr[3]<<8)&0xFF00)|(step_or_break_adr[2]&0xff);
   off=((step_or_break_adr[1]<<8)&0xFF00)|(step_or_break_adr[0]&0xff);
   pokeb(seg,off,0x55);
}
