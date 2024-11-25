/*******************************************************************
  File name:     TWINDOW.H
  Belong to:     LASTLINE 2.5 English version
  Date:          8/24/94
  Author:        WangQuan
  Function:      To be .H file of TWINDOW.C and the other .C file
		 in LASTLINE 2.5 English version.
  Usage:         #include "twindow.h"
  Where stored:  Floppy disk "LASTLINE 2.5 English version
		 Source files"(LASTLINE 2.5 Yingwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/


	/*------------ twindow.h ------------ */

	/*---------- window colors --------- */
/*	#define FASTWINDOWS*/
	#define RED 4
	#define GREEN  2
	#define BLUE  1
	#define WHITE  (RED+GREEN+BLUE)
	#define YELLOW   (RED+GREEN)
	#define AQUA  (GREEN+BLUE)
	#define MAGENTA (RED+BLUE)
	#define BLACK  0
	#define BRIGHT  8
	#define DIM  0
	#define BLINK 0x80
	#define BORDER 0
	#define TITLE 1
	#define ACCENT 2
	#define NORMAL 3
	#define ALL 4
	#define TRUE  1
	#define FALSE 0
	#define ERROR -1
	#define OK  0
	/* int fg,bg,in; */
	/*---------- window controller structures -----  */
	typedef struct field {
	char *fmask;
	int fprot;
	char *fbuff;
	int ftype;
	int frow;
	int fcol;
	void (*fhelp)();
	char *fhwin;
	int flx,fly;
	int (*fvalid)();
	struct field *fnxt;
	struct field *fprv;
	}FIELD;
	typedef struct _wnd {
	int _wv;
	int _hd;
	char *_ws;
	char *_tl;
	int _wx;
	int _wy;
	int _ww;
	int _wh;
	int _wsp;
	 int _sp;
	 int _cr;
	 int btype;
	 int wcolor[4];
	 int _pn;
	 struct _wnd *_nx;
	 struct _wnd *_pv;
	 FIELD *_fh;
	 FIELD *_ft;
	 } WINDOW;
	 typedef struct w_menu {
	 char *mname;
	 char **mselcs;
	 void (* *func)();
	 } MENU;
	 #define SAV   (wnd->_ws)
	 #define WTITLE  (wnd->_tl)
	 #define COL  (wnd->_wx)
	 #define ROW (wnd->_wy)
	 #define WIDTH  (wnd->_ww)
	 #define HEIGHT (wnd->_wh)
	 #define SCROLL (wnd->_wsp)
	 #define SELECT    (wnd->_sp)
	 #define WCURS (wnd->_cr)

	 #define WBORDER (wnd->wcolor[BORDER])
	 #define WTITLEC (wnd->wcolor[TITLE])
	 #define WACCENT  (wnd->wcolor[ACCENT])

	 #define WNORMAL  (wnd->wcolor[NORMAL])
	 #define PNORMAL (wnd->_pn)
	 #define BTYPE   (wnd->btype)

	 #define NEXT   (wnd->_nx)
	 #define PREV  (wnd->_pv)
	 #define WCOLOR  (wnd->wcolor)
	 #define VISIBLE  (wnd->_wv)
	 #define HIDDEN  (wnd->_hd)
	 #define FHEAD   (wnd->_fh)
	 #define FTAIL   (wnd->_ft)
	 #define NW    (wcs[wnd->btype].nw)
	 #define NE    (wcs[wnd->btype].ne)
	 #define SE    (wcs[wnd->btype].se)
	 #define SW    (wcs[wnd->btype].sw)
	 #define SIDE  (wcs[wnd->btype].side)
	 #define LINE (wcs[wnd->btype].line)
	 /*------ function protypes and macros ----*/
	 /*----- general purpose functions and macros -----*/
	 void clear_screen(void);
	 int vmode(void);
	 void cursor(int,int);
	 int cursor_type (void);
	 void set_cursor_type(int);
	 int get_char(void);
	 int get_ch(void); /* Without pre_enter*/
	 int scroll_lock(void);
	 void vpoke(unsigned,unsigned,unsigned);
	 int vpeek(unsigned,unsigned);

	 /*------windiow functions and macros----*/

	 WINDOW *establish_window(int,int,int,int);
	 void set_border(WINDOW *,int);
	 void set_colors(WINDOW *,int,int,int,int);
	 void set_intensity(WINDOW *,int);
	 void set_title (WINDOW *,char *);
	 void display_window(WINDOW *);
	 void delete_window(WINDOW *);
	 void clear_window(WINDOW *);
	 void hide_window(WINDOW *);
	 void wprintf (WINDOW *,char *,...);
	 void wclrprintf(WINDOW *,int,int,int,char *,...);
	 void wputchar(WINDOW *,int );
	 void wclrputchar(WINDOW *,int,int,int,int);
	 void close_all (void);
	 void wcursor (WINDOW *,int x,int y);
	 void error_message (char *);
	 void clear_message (void);
	 int  get_selection(WINDOW *,int, char *,int, int ,int);
	 #define reverse_video(wnd) wnd->wcolor[3]=wnd->wcolor[2]
	 #define normal_video(wnd)  wnd->wcolor[3]=wnd->_pn
	 #define rmove_window(wnd,x,y)  repos_wnd(wnd,x,y,0)
	 #define move_window(wnd,x,y)  repos_wnd(wnd,COL-x,ROW-y,0)

	 #define forefront(wnd)  repos_wnd(wnd,0,0,1)
	 #define rear_window(wnd)  repos_wnd (wnd,0,0,-1)
	 #define vpoke(vseg,adr,chr) poke(vseg,adr,chr)
	 #define vpeek(vseg,adr) peek(vseg,adr)

	 /*------- internal to window processes -----*/

	 void accent (WINDOW *,int);
	 void deaccent (WINDOW *,int);
	 void scroll (WINDOW *,int);
	 void repos_wnd (WINDOW *,int,int,int);
	 void acline (WINDOW *,int,int);
	 #define accent(wnd,x)  acline(wnd,WACCENT,x)
	 #define deaccent(wnd,x)  acline (wnd,WNORMAL,x)
	 #define  clr(bg,fg,in)  ((fg)|(bg<<4)|(in))
	 #define vad(x,y)  ((y)*160+(x)*2)
	 #ifdef FASTWINDOWS
	 #define cht(ch,at)  (((ch)&255|((at<<8))
	 #define displ(w,x,y,c,a) vpoke(VSG,vad(x+COL,y+ROW),cht(c,a))
	 #define dget(w,x,y)  vpeek(VSG,vad(x+COL,y+ROW))
	 #define verify_wnd(w)   (*(w)=listtail)!=0
	 #else
	 void displ(WINDOW * wnd,int x,int y, int ch, int at);
	 #endif
	 /*  ----- editor ----*/
	 void text_editor(WINDOW *,char *,unsigned);
	 /* ---- menu function --- */
	 void menu_select(char *name,MENU *mn);
	 /*------- help function ----*/
	 void load_help(char *);
	 void set_help(char *,int,int);
	 /* ---- data  enter function ---*/
	 void init_template(WINDOW *);
	 FIELD *establish_field(WINDOW *,int,int,char *,char *,int);
	 void clear_tempate(WINDOW *);
	 void field_tally(WINDOW *);
	 int data_entry(WINDOW *);
	 void wprompt (WINDOW *,int ,int,char *);
		 void error_message (char *);
	 void clear_notice(void);

	 void field_window(FIELD *,char *,int,int);
	 # define field_protect(f,s)  f->fprot=s
	 #define field_help(f,h)   f->fhelp=h

	 #define field_validate(f,v)   f->fvalid=v

































































