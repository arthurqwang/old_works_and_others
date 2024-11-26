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

oid=trim(request("oid"))
'response.write oid
conn_init()    '建立数据库连接


dgxs=trim(request("dgxs"))
pzdj=trim(request("pzdj")) & ""  '转换成字符型，因为他们是 radio输入的
ddlx=trim(request("ddlx")) & ""
shfs=trim(request("shfs")) & ""
xzdh=trim(request("xzdh"))
shr=trim(request("shr"))
shdh=trim(request("shdh"))
shdz=trim(request("shdz"))
yzbm=trim(request("yzbm"))
qtsm=trim(request("qtsm"))

if is_adm=1 then
	dqzt=trim(request("dqzt"))
	dgdj=trim(request("dgdj"))
	zje=trim(request("zje"))
	yjje=trim(request("yjje")) 
	bz=trim(request("bz"))
end if


'********************** 处理数据库
can_add_order =0

check_new_order()   '检查提交的新订单,通过则 can_add_order=1
if can_add_order=1 then updateorder()    '向数据库更新订单

response.write "<br>正在处理，请稍等...<br>"

'conn_reconnect()   '为了保证最新加入的记录能够查询出来，必须重新连接一次

end_this_file()   '结束本程序，即本文件封尾
'response.redirect "showall.asp"  '在本文件头部导向

'*****************************程序全部结束

%>


