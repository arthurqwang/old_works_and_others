<!--#include file=newconn.asp-->
<%
dim sql
dim rs
dim seekerrs
dim founduser
dim adminame
dim companyid
dim adminpwd
dim errmsg
dim founderr
founderr=false
FoundUser=false
adminame=trim(request.form("username"))
adminpwd=trim(Request.Form("password"))
if adminame="" then
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
   response.write "���������Ա���֣�"
end if
if adminpwd="" then
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
     response.redirect "���������Ա���룡"
end if

set rs=server.createobject("adodb.recordset")
sql="select * from admin where adminame='"&adminame&"'"
rs.open sql,conn,1,1
if not rs.eof then
 if adminpwd=rs("adminpwd") then
   response.cookies("adminok")=true
   response.cookies("myname")=adminame
   %>
   <script language="javascript">
	 parent.document.all.BoardAnnounce.location="loginch.asp"
	</script>
   <%
   response.redirect "boardmanager.asp?isAdmin=yes"
 else
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
     response.write "Sorry,��������ȷ�Ĺ���Ա���ֺ�����"
 end if
else
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
     response.write "Sorry,��������ȷ�Ĺ���Ա���ֺ�����"
end if
rs.close
conn.close
set rs=nothing
set conn=nothing

%>
