<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<title>诺敏河鸭稻米农民合作社-产品定制登记板</title>
</head>

<%
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

oid=trim(request("oid"))
'response.write oid
conn_init()    '建立数据库连接

    set rs=server.createobject("adodb.recordset")
	sql="select * from orderlist where oid=" & oid
	rs.open sql,conn,1,1
'    'oid=rs("oid")

	dgxs=trim(rs("dgxs"))
	pzdj=trim(rs("pzdj"))
       dim pzdj0,pzdj1,pzdj2
       if pzdj="特级" then pzdj0="checked"
       if pzdj="一级" then pzdj1="checked"
       if pzdj="二级" then pzdj2="checked"

	ddlx=trim(rs("ddlx"))
       dim ddlx0,ddlx1
       if ddlx="现货存米" then ddlx0="checked"
       if ddlx="年度预订" then ddlx1="checked"

	shfs=trim(rs("shfs"))
       dim shfs0,shfs1
       if shfs="特快直达" then shfs0="checked"
       if shfs="同城自取" then shfs1="checked"

	xzdh=trim(rs("xzdh"))
	shr=trim(rs("shr"))
	shdh=trim(rs("shdh"))
	shdz=trim(rs("shdz"))
	yzbm=trim(rs("yzbm"))
	qtsm=trim(rs("qtsm"))

	dqzt=trim(rs("dqzt"))
       dim dqzt1,dqzt2,dqzt3,dqzt4,dqzt5,dqzt6,dqzt7,dqzt8,dqzt9,dqzt10,dqzt11,dqzt12
       if dqzt="1 最新登记" then dqzt1="selected"
       if dqzt="2 初步联络" then dqzt2="selected"
       if dqzt="3 已签合同" then dqzt3="selected"
       if dqzt="4 重调订单" then dqzt4="selected"
       if dqzt="5 订单锁定" then dqzt5="selected"
       if dqzt="6 已交定金" then dqzt6="selected"
       if dqzt="7 已交全款" then dqzt7="selected"
       if dqzt="8 已经发货" then dqzt8="selected"
       if dqzt="9 已经收货" then dqzt9="selected"
       if dqzt="10 暂停执行" then dqzt10="selected"
       if dqzt="11 订单结束" then dqzt11="selected"
       if dqzt="12 订单解除" then dqzt12="selected"

	dgdj=trim(rs("dgdj"))
	zje=trim(rs("zje"))
	yjje=trim(rs("yjje"))
	bz=trim(rs("bz"))
check_modify_del_order()
rs.close

%>

<script language="javascript">
function getCookie(name){var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));if(arr != null) return decodeURI(arr[2]); return null;}
function setCookie(cookiename,cookievalue,cookieexpdate)
{
    document.cookie = cookiename + "=" + encodeURI(cookievalue)
    + "; path=" + "/"
    + "; expires=" + cookieexpdate.toGMTString();
}

function WriteAll()
{
    var d = new Date();
    d.setTime(d.getTime()+1000*60*30);
    setCookie("ggymdlwm", "", d);
    setCookie("ggymadm", "", d);
    setCookie("ggymndxm", "", d);
    setCookie("ggymcysj", "", d);
}

function ReadAll()
{
    alert(getCookie("ggymdlwm"));
    alert(getCookie("ggymadm"));
    alert(getCookie("ggymndxm"));
    alert(getCookie("ggymcysj"));
}

</script>
<body>
<center><a href="http://guaguayami.blog.sohu.com" target="_blank">
<img border="0" src="http://www.kxqbz.com/guaguayami/images/bar3-1.gif"></a>
<font color=#0000ff><br>为了您的信息安全，请您登记结束后点此<a href=# onclick="WriteAll();window.top.close();"><font color=#fff0000>退出登记</font></a>，并关闭窗口<br></font>

<h3>修改订货信息</h3>
<%
if can_modify_del_order<>1 then
response.write "</center>订单信息不可以再修改"
end_this_file()
end if


%>

<table border="0"><tr><td align="left"><font size="2">
　　鸭米及各种农产品均可在此修改<br>
　　订鸭米以外的产品请在其他说明里注明<br>
　　<font color="#ff0000">信息务必准确，我们保证不外泄</font><br>
<form name='or1' method='post' action='http://www.kxqbz.com/guaguayami/mdfyodr2.asp?oid=<% response.write oid %>'>

