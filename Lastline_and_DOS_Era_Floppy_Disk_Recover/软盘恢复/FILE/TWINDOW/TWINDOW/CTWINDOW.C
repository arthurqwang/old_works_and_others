#include <stdio.h>
#include <ctype.h>
#include <stdarg.h>
#include <dos.h>
#include <alloc.h>
#include <stdlib.h>
#include <string.h>
#include "ctwindow.h"
#include "keys.h"

#define TABS 4
#define SCRNHT 25
#define SCRNWIDTH 80
#define ON 1
#define OFF 0
#define ERROR -1

redraw(WINDOW *wnd);
wframe(WINDOW *wnd);
dtitle(WINDOW *wnd);
int *waddr(WINDOW *wnd,int x,int y);
vswap(WINDOW *wnd);
vsave(WINDOW *wnd);
vrstr(WINDOW *wnd);
add_list(WINDOW *wnd);
beg_list(WINDOW *wnd);
remove_list(WINDOW *wnd);
insert_list(WINDOW *w1,WINDOW *w2);
void vpo(int x,int y,int ch,int at);
int vpe(int,int);
void split_window(WINDOW*);
#ifndef FASTWINDOWS
int dget(WINDOW *wnd,int x,int y);
verify_wnd(WINDOW **w1);
#endif

struct{
	int nw,ne,se,sw,side,line;
}wcs[]={
	{176,180,188,184,166,164},
	{179,183,191,187,167,165},
	{178,182,190,186,167,164},
	{177,181,189,185,166,165},
	{208,208,188,184,166,164},
};

WINDOW *listhead=NULL;
WINDOW *listtail=NULL;
int VSG;

WINDOW *establish_window(x,y,h,w)
{	WINDOW *wnd;
	x*=2;
	w*=2;
	VSG=(vmode()==7?0xb000:0xb800);
	if((wnd=(WINDOW *)malloc(sizeof(WINDOW)))==NULL)
		return NULL;
	WTITLE="";
	HEIGHT=min(h,SCRNHT);
	WIDTH=min(w,SCRNWIDTH);
	COL=max(0,min(x,SCRNWIDTH-WIDTH));
	ROW=max(0,min(y,SCRNHT-HEIGHT));
	WCURS=1;
	SCROLL=0;
	SELECT=1;
	BTYPE=0;
	VISIBLE=HIDDEN=0;
	PREV=NEXT=NULL;
	FHEAD=FTAIL=NULL;
	WBORDER=WNORMAL=PNORMAL=WTITLEC=clr(BLACK,WHITE,BRIGHT);
	WACCENT=clr(WHITE,BLACK,DIM);
	if((SAV=malloc(WIDTH*HEIGHT*2))==(char *)0)
		return NULL;
	add_list(wnd);
#ifndef FASTWINDOWS
	clear_window(wnd);
	wframe(wnd);
#endif
	return wnd;
}

void set_border(WINDOW *wnd,int btype)
{	if(verify_wnd(&wnd)){
		BTYPE=btype;
		redraw(wnd);
	}
}

void set_colors(WINDOW *wnd,int area,int bg,int fg,int inten)
{
		if(vmode()==7){
		if(bg!=WHITE&&bg!=BLACK)
			return;
		if(fg!=WHITE&&fg!=BLACK)
			return;
	}
	if(verify_wnd(&wnd)){
		if(area==ALL)
			while(area)
				WCOLOR[--area]=clr(bg,fg,inten);
		else
			WCOLOR[area]=clr(bg,fg,inten);
		redraw(wnd);
	}
}

void set_intensity(WINDOW *wnd,int inten)
{	int area=ALL;
	if(verify_wnd(&wnd)){
		while(area){
			WCOLOR[--area]&=~BRIGHT;
			WCOLOR[area]|=inten;
		}
		redraw(wnd);
	}
}

void set_title(WINDOW *wnd,char *title)
{	if(verify_wnd(&wnd)){
		WTITLE=title;
		redraw(wnd);
	}
}

static redraw(WINDOW *wnd)
{
#ifndef FASTWINDOWS
	int x,y,chat,atr;
	for(y=1;y<HEIGHT-1;y++)
		for(x=2;x<WIDTH-2;x++){
			chat=dget(wnd,x,y);
			/*atr=(((chat>>8)&255)==PNORMAL?WNORMAL:WACCENT);*/
			atr=(chat>>8)&255;
			if(atr==PNORMAL) atr=WNORMAL;
			displ(wnd,x,y,chat&255,atr);
		}
	wframe(wnd);
#endif
	PNORMAL=WNORMAL;
}

