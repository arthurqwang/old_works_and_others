<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����</title>
<meta name="GENERATOR" content="lousi soft 1.0">
<link rel="stylesheet" type="text/css" href="lun.css">
</head>

<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p><h3><strong>�������а�</strong></h3></center>
<%
dim rs
dim sql
dim Article
dim username
 set rs=server.createobject("adodb.recordset")
 sql="select * from user where username ORDER BY Article desc"
 rs.open sql,conn,1,1
 if rs.EOF then
	response.write "not point"
	else
%>
<div align='center'><center><table border='1' width='50%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'>
<tr>
<td width="100%" colspan="4" bgcolor='#ffffff' ><table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td width="100%" align="center"><b>��̳�������а�</b></td>
      </tr>
    </table>
    </td>
</tr>
<tr bgcolor=#ffffff>
<td align='center' width='40%'><b>����</b></td>
<td align='center' width='30%'><b>��������</b></td><td align='center' width='30%'><b>��������</b></td></tr>
<%do while NOT rs.EOF%>

<tr bgcolor=#ffffff>
<td align='center' width='40%'><%=rs("username")%></td>
<td align='center' width='40%'><font color=red><%=rs("Article")%></font></td>
<td align='center' width='40%'><font color=blue><%=rs("point")%></font></td>
</tr>
<%
	rs.MoveNext
	username=username+1
        if username>20 then Exit Do
  loop
 end if
rs.Close
set rs=nothing
%>
</table></center></div>
<br>
<div align="center"><center>

<table border="1" width="70%" cellspacing="0" bordercolordark="#FFFFFF"
bordercolorlight="#000000" bgcolor="#FFFFFF" cellpadding="1" height="170">
  <tr>
    <td width="100%" align="center" bgcolor='#ffffff' height="16"><span class="smallFont"><strong>�� �� �� ��</strong></span></td>
  </tr>
  <tr bgcolor=#ffffff>
    <td width="100%" height="7"><ul>
      <li><span class="smallFont">��һ���������ּ�3��</span></li>
      <li><span class="smallFont">��һ��ͼƬ���ּ�2��</span></li>
	  <li><span class="smallFont">��һ���ظ����ּ�1��</span></li>
      <li><span class="smallFont">��ɾһ�����ӣ�����1��</span></li>
    </ul>
    <p><b>˵����</b><br>
    &nbsp;&nbsp;&nbsp; &nbsp;���û��ֻ���ֻ������Ծ��̳�����գ�������ֻ��˵�������ڱ���̳�Ļ�Ծ���������һ�����������κη���ĸ���ˮƽ��</td>
  </tr>
</table>
</center></div>

</body>
</html>
