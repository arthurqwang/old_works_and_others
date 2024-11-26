<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<title>诺敏河鸭稻米农民合作社-产品定制登记板</title>
</head>

<%
verify_user() '检查用户权限，is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"
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

<h3>登记订货信息</h3>

<table border="0"><tr><td align="left"><font size="2">
　　鸭米及各种农产品均可在此登记<br>
　　订鸭米以外的产品请在其他说明里注明<br>
　　<font color="#ff0000">信息务必准确，我们保证不外泄</font><br>
<form name='or1' method='post' action='http://www.kxqbz.com/guaguayami/order2.asp'>

　　登录网名:<% response.write dlwm %>
　　您的姓名:<% response.write ndxm %><br><br>

　　订购箱数:<input type='text' name='dgxs'  size='25' id='k7' style='color:#999;'  value='每箱20斤，1箱起订' onfocus='if(this.value=="每箱20斤，1箱起订"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="每箱20斤，1箱起订";this.style.color="#999";}'><br>

　　品质等级:<input type='radio' name='pzdj' value='0' >特级　<input type='radio' name='pzdj' value='1' >一级　<input type='radio' name='pzdj' value='2' >二级<br>

　　订单类型:<input type='radio' name='ddlx' value='0' >现货存米　　<input type='radio' name='ddlx' value='1' >年度预订<br>

　　收货方式:<input type='radio' name='shfs' value='0' >特快直达　　<input type='radio' name='shfs' value='1' >同城自取<br>

　　选择地号:<input type='text'  name='xzdh'  size='18' id='k102' style='color:#999;'  value='请看卫星照片选择地号' onfocus='if(this.value=="请看卫星照片选择地号"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="请看卫星照片选择地号";this.style.color="#999";}'><a  href="http://www.kxqbz.com/guaguayami/images/ggg5.jpg" target="_blank">卫星照片</a><br>

　　收货人　:<input type='text'  name='shr'  size='25' id='k10' style='color:#999;'  value='可以送人哦，缺省是您自己' onfocus='if(this.value=="可以送人哦，缺省是您自己"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="可以送人哦，缺省是您自己";this.style.color="#999";}'><br>

　　收货电话:<input type='text' name='shdh'  size='25' id='k11' style='color:#999;'  value='缺省是您的常用手机' onfocus='if(this.value=="缺省是您的常用手机"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="缺省是您的常用手机";this.style.color="#999";}'><br>

　　收货地址:<input type='text'  name='shdz'  size='25' id='k5' style='color:#999;'  value='请详细准确填写' onfocus='if(this.value=="请详细准确填写"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="请详细准确填写";this.style.color="#999";}'><br>

　　邮政编码:<input type='text' name='yzbm'  size='25' ><br>

　　其他说明:<input type='text'  name='qtsm'  size='25' id='k' style='color:#999;'  value='比如订购鸭子、大豆、大蒜等' onfocus='if(this.value=="比如订购鸭子、大豆、大蒜等"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="比如订购鸭子、大豆、大蒜等";this.style.color="#999";}'><br>

　　详见<font color="#118811">搜狐博客</font>:<a href="http://guaguayami.blog.sohu.com" target="_blank"><font color="#ff0000">诺敏河鸭稻米农民合作社</font></a><br>

　　　<input type='submit' name='djcxhxg' value='登记' >　<input type='reset' name='ct' value=' 重填 ' >

</form>
　　* 此信息仅供联络使用，订单需洽谈<br>
</font></td></tr></table>
</center>
</body>
</html>














