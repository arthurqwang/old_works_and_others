#include <dos.h>
#include <stdio.h>
#include <string.h>
#include "twindow.h"
/*struct {             */
	char name[26]="sssssss";
	char addr[26]="Ssssss";
	char city[26];
	char state[3];
	char zip[6];
	char amt[6];
	char dt[7];
	char phone[11];
/*	}rcd;*/

char msk25[]="_________________________";
char mskamt[]="___.__";
char mskdate[]="__/__/__";
char mskphone[]="(___)___-____";
#define mskst msk25+23
#define mskzip msk25+20
int validate_state(char *);
void help_date(char *);


void ordent()
  {
    WINDOW *wnd;
    FIELD *fld;
    system("cls");
    wnd=establish_window(10,5,15,50);
    set_title(wnd,"order entry");
    set_colors(wnd,ALL,BLUE,RED,BRIGHT);
    set_colors(wnd,ACCENT,WHITE,BLACK,DIM);
    display_window(wnd);
    wprompt(wnd,5,2,"Name:");
    wprompt(wnd,5,3,"Address:");
    wprompt(wnd,5,4,"City:");
    wprompt(wnd,5,5,"State:");
    wprompt(wnd,18,5,"Zip:");
    wprompt(wnd,5,10,"Phone:");
    wprompt(wnd,5,7,"Amount:");
    wprompt(wnd,5,8,"Date:");
    init_template(wnd);
    fld=establish_field(wnd,15,2,msk25,name,'A');
    field_window(fld,"name    ",40,1);
    fld=establish_field(wnd,15,3,msk25,addr,'A');
    field_window(fld,"address ",40,2);
    fld=establish_field(wnd,15,4,msk25,city,'A');
    field_window(fld,"address ",40,3);
    fld=establish_field(wnd,15,5,mskst,state,'A');
    field_validate(fld,validate_state);
    field_window(fld,"state    ",40,4);
    fld=establish_field(wnd,23,5,mskzip,zip,'Z');
    field_window(fld,"address ",40,4);
    fld=establish_field(wnd,15,10,mskphone,phone,'N');
    field_window(fld,"phone   ",40,9);
    fld=establish_field(wnd,15,7,mskamt,amt,'C');
    field_window(fld,"amount  ",40,8);
    fld=establish_field(wnd,15,8,mskdate,dt,'D');
    field_help(fld,help_date);
/*    clear_template(wnd);*/
    data_entry(wnd);
    delete_window(wnd);
    printf("\n\n\n\n\nname=%s\n",(name));
    printf("addr=%s\n",(addr));
    printf("city=%s\n",(city));
    printf("state=%s\n",(state));
    printf("zip=%s\n",(zip));
    printf("phone=%s\n",(phone));
    printf("amt=%s\n",(amt));
    printf("dt=%s\n",(dt));

    get_char();
  }


int validate_state(char *bf)
  {
     static char *states[]=
	 {"","VA","NC","SC","GA","FL",0};
	 char **st=states;
	 while (*st)
	    if (strcmp(*st++,bf)==0)
		return OK;
	    error_message("Invalid State.");
	    return ERROR;
   }


void help_date(char *bf)
{
   struct date dat;
   getdate(&dat);
   sprintf(bf,"%02d%02d%02d",dat.da_day,dat.da_mon,dat.da_year %100);
}



