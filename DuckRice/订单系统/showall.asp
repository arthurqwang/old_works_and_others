<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://guaguayami.blog.sohu.com" target="_blank">
<img border="0" src="http://www.kxqbz.com/guaguayami/images/bar3-1.gif"></a>
<font color=#0000ff><br>为了您的信息安全，请您登记结束后点此<a href=# onclick="WriteAll();window.top.close();"><font color=#fff0000>退出登记</font></a>，并关闭窗口<br></font>
<h3>客户信息/订货信息管理</h3></p></center>

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



<%
on error resume next
conn_init()    '建立数据库连接
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"
if is_adm=1 and request("only_single_user")=1 then response.write "<center><a href='showall.asp'><font size=3 color=#aa0000>[返回总页面]</font></a><br></center>"
showuser()   '显示用户信息
showorder()  '显示订货信息
if is_adm=1 and only_single_user=1 then response.write "<center><a href='showall.asp'><font size=3 color=#aa0000>[返回总页面]</font></a><br></center>"

end_this_file()   '结束本程序，即本文件封尾

'*****************************程序全部结束

%>


