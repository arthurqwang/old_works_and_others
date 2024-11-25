#include <stdio.h>
#include <ctype.h>
#include <stdarg.h>
#include <dos.h>
#include <alloc.h>
#include <stdlib.h>
#include <string.h>
#include "twindow.h"
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
void split_window(WINDOW*);
#ifndef FASTWINDOWS

int dget(WINDOW *wnd,int x,int y);
verify_wnd(WINDOW **w1);
#endif

int open_hmenu(WINDOW *wnd,
		char *title,int ttbg,int ttfg,int ttinten,
		char **hmnnames,int hmnbg,int hmnfg,int hmninten,
		char *keys,int kchbg,int kchfg,int kchinten,
		int bdtype,int bdbg,int bdfg,int bdinten,
		int nmlbg,int nmlfg,int nmlinten,
		char *cfirst_line,int dfirst_line[]);

int print_menu_name(WINDOW *wnd,char **hmnnames,int hmnbg,int hmnfg,int hmninten,
				char *keys,int kchbg,int kchfg,int kchinten);
void get_1st_line(WINDOW *wnd,char *cfirst_line,int dfirst_line[]);
int compute_tabstep(WINDOW *wnd,char **hmnnames);
int get_hselection(WINDOW *wnd,int s,int num,char **hmnnames,char *keys,
			char *cfirst_line,int dfirst_line[],
			int acbg,int acfg,int acinten);
void light(WINDOW *wnd,int hsel,char **hmnnames,char *cfirst_line,
		       int acbg,int acfg,int acinten);
void delight(WINDOW *wnd,char *cfirst_line,int dfirst_line[]);
struct{
	int nw,ne,se,sw,side,line;
}wcs[]={
	{218,191,217,192,179,196},
	{201,187,188,200,186,205},
	{214,183,189,211,186,196},
	{213,184,190,212,179,205},
	{194,194,217,192,179,196},
};

WINDOW *listhead=NULL;
WINDOW *listtail=NULL;
int VSG;

