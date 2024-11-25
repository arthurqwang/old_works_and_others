<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/cfmexp.inc"-->

<%

 dim rss,sql
 set rss=server.createobject("adodb.recordset")
 sql="select * from experts where expertnm='"&expertnm&"'"
 rss.open sql,conn,1,1
 if not(rss.eof) then
    expertpw=rss("expertpw")
    realnm=rss("realnm")
    unitnm=rss("unitnm")
    email=rss("email")
    tel=rss("tel")
    memo=rss("memo")
 end if
 rss.close
%>

<HTML>
<HEAD>
   <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
   <META HTTP-EQUIV="Content-Language" CONTENT="zh-CN">
   <TITLE>专家/嘉宾深入讨论区-注册信息修改</TITLE>
</HEAD>
<BODY marginheight=0 marginwidth=0 topmargin=10 leftmargin=10 bgcolor="#FFFFFF">
<center>
<a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><br><Br>专家/嘉宾深入讨论区<br>注册信息修改<br>(*必填)</h3>
<form method=POST action="exppwexe.asp">
<input type=hidden name="expertnm" value="<%=expertnm%>">
<input type=hidden name="expertpw" value="<%=expertpw%>">
<table border="0">
<tr><td align="left">当前用户: <%=expertnm%> <% if expertnm="" then response.write "<font color='#cc6600'>未登录或超时</font>" %></td></tr>
<tr><td align="left">新设密码: <input type=text name="newpw" size="40" value="<%=expertpw%>">*</td></tr>
<tr><td align="left">真实姓名: <input type=text name="realnm" size="40" value="<%=realnm%>">*</td></tr>
<tr><td align="left">工作单位: <input type=text name="unitnm" size="40" value="<%=unitnm%>">*</td></tr>
<tr><td align="left">电子邮件: <input type=text name="email" size="40" value="<%=email%>">*&nbsp;只能写一个</td></tr>
<tr><td align="left">联系电话: <input type=text name="tel" size="40" value="<%=tel%>">&nbsp;可写多个</td></tr>
<tr><td align="left">补充说明: <input type=text name="memo" size="40" value="<%=memo%>"></td></tr>

<tr><td align="left"><input type=submit value="更改"></td></tr>
</table>
</form>
</center>
</body></html>
