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
<title>资料下载信息修改</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
<h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;资料下载信息修改</h3></p><br><br>
<%

 dim rss,seq,sql
 seq=request("seq")
 set rss=server.createobject("adodb.recordset")
 sql="select * from dllist where seq="&seq
 rss.open sql,conn,1,1
 if not(rss.eof) then
%>

   <form action="mdfdl.asp" method="POST">
   <table border="0" cellpadding="1" cellspacing="1">
   <tr><td><font color="#666666" size="2">
   文档标题：<input type=text name=topic size=50 value='<% =rss("topic") %>'>*
   &nbsp;&nbsp;&nbsp;&nbsp;
   文档短标题：<input type=text name=shorttopic size=24 value='<% =rss("shorttopic") %>'><br>
   文档作者：<input type=text name=author size=10 value='<% =rss("author") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   文档地址：<input type=text name=url size=67 value='<% =rss("url") %>'>*<br>
   排队权限：<input type=text name=priority size=10 value='<% =rss("priority") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   文件格式：<input type=text name=format size=20 value='<% =rss("format") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   文件大小：<input type=text name=size size=10 value='<% =rss("size") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   密码：<input type=text name=needpass size=7 value='<% =rss("needpass") %>'>
   <br>
   发布：<input type="Radio" name="display" value="0" <% if rss("display")=0 then response.write "checked"%>>否<input type="Radio" name="display" value="1" <% if rss("display")>0 then response.write "checked"%>>是
   |
   重要：<input type="Radio" name="important" value="0" <% if rss("important")=0 then response.write "checked"%>>否<input type="Radio" name="important" value="1" <% if rss("important")>0 then response.write "checked"%>>是
   |
   目录：<input type="Radio" name="folderornot" value="0" <% if rss("folderornot")=0 then response.write "checked"%>>否<input type="Radio" name="folderornot" value="1" <% if rss("folderornot")>0 then response.write "checked"%>>是
   |
   置新：<input type="Radio" name="newornot" value="0" <% if rss("newornot")=0 then response.write "checked"%>>否<input type="Radio" name="newornot" value="1" <% if rss("newornot")>0 then response.write "checked"%>>是
   |
   首显：<input type="Radio" name="firstdisplay" value="0" <% if rss("firstdisplay")=0 then response.write "checked"%>>否<input type="Radio" name="firstdisplay" value="1" <% if rss("firstdisplay")>0 then response.write "checked"%>>是
   |
   深入讨论：<input type="Radio" name="specialzone" value="0" <% if rss("specialzone")=0 then response.write "checked"%>>否<input type="Radio" name="specialzone" value="1" <% if rss("specialzone")>0 then response.write "checked"%>>是<br>
   文档描述：<br><textarea COLS=103 ROWS=20 name=explain tabindex=4><% =rss("explain") %></textarea><br>
   <input type="hidden" name="seq" value=<% =rss("seq")%>>
   <input type=submit value='修改记录' tabindex="5">
   </font>
   </td></tr>
   </table>

<%
 else
    response.write "无法编辑！"
 end if
          
%>
</center>
</body>
</html>