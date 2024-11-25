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
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>管理专家/嘉宾</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;专家/嘉宾管理</h3></p>
<table border="0" width="800">
<tr><td colspan="2">
<font color="#336699" size="4">增加专家/嘉宾目录</font>
<font color="#666666" size="2">&nbsp;&nbsp;&nbsp;&nbsp;（*必填）<br></font>

<form action="addexp.asp" method="POST">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td><font color="#666666" size="2">
姓名<input type=text name=realnm size=5>*&nbsp;&nbsp;单位<input type=text name=unitnm size=60>*<br>
用户<input type=text name=expertnm size=5>*&nbsp;
密码<input type=text name=expertpw size=10>*&nbsp;&nbsp;
Email<input type=text name=email size=23>*&nbsp;&nbsp;
专栏目录<input type=text name=folder size=3><br>
电话<input type=text name=tel size=20>&nbsp;&nbsp;&nbsp;补充说明<input type=text name=memo size=41><br>
活动状态<input type="Radio" name="active" value="1" checked>是<input type="Radio" name="active" value="0">否
<input type=submit value='增加记录' tabindex="5">
</font>
</td></tr>
</table>
<br>
<hr>
<br><br>
<font color="#336699" size="4">管理原有专家/嘉宾目录<br></font>

</td></tr>
<%
dim rs,sql,i
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts order by active,realnm"
       rs.open sql,conn,1,1
 	 do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       if rs("active")=0 then response.write "<a href='saveexp.asp?action=permit&expertnm="&rs("expertnm")&"'><font size=2 color=#ff0000>批准</font></a>&nbsp;&nbsp;"
       response.write "<a href='saveexp.asp?action=modify&expertnm="&rs("expertnm")&"'><font size=2 color=#336699>修改</font></a>"
       response.write "&nbsp;&nbsp;<a href='saveexp.asp?action=delete&expertnm="&rs("expertnm")&"'><font size=2 color=#336699>删除</font></a>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>姓名：</font><font color=#000000>"&rs("realnm")&"</font>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>用户：</font>"&rs("expertnm")
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>密码：</font>"&rs("expertpw")

       response.write "&nbsp;&nbsp;<font size=2 color=#996633>专栏目录：</font>"
       if rs("folder")=0 then
         response.write "无"
       else
         response.write rs("folder")
       end if
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>活动状态：</font>"
       if rs("active")=0 then
         response.write "禁止"
       else
         response.write "活动"
       end if
       response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>单位：</font>"&rs("unitnm")
       response.write "&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>Email：</font>"&"<a href='mailto.asp?expertnm="&rs("expertnm")&"'>"&rs("email")&"</a>"
       response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>电话：</font>"&rs("tel")
       response.write "&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>补充说明：</font>"&rs("memo")
       response.write "</td></tr>"
       rs.MoveNext
       i=i+1 
     loop
     i=1
     rs.MoveFirst
     response.write "<tr><td colspan=2><br>登录记录</td></tr>"
     do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       response.write "<font size=2 color=#996633>姓名：</font>"&rs("realnm")&"&nbsp;&nbsp;<a href='mailto.asp?expertnm="&rs("expertnm")&"'>"&rs("email")&"</a>"
       response.write "<br>"&rs("loginrec")
       response.write "</td></tr>"
       rs.MoveNext
       i=i+1 
     loop

     rs.Close
  
%>
</table>
</center>
</body>
</html>
