#include <dos.h>
static union REGS rg;
void cursor(int x,int y)
    {
       rg.x.ax=0x0200;
       rg.x.bx=0;
       rg.x.dx=((y<<8)&0xff00)+x;
       int86(16,&rg,&rg);
    }
void curr_cursor(int *x, int *y)
  {
     rg.x.ax=0x0300;
     rg.x.bx=0;
     int86(16,&rg,&rg);
     *x=rg.h.dl;
     *y=rg.h.dh;
  }
void set_cursor_type( int t)
    {
	 rg.x.ax=0x0100;
	 rg.x.bx=0;
	 rg.x.cx=t;
	 int86(16,&rg,&rg);
    }
char attrib=7;
void clear_screen()
  {
    cursor(0,0);
    rg.h.al=' ';
    rg.h.ah=9;
    rg.x.bx=attrib;
    rg.x.cx=2000;
    int86(16,&rg,&rg);
  }
int vmode()
  {
     rg.h.ah=15;
     int86(16,&rg,&rg);
     return rg.h.al;
  }
int scroll_lock()
  {
    rg.x.ax=0x0200;
    int86(0x16,&rg,&rg);
    return rg.h.al &0x10;
  }
void(*helpfunc)();
int helpkey =0;
int helping= 0;
int get_char()
  {
     int c;
     while(1){
       rg.h.ah=1;
       int86(0x16,&rg,&rg);
       if (rg.x.flags &0x40){
	  int86(0x28,&rg,&rg);
	  continue;
       }
     rg.h.ah=0;
     int86(0x16,&rg,&rg);
     if(rg.h.al==0)
       c=rg.h.ah|128;
     else
       c=rg.h.al;
     if(c==helpkey &&helpfunc){
	if (!helping){
	    helping=1;
	    (*helpfunc)();
	   helping=0;
	   continue;
	}
     }
     break;
  }
  return c;
}