void display_window(WINDOW *wnd)
{	if(verify_wnd(&wnd)&&!VISIBLE){
		VISIBLE=1;
#ifdef FASTWINDOWS
		if(HIDDEN){
			HIDDEN=0;
			vrstr(wnd);
		}
		else{
			vsave(wnd);
			clear_window(wnd);
			wframe(wnd);
		}
#else
		vswap(wnd);
#endif
	}
}

void close_all()
{	WINDOW *sav,*wnd=listtail;
	while(wnd){
		sav=PREV;
		delete_window(wnd);
		wnd=sav;
	}
}

void delete_window(WINDOW *wnd)
{	if(verify_wnd(&wnd)){
		hide_window(wnd);
		free(SAV);
		remove_list(wnd);
		free(wnd);
	}
}

void hide_window(WINDOW *wnd)
{	if(verify_wnd(&wnd)&&VISIBLE){
#ifndef FASTWINDOWS
		vswap(wnd);
#else
		vrstr(wnd);
#endif
		HIDDEN=1;
		VISIBLE=0;
	}
}

#ifndef FASTWINDOWS
void repos_wnd(WINDOW *wnd,int x,int y,int z)
{	WINDOW *twnd;
	int xl,yl,chat;
	x*=2;
	if(!verify_wnd(&wnd))
		return;
	if((x+COL)+WIDTH>=SCRNWIDTH) return;
	twnd=establish_window((x+COL)/2,y+ROW,HEIGHT,WIDTH/2);
	twnd->_tl=WTITLE;
	twnd->btype=BTYPE;
	twnd->wcolor[BORDER]=WBORDER;
	twnd->wcolor[TITLE]=WTITLEC;
	twnd->wcolor[ACCENT]=WACCENT;
	twnd->wcolor[NORMAL]=WNORMAL;
	twnd->_pn=PNORMAL;
	twnd->_sp=SELECT;
	twnd->_wsp=SCROLL;
	twnd->_cr=WCURS;
	if(z!=1){
		remove_list(twnd);
		if(z==0)
			insert_list(twnd,wnd);
		else
			beg_list(twnd);
	}
	for(yl=0;yl<twnd->_wh;yl++)
	for(xl=0;xl<twnd->_ww;xl++){
		chat=dget(wnd,xl,yl);
		displ(twnd,xl,yl,chat&255,(chat>>8)&255);
	}
	twnd->_wv=1;
	vswap(twnd);
	hide_window(wnd);
	free(SAV);
	remove_list(wnd);

	*wnd=*twnd;

	insert_list(wnd,twnd);
	remove_list(twnd);
	free(twnd);
}
#endif

void clear_window(WINDOW *wnd)
{	register int xl,yl;
	if(verify_wnd(&wnd))
		for(yl=1;yl<HEIGHT-1;yl++)
			for(xl=2;xl<WIDTH-2;xl++)
				displ(wnd,xl,yl,' ',WNORMAL);
}

static wframe(WINDOW *wnd)
{	register int xl,yl;
	if(!verify_wnd(&wnd))
		return;
	displ(wnd,0,0,169,WBORDER);
	displ(wnd,1,0,NW,WBORDER);
	dtitle(wnd);
	displ(wnd,WIDTH-2,0,169,WBORDER);
	displ(wnd,WIDTH-1,0,NE,WBORDER);
	for(yl=1;yl<HEIGHT-1;yl++){
		displ(wnd,0,yl,169,WBORDER);
		displ(wnd,1,yl,SIDE,WBORDER);
		displ(wnd,WIDTH-2,yl,169,WBORDER);
		displ(wnd,WIDTH-1,yl,SIDE,WBORDER);
	}
	displ(wnd,0,yl,169,WBORDER);
	displ(wnd,1,yl,SW,WBORDER);
	for(xl=2;xl<WIDTH-2;xl+=2)
	    {   displ(wnd,xl,yl,169,WBORDER);
		displ(wnd,xl+1,yl,LINE,WBORDER);
	    }
		displ(wnd,xl,yl,169,WBORDER);
		displ(wnd,xl+1,yl,SE,WBORDER);
}

static dtitle(WINDOW *wnd)
{	int xl=2,i,ln;
	char *s=WTITLE;
	if(!verify_wnd(&wnd))
		return;
	if(s){
		ln=strlen(s);
		if(ln>WIDTH-2)
			i=0;
		else
			i=((WIDTH-2-ln)/4);
		if(i>0)
			while((i--))  {
			displ(wnd,xl++,0,169,WBORDER);
			displ(wnd,xl++,0,LINE,WBORDER);}
		while(*s&&xl<WIDTH-2)
			displ(wnd,xl++,0,*s++,WTITLEC);
	}
	while(xl<WIDTH-2)
		{displ(wnd,xl++,0,169,WBORDER);
		 displ(wnd,xl++,0,LINE,WBORDER);}
}

