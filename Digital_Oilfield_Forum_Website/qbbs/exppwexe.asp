<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>专家/嘉宾深入讨论区-注册信息修改</h3></title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><img border="0" src="images/download.jpg" height="20" width="30"><h3><br><Br>专家/嘉宾深入讨论区<br>密码修改</h3></p>

<%
   
    dim rs,sql
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts where expertnm='"&request("expertnm")&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) and rs("expertpw")=request("expertpw") and trim(request("newpw"))<>"" and trim(request("unitnm"))<>"" and trim(request("email"))<>"" and trim(request("realnm"))<>"" then
       rs("expertpw")=trim(request("newpw"))
       rs("realnm")=trim(request("realnm"))
       rs("unitnm")=trim(request("unitnm"))
       rs("email")=trim(request("email"))
       rs("tel")=trim(request("tel"))
       rs("memo")=trim(request("memo"))
       rs.update
       response.write "修改成功！"
       response.write "<br>您的新密码是："&trim(request("newpw"))&"，请记住。<br>为使新密码生效，请关闭所有浏览器窗口，然后重新进入。"
       response.cookies("expertpw")=trim(request("newpw"))
     else 
	   response.write "操作失败。新设密码、真实姓名、工作单位、电子邮件不能为空。"
    end if
   rs.close

'修改普通用户表
    set rs=server.createobject("adodb.recordset")
    sql="select * from user where username='"&request("expertnm")&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("userpassword")=trim(request("newpw"))
       rs("useremail")=trim(request("email"))
       rs.update
     else 
	   response.write "操作失败。"
    end if
   rs.close
   
%>
 

</body>
</html>