/*******************************************************************
  File name:     TWINGRA.H
  Belong to:     LASTLINE 2.5 Chinese version
  Date:          NOV/10/94
  Author:        WangQuan
  Function:      To be .H file for TWINGRA.C.
  Usage:         Used in .PRJ files.
  Where stored:  Floppy disk "LASTLINE 2.5 Chinese version
		 Source files"(LASTLINE 2.5 Zhongwenban Yuanwenjian)
  Path stored:   \
  OS passed:     DOS 3.3a,DOS 5.0,DOS 6.0,DOS 6.2
  Computer
       passed:   GW286,COMPAQ 386/33(25),AST 286
		 Antai 286 ,At&t 386,DELL 433DE ,NONAME 286
		 Envision 386,so on
*****************************************************************/

#include <graphics.h>
#include <fcntl.h>
#include <io.h>
#include <stdio.h>
#include <dos.h>
typedef struct wingra
    {
     int row;
     int col;
     int erow;
     int ecol;
     int curline;
     int curcol;
     int color;
     int detarow;
    }WINGRA;
void title(char *path_of_HZK);
void clr_win(WINGRA *win,int hg);
void high(int x,int y,int xx,int yy,int colo,int times);
void nohigh(int x,int y,int xx,int yy,int colo,int times);
void draw_box(int row,int col,int erow,int ecol,int colo);
void puthz(WINGRA *win,unsigned char *hz,int color,int bkcolor);
void pputhz(WINGRA *win,unsigned *hz,int color,int bkcolor);
WINGRA * open_win(int row,int col,int erow,int ecol,int color,int hg);
void anti_trace(void);
void can_trace(void);
void SN_string_cvr(unsigned SN_num,unsigned char *SN_str);
unsigned get_SN_from_hd(void);
unsigned get_SN_from_fd(void);
void wrt_SN_with_hd(void);
void wrt_SN_with_fd(void);
int get_ch(void);
void putbmp(char *,int,int);

