<%@ LANGUAGE="VBSCRIPT" %>

<HTML>
<HEAD>
   <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
   <META HTTP-EQUIV="Content-Language" CONTENT="zh-CN">
   <TITLE>站内检索</TITLE>
</HEAD>
<BODY marginheight=0 marginwidth=0 topmargin=10 leftmargin=10 bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>站内检索</h3><br>

<font color="black" size="4">BBS帖子检索</font><br><font size="2">检索帖子标题、作者、内容</font><br>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd">
<tr><td align="center">
<br>
<form name="queryUser" method="POST" action="queryResult.asp" target="_blank">
<font size="2">&nbsp;&nbsp;&nbsp;关键词：</font><input type="text" name="keyword" size="17"><input class="buttonface" type="submit" value="检索" name="cmdTopic">&nbsp;&nbsp;&nbsp;
</form>
</td></tr>
</table>
<br><br>


<font color="black" size="4">下载中心资料检索</font><br><font size="2">检索资料的标题、作者、格式、说明等</font><br>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd">
<tr><td align="center">
<br>
<form method="POST" name="dl" action="searchdl.asp" target="_blank">
<font size="2">&nbsp;&nbsp;&nbsp;关键词：</font><input class="smallInput" type="text" name="keywords" size="17"><input class="buttonface" type="submit" value="检索" name="dlcmd">&nbsp;&nbsp;&nbsp;
</form>
</td></tr>
</table>
<br><br>


<font color="black" size="4">站内全文检索</font><br><font size=2>检索站内HTML、ASP等网页文件<br>不包括BBS帖子和下载资料</font><br>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd">
<tr><td align="center">
<br>
<form method="get" action="http://www.google.com/custom" target="_blank">
<font size="2">&nbsp;&nbsp;&nbsp;关键词：</font><INPUT TYPE="text" name="q" size="17" maxlength="255"><INPUT class="buttonface" type="submit" name="sa" VALUE="检索">&nbsp;&nbsp;&nbsp;
<INPUT type="hidden" name="cof" VALUE="hl:zh-CN;GALT:#999966;S:http://www.digitaloilfield.org.cn;VLC:#999999;AH:left;BGC:#FFFFFF;LC:#284259;GFNT:#999999;L:http://www.digitaloilfield.org.cn/internetismlg.jpg;ALC:#999966;T:#454545;GIMP:#cc3300;">
<input type="hidden" name="domains" value="www.digitaloilfield.org.cn">
<INPUT TYPE=hidden name=hl  value=zh-CN>
<input type="hidden" name="sitesearch" value="www.digitaloilfield.org.cn"><br>
</form>
<table boder="0"><tr><td valign="top">
Powered by</td><td valign="bottom"><a href="http://www.google.com"><img src="http://www.google.com/images/logo.gif" height="32" border="0"></a></td></tr></table>
</td></tr>
</table>
<br><br>


</center>
</body></html>
