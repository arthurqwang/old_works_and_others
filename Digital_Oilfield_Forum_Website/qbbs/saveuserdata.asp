<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%

if request.cookies("adminok")="" then
  response.redirect "index.html"
end if

if session("usersetok")<>"yes" then
 response.redirect "index.html"
end if

dim sql,rs,action,username
action=request("action")
username=request("user")

if action="" or username="" then
 response.redirect "index.html"
end if
 
on error resume next
 

 set rs=server.createobject("adodb.recordset")
 sql="select * from user where username='"+username+"'"
 rs.open sql,conn,1,3
 if err.number<>0 then 
      response.write "���ݿ����ʧ�ܣ�"&err.description
 else
    if not rs.eof then '   �ҵ��˸��û�
	  if action="disable" then 
	  rs("UserPassword")="������β²���~!@#$%^&*"
	  rs("disable")=1
	  rs.update
	  end if
      
	  if action="able" then
      rs("UserPassword")="test"
	  rs("disable")=0
	  rs.update
	  end if

	  if action="delete"  then 
	  conn.execute "delete from user where username='"+username+"'"
	  end if
	
	rs.close
           if err.number<>0 then
              response.write "���ݿ����ʧ�ܣ����Ժ�����"&err.Description
			  err.clear
           else
		      response.redirect "userdata.asp"
%>



<%         end if
    end if
 end if   
%>
