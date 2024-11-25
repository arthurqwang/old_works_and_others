#include <bios.h>
unsigned BKHEAD,BKTRACK,i;
void get_BK(void)
 {
   unsigned char tttt[512];
   unsigned HD_base_table_adr[4],temp[3],a=0,b=0x400;
   HD_base_table_adr[0]=peekb(0,0x104)&0xff;
   HD_base_table_adr[1]=peekb(0,0x105)&0xff;
   HD_base_table_adr[2]=peekb(0,0x106)&0xff;
   HD_base_table_adr[3]=peekb(0,0x107)&0xff;
   temp[0]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+0);
   temp[1]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+1);
   temp[2]=peekb((HD_base_table_adr[3]<<8)+HD_base_table_adr[2],(HD_base_table_adr[1]<<8)+HD_base_table_adr[0]+2);
   BKTRACK=((temp[1]&0xff)<<8)+(temp[0]&0xff)-1;
/*   BKHEAD=(temp[2]&0xff)-1;*/
   BKHEAD=0;
   if(BKTRACK > 0x3FF)
    {
      BKTRACK=0x3FF;BKHEAD=0;
      if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
       {
	BKTRACK=0x200;
	while( (b-a)>1 )
	 {
	   if(biosdisk(2,0x80,BKHEAD,BKTRACK,1,1,tttt))
	      b=BKTRACK;
	   else
	      a=BKTRACK;
	   BKTRACK=(a+b)/2;
	 }
       }
    }
}

main()
{

  unsigned char a[512];
  unsigned bfillvalue,ffillvalue,spot;
  printf("Fill hidden sector.Enter FF not to fill.\nWhat do you want to fill the Fore sec?(HEX)" );
  scanf("%x",&ffillvalue);
  printf("What spot value is?(HEX)");
  scanf("%x",&spot);
  printf("What do you want to fill Back sec?(HEX)");
  scanf("%x",&bfillvalue);

  ffillvalue &= 0xff;
  bfillvalue &= 0xff;
  spot &= 0xff;

  for (i=0;i<512;i++)
    a[i]=ffillvalue;
  a[10]=spot;
  get_BK();
  if(ffillvalue != 0xFF)
  for(i=2;i<=17;i++)
  {
  if(biosdisk(3,0x80,0,0,i,1,a))
    {
      printf("Error.\n");
      exit(0);
    }
  }

  for (i=0;i<512;i++)
    a[i]=bfillvalue;
  if(bfillvalue != 0xFF)
  for(i=2;i<=17;i++)
  {
  if(biosdisk(3,0x80,BKHEAD,BKTRACK,i,1,a))
    {
      printf("Error.\n");
      exit(0);
    }
  }
   printf("Ok.\n");
}
