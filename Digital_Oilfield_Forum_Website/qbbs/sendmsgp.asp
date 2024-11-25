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
<title>内部消息发送</title>
</head>

<BODY  bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;内部消息发送</h3></p>

<font color="#336699" size="4">消息内容</font><br></font>
<form action="sendmsg.asp" method="POST">
<table border="0" align="center">
<tr><td align="left"><font color="#000000" size="3">消息标题</font></td>
<td><input type="text" name="msgtpc" value="数字油田论坛:" size=101></td></tr>
<tr><td valign="top"><font color="#000000" size="3">前导说明</font></td>
<td><textarea COLS=100 ROWS=15 name='preface' tabindex="4"></textarea></td></tr>
<tr><td colspan="2">

发送给：<input type="checkbox" name="toexpert" size="5" class="input3" checked>专家/嘉宾&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="tousualuser" size="5" class="input3" checked>一般用户
<br>附加：<input type="checkbox" name="attach_articles" size="5" class="input3" checked>精华贴&nbsp;&nbsp;&nbsp;&nbsp;时间范围：近<input type=text name=month_num size=1 value="1">月
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="attach_downloads" size="5" class="input3" checked>下载资料&nbsp;&nbsp;&nbsp;&nbsp;范围：近<input type=text name="dlnum" size=1 value="5">个

<br>
<input type=submit value='发送' tabindex="5">
</td></tr></table>
<br><hr><b><font size=4>全部电子邮件地址</font></b>
<table><tr><td><font size=3 color=#336699>专家/嘉宾</font></td><td><font size=3 color=#336699>一般用户</font></td><td><font size=3 color=#336699>帖子附带</font></td><td><font size=3 color=#336699>不重复全部</font></td></tr>
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
