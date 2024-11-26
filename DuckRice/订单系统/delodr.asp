<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<meta http-equiv=refresh content="2;URL=showall.asp">
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://guaguayami.blog.sohu.com" target="_blank">
<img border="0" src="http://www.kxqbz.com/guaguayami/images/bar3-1.gif"></a>

<h3>删除订货信息</h3></p></center>



<%

dim err_t
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

oid=trim(request("oid"))
conn_init()    '建立数据库连接

	set rs=server.createobject("adodb.recordset")
    	sql="DELETE FROM orderlist WHERE oid=" & oid & " and dlwm='" & dlwm & "'"
    	if is_adm=1 then sql="DELETE FROM orderlist WHERE oid=" & oid
	Set rs = conn.Execute (sql,err_t)
    if err_t=1 then
      response.write "删除成功<br>"
    else
      response.write "删除失败<br>"
    end if

response.write "正在处理，请稍等...<br>"

end_this_file()
%>














