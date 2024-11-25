<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
dim username
username=trim(request("name"))
FoundError=false
if username="" then
   ErrMsg="请输入姓名"
    session("ErrMsg")=ErrMsg
    response.redirect "myinfo.asp?page=3"
else
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查询个人信息</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>

<body>
<%
set rs=server.createobject("adodb.recordset")
   sql="select * from User"
   rs.open sql,conn,1,1
   if err.number<>0 then 
      response.write "数据库操作失败："&err.description
   else
      dim FoundUser
      FoundUser=false
      do while  not (rs.eof or err.number<>0)
         if ucase(rs("UserName"))=ucase(UserName) then
            FoundUser=True
 	         exit do 
	     end if
	 rs.movenext
    loop
    end if
      if not FoundUser then
         response.write "您的名字不存在或您的密码不正确"
      else
%>
<div align="center"><center>

<table border="0" width="379">
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">姓 名：</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("username")%></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">简 介：</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("Userdetails")%></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">E_Mail：</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><a href="mailto:<%=rs("useremail")%>"><%=rs("useremail")%></a></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">来 自：</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("comefrom")%></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">主 页：</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><a href="<%=rs("homepage")%>"
    target="_blank"><%=rs("homepage")%></a></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">积 分：</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("article")%></span></td>
  </tr>
</table>
</center></div><%end if%>

</body>
</html>
<%end if%>
