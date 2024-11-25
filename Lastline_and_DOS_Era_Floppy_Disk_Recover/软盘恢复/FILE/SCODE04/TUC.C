
#include "graphics.h"
main()

{
int driver,mode,n=0,m=0,b=90,v=0,c=0;
driver=DETECT;
mode=0;
initgraph(&driver,&mode,"");
while (m<100){
setcolor(3);
n+=8;
m+=3;
c+=5;
arc(m+100,n,0,360,c);}
while (m>8){
setcolor(5);
n-=8  ;
m-=3 ;
c+=5;
arc(m+200,n,0,360,c);}
setcolor(2);
while (v<50){
v++;
n+=6;
arc(n,m+150,0,360,v);}
getch();
restorecrtmode();
}
