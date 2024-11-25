#include "twindow.h"
#include "keys.h"
main()
{
  WINDOW * wnd;
  wnd=establish_window(10,10,10,10);
  wprintf(wnd,"1:okokoko");
  wprintf(wnd,"1:okokoko");
  wprintf(wnd,"1:okokoko");
  wprintf(wnd,"1:okokoko");
  wprintf(wnd,"1:okokoko");
  display_window(wnd);
  }