void wprintf(WINDOW *wnd,char *ln,...)
{	char dlin[100],*dl=dlin;
	if(verify_wnd(&wnd)){
		va_list ap;
		va_start(ap,ln);
		vsprintf(dlin,ln,ap);
		va_end(ap);
		if(*dl=='-'&&*(dl+1)=='-'&&*(dl+2)=='-')
		  split_window(wnd);
		else
		while(*dl)
			wputchar(wnd,*dl++);
	}
}

void wclrprintf(WINDOW *wnd,int bg,int fg,int inten,char *ln,...)
{	char dlin[100],*dl=dlin;
	if(verify_wnd(&wnd)){
		va_list ap;
		va_start(ap,ln);
		vsprintf(dlin,ln,ap);
		va_end(ap);
		  while(*dl)
			wclrputchar(wnd,*dl++,bg,fg,inten);
	}
}

void wputchar(WINDOW *wnd,int c)
{	if(!verify_wnd(&wnd))
		return;
	switch(c){
		case '\n':
			if(SCROLL==HEIGHT-3)
				scroll(wnd,UP);
			else
				SCROLL++;
			WCURS=1;
			break;
		case '\t':
			do displ(wnd,(WCURS++)+3,SCROLL+1,' ',WNORMAL);
				while((WCURS%TABS)&&(WCURS+1)<WIDTH-2);
			break;
		default:
			if((WCURS+1)<WIDTH-2){
				displ(wnd,WCURS+1,SCROLL+1,c,WNORMAL);
				WCURS++;
			}
			break;
	}
}
void split_window(WINDOW *wnd)
 {

  int x;
  for(x=2;x<=WIDTH-2;x++)
   {wputchar(wnd,169);wputchar(wnd,164);}
   wputchar(wnd,'\n');
 }

void wclrputchar(WINDOW *wnd,int c,int bg,int fg,int inten)
{	if(!verify_wnd(&wnd))
		return;
	switch(c){
		case '\n':
			if(SCROLL==HEIGHT-3)
				scroll(wnd,UP);
			else
				SCROLL++;
			WCURS=1;
			break;
		case '\t':
			do displ(wnd,(WCURS++)+3,SCROLL+1,' ',clr(bg,fg,inten));
				while((WCURS%TABS)&&(WCURS+1)<WIDTH-2);
			break;
		default:
			if((WCURS+1)<WIDTH-2){
				displ(wnd,WCURS+1,SCROLL+1,c,clr(bg,fg,inten));
				WCURS++;
			}
			break;
	}
}

void wcursor(WINDOW *wnd,int x,int y)
{
/*	x*=2;*/
	if(verify_wnd(&wnd)&&x<WIDTH-2&&y<HEIGHT-1){
		WCURS=x;
		SCROLL=y;
		cursor(COL+x+2,ROW+y+1);
	   }
}

