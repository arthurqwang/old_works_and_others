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
<title>������̳�û�</title>
<meta name="GENERATOR" content="lousi soft 1.0">
<link rel="stylesheet" type="text/css" href="lun.css">
</head>

<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p><h3>��̳�û�����</h3></center>
<%
dim rs
dim sql
dim Article
dim username
 set rs=server.createobject("adodb.recordset")
 sql="select * from user where username ORDER BY username"
 rs.open sql,conn,1,1
 if rs.EOF then
	response.write "��û���κ��û���"
	else
%>

<div align='center'><center><table border='1' width='50%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'>
<tr>
<td width="100%" colspan="5" bgcolor='#ffffff' align=left>
  <b>������̳�û�</b><br>
 ʧЧ�ǽ��û��������Ϊ�����ߵ����룬�Ӷ�ʹ�û��Լ��޷�ʹ�ã�
<br>Ҳ�޷��ô�������ע�ᡣ�Ժ�����ټ����������Ϊtest.<br>
 ����û��������룬������ɾ���������·���ע��
    </td>
</tr>
<tr bgcolor=#ffffff>
<td align='center' width="15%"><b>ʧЧ</b></td>
<td align='center' width="15%"><b>ɾ��</b></td>
<td align='center' width="25%"><b>�û���</b></td>
<td align='center' width="25%"><b>����</b></td>
<td align='center' width="20%"><b>����������</b></td>

</tr>
<%do while NOT rs.EOF%>

<tr bgcolor=#E3F1D1>
<td align='center' width="15%">
<% if rs("disable")=0 then %>
<a href="saveuserdata.asp?action=disable&user=<%=rs("username")%>"><font color=red>ʧЧ</font></a></td>
<%else%>
<a href="saveuserdata.asp?action=able&user=<%=rs("username")%>" title="���¼�������붼��Ϊtest"><font color=red>����</font></a></td>
<%end if%>
<td align='center' width="15%"><a href="saveuserdata.asp?action=delete&user=<%=rs("username")%>"><font color=blue>ɾ��</font></a></td>
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
