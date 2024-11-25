main()
 {
   unsigned short dv[4],num[3];
   unsigned cy,head;
   dv[0]=peekb(0,0x104)&0xff;
   dv[1]=peekb(0,0x105)&0xff;
   dv[2]=peekb(0,0x106)&0xff;
   dv[3]=peekb(0,0x107)&0xff;
   printf("%x %x %x %x\n",dv[0],dv[1],dv[2],dv[3]);
   num[0]=peekb((dv[3]<<8)+dv[2],(dv[1]<<8)+dv[0]+0)&0xff;
   num[1]=peekb((dv[3]<<8)+dv[2],(dv[1]<<8)+dv[0]+1)&0xff;
   num[2]=peekb((dv[3]<<8)+dv[2],(dv[1]<<8)+dv[0]+2)&0xff;
   printf("%x %x %x %x\n",num[0],num[1],num[2]);
   cy=(num[1]<<8) + num[0];
   head=num[2];
   printf("%x %x\n",cy,head);
   }