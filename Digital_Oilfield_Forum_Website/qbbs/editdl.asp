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
<title>����������Ϣ�޸�</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
<h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;����������Ϣ�޸�</h3></p><br><br>
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
   �ĵ����⣺<input type=text name=topic size=50 value='<% =rss("topic") %>'>*
   &nbsp;&nbsp;&nbsp;&nbsp;
   �ĵ��̱��⣺<input type=text name=shorttopic size=24 value='<% =rss("shorttopic") %>'><br>
   �ĵ����ߣ�<input type=text name=author size=10 value='<% =rss("author") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   �ĵ���ַ��<input type=text name=url size=67 value='<% =rss("url") %>'>*<br>
   �Ŷ�Ȩ�ޣ�<input type=text name=priority size=10 value='<% =rss("priority") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   �ļ���ʽ��<input type=text name=format size=20 value='<% =rss("format") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   �ļ���С��<input type=text name=size size=10 value='<% =rss("size") %>'>
   &nbsp;&nbsp;&nbsp;&nbsp;
   ���룺<input type=text name=needpass size=7 value='<% =rss("needpass") %>'>
   <br>
   ������<input type="Radio" name="display" value="0" <% if rss("display")=0 then response.write "checked"%>>��<input type="Radio" name="display" value="1" <% if rss("display")>0 then response.write "checked"%>>��
   |
   ��Ҫ��<input type="Radio" name="important" value="0" <% if rss("important")=0 then response.write "checked"%>>��<input type="Radio" name="important" value="1" <% if rss("important")>0 then response.write "checked"%>>��
   |
   Ŀ¼��<input type="Radio" name="folderornot" value="0" <% if rss("folderornot")=0 then response.write "checked"%>>��<input type="Radio" name="folderornot" value="1" <% if rss("folderornot")>0 then response.write "checked"%>>��
   |
   ���£�<input type="Radio" name="newornot" value="0" <% if rss("newornot")=0 then response.write "checked"%>>��<input type="Radio" name="newornot" value="1" <% if rss("newornot")>0 then response.write "checked"%>>��
   |
   ���ԣ�<input type="Radio" name="firstdisplay" value="0" <% if rss("firstdisplay")=0 then response.write "checked"%>>��<input type="Radio" name="firstdisplay" value="1" <% if rss("firstdisplay")>0 then response.write "checked"%>>��
   |
   �������ۣ�<input type="Radio" name="specialzone" value="0" <% if rss("specialzone")=0 then response.write "checked"%>>��<input type="Radio" name="specialzone" value="1" <% if rss("specialzone")>0 then response.write "checked"%>>��<br>
   �ĵ�������<br><textarea COLS=103 ROWS=20 name=explain tabindex=4><% =rss("explain") %></textarea><br>
   <input type="hidden" name="seq" value=<% =rss("seq")%>>
   <input type=submit value='�޸ļ�¼' tabindex="5">
   </font>
   </td></tr>
   </table>

<%
 else
    response.write "�޷��༭��"
 end if
          
%>
</center>
</body>
</html>