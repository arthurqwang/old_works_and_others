<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
dim username
dim oldpwd
dim newpwd
dim compwd
dim sql
dim rs
dim errmsg
dim founderror
username=trim(request("name"))
oldpwd=trim(request("oldpwd"))
newpwd=trim(request("newpwd"))
compwd=trim(request("compwd"))
FoundError=false
if username="" then
   ErrMsg="����������"
   foundError=True
elseif oldpwd="" then
   ErrMsg="�����������"
   foundError=True
elseif newpwd="" then
   ErrMsg="������������"
   foundError=True
elseif compwd="" then
   ErrMsg="������ȷ������"
   foundError=True
elseif newpwd<>compwd then
   ErrMsg="��������ȷ�����벻��ͬ"
   foundError=True

end if
if founderror then
    session("ErrMsg")=ErrMsg
    response.redirect "myinfo.asp?page=1"
else
   set rs=server.createobject("adodb.recordset")
   sql="select * from User"
   rs.open sql,conn,1,3
   if err.number<>0 then 
      response.write "���ݿ����ʧ�ܣ�"&err.description
   else
      dim FoundUser
      FoundUser=false
      do while  not (rs.eof or err.number<>0)
         if ucase(rs("UserName"))=ucase(UserName) and ucase(rs("userpassword"))=ucase(oldpwd) then
            FoundUser=True
 	        rs("userpassword")=newpwd
	        rs.update
	        Msg="�����޸ĳɹ������ס�������"
	       exit do 
	     end if
	 rs.movenext
    loop
      if not FoundUser then
         Msg="�������ֲ����ڻ��������벻��ȷ"
         founderror=true 
      end if
    rs.close
    end if
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" type="text/css" href="forum.css">
</head>

<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>

<p align="center"><%=msg%> ��</p>
</body>
</html>
