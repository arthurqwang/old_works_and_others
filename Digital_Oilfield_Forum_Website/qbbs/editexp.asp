<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
if request.cookies("adminok")="" then
  response.redirect "firstpg.asp"
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ר��/�α���Ϣ�޸�</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
<h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;ר��/�α���Ϣ�޸�</h3></p><br><br>
<%

 dim rss,expertnm,sql
 expertnm=request("expertnm")
 set rss=server.createobject("adodb.recordset")
 sql="select * from experts where expertnm='"&expertnm&"'"
 rss.open sql,conn,1,1
 if not(rss.eof) then

%>

   <form action="mdfexp.asp" method="POST">
   <table border="0" cellpadding="1" cellspacing="1">
   <tr><td><font color="#666666" size="2">
   ����<input type=text name=realnm size=5 value='<% =rss("realnm") %>'>*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   ��λ<input type=text name=unitnm size=52 value='<% =rss("unitnm") %>'>*<br>
   �û�<input type=hidden name=expertnm size=5 value='<% =rss("expertnm") %>'>&nbsp;<font color="#cc6600"><%=rss("expertnm")&left("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",(10-len(rss("expertnm")))*6)%></font>&nbsp;&nbsp;
   ����<input type=text name=expertpw size=10 value='<% =rss("expertpw") %>'>*&nbsp;&nbsp;
   Email<input type=text name=email size=15 value='<% =rss("email") %>'>*&nbsp;&nbsp;
   ר��Ŀ¼<input type=text name=folder size=3 value='<% =rss("folder") %>'><br>
   �绰<input type=text name=tel size=20 value='<% =rss("tel")%>'>&nbsp;&nbsp;&nbsp;&nbsp;����˵��<input type=text name=memo size=36 value='<% =rss("memo")%>'><br>
   �״̬<input type="Radio" name="active" value="1" <% if rss("active")>0 then response.write "checked" %>>��<input type="Radio" name="active" value="0" <% if rss("active")=0 then response.write "checked"%>>��
   &nbsp;&nbsp;&nbsp;�����¼��¼<input type="Radio" name="clrloginrec" value="1">��<input type="Radio" name="clrloginrec" value="0" checked>��
   <input type=submit value='�޸ļ�¼' tabindex="5">
   </font>
   </td></tr>
   </table>

<%
 else
    response.write "�޷��༭��"
 end if
 rss.close         
%>
</center>
</body>
</html>