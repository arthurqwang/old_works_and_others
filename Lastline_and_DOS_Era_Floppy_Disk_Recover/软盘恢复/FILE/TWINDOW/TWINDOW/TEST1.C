#include "twindow.h"
#include "keys.h"
main()
 {
   WINDOW *wnd;
   int c;
   system("mkscr");
   wnd=establish_window(10,10,10,20);
   set_colors(wnd,ALL,BLUE,RED,DIM);
   display_window(wnd);
   do {
	c=get_char();
	switch(c){
	  case FWD:rmove_window(wnd,1,0);break;
	  case BS:rmove_window(wnd,-1,0);break;
	  case UP:rmove_window(wnd,0,-1);break;
	  case DN:rmove_window(wnd,0,1);break;
	  default:break;
	  }
	}while(c!=ESC);
	delete_window(wnd);
	get_char();
   }