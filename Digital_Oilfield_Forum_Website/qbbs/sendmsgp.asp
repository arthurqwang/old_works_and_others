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
<title>�ڲ���Ϣ����</title>
</head>

<BODY  bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;�ڲ���Ϣ����</h3></p>

<font color="#336699" size="4">��Ϣ����</font><br></font>
<form action="sendmsg.asp" method="POST">
<table border="0" align="center">
<tr><td align="left"><font color="#000000" size="3">��Ϣ����</font></td>
<td><input type="text" name="msgtpc" value="����������̳:" size=101></td></tr>
<tr><td valign="top"><font color="#000000" size="3">ǰ��˵��</font></td>
<td><textarea COLS=100 ROWS=15 name='preface' tabindex="4"></textarea></td></tr>
<tr><td colspan="2">

���͸���<input type="checkbox" name="toexpert" size="5" class="input3" checked>ר��/�α�&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="tousualuser" size="5" class="input3" checked>һ���û�
<br>���ӣ�<input type="checkbox" name="attach_articles" size="5" class="input3" checked>������&nbsp;&nbsp;&nbsp;&nbsp;ʱ�䷶Χ����<input type=text name=month_num size=1 value="1">��
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="attach_downloads" size="5" class="input3" checked>��������&nbsp;&nbsp;&nbsp;&nbsp;��Χ����<input type=text name="dlnum" size=1 value="5">��

<br>
<input type=submit value='����' tabindex="5">
</td></tr></table>
<br><hr><b><font size=4>ȫ�������ʼ���ַ</font></b>
<table><tr><td><font size=3 color=#336699>ר��/�α�</font></td><td><font size=3 color=#336699>һ���û�</font></td><td><font size=3 color=#336699>���Ӹ���</font></td><td><font size=3 color=#336699>���ظ�ȫ��</font></td></tr>
<tr>
<td valign="top"><font size=2>
<%
      dim rss,sql,distinct_all
      distinct_all=""
      set rss=server.createobject("adodb.recordset")
      sql="select email from experts where email like '%@%' order by email"
      rss.open sql,conn,1,1
      do while not rss.EOF
         response.write lcase(rss("email"))&"<br>"
         if instr(distinct_all,lcase(rss("email")))=0 then distinct_all=distinct_all&lcase(rss("email"))&"<br>"
         rss.MoveNext
      loop
      rss.close
%>
</font></td>
<td valign="top"><font size=2>
<%

      set rss=server.createobject("adodb.recordset")
      sql="select distinct UserEmail from user where UserEmail like '%@%' order by UserEmail"
      rss.open sql,conn,1,1
      do while not rss.EOF
         response.write lcase(rss("useremail"))&"<br>"
         if instr(distinct_all,lcase(rss("useremail")))=0 then distinct_all=distinct_all&lcase(rss("useremail"))&"<br>"
         rss.MoveNext
      loop
      rss.close
%>
</font></td>
<td valign="top"><font size=2>
<%

      set rss=server.createobject("adodb.recordset")
      sql="select distinct UserEmail from bbs1 where UserEmail like '%@%' order by UserEmail"
      rss.open sql,conn,1,1
      do while not rss.EOF
         response.write lcase(rss("useremail"))&"<br>"
         if instr(distinct_all,lcase(rss("useremail")))=0 then distinct_all=distinct_all&lcase(rss("useremail"))&"<br>"
         rss.MoveNext
      loop
      rss.close
%>
</font></td>
<td valign="top"><font size=2>
<%
      response.write distinct_all
%>
</font></td>

</tr>
</table>

</center>
</body>
</html>
