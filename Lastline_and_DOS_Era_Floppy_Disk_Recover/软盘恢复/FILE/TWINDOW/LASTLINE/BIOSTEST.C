main()
 {
   int i;
   char a[512];
   for ( i=1 ;i<1000;i++)
    {
    if((biosdisk(2,0x80,i,0,1,1,a)))
    {
     biosdisk(0,0x80,0,0,0,0,0);
     printf("%X \n",i-1);
     break;
    }
   }
   for ( i=1 ;i<1000;i++)
   if((biosdisk(2,0x80,0,i,1,1,a)))
    {
     biosdisk(0,0x80,0,0,0,0,0);
     printf("%X \n",i-1);
     break;
    }
   for ( i=1 ;i<1000;i++)
   if((biosdisk(2,0x80,0,0,i,1,a)))
    {
     biosdisk(0,0x80,0,0,0,0,0);
     printf("%X \n",i-1);
     break;
    }
    getch();
 }
