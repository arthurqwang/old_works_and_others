<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->

<%
if request.cookies("adminok")="" then
  response.redirect "index.html"
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>管理论坛用户</title>
<meta name="GENERATOR" content="lousi soft 1.0">
<link rel="stylesheet" type="text/css" href="lun.css">
</head>

<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p><h3>论坛用户管理</h3></center>
<%
dim rs
dim sql
dim Article
dim username
 set rs=server.createobject("adodb.recordset")
 sql="select * from user where username ORDER BY username"
 rs.open sql,conn,1,1
 if rs.EOF then
	response.write "还没有任何用户！"
	else
%>

<div align='center'><center><table border='1' width='50%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'>
<tr>
<td width="100%" colspan="5" bgcolor='#ffffff' align=left>
  <b>管理论坛用户</b><br>
 失效是将用户的密码改为管理者的密码，从而使用户自己无法使用，
<br>也无法用此名重新注册。以后可以再激活且密码变为test.<br>
 如果用户忘记密码，可以先删除让他重新发言注册
    </td>
</tr>
<tr bgcolor=#ffffff>
<td align='center' width="15%"><b>失效</b></td>
<td align='center' width="15%"><b>删除</b></td>
<td align='center' width="25%"><b>用户名</b></td>
<td align='center' width="25%"><b>密码</b></td>
<td align='center' width="20%"><b>发表文章数</b></td>

</tr>
<%do while NOT rs.EOF%>

<tr bgcolor=#E3F1D1>
<td align='center' width="15%">
<% if rs("disable")=0 then %>
<a href="saveuserdata.asp?action=disable&user=<%=rs("username")%>"><font color=red>失效</font></a></td>
<%else%>
<a href="saveuserdata.asp?action=able&user=<%=rs("username")%>" title="重新激活后密码都变为test"><font color=red>激活</font></a></td>
<%end if%>
<td align='center' width="15%"><a href="saveuserdata.asp?action=delete&user=<%=rs("username")%>"><font color=blue>删除</font></a></td>
<td align='center' width="25%"><%=rs("username")%></td>
<td align='center' width="25%"><%=rs("userpassword")%></td>
<td align='center' width="20%"><font color=red><%=rs("Article")%></font></td>

</tr>
<%
	rs.MoveNext
	'username=username+1
     '   if username>20 then Exit Do
  loop
 end if
rs.Close
set rs=nothing
session("usersetok")="yes"
%>
</table></center></div>

</body>
</html>
