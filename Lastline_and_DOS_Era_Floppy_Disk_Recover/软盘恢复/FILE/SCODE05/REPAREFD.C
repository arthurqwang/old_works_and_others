/* This is a pro which can repare bad floppy disk.*/
/* It can be used under DOS 5.0(or higher one).   */
main()
{
  unsigned char a[512],dr[10],fmt[100]="format a:/q";
  int drv,cod;
  printf("Which drive to be used? ");
  scanf("%s",dr);
  drv=toupper(dr[0])-'A';
  printf("Insert a GOOD disk into drive %c:,please.\nPress any key when ready...\n",toupper(dr[0]));
  getch();
  if(biosdisk(2,drv,0,0,1,1,a))
   if(biosdisk(2,drv,0,0,1,1,a))
    if(biosdisk(2,drv,0,0,1,1,a))
    if(biosdisk(2,drv,0,0,1,1,a))
    if(biosdisk(2,drv,0,0,1,1,a))
    {
      printf("Read error in drive %c:\n.",toupper(dr[0]));
      exit(0);
    }
  printf("Insert the BAD disk into drive %c:,please.\nPress any key when ready...\n",toupper(dr[0]));
  getch();
  a[0xe]=a[0x18]*2;
  if(biosdisk(3,drv,0,0,1,1,a))
   if(biosdisk(3,drv,0,0,1,1,a))
    if(biosdisk(3,drv,0,0,1,1,a))
    if(biosdisk(3,drv,0,0,1,1,a))
    if(biosdisk(3,drv,0,0,1,1,a))
    {
      printf("Write error in drive %c:\n.",toupper(dr[0]));
      exit(0);
    }
/*  if(biosdisk(3,drv,0,1,1,99,a+512))
   if(biosdisk(3,drv,0,1,1,99,a+512))
    if(biosdisk(3,drv,0,1,1,99,a+512))
    if(biosdisk(3,drv,0,1,1,99,a+512))
    if(biosdisk(3,drv,0,1,1,99,a+512))
    {
      printf("Write error in drive %c:\n.",toupper(dr[0]));
      exit(0);
    }*/
  printf("\nNow,begin to FORMAT.\n");
  fmt[7]=dr[0];
  system (fmt);
}
