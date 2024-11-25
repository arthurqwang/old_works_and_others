#include <graphics.h>
#include <fcntl.h>
#include <io.h>
#include <stdio.h>
typedef struct wingra
    {
     int row;
     int col;
     int erow;
     int ecol;
     int curline;
     int curcol;
     int color;
    }WINGRA;
void title(void);
void clr_win(WINGRA *win,int hg);
void high(int x,int y,int xx,int yy,int colo,int times);
void nohigh(int x,int y,int xx,int yy,int colo,int times);
void draw_box(int row,int col,int erow,int ecol,int colo);
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor);
void pputhz(WINGRA *win,unsigned *hz,int color,int bkcolor);
WINGRA * open_win(int row,int col,int erow,int ecol,int color,int hg);
