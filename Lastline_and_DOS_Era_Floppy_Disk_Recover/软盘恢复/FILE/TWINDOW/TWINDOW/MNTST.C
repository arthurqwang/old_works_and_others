#include "twindow.h"
#include "keys.h"
main()
{
  WINDOW *mnwnd,*wnd;
  int i,s,c;
  system("cls");
  mnwnd=establish_window(10,10,10,20);
  wnd=establish_window(16,14,10,20);
  set_colors(mnwnd,BORDER,GREEN,WHITE,BRIGHT);
  set_colors(mnwnd,NORMAL,BLUE,YELLOW,BRIGHT);
  set_colors(mnwnd,TITLE,BLACK,RED,BRIGHT);
  set_colors(mnwnd,ACCENT,MAGENTA,AQUA,BRIGHT);
  set_border(mnwnd,2);
  set_title(mnwnd,"test");

/*  displ(mnwnd,1,1,'a',clr(BLUE,RED,BRIGHT));*/
  wprintf(mnwnd,"1:께께께께께\n");
  wprintf(mnwnd,"2:께께께께께\n");
  wprintf(mnwnd,"3:께께께께께\n");
  wprintf(mnwnd,"4:께께께께께");
  display_window(mnwnd);
  display_window(wnd);
  wprintf(wnd,"2:bbbbbBbbbbbbbbb\n");
  wprintf(wnd,"3:ccccccCccc\n");
  wprintf(wnd,"4:dddddddDdddddddddddd");

/*  get_char();
  set_intensity(mnwnd,DIM);
  getch();
  clear_window(mnwnd);
  getch();
  hide_window(mnwnd);
  getch();
  display_window(mnwnd);

  getch();
  wprintf(mnwnd,"\n123456\n");
  getch();

  reverse_video(mnwnd);
  wprintf(mnwnd,"\nabcdefghijklm");
  normal_video(mnwnd);
  wprintf(mnwnd,"\nabcdefghijklm");
  getch();
  delete_window(mnwnd);*/

  load_help("tcprogs.hlp");
  set_help("menu    ",40,10);

/*  getch();
  set_colors(mnwnd,BORDER,GREEN,WHITE,BRIGHT|BLINK);
  rmove_window(mnwnd,10,0);
  getch();
  set_colors(mnwnd,BORDER,GREEN,WHITE,BRIGHT);*/
  get_selection(mnwnd,1,"123");
      close_all();

}