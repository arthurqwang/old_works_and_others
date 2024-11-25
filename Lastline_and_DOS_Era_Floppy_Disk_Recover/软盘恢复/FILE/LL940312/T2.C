void title(char *path_of_HZK)
  {
    WINGRA *win;
    int graphdrive=DETECT,mode,i,j;
/*    int graphdrive=EGA,mode=EGAHI,i,j;*/
    char MSS[]="PlfurVdih#V|vwhp##PVV#513";
    for(i=0;i<=24;i++)
       MSS[i] -= 3;
    if((CCLIB=open(path_of_HZK,O_RDONLY|O_BINARY))==-1)
       {
       printf("Can't find file MSSHZ.LIB or not running in floppy disk.\n");
       exit(0);
       }
    if(registerfarbgidriver(EGAVGA_driver_far)<0) exit(1);
    if(registerfarbgifont(triplex_font_far)<0) exit(1);
    if(registerfarbgifont(small_font_far)<0) exit(1);
    initgraph(&graphdrive,&mode,"");
    if(getgraphmode()==2)
       high_of_char=16;
    else
       high_of_char=14;
    setfillstyle(SOLID_FILL,7);
    bar(0,0,640,480);
    for (i=-1;i<480;i+=10)
      {
	 setcolor(0);
	 line(0,i+1,640,i+1);
	 setcolor(15);
	 line(0,i,640,i);
      }
    win=open_win(2,15,6,65,7,0);
/*    puthz(win,"      最后防线最后防线最",0,7);*/
    settextstyle(1,0,2);
    setcolor(0);
    outtextxy(180,high_of_char*3-1,MSS);
    outtextxy(179,high_of_char*3-1,MSS);
    setcolor(15);
    outtextxy(178,high_of_char*3-3,MSS);
    outtextxy(177,high_of_char*3-3,MSS);
    setcolor(7);
    setfillstyle(SOLID_FILL,1);
    pieslice(150,high_of_char*3+5,0,56,10);
    setfillstyle(SOLID_FILL,14);
    pieslice(150,high_of_char*3+5,62,118,10);
    setfillstyle(SOLID_FILL,4);
    pieslice(150,high_of_char*3+5,122,180,10);
    high(140,high_of_char*3+8,160,high_of_char*3+17,7,1);
    settextstyle(2,0,3);
    setcolor(4);
    outtextxy(143,high_of_char*3+9,"RSun");
  }