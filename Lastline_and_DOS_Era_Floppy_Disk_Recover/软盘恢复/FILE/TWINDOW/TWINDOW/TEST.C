#include "twindow.h"
#include "keys.h"
main()
  {
    WINDOW *wndA,*wndB;
    int c;
    wndA=establish_window(1,1,20,50);
    wndB=establish_window(3,10,8,15);
    set_colors(wndA,ALL,YELLOW,BLUE,DIM);
    set_colors(wndB,ALL,GREEN,RED,BRIGHT);
    display_window(wndA);
    display_window(wndB);
    shadow(wndB);
    wprintf(wndA,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    wprintf(wndA,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    wprintf(wndA,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    wprintf(wndA,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    wprintf(wndA,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    wprintf(wndA,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    wprintf(wndB,"\n\nhjerhjghjrh\nyuweyuyufyufyufyuf\nhhg");
    do{
       c=get_char();
       switch(c){
	 case FWD:{reshadow(wndB);rmove_window(wndB,1,0);shadow(wndB);};break;
	 case BS:{reshadow(wndB);rmove_window(wndB,-1,0);shadow(wndB);};break;
	 case UP:{reshadow(wndB);rmove_window(wndB,0,-1);shadow(wndB);};break;
	 case DN:{reshadow(wndB);rmove_window(wndB,0,1);shadow(wndB);};break;
	 default:break;
	 } }while(c!=ESC);
    }


