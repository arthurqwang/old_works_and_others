#include "twindow.h"
#include "keys.h"
main()
{
  WINDOW * wnd;
  wnd=establish_window(10,10,10,10);
  wprintf(wnd,"1:okokoko\n");
  wprintf(wnd,"1:okokoko\n");
  wprintf(wnd,"1:okokoko\n");
  wprintf(wnd,"1:okokoko\n");
  wprintf(wnd,"1:okokoko\n");
  set_colors(wnd,ALL,BLUE,WHITE,BRIGHT);
  set_colors(wnd,ACCENT,RED,YELLOW,BRIGHT);
  display_window(wnd);
  get_selection(wnd,1,"1234");
  getch();
  close_all();
  }
