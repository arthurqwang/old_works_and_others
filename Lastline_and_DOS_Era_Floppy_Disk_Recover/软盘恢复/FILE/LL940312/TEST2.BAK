#include <stdio.h>
#include <graphics.h>
putbmp(char * file,int x,int y);
main()
{
  putbmp("c:\\windows\\winlogo.bmp",100,100);
  getch();
}
putbmp(char * file,int x,int y)
{
    FILE * fp;
    unsigned char head[54],colors[16],twop;
    long unsigned int width,height,*wp,*ht;
    int graphdrive=DETECT,mode,i,j;
    initgraph(&graphdrive,&mode,"");
    colors[0]=0;
    colors[1]=4;
    colors[2]=2;
    colors[3]=6;
    colors[4]=1;
    colors[5]=5;
    colors[6]=3;
    colors[7]=7;
    colors[8]=8;
    colors[9]=12;
    colors[10]=10;
    colors[11]=14;
    colors[12]=9;
    colors[13]=13;
    colors[14]=11;
    colors[15]=15;
    if((fp=fopen(file,"rb"))==NULL) exit(0);
    fread(head,54,1,fp);
    wp=(head+0x12);
    ht=(head+0x16);
    width=*wp;
    height=*ht;
    fseek(fp,0x76,SEEK_SET);
    for(j=height-1;j>=0;j--)
    for(i=0;i<width/2;i++)
      {
	fread(&twop,1,1,fp);
	putpixel(i*2+1+x,j+y,colors[twop&0x000F]);
	putpixel(i*2+x,j+y,colors[(twop>>4)&0x000F]);
      }
    fclose(fp);
}