<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������������а�</title>
<link rel="stylesheet" type="text/css" href="lun.css">
</head>

<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p><h3><strong>�������а�</strong></h3></center>
<%
dim rs
dim sql
dim flag
if  request("BoardID")<>"" then
      boardid=request("boardid")
else 
	boardid=1 'Ĭ�Ͻ����1������
end if

 set rs=server.createobject("adodb.recordset")
 sql="select * from bbs1 where hits>5 and boardID="&cstr(boardID)&" ORDER BY hits desc "
 rs.open sql,conn,1,1
 if rs.EOF then
	response.write "��ʱû�м�¼"
	else
%>
<div align='center'><center><table border='1' width='50%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'>
<tr>
<td width="100%" colspan="4" bgcolor='#ffffff' >
  <table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr><td width="100%" align="center"><b>���½�������������а�</b></td></tr>
	   <tr><td width="100%" align="center">(�Ķ�5�����µ����Ӳ���ʾ)</td></tr>
</table>
    </td>
</tr>
<tr bgcolor=#ffffff>
<td align='center' width='60%'><b>���±���</b></td>
<td align='center' width='20%'><b>��������</b></td><td align='center' width='20%'><b>���������</b></td></tr>
<%do while NOT rs.EOF%>

<tr bgcolor=#ffffff>
<td align='left' width='60%'>
<%
dim iroot
iroot=rs("rootID")
if rs("rootID")=0 then iroot=rs("announceID")
                  response.write " <a href='ShowAnnounce.asp?boardID="&cstr(rs("BoardID"))&"&RootID="&cstr(iroot)&"&ID="&Cstr(rs("AnnounceID"))&"' target='_blank'>"
	  
                  if pwsonchsys then
	                 showBody rs("Topic")
                  else
                     response.write Server.HTMLEncode(rs("Topic"))
                  end if
	 response.write "</a>"
%>
</td>
<td align='center' width='20%'><font color=red><%=rs("username")%></font></td>
<td align='center' width='20%'><font color=blue><%=rs("hits")%></font></td>
</tr>
<%
	rs.MoveNext
	flag=flag+1
        if flag>50 then Exit Do
  loop
 end if
rs.Close
set rs=nothing
%>
</table></center></div>

</body>
</html>
