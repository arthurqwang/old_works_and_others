<% @language="vbscript" %>
<!--#include file=newconn.asp-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Left</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>
<body bgcolor=#E3F1D1>
<p align="center"><a href="index.html" target=_top>������ҳ>></a><br>
<a href="login.asp" target="BoardAnnounce" title="�ܹ��������ӡ��޸ġ�ɾ������,ָ������̳������">��̳����>></a><br>
<a href="elogin.asp" target="BoardAnnounce" title="�����˹�����̳����">�������>></a><br>
<a href="about.asp" target="BoardList">������̳>></a><br>
</p>
<p align="center">
������̳>><br>
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
<a href="query.asp" target="BoardAnnounce">��̳���Ӳ�ѯ</a><br>
<a href="myinfo.asp?page=1" target="BoardAnnounce">���ĸ�������</a><br>
<a href="myinfo.asp?page=2" target="BoardAnnounce">�޸ĸ�����Ϣ</a><br>
<a href="myinfo.asp?page=3" target="BoardAnnounce">��ѯ������Ϣ</a><br>
<a href="point.asp" target="BoardAnnounce">�鿴��������</a><br>
<p align="center">Power by <br><a href="mailto:lousi8@hotmail.com">��¶ӯ�ɹ�����</a><br>2003-2004<br><br><b><a href="http://lousi.yeah.net">lousi.yeah.net</a></b>

<p align="center">����<%=Application("online")%>��
<p align="center">
</center>
</body>
</html>