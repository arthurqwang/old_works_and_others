#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "twindow.h"
#include "keys.h"
void get_poem(int s);
int ht(char **tb);
int wd(char **tb);
char *titles[]={
    "1:我们是战士",
    "2:五月的鲜花" ,
    "3:海岸边远征",
    "4:候机场景",
    "5:深夜航程" };
    WINDOW *pno[]={0,0,0,0,0};
    static int x[]={20,15,29,10,17};
    static int y[]={5,10,13,18,6};
    static int wcl[][2]={
       {BLUE,WHITE},
       {MAGENTA,WHITE},
       {RED,WHITE},
       {GREEN,WHITE},
       {AQUA,WHITE}  };
char *poem1 []={
   "在乎你",
   "们们们们们们们们",
   "一二师傅傅傅范围困",
   "惑众议题句号码头发" ,
   "表面包围攻关闭会场院长",
   "安全部队部队部队部队部" ,
   "队部队部队部队部队部",
   0};
char *poem2[]={
  "摀矒瀾湶hjfhjfhhjfdhjhvhjhjfhjhj",
  "jhgvdfhhjdfdfvhj",
  "hjefhjhj",
  "摀矒瀾湶yugfhjhjfhgjfhj",
  "higerfhghjdf",
  "hgvdfhgjdfjhgdfvhjfdhjfdhj",
  "摀矒瀾湶yugfhdhgdfhjhdfhj",
  "hgcvghsvghvghghg"
  ""          ,
  ""           ,
  ""            ,
  "hgufdhjhjfd",0};
char *poem3[]={
   "ghdfaghdfvghfhfghvf",
   "",
   "",
   "",
   "",
   "hjgrgjhjhgbhjghjhjb",
   "hjfhvvgv",0};
char *poem4[] ={
   "hjhjhjbhj",
   "hfdhjhffhdfvh",
   "摀矒瀾湶",
   "摀矒瀾湶",
   "",
   "hjhjfhfhfhfhjhj",
   "uytfegedfeadfhgfdhgdfhg",
   "jhgfhjerjhfrfyuehjf",
   0};
char *poem5[]={
   "jjfhhjfbhbhjhjb",
   "jhjhjghjgfdjhhj",
   "摀矒瀾湶",
   "摀矒瀾湶",
   "yuhgjhjgjhfbjhgfbhjf",
   "hjhjbhjfbdhjbhjbvjh",
   "hjhjgvhjbhj",
   0};
char **poem[]={poem1,poem2,poem3,poem4,poem5,0};
void poems()
 {
   int s=0,i,c;
   WINDOW *mn;
   char **cp;

   cursor(0,25);
   mn=establish_window(0,0,7,11);
   set_title(mn,"我们是战士");
   set_colors(mn,ALL,BLUE,GREEN,BRIGHT);
   set_colors(mn,ACCENT,GREEN,WHITE,BRIGHT);
   set_border(mn,3);
   display_window(mn);
   cp=titles;
   while(*cp)
     wprintf(mn,"\n%s",*cp++);

     while(1){
     set_help("poemmenu",40,10);
     s=get_selection(mn,s+1,"12345");
     if(s==0)
      break;
     if(s==FWD||s==BS){
	s=0;
	continue;
	}
 hide_window(mn);
 get_poem(--s);
 c=0;
 set_help("poems   ",5,15);
 while(c!=ESC){
    c=get_char();
    switch(c){
       case FWD:rmove_window(pno[s],1,0);
	 break;
       case BS:rmove_window(pno[s],-1,0);
	 break;
       case UP:rmove_window(pno[s],0,-1);
       break;
       case DN:rmove_window(pno[s],0,1);
       break;

       case DEL:delete_window(pno[s]);
	 pno[s]=NULL;
	 break;
       case '+':
	 forefront(pno[s]);
	 break;
       case '-':rear_window(pno[s]);
       break;
       default:break;
       }
       if (c>'0' &&c<'6')
	get_poem(s=c-'1');
       }
       forefront(mn);
       display_window(mn);
       }
       close_all();
       for(i=0;i<5;i++)
       pno[i]=NULL;
       }


 static void get_poem(int s)
   {
     char **cp;
     static int lastp=-1;
     if(lastp!=-1)
       set_intensity(pno[lastp],DIM);
       lastp=s;
     if (pno[s])
	set_intensity(pno[s],BRIGHT);
     else
       {pno[s]=establish_window(x[s]/2,y[s],ht(poem[s]),wd(poem[s])/2+1);
       set_title(pno[s],titles[s]);
       set_colors(pno[s],ALL,wcl[s][0],wcl[s][1],BRIGHT);
       set_border(pno[s],1);
       display_window(pno[s]);
       cp=poem[s];
       while(*cp)
       wprintf(pno[s],"\n%s",*cp++);
       }
     }



static int ht(char  **tb)
  {
     int h=0;
     while (*(tb+h++));
     return h+3;
  }
static int wd(char **tb)
  {
    int w=0;
    while(*tb){
       w=max(w,strlen(*tb));
       tb++;
       }
       return w+4;
    }


