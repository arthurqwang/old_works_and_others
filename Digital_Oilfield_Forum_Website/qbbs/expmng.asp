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
<title>����ר��/�α�</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;ר��/�α�����</h3></p>
<table border="0" width="800">
<tr><td colspan="2">
<font color="#336699" size="4">����ר��/�α�Ŀ¼</font>
<font color="#666666" size="2">&nbsp;&nbsp;&nbsp;&nbsp;��*���<br></font>

<form action="addexp.asp" method="POST">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td><font color="#666666" size="2">
����<input type=text name=realnm size=5>*&nbsp;&nbsp;��λ<input type=text name=unitnm size=60>*<br>
�û�<input type=text name=expertnm size=5>*&nbsp;
����<input type=text name=expertpw size=10>*&nbsp;&nbsp;
Email<input type=text name=email size=23>*&nbsp;&nbsp;
ר��Ŀ¼<input type=text name=folder size=3><br>
�绰<input type=text name=tel size=20>&nbsp;&nbsp;&nbsp;����˵��<input type=text name=memo size=41><br>
�״̬<input type="Radio" name="active" value="1" checked>��<input type="Radio" name="active" value="0">��
<input type=submit value='���Ӽ�¼' tabindex="5">
</font>
</td></tr>
</table>
<br>
<hr>
<br><br>
<font color="#336699" size="4">����ԭ��ר��/�α�Ŀ¼<br></font>

</td></tr>
<%
dim rs,sql,i
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts order by active,realnm"
       rs.open sql,conn,1,1
 	 do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       if rs("active")=0 then response.write "<a href='saveexp.asp?action=permit&expertnm="&rs("expertnm")&"'><font size=2 color=#ff0000>��׼</font></a>&nbsp;&nbsp;"
       response.write "<a href='saveexp.asp?action=modify&expertnm="&rs("expertnm")&"'><font size=2 color=#336699>�޸�</font></a>"
       response.write "&nbsp;&nbsp;<a href='saveexp.asp?action=delete&expertnm="&rs("expertnm")&"'><font size=2 color=#336699>ɾ��</font></a>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>������</font><font color=#000000>"&rs("realnm")&"</font>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>�û���</font>"&rs("expertnm")
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>���룺</font>"&rs("expertpw")

       response.write "&nbsp;&nbsp;<font size=2 color=#996633>ר��Ŀ¼��</font>"
       if rs("folder")=0 then
         response.write "��"
       else
         response.write rs("folder")
       end if
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>�״̬��</font>"
       if rs("active")=0 then
         response.write "��ֹ"
       else
         response.write "�"
       end if
       response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>��λ��</font>"&rs("unitnm")
       response.write "&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>Email��</font>"&"<a href='mailto.asp?expertnm="&rs("expertnm")&"'>"&rs("email")&"</a>"
       response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>�绰��</font>"&rs("tel")
       response.write "&nbsp;&nbsp;&nbsp;<font size=2 color=#996633>����˵����</font>"&rs("memo")
       response.write "</td></tr>"
       rs.MoveNext
       i=i+1 
     loop
     i=1
     rs.MoveFirst
     response.write "<tr><td colspan=2><br>��¼��¼</td></tr>"
     do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       response.write "<font size=2 color=#996633>������</font>"&rs("realnm")&"&nbsp;&nbsp;<a href='mailto.asp?expertnm="&rs("expertnm")&"'>"&rs("email")&"</a>"
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