WINDOW *establish_window(x,y,h,w)
{	WINDOW *wnd;
	VSG=(vmode()==7?0xb000:0xb800);
	if((wnd=(WINDOW *)malloc(sizeof(WINDOW)))==NULL)
		return NULL;
	WTITLE="";
	HEIGHT=min(h,SCRNHT);
	WIDTH=min(w,SCRNWIDTH);
	COL=max(0,min(x,SCRNWIDTH-WIDTH));
	ROW=max(0,min(y,SCRNHT-HEIGHT));
	WCURS=0;
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
		for(x=1;x<WIDTH-1;x++){
			chat=dget(wnd,x,y);
	/*		atr=(((chat>>8)&255)==PNORMAL?WNORMAL:WACCENT);*/
			atr=(chat>>8)&255;
			if(atr==PNORMAL)  atr=WNORMAL;
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
	if(!verify_wnd(&wnd))
		return;
	twnd=establish_window(x+COL,y+ROW,HEIGHT,WIDTH);
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
			for(xl=1;xl<WIDTH-1;xl++)
				displ(wnd,xl,yl,' ',WNORMAL);
}

static wframe(WINDOW *wnd)
{	register int xl,yl;
	if(!verify_wnd(&wnd))
		return;
	displ(wnd,0,0,NW,WBORDER);
	dtitle(wnd);
	displ(wnd,WIDTH-1,0,NE,WBORDER);
	for(yl=1;yl<HEIGHT-1;yl++){
		displ(wnd,0,yl,SIDE,WBORDER);
		displ(wnd,WIDTH-1,yl,SIDE,WBORDER);
	}
	displ(wnd,0,yl,SW,WBORDER);
	for(xl=1;xl<WIDTH-1;xl++)
		displ(wnd,xl,yl,LINE,WBORDER);
		displ(wnd,xl,yl,SE,WBORDER);
}

static dtitle(WINDOW *wnd)
{	int xl=1,i,ln;
	char *s=WTITLE;
	if(!verify_wnd(&wnd))
		return;
	if(s){
		ln=strlen(s);
		if(ln>WIDTH-2)
			i=0;
		else
			i=((WIDTH-2-ln)/2);
		if(i>0)
			while(i--)
			displ(wnd,xl++,0,LINE,WBORDER);
		while(*s&&xl<WIDTH-1)
			displ(wnd,xl++,0,*s++,WTITLEC);
	}
	while(xl<WIDTH-1)
		displ(wnd,xl++,0,LINE,WBORDER);
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
	wcursor(wnd,WCURS,SCROLL);
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
	wcursor(wnd,WCURS,SCROLL);
}

void wputchar(WINDOW *wnd,int c)
{	if(!verify_wnd(&wnd))
		return;
	switch(c){
		case '\b':
		     WCURS--;
		     break;
		case '\n':
			if(SCROLL==HEIGHT-3)
				scroll(wnd,UP);
			else
				SCROLL++;
			WCURS=0;
			break;
		case '\t':
			do displ(wnd,(WCURS++)+3,SCROLL+1,' ',WNORMAL);
				while((WCURS%TABS)&&(WCURS+1)<WIDTH-1);
			break;
		default:
			if((WCURS+1)<WIDTH-1){
				displ(wnd,WCURS+1,SCROLL+1,c,WNORMAL);
				WCURS++;
			}
			break;
	}
}
void split_window(WINDOW *wnd)
 {
  int x;
  for(x=1;x<=WIDTH-1;x++)
   wputchar(wnd,196);
   wputchar(wnd,'\n');
 }

void wclrputchar(WINDOW *wnd,int c,int bg,int fg,int inten)
{	if(!verify_wnd(&wnd))
		return;
	switch(c){
                case '\b':
		     WCURS--;
		     break;
		case '\n':
			if(SCROLL==HEIGHT-3)
				scroll(wnd,UP);
			else
				SCROLL++;
			WCURS=0;
			break;
		case '\t':
			do displ(wnd,(WCURS++)+3,SCROLL+1,' ',clr(bg,fg,inten));
				while((WCURS%TABS)&&(WCURS+1)<WIDTH-1);
			break;
		default:
			if((WCURS+1)<WIDTH-1){
				displ(wnd,WCURS+1,SCROLL+1,c,clr(bg,fg,inten));
				WCURS++;
			}
			break;
	}
}

void wcursor(WINDOW *wnd,int x,int y)
{	if(verify_wnd(&wnd)&&x<WIDTH-1&&y<HEIGHT-1){
		WCURS=x;
		SCROLL=y;
		cursor(COL+x+1,ROW+y+1);
	   }
}


int get_selection(WINDOW *wnd,int s,char *keys,int bg,int fg,int inten)
{	int c=0,ky,d,move_step=1,prvbrdrclr=WCOLOR[BORDER];
	int line=1,ch,cch,x,loca[50],totallines;
	int maxselect=0,have=0,len_keys=strlen(keys);
	ky=0;
	if(!verify_wnd(&wnd))
		return 0;

	while(line<HEIGHT-1 )
	  { have=0;
	    for(x=1;x<=WIDTH-2;x++)
	     if((dget(wnd,x,line)&255)!=' ') {have=1;break;}
	    if (!have) break;
            if((ch=dget(wnd,1,line)&255)==196)
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
	    for (x=1;x<=WIDTH-1;x++)
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
				for (x=1;x<=WIDTH-1;x++)
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
				if((ch=dget(wnd,1,line-1)&255)==196) line--;
				line--;
				if(line>0)
					SELECT--;
				else
					{SELECT=maxselect;line=totallines;}
				break;
			case DN:
                        	deaccent(wnd,line);
				if(SELECT<=len_keys){

				for (x=1;x<=WIDTH-1;x++)
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
                                if((ch=dget(wnd,1,line+1)&255)==196) line++;
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
						case ESC:delete_window(wnd);return 0;
						default:break;
					    }
				    }while(d!=F2);
				    WCOLOR[BORDER] =prvbrdrclr;
				    redraw(wnd);
				break;
			#endif
			
			case ESC:
			case FWD:
			case BS:delete_window(wnd);break;
                        case '\r':
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
		rg.h.cl=COL+1;
		rg.h.ch=ROW+1;
		rg.h.dl=COL+WIDTH-2;
		rg.h.dh=ROW+HEIGHT-2;
		int86(16,&rg,&rg);
		return;
	}
	if(dir==UP){
		for(row=2;row<HEIGHT-1;row++)
			for(col=1;col<WIDTH-1;col++){
				chat=dget(wnd,col,row);
				displ(wnd,col,row-1,chat&255,(chat>>8)&255);
			}
	/*	for(row=HEIGHT-2;row>1;--row)
			for(col=1;col<WIDTH-1;col++){
				chat=dget(wnd,col,row-1);
				displ(wnd,col,row,chat&255,(chat>>8)&255);
			}*/
		for(col=1;col<WIDTH-1;col++)
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
		vpoke(VSG,vad(x+COL,y+ROW),vch);
}

static int dget(WINDOW *wnd,int x,int y)
{	int *vp;
	if((vp=waddr(wnd,x,y))!=NULL)
		return *vp;
	return vpeek(VSG,vad(x+COL,y+ROW));
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
			*bf++=vpeek(VSG,vad(x+COL,y+ROW));
}

static vrstr(WINDOW *wnd)
{	int x,y;
	int *bf=(int *)SAV;
	for(y=0;y<HEIGHT;y++)
		for(x=0;x<WIDTH;x++)
			vpoke(VSG,vad(x+COL,y+ROW),*bf++);
}
#endif

void acline(WINDOW *wnd,int set,int line)
{	int x,ch;
	if(!verify_wnd(&wnd))
		return;
	  for(x=1;x<WIDTH-1;x++){
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
/*Used in horizenal menu*/
int open_hmenu(WINDOW *wnd,
		char *title,int ttbg,int ttfg,int ttinten,
		char **hmnnames,int hmnbg,int hmnfg,int hmninten,
		char *keys,int kchbg,int kchfg,int kchinten,
		int bdtype,int bdbg,int bdfg,int bdinten,
		int nmlbg,int nmlfg,int nmlinten,
		char *cfirst_line,int dfirst_line[])
{
  int num;
  set_border(wnd,bdtype);
  set_title(wnd,title);
  set_colors(wnd,TITLE,ttbg,ttfg,ttinten);
  set_colors(wnd,BORDER,bdbg,bdfg,bdinten);
  set_colors(wnd,NORMAL,nmlbg,nmlfg,nmlinten);
  display_window(wnd);
  num=print_menu_name(wnd,hmnnames,hmnbg,hmnfg,hmninten,
			  keys,kchbg,kchfg,kchinten);
  get_1st_line(wnd,cfirst_line,dfirst_line);
  /*hsele=get_hselection(wnd, hsele, num,hmnnames,keys,
			cfirst_line,dfirst_line,
			acbg,acfg,acinten);*/

  return num;
}

int print_menu_name(WINDOW *wnd,char **hmnnames,int hmnbg,int hmnfg,int hmninten,
				char *keys,int kchbg,int kchfg,int kchinten)
{
  int tabstep,i=0,x;
  tabstep=compute_tabstep(wnd,hmnnames);
  for(x=1;x<WIDTH;x++)
     wclrputchar(wnd,' ',hmnbg,hmnfg,hmninten);
  wcursor(wnd,2,0);
  while(*(hmnnames+i))
    {
      int j=0,ch;
      while(ch=*(*(hmnnames+i)+j))
	{
	 if(ch==*(keys+i))
	   wclrputchar(wnd,ch,kchbg,kchfg,kchinten);
	 else
	   wclrputchar(wnd,ch,hmnbg,hmnfg,hmninten);
	 j++;
	}
      i++;
      WCURS+=tabstep;
    }
  return i;
}
void get_1st_line(WINDOW *wnd,char *cfirst_line,int dfirst_line[])
 {
  int x,ch,i=0;
  for(x=1;x<WIDTH-1;x++)
    {
      ch=dget(wnd,x,1);
      *(cfirst_line+i)=ch&255;
      *(dfirst_line+i)=(ch>>8)&255;
      i++;
    }
  *(cfirst_line+i)='\0';
 }




int compute_tabstep(WINDOW *wnd,char **hmnnames)
{
  int tlen=0,num=0;
  while(*(hmnnames+num))
    {
     tlen+=strlen(*(hmnnames+num));
     num++;
    }
    return (WIDTH-4-tlen)/(num+1);
  }

int get_hselection(WINDOW *wnd,int s,int num,char **hmnnames,char *keys,
			char *cfirst_line,int dfirst_line[],
			int acbg,int acfg,int acinten)
  {
   int ch=0,hsel,ky,d,move_step=1,prvbrdrclr=WCOLOR[BORDER];
   hsel=s;
   if (hsel<1||hsel>num) hsel=1;
   while(ch!=ESC&&ch!='\r')
     {
       delight(wnd,cfirst_line,dfirst_line);
       light(wnd,hsel,hmnnames,cfirst_line,acbg,acfg,acinten);
       ch=get_char();

       switch(ch)
	{
	 case FWD:
         	delight(wnd,cfirst_line,dfirst_line);
		hsel++;
		if(hsel>num)hsel=1;
		break;
	 case BS:
         	delight(wnd,cfirst_line,dfirst_line);
		hsel--;
		if (hsel<1 )hsel=num;
		break;
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
	 case '\r':
	 case ESC: break;
	 default:
		if(strlen(keys)>num) *(keys+num)='\0';
		if(*keys)
		 {
		   ky=0;
		   while(*(keys+ky)){
		    if(*(keys+ky)==toupper(ch)||*(keys+ky)==tolower(ch))
		    return ky+1;
		    ky++;
		   }
		  }
		 break;
	 }
     }
   return ch==ESC?0:hsel;
  }

void light(WINDOW *wnd,int hsel,char **hmnnames,char *cfirst_line,
		       int acbg,int acfg,int acinten)
{
  int loca;
  loca=strstr(cfirst_line,*(hmnnames+hsel-1))-cfirst_line;
  wcursor(wnd,loca,0);
  wclrprintf(wnd,acbg,acfg,acinten,*(hmnnames+hsel-1));
  cursor(0,SCRNHT);
}
void delight(WINDOW *wnd,char *cfirst_line,int dfirst_line[])
{
  int x;
  for(x=1;x<WIDTH-1;x++)
  displ(wnd,x,1,*(cfirst_line+x-1),*(dfirst_line+x-1));
}
