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

is_adm=0
dlwm=""
ndxm=""
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

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

'若变量等于缺省的值，则都置空
if dgxs="每箱20斤，1箱起订" then dgxs=""
if xzdh="请看卫星照片选择地号" then xzdh=""
if shr="可以送人哦，缺省是您自己" then shr=""
if shdh="缺省是您的常用手机" then shdh=""
if shdz="请详细准确填写" then shdz=""
if qtsm="比如订购鸭子、大豆、大蒜等" then qtsm=""



'********************** 处理数据库
can_add_order =0

check_new_order()   '检查提交的新订单,通过则 can_add_order=1
if can_add_order=1 then addorder()    '向数据库加新订单

response.write "<br>正在处理，请稍等...<br>"

'conn_reconnect()   '为了保证最新加入的记录能够查询出来，必须重新连接一次

end_this_file()   '结束本程序，即本文件封尾
'response.redirect "showall.asp"  '在本文件头部导向

'*****************************程序全部结束

%>


