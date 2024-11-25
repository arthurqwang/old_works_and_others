<%
   rem 检查sql字符串中是否有单引号，有则进行转化
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