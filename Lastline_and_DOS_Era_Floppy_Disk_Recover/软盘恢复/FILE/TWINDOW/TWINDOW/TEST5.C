#include "twindow.h"
#include "keys.h"
main()
{
  WINDOW *wnd;
  int s=1;
  wnd=establish_window(10,10,10,20);
  set_colors(wnd,BORDER,WHITE,BLUE,BRIGHT);
  set_colors(wnd,TITLE,GREEN,YELLOW,DIM);
  set_colors(wnd,NORMAL,BLACK,RED,DIM);
  set_colors(wnd,ACCENT,AQUA,GREEN,BRIGHT);
  set_title(wnd,"test5");
  wprintf(wnd,"1:hhhhhhhhjhj\n");
  wprintf(wnd,"2:hhhhhhhhjhj\n");
  wprintf(wnd,"3:hhhhhhhhjhj\n");
  wprintf(wnd,"4:hhhhhhhhjhj\n");
  wprintf(wnd,"5:hhhhhhhhjhj");
  display_window(wnd);
  load_help("tcprogs.hlp");
  set_help("menu    ",40,10);
  do{
      s=get_selection(wnd,s,"12345");
      switch(s){
	  case 1:printf("%d  111111111111111",s);break;
	  case 2:printf("%d  222222222222222",s);break;
	  case 3:printf("%d  333333333333333",s);break;
	  case 4:printf("%d  444444444444444",s);break;
	  case 5:printf("%d  555555555555555",s);break;
	  default:break;
	 }
    }while(s!=0);
  getch();
  close_all();
  }
