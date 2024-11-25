#include "twindow.h"
#include "keys.h"
main()
{
  WINDOW *wnd,*wnd2;
  int c;
  clrscr();
  wnd=establish_window(10,10,10,10);
  wnd2=establish_window(12,12,12,12);
  set_colors(wnd,ALL,RED,BLUE,BRIGHT);
  wprintf(wnd,"1111111");
  wprintf(wnd2,"22222222");
  display_window(wnd);
  display_window(wnd2);
  do{
      c=get_char();
      wprintf(wnd2,"\n0000000000000000");
      }while (c!=ESC);
  close_all();
}
