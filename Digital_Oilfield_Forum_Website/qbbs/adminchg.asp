<!--#include file=newconn.asp-->
<html>
<head>
<title>�޸Ĺ���������</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>

<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<div align="center"><center>

<table border="0" cellspacing="1" width="90%">
  <tr>
    <td>��<%
dim rs
dim sql
dim FoundUser
FoundUser=false

adminame=trim(request.form("username"))
adminold=trim(Request.Form("oldpwd"))
adminpwd=trim(Request.Form("password"))
adminpww=trim(Request.Form("password1"))
if adminame="" then
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
      response.write "���������Ա���֣�<br><a href=loginch.asp>����</a>"
	  response.end
end if
if adminpwd="" then
     response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
     response.write "����Ա���벻��Ϊ�գ�<br><a href=loginch.asp>����</a>"
     response.end
end if

if adminpwd<>adminpww then
      response.write "<link rel='stylesheet' type='text/css' href='forum.css'>"
      response.write "�������������룡<br><a href=loginch.asp>����</a>"
      response.end
end if

set rs=server.createobject("adodb.recordset")
sql="select * from admin where adminame='"&adminame&"' and adminpwd='" &adminold&"'"
rs.open sql,conn,1,3
 
   if not rs.EOF then
        FoundUser=True
	    rs("adminpwd")=adminpwd
		rs.update
		response.write "����Ա�����޸ĳɹ�!<br><a href=login.asp>����</a>"
   end if

	  if not FoundUser then
        response.writre "�㲻�����޸Ĺ���Ա����"
      end if
    rs.close
	%>
    <p align="center">��</td>
  </tr>
</table>
</center></div>
</body>
</html>

