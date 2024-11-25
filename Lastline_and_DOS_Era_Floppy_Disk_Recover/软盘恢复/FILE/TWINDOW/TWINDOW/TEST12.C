#include <stdio.h>
#include "twindow.h"
#include "keys.h"
main()
{
  WINDOW *wnd,*bgwnd,*dnwnd;
  int num,d[80],s=1;
  char c[80],*names[]={
		"File","Edit","Run","Compile","Project","Options","Debug","Break/watch",0};
  wnd=establish_window(0,0,2,80);
  dnwnd=establish_window(0,22,2,80);
  set_colors(dnwnd,BORDER,BLACK,BLACK,DIM);
  wclrprintf(dnwnd,WHITE,RED,DIM," F1");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-HELP  ");
  wclrprintf(dnwnd,WHITE,RED,DIM," F5");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-Zoom  ");
  wclrprintf(dnwnd,WHITE,RED,DIM," F6");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-Switch  ");
  wclrprintf(dnwnd,WHITE,RED,DIM," F7");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-Trace  ");
  wclrprintf(dnwnd,WHITE,RED,DIM," F8");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-Step  ");
  wclrprintf(dnwnd,WHITE,RED,DIM," F9");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-Make  ");
  wclrprintf(dnwnd,WHITE,RED,DIM," F10");
  wclrprintf(dnwnd,WHITE,BLACK,DIM,"-Menu      ");
  display_window(dnwnd);
  num=open_hmenu(wnd,/*"MYSOFTWARE (C) COPYRIGHT MAY 1993.BY WANGQUAN."*/"",RED,YELLOW,DIM,
		 names,WHITE,BLACK,DIM,"FERCPODB",WHITE,RED,DIM,
		 2,BLACK,BLACK,DIM,BLUE,YELLOW,DIM,c,d);
  bgwnd=establish_window(1,2,21,78);
  set_border(bgwnd,3);
  set_colors(bgwnd,ALL,BLUE,WHITE,DIM);
  set_colors(bgwnd,TITLE,BLUE,WHITE,BRIGHT);
  set_title(bgwnd," Edit ");
  wcursor(bgwnd,6,0);
  wprintf(bgwnd,"Line      Col     Insert Indent Tab Fill Unindent   NONAME.C");
  wcursor(bgwnd,0,bgwnd->_wh-4);
  wprintf(bgwnd,"-----");
  wcursor(bgwnd,34,bgwnd->_wh-4);
  wprintf(bgwnd," Watch ");
  display_window(bgwnd);
  while(s!=ESC){
  WINDOW *wndd;
  s=get_hselection(wnd,s,num,names,"FERCPODB",c,d,BLACK,WHITE,BRIGHT);
  switch(s){
    case 1:
       wndd=establish_window(2,2,11,16);
       set_colors(wndd,ALL,WHITE,BLACK,DIM);
       set_colors(wndd,ACCENT,BLACK,WHITE,BRIGHT);
       wprintf(wndd," Load      F3\n");
       wprintf(wndd," Pick  Alt-F3\n");
       wprintf(wndd," New\n");
       wprintf(wndd," Save      F2\n");
       wprintf(wndd," Write to\n");
       wprintf(wndd," Directory\n");
       wprintf(wndd," Change dir\n");
       wprintf(wndd," OS shell\n");
       wprintf(wndd," Quit  Alt-X");
       display_window(wndd);
       get_selection(wndd,1,"LPNSWDCOQ",WHITE,RED,DIM);
       break;

  }
}
}