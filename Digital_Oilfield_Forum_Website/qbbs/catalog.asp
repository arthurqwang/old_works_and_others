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
<title>BBS���·���</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
<h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;BBS���·���</h3></p><br><br>
<%

 dim rss,announceid,sql,catalog
 announceid=request("announceid")
 set rss=server.createobject("adodb.recordset")
 sql="select * from bbs1 where announceid="&announceid
 rss.open sql,conn,1,1
 if not(rss.eof) then
%>

   <form action="ctlgexe.asp" method="POST">
   <table border="0" cellpadding="1" cellspacing="1">
   <tr><td><font color="#666666" size="2">
   <font size=4 color=#000000>����:&nbsp;<%=rss("topic")%></font><br>
<%  catalog=LCase(rss("catalog")) %>

<input type="checkbox" name="ctlg0" <% if instr(catalog,"0")>0 then response.write "checked" %>>δ����<br>
<input type="checkbox" name="ctlg1" <% if instr(catalog,"1")>0 then response.write "checked" %>>���������ϵͳ����<br>
<input type="checkbox" name="ctlg2" <% if instr(catalog,"2")>0 then response.write "checked" %>>���������ݿ�<br>
<input type="checkbox" name="ctlg3" <% if instr(catalog,"3")>0 then response.write "checked" %>>�����������ʩ<br>
<input type="checkbox" name="ctlg4" <% if instr(catalog,"4")>0 then response.write "checked" %>>GIS<br>
<input type="checkbox" name="ctlg5" <% if instr(catalog,"5")>0 then response.write "checked" %>>�칫�Զ���<br>
<input type="checkbox" name="ctlg6" <% if instr(catalog,"6")>0 then response.write "checked" %>>��ý��<br>
<input type="checkbox" name="ctlg7" <% if instr(catalog,"7")>0 then response.write "checked" %>>ϵͳά��<br>
<input type="checkbox" name="ctlg8" <% if instr(catalog,"8")>0 then response.write "checked" %>>������ʵ<br>
<input type="checkbox" name="ctlg9" <% if instr(catalog,"9")>0 then response.write "checked" %>>��������<br>
<input type="checkbox" name="ctlga" <% if instr(catalog,"a")>0 then response.write "checked" %>>ERP<br>
<input type="checkbox" name="ctlgb" <% if instr(catalog,"b")>0 then response.write "checked" %>>��̽<br>
<input type="checkbox" name="ctlgc" <% if instr(catalog,"c")>0 then response.write "checked" %>>����<br>
<input type="checkbox" name="ctlgd" <% if instr(catalog,"d")>0 then response.write "checked" %>>��̽����һ�廯<br>
<input type="checkbox" name="ctlge" <% if instr(catalog,"e")>0 then response.write "checked" %>>���湤��<br>
<input type="checkbox" name="ctlgf" <% if instr(catalog,"f")>0 then response.write "checked" %>>��Ӫ����<br>
<input type="checkbox" name="ctlgg" <% if instr(catalog,"g")>0 then response.write "checked" %>>��Ϣ��������������<br>
<input type="checkbox" name="ctlgz" <% if instr(catalog,"z")>0 then response.write "checked" %>>վ���������<br>

<input type="hidden" name="announceid" value="<% =announceid %>">
<input class="button1" type="submit" value="OK" name="cmdTopic">

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