<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
dim username
dim txtpwd
dim sql
dim rs
dim errmsg
dim founderror
dim msg
dim UserID
username=trim(request("name"))
txtpwd=trim(request("txtpwd"))
newpwd=trim(request("newpwd"))
compwd=trim(request("compwd"))
FoundError=false
if username="" then
   ErrMsg="����������"
   foundError=True
elseif txtpwd="" then
   ErrMsg="�����������"
   foundError=True
end if
if founderror then
    session("ErrMsg")=ErrMsg
    response.redirect "myinfo.asp?page=2"
else
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸ĸ�����Ϣ</title>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" type="text/css" href="forum.css">
<script LANGUAGE="javascript">
<!--

function modifyUser_onsubmit() {
if(document.modifyUser.Password.value=="")
   {
      alert("���������룡")
      document.modifyUser.Password.focus()
      return false
    }
else if(document.modifyUser.ConfirmPwd.value=="")
   {
     alert("������ȷ�����룡")
     document.modifyUser.ConfirmPwd.focus()
     return false
    }
else if(document.modifyUser.Password.value!=document.modifyUser.ConfirmPwd.value)
   {
      alert("�����ȷ�����벻��ͬ����������д��")
      document.modifyUser.Password.focus()
      return false
    }
else
   {
     return true
    }
}                    
//-->
</script>
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
         if ucase(rs("UserName"))=ucase(UserName) and ucase(rs("userpassword"))=ucase(txtpwd) then
            FoundUser=True
            UserID=rs("UserID")
 	         exit do 
	     end if
	 rs.movenext
    loop
    end if
      if not FoundUser then
         Msg="�������ֲ����ڻ��������벻��ȷ"
      else
%>

<p align="center">��������д��������ݣ�<font color="#FF8040"><strong>*</strong></font>Ϊ������Ŀ��</p>

<form method="POST" action="savemodify.asp?UserID=<%=UserID%>" name="modifyUser"
LANGUAGE="javascript" onsubmit="return modifyUser_onsubmit()">
  <div align="center"><center><table border="0" cellpadding="0" width="80%">
    <tr>
      <td width="35%"><div align="right"><p>�� ����</td>
      <td width="65%"><input type="text" name="Username" size="20" maxlength="20"
      class="smallInput" disabled value="<%=rs("username")%>"><font color="#FF8040"><strong>*</strong></font></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>�� ��</td>
      <td width="65%"><input type="radio" value="��" checked name="Sex"><span class="smallFont">��</span> 
      <input type="radio" name="Sex" value="Ů"><span class="smallFont">Ů</span><font
      color="#FF8040"><strong> *</strong></font></td>
<%if rs("sex")="Ů" then%>
      <script language="javascript">
document.modifyUser.Sex[1].checked=true
</script>
<%end if%>

    </tr>
    <tr>
      <td width="35%"><div align="right"><p>Email��</td>
      <td width="65%"><input type="text" name="Email" size="20" maxlength="50"
      class="smallInput" value="<%=rs("useremail")%>"></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>�� �룺</td>
      <td width="65%"><input type="password" name="Password" size="20" maxlength="10"
      class="smallInput" value="<%=rs("Userpassword")%>"><font color="#FF8040"><strong>*</strong></font></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>ȷ�����룺</td>
      <td width="65%"><input type="password" name="ConfirmPwd" size="20" maxlength="10"
      class="smallInput" value="<%=rs("Userpassword")%>"><font color="#FF8040"><strong>*</strong></font></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>�� �ԣ�</td>
      <td width="65%"><input type="text" name="Comefrom" size="30" class="smallInput"
      maxlength="255" value="<%=rs("comefrom")%>"></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>�� ҳ��</td>
      <td width="65%"><input type="text" name="Homepage" size="30" class="smallInput"
      maxlength="255" value="<%=rs("homepage")%>"></td>
    </tr>
  </table>
  </center></div><div align="center"><center><p><input type="submit" value=" ���� "
  name="cmdOK" class="buttonface"> <input type="reset" value=" ��д " name="cmdCancel"
  class="buttonface"></p>
  </center></div>
</form>
<%end if
response.write msg
%>
</body>
</html>
<%end if%>
