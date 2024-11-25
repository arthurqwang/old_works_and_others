#include "twindow.h"
#include "keys.h"
main()
  {
    WINDOW *wnd;
    system("cls");
    wnd=establish_window(10,10,10,10);
    set_colors(wnd,BORDER,RED,BLUE,DIM);
    set_colors(wnd,ACCENT,GREEN,BLACK,DIM);
    set_colors(wnd,NORMAL,WHITE,YELLOW,BRIGHT);
    wprintf(wnd,"hjjhghjhgjghjghjghj\n");
    display_window(wnd);
    getch();
    set_colors(wnd,BORDER,RED,BLUE,BRIGHT);
    rmove_window(wnd,10,0);
    getch();
    set_colors(wnd,BORDER,RED,BLUE,DIM);

    getch();
    close_all();
   }