<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>����������������</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;������������</h3></p>
<font size=2 color=#666666><br>�����Խ��������ϵĵ�ַ���룬����ҹ���<br>�����Ҫ�ڱ���̳�ϴ洢������ϵ�����˻���̳����<br>���¼����������Ҫ������������ʾ�������ĵȴ���<br>лл������˽���ף�<br><br></font>
<table border="0" width="800">
<tr><td colspan="2" align="center">
<font color="#336699" size="4">������������Ŀ¼</font>
<font color="#666666" size="2">&nbsp;&nbsp;&nbsp;&nbsp;��*���<br></font>

<form action="adddlurl.asp" method="POST">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td><font color="#666666" size="2">
���ϱ��⣺<input type=text name=topic size=44>*
&nbsp;
<input type=hidden name=shorttopic size=24 value="">
����/����ߣ�<input type=text name=author size=10>
<br>
��ַ URL��<input type=text name=url size=73>*
<input type=hidden name=priority size=10 value="0">
<br>
�ļ���ʽ��<input type=text name=format size=20>
&nbsp;&nbsp;&nbsp;&nbsp;
�ļ���С��<input type=text name=size size=10><br>
<input type=hidden name="important" value="0">
<input type=hidden name="folderornot" value="0">
<input type=hidden name="needpass" value="">
<input type=hidden name="newornot" value="1">
<input type=hidden name="firstdisplay" value="1">
<input type=hidden name="specialzone" value="0">
<br>
����������<br><textarea COLS=82 ROWS=15 name=explain tabindex=4></textarea><br>
<input type=submit value='���Ӽ�¼' tabindex="5">
</font>
</td></tr>
</table>

</center>
</body>
</html>
