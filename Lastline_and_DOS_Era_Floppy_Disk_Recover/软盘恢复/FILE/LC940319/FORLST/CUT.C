
   set_colors(back2,ALL,YELLOW,YELLOW,DIM);
   display_window(back2);
   titt=establish_window(17,6,4,50);
   set_colors(titt,ALL,3,WHITE,BRIGHT);
   titt->wcolor[0]=0x33;
   set_border(titt,3);
   display_window(titt);

   tit=establish_window(15,5,4,50);
   set_colors(tit,ALL,BLUE,WHITE,BRIGHT);
   tit->wcolor[0]=0x11;
   set_border(tit,3);
   display_window(tit);
   wprintf(tit,"              LASTLINE Version 2.0\n          (C) Copyright ");
   wprintf(tit,"%c%c%c%c%c%c%c%c",87,65,78,71,81,85,65,78);
   wprintf(tit," 1993.");
   inff=establish_window(12,12,5,60);
   set_colors(inff,ALL,3,YELLOW,BRIGHT);
   inff->wcolor[0]=0x33;
   set_border(inff,3);
   display_window(inff);

   inf=establish_window(10,11,5,60);
   set_colors(inf,ALL,BLUE,YELLOW,BRIGHT);
   inf->wcolor[0]=0x11;
   set_border(inf,3);
   display_window(inf);
   pp=establish_window(12,19,3,60);
   set_colors(pp,ALL,3,WHITE,BRIGHT);
   pp->wcolor[0]=0x33;
   set_border(pp,3);
   p=establish_window(10,18,3,60);
   set_colors(p,ALL,BLUE,WHITE,BRIGHT);
   set_border(p,3);
   olddvr=getdisk();
   if(argv[0][1]==':')
     setdisk(toupper(argv[0][0])-'A');
   dvr[0]=toupper(argv[0][0]);
   dvr[2]=0;
  wprintf(inf,"\n   DOS path is    C:\\DOS , right?[Y]\b\b");
  k=getch();
  printf("\x7");
  if((k==13) ||(toupper(k)=='Y'))
     strcpy(dospath,"c:\\dos");
  else
    {
      wprintf(inf,"N");
      wprintf(inf,"\n   Enter path including DOS,please :  ");
      scanf("%s",dospath);
      printf("\x7");
    }
  wprintf(inf,"\n   Auto startup anti-virus software,ALWAYSEE ?[Y]\b\b");
  k=getch();
  printf("\x7");
  if(toupper(k)=='N') wprintf(inf,"N\n");
  wprintf(inf,"\n\n   Wait a while,please...");
  set_l();       /*include anti_trace()  */
  check_sec();
  set_title(p,"Installing...");
  display_window(pp);
  display_window(p);
  wputchar(p,219);wputchar(p,219);wputchar(p,219);
  wputchar(p,219);wputchar(p,219);