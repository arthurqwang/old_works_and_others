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
   <TITLE>ר��/�α�����������-ע����Ϣ�޸�</TITLE>
</HEAD>
<BODY marginheight=0 marginwidth=0 topmargin=10 leftmargin=10 bgcolor="#FFFFFF">
<center>
<a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><br><Br>ר��/�α�����������<br>ע����Ϣ�޸�<br>(*����)</h3>
<form method=POST action="exppwexe.asp">
<input type=hidden name="expertnm" value="<%=expertnm%>">
<input type=hidden name="expertpw" value="<%=expertpw%>">
<table border="0">
<tr><td align="left">��ǰ�û�: <%=expertnm%> <% if expertnm="" then response.write "<font color='#cc6600'>δ��¼��ʱ</font>" %></td></tr>
<tr><td align="left">��������: <input type=text name="newpw" size="40" value="<%=expertpw%>">*</td></tr>
<tr><td align="left">��ʵ����: <input type=text name="realnm" size="40" value="<%=realnm%>">*</td></tr>
<tr><td align="left">������λ: <input type=text name="unitnm" size="40" value="<%=unitnm%>">*</td></tr>
<tr><td align="left">�����ʼ�: <input type=text name="email" size="40" value="<%=email%>">*&nbsp;ֻ��дһ��</td></tr>
<tr><td align="left">��ϵ�绰: <input type=text name="tel" size="40" value="<%=tel%>">&nbsp;��д���</td></tr>
<tr><td align="left">����˵��: <input type=text name="memo" size="40" value="<%=memo%>"></td></tr>

<tr><td align="left"><input type=submit value="����"></td></tr>
</table>
</form>
</center>
</body></html>
