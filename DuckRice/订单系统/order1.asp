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

conn_init()    '建立数据库连接

response.cookies("ggymdlwm")=""   '立即冲掉cookie原有用户信息
response.cookies("ggymadm")="" 
response.cookies("ggymndxm")=""

'****************** 读取 "登记 查询 修改" 的数据

is_adm=0
dlwm=""
ndxm=""

dlwm=trim(request("dlwm"))
dlmm=trim(request("dlmm"))
ndxm=trim(request("ndxm"))
cysj=trim(request("cysj"))
gddh=trim(request("gddh"))
czhm=trim(request("czhm"))
jstx=trim(request("jstx"))
dzyj=trim(request("dzyj"))
qtfs=trim(request("qtfs"))

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
if dlwm="必填" then dlwm=""
if dlmm="必填" then dlmm=""
if ndxm="首次登记必填" then ndxm=""
if cysj="首次登记必填" then cysj=""
if jstx="例如QQ、MSN等" then jstx=""
if dgxs="每箱20斤，1箱起订" then dgxs=""
if xzdh="请看卫星照片选择地号" then xzdh=""
if shr="可以送人哦，缺省是您自己" then shr=""
if shdh="缺省是您的常用手机" then shdh=""
if shdz="请详细准确填写" then shdz=""
if qtsm="比如订购鸭子、大豆、大蒜等" then qtsm=""



'********************** 处理数据库

can_add_user =0 
can_add_order =0
user_exist =0
pw_ok =0
log_in =0
is_adm =0

find_user()   '检查数据库中的用户，若验证不通过，则结束程序，若通过，赋值相应变量
if user_exist=0 then check_new_user()  '检查新用户必填项是否填写,检查通过则can_add_user =1，表示应向数据库加用户
if can_add_user=1 then adduser()    '向数据库加新用户

check_new_order()   '检查提交的新订单,通过则 can_add_order=1
if can_add_order=1 then addorder()    '向数据库加新订单

response.write "<br>正在处理，请稍等...<br>"

'conn_reconnect()   '为了保证最新加入的记录能够查询出来，必须重新连接一次

end_this_file()   '结束本程序，即本文件封尾
'response.redirect "showall.asp"  '在本文件头部导向

'*****************************程序全部结束

%>


