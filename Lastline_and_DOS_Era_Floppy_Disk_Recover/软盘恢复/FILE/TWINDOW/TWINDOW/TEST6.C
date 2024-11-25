#include "twindow.h"
#include <stdio.h>
#include <string.h>
#include <dos.h>
  char bg[5],ed[5],stp[3],a[5],b[6];
  char bgg[]="____";
  char edd[]="____";
  char stpp[]="__";
  char bb[]="_____";
  char aa[]="____";
main()
{
  WINDOW *wnd;
  FIELD *fld;
  system("cls");
  load_help("tcprogs.hlp");
  wnd=establish_window(10,10,10,50);
  set_colors(wnd,ALL,RED,GREEN,BRIGHT);
  set_colors(wnd,ACCENT,AQUA,BLACK,BRIGHT);
  display_window(wnd);
  wprompt(wnd,2,2,"Begginning number:");
  wprompt(wnd,2,3,"End number:");
  wprompt(wnd,2,4,"Step number:");
  wprompt(wnd,2,5,"aaaaaa:");
  wprompt(wnd,2,6,"bbbbbbbbb:");
  init_template(wnd);
  fld=establish_field(wnd, 25,2,bgg,bg,'n');
  field_window(fld,"name    ",40,1);
  fld=establish_field(wnd, 25,3,edd,ed,'Z');
  fld=establish_field(wnd, 25,4,stpp,stp,'A');
  fld=establish_field(wnd, 25,5,aa,a,'A');
  fld=establish_field(wnd, 25,6,bb,b,'A');
  clear_template(wnd);
  data_entry(wnd);
  delete_window(wnd);
  printf("\n\n\nbg=%s\ned=%s\nstp=%s\na=%s\nb=%s\n",bg,ed,stp,a,b);
  getch();
  }
