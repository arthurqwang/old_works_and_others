<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>ר��/�α�����������-ע����Ϣ�޸�</h3></title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><img border="0" src="images/download.jpg" height="20" width="30"><h3><br><Br>ר��/�α�����������<br>�����޸�</h3></p>

<%
   
    dim rs,sql
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts where expertnm='"&request("expertnm")&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) and rs("expertpw")=request("expertpw") and trim(request("newpw"))<>"" and trim(request("unitnm"))<>"" and trim(request("email"))<>"" and trim(request("realnm"))<>"" then
       rs("expertpw")=trim(request("newpw"))
       rs("realnm")=trim(request("realnm"))
       rs("unitnm")=trim(request("unitnm"))
       rs("email")=trim(request("email"))
       rs("tel")=trim(request("tel"))
       rs("memo")=trim(request("memo"))
       rs.update
       response.write "�޸ĳɹ���"
       response.write "<br>�����������ǣ�"&trim(request("newpw"))&"�����ס��<br>Ϊʹ��������Ч����ر�������������ڣ�Ȼ�����½��롣"
       response.cookies("expertpw")=trim(request("newpw"))
     else 
	   response.write "����ʧ�ܡ��������롢��ʵ������������λ�������ʼ�����Ϊ�ա�"
    end if
   rs.close

'�޸���ͨ�û���
    set rs=server.createobject("adodb.recordset")
    sql="select * from user where username='"&request("expertnm")&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("userpassword")=trim(request("newpw"))
       rs("useremail")=trim(request("email"))
       rs.update
     else 
	   response.write "����ʧ�ܡ�"
    end if
   rs.close
   
%>
 

</body>
</html>