int get_selection(WINDOW *wnd,int s,char *keys,int bg,int fg,int inten)
{	int c=0,ky,d,move_step=1,prvbrdrclr=WCOLOR[BORDER];
	int line=1,ch,cch,x,loca[50],totallines;
	int maxselect=0,have=0,len_keys=strlen(keys);
	ky=0;
	if(!verify_wnd(&wnd))
		return 0;

	while(line<HEIGHT-1)
	  { have=0;
	    for(x=2;x<=WIDTH-3;x++)
	     if((dget(wnd,x,line)&255)!=' ') {have=1;break;}
	    if (!have) break;
	    if((ch=dget(wnd,2,line)&255)==169)
		{
		  line++;
		  continue;
		}
	    else
	    {
	    maxselect++;
	    loca[ky+1]=line;
	    if(ky<=len_keys){
	    cch=toupper(*(keys+ky));
	    for (x=2;x<=WIDTH-2;x++)
	      {
	       #ifndef FASTWINDOWS
		ch=dget(wnd,x,line)&255;
	       #else
		ch=vpeek(VSG,vad(x+COL,line+ROW));
	       #endif

		if (cch==toupper(ch))
		   {
		     wcursor(wnd,x-1,line-1);/*because the corner of text area is at(0,0)*/
		     wclrputchar(wnd,ch,bg,fg,inten);
		     break;
		   }
	      }
	      }
	    ky++;
	    line++;
	    }
	  }
	  cursor(0,SCRNHT);
	totallines=line-1;
	if(s<1||s>maxselect) s=1;
	SELECT=s;
	line=loca[SELECT];
	while(c!=ESC&&c!='\r'&&c!=BS&&c!=FWD){

		cch=toupper(*(keys+SELECT-1));
		accent(wnd,line);
		c=get_char();
		


		switch(c){
			case UP:
                        	deaccent(wnd,line);
				if(SELECT<=len_keys){
				for (x=2;x<=WIDTH-2;x++)
				  {
				    ch=dget(wnd,x,line)&255;
				    if (cch==toupper(ch))
				      {
					wcursor(wnd,x-1,line-1);
					wclrputchar(wnd,ch,bg,fg,inten);
					cursor(0,SCRNHT);
					break;
				      }
				  }
				  }
				if((ch=dget(wnd,2,line-1)&255)==169) line--;
				line--;
				if(line>0)
					SELECT--;
				else
					{SELECT=maxselect;line=totallines;}
				break;
			case DN:
                                deaccent(wnd,line);
				if(SELECT<=len_keys){

				for (x=2;x<=WIDTH-2;x++)
				  {
				    ch=dget(wnd,x,line)&255;
				    if (cch==toupper(ch))
				      {
					wcursor(wnd,x-1,line-1);
					wclrputchar(wnd,ch,bg,fg,inten);
					cursor(0,SCRNHT);
					break;
				      }
				  }
				  }
				if((ch=dget(wnd,2,line+1)&255)==169) line++;
				line++;
				if(line<=totallines)
					SELECT++;
				else
					{SELECT=1;line=1;}
				break;
			#ifndef FASTWINDOWS
			case F2:
			   WCOLOR[BORDER] |=0x80;
			   redraw(wnd);
				do{
				    d=get_char();
				    if (d>='0'&& d<='9')  {move_step=d-'0';continue;}
					 switch(d)
					   {
						case FWD: rmove_window(wnd,move_step,0);break;
						case BS:  rmove_window(wnd,-move_step,0);break;
						case UP:rmove_window(wnd,0,-move_step);break;
						case DN:rmove_window(wnd,0,move_step);break;
						case '+':forefront(wnd);break;
						case '-':rear_window(wnd);break;
						case ESC:return 0;
						default:break;
					    }
				    }while(d!=F2);
				    WCOLOR[BORDER] =prvbrdrclr;
				    redraw(wnd);
				break;
			#endif
			case '\r':
			case ESC:
			case FWD:
			case BS:
				break;
			default:
				if(len_keys>maxselect) *(keys+maxselect)='\0';
				if(*keys){
					ky=0;
					while(*(keys+ky)){
						if(*(keys+ky)==toupper(c)||*(keys+ky)==tolower(c))
							return ky+1;
						ky++;
					}
				}
				break;
			}
		}
	return c=='\r'?SELECT:c==ESC?0:c;
}


union REGS rg;
void scroll(WINDOW *wnd,int dir)
{	int row=HEIGHT-1,col,chat;
	if(!verify_wnd(&wnd))
		return;
	if(NEXT==NULL&&HEIGHT>3&&VISIBLE){
		rg.h.ah=dir==UP?6:7;
		rg.h.al=1;
		rg.h.bh=WNORMAL;
		rg.h.cl=COL+2;
		rg.h.ch=ROW+1;
		rg.h.dl=COL+WIDTH-3;
		rg.h.dh=ROW+HEIGHT-2;
		int86(16,&rg,&rg);
		return;
	}
	if(dir==UP){
		for(row=2;row<HEIGHT-1;row++)
			for(col=2;col<WIDTH-2;col++){
				chat=dget(wnd,col,row);
				displ(wnd,col,row-1,chat&255,(chat>>8)&255);
			}
		for(col=2;col<WIDTH-2;col++)
			displ(wnd,col,HEIGHT-2,' ',WNORMAL);
	}
}

#ifndef FASTWINDOWS
static int *waddr(WINDOW *wnd,int x,int y)
{	WINDOW *nxt=NEXT;
	int *vp;
	if(!VISIBLE)
		return (int*)(SAV+y*(WIDTH*2)+x*2);
		x+=COL;
		y+=ROW;
	while(nxt){
		if(nxt->_wv)
		  {if(x>=nxt->_wx&&x<=nxt->_wx+nxt->_ww-1)
		    {if(y>=nxt->_wy&&y<=nxt->_wy+nxt->_wh-1){
			x-=nxt->_wx;
			y-=nxt->_wy;
			vp=(int *)((nxt->_ws)+y*(nxt->_ww*2)+x*2);
			return vp;}
		   }
		}
		nxt=nxt->_nx;
	}
	return NULL;
}

