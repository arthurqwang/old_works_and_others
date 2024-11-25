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
   response.write "请输入管理员名字！"
end if
if adminpwd="" then
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
     response.redirect "请输入管理员密码！"
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
     response.write "Sorry,请输入正确的管理员名字和密码"
 end if
else
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
     response.write "Sorry,请输入正确的管理员名字和密码"
end if
rs.close
conn.close
set rs=nothing
set conn=nothing

%>
