#include "twindow.h"
#include "keys.h"
main()
  {
    WINDOW *wnd;
    wnd=establish_window(10,10,10,20);
    set_colors(wnd,ALL,RED,BLUE,BRIGHT);
    wprintf(wnd,"okokokokoko\n");

    display_window(wnd);
    get_char();
    delete_window(wnd);
  }
