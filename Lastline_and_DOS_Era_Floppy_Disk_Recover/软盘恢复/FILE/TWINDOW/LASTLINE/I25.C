#include <dos.h>
void read_with_lgsector(unsigned bgn_lgsector,unsigned lg_num,void *arry);
main()
 {
  char a[51200],b[30]="wqpywcbffzqbhqareok!";
  unsigned i=0,j,k=0,l,m=0;
  for(j=0;j<80000;j+=100)
  {
  read_with_lgsector(j,100,a);
  for(k=0;k<51200;k+=512)
    if(!memcmp(a+k,b,20))
      {
       printf("%x \n",j);
      }
  }
  }

void read_with_lgsector(unsigned bgn_lgsector,unsigned lg_num,void *arry)
  {
    union REGS in,out;
    in.h.al=2;
    in.x.cx=lg_num;
    in.x.dx=bgn_lgsector;
    in.x.bx=arry;
    int86(0x25,&in,&out);
  }
