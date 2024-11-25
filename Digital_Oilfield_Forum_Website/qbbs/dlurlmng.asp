<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>管理资料下载中心</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;资料下载中心</h3></p>
<font size=2 color=#666666><br>您可以将您的资料的地址加入，供大家共享。<br>如果需要在本论坛上存储，请联系主持人或论坛助理。<br>您新加入的链接需要经过审查才能显示，请耐心等待。<br>谢谢您的无私奉献！<br><br></font>
<table border="0" width="800">
<tr><td colspan="2" align="center">
<font color="#336699" size="4">增加下载资料目录</font>
<font color="#666666" size="2">&nbsp;&nbsp;&nbsp;&nbsp;（*必填）<br></font>

<form action="adddlurl.asp" method="POST">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td><font color="#666666" size="2">
资料标题：<input type=text name=topic size=44>*
&nbsp;
<input type=hidden name=shorttopic size=24 value="">
作者/添加者：<input type=text name=author size=10>
<br>
地址 URL：<input type=text name=url size=73>*
<input type=hidden name=priority size=10 value="0">
<br>
文件格式：<input type=text name=format size=20>
&nbsp;&nbsp;&nbsp;&nbsp;
文件大小：<input type=text name=size size=10><br>
<input type=hidden name="important" value="0">
<input type=hidden name="folderornot" value="0">
<input type=hidden name="needpass" value="">
<input type=hidden name="newornot" value="1">
<input type=hidden name="firstdisplay" value="1">
<input type=hidden name="specialzone" value="0">
<br>
资料描述：<br><textarea COLS=82 ROWS=15 name=explain tabindex=4></textarea><br>
<input type=submit value='增加记录' tabindex="5">
</font>
</td></tr>
</table>

</center>
</body>
</html>
