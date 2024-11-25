/*NOTE:This will demage MAINBOOT*/
#include "twindow.h"
main()
{
  WINDOW *wnd,*white;
  char a[512];
  int i;
  biosdisk(3,0x80,0,0,1,1,a);
  set_cursor_type(-1);
  wnd=establish_window(0,0,15,80);
  white=establish_window(0,14,4,80);
  set_colors(wnd,NORMAL,BLUE,RED,BLINK);
  set_colors(wnd,BORDER,BLUE,BLUE,DIM);
  set_colors(white,ALL,WHITE,WHITE,BRIGHT);
  set_colors(white,BORDER,WHITE,WHITE,DIM);
  wclrprintf(wnd,YELLOW,RED,BLINK,"\n\n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"            л               л               л               л               л\n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"      л    л          л    л          л    л          л    л          л    л \n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"    лл   ллл        лл   ллл        лл   ллл        лл   ллл        лл   ллл \n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"   ллл  лллл       ллл  лллл       ллл  лллл       ллл  лллл       ллл  лллл \n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"  ллл   ллл       ллл   ллл       ллл   ллл       ллл   ллл       ллл   ллл  \n");
  wclrprintf(wnd,YELLOW,RED,BLINK," лллллллллл      лллллллллл      лллллллллл      лллллллллл      лллллллллл  \n");
  wclrprintf(wnd,YELLOW,RED,BLINK," ллллллллллл     ллллллллллл     ллллллллллл     ллллллллллл     ллллллллллл \n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"лллллллллллл    лллллллллллл    лллллллллллл    лллллллллллл    лллллллллллл \n");
  wclrprintf(wnd,YELLOW,RED,BLINK," лллллллллллл    лллллллллллл    лллллллллллл    лллллллллллл    лллллллллллл\n");
  wclrprintf(wnd,YELLOW,RED,BLINK," лллллллллллл    лллллллллллл    лллллллллллл    лллллллллллл    лллллллллллл\n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"  лллллллллл      лллллллллл      лллллллллл      лллллллллл      лллллллллл \n");
  wclrprintf(wnd,YELLOW,RED,BLINK,"  лллллллллл      лллллллллл      лллллллллл      лллллллллл      лллллллллл ");
  display_window(white);
  display_window(wnd);
}