　　登录网名:<% response.write dlwm %>
　　您的姓名:<% response.write ndxm %><br><br>

　　订购箱数:<input type='text' name='dgxs'  size='25' id='k7'  value='<% response.write dgxs %>'><br>

　　品质等级:<input type='radio' name='pzdj' value='0' <% response.write pzdj0 %>>特级
           　<input type='radio' name='pzdj' value='1' <% response.write pzdj1 %>>一级
           　<input type='radio' name='pzdj' value='2' <% response.write pzdj2 %>>二级<br>

　　订单类型:<input type='radio' name='ddlx' value='0' <% response.write ddlx0 %>>现货存米
         　　<input type='radio' name='ddlx' value='1' <% response.write ddlx1 %>>年度预订<br>

　　收货方式:<input type='radio' name='shfs' value='0' <% response.write shfs0 %>>特快直达
         　　<input type='radio' name='shfs' value='1' <% response.write shfs1 %>>同城自取<br>

　　选择地号:<input type='text'  name='xzdh'  size='18' id='k10' value='<% response.write xzdh %>'><a  href="http://www.kxqbz.com/guaguayami/images/ggg5.jpg" target="_blank">卫星照片</a><br>
　　收货人　:<input type='text'  name='shr'  size='25' id='k10' value='<% response.write shr %>'><br>
　　收货电话:<input type='text' name='shdh'  size='25' id='k11' value='<% response.write shdh %>'><br>
　　收货地址:<input type='text'  name='shdz'  size='25' id='k5' value='<% response.write shdz %>'><br>
　　邮政编码:<input type='text' name='yzbm'  size='25' value='<% response.write yzbm %>'><br>

　　其他说明:<input type='text'  name='qtsm'  size='25' id='k' value='<% response.write qtsm %>'><br>
    <% if is_adm=1 then %>
	　　当前状态:<select   name='dqzt'  id='k9001'>
			        <option  value="1 最新登记" <% response.write dqzt1  %>>1 最新登记</option>   
			        <option  value="2 初步联络" <% response.write dqzt2  %>>2 初步联络</option>   
			        <option  value="3 已签合同" <% response.write dqzt3  %>>3 已签合同</option>   
			        <option  value="4 重调订单" <% response.write dqzt4  %>>4 重调订单</option>   
			        <option  value="5 订单锁定" <% response.write dqzt5  %>>5 订单锁定</option>   
			        <option  value="6 已交定金" <% response.write dqzt6  %>>6 已交定金</option>   
			        <option  value="7 已交全款" <% response.write dqzt7  %>>7 已交全款</option>   
			        <option  value="8 已经发货" <% response.write dqzt8  %>>8 已经发货</option>   
			        <option  value="9 已经收货" <% response.write dqzt9  %>>9 已经收货</option>   
			        <option  value="10 暂停执行" <% response.write dqzt10  %>>10 暂停执行</option>   
			        <option  value="11 订单结束" <% response.write dqzt11  %>>11 订单结束</option>   
			        <option  value="12 订单解除" <% response.write dqzt12  %>>12 订单解除</option>   
                 </select><br>


	　　订购单价:<input type='text'  name='dgdj'  size='25' id='k' value='<% response.write dgdj %>'><br>
	　　总金额　:<input type='text'  name='zje'  size='25' id='k' value='<% response.write zje %>'><br>
	　　已交金额:<input type='text'  name='yjje'  size='25' id='k' value='<% response.write yjje %>'><br>
	　　备　　注:<input type='text'  name='bz'  size='25' id='k' value='<% response.write bz %>'><br>
     <% end if %>

　　详见<font color="#118811">搜狐博客</font>:<a href="http://guaguayami.blog.sohu.com" target="_blank"><font color="#ff0000">诺敏河鸭稻米农民合作社</font></a><br>

　　　<input type='submit' name='djcxhxg' value='修改' >　<input type='reset' name='ct' value=' 重填 ' >

</form>
　　* 此信息仅供联络使用，订单需洽谈<br>
</font></td></tr></table>
</center>
<%
end_this_file()
%>
</body>
</html>














