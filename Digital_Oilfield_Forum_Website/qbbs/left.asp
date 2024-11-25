<% @language="vbscript" %>
<!--#include file=newconn.asp-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Left</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>
<body bgcolor=#E3F1D1>
<p align="center"><a href="index.html" target=_top>返回首页>></a><br>
<a href="login.asp" target="BoardAnnounce" title="总管理者增加、修改、删除版面,指定分论坛主持人">论坛管理>></a><br>
<a href="elogin.asp" target="BoardAnnounce" title="主持人管理论坛设置">版面管理>></a><br>
<a href="about.asp" target="BoardList">关于论坛>></a><br>
</p>
<p align="center">
各分论坛>><br>
<%
   dim rs,sql
   set rs=server.createobject("adodb.recordset")
   sql="select boardname,boardID from board"
   rs.open sql,conn,1,1
			  do while not rs.eof
      response.write "<a href='list.asp?boardID=" +CStr(rs("BoardID"))+"'  target='BoardList'>"+rs("Boardname")+"</a><br>"+chr(13)+chr(10)
		             rs.movenext
		      loop
			  %>    

<p align="center">
<a href="query.asp" target="BoardAnnounce">论坛帖子查询</a><br>
<a href="myinfo.asp?page=1" target="BoardAnnounce">更改个人密码</a><br>
<a href="myinfo.asp?page=2" target="BoardAnnounce">修改个人信息</a><br>
<a href="myinfo.asp?page=3" target="BoardAnnounce">查询个人信息</a><br>
<a href="point.asp" target="BoardAnnounce">查看积分排行</a><br>
<p align="center">Power by <br><a href="mailto:lousi8@hotmail.com">清露盈荷工作室</a><br>2003-2004<br><br><b><a href="http://lousi.yeah.net">lousi.yeah.net</a></b>

<p align="center">在线<%=Application("online")%>人
<p align="center">
</center>
</body>
</html>