<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
dim username
dim txtpwd
dim mode
dim sql
dim rs
dim errmsg
dim founderror
dim msg
dim UserID
username=trim(request("username"))
txtpwd=trim(request("password"))
mode=trim(request("mode"))

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
    response.redirect "config.asp"
else
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改个人信息</title>
<link rel="stylesheet" type="text/css" href="lun.css">
<script LANGUAGE="javascript" runat=server>
<!--

function modifyUser_onsubmit() {
if(document.all.modifyUser.newpwd.value=="")
   {
      alert("请输入密码！")
      document.all.modifyUser.newpwd.focus()
      return false
    }
else if(document.all.modifyUser.compwd.value=="")
   {
     alert("请输入确认密码！")
     document.all.modifyUser.compwd.focus()
     return false
    }
else if(document.all.modifyUser.newpwd.value!=document.all.modifyUser.compwd.value)
   {
      alert("密码和确认密码不相同，请重新填写！")
      document.all.modifyUser.newpwd.focus()
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

<BODY marginheight=0 marginwidth=0 topmargin="0" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></center>
<iframe name=MyFrame align=default src="" frameborder="no" border="0" width=100% SCROLLING="no" height=11></iframe>
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
         session("change_user_detail_yes")=Msg
		 response.write Msg
 else'找到了姓名和密码匹配的用户
   session("change_user_detail_yes")="yes"
 if mode="everydetails" then '显示修改用户资料的页面
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td>
<center><h3>论坛用户资料修改 </h3></center>
<form method="POST" action="savemodify.asp?UserID=<%=UserID%>">
 
        <input type=hidden name="password" value="<%=txtpwd%>">
        <input type=hidden name="username" value="<%=username%>">
        <input type="hidden" name="mode" value="everydetails">
      
        <table border=0 cellpadding="0">
          <tr> 
            <td align=right>真实姓名: </td>
            <td> 
              <input type=text name="fullname" value="<%=rs("UserFullname")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>邮件地址: </td>
            <td> 
              <input type=text name="email" value="<%=rs("UserEmail")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>联系地址: </td>
            <td> 
              <input type=text name="address" value="<%=rs("UserAddress")%>">
            </td>
          </tr>
		  <tr> 
            <td align=right>来 自 : </td>
            <td> 
              <input type=text name="comefrom" value="<%=rs("comefrom")%>">
            </td>
          </tr>
		  <tr> 
            <td align=right>个人主页: </td>
            <td> 
              <input type=text name="homepage" value="<%=rs("homepage")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>联系电话: </td>
            <td> 
              <input type=text name="phone" value="<%=rs("UserTelephone")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>自己的详细介绍(小于50字,<br>
如需要加入自己的照片,
在这里写入&lt;img src=你的图片地址>即可): </td>
            <td> 
              <textarea name="Userdetails" cols="40" rows="4"><%=rs("Userdetails")%></textarea>
            </td>
          </tr>
          <tr> 
            <td> 
              <div align="right">是否愿意自己档案公开?</div>
            </td>
            <td>
<input type="radio" name="myopen" value="yes" checked>是
<input type="radio" name="myopen" value="no">否
            </td>
          </tr>


          <tr> 
            <td align=right>论坛发言时的签名内容设置(可HTML码): </td>
            <td align=right> 
              <textarea name="sign" cols="40" rows="4"><%=rs("sign")%></textarea>
            </td>
          </tr>
        </table><center>
        <input type=submit value="确定" name="submit">
        <input type=reset  value="重置" name="reset"></center>
      </form>
</center>
<br></td></tr></table><br>
<%end if
if mode="everypassword" then '如果是修改密码
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td><br>
<center>
<h3>论坛用户密码修改 </h3>
      <form method=POST action="savemodify.asp?UserID=<%=UserID%>" name=modifyUser LANGUAGE="javascript" onsubmit="return modifyUser_onsubmit()">
        <input type=hidden name="mode" value="everypassword">
        <input type=hidden name="password" value="<%=txtpwd%>">
        <input type=hidden name="username" value="<%=username%>">
        <table border=0 cellpadding="0">
          <tr> 
            <td align=right>新密码: </td>
            <td> 
              <input type=password name="newpwd" value="">
            </td>
          </tr>
          <tr> 
            <td align=right>再输入新密码确证: </td>
            <td> 
              <input type=password name="compwd" value="">
            </td>
          </tr>
        </table><center>
        <input type=submit value="确定" name="submit">
        <input type=reset name="reset"></center>
      </form>
</center>
<br></td></tr></table><br>
<%end if%>

<% if mode="everypic" then '修改图片资料
%>

   <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td><br>
   <form method=POST action="savemodify.asp?UserID=<%=UserID%>">
        <input type=hidden name="mode" value="everypic">
        <input type=hidden name="password" value="<%=txtpwd%>">
        <input type=hidden name="username" value="<%=username%>">
       

<table width="90%" border="0" cellspacing="5" cellpadding="5" align="center" class="hangju">
              <tr> 
                <td colspan="5"> 
                  <p align="center"><h3>论坛用户图像资料</h3><font size="3">选择自己喜欢的图片作为自己的人物标记</font></p>
                </td>

<tr><td  colspan="5">
<div align=center >请输入头像网址:<br>
<input type=text name=myphoto size=50> <br>如果你的照片在自己电脑上,请先把它上传到一个网络像册中</div>
</td></tr></table>

<center><input type=submit value="确定">
<input type=reset value="复位"></center>
</form>
<br></td></tr></table><br>
<% end if%>

<%end if
'response.write msg
%>
<hr>

</center>
</font>
</body>
</html>
<%end if%>
