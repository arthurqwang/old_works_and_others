#include "twindow.h"
#include "keys.h"
main()
 {
    WINDOW *wnd;
    int c;
    wnd=establish_window(10,10,5,15);
    display_window(wnd);
    wprintf(wnd,"\n\n\noooooooo\nkkkk");
    do{
	c=get_char();
	wprintf(wnd,"\n%d",c);
      }while(c!=ESC);
 }
