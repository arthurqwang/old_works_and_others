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
   ErrMsg="����������"
   foundError=True
elseif txtpwd="" then
   ErrMsg="�����������"
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
<title>�޸ĸ�����Ϣ</title>
<link rel="stylesheet" type="text/css" href="lun.css">
<script LANGUAGE="javascript" runat=server>
<!--

function modifyUser_onsubmit() {
if(document.all.modifyUser.newpwd.value=="")
   {
      alert("���������룡")
      document.all.modifyUser.newpwd.focus()
      return false
    }
else if(document.all.modifyUser.compwd.value=="")
   {
     alert("������ȷ�����룡")
     document.all.modifyUser.compwd.focus()
     return false
    }
else if(document.all.modifyUser.newpwd.value!=document.all.modifyUser.compwd.value)
   {
      alert("�����ȷ�����벻��ͬ����������д��")
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
         session("change_user_detail_yes")=Msg
		 response.write Msg
 else'�ҵ�������������ƥ����û�
   session("change_user_detail_yes")="yes"
 if mode="everydetails" then '��ʾ�޸��û����ϵ�ҳ��
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td>
<center><h3>��̳�û������޸� </h3></center>
<form method="POST" action="savemodify.asp?UserID=<%=UserID%>">
 
        <input type=hidden name="password" value="<%=txtpwd%>">
        <input type=hidden name="username" value="<%=username%>">
        <input type="hidden" name="mode" value="everydetails">
      
        <table border=0 cellpadding="0">
          <tr> 
            <td align=right>��ʵ����: </td>
            <td> 
              <input type=text name="fullname" value="<%=rs("UserFullname")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>�ʼ���ַ: </td>
            <td> 
              <input type=text name="email" value="<%=rs("UserEmail")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>��ϵ��ַ: </td>
            <td> 
              <input type=text name="address" value="<%=rs("UserAddress")%>">
            </td>
          </tr>
		  <tr> 
            <td align=right>�� �� : </td>
            <td> 
              <input type=text name="comefrom" value="<%=rs("comefrom")%>">
            </td>
          </tr>
		  <tr> 
            <td align=right>������ҳ: </td>
            <td> 
              <input type=text name="homepage" value="<%=rs("homepage")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>��ϵ�绰: </td>
            <td> 
              <input type=text name="phone" value="<%=rs("UserTelephone")%>">
            </td>
          </tr>
          <tr> 
            <td align=right>�Լ�����ϸ����(С��50��,<br>
����Ҫ�����Լ�����Ƭ,
������д��&lt;img src=���ͼƬ��ַ>����): </td>
            <td> 
              <textarea name="Userdetails" cols="40" rows="4"><%=rs("Userdetails")%></textarea>
            </td>
          </tr>
          <tr> 
            <td> 
              <div align="right">�Ƿ�Ը���Լ���������?</div>
            </td>
            <td>
<input type="radio" name="myopen" value="yes" checked>��
<input type="radio" name="myopen" value="no">��
            </td>
          </tr>


          <tr> 
            <td align=right>��̳����ʱ��ǩ����������(��HTML��): </td>
            <td align=right> 
              <textarea name="sign" cols="40" rows="4"><%=rs("sign")%></textarea>
            </td>
          </tr>
        </table><center>
        <input type=submit value="ȷ��" name="submit">
        <input type=reset  value="����" name="reset"></center>
      </form>
</center>
<br></td></tr></table><br>
<%end if
if mode="everypassword" then '������޸�����
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td><br>
<center>
<h3>��̳�û������޸� </h3>
      <form method=POST action="savemodify.asp?UserID=<%=UserID%>" name=modifyUser LANGUAGE="javascript" onsubmit="return modifyUser_onsubmit()">
        <input type=hidden name="mode" value="everypassword">
        <input type=hidden name="password" value="<%=txtpwd%>">
        <input type=hidden name="username" value="<%=username%>">
        <table border=0 cellpadding="0">
          <tr> 
            <td align=right>������: </td>
            <td> 
              <input type=password name="newpwd" value="">
            </td>
          </tr>
          <tr> 
            <td align=right>������������ȷ֤: </td>
            <td> 
              <input type=password name="compwd" value="">
            </td>
          </tr>
        </table><center>
        <input type=submit value="ȷ��" name="submit">
        <input type=reset name="reset"></center>
      </form>
</center>
<br></td></tr></table><br>
<%end if%>

<% if mode="everypic" then '�޸�ͼƬ����
%>

   <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td><br>
   <form method=POST action="savemodify.asp?UserID=<%=UserID%>">
        <input type=hidden name="mode" value="everypic">
        <input type=hidden name="password" value="<%=txtpwd%>">
        <input type=hidden name="username" value="<%=username%>">
       

<table width="90%" border="0" cellspacing="5" cellpadding="5" align="center" class="hangju">
              <tr> 
                <td colspan="5"> 
                  <p align="center"><h3>��̳�û�ͼ������</h3><font size="3">ѡ���Լ�ϲ����ͼƬ��Ϊ�Լ���������</font></p>
                </td>

<tr><td  colspan="5">
<div align=center >������ͷ����ַ:<br>
<input type=text name=myphoto size=50> <br>��������Ƭ���Լ�������,���Ȱ����ϴ���һ�����������</div>
</td></tr></table>

<center><input type=submit value="ȷ��">
<input type=reset value="��λ"></center>
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
