<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<%
function changeSpace(str)
   'if isnull(str) then str=""
   'if isempty(str) then str=""
end function

dim UserID
dim username
dim userpwd
dim mode
dim sex
dim useremail
dim userpassword
dim comefrom
dim homepage
dim newpwd
dim compwd
dim userfullname
dim useraddress
dim usertelephone
dim userdetails
dim willopen
dim sign
dim FoundError
dim picstr

UserID=request("UserID")
username=request("username")
mode=request("mode")
userfullname=request("fullname")
useraddress=request("address")
usertelephone=request("phone")
userdetails=request("Userdetails")
willopen=request("myopen")
if willopen="-1" then willopen="yes"
sign=request("sign")
'sex=request.form("sex")
newpwd=trim(request("newpwd"))
compwd=trim(request("compwd"))
useremail=replace(trim(request.form("email")),"<","&lt;")
userpassword=replace(trim(request.form("password")),"<","&lt;")
comefrom=replace(trim(request.form("comefrom")),"<","&lt;")
homepage=replace(trim(request.form("homepage")),"<","&lt;")
picstr=request("myphoto")

on error resume next

dim sql
dim rs
set rs=server.createobject("adodb.recordset")
if UserID="" or username="" or userpassword="" then
response.write "输入不完全,请重新输入"
response.Redirect "config.asp"
end if
sql="select * from user where UserID="&UserID
rs.open sql,conn,1,3
if mode="everydetails" then
   'rs("sex")=sex
   rs("useremail")=useremail
   'rs("UserPassword") = UserPassword
   rs("comefrom")=comefrom
   rs("homepage")=homepage
   rs("sign")=sign
   rs("UserFullname")=userfullname
   rs("UserAddress")=useraddress
   rs("Userdetails")=userdetails
   rs("Willopen")=willopen
end if

if mode="everypassword" then
   if newpwd="" or compwd="" or newpwd<>compwd then
   response.write "请确保新密码和确认密码均非空，而且一致！"
   response.write "<br><a href='config.asp'>返回用户设置区</a>"
   response.end
   else
   rs("Userpassword")=newpwd
   end if
end if

if mode="everypic" then
  if (not isnull(picstr)) and picstr<>"" and instr(ucase(picstr),"HTTP://")>0 then
    if  instr(ucase(picstr),".GIF")>0 and instr(ucase(picstr),".JPG")>0 and instr(ucase(picstr),".JPEG")>0 then
	picstr="<img src=" &picstr&">"
	rs("sign")=rs("sign")&picstr
	end if
  
  end if
end if
rs.Update
rs.close
conn.close

if err.number<>0 then 
   err.clear
   FoundError=true
   ErrMsg="数据库操作失败，请以后再试"&err.Description 
   response.write ErrMsg
else
   %>
   <html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户资料保存成功</title>
<link rel="stylesheet" type="text/css" href="lun.css">
<BODY marginheight=0 marginwidth=0 topmargin="0" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
 <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td><br><center>
<center><h3>用户资料保存成功!</h3></center>
<font size="-1"><a href="config.asp">返回论坛助理</a></font>
</center><br></td></tr></table><br>
<hr>
<!--#include file="FooterLogo.asp"-->
</center>
</font></body></html>
<%
end if
%>

