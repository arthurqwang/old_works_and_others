<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<title>诺敏河鸭稻米农民合作社-产品定制登记板</title>
</head>
<%
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

dim dlwm2   '管理员和普通客户区分开,dlwm2-普通
dlwm2=trim(request("dlwm"))
'response.write oid
conn_init()    '建立数据库连接

    set rs=server.createobject("adodb.recordset")
	sql="select * from userlist where dlwm='" & dlwm2 & "'"
	rs.open sql,conn,1,1

	dlwm=trim(rs("dlwm"))
	dlmm=trim(rs("dlmm"))
	ndxm=trim(rs("ndxm"))
	cysj=trim(rs("cysj"))
	gddh=trim(rs("gddh"))
	czhm=trim(rs("czhm"))
	jstx=trim(rs("jstx"))
	dzyj=trim(rs("dzyj"))
	qtfs=trim(rs("qtfs"))
check_modify_del_user()
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
<h3>修改用户信息</h3>
<%
if can_modify_del_user<>1 then
response.write "</center>该用户信息不可修改"
end_this_file()
end if
%>


<table border="0"><tr><td align="left"><font size="2">
　　<font color="#ff0000">信息务必准确，我们保证不外泄</font><br>
　　<font color="#ff0000">带*的必填</font><br>
<form name='or1' method='post' action='http://www.kxqbz.com/guaguayami/mdfyusr2.asp?dlwm=<% response.write dlwm %>'>

　　登录网名:<% response.write dlwm %><br>

　　登录密码:<input type='text'  name='dlmm'  size='25'  value='<% response.write dlmm %>' >*<br>

　　您的姓名:<input type='text'  name='ndxm'  size='25'  value='<% response.write ndxm %>' >*<br>

　　常用手机:<input type='text'  name='cysj'  size='25'  value='<% response.write cysj %>' >*<br>

　　固定电话:<input type='text' name='gddh'  size='25'   value='<% response.write gddh %>'><br>

　　传真号码:<input type='text' name='czhm'  size='25'   value='<% response.write czhm %>'><br>

　　即时通讯:<input type='text' name='jstx'  size='25'  value='<% response.write jstx %>'><br>

　　电子邮件:<input type='text' name='dzyj'  size='25'   value='<% response.write dzyj %>'><br>

　　其他方式:<input type='text' name='qtfs'  size='25'   value='<% response.write qtfs %>'><br>

　　详见<font color="#118811">搜狐博客</font>:<a href="http://guaguayami.blog.sohu.com" target="_blank"><font color="#ff0000">诺敏河鸭稻米农民合作社</font></a><br>

　　　<input type='submit' name='djcxhxg' value='修改' >　<input type='reset' name='ct' value=' 重填 ' >

</form>
</font></td></tr></table>
</center>
<%
end_this_file()
%>
</body>
</html>














