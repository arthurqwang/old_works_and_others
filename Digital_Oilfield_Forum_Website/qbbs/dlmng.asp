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
<title>����������������</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;�����������Ĺ���</h3></p>
<table border="0" width="800">
<tr><td colspan="2">
<font color="#336699" size="4">������������Ŀ¼</font>
<font color="#666666" size="2">&nbsp;&nbsp;&nbsp;&nbsp;��*���<br></font>

<form action="adddl.asp" method="POST">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td><font color="#666666" size="2">
�ĵ����⣺<input type=text name=topic size=50>*
&nbsp;&nbsp;&nbsp;&nbsp;
�ĵ��̱��⣺<input type=text name=shorttopic size=24><br>
�ĵ����ߣ�<input type=text name=author size=10>
&nbsp;&nbsp;&nbsp;&nbsp;
�ĵ���ַ��<input type=text name=url size=67 value="http://www.digitaloilfield.org.cn/downloads/">*<br>
�Ŷ�Ȩ�ޣ�<input type=text name=priority size=10>
&nbsp;&nbsp;&nbsp;&nbsp;
�ļ���ʽ��<input type=text name=format size=20>
&nbsp;&nbsp;&nbsp;&nbsp;
�ļ���С��<input type=text name=size size=10>
&nbsp;&nbsp;&nbsp;&nbsp;
���룺<input type=text name=needpass size=7>
<br>
������<input type="Radio" name="display" value="0">��<input type="Radio" name="display" value="1" checked>��
|
��Ҫ��<input type="Radio" name="important" value="0" checked>��<input type="Radio" name="important" value="1">��
|
Ŀ¼��<input type="Radio" name="folderornot" value="0" checked>��<input type="Radio" name="folderornot" value="1">��
|
���£�<input type="Radio" name="newornot" value="0">��<input type="Radio" name="newornot" value="1" checked>��
|
���ԣ�<input type="Radio" name="firstdisplay" value="0">��<input type="Radio" name="firstdisplay" value="1" checked>��
|
�������ۣ�<input type="Radio" name="specialzone" value="0" checked>��<input type="Radio" name="specialzone" value="1">��
<br>
�ĵ�������<br><textarea COLS=103 ROWS=20 name=explain tabindex=4></textarea>
<input type=submit value='���Ӽ�¼' tabindex="5">
</font>
</td></tr>
</table>
<br>
<hr>
<br><br>
<font color="#336699" size="4">����ԭ����������Ŀ¼<br></font>

</td></tr>
<%
dim rs,sql,i
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from dllist order by priority desc,seq desc"
       rs.open sql,conn,1,1
 	 do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       if rs("display")=0 then response.write "<a href='savedl.asp?action=release&seq="&rs("seq")&"'><font size=2 color=#ff0000>����</font></a>&nbsp;&nbsp;"
       response.write "<a href='savedl.asp?action=modify&seq="&rs("seq")&"'><font size=2 color=#336699>�޸�</font></a>"
       response.write "&nbsp;&nbsp;<a href='savedl.asp?action=delete&seq="&rs("seq")&"'><font size=2 color=#336699>ɾ��</font></a>"
       if rs("folderornot")=1 then response.write "<img border='0' src='images/folder.gif' title='�ļ���'>"
       if rs("important")=1 then response.write "<img border='0' src='images/important.gif' title='��Ҫ�ĵ�'>"
       if trim(rs("needpass"))<>"" then response.write "<img border='0' src='images/lock.gif' title='��Ҫ����'>"
       if rs("newornot")=1 then response.write "<img border='0' src='images/new.gif' title='�����ĵ�'>"
       if rs("firstdisplay")=1 then response.write "<img border='0' src='images/1st.gif' title='��ҳ��ʾ'>"
       if rs("specialzone")=1 then response.write "<img border='0' src='images/expert.gif' title='��������'>"
       response.write "<font size=2 color=#996633>���⣺</font><a href="&rs("url")&" target='_blank'>"&rs("topic")&"</a>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>�̱��⣺</font>"&rs("shorttopic")
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>���ߣ�</font>"&rs("author")
       
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>�Ŷ�Ȩ�ޣ�</font>"&rs("priority")
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>��ʽ��</font>"&rs("format")
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>��С��</font>"&rs("size")
       if trim(rs("needpass"))<>"" then response.write "&nbsp;&nbsp;<font size=2 color=#996633>���룺</font>"&rs("needpass")
       response.write "<br><font size=2 color=#996633>URL��</font>"&rs("url")
       response.write "</font>"
       response.write "<br><font size=2 color=#996633>˵����</font><font size=2 color='#666666'>"&rs("explain") 
       response.write "</font></td></tr>"
       rs.MoveNext
       i=i+1 
     loop
     rs.Close
  
%>
</table>
</center>
</body>
</html>
