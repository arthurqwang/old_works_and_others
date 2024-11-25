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
   ErrMsg="请输入姓名"
   foundError=True
elseif txtpwd="" then
   ErrMsg="请输入旧密码"
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
<title>修改个人信息</title>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" type="text/css" href="forum.css">
<script LANGUAGE="javascript">
<!--

function modifyUser_onsubmit() {
if(document.modifyUser.Password.value=="")
   {
      alert("请输入密码！")
      document.modifyUser.Password.focus()
      return false
    }
else if(document.modifyUser.ConfirmPwd.value=="")
   {
     alert("请输入确认密码！")
     document.modifyUser.ConfirmPwd.focus()
     return false
    }
else if(document.modifyUser.Password.value!=document.modifyUser.ConfirmPwd.value)
   {
      alert("密码和确认密码不相同，请重新填写！")
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
      response.write "数据库操作失败："&err.description
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
         Msg="您的名字不存在或您的密码不正确"
      else
%>

<p align="center">请认真填写下面的内容（<font color="#FF8040"><strong>*</strong></font>为必填项目）</p>

<form method="POST" action="savemodify.asp?UserID=<%=UserID%>" name="modifyUser"
LANGUAGE="javascript" onsubmit="return modifyUser_onsubmit()">
  <div align="center"><center><table border="0" cellpadding="0" width="80%">
    <tr>
      <td width="35%"><div align="right"><p>姓 名：</td>
      <td width="65%"><input type="text" name="Username" size="20" maxlength="20"
      class="smallInput" disabled value="<%=rs("username")%>"><font color="#FF8040"><strong>*</strong></font></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>性 别：</td>
      <td width="65%"><input type="radio" value="男" checked name="Sex"><span class="smallFont">男</span> 
      <input type="radio" name="Sex" value="女"><span class="smallFont">女</span><font
      color="#FF8040"><strong> *</strong></font></td>
<%if rs("sex")="女" then%>
      <script language="javascript">
document.modifyUser.Sex[1].checked=true
</script>
<%end if%>

    </tr>
    <tr>
      <td width="35%"><div align="right"><p>Email：</td>
      <td width="65%"><input type="text" name="Email" size="20" maxlength="50"
      class="smallInput" value="<%=rs("useremail")%>"></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>密 码：</td>
      <td width="65%"><input type="password" name="Password" size="20" maxlength="10"
      class="smallInput" value="<%=rs("Userpassword")%>"><font color="#FF8040"><strong>*</strong></font></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>确认密码：</td>
      <td width="65%"><input type="password" name="ConfirmPwd" size="20" maxlength="10"
      class="smallInput" value="<%=rs("Userpassword")%>"><font color="#FF8040"><strong>*</strong></font></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>来 自：</td>
      <td width="65%"><input type="text" name="Comefrom" size="30" class="smallInput"
      maxlength="255" value="<%=rs("comefrom")%>"></td>
    </tr>
    <tr>
      <td width="35%"><div align="right"><p>主 页：</td>
      <td width="65%"><input type="text" name="Homepage" size="30" class="smallInput"
      maxlength="255" value="<%=rs("homepage")%>"></td>
    </tr>
  </table>
  </center></div><div align="center"><center><p><input type="submit" value=" 发送 "
  name="cmdOK" class="buttonface"> <input type="reset" value=" 重写 " name="cmdCancel"
  class="buttonface"></p>
  </center></div>
</form>
<%end if
response.write msg
%>
</body>
</html>
<%end if%>
