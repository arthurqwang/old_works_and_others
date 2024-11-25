#include "twindow.h"
#include "keys.h"
main()
 {
   WINDOW *wndA,*wndB,*wndC;
   int c;
   system("cls");
   wndA=establish_window(1,1,5,15);
   wndB=establish_window(5,2,5,10);
   wndC=establish_window(6,5,6,7);
   set_colors(wndA,ALL,RED,YELLOW,BRIGHT);
   set_colors(wndB,ALL,AQUA,YELLOW,DIM);
   set_colors(wndC,ALL,YELLOW,WHITE,BRIGHT);
   display_window(wndA);
   display_window(wndB);
   display_window(wndC);

   wprintf(wndA ,"\n\n window A\n께께께께");
   wprintf(wndB ,"\n\n window B");
   wprintf(wndB,"\n1234");
   wprintf(wndC ,"\n\n window C\n께께께께");

   do{
       c=get_char();
       switch(c){
	case 'a':forefront(wndA);
		break;
	case 'b':forefront(wndB);
        	break;
	case 'c':forefront(wndC);
        	break;
	case 'A':rear_window(wndA);
        	break;
	case 'B':rear_window(wndB);
        	break;
	case 'C':rear_window(wndC);
		break;
	case FWD:rmove_window(wndB,1,0);break;
	case BS:rmove_window(wndB,-1,0);break;
	case UP:rmove_window(wndB,0,-1);break;
	case DN:rmove_window(wndB,0,1);break;

	default:wprintf(wndB,"\n%d",c);break;
	}
	}while (c!=ESC);
	delete_window(wndA);
	    get_char();
	delete_window(wndC);
        	get_char();
	delete_window(wndB);
             get_char();

   }
