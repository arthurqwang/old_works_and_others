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

<h3>客户信息/订货信息管理</h3></p></center>

<%

on error resume next
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

dlwm=trim(request("dlwm"))  '行命令传过来的
'response.write oid
conn_init()    '建立数据库连接


ndxm=trim(request("ndxm"))
cysj=trim(request("cysj"))
gddh=trim(request("gddh"))
czhm=trim(request("czhm"))
jstx=trim(request("jstx"))
dzyj=trim(request("dzyj"))
qtfs=trim(request("qtfs"))

'********************** 处理数据库
can_add_user =0 

check_new_user()  '检查新用户必填项是否填写,检查通过则can_add_user =1，表示应向数据库加用户
if can_add_user=1 then updateuser()    '向数据库加新用户

response.write "<br>正在处理，请稍等...<br>"

'conn_reconnect()   '为了保证最新加入的记录能够查询出来，必须重新连接一次

end_this_file()   '结束本程序，即本文件封尾
'response.redirect "showall.asp"  '在本文件头部导向

'*****************************程序全部结束

%>

