/*******************************************************************
  File name:     TWINGRA.C
  Belong to:     MSS 2.0 Chinese version
  Date:          NOV/10/94
  Author:        WangQuan
  Function:      To be graphics windows functions & print chinese.
  Usage:         Used in .PRJ files.
  Where stored:  Floppy disk "MSS 2.0 Chinese version
		 Source files"(MSS 2.0 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/



#include "twingra.h"
extern unsigned BKHEAD,BKTRACK;
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
/*void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
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
}       */
/*This puthz() uses GB HZK*/
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor)
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
    char MSS[]="PlfurVdih#V|vwhp##PVV#513";
    for(i=0;i<=24;i++)
       MSS[i] -= 3;
    if((CCLIB=open(path_of_HZK,O_RDONLY|O_BINARY))==-1)
       {
       printf("Can't find file MSSHZ.LIB or not running in floppy disk.\n");
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
    setfillstyle(SOLID_FILL,7);
    bar(0,0,640,480);
    for (i=-1;i<480;i+=10)
      {
	 setcolor(0);
	 line(0,i+1,640,i+1);
	 setcolor(15);
	 line(0,i,640,i);
      }
    win=open_win(2,15,6,65,7,0);
/*    puthz(win,"      最后防线最后防线最",0,7);*/
    settextstyle(1,0,2);
    setcolor(0);
    outtextxy(180,high_of_char*3-1,MSS);
    outtextxy(179,high_of_char*3-1,MSS);
    setcolor(15);
    outtextxy(178,high_of_char*3-3,MSS);
    outtextxy(177,high_of_char*3-3,MSS);
    setcolor(7);
    setfillstyle(SOLID_FILL,1);
    pieslice(150,high_of_char*3+5,0,56,10);
    setfillstyle(SOLID_FILL,14);
    pieslice(150,high_of_char*3+5,62,118,10);
    setfillstyle(SOLID_FILL,4);
    pieslice(150,high_of_char*3+5,122,180,10);
    high(140,high_of_char*3+8,160,high_of_char*3+17,7,1);
    settextstyle(2,0,3);
    setcolor(4);
    outtextxy(143,high_of_char*3+9,"RSun");
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
void SN_string_cvr(unsigned SN_num,unsigned char *SN_str)
{
  int i;
  for(i=5;i>=0;i--)
  {
    SN_str[i]=SN_num%10+'0';
    SN_num /= 10;
  }
  SN_str[6]=0;
}
unsigned get_SN_from_hd(void)
{
  unsigned SN;
  unsigned char part[512];
  get_BK();
  if(biosdisk(2,0x80,BKHEAD,BKTRACK,10,1,part))
    biosdisk(2,0x80,0,0,10,1,part);
  if(part[0]!='W' || part[511]!='Q')
    biosdisk(2,0x80,0,0,10,1,part);
  SN = part[507]+part[508]*256;
  return SN;
}
/* unsigned get_SN_from_fd(void)
{
  unsigned SN;
  unsigned char part[512];
  if(absread(toupper(dvr[0])-65,1,0,part))
    if(absread(toupper(dvr[0])-65,1,0,part))
     if(absread(toupper(dvr[0])-65,1,0,part))
       ;
  SN = part[0x27]+part[0x28]*256;
  return SN;
} *//* Move into LASTLIN2.c,LASTLIN3.c,MNGRBOOT.c,INSTALL.c  */
void wrt_SN_with_hd(void)
{
  unsigned char a[10];
  SN_string_cvr(get_SN_from_hd(),a);
  settextstyle(0,0,1);
  setcolor(14);
  outtextxy(420,high_of_char*2,"SN:");
  outtextxy(445,high_of_char*2,a);
  high(418,high_of_char*2-2,494,high_of_char*2+8,7,1);
}

void wrt_SN_with_fd(void)
{
  unsigned char a[10];
  SN_string_cvr(get_SN_from_fd(),a);
  settextstyle(0,0,1);
  setcolor(14);
  outtextxy(420,high_of_char*2,"SN:");
  outtextxy(445,high_of_char*2,a);
  high(418,high_of_char*2-2,494,high_of_char*2+8,7,1);
}
int get_ch(void)
{
      union REGS in,out;
      in.h.ah=0xC;
      in.h.al=0x07;
      intdos(&in,&out);
      return(out.h.al);
}


