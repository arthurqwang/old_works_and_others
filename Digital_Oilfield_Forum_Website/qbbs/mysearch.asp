<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
dim username
username=trim(request("name"))
FoundError=false
if username="" then
   ErrMsg="����������"
    session("ErrMsg")=ErrMsg
    response.redirect "myinfo.asp?page=3"
else
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ѯ������Ϣ</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>

<body>
<%
set rs=server.createobject("adodb.recordset")
   sql="select * from User"
   rs.open sql,conn,1,1
   if err.number<>0 then 
      response.write "���ݿ����ʧ�ܣ�"&err.description
   else
      dim FoundUser
      FoundUser=false
      do while  not (rs.eof or err.number<>0)
         if ucase(rs("UserName"))=ucase(UserName) then
            FoundUser=True
 	         exit do 
	     end if
	 rs.movenext
    loop
    end if
      if not FoundUser then
         response.write "�������ֲ����ڻ��������벻��ȷ"
      else
%>
<div align="center"><center>

<table border="0" width="379">
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">�� ����</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("username")%></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">�� �飺</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("Userdetails")%></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">E_Mail��</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><a href="mailto:<%=rs("useremail")%>"><%=rs("useremail")%></a></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">�� �ԣ�</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("comefrom")%></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">�� ҳ��</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><a href="<%=rs("homepage")%>"
    target="_blank"><%=rs("homepage")%></a></span></td>
  </tr>
  <tr>
    <td width="83" align="right" height="30"><font color="#0000A0"><strong><span
    class="smallFont">�� �֣�</span></strong></font></td>
    <td width="288" height="30"><span class="smallFont"><%=rs("article")%></span></td>
  </tr>
</table>
</center></div><%end if%>

</body>
</html>
<%end if%>
