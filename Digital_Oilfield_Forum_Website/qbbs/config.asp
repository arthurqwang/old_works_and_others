<%@ LANGUAGE="VBSCRIPT" %>
<%option explicit%>
<!--#include file="newconn.asp"-->
<%
   dim sql,rs
   dim sel
   dim boardid
   boardid=1
   if not (isNUll(request("boardid")) or isEmpty(request("boardid")) or (request("BoardID")="") ) then
      boardid=request("boardid")
	  else 
	boardid=1 'Ĭ�Ͻ����1������
   end if

   set rs=server.createobject("adodb.recordset")
   sql="select * from board"
   rs.open sql,conn,1,1
%>
<HTML>
<HEAD>
   <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
   <META HTTP-EQUIV="Content-Language" CONTENT="zh-CN">
   <link rel="stylesheet" type="text/css" href="lun.css">
   <TITLE>��̳����</TITLE>
</HEAD>
<BODY marginheight=0 marginwidth=0 topmargin=10 leftmargin=10 bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>��̳����</h3></center>
<center>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td>
<center><font size="-1">[ <a href="about.asp" target="_blank">ʹ�ð���</a>|<a href="point.asp"  target="_blank">�������а�</a>|<a href="Article.asp?boardID=<%=boardID%>" target="_blank">�������а�</a>|<a href="#1">������ר�ù���</a> ]</font>
<br>
<hr>
<h3>��̳�û������޸�</h3>
<form method=POST action="boarduserdetail.asp">
<input type=hidden name="action" value="change_usrdata">
��������ע�����̳ [��ͨ�û�] ʹ��<br>������Ѿ���ע��� [ר��/�α�] �벻Ҫ�ڴ��޸���Ϣ
<table border=0 cellpadding="0" cellpadding="0">

<tr>
<td align=right>�û�: </td><td><input type=text name="username" size="10"></td>
</tr><tr>
<td align=right>����: </td><td><input type=password name="password" size="10"></td>
</tr><tr>
<td align=center colspan="2" ><input type="Radio" name="mode" value="everydetails" checked>��������
<input type="Radio" name="mode" value="everypassword" >�޸�����
<input type="Radio" name="mode" value="everypic" >ͼƬ����
</td></tr>
</table>
<input type=submit value="����"><input type=reset>
</form>
<hr>
<h3><a name="1"><h3>������ר�ù���</h3></p>��ͨ�û�����</a></h3>
<form method=POST action="eChklogin.asp">
<table border=0 cellpadding="0" cellpadding="0">
<tr>
<td align=right>�������û���: </td><td><input type=text name="username" size="10"></td>
</tr><tr>
<td align=right>����������: </td><td><input type=password name="password" size="10"></td>
</tr><tr>
<td align=left colspan="2" >
<input type="Radio" name="action" value="content" checked>������̳����
<input type="Radio" name="action" value="download">����������������<br>
<input type="Radio" name="action" value="expert">����ר�Ҽα�
<input type="Radio" name="action" value="boardset">��̳�����޸�<br>
<input type="Radio" name="action" value="userdata">������̳�û�
<input type="Radio" name="action" value="chgmanage">���Ĺ����ʺ�<br>
<input type="Radio" name="action" value="sendmsg">�����ڲ���Ϣ
</td></tr>
</table>
<input type=submit value="����"><input type=reset>
</form><hr>
<!--#include file="FooterLogo.asp"-->
</center>
</font></body></html>
