<%
if request.cookies("adminok")="" then
  response.redirect "login.asp"
end if
%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<% 
	set rs=server.createobject("adodb.recordset")
	sql="DELETE FROM bbs1 WHERE AnnounceID="&Request.QueryString("AnnounceID")&""
	Set rs = conn.Execute( sql )
%> 
<% 
Sub delaySecond(DelaySeconds) 
SecCount = 0 
Sec2 = 0
While SecCount<DelaySeconds + 1 
Sec1 = Second(Time())
If Sec1 <> Sec2 Then 
Sec2 = Second(Time()) 
SecCount = SecCount + 1 
End If
Wend 
End Sub
%> 
<% delaySecond(2) %>

<% Response.Redirect ("emanage.asp?boardID=1") %> 