<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
if request.cookies("adminok")="" then
  response.redirect "firstpg.asp"
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>专家/嘉宾信息修改</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;专家/嘉宾信息修改</h3></p>

<%
    dim rs,sql

  if request("realnm")<>"" and request("expertnm")<>"" and request("expertpw")<>"" and request("unitnm")<>"" and request("active")>=0 then  
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts where expertnm='"&request("expertnm")&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("realnm")=request("realnm")
       rs("unitnm")=request("unitnm")
       'rs("expertnm")=request("expertnm")
       rs("expertpw")=request("expertpw")
       rs("email")=request("email")
       rs("folder")=request("folder")
       rs("active")=request("active")
       rs("tel")=request("tel")
       rs("memo")=request("memo")

       if request("clrloginrec")=1 then rs("loginrec")=""
 	   rs.update
       response.write "修改成功！"
     else 
	   response.write "操作失败。"
     end if
     rs.close

'修改普通用户表
    set rs=server.createobject("adodb.recordset")
    sql="select * from user where UserName='"&request("expertnm")&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("userpassword")=request("expertpw")
       rs("useremail")=request("email")
 	   rs.update
       response.write "修改成功！"
     else 
	   response.write "操作失败。"
     end if
     rs.close


     response.redirect "expmng.asp"
  else
    response.write "<script language='javascript'>window.open ('alert6.htm','警告', 'height=100, width=450, top=100, left=100,location=no')"
    response.write chr(13)&"location.reload('editexp.asp?expertnm="&request("expertnm")&"')"
    response.write chr(13)&"</script>"
  end if

%>
 

</body>
</html>