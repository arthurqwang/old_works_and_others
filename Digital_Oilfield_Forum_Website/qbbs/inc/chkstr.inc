<%
   rem ���sql�ַ������Ƿ��е����ţ��������ת��
   function CheckStr(str)
       dim tstr,l,i,ch
	   l=len(str)
	   for i=1 to l
	       ch=mid(str,i,1)
	       if ch="'" then
		      tstr=tstr+"'"
		   end if
		   tstr=tstr+ch
	   next
	   CheckStr=tstr
   end function
%>