void displ(WINDOW *wnd,int x,int y,int ch,int at)
{	int *vp;
	int vch=(ch&255)|(at<<8);
	if((vp=waddr(wnd,x,y))!=NULL)
		*vp=vch;
	else
/*		vpoke(VSG,vad(x+COL,y+ROW),vch);*/
	vpo(x+COL,y+ROW,ch,at);

}


void vpo(int x,int y,int ch,int at)

   {
     gotoxy(x+1,y+1);
     textattr(at);
     cprintf("%c",ch);
     cursor(0,SCRNHT);
   }
int vpe(int x,int y)
  {
    int tem,*bf=&tem;
    gettext(x+1,y+1,x+1,y+1,bf);
    return *bf;
  }

static int dget(WINDOW *wnd,int x,int y)
{	int *vp;
	if((vp=waddr(wnd,x,y))!=NULL)
		return *vp;
/*	return vpeek(VSG,vad(x+COL,y+ROW));*/
	return vpe(x+COL,y+ROW);
}

static vswap(WINDOW *wnd)
{	int x,y,chat;
	int *bf=(int *)SAV;
	for(y=0;y<HEIGHT;y++)
		for(x=0;x<WIDTH;x++){
			chat=*bf;
			*bf++=dget(wnd,x,y);
			displ(wnd,x,y,chat&255,(chat>>8)&255);
		}
}

#else

static vsave(WINDOW *wnd)
{       int x,y;
	int *bf=(int *)SAV;
	for(y=0;y<HEIGHT;y++)
		for(x=0;x<WIDTH;x++)
		/*	*bf++=vpeek(VSG,vad(x+COL,y+ROW));*/
			*bf=vpe(x+COL,y+ROW);
}

static vrstr(WINDOW *wnd)
{	int x,y;
	int *bf=(int *)SAV;
	for(y=0;y<HEIGHT;y++)
		for(x=0;x<WIDTH;x++)
/*			vpoke(VSG,vad(x+COL,y+ROW),*bf++);*/
			vpo(x+COL,y+ROW,*bf&255,(*bf>>8)&255);
}
#endif

void acline(WINDOW *wnd,int set,int line)
{	int x,ch;
	if(!verify_wnd(&wnd))
		return;
	for(x=2;x<WIDTH-2;x++){
		ch=dget(wnd,x,line)&255;
		displ(wnd,x,line,ch,set);
	}
}

static add_list(WINDOW *wnd)
{	if(listtail){
		PREV=listtail;
		listtail->_nx=wnd;
	}
	listtail=wnd;
	if(!listhead)
		listhead=wnd;
}

static beg_list(WINDOW *wnd)
{	if(listhead){
		NEXT=listhead;
		listhead->_pv=wnd;
	}
	listhead=wnd;
	if(!listtail)
		listtail=wnd;
}

static remove_list(WINDOW *wnd)
{	if(NEXT)
		NEXT->_pv=PREV;
	if(PREV)
		PREV->_nx=NEXT;
	if(listhead==wnd)
		listhead=NEXT;
	if(listtail==wnd)
		listtail=PREV;
	NEXT=PREV=NULL;
}

static insert_list(WINDOW *w1,WINDOW *w2)
{	w1->_pv=w2;
	w1->_nx=w2->_nx;
	w2->_nx=w1;
	if(w1->_nx==NULL)
		listtail=w1;
	else
		w1->_nx->_pv=w1;
}

#ifndef FASTWINDOWS
static verify_wnd(WINDOW **w1)
{       WINDOW *wnd;
	wnd=listhead;
	if(*w1==NULL)
		*w1=listtail;
	else{
		while(wnd!=NULL){
		if(*w1==wnd)
			break;
		wnd=NEXT;
		}
	}
	return wnd!=NULL;
}
#endif

WINDOW *ewnd=NULL;
void error_message(char *s)
{	ewnd=establish_window(50,22,3,max(10,strlen(s)+2));
	set_colors(ewnd,ALL,RED,YELLOW,BRIGHT);
	set_title(ewnd,"ERROR!");
	display_window(ewnd);
	wprintf(ewnd,s);
	putchar(BELL);
}

void clear_message()
{	if(ewnd)
		delete_window(ewnd);
	ewnd=NULL;